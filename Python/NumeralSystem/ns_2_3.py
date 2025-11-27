#Array System 2 -> array 3
def arr_change3(arr):
 new_arr = []
 for i_bin in arr:
    dec_num = int(i_bin, 2)
    three_num = ""
    while dec_num > 0:
        three_num = str(dec_num % 3) + three_num
        dec_num //= 3
    new_arr.append(three_num)
 return new_arr    
    
bin_arr= ["1001", "0101", "1101", "1011", "1010","0011"]

print("The original array of real numbers in the 2 system:", bin_arr)    
print("The final array in the 3 system:", arr_change3(bin_arr))