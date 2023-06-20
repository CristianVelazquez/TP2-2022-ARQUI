import sys
import serial

def enviar():
     try:
        ser = serial.Serial('COM13', 38400)
        ser.timeout = 10
     except:
        sys.stderr.write('ERROR')
        sys.exit(1)
     i=0
     while 3>i:
          print("Primer se envia en dato A, luego el B y por ultimo la operacion")
          input_data = input('Escribe el dato a enviar: ')
          print (input_data)
          match input_data:
               case "ADD":
                    writed = ser.write(" ".encode('ascii'))
               case "SUB":
                    writed = ser.write("\"".encode('ascii'))
               case "AND":
                    writed = ser.write("$".encode('ascii'))
               case "OR":
                    writed = ser.write("%".encode('ascii'))
               case "XOR":
                    writed = ser.write("&".encode('ascii'))
               case "SRA":
                    writed = ser.write(b'\x03')
               case "SRL":
                    writed = ser.write(b'\x02')
               case "NOR":
                    writed = ser.write("\'".encode('ascii'))
               case "0":
                    writed = ser.write(b'\x00')
               case "1":
                    writed = ser.write(b'\x01')
               case "2":
                    writed = ser.write(b'\x02')
               case "3":
                    writed = ser.write(b'\x03')
               case "4": 
                    writed = ser.write(b'\x04')
               case "5":
                    writed = ser.write(b'\x05')
               case "6":
                    writed = ser.write(b'\x06')
               case "7":
                    writed = ser.write(b'\x07')
               case "8":
                    writed = ser.write(b'\x08')
               case "9":
                    writed = ser.write(b'\x09')
               case _:
                    writed = ser.write(input_data.encode('ascii'))
          print(f'writed = {writed}')
          i=i+1
     ser.close()

def ascii_a_binario(letra):
    # Int
    valor = ord(letra)
    return "{0:08b}".format(valor)


def binario_a_decimal(binario):
    posicion = 0
    decimal = 0
    # Invertir la cadena porque debemos recorrerla de derecha a izquierda
    binario = binario[::-1]
    for digito in binario:
        # Elevar 2 a la posición actual
        multiplicador = 2**posicion
        decimal += int(digito) * multiplicador
        posicion += 1
    return decimal

def to_hexadecimal(value):
    decimal = int(value, 2)
    hexadecimal = hex(decimal)
    return hexadecimal

def recibir():
     ser = serial.Serial('COM13', 38400)
     ser.timeout = 5

     while True:
          received_data = ser.read(1)
          if ((received_data) and (received_data != b'\n')):
               print(f'\rbinary: {ascii_a_binario(received_data)}\t'
               f'Decimal: {binario_a_decimal(ascii_a_binario(received_data))}\t'
               f'Hex:{to_hexadecimal(ascii_a_binario(received_data))}\t',
               end='')
               ser.close()
               break

while True:
     enviar()
     recibir()