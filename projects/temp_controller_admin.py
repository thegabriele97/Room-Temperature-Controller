from tkinter import *
from tkinter import messagebox as mbox
from matplotlib import pyplot as plt
import matplotlib.animation as animation
from matplotlib import style
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg, NavigationToolbar2TkAgg
import serial
import binascii
import datetime
import os
from subprocess import Popen, PIPE
import _thread as thread
from tkintertable import TableCanvas, TableModel

curr_avg_count = 4
curr_sampling_period = 1000;
ser = serial.Serial()
is_connected = False
temp_read_cnt = 0

def gabriuart_checksum(crc: int):
    crc ^= (crc >> 16)
    crc ^= (crc >> 8)

    return crc & 0xff;

def toBinary(string):
    return "".join([format(ord(char),'#010b')[2:] for char in string])

def ch_2_int32(cmd: str):
    return int(toBinary(cmd), 2)

def cmd2_u32(v: str):
    return (ch_2_int32(v[3]) << 24) | (ch_2_int32(v[2]) << 16) | (ch_2_int32(v[1]) << 8)  | (ch_2_int32(v[0]) << 0)

def send_ping():
    cmd = "PING"
    data = 0xaa;
    checksum = chr((gabriuart_checksum(cmd2_u32(cmd)) + gabriuart_checksum(data)) & 0x7f)
    bytes_arr = [ b'\x02', bytes(cmd, 'ascii'), b'\x01', b'\xaa', bytes(checksum, 'ascii'), b'\x03' ]
    
    for i in range(1, 10):
        for byte in bytes_arr:
            ser.write(byte)

        if not wait_ack():
            raise Exception("ACK not received.")
            
        while 1:
            pong = ser.read_until()
            print(pong)
            if b'\x02' in pong:
                if not pong.find(b'PONG'):
                    raise Exception("PING sent. PONG not received. Handshake failed.")
                else:
                    break

def wait_ack():

    while 1:
        ack = ser.read_until()
        if b'\x02' in ack and not (b'CURR' in ack or b'CAVG' in ack or b'PONG' in ack):
            print(ack)
            if not b'\x06' in ack:
                print("Ack not received. Closing...")
                return False
            else:
                return True
        
    return False

def gabriuart_send(cmd: str, length: int, data: list):
    checksum = gabriuart_checksum(cmd2_u32(cmd))
    for s_data in data:
        checksum += gabriuart_checksum(s_data)

    checksum &= 0x7f
    bytes_arr = [ b'\x02', bytes(cmd, 'ascii'), length.to_bytes(1, "little"), *[i.to_bytes(1, "little") for i in data], checksum.to_bytes(1, "little"), b'\x03' ]

    for byte in bytes_arr:
        ser.write(byte)

    if cmd != "LIVE":
        wait_ack()

def reconstruct_int32(data: list, index: int):
    return data[index] << 24 | data[index-1] << 16 | data[index-2] << 8 | data[index-3]

def reconstruct_int16(data: list, index: int):
    return data[index] << 8 | data[index-1]

def get_btn_handler():
    gabriuart_send("CGET", 0, [])

    while 1:
        csen = bytes()

        while 1:
            csen += ser.readline()

            try:
                if (len(csen) == 6 + csen[5] + 2 + 2 or (b'\x06' in csen or b'\x0f' in csen)): #total length is 6 of STX, CMD, LEN + length of frame + checksum + ETX + \r\n
                    break
            except:
                    break

            if len(csen) > 50:    # something bad happened.. trying again from 0
                get_btn_handler()
                return

        print(csen)
        if b'\x02' in csen:
            if b'CSEN' in csen:
                break

    sample_freq_entry.delete(0, END)
    sample_freq_entry.insert(0, reconstruct_int32(csen, 9))

    avg_entry.delete(0, END)
    avg_entry.insert(0, csen[10])

    global curr_avg_count
    curr_avg_count = csen[10]

    global curr_sampling_period;
    curr_sampling_period = reconstruct_int32(csen, 9)

    th0.delete(0, END)
    th0.insert(0, csen[11] * 400 / 128 / 10);
    global line3
    line3.remove()
    line3 = create_line_th0(plt, float(th0.get()))

    m0_th0.delete(0, END)
    m0_th0.insert(0, reconstruct_int16(csen, 13))

    m1_th0.delete(0, END)
    m1_th0.insert(0, reconstruct_int16(csen, 15))

    th1.delete(0, END)
    th1.insert(0, csen[16] * 400 / 128 / 10);
    global line4
    line4.remove()
    line4 = create_line_th1(plt, float(th1.get()))

    m0_th1.delete(0, END)
    m0_th1.insert(0, reconstruct_int16(csen, 18))

    m1_th1.delete(0, END)
    m1_th1.insert(0, reconstruct_int16(csen, 20))

    th2.delete(0, END)
    th2.insert(0, csen[21] * 400 / 128 / 10);
    global line5
    line5.remove()  
    line5 = create_line_th2(plt, float(th2.get()))

    m0_th2.delete(0, END)
    m0_th2.insert(0, reconstruct_int16(csen, 23))

    m1_th2.delete(0, END)
    m1_th2.insert(0, reconstruct_int16(csen, 25))


def set_btn_handler():
    sample_freq = int(sample_freq_entry.get())
    avg_cnt = int(avg_entry.get())
    th0_val = int(float(th0.get()) * 10 * 128 / 400)
    th0_m0 = int(m0_th0.get())
    th0_m1 = int(m1_th0.get())
    th1_val = int(float(th1.get()) * 10 * 128 / 400)
    th1_m0 = int(m0_th1.get())
    th1_m1 = int(m1_th1.get())
    th2_val = int(float(th2.get()) * 10 * 128 / 400)
    th2_m0 = int(m0_th2.get())
    th2_m1 = int(m1_th2.get())

    gabriuart_send("CSET", 20, 
        [sample_freq & 0xff, sample_freq >> 8 & 0xff, sample_freq >> 16 & 0xff, sample_freq >> 24 & 0xff, avg_cnt & 0xff, 
         th0_val & 0xff, th0_m0 & 0xff, th0_m0 >> 8 & 0xff, th0_m1 & 0xff, th0_m1 >> 8 & 0xff, 
         th1_val & 0xff, th1_m0 & 0xff, th1_m0 >> 8 & 0xff, th1_m1 & 0xff, th1_m1 >> 8 & 0xff,
         th2_val & 0xff, th2_m0 & 0xff, th2_m0 >> 8 & 0xff, th2_m1 & 0xff, th2_m1 >> 8 & 0xff])
    
    get_btn_handler()

def create_line_th0(plot, val: float):
    return plot.axhline(y=val, color='y', linestyle='--', label="Threshold 0")

def create_line_th1(plot, val: float):
    return plot.axhline(y=val, color='y', linestyle='-.', label="Threshold 1")

def create_line_th2(plot, val: float):
    return plot.axhline(y=val, color='y', linestyle=':', label="Threshold 2")

def open_serial(port, nbits, br):
    global ser

    ser = serial.Serial(
        port = port,
        baudrate = br,
        parity = serial.PARITY_NONE,
        stopbits = serial.STOPBITS_ONE,
        bytesize = nbits
    )

    ser.isOpen()

def configure_serial():
    global is_connected
    global nbits
    global br_entry
    global serial_port_entry
    
    try:
        open_serial(serial_port_entry.get(), int(nbits.get()[0]), int(br_entry.get()))
        send_ping()
        get_btn_handler()

        is_connected = True
    except Exception as e:
        ser.close()
        mbox.showerror("Error", "An error occurred while opening serial port: " + str(e))

def openHistoryWindow(): 
    gabriuart_send("HGET", 0, [])
    
    data = {"Record 0": {}}        
    row_cnt = 0
    col_cnt = 0

    for i in range(0, 16):
        
        while 1:
            hsen = bytes()

            while 1:
                hsen += ser.readline()

                try:
                    if (len(hsen) == 6 + hsen[5] + 2 + 2) or (b'\x06' in hsen or b'\x0f' in hsen): #total length is 6 of STX, CMD, LEN + length of frame + checksum + ETX + \r\n
                        break
                except:
                    break

                if len(hsen) > 50:    # something bad happened.. trying again from 0
                    openHistoryWindow()
                    return

            print(hsen)
            if b'\x02' in hsen:
                if b'HSEN' in hsen:
                    break

        for i in range(0, hsen[5]):

            value = float("{:.1f}".format(int(hsen[6 + i] & 0x7f) * 400.0 / 128.0 / 10.0))
            is_temp = ((hsen[6 + i] & 0x80) >> 7 == 0)
            if not is_temp:
                data["Record " + str(row_cnt)]["Average"] = value
                row_cnt += 1
                col_cnt = 0
                data["Record " + str(row_cnt)] = {}
                continue

            data["Record " + str(row_cnt)]["Temperature " + str(col_cnt)] = value
            col_cnt += 1

    newWindow = Toplevel(root) 
    newWindow.title("Temperature History") 
    newWindow.geometry("800x600") 
    table = TableCanvas(newWindow, data=data)
    table.show()

root = Tk()
root.geometry('1200x700+200+100')
root.title('Temperature Controller [Operator Mode] - Developed By La Greca Salvatore Gabriele')
#root.state('zoomed')
root.config(background='#ffffff')

logframe = LabelFrame(root, text="Serial monitor", background="#ffffff")
logframe.grid(column=1, row=2)

log = Text(logframe, state=DISABLED, height=7)
log.pack()
log.config(state=DISABLED)

configframe = LabelFrame(root, text="Device configuration", background="#ffffff")
configframe.grid(column=2, row=1)

################################################################
########### SAMPLING FRAME #####################################
################################################################
samplingframe = LabelFrame(configframe, text="Sampling behaviour", background="#ffffff")
samplingframe.grid(column=1, row=1)

L1 = Label(samplingframe, text="Frequency (ms):", background="#ffffff")
L1.grid(column=1, row=1)

sample_freq_entry = Entry(samplingframe, width=10)
sample_freq_entry.grid(column=2, row=1)

L1 = Label(samplingframe, text="Average every:", background="#ffffff")
L1.grid(column=1, row=2)

avg_entry = Entry(samplingframe, width=10)
avg_entry.grid(column=2, row=2)

################################################################
########### TH0 FRAME ##########################################
################################################################
th0frame = LabelFrame(configframe, text="Threshold 0", background="#ffffff")
th0frame.grid(column=1, row=2)

L2 = Label(th0frame, text="Threshold value (°C):", background="#ffffff")
L2.grid(column=1, row=1)

th0 = Entry(th0frame, width=6)
th0.grid(column=2, row=1)

L2 = Label(th0frame, text="Motor Speed M0 (200-1023):", background="#ffffff")
L2.grid(column=1, row=2)

m0_th0 = Entry(th0frame, width=6)
m0_th0.grid(column=2, row=2)

L2 = Label(th0frame, text="Motor Speed M1 (200-1023):", background="#ffffff")
L2.grid(column=1, row=3)

m1_th0 = Entry(th0frame, width=6)
m1_th0.grid(column=2, row=3)


################################################################
########### TH1 FRAME ##########################################
################################################################
th1frame = LabelFrame(configframe, text="Threshold 1", background="#ffffff")
th1frame.grid(column=1, row=3)

L2 = Label(th1frame, text="Threshold value (°C):", background="#ffffff")
L2.grid(column=1, row=1)

th1 = Entry(th1frame, width=6)
th1.grid(column=2, row=1)

L2 = Label(th1frame, text="Motor Speed M0 (200-1023):", background="#ffffff")
L2.grid(column=1, row=2)

m0_th1 = Entry(th1frame, width=6)
m0_th1.grid(column=2, row=2)

L2 = Label(th1frame, text="Motor Speed M1 (200-1023):", background="#ffffff")
L2.grid(column=1, row=3)

m1_th1 = Entry(th1frame, width=6)
m1_th1.grid(column=2, row=3)


################################################################
########### TH2 FRAME ##########################################
################################################################
th2frame = LabelFrame(configframe, text="Threshold 2", background="#ffffff")
th2frame.grid(column=1, row=4)

L2 = Label(th2frame, text="Threshold value (°C):", background="#ffffff")
L2.grid(column=1, row=1)

th2 = Entry(th2frame, width=6)
th2.grid(column=2, row=1)

L2 = Label(th2frame, text="Motor Speed M0 (200-1023):", background="#ffffff")
L2.grid(column=1, row=2)

m0_th2 = Entry(th2frame, width=6)
m0_th2.grid(column=2, row=2)

L2 = Label(th2frame, text="Motor Speed M1 (200-1023):", background="#ffffff")
L2.grid(column=1, row=3)

m1_th2 = Entry(th2frame, width=6)
m1_th2.grid(column=2, row=3)


################################################################
########### DOWNLOAD AND UPLOADS BUTTONS #######################
################################################################
btnframe = LabelFrame(configframe, text="Get & Set", background="#ffffff")
btnframe.grid(column=1, row=5)

get_btn = Button(master = btnframe, height = 1, text = "Download", command=get_btn_handler)
get_btn.grid(row=1, column=1)

set_btn = Button(master = btnframe, height = 1, text = "Upload", command=set_btn_handler)
set_btn.grid(row=1, column=2)

Button(btnframe, height = 1, width=12, text="Retrieve History", command=openHistoryWindow).grid(column=1, row=2, sticky='') 


connectframe = LabelFrame(root, text="Device connection", background="#ffffff")
connectframe.grid(column=2, row=2)

L1 = Label(connectframe, text="Serial Port")
L1.grid(column=1, row=1)

serial_port_entry = Entry(connectframe, width=20)
serial_port_entry.grid(column=2, row=1)

Label(connectframe, text="Baud Rate").grid(column=1, row=2)
br_entry = Entry(connectframe, width=10)
br_entry.grid(column=2, row=2)

Label(connectframe, text="Number of bits").grid(column=1, row=3)
connectframe.grid_columnconfigure(1, weight=1)
nbits = StringVar(connectframe, "8 bits") 
OptionMenu(connectframe, nbits, "5 bits", "6 bits", "7 bits", "8 bits").grid(column=2, row=3)

connect_btn = Button(master = connectframe, height = 1, width = 10, text = "Connect", command=configure_serial)
connect_btn.grid(row=4, column=1)

xar = []
yar = []

xar2 = []
yar2 = []

ann_list = []

style.use('ggplot')
#fig = plt.figure(figsize=(14, 4.5), dpi=100)
fig = plt.figure(figsize=(10, 5.5), dpi=90)
ax1 = fig.add_subplot(1, 1, 1)
ax1.set_ylim(0, 50)
ax1.set_title("Real Time Room Temperature")
ax1.set_xlabel("Number of sample")
ax1.set_ylabel("Temperature (° C)")
line, = ax1.plot(xar, yar, 'b-', linestyle=':', marker='.', label="Real time temperature")
line2, = ax1.plot(xar2, yar2, 'r-', linestyle='-', label="Average temperature")
line3 = create_line_th0(plt, 0)
line4 = create_line_th1(plt, 0)
line5 = create_line_th2(plt, 0)

plt.gcf().autofmt_xdate()
leg = plt.legend()

def animate_th(th_name, i):
    global temp_read_cnt

    print("So.. ", end='')
    temp = ser.read_until()
    print(temp)

    log.config(state=NORMAL)
    log.insert(END, str(datetime.datetime.now()).split('.')[0] + ': ')
    log.insert(END, str(temp))
    log.insert(END, '\n')
    log.see("end")
    log.config(state=DISABLED)

    """     checksum = gabriuart_checksum(reconstruct_int32(temp, 4))
    for s_data in temp[5:(len(temp)-5)]:
        checksum += gabriuart_checksum(s_data)

    checksum &= 0x7f 
    """

    if b"CURR" in temp:
        temp_read_cnt += 1
        temp = temp[6]

        yar.append(temp * 400.0 / 128.0 / 10.0)
        xar.append(i)
        line.set_data(xar, yar)
        ax1.set_xlim(i-500, i+1)

    elif b"CAVG" in temp:
        temp_read_cnt += 1
        temp = temp[9] << 24 | temp[8] << 16 | temp[7] << 8 | temp[6];

        yar2.append((float(temp) / curr_avg_count) * 400.0 / 128.0 / 10.0);
        xar2.append(i)
        line2.set_data(xar2, yar2)

    for i, a in enumerate(ann_list):
        a.remove()
        ann_list[:] = []

    ann = plt.annotate('%0.1f °C' % yar[-1], xy=(1, yar[-1]), xytext=(8, 0), xycoords=('axes fraction', 'data'), textcoords='offset points')
    ann_list.append(ann)

def animate(i):
    global is_connected
    global temp_read_cnt

    if not ser.is_open or not is_connected:
        return

    #t1 = thread.start_new_thread(animate_th, ("thread_animate", i))
    #t1.wait()

    if (temp_read_cnt > 1):
        gabriuart_send("LIVE", 0, [])
        temp_read_cnt = 0

    try:
        animate_th("", i)
    except:
        pass

plotcanvas = FigureCanvasTkAgg(fig, root)
plotcanvas.get_tk_widget().grid(column=1, row=1, sticky=NSEW)
ani = animation.FuncAnimation(fig, animate, interval=(curr_sampling_period / 8), blit=False)

root.mainloop()
