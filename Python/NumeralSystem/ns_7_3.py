# Array System 7->3
def arr_change3(arr):
 new_arr = []
 for i_bin in arr:
    dec_num = int(i_bin, 7)
    print("  7-ная  -  10-ная   : ", i_bin,"  ->  ", dec_num) 
    three_num = ""
    while dec_num > 0:
        three_num = str(dec_num % 3) + three_num
        dec_num //= 3
    new_arr.append(three_num)
    print("# Итог  3-я : ", three_num)
 return new_arr    
    
bin_arr= ["1064", "342", "6103", "4421", "3625", "251"]
# Output 112102  20120  2220011  2011122 1211201 11222

print("The original array in the 7th number system:", bin_arr)    
print("The resulting array in the 3rd number system:", arr_change3(bin_arr))