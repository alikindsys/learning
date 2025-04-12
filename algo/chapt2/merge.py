# Merge Sort
# Date: 11/04/2025
# Page: 30

import math

def msort(arr):
    # Array, Starting Point, End Point
    _msort(arr, 0, len(arr) - 1)
    return arr

def _msort(arr, spoint, epoint):
#    print(f"_msort({arr}, {spoint}, {epoint})")
    if spoint < epoint:
        # Split the array into two halves
        midpoint = math.floor((spoint + epoint) / 2)
        _msort(arr, spoint, midpoint)
        _msort(arr, midpoint + 1, epoint)

        # Array, Starting Point, Mid Point, Ending Point
        _merge(arr, spoint, midpoint, epoint)

def _merge(arr, startL, mid, endR):
 #   print(f"_merge({arr}, {startL}, {mid}, {endR})")

    L = arr[startL: mid + 1]
    R = arr[mid + 1: endR + 1]

    L.append(math.inf)
    R.append(math.inf)

  #  print(f"L = {L}, R = {R}")

    i = 0
    j = 0

    for idx in range(startL, endR + 1):
        if L[i] < R[j]:
            arr[idx] = L[i]
            i += 1
        else:
            arr[idx] = R[j]
            j += 1

if __name__ == "__main__":
    unsorted = [3,2,1]
    print(f"Unsorted: {unsorted}")
    msort(unsorted)
    print(f"Sorted: {unsorted}")

