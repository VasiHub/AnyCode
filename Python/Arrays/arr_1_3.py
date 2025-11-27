# Array of real numbers
# 1 Product of positive array elements.
# 2 The sum of the array elements located before the minimum
# 3 Arrange the elements into even and odd positions.

def pro_pos_elem(in_arr): # Product of positive array elements.
    pro=1 
    for i in in_arr: 
      if i>0:  
         pro=pro*i       
    return pro 

def sum_min(in_arr): # The sum of the array elements located before the minimum
 min_el = in_arr[0] 
 min_idx = -1 
 sum_el=0 
 for i in range(n): 
    if in_arr[i] < min_el:
         min_idx = i 
 for i in range(min_idx): 
    sum_el += in_arr[i] 
 return sum_el 

def arr_sorted(in_arr): # Transformed array even/odd
 even_el = [in_arr[i] for i in range(len(in_arr)) if i % 2 == 0]
 odd_el = [in_arr[i] for i in range(len(in_arr)) if i % 2 != 0]
 new_odd=my_sorted(even_el) 
 new_even=my_sorted(odd_el)
 return new_even+new_odd  

def my_sorted(el_arr): 
 n = len(el_arr)
 for i in range(n): 
    for j in range(0, n - i - 1): 
       if el_arr[j] > el_arr[j + 1]: 
        el_arr[j], el_arr[j + 1] = el_arr[j + 1], el_arr[j] 
 return el_arr 

n=int(input("Entering the number of array elements, N= "))
my_array = []
for i in range(n): 
    num = int(input(f"Enter an integer array element, index {i} : "))
    my_array.append(num)
#"""    

print("Source array:", my_array)
print("Product of positive array elements : ", pro_pos_elem(my_array))
print("The sum of the array elements located before the minimum : ", sum_min(my_array))
print("Transformed array of elements: ", arr_sorted(my_array))