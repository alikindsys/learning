#include <bcl.hpp>

class IntArray {
    public:
        IntArray(){
            this->size = 4;
            this->count = 0;
            this->data = new int[4];
        }
        IntArray(IntArray& other){
            this->size = other.size;
            this->count = other.count;
            this->data = new int[this->size];

            for(int i = 0; i < other.count; i++)
                this->data[i] = other.data[i];
        }
        IntArray(IntArray&& other){
            this->size = other.size;
            this->count = other.count;
            this->data = other.data;
            
            other.size = 0;
            other.count = 0;
            other.data = nullptr;
        }
        ~IntArray(){
            delete this->data;
            this->size = 0;
            this->count = 0;
        }
        IntArray& operator=(IntArray& other){
            delete this->data;

            this->size = other.size;
            this->count = other.count;
            this->data = new int[this->size];

            for(int i = 0; i < other.count; i++)
                this->data[i] = other.data[i];
        }
        IntArray& operator=(IntArray&& other){
            delete this->data;
            this->size = other.size;
            this->count = other.count;
            this->data = other.data;

            other.data = nullptr;
            other.size = 0;
            other.count = 0;
        }
       
       /* 
        * Not on RAII
        * Additions for having a complete-ish data-type
        */

        IntArray(int capacity){
            this->size = capacity;
            this->count = 0;
            this->data = new int[capacity];
        }

        void Push(int value){
            if(this->count == this->size)
                this->Resize();
            this->data[this->count] = value;
            this->count += 1;
        }

        void Pop(){
            this->count -= 1;
            if(this->count == (this->size/2))
                this->Resize(true);
            this->data[this->count] == 0;
        }

    private:
        int size;
        int count;
        int* data;

        /* 
        * Not on RAII
        * Additions for having a complete-ish data-type
        */
        void Resize(bool diminish = false){
            IntArray newArr;
            if(!diminish){
                newArr = IntArray(this->size*2);
            } else {
                newArr = IntArray(this->size/2);
            }
            for(int i; i < this->count; i++){
                newArr.data[i] = this->data[i];
                newArr.count += 1;
            }
            delete this->data;
            this->count = newArr.count;
            this->size = newArr.size;
            this->data = newArr.data;
            
            newArr.data = nullptr;
            newArr.count = 0;
            newArr.size = 0;
        }
};
