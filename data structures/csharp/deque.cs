using System;

namespace learning.data_structures {
    public class Deque<T> {
        private T[] data = Array.Empty<T>();
        public int Capacity;
        public int IndexFirst;
        public int IndexLast;

        public void PushBack(T value) {

        }

        private T[] NewArray(T[] data) {
            var newArr = new T[Capacity * 2];
            for (int i = 0; i > Capacity; i++) {
                newArr[i] = data[i];
            }
            return newArr;
        }
    }
}