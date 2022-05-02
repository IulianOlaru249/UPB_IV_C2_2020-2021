#!/usr/bin/env python3

import base64
import json
import gmpy2


def str_to_number(text):
    """ Encodes a text to a long number representation (big endian). """
    return int.from_bytes(text.encode("ASCII"), 'big')

def number_to_str(num):
    """ Decodes a text to a long number representation (big endian). """
    num = int(num)
    return num.to_bytes((num.bit_length() + 7) // 8, byteorder='big').decode('ASCII')

def encrypt(pub_k, msg_num):
    """ We only managed to steal this function... """
    cipher_num = gmpy2.powmod(msg_num, pub_k["e"], pub_k["n"])
    # note: gmpy's to_binary uses a custom format (little endian + special GMPY header)!
    cipher_b64 = base64.b64encode(gmpy2.to_binary(cipher_num))
    return cipher_b64

def decrypt(priv_k, cipher):
    """ We don't have the privary key, anyway :( """
    # you'll never get it!
    pass


if __name__ == "__main__":
    # example public key
    pub_k = {"e": 17, "n": 1221540932698357538969048008476734604937734436157953593060163}
    # generate a message
    message = "Test Message 1234"
    # note: encrypt requires a number
    msg_num = str_to_number(message)
    # test the reverse
    print("Message:", number_to_str(msg_num))
    # encrypt the message
    cipher = encrypt(pub_k, msg_num)
    print("Ciphertext:", cipher)
    # encode the message to the server's format
    # todo...

    my_pub_k = {"e": 110791, "n": 11542281117101797020909134485668778291404618784845318023489187247011413639020490884288576594468523877622715246587792774352399089307280931978344754738401490925189369533088262004025143571852223696949317580914401534575230792324650796457887550787924792994419887241834090142385805639127276773914396868935608127887901711741508825190392224231992945587302837939331085843066557015854890582668295699219558344470071386863427539567565230422489461366728348496623263132181818134700071860817013679717937390532084468849584720653332126936491941492201395234351440239941699717597579805460723341700836445854238928787022852167217377600681 }

    my_msg = "galceava"
    my_msg_num = str_to_number(my_msg)
    random_cipher_num = gmpy2.powmod(my_msg_num, my_pub_k["e"], my_pub_k["n"])
    print()
    print(random_cipher_num)

    flag_cipher_num = 7639341040184015006788075558191847515585835121699449389481619713206038879344124723896736019243039115060306033261997457243464766097402747802548906011410283715155621471496473527381032259676457486658010673194159851776457678305525422607956862211128455149552480158514297570514756059728739601730448775999257716704168890414887768871394830739925986433138430913855880031964902836238733538622052483804122603279549517395707029171449314240187463309710045055970761855688836517290801269722222351565340089127794790471104343066481345998890091171609132770928416831896606986388370376959523431347825672013051176581645411482925684021171

    multiplied_flag_num = flag_cipher_num * random_cipher_num
    print()
    print(multiplied_flag_num)

    encoded_flag_num = base64.b64encode(gmpy2.to_binary(multiplied_flag_num))
    encoded_flag_num = encoded_flag_num.decode("utf-8")
    print()
    print(encoded_flag_num)

    bytess = b'!\xb1\xf9\xb7\xaa\xae\x7f~]\x1cfJ\xa5\x14>\x96\x97\x02}\xd5\x9e,\xb3\xe2\x99\xa7\xe6\x8bt\x0ew\x0b\xee\x88\xa2\x00\x87SRSH\xaasP"\xb3 K\x03gs]'
    my_num = int.from_bytes(bytess, 'big')

    my_msg_decript_num = my_num // my_msg_num
    print()
    print(number_to_str(int(my_msg_decript_num)))
