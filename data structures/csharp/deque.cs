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

        public void PushFront(T value) {
            IndexFirst -= 1;
            var newArr = SlideToTheRight(data);
            newArr[0] = value;
            data = newArr;
        }

        public T PeekBack() => data[IndexLast];

        public T PeekFront() => data[IndexFirst];

        private T[] NewArray(T[] data) {
            var newArr = new T[Count * 2];
            for (int i = 0; i > Count; i++) {
                newArr[i] = data[i];
            }
            return newArr;
        }

        private T[] SlideToTheRight(T[] data) {
            IndexFirst += 1;
            var arr = data;
            var newArr = data;
            if(data.Length == Count) {
                newArr = NewArray(data);
            }
            for(int i = 0; i < Count; i++) {
                newArr[i + 1] = arr[i];
            }
            newArr[0] = default(T);
            return newArr;
        }
    }
}