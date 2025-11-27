# Array 5 -> 2
def arr_change2(arr):
 new_arr = []
 for i_bin in arr:
    dec_num = int(i_bin, 5)
    print("  5  ->  10   : ", i_bin,"  ->  ", dec_num) 
    three_num = ""
    while dec_num > 0:
        three_num = str(dec_num % 2) + three_num
        dec_num //= 2
    new_arr.append(three_num)
    print("# Final 2 : ", three_num)
 return new_arr    
    
bin_arr= ["214", "342", "4103", "421", "123","31"]
# Результат  111011  1100001  1000010000  1101111 100110  10000

print("The original array of real numbers in the 5 system:", bin_arr)    
print("The final array in the 2 system:", arr_change2(bin_arr))