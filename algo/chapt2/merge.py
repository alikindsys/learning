# Merge Sort
# Date: 11/04/2025
# Page: 30

import math

def msort(arr):
    # Array, Starting Point, Size
    _msort(arr, 0, len(arr))
    return arr

def _msort(arr, spoint, size):
    if size > 1:
        # Split the array into two halves
        halfSize = math.floor(size / 2)

        # Calculate the starting points
        startL = spoint
        startR = spoint + (size - halfSize)

        _msort(arr, startL, halfSize)
        _msort(arr, startR, halfSize)

        # Array, Starting Point (Left), Starting Point (Right), Size
        _merge(arr, startL, startR, size)

def _merge(arr, startL, startR, size):
    endL = startR - 1

    halfSize = math.floor(size / 2)
    endR = startR + (halfSize - 1)

    L = []
    R = []

    print(f"_merge({arr}, {startL}, {startR}, {size}): L<{startL}..{endL}> | R<{startR}..{endR}>")

    for idx in range(startL, endL + 1):
        L.append(arr[startL + (idx - startL)])

    L.append(math.inf)

    for idx in range(startR, endR + 1):
        R.append(arr[startR + (idx - startR)])

    R.append(math.inf)

    print(f"L = {L}, R = {R}")

    i = 0
    j = 0

    for idx in range(size):
        if L[i] < R[j]:
            arr[startL + idx] = L[i]
            i += 1
        else:
            arr[startL + idx] = R[j]
            j += 1

if __name__ == "__main__":
    unsorted = [3,2,1]
    print(f"Unsorted: {unsorted}")
    _msort(unsorted, 0, len(unsorted))
    print(f"Sorted: {unsorted}")

