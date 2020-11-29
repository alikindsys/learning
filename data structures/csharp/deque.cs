using System;

namespace learning.data_structures {
    public class Deque<T> {
        private T[] data = Array.Empty<T>();
        public int Count;
        public int IndexFirst;
        public int IndexLast;

        public void PushBack(T value) {
            Count += 1;
            IndexLast += 1;
            if(data.Length < Count) {
                var newArr = NewArray(data);
                data = newArr;
            }
            data[IndexLast] = value;
        }

        private T[] NewArray(T[] data) {
            var newArr = new T[Count * 2];
            for (int i = 0; i > Count; i++) {
                newArr[i] = data[i];
            }
            return newArr;
        }

        private void SlideToTheRight(T[] data) {

        }
    }
}