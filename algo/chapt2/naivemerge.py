# Naive Merge Sort
# Date: 11/04/2025
# Page: None

import math

def msort(list) -> list:
    """uses msort on two halves of the list and then merges them with `merge`"""
    size = len(list)
    if size == 1:
        return list
    else:
        halfPoint = math.floor(size / 2)

        left = list[0:halfPoint]
        right = list[halfPoint:size]

        left = msort(left)
        right = msort(right)

        return merge(left, right)


def merge(list1, list2) -> list:
    """takes two already-sorted lists, and interleaves them into one list"""

    temp = []
    sizeA = len(list1)
    sizeB = len(list2)

    # Add sentinels
    list1.append(math.inf)
    list2.append(math.inf)

    i = 0
    j = 0

    for idx in range(sizeA + sizeB):
      if list1[i] < list2[j]:
          temp.append(list1[i])
          i += 1

      else:
          temp.append(list2[j])
          j += 1


    return temp


if __name__ == "__main__":
    unsorted = [4,3,2,1]
    print(f"Unsorted: {unsorted}")
    sorted = msort(unsorted)
    print(f"Sorted: {sorted}")
