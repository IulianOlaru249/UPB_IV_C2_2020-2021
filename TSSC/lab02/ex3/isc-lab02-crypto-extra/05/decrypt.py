import onetimepad
import base64
from time import sleep

#cipher = onetimepad.encrypt('wAyk{mmAwjAuwpz\\x7fAwmAqjn', 'random')
#print("Cipher text is ")
#print(cipher)
#print("Plain text is ")

text = 'wAyk{mmAwjAuwpz\\x7fAwmAqjn'

def decode_cipher(a,b):
    return ''.join([hex(ord(a[i%len(a)]) ^ ord(b[i%(len(b))]))[2:] for i in range(max(len(a), len(b)))])

#read bytes from file in bytearray
#xor byte by byte

leng = len(text)
#while True:
for byte in range(20, 30):
	passwd = ''
	for i in range(leng):
		passwd += str(byte)

	msg = decode_cipher(text, passwd)
	print(msg)
#	sleep(2)

