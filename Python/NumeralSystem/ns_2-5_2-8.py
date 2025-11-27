#System 2->5   and   2->8
def arr_change5(arr):
 new_arr = []
 for i_bin in arr:
    dec_num = int(i_bin, 2)
    five_num = ""
    while dec_num > 0:
        five_num = str(dec_num % 5) + five_num
        dec_num //= 5
    new_arr.append(five_num)
 return new_arr

def arr_change8(arr):
 new_arr = []
 for i_bin in arr:
    dec_num = int(i_bin, 2)
    el_num = ""
    while dec_num > 0:
        el_num = str(dec_num % 8) + el_num
        dec_num //= 8
    new_arr.append(el_num)
 return new_arr    
    
bin_arr= ["1001", "0101", "1101", "1011", "1010", "0011"]
print("The original array in the 2nd number system:", bin_arr)    

print("The resulting array in the 5th number system:", arr_change5(bin_arr))
print("The resulting array in the 8th number system:", arr_change8(bin_arr))