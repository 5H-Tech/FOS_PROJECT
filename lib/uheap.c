#include <inc/lib.h>

// malloc()
//	This function use FIRST FIT strategy to allocate space in heap
//  with the given size and return void pointer to the start of the allocated space

//	To do this, we need to switch to the kernel, allocate the required space
//	in Page File then switch back to the user again.
//
//	We can use sys_allocateMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls allocateMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the allocateMem function is empty, make sure to implement it.

//==================================================================================//
//=======================
//===== REQUIRED FUNCTIONS ==================================//
//==================================================================================//

uint32 last_addres = USER_HEAP_START;
int changes = 0;
int sizeofarray = 0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {

	if(size>USER_HEAP_MAX - USER_HEAP_START)
		return NULL;
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
		num++;
	if (changes == 0) {
		sys_allocateMem(last_addres, size);
		return_addres = last_addres;
		last_addres += num * PAGE_SIZE;
		numOfPages[sizeofarray] = num;
		addresses[sizeofarray] = return_addres;
		changed[sizeofarray] = 1;
		sizeofarray++;
		return (void*) return_addres;
	}
	else
	{

		int count = 0;
		int min = 4000;
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
					f++;
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
					{
						min=count;
						min_addresss=addresses[i]-count*PAGE_SIZE;
						index=i-f;
						bool=1;
						lastindex=i;
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
				numOfPages[index+1]=numOfPages[index]-num;
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
						return NULL;
					sys_allocateMem(last_addres, size);
					return_addres = last_addres;
					last_addres += num * PAGE_SIZE;
					numOfPages[sizeofarray] = num;
					addresses[sizeofarray] = return_addres;
					changed[sizeofarray] = 1;
					sizeofarray++;
					return (void*) return_addres;
				}
	}
	//This function should find the space of the required range
	//using the BEST FIT strategy

	//refer to the project presentation and documentation for details

	return NULL;

}

// free():
//	This function frees the allocation of the given virtual_address
//	To do this, we need to switch to the kernel, free the pages AND "EMPTY" PAGE TABLES
//	from page file and main memory then switch back to the user again.
//
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address

	//display the arrays data
	/*cprintf("the va is :%x\n", virtual_address);
	cprintf("---------------------------------------------------\n");
	for (int j = 0; j < sizeofarray; j++) {
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
		if (addresses[i] == va && changed[i] == 1) {
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
		size = numOfPages[index] * PAGE_SIZE;
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
		changed[index] = 0;
		changes++;
	}
	//refer to the project presentation and documentation for details
}

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
	panic("this function is not required...!!");
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
	panic("this function is not required...!!");
	return 0;
}

void sfree(void* virtual_address) {
	panic("this function is not required...!!");
}

void *realloc(void *virtual_address, uint32 new_size) {
	panic("this function is not required...!!");
	return 0;
}

void expand(uint32 newSize) {
	panic("this function is not required...!!");
}
void shrink(uint32 newSize) {
	panic("this function is not required...!!");
}

void freeHeap(void* virtual_address) {
	panic("this function is not required...!!");
}
