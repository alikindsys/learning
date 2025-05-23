# Merge Sort
# Date: 11/04/2025
# Page: 30

import math

def msort(arr):
    # Array, Starting Point, End Point
    _msort(arr, 0, len(arr) - 1)
    return arr

def _msort(arr, spoint, epoint):
    #print(f"_msort({arr}, {spoint}, {epoint})")
    if spoint < epoint:
        # Split the array into two halves
        midpoint = math.floor((spoint + epoint) / 2)
        _msort(arr, spoint, midpoint)
        _msort(arr, midpoint + 1, epoint)

        # Array, Starting Point, Mid Point, Ending Point
        _merge(arr, spoint, midpoint, epoint)

def _merge(arr, startL, mid, endR):
    #print(f"_merge({arr}, {startL}, {mid}, {endR})")

    L = arr[startL: mid + 1]
    R = arr[mid + 1: endR + 1]

    lenL = len(L)
    lenR = len(R)

    # L.append(math.inf)
    # R.append(math.inf)

    print(f"L = {L}, R = {R}")

    i = 0
    j = 0

    flagI = False
    flagJ = False

    for idx in range(startL, endR + 1):
        if flagI and flagJ:
            break

        if not flagI and (L[i] < R[j] or flagJ):
            arr[idx] = L[i]
            if i + 1 < lenL:
                i += 1
            else:
                flagI = True
        else:
            arr[idx] = R[j]
            if j + 1 < lenR:
                j += 1
            else:
                flagJ = True

if __name__ == "__main__":
    unsorted = [3,2,1]
    print(f"Unsorted: {unsorted}")
    msort(unsorted)
    print(f"Sorted: {unsorted}")

