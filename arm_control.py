#-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.
 #File Name : arm_control.py
 #Creation Date : 08-12-2018
 #Created By : Rui An  
#_._._._._._._._._._._._._._._._._._._._._.
import requests
import time
import serial
current_rotation = "rest"
ser = serial.Serial('/dev/cu.usbmodem14201', 9600)

def check_rotation():
    response = requests.get('https://mine-yours-heroku.herokuapp.com/api/rotate')
    return response.content.decode("utf-8")
     

def update_arm(position_to_rotate):
    global ser
    bytes_rotation = position_to_rotate.encode('utf-8')
    ser.write(bytes_rotation)
    print("update the arm to", position_to_rotate, "position")


# Check the server every 3 seconds to see if there is rotation change update
def rotate_update():
    global current_rotation
    while True:
        time.sleep(1)
        server_rotation = check_rotation()
        if (current_rotation != server_rotation):
            current_rotation = server_rotation
            update_arm(current_rotation)


rotate_update()

