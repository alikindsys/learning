# Insertion Sort
# Date: 10/04/2025
# Page: 18

def isort(arr):
    # loop through each index in the array
    for idx in range(len(arr)):
        # Get the current value at the index
        v = arr[idx]
        lowest_idx = -1

        # Go through every index again
        for iidx in reversed(range(idx)):
            # Get the comparison
            c = arr[iidx]

            # If the value is smaller then the comparison have to shift
            if (v < c):
 #               print(f"For v={v} @ idx={idx} | Lowest Set: {iidx}")
                lowest_idx = iidx
            else:
                break

#        print(f"Lowest Idx: {lowest_idx} for idx={idx}")
        if lowest_idx < idx and lowest_idx != -1:
#            print(f"Pre-Shift: {arr}")
            # Shifting
            for shift in reversed(range(lowest_idx, idx)):
                arr[shift + 1] = arr[shift]

            arr[lowest_idx] = v

#            print(f"Shift @ {lowest_idx} for {idx}: {arr}")


    return arr


if __name__ == "__main__":
    unsorted = [5,2,4,6,1,3]
    print(f"Unsorted: {unsorted}")
    sorted = isort(unsorted)
    print(f"Sorted: {sorted}")

