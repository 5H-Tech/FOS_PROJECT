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
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//

uint32 last_addres=USER_HEAP_START;
int changes=0;
int sizeofarray=0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size)
{
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
			num++;
		if(last_addres==USER_HEAP_START)
		{
			sys_allocateMem(USER_HEAP_START,size);
			return_addres=last_addres;
			last_addres+=num*PAGE_SIZE;
			numOfPages[sizeofarray]=num;
			addresses[sizeofarray]=last_addres;
			changed[sizeofarray]=1;
			sizeofarray++;
			return (void*)return_addres;
		}
		else
		{
			if(changes==0)
			{
				sys_allocateMem(last_addres,size);
				return_addres=last_addres;
				last_addres+=num*PAGE_SIZE;
				numOfPages[sizeofarray]=num;
				addresses[sizeofarray]=return_addres;
				changed[sizeofarray]=1;
				sizeofarray++;
				return (void*)return_addres;
			}
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
					{
						if(addresses[j]==i)
						{
							index=j;
							break;
						}
					}

					if(index==-1)
					{
						count++;
					}
					else
					{
						if(changed[index]==0)
						{
							count++;
						}
						else
						{
							if(count<min&&count>=num)
							{
								min=count;
								min_addresss=i;
							}
							count=0;
						}

					}

					}

				sys_allocateMem(min_addresss,size);
				numOfPages[sizeofarray]=num;
				addresses[sizeofarray]=last_addres;
				changed[sizeofarray]=1;
				sizeofarray++;
				return(void*) min_addresss;
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

void free(void* virtual_address)
{
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    int size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
    	if(addresses[i]==va&&changed[i]==1){
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
    	size=numOfPages[index]*PAGE_SIZE;
    	sys_freeMem(va,size);
    	changed[index]=0;
    	changes++;
    }


	//refer to the project presentation and documentation for details
}

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
	panic("this function is not required...!!");
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
	panic("this function is not required...!!");
	return 0;
}

void sfree(void* virtual_address)
{
	panic("this function is not required...!!");
}

void *realloc(void *virtual_address, uint32 new_size)
{
	panic("this function is not required...!!");
	return 0;
}

void expand(uint32 newSize)
{
	panic("this function is not required...!!");
}
void shrink(uint32 newSize)
{
	panic("this function is not required...!!");
}

void freeHeap(void* virtual_address)
{
	panic("this function is not required...!!");
}
