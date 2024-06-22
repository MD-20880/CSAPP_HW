#include <stdio.h> 
#include <limits.h>
#include <stdlib.h>
#include <string.h>

typedef unsigned char *byte_pointer; 

void show_bytes(byte_pointer start, size_t len) { 
    size_t i; 
    for (i = 0; i < len; i++) 
    printf (" %.2x", start [i]); 
    printf("\n"); 
} 
 
void show_int(int x) { 
    show_bytes((byte_pointer) &x, sizeof(int)); 
} 
 
void show_float (float x) { 
    show_bytes ((byte_pointer) &x, sizeof (float)); 
} 
 
void show_pointer(void *x) { 
    show_bytes((byte_pointer) &x, sizeof(void *)); 
} 

/*2.63*/
//logical right shift
unsigned srl(unsigned x, int k){
    unsigned xsra = (int) x >> k;   
    int w = 8*sizeof(int);
    unsigned mask = (0x01 << (w-k))-1;
    return (xsra & mask) | 0x0;
}

//arithmetic right shift
unsigned sra(int x, int k){
    int xsrl = (unsigned) x >> k;
    int w = 8*sizeof(int);
    unsigned valuemask = (0x01 << (w-k))-1;
    unsigned signmask = 0x01 << (w-k-1);
    return (0 - (xsrl & signmask)) | (valuemask & xsrl);
}

void q263(){
    unsigned x = 0xF2345678;
    int k = 7;
    printf("srl(0x%X, %d) = 0x%X\n", x, k, srl(x, k));
    printf("sra(0x%X, %d) = 0x%X\n", x, k, sra(x, k));
}

/*2.64*/
int any_odd_one(unsigned x){
    return !!(x & 0xAAAAAAAA);
}

/*2.65*/
/* Return 1 when x contains an odd number of ls; 0 otherwise. Assume w=32*/
int odd_ones(unsigned x){
    x ^= x >> 16;
    x ^= x >> 8;
    x ^= x >> 4;
    x ^= x >> 2;
    x ^= x >> 1;
    return x & 0x01;
}

void q265(){
    printf("odd_ones(0x%X) = %d\n", 0x10101010, odd_ones(0x10101010));
    printf("odd_ones(0x%X) = %d\n", 0x10101011, odd_ones(0x10101011));
}

/*2.66*/
/* 
* Generate mask indicating leftmost 1 in x. Assume w=32. 
* For example, OxFF00 -> Ox8000, and Ox6600 --> Ox4000. 
* If x = 0, then return 0. 
*/ 

int leftmost_one(unsigned x){
    x |= x >> 1;
    x |= x >> 2;
    x |= x >> 4;
    x |= x >> 8;
    x |= x >> 16;
    return x & ((~x) >> 1);
}

void q266(){
    printf("leftmost_one(0x%X) = 0x%X\n", 0xFF00, leftmost_one(0xFF00));
    printf("leftmost_one(0x%X) = 0x%X\n", 0x6600, leftmost_one(0x6600));
}

/*2.67*/
int bad_int_size_is_32() {
   int set_msb_16 = 1 << 15;
   int beyond_msb_16 = set_msb_16 << 1;
   int set_msb  = beyond_msb_16 << 15;
   int beyond_msb = set_msb << 1;

   return set_msb && !beyond_msb; 
}

/*2.68*/
int lower_one_mask(int n){
    int w = 8*sizeof(int);
    unsigned mask = (int) -1;
    return (int)(mask >> (w-n));
}

void q268(){
    printf("lower_one_mask(6) = 0x%X\n", lower_one_mask(6));
    printf("lower_one_mask(17) = 0x%X\n", lower_one_mask(17));
    printf("lower_one_mask(32) = 0x%X\n", lower_one_mask(32));  
}

/*2.69*/
unsigned rotate_left(unsigned x, int n){
    unsigned x2 = x;
    int w = 8*sizeof(int);
    unsigned highpart = x >> (w-n);
    unsigned lowpart = x << n; 
    return lowpart | highpart;
}

void q269(){
    printf("rotate_left(0x%X, %d) = 0x%X\n", 0x12345678, 4, rotate_left(0x12345678, 4));
    printf("rotate_left(0x%X, %d) = 0x%X\n", 0x12345678, 8, rotate_left(0x12345678, 8));
    printf("rotate_left(0x%X, %d) = 0x%X\n", 0x12345678, 0, rotate_left(0x12345678, 0));
}

/*2.70*/
int fits_bits(int x, int n){
    unsigned mask = ((int) -1) >> (8*sizeof(int)-n);
    int num = mask & x;
    num = (num << (8*sizeof(int) - n)) >> (8*sizeof(int)-n);
    return num == x;
}

int q270(){
    printf("fits_bits(0x%X, %d) = %d\n", 0x1234, 8, fits_bits(0x1234, 8));
    printf("fits_bits(0x%X, %d) = %d\n", 0x1234, 12, fits_bits(0x1234, 12));
    printf("fits_bits(0x%X, %d) = %d\n", 0x1234, 16, fits_bits(0x1234, 16));
    printf("fits_bits(0x%X, %d) = %d\n", 0x1234, 32, fits_bits(0x1234, 32));
}

/*2.71*/
typedef unsigned packed_t;
int xbyte(packed_t word, int bytenum){
    int result = (word >> (bytenum << 3) &0xFF);
    return ((result << (32-8)) >> (32-8));
}

void q271(){
    printf("xbyte(0x%X, %d) = 0x%X\n", 0x12345678, 0, xbyte(0x12345678, 0));
    printf("xbyte(0x%X, %d) = 0x%X\n", 0x12345678, 1, xbyte(0x12345678, 1));
    printf("xbyte(0x%X, %d) = 0x%X\n", 0x12345678, 2, xbyte(0x12345678, 2));
    printf("xbyte(0x%X, %d) = 0x%X\n", 0x12345678, 3, xbyte(0x12345678, 3));
    printf("xbyte(0x%X, %d) = 0x%X\n", 0x12F01212, 2, xbyte(0x12F01212, 2));
}

/*2.73*/
int saturating_add(int x, int y){
    int x_sign_mask = x>>((sizeof(int)<<3)-1);
    int y_sign_mask = y>>((sizeof(int)<<3)-1);

    int sum = x + y;
    int sum_sign_flag = sum >>((sizeof(int)<<3)-1);

    int positive_flag = ~x_sign_mask & ~y_sign_mask & sum_sign_flag;
    int negative_flag = x_sign_mask & y_sign_mask & ~sum_sign_flag;

    return (INT_MAX  & positive_flag) | (INT_MIN & negative_flag) | (sum & (~(positive_flag|negative_flag)));
}

void q273(){
    printf("saturating_add(0x%X, 0x%X) = 0x%X\n", 0x7FFFFFFF, 0x7FFFFFFF, saturating_add(0x7FFFFFFF, 0x7FFFFFFF));
    printf("saturating_add(0x%X, 0x%X) = 0x%X\n", 0x7FFFFFFF, 0x80000000, saturating_add(0x7FFFFFFF, 0x80000000));
    printf("saturating_add(0x%X, 0x%X) = 0x%X\n", 0x80000000, 0x80000000, saturating_add(0x80000000, 0x80000000));
}

/*2.74*/
int tsub_ok(int x, int y){
    int x_sign_mask = x>>((sizeof(int)<<3)-1);
    int y_sign_mask = y>>((sizeof(int)<<3)-1);

    int diff = x - y;
    int diff_sign_flag = diff >>((sizeof(int)<<3)-1);

    int positive_flag = ~x_sign_mask & y_sign_mask & diff_sign_flag;
    int negative_flag = x_sign_mask & ~y_sign_mask & ~diff_sign_flag;

    return (INT_MAX  & positive_flag) | (INT_MIN & negative_flag) | (diff & (~(positive_flag|negative_flag)));
}

void q274(){
    printf("tsub_ok(0x%X, 0x%X) = 0x%X\n", 0x7FFFFFFF, 0x7FFFFFFF, tsub_ok(0x7FFFFFFF, 0x7FFFFFFF));
    printf("tsub_ok(0x%X, 0x%X) = 0x%X\n", 0x7FFFFFFF, 0x80000000, tsub_ok(0x7FFFFFFF, 0x80000000));
    printf("tsub_ok(0x%X, 0x%X) = 0x%X\n", 0x80000000, 0x80000000, tsub_ok(0x80000000, 0x80000000));
    printf("tsub_ok(0x%X, 0x%X) = 0x%X\n", 0x80000000, 0x7FFFFFFF, tsub_ok(0x80000000, 0x7FFFFFFF));
}

/*2.75*/
//PASS

/*2.76*/
void *calloc(size_t nmemb, size_t size){
    if (nmemb == 0 || size == 0){
        return NULL;
    }
    
    size_t total_size = nmemb * size;

    if (total_size / nmemb != size){
        return NULL;
    } // check whether overflow

    void *p = malloc(total_size);
    memset(p, 0, total_size);
    return p;
}


/*2.78*/
int divide_power2(int x, int k){
    int w = 8*sizeof(int);
    int isneg = x >> (w-1);
    (isneg && (x = x + (1 << k) - 1));
    return x >> k;
}

void q278(){
    printf("divide_power2(0x%X, %d) = 0x%X\n", 0x80000000, 1, divide_power2(0x80000000, 1));
    printf("divide_power2(0x%X, %d) = 0x%X\n", 0x80000000, 2, divide_power2(0x80000000, 2));
    printf("divide_power2(0x%X, %d) = 0x%X\n", 0x80000000, 3, divide_power2(0x80000000, 3));
}

int main(void){
    // q263();
    // q265(); 
    // q266();
    // q268();
    // q269();
    // q270();
    // q271();
    // q273();
    // q274();
    q278();
    return 0;
}