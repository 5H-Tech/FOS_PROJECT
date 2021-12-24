
obj/user/tst_mod_11:     file format elf32-i386


Disassembly of section .text:

00800020 <_start>:
// starts us running when we are initially loaded into a new environment.
.text
.globl _start
_start:
	// See if we were started with arguments on the stack
	mov $0, %eax
  800020:	b8 00 00 00 00       	mov    $0x0,%eax
	cmpl $USTACKTOP, %esp
  800025:	81 fc 00 e0 bf ee    	cmp    $0xeebfe000,%esp
	jne args_exist
  80002b:	75 04                	jne    800031 <args_exist>

	// If not, push dummy argc/argv arguments.
	// This happens when we are loaded by the kernel,
	// because the kernel does not know about passing arguments.
	pushl $0
  80002d:	6a 00                	push   $0x0
	pushl $0
  80002f:	6a 00                	push   $0x0

00800031 <args_exist>:

args_exist:
	call libmain
  800031:	e8 4a 0b 00 00       	call   800b80 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

extern void shrink(uint32 newSize) ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	81 ec f0 00 00 00    	sub    $0xf0,%esp
	int Mega = 1024*1024;
  800043:	c7 45 e0 00 00 10 00 	movl   $0x100000,-0x20(%ebp)
	int kilo = 1024;
  80004a:	c7 45 dc 00 04 00 00 	movl   $0x400,-0x24(%ebp)


	char minByte = 1<<7;
  800051:	c6 45 db 80          	movb   $0x80,-0x25(%ebp)
	char maxByte = 0x7F;
  800055:	c6 45 da 7f          	movb   $0x7f,-0x26(%ebp)
	short minShort = 1<<15 ;
  800059:	66 c7 45 d8 00 80    	movw   $0x8000,-0x28(%ebp)
	short maxShort = 0x7FFF;
  80005f:	66 c7 45 d6 ff 7f    	movw   $0x7fff,-0x2a(%ebp)
	int minInt = 1<<31 ;
  800065:	c7 45 d0 00 00 00 80 	movl   $0x80000000,-0x30(%ebp)
	int maxInt = 0x7FFFFFFF;
  80006c:	c7 45 cc ff ff ff 7f 	movl   $0x7fffffff,-0x34(%ebp)
	char *byteArr, *byteArr2 ;
	short *shortArr, *shortArr2 ;
	int *intArr;
	struct MyStruct *structArr ;
	int lastIndexOfByte, lastIndexOfByte2, lastIndexOfShort, lastIndexOfShort2, lastIndexOfInt, lastIndexOfStruct;
	int start_freeFrames = sys_calculate_free_frames() ;
  800073:	e8 2e 21 00 00       	call   8021a6 <sys_calculate_free_frames>
  800078:	89 45 c8             	mov    %eax,-0x38(%ebp)

	//malloc some spaces
	int i, freeFrames, usedDiskPages ;
	char* ptr;
	int lastIndices[20] = {0};
  80007b:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  800081:	b9 14 00 00 00       	mov    $0x14,%ecx
  800086:	b8 00 00 00 00       	mov    $0x0,%eax
  80008b:	89 d7                	mov    %edx,%edi
  80008d:	f3 ab                	rep stos %eax,%es:(%edi)

	uint32 *arr;
	int expectedNumOfFrames1 = 0;
  80008f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	int expectedNumOfFrames2 = 0;
  800096:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	int expectedNumOfFrames3 = 0;
  80009d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	uint32 lastAddr = 0;
  8000a4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	uint32 curAddr = 0;
  8000ab:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)

	void* ptr_allocations[20] = {0};
  8000b2:	8d 95 08 ff ff ff    	lea    -0xf8(%ebp),%edx
  8000b8:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000bd:	b8 00 00 00 00       	mov    $0x0,%eax
  8000c2:	89 d7                	mov    %edx,%edi
  8000c4:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		//2 MB
		freeFrames = sys_calculate_free_frames() ;
  8000c6:	e8 db 20 00 00       	call   8021a6 <sys_calculate_free_frames>
  8000cb:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8000ce:	e8 56 21 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  8000d3:	89 45 bc             	mov    %eax,-0x44(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8000d6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000d9:	01 c0                	add    %eax,%eax
  8000db:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8000de:	83 ec 0c             	sub    $0xc,%esp
  8000e1:	50                   	push   %eax
  8000e2:	e8 0a 1c 00 00       	call   801cf1 <malloc>
  8000e7:	83 c4 10             	add    $0x10,%esp
  8000ea:	89 85 08 ff ff ff    	mov    %eax,-0xf8(%ebp)
		if ((uint32) ptr_allocations[0] !=  (USER_HEAP_START)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8000f0:	8b 85 08 ff ff ff    	mov    -0xf8(%ebp),%eax
  8000f6:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8000fb:	74 14                	je     800111 <_main+0xd9>
  8000fd:	83 ec 04             	sub    $0x4,%esp
  800100:	68 00 29 80 00       	push   $0x802900
  800105:	6a 2c                	push   $0x2c
  800107:	68 65 29 80 00       	push   $0x802965
  80010c:	e8 b4 0b 00 00       	call   800cc5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512 ) panic("Extra or less pages are allocated in PageFile");
  800111:	e8 13 21 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  800116:	2b 45 bc             	sub    -0x44(%ebp),%eax
  800119:	3d 00 02 00 00       	cmp    $0x200,%eax
  80011e:	74 14                	je     800134 <_main+0xfc>
  800120:	83 ec 04             	sub    $0x4,%esp
  800123:	68 78 29 80 00       	push   $0x802978
  800128:	6a 2d                	push   $0x2d
  80012a:	68 65 29 80 00       	push   $0x802965
  80012f:	e8 91 0b 00 00       	call   800cc5 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800134:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  800137:	e8 6a 20 00 00       	call   8021a6 <sys_calculate_free_frames>
  80013c:	29 c3                	sub    %eax,%ebx
  80013e:	89 d8                	mov    %ebx,%eax
  800140:	83 f8 01             	cmp    $0x1,%eax
  800143:	74 14                	je     800159 <_main+0x121>
  800145:	83 ec 04             	sub    $0x4,%esp
  800148:	68 a8 29 80 00       	push   $0x8029a8
  80014d:	6a 2e                	push   $0x2e
  80014f:	68 65 29 80 00       	push   $0x802965
  800154:	e8 6c 0b 00 00       	call   800cc5 <_panic>
		lastIndices[0] = (2*Mega-kilo)/sizeof(char) - 1;
  800159:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80015c:	01 c0                	add    %eax,%eax
  80015e:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800161:	48                   	dec    %eax
  800162:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)

		//2 MB
		freeFrames = sys_calculate_free_frames() ;
  800168:	e8 39 20 00 00       	call   8021a6 <sys_calculate_free_frames>
  80016d:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800170:	e8 b4 20 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  800175:	89 45 bc             	mov    %eax,-0x44(%ebp)
		ptr_allocations[1] = malloc(2*Mega-kilo);
  800178:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80017b:	01 c0                	add    %eax,%eax
  80017d:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800180:	83 ec 0c             	sub    $0xc,%esp
  800183:	50                   	push   %eax
  800184:	e8 68 1b 00 00       	call   801cf1 <malloc>
  800189:	83 c4 10             	add    $0x10,%esp
  80018c:	89 85 0c ff ff ff    	mov    %eax,-0xf4(%ebp)
		if ((uint32) ptr_allocations[1] != (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800192:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
  800198:	89 c2                	mov    %eax,%edx
  80019a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80019d:	01 c0                	add    %eax,%eax
  80019f:	05 00 00 00 80       	add    $0x80000000,%eax
  8001a4:	39 c2                	cmp    %eax,%edx
  8001a6:	74 14                	je     8001bc <_main+0x184>
  8001a8:	83 ec 04             	sub    $0x4,%esp
  8001ab:	68 00 29 80 00       	push   $0x802900
  8001b0:	6a 35                	push   $0x35
  8001b2:	68 65 29 80 00       	push   $0x802965
  8001b7:	e8 09 0b 00 00       	call   800cc5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512 ) panic("Extra or less pages are allocated in PageFile");
  8001bc:	e8 68 20 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  8001c1:	2b 45 bc             	sub    -0x44(%ebp),%eax
  8001c4:	3d 00 02 00 00       	cmp    $0x200,%eax
  8001c9:	74 14                	je     8001df <_main+0x1a7>
  8001cb:	83 ec 04             	sub    $0x4,%esp
  8001ce:	68 78 29 80 00       	push   $0x802978
  8001d3:	6a 36                	push   $0x36
  8001d5:	68 65 29 80 00       	push   $0x802965
  8001da:	e8 e6 0a 00 00       	call   800cc5 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8001df:	e8 c2 1f 00 00       	call   8021a6 <sys_calculate_free_frames>
  8001e4:	89 c2                	mov    %eax,%edx
  8001e6:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001e9:	39 c2                	cmp    %eax,%edx
  8001eb:	74 14                	je     800201 <_main+0x1c9>
  8001ed:	83 ec 04             	sub    $0x4,%esp
  8001f0:	68 a8 29 80 00       	push   $0x8029a8
  8001f5:	6a 37                	push   $0x37
  8001f7:	68 65 29 80 00       	push   $0x802965
  8001fc:	e8 c4 0a 00 00       	call   800cc5 <_panic>
		lastIndices[1] = (2*Mega-kilo)/sizeof(char) - 1;
  800201:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800204:	01 c0                	add    %eax,%eax
  800206:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800209:	48                   	dec    %eax
  80020a:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  800210:	e8 91 1f 00 00       	call   8021a6 <sys_calculate_free_frames>
  800215:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800218:	e8 0c 20 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  80021d:	89 45 bc             	mov    %eax,-0x44(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  800220:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800223:	01 c0                	add    %eax,%eax
  800225:	83 ec 0c             	sub    $0xc,%esp
  800228:	50                   	push   %eax
  800229:	e8 c3 1a 00 00       	call   801cf1 <malloc>
  80022e:	83 c4 10             	add    $0x10,%esp
  800231:	89 85 10 ff ff ff    	mov    %eax,-0xf0(%ebp)
		if ((uint32) ptr_allocations[2] != (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800237:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
  80023d:	89 c2                	mov    %eax,%edx
  80023f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800242:	c1 e0 02             	shl    $0x2,%eax
  800245:	05 00 00 00 80       	add    $0x80000000,%eax
  80024a:	39 c2                	cmp    %eax,%edx
  80024c:	74 14                	je     800262 <_main+0x22a>
  80024e:	83 ec 04             	sub    $0x4,%esp
  800251:	68 00 29 80 00       	push   $0x802900
  800256:	6a 3e                	push   $0x3e
  800258:	68 65 29 80 00       	push   $0x802965
  80025d:	e8 63 0a 00 00       	call   800cc5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1 ) panic("Extra or less pages are allocated in PageFile");
  800262:	e8 c2 1f 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  800267:	2b 45 bc             	sub    -0x44(%ebp),%eax
  80026a:	83 f8 01             	cmp    $0x1,%eax
  80026d:	74 14                	je     800283 <_main+0x24b>
  80026f:	83 ec 04             	sub    $0x4,%esp
  800272:	68 78 29 80 00       	push   $0x802978
  800277:	6a 3f                	push   $0x3f
  800279:	68 65 29 80 00       	push   $0x802965
  80027e:	e8 42 0a 00 00       	call   800cc5 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800283:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  800286:	e8 1b 1f 00 00       	call   8021a6 <sys_calculate_free_frames>
  80028b:	29 c3                	sub    %eax,%ebx
  80028d:	89 d8                	mov    %ebx,%eax
  80028f:	83 f8 01             	cmp    $0x1,%eax
  800292:	74 14                	je     8002a8 <_main+0x270>
  800294:	83 ec 04             	sub    $0x4,%esp
  800297:	68 a8 29 80 00       	push   $0x8029a8
  80029c:	6a 40                	push   $0x40
  80029e:	68 65 29 80 00       	push   $0x802965
  8002a3:	e8 1d 0a 00 00       	call   800cc5 <_panic>
		lastIndices[2] = (2*kilo)/sizeof(char) - 1;
  8002a8:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002ab:	01 c0                	add    %eax,%eax
  8002ad:	48                   	dec    %eax
  8002ae:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
		ptr = (char*)ptr_allocations[2];
  8002b4:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
  8002ba:	89 45 b8             	mov    %eax,-0x48(%ebp)
		for (i = 0; i < lastIndices[2]; ++i)
  8002bd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8002c4:	eb 0e                	jmp    8002d4 <_main+0x29c>
		{
			ptr[i] = 2 ;
  8002c6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8002c9:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8002cc:	01 d0                	add    %edx,%eax
  8002ce:	c6 00 02             	movb   $0x2,(%eax)
		if ((uint32) ptr_allocations[2] != (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1 ) panic("Extra or less pages are allocated in PageFile");
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
		lastIndices[2] = (2*kilo)/sizeof(char) - 1;
		ptr = (char*)ptr_allocations[2];
		for (i = 0; i < lastIndices[2]; ++i)
  8002d1:	ff 45 f4             	incl   -0xc(%ebp)
  8002d4:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  8002da:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8002dd:	7f e7                	jg     8002c6 <_main+0x28e>
		{
			ptr[i] = 2 ;
		}

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  8002df:	e8 c2 1e 00 00       	call   8021a6 <sys_calculate_free_frames>
  8002e4:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8002e7:	e8 3d 1f 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  8002ec:	89 45 bc             	mov    %eax,-0x44(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  8002ef:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002f2:	01 c0                	add    %eax,%eax
  8002f4:	83 ec 0c             	sub    $0xc,%esp
  8002f7:	50                   	push   %eax
  8002f8:	e8 f4 19 00 00       	call   801cf1 <malloc>
  8002fd:	83 c4 10             	add    $0x10,%esp
  800300:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
		if ((uint32) ptr_allocations[3] != (USER_HEAP_START + 4*Mega + 4*kilo)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800306:	8b 85 14 ff ff ff    	mov    -0xec(%ebp),%eax
  80030c:	89 c2                	mov    %eax,%edx
  80030e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800311:	c1 e0 02             	shl    $0x2,%eax
  800314:	89 c1                	mov    %eax,%ecx
  800316:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800319:	c1 e0 02             	shl    $0x2,%eax
  80031c:	01 c8                	add    %ecx,%eax
  80031e:	05 00 00 00 80       	add    $0x80000000,%eax
  800323:	39 c2                	cmp    %eax,%edx
  800325:	74 14                	je     80033b <_main+0x303>
  800327:	83 ec 04             	sub    $0x4,%esp
  80032a:	68 00 29 80 00       	push   $0x802900
  80032f:	6a 4c                	push   $0x4c
  800331:	68 65 29 80 00       	push   $0x802965
  800336:	e8 8a 09 00 00       	call   800cc5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1 ) panic("Extra or less pages are allocated in PageFile");
  80033b:	e8 e9 1e 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  800340:	2b 45 bc             	sub    -0x44(%ebp),%eax
  800343:	83 f8 01             	cmp    $0x1,%eax
  800346:	74 14                	je     80035c <_main+0x324>
  800348:	83 ec 04             	sub    $0x4,%esp
  80034b:	68 78 29 80 00       	push   $0x802978
  800350:	6a 4d                	push   $0x4d
  800352:	68 65 29 80 00       	push   $0x802965
  800357:	e8 69 09 00 00       	call   800cc5 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  80035c:	e8 45 1e 00 00       	call   8021a6 <sys_calculate_free_frames>
  800361:	89 c2                	mov    %eax,%edx
  800363:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800366:	39 c2                	cmp    %eax,%edx
  800368:	74 14                	je     80037e <_main+0x346>
  80036a:	83 ec 04             	sub    $0x4,%esp
  80036d:	68 a8 29 80 00       	push   $0x8029a8
  800372:	6a 4e                	push   $0x4e
  800374:	68 65 29 80 00       	push   $0x802965
  800379:	e8 47 09 00 00       	call   800cc5 <_panic>
		lastIndices[3] = (2*kilo)/sizeof(char) - 1;
  80037e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800381:	01 c0                	add    %eax,%eax
  800383:	48                   	dec    %eax
  800384:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
		ptr = (char*)ptr_allocations[3];
  80038a:	8b 85 14 ff ff ff    	mov    -0xec(%ebp),%eax
  800390:	89 45 b8             	mov    %eax,-0x48(%ebp)
		for (i = 0; i < lastIndices[3]; ++i)
  800393:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80039a:	eb 0e                	jmp    8003aa <_main+0x372>
		{
			ptr[i] = 3 ;
  80039c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80039f:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8003a2:	01 d0                	add    %edx,%eax
  8003a4:	c6 00 03             	movb   $0x3,(%eax)
		if ((uint32) ptr_allocations[3] != (USER_HEAP_START + 4*Mega + 4*kilo)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1 ) panic("Extra or less pages are allocated in PageFile");
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
		lastIndices[3] = (2*kilo)/sizeof(char) - 1;
		ptr = (char*)ptr_allocations[3];
		for (i = 0; i < lastIndices[3]; ++i)
  8003a7:	ff 45 f4             	incl   -0xc(%ebp)
  8003aa:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  8003b0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8003b3:	7f e7                	jg     80039c <_main+0x364>
		{
			ptr[i] = 3 ;
		}

		//7 KB
		freeFrames = sys_calculate_free_frames() ;
  8003b5:	e8 ec 1d 00 00       	call   8021a6 <sys_calculate_free_frames>
  8003ba:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8003bd:	e8 67 1e 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  8003c2:	89 45 bc             	mov    %eax,-0x44(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  8003c5:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8003c8:	89 d0                	mov    %edx,%eax
  8003ca:	01 c0                	add    %eax,%eax
  8003cc:	01 d0                	add    %edx,%eax
  8003ce:	01 c0                	add    %eax,%eax
  8003d0:	01 d0                	add    %edx,%eax
  8003d2:	83 ec 0c             	sub    $0xc,%esp
  8003d5:	50                   	push   %eax
  8003d6:	e8 16 19 00 00       	call   801cf1 <malloc>
  8003db:	83 c4 10             	add    $0x10,%esp
  8003de:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
		if ((uint32) ptr_allocations[4] != (USER_HEAP_START + 4*Mega + 8*kilo)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8003e4:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
  8003ea:	89 c2                	mov    %eax,%edx
  8003ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003ef:	c1 e0 02             	shl    $0x2,%eax
  8003f2:	89 c1                	mov    %eax,%ecx
  8003f4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8003f7:	c1 e0 03             	shl    $0x3,%eax
  8003fa:	01 c8                	add    %ecx,%eax
  8003fc:	05 00 00 00 80       	add    $0x80000000,%eax
  800401:	39 c2                	cmp    %eax,%edx
  800403:	74 14                	je     800419 <_main+0x3e1>
  800405:	83 ec 04             	sub    $0x4,%esp
  800408:	68 00 29 80 00       	push   $0x802900
  80040d:	6a 5a                	push   $0x5a
  80040f:	68 65 29 80 00       	push   $0x802965
  800414:	e8 ac 08 00 00       	call   800cc5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2 ) panic("Extra or less pages are allocated in PageFile");
  800419:	e8 0b 1e 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  80041e:	2b 45 bc             	sub    -0x44(%ebp),%eax
  800421:	83 f8 02             	cmp    $0x2,%eax
  800424:	74 14                	je     80043a <_main+0x402>
  800426:	83 ec 04             	sub    $0x4,%esp
  800429:	68 78 29 80 00       	push   $0x802978
  80042e:	6a 5b                	push   $0x5b
  800430:	68 65 29 80 00       	push   $0x802965
  800435:	e8 8b 08 00 00       	call   800cc5 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  80043a:	e8 67 1d 00 00       	call   8021a6 <sys_calculate_free_frames>
  80043f:	89 c2                	mov    %eax,%edx
  800441:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800444:	39 c2                	cmp    %eax,%edx
  800446:	74 14                	je     80045c <_main+0x424>
  800448:	83 ec 04             	sub    $0x4,%esp
  80044b:	68 a8 29 80 00       	push   $0x8029a8
  800450:	6a 5c                	push   $0x5c
  800452:	68 65 29 80 00       	push   $0x802965
  800457:	e8 69 08 00 00       	call   800cc5 <_panic>
		lastIndices[4] = (7*kilo)/sizeof(char) - 1;
  80045c:	8b 55 dc             	mov    -0x24(%ebp),%edx
  80045f:	89 d0                	mov    %edx,%eax
  800461:	01 c0                	add    %eax,%eax
  800463:	01 d0                	add    %edx,%eax
  800465:	01 c0                	add    %eax,%eax
  800467:	01 d0                	add    %edx,%eax
  800469:	48                   	dec    %eax
  80046a:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
		ptr = (char*)ptr_allocations[4];
  800470:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
  800476:	89 45 b8             	mov    %eax,-0x48(%ebp)
		for (i = 0; i < lastIndices[4]; ++i)
  800479:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800480:	eb 0e                	jmp    800490 <_main+0x458>
		{
			ptr[i] = 4 ;
  800482:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800485:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800488:	01 d0                	add    %edx,%eax
  80048a:	c6 00 04             	movb   $0x4,(%eax)
		if ((uint32) ptr_allocations[4] != (USER_HEAP_START + 4*Mega + 8*kilo)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2 ) panic("Extra or less pages are allocated in PageFile");
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
		lastIndices[4] = (7*kilo)/sizeof(char) - 1;
		ptr = (char*)ptr_allocations[4];
		for (i = 0; i < lastIndices[4]; ++i)
  80048d:	ff 45 f4             	incl   -0xc(%ebp)
  800490:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  800496:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800499:	7f e7                	jg     800482 <_main+0x44a>
		{
			ptr[i] = 4 ;
		}

		cprintf("1/9\n");
  80049b:	83 ec 0c             	sub    $0xc,%esp
  80049e:	68 12 2a 80 00       	push   $0x802a12
  8004a3:	e8 bf 0a 00 00       	call   800f67 <cprintf>
  8004a8:	83 c4 10             	add    $0x10,%esp

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8004ab:	e8 f6 1c 00 00       	call   8021a6 <sys_calculate_free_frames>
  8004b0:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8004b3:	e8 71 1d 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  8004b8:	89 45 bc             	mov    %eax,-0x44(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  8004bb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004be:	89 c2                	mov    %eax,%edx
  8004c0:	01 d2                	add    %edx,%edx
  8004c2:	01 d0                	add    %edx,%eax
  8004c4:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8004c7:	83 ec 0c             	sub    $0xc,%esp
  8004ca:	50                   	push   %eax
  8004cb:	e8 21 18 00 00       	call   801cf1 <malloc>
  8004d0:	83 c4 10             	add    $0x10,%esp
  8004d3:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
		if ((uint32) ptr_allocations[5] != (USER_HEAP_START + 4*Mega + 16*kilo) ) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8004d9:	8b 85 1c ff ff ff    	mov    -0xe4(%ebp),%eax
  8004df:	89 c2                	mov    %eax,%edx
  8004e1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004e4:	c1 e0 02             	shl    $0x2,%eax
  8004e7:	89 c1                	mov    %eax,%ecx
  8004e9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004ec:	c1 e0 04             	shl    $0x4,%eax
  8004ef:	01 c8                	add    %ecx,%eax
  8004f1:	05 00 00 00 80       	add    $0x80000000,%eax
  8004f6:	39 c2                	cmp    %eax,%edx
  8004f8:	74 14                	je     80050e <_main+0x4d6>
  8004fa:	83 ec 04             	sub    $0x4,%esp
  8004fd:	68 00 29 80 00       	push   $0x802900
  800502:	6a 6a                	push   $0x6a
  800504:	68 65 29 80 00       	push   $0x802965
  800509:	e8 b7 07 00 00       	call   800cc5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 768 ) panic("Extra or less pages are allocated in PageFile");
  80050e:	e8 16 1d 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  800513:	2b 45 bc             	sub    -0x44(%ebp),%eax
  800516:	3d 00 03 00 00       	cmp    $0x300,%eax
  80051b:	74 14                	je     800531 <_main+0x4f9>
  80051d:	83 ec 04             	sub    $0x4,%esp
  800520:	68 78 29 80 00       	push   $0x802978
  800525:	6a 6b                	push   $0x6b
  800527:	68 65 29 80 00       	push   $0x802965
  80052c:	e8 94 07 00 00       	call   800cc5 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800531:	e8 70 1c 00 00       	call   8021a6 <sys_calculate_free_frames>
  800536:	89 c2                	mov    %eax,%edx
  800538:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80053b:	39 c2                	cmp    %eax,%edx
  80053d:	74 14                	je     800553 <_main+0x51b>
  80053f:	83 ec 04             	sub    $0x4,%esp
  800542:	68 a8 29 80 00       	push   $0x8029a8
  800547:	6a 6c                	push   $0x6c
  800549:	68 65 29 80 00       	push   $0x802965
  80054e:	e8 72 07 00 00       	call   800cc5 <_panic>
		lastIndices[5] = (3*Mega-kilo)/sizeof(char) - 1;
  800553:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800556:	89 c2                	mov    %eax,%edx
  800558:	01 d2                	add    %edx,%edx
  80055a:	01 d0                	add    %edx,%eax
  80055c:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80055f:	48                   	dec    %eax
  800560:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
		ptr = (char*)ptr_allocations[5];
  800566:	8b 85 1c ff ff ff    	mov    -0xe4(%ebp),%eax
  80056c:	89 45 b8             	mov    %eax,-0x48(%ebp)
		for (i = 0; i < lastIndices[5]; i+=PAGE_SIZE)
  80056f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800576:	eb 12                	jmp    80058a <_main+0x552>
		{
			ptr[i] = 5 ;
  800578:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80057b:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80057e:	01 d0                	add    %edx,%eax
  800580:	c6 00 05             	movb   $0x5,(%eax)
		if ((uint32) ptr_allocations[5] != (USER_HEAP_START + 4*Mega + 16*kilo) ) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 768 ) panic("Extra or less pages are allocated in PageFile");
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
		lastIndices[5] = (3*Mega-kilo)/sizeof(char) - 1;
		ptr = (char*)ptr_allocations[5];
		for (i = 0; i < lastIndices[5]; i+=PAGE_SIZE)
  800583:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
  80058a:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800590:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800593:	7f e3                	jg     800578 <_main+0x540>
		{
			ptr[i] = 5 ;
		}

		cprintf("2/9\n");
  800595:	83 ec 0c             	sub    $0xc,%esp
  800598:	68 17 2a 80 00       	push   $0x802a17
  80059d:	e8 c5 09 00 00       	call   800f67 <cprintf>
  8005a2:	83 c4 10             	add    $0x10,%esp

		//6 MB
		freeFrames = sys_calculate_free_frames() ;
  8005a5:	e8 fc 1b 00 00       	call   8021a6 <sys_calculate_free_frames>
  8005aa:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8005ad:	e8 77 1c 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  8005b2:	89 45 bc             	mov    %eax,-0x44(%ebp)
		ptr_allocations[6] = malloc(6*Mega);
  8005b5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005b8:	89 d0                	mov    %edx,%eax
  8005ba:	01 c0                	add    %eax,%eax
  8005bc:	01 d0                	add    %edx,%eax
  8005be:	01 c0                	add    %eax,%eax
  8005c0:	83 ec 0c             	sub    $0xc,%esp
  8005c3:	50                   	push   %eax
  8005c4:	e8 28 17 00 00       	call   801cf1 <malloc>
  8005c9:	83 c4 10             	add    $0x10,%esp
  8005cc:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
		if ((uint32) ptr_allocations[6] != (USER_HEAP_START + 7*Mega + 16*kilo)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8005d2:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  8005d8:	89 c1                	mov    %eax,%ecx
  8005da:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005dd:	89 d0                	mov    %edx,%eax
  8005df:	01 c0                	add    %eax,%eax
  8005e1:	01 d0                	add    %edx,%eax
  8005e3:	01 c0                	add    %eax,%eax
  8005e5:	01 d0                	add    %edx,%eax
  8005e7:	89 c2                	mov    %eax,%edx
  8005e9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005ec:	c1 e0 04             	shl    $0x4,%eax
  8005ef:	01 d0                	add    %edx,%eax
  8005f1:	05 00 00 00 80       	add    $0x80000000,%eax
  8005f6:	39 c1                	cmp    %eax,%ecx
  8005f8:	74 14                	je     80060e <_main+0x5d6>
  8005fa:	83 ec 04             	sub    $0x4,%esp
  8005fd:	68 00 29 80 00       	push   $0x802900
  800602:	6a 7a                	push   $0x7a
  800604:	68 65 29 80 00       	push   $0x802965
  800609:	e8 b7 06 00 00       	call   800cc5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1536 ) panic("Extra or less pages are allocated in PageFile");
  80060e:	e8 16 1c 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  800613:	2b 45 bc             	sub    -0x44(%ebp),%eax
  800616:	3d 00 06 00 00       	cmp    $0x600,%eax
  80061b:	74 14                	je     800631 <_main+0x5f9>
  80061d:	83 ec 04             	sub    $0x4,%esp
  800620:	68 78 29 80 00       	push   $0x802978
  800625:	6a 7b                	push   $0x7b
  800627:	68 65 29 80 00       	push   $0x802965
  80062c:	e8 94 06 00 00       	call   800cc5 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800631:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  800634:	e8 6d 1b 00 00       	call   8021a6 <sys_calculate_free_frames>
  800639:	29 c3                	sub    %eax,%ebx
  80063b:	89 d8                	mov    %ebx,%eax
  80063d:	83 f8 02             	cmp    $0x2,%eax
  800640:	74 14                	je     800656 <_main+0x61e>
  800642:	83 ec 04             	sub    $0x4,%esp
  800645:	68 a8 29 80 00       	push   $0x8029a8
  80064a:	6a 7c                	push   $0x7c
  80064c:	68 65 29 80 00       	push   $0x802965
  800651:	e8 6f 06 00 00       	call   800cc5 <_panic>
		lastIndices[6] = (6*Mega)/sizeof(uint32) - 1;
  800656:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800659:	89 d0                	mov    %edx,%eax
  80065b:	01 c0                	add    %eax,%eax
  80065d:	01 d0                	add    %edx,%eax
  80065f:	01 c0                	add    %eax,%eax
  800661:	c1 e8 02             	shr    $0x2,%eax
  800664:	48                   	dec    %eax
  800665:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		arr = (uint32*)ptr_allocations[6];
  80066b:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  800671:	89 45 b4             	mov    %eax,-0x4c(%ebp)

		lastAddr = 0;
  800674:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		for (i = 0; i <= lastIndices[6]; i+=PAGE_SIZE)
  80067b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800682:	eb 62                	jmp    8006e6 <_main+0x6ae>
		{
			arr[i] = i ;
  800684:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800687:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80068e:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800691:	01 c2                	add    %eax,%edx
  800693:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800696:	89 02                	mov    %eax,(%edx)
			curAddr = ROUNDDOWN((uint32)(&(arr[i])), PAGE_SIZE) ;
  800698:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80069b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006a2:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8006a5:	01 d0                	add    %edx,%eax
  8006a7:	89 45 b0             	mov    %eax,-0x50(%ebp)
  8006aa:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8006ad:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8006b2:	89 45 c4             	mov    %eax,-0x3c(%ebp)
			if (curAddr != lastAddr)
  8006b5:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8006b8:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8006bb:	74 22                	je     8006df <_main+0x6a7>
			{
				if (curAddr >= (uint32)ptr_allocations[6] + 5*Mega)
  8006bd:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  8006c3:	89 c1                	mov    %eax,%ecx
  8006c5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006c8:	89 d0                	mov    %edx,%eax
  8006ca:	c1 e0 02             	shl    $0x2,%eax
  8006cd:	01 d0                	add    %edx,%eax
  8006cf:	01 c8                	add    %ecx,%eax
  8006d1:	3b 45 c4             	cmp    -0x3c(%ebp),%eax
  8006d4:	77 03                	ja     8006d9 <_main+0x6a1>
					expectedNumOfFrames1++ ;
  8006d6:	ff 45 f0             	incl   -0x10(%ebp)
				lastAddr = curAddr;
  8006d9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8006dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
		lastIndices[6] = (6*Mega)/sizeof(uint32) - 1;
		arr = (uint32*)ptr_allocations[6];

		lastAddr = 0;
		for (i = 0; i <= lastIndices[6]; i+=PAGE_SIZE)
  8006df:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
  8006e6:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8006ec:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8006ef:	7d 93                	jge    800684 <_main+0x64c>
					expectedNumOfFrames1++ ;
				lastAddr = curAddr;
			}
		}

		cprintf("3/9\n");
  8006f1:	83 ec 0c             	sub    $0xc,%esp
  8006f4:	68 1c 2a 80 00       	push   $0x802a1c
  8006f9:	e8 69 08 00 00       	call   800f67 <cprintf>
  8006fe:	83 c4 10             	add    $0x10,%esp
	}


	//Shrink last allocated variable to 5 MB instead of 6 MB
	{
		freeFrames = sys_calculate_free_frames() ;
  800701:	e8 a0 1a 00 00       	call   8021a6 <sys_calculate_free_frames>
  800706:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800709:	e8 1b 1b 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  80070e:	89 45 bc             	mov    %eax,-0x44(%ebp)

		shrink(5*Mega) ;
  800711:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800714:	89 d0                	mov    %edx,%eax
  800716:	c1 e0 02             	shl    $0x2,%eax
  800719:	01 d0                	add    %edx,%eax
  80071b:	83 ec 0c             	sub    $0xc,%esp
  80071e:	50                   	push   %eax
  80071f:	e8 dc 18 00 00       	call   802000 <shrink>
  800724:	83 c4 10             	add    $0x10,%esp

		assert(usedDiskPages - sys_pf_calculate_allocated_pages() == 256) ;
  800727:	e8 fd 1a 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  80072c:	8b 55 bc             	mov    -0x44(%ebp),%edx
  80072f:	29 c2                	sub    %eax,%edx
  800731:	89 d0                	mov    %edx,%eax
  800733:	3d 00 01 00 00       	cmp    $0x100,%eax
  800738:	74 19                	je     800753 <_main+0x71b>
  80073a:	68 24 2a 80 00       	push   $0x802a24
  80073f:	68 5e 2a 80 00       	push   $0x802a5e
  800744:	68 99 00 00 00       	push   $0x99
  800749:	68 65 29 80 00       	push   $0x802965
  80074e:	e8 72 05 00 00       	call   800cc5 <_panic>
		assert(sys_calculate_free_frames() - freeFrames == expectedNumOfFrames1) ;
  800753:	e8 4e 1a 00 00       	call   8021a6 <sys_calculate_free_frames>
  800758:	89 c2                	mov    %eax,%edx
  80075a:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80075d:	29 c2                	sub    %eax,%edx
  80075f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800762:	39 c2                	cmp    %eax,%edx
  800764:	74 19                	je     80077f <_main+0x747>
  800766:	68 74 2a 80 00       	push   $0x802a74
  80076b:	68 5e 2a 80 00       	push   $0x802a5e
  800770:	68 9a 00 00 00       	push   $0x9a
  800775:	68 65 29 80 00       	push   $0x802965
  80077a:	e8 46 05 00 00       	call   800cc5 <_panic>
	}
	cprintf("4/9\n");
  80077f:	83 ec 0c             	sub    $0xc,%esp
  800782:	68 b5 2a 80 00       	push   $0x802ab5
  800787:	e8 db 07 00 00       	call   800f67 <cprintf>
  80078c:	83 c4 10             	add    $0x10,%esp

	//Access elements after shrink
	int newLastIndex = (5*Mega)/sizeof(uint32) - 1;
  80078f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800792:	89 d0                	mov    %edx,%eax
  800794:	c1 e0 02             	shl    $0x2,%eax
  800797:	01 d0                	add    %edx,%eax
  800799:	c1 e8 02             	shr    $0x2,%eax
  80079c:	48                   	dec    %eax
  80079d:	89 45 ac             	mov    %eax,-0x54(%ebp)
	{
		lastAddr = 0;
  8007a0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		for (i = 0; i <= newLastIndex ; i+=PAGE_SIZE)
  8007a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8007ae:	eb 7f                	jmp    80082f <_main+0x7f7>
		{
			assert(arr[i] == i);
  8007b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8007b3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007ba:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8007bd:	01 d0                	add    %edx,%eax
  8007bf:	8b 10                	mov    (%eax),%edx
  8007c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8007c4:	39 c2                	cmp    %eax,%edx
  8007c6:	74 19                	je     8007e1 <_main+0x7a9>
  8007c8:	68 ba 2a 80 00       	push   $0x802aba
  8007cd:	68 5e 2a 80 00       	push   $0x802a5e
  8007d2:	68 a4 00 00 00       	push   $0xa4
  8007d7:	68 65 29 80 00       	push   $0x802965
  8007dc:	e8 e4 04 00 00       	call   800cc5 <_panic>
			curAddr = ROUNDDOWN((uint32)(&(arr[i])), PAGE_SIZE) ;
  8007e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8007e4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007eb:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8007ee:	01 d0                	add    %edx,%eax
  8007f0:	89 45 a8             	mov    %eax,-0x58(%ebp)
  8007f3:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8007f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007fb:	89 45 c4             	mov    %eax,-0x3c(%ebp)

			if (curAddr != lastAddr)
  8007fe:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800801:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800804:	74 22                	je     800828 <_main+0x7f0>
			{
				if (curAddr >= (uint32)ptr_allocations[6] + 2*Mega)
  800806:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  80080c:	89 c2                	mov    %eax,%edx
  80080e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800811:	01 c0                	add    %eax,%eax
  800813:	01 d0                	add    %edx,%eax
  800815:	3b 45 c4             	cmp    -0x3c(%ebp),%eax
  800818:	77 05                	ja     80081f <_main+0x7e7>
					expectedNumOfFrames2++ ;
  80081a:	ff 45 ec             	incl   -0x14(%ebp)
  80081d:	eb 03                	jmp    800822 <_main+0x7ea>
				else
					expectedNumOfFrames3++ ;
  80081f:	ff 45 e8             	incl   -0x18(%ebp)
				lastAddr = curAddr;
  800822:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800825:	89 45 e4             	mov    %eax,-0x1c(%ebp)

	//Access elements after shrink
	int newLastIndex = (5*Mega)/sizeof(uint32) - 1;
	{
		lastAddr = 0;
		for (i = 0; i <= newLastIndex ; i+=PAGE_SIZE)
  800828:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
  80082f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800832:	3b 45 ac             	cmp    -0x54(%ebp),%eax
  800835:	0f 8e 75 ff ff ff    	jle    8007b0 <_main+0x778>
					expectedNumOfFrames3++ ;
				lastAddr = curAddr;
			}
		}

		cprintf("5/9\n");
  80083b:	83 ec 0c             	sub    $0xc,%esp
  80083e:	68 c6 2a 80 00       	push   $0x802ac6
  800843:	e8 1f 07 00 00       	call   800f67 <cprintf>
  800848:	83 c4 10             	add    $0x10,%esp

		//Bypass the PAGE FAULT on <MOVB immediate, reg> instruction by setting its length
		//and continue executing the remaining code
		sys_bypassPageFault(3);
  80084b:	83 ec 0c             	sub    $0xc,%esp
  80084e:	6a 03                	push   $0x3
  800850:	e8 68 1c 00 00       	call   8024bd <sys_bypassPageFault>
  800855:	83 c4 10             	add    $0x10,%esp

		ptr = (char *) ptr_allocations[6];
  800858:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  80085e:	89 45 b8             	mov    %eax,-0x48(%ebp)
		ptr[5*Mega] = 10;
  800861:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800864:	89 d0                	mov    %edx,%eax
  800866:	c1 e0 02             	shl    $0x2,%eax
  800869:	01 d0                	add    %edx,%eax
  80086b:	89 c2                	mov    %eax,%edx
  80086d:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800870:	01 d0                	add    %edx,%eax
  800872:	c6 00 0a             	movb   $0xa,(%eax)
		assert(sys_rcr2() == (uint32)&(ptr[5*Mega])) ;
  800875:	e8 2a 1c 00 00       	call   8024a4 <sys_rcr2>
  80087a:	89 c1                	mov    %eax,%ecx
  80087c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80087f:	89 d0                	mov    %edx,%eax
  800881:	c1 e0 02             	shl    $0x2,%eax
  800884:	01 d0                	add    %edx,%eax
  800886:	89 c2                	mov    %eax,%edx
  800888:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80088b:	01 d0                	add    %edx,%eax
  80088d:	39 c1                	cmp    %eax,%ecx
  80088f:	74 19                	je     8008aa <_main+0x872>
  800891:	68 cc 2a 80 00       	push   $0x802acc
  800896:	68 5e 2a 80 00       	push   $0x802a5e
  80089b:	68 b9 00 00 00       	push   $0xb9
  8008a0:	68 65 29 80 00       	push   $0x802965
  8008a5:	e8 1b 04 00 00       	call   800cc5 <_panic>

		ptr[5*Mega+4*kilo] = 10;
  8008aa:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008ad:	89 d0                	mov    %edx,%eax
  8008af:	c1 e0 02             	shl    $0x2,%eax
  8008b2:	01 c2                	add    %eax,%edx
  8008b4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8008b7:	c1 e0 02             	shl    $0x2,%eax
  8008ba:	01 d0                	add    %edx,%eax
  8008bc:	89 c2                	mov    %eax,%edx
  8008be:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8008c1:	01 d0                	add    %edx,%eax
  8008c3:	c6 00 0a             	movb   $0xa,(%eax)
		assert(sys_rcr2() == (uint32)&(ptr[5*Mega+4*kilo])) ;
  8008c6:	e8 d9 1b 00 00       	call   8024a4 <sys_rcr2>
  8008cb:	89 c1                	mov    %eax,%ecx
  8008cd:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008d0:	89 d0                	mov    %edx,%eax
  8008d2:	c1 e0 02             	shl    $0x2,%eax
  8008d5:	01 c2                	add    %eax,%edx
  8008d7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8008da:	c1 e0 02             	shl    $0x2,%eax
  8008dd:	01 d0                	add    %edx,%eax
  8008df:	89 c2                	mov    %eax,%edx
  8008e1:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8008e4:	01 d0                	add    %edx,%eax
  8008e6:	39 c1                	cmp    %eax,%ecx
  8008e8:	74 19                	je     800903 <_main+0x8cb>
  8008ea:	68 f4 2a 80 00       	push   $0x802af4
  8008ef:	68 5e 2a 80 00       	push   $0x802a5e
  8008f4:	68 bc 00 00 00       	push   $0xbc
  8008f9:	68 65 29 80 00       	push   $0x802965
  8008fe:	e8 c2 03 00 00       	call   800cc5 <_panic>

		ptr[6*Mega - kilo] = 10;
  800903:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800906:	89 d0                	mov    %edx,%eax
  800908:	01 c0                	add    %eax,%eax
  80090a:	01 d0                	add    %edx,%eax
  80090c:	01 c0                	add    %eax,%eax
  80090e:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800911:	89 c2                	mov    %eax,%edx
  800913:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800916:	01 d0                	add    %edx,%eax
  800918:	c6 00 0a             	movb   $0xa,(%eax)
		assert(sys_rcr2() == (uint32)&(ptr[6*Mega - kilo])) ;
  80091b:	e8 84 1b 00 00       	call   8024a4 <sys_rcr2>
  800920:	89 c1                	mov    %eax,%ecx
  800922:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800925:	89 d0                	mov    %edx,%eax
  800927:	01 c0                	add    %eax,%eax
  800929:	01 d0                	add    %edx,%eax
  80092b:	01 c0                	add    %eax,%eax
  80092d:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800930:	89 c2                	mov    %eax,%edx
  800932:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800935:	01 d0                	add    %edx,%eax
  800937:	39 c1                	cmp    %eax,%ecx
  800939:	74 19                	je     800954 <_main+0x91c>
  80093b:	68 20 2b 80 00       	push   $0x802b20
  800940:	68 5e 2a 80 00       	push   $0x802a5e
  800945:	68 bf 00 00 00       	push   $0xbf
  80094a:	68 65 29 80 00       	push   $0x802965
  80094f:	e8 71 03 00 00       	call   800cc5 <_panic>

		//set it to 0 again to cancel the bypassing option
		sys_bypassPageFault(0);
  800954:	83 ec 0c             	sub    $0xc,%esp
  800957:	6a 00                	push   $0x0
  800959:	e8 5f 1b 00 00       	call   8024bd <sys_bypassPageFault>
  80095e:	83 c4 10             	add    $0x10,%esp
	}

	cprintf("6/9\n");
  800961:	83 ec 0c             	sub    $0xc,%esp
  800964:	68 4c 2b 80 00       	push   $0x802b4c
  800969:	e8 f9 05 00 00       	call   800f67 <cprintf>
  80096e:	83 c4 10             	add    $0x10,%esp

	//Shrink it again to 2 MB instead of 5 MB
	{
		freeFrames = sys_calculate_free_frames() ;
  800971:	e8 30 18 00 00       	call   8021a6 <sys_calculate_free_frames>
  800976:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800979:	e8 ab 18 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  80097e:	89 45 bc             	mov    %eax,-0x44(%ebp)

		shrink(2*Mega) ;
  800981:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800984:	01 c0                	add    %eax,%eax
  800986:	83 ec 0c             	sub    $0xc,%esp
  800989:	50                   	push   %eax
  80098a:	e8 71 16 00 00       	call   802000 <shrink>
  80098f:	83 c4 10             	add    $0x10,%esp

		assert(usedDiskPages - sys_pf_calculate_allocated_pages() == 768) ;
  800992:	e8 92 18 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  800997:	8b 55 bc             	mov    -0x44(%ebp),%edx
  80099a:	29 c2                	sub    %eax,%edx
  80099c:	89 d0                	mov    %edx,%eax
  80099e:	3d 00 03 00 00       	cmp    $0x300,%eax
  8009a3:	74 19                	je     8009be <_main+0x986>
  8009a5:	68 54 2b 80 00       	push   $0x802b54
  8009aa:	68 5e 2a 80 00       	push   $0x802a5e
  8009af:	68 ce 00 00 00       	push   $0xce
  8009b4:	68 65 29 80 00       	push   $0x802965
  8009b9:	e8 07 03 00 00       	call   800cc5 <_panic>
		assert(sys_calculate_free_frames() - freeFrames == expectedNumOfFrames2 + 1 /*table*/) ;
  8009be:	e8 e3 17 00 00       	call   8021a6 <sys_calculate_free_frames>
  8009c3:	89 c2                	mov    %eax,%edx
  8009c5:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8009c8:	29 c2                	sub    %eax,%edx
  8009ca:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009cd:	40                   	inc    %eax
  8009ce:	39 c2                	cmp    %eax,%edx
  8009d0:	74 19                	je     8009eb <_main+0x9b3>
  8009d2:	68 90 2b 80 00       	push   $0x802b90
  8009d7:	68 5e 2a 80 00       	push   $0x802a5e
  8009dc:	68 cf 00 00 00       	push   $0xcf
  8009e1:	68 65 29 80 00       	push   $0x802965
  8009e6:	e8 da 02 00 00       	call   800cc5 <_panic>
	}

	cprintf("7/9\n");
  8009eb:	83 ec 0c             	sub    $0xc,%esp
  8009ee:	68 d5 2b 80 00       	push   $0x802bd5
  8009f3:	e8 6f 05 00 00       	call   800f67 <cprintf>
  8009f8:	83 c4 10             	add    $0x10,%esp

	//Allocate after shrinking last var
	{
		//4 MB
		freeFrames = sys_calculate_free_frames() ;
  8009fb:	e8 a6 17 00 00       	call   8021a6 <sys_calculate_free_frames>
  800a00:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800a03:	e8 21 18 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  800a08:	89 45 bc             	mov    %eax,-0x44(%ebp)
		ptr_allocations[7] = malloc(4*Mega);
  800a0b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a0e:	c1 e0 02             	shl    $0x2,%eax
  800a11:	83 ec 0c             	sub    $0xc,%esp
  800a14:	50                   	push   %eax
  800a15:	e8 d7 12 00 00       	call   801cf1 <malloc>
  800a1a:	83 c4 10             	add    $0x10,%esp
  800a1d:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
		if ((uint32) ptr_allocations[7] != (USER_HEAP_START + 7*Mega + 16*kilo + 2*Mega)) panic("Wrong start address after shrink()... ");
  800a23:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  800a29:	89 c1                	mov    %eax,%ecx
  800a2b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a2e:	89 d0                	mov    %edx,%eax
  800a30:	01 c0                	add    %eax,%eax
  800a32:	01 d0                	add    %edx,%eax
  800a34:	01 c0                	add    %eax,%eax
  800a36:	01 d0                	add    %edx,%eax
  800a38:	89 c2                	mov    %eax,%edx
  800a3a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a3d:	c1 e0 04             	shl    $0x4,%eax
  800a40:	01 c2                	add    %eax,%edx
  800a42:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a45:	01 c0                	add    %eax,%eax
  800a47:	01 d0                	add    %edx,%eax
  800a49:	05 00 00 00 80       	add    $0x80000000,%eax
  800a4e:	39 c1                	cmp    %eax,%ecx
  800a50:	74 17                	je     800a69 <_main+0xa31>
  800a52:	83 ec 04             	sub    $0x4,%esp
  800a55:	68 dc 2b 80 00       	push   $0x802bdc
  800a5a:	68 da 00 00 00       	push   $0xda
  800a5f:	68 65 29 80 00       	push   $0x802965
  800a64:	e8 5c 02 00 00       	call   800cc5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 4*Mega/PAGE_SIZE ) panic("Extra or less pages are allocated in PageFile");
  800a69:	e8 bb 17 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  800a6e:	2b 45 bc             	sub    -0x44(%ebp),%eax
  800a71:	89 c2                	mov    %eax,%edx
  800a73:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a76:	c1 e0 02             	shl    $0x2,%eax
  800a79:	85 c0                	test   %eax,%eax
  800a7b:	79 05                	jns    800a82 <_main+0xa4a>
  800a7d:	05 ff 0f 00 00       	add    $0xfff,%eax
  800a82:	c1 f8 0c             	sar    $0xc,%eax
  800a85:	39 c2                	cmp    %eax,%edx
  800a87:	74 17                	je     800aa0 <_main+0xa68>
  800a89:	83 ec 04             	sub    $0x4,%esp
  800a8c:	68 78 29 80 00       	push   $0x802978
  800a91:	68 db 00 00 00       	push   $0xdb
  800a96:	68 65 29 80 00       	push   $0x802965
  800a9b:	e8 25 02 00 00       	call   800cc5 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800aa0:	e8 01 17 00 00       	call   8021a6 <sys_calculate_free_frames>
  800aa5:	89 c2                	mov    %eax,%edx
  800aa7:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800aaa:	39 c2                	cmp    %eax,%edx
  800aac:	74 17                	je     800ac5 <_main+0xa8d>
  800aae:	83 ec 04             	sub    $0x4,%esp
  800ab1:	68 a8 29 80 00       	push   $0x8029a8
  800ab6:	68 dc 00 00 00       	push   $0xdc
  800abb:	68 65 29 80 00       	push   $0x802965
  800ac0:	e8 00 02 00 00       	call   800cc5 <_panic>
	}

	cprintf("8/9\n");
  800ac5:	83 ec 0c             	sub    $0xc,%esp
  800ac8:	68 03 2c 80 00       	push   $0x802c03
  800acd:	e8 95 04 00 00       	call   800f67 <cprintf>
  800ad2:	83 c4 10             	add    $0x10,%esp

	//free the shrunk variable
	{
		//kfree 2 MB (shrunk)
		freeFrames = sys_calculate_free_frames() ;
  800ad5:	e8 cc 16 00 00       	call   8021a6 <sys_calculate_free_frames>
  800ada:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800add:	e8 47 17 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  800ae2:	89 45 bc             	mov    %eax,-0x44(%ebp)
		free(ptr_allocations[6]);
  800ae5:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  800aeb:	83 ec 0c             	sub    $0xc,%esp
  800aee:	50                   	push   %eax
  800aef:	e8 8e 13 00 00       	call   801e82 <free>
  800af4:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2*Mega/PAGE_SIZE ) panic("Extra or less pages are allocated in PageFile");
  800af7:	e8 2d 17 00 00       	call   802229 <sys_pf_calculate_allocated_pages>
  800afc:	8b 55 bc             	mov    -0x44(%ebp),%edx
  800aff:	29 c2                	sub    %eax,%edx
  800b01:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b04:	01 c0                	add    %eax,%eax
  800b06:	85 c0                	test   %eax,%eax
  800b08:	79 05                	jns    800b0f <_main+0xad7>
  800b0a:	05 ff 0f 00 00       	add    $0xfff,%eax
  800b0f:	c1 f8 0c             	sar    $0xc,%eax
  800b12:	39 c2                	cmp    %eax,%edx
  800b14:	74 17                	je     800b2d <_main+0xaf5>
  800b16:	83 ec 04             	sub    $0x4,%esp
  800b19:	68 78 29 80 00       	push   $0x802978
  800b1e:	68 e7 00 00 00       	push   $0xe7
  800b23:	68 65 29 80 00       	push   $0x802965
  800b28:	e8 98 01 00 00       	call   800cc5 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != expectedNumOfFrames3 + 1 /*table*/) panic("Wrong kfree: attempt to kfree a non-existing ptr. It should do nothing");
  800b2d:	e8 74 16 00 00       	call   8021a6 <sys_calculate_free_frames>
  800b32:	89 c2                	mov    %eax,%edx
  800b34:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800b37:	29 c2                	sub    %eax,%edx
  800b39:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b3c:	40                   	inc    %eax
  800b3d:	39 c2                	cmp    %eax,%edx
  800b3f:	74 17                	je     800b58 <_main+0xb20>
  800b41:	83 ec 04             	sub    $0x4,%esp
  800b44:	68 08 2c 80 00       	push   $0x802c08
  800b49:	68 e8 00 00 00       	push   $0xe8
  800b4e:	68 65 29 80 00       	push   $0x802965
  800b53:	e8 6d 01 00 00       	call   800cc5 <_panic>
//		shrink(4*Mega - 20*kilo) ;
//
//		assert(usedDiskPages  - sys_pf_calculate_allocated_pages() == 5) ;
//		assert(sys_calculate_free_frames() - freeFrames == 0) ;
//	}
	cprintf("9/9\n");
  800b58:	83 ec 0c             	sub    $0xc,%esp
  800b5b:	68 4f 2c 80 00       	push   $0x802c4f
  800b60:	e8 02 04 00 00       	call   800f67 <cprintf>
  800b65:	83 c4 10             	add    $0x10,%esp

	cprintf("\nCongratulations!! your modification is run successfully.\n");
  800b68:	83 ec 0c             	sub    $0xc,%esp
  800b6b:	68 54 2c 80 00       	push   $0x802c54
  800b70:	e8 f2 03 00 00       	call   800f67 <cprintf>
  800b75:	83 c4 10             	add    $0x10,%esp
}
  800b78:	90                   	nop
  800b79:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b7c:	5b                   	pop    %ebx
  800b7d:	5f                   	pop    %edi
  800b7e:	5d                   	pop    %ebp
  800b7f:	c3                   	ret    

00800b80 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800b80:	55                   	push   %ebp
  800b81:	89 e5                	mov    %esp,%ebp
  800b83:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800b86:	e8 50 15 00 00       	call   8020db <sys_getenvindex>
  800b8b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800b8e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b91:	89 d0                	mov    %edx,%eax
  800b93:	c1 e0 03             	shl    $0x3,%eax
  800b96:	01 d0                	add    %edx,%eax
  800b98:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800b9f:	01 c8                	add    %ecx,%eax
  800ba1:	01 c0                	add    %eax,%eax
  800ba3:	01 d0                	add    %edx,%eax
  800ba5:	01 c0                	add    %eax,%eax
  800ba7:	01 d0                	add    %edx,%eax
  800ba9:	89 c2                	mov    %eax,%edx
  800bab:	c1 e2 05             	shl    $0x5,%edx
  800bae:	29 c2                	sub    %eax,%edx
  800bb0:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800bb7:	89 c2                	mov    %eax,%edx
  800bb9:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800bbf:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800bc4:	a1 20 40 80 00       	mov    0x804020,%eax
  800bc9:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800bcf:	84 c0                	test   %al,%al
  800bd1:	74 0f                	je     800be2 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800bd3:	a1 20 40 80 00       	mov    0x804020,%eax
  800bd8:	05 40 3c 01 00       	add    $0x13c40,%eax
  800bdd:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800be2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800be6:	7e 0a                	jle    800bf2 <libmain+0x72>
		binaryname = argv[0];
  800be8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800beb:	8b 00                	mov    (%eax),%eax
  800bed:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  800bf2:	83 ec 08             	sub    $0x8,%esp
  800bf5:	ff 75 0c             	pushl  0xc(%ebp)
  800bf8:	ff 75 08             	pushl  0x8(%ebp)
  800bfb:	e8 38 f4 ff ff       	call   800038 <_main>
  800c00:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800c03:	e8 6e 16 00 00       	call   802276 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800c08:	83 ec 0c             	sub    $0xc,%esp
  800c0b:	68 a8 2c 80 00       	push   $0x802ca8
  800c10:	e8 52 03 00 00       	call   800f67 <cprintf>
  800c15:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800c18:	a1 20 40 80 00       	mov    0x804020,%eax
  800c1d:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800c23:	a1 20 40 80 00       	mov    0x804020,%eax
  800c28:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800c2e:	83 ec 04             	sub    $0x4,%esp
  800c31:	52                   	push   %edx
  800c32:	50                   	push   %eax
  800c33:	68 d0 2c 80 00       	push   $0x802cd0
  800c38:	e8 2a 03 00 00       	call   800f67 <cprintf>
  800c3d:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800c40:	a1 20 40 80 00       	mov    0x804020,%eax
  800c45:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800c4b:	a1 20 40 80 00       	mov    0x804020,%eax
  800c50:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800c56:	83 ec 04             	sub    $0x4,%esp
  800c59:	52                   	push   %edx
  800c5a:	50                   	push   %eax
  800c5b:	68 f8 2c 80 00       	push   $0x802cf8
  800c60:	e8 02 03 00 00       	call   800f67 <cprintf>
  800c65:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800c68:	a1 20 40 80 00       	mov    0x804020,%eax
  800c6d:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800c73:	83 ec 08             	sub    $0x8,%esp
  800c76:	50                   	push   %eax
  800c77:	68 39 2d 80 00       	push   $0x802d39
  800c7c:	e8 e6 02 00 00       	call   800f67 <cprintf>
  800c81:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800c84:	83 ec 0c             	sub    $0xc,%esp
  800c87:	68 a8 2c 80 00       	push   $0x802ca8
  800c8c:	e8 d6 02 00 00       	call   800f67 <cprintf>
  800c91:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800c94:	e8 f7 15 00 00       	call   802290 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800c99:	e8 19 00 00 00       	call   800cb7 <exit>
}
  800c9e:	90                   	nop
  800c9f:	c9                   	leave  
  800ca0:	c3                   	ret    

00800ca1 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800ca1:	55                   	push   %ebp
  800ca2:	89 e5                	mov    %esp,%ebp
  800ca4:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800ca7:	83 ec 0c             	sub    $0xc,%esp
  800caa:	6a 00                	push   $0x0
  800cac:	e8 f6 13 00 00       	call   8020a7 <sys_env_destroy>
  800cb1:	83 c4 10             	add    $0x10,%esp
}
  800cb4:	90                   	nop
  800cb5:	c9                   	leave  
  800cb6:	c3                   	ret    

00800cb7 <exit>:

void
exit(void)
{
  800cb7:	55                   	push   %ebp
  800cb8:	89 e5                	mov    %esp,%ebp
  800cba:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800cbd:	e8 4b 14 00 00       	call   80210d <sys_env_exit>
}
  800cc2:	90                   	nop
  800cc3:	c9                   	leave  
  800cc4:	c3                   	ret    

00800cc5 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800cc5:	55                   	push   %ebp
  800cc6:	89 e5                	mov    %esp,%ebp
  800cc8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800ccb:	8d 45 10             	lea    0x10(%ebp),%eax
  800cce:	83 c0 04             	add    $0x4,%eax
  800cd1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800cd4:	a1 18 41 80 00       	mov    0x804118,%eax
  800cd9:	85 c0                	test   %eax,%eax
  800cdb:	74 16                	je     800cf3 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800cdd:	a1 18 41 80 00       	mov    0x804118,%eax
  800ce2:	83 ec 08             	sub    $0x8,%esp
  800ce5:	50                   	push   %eax
  800ce6:	68 50 2d 80 00       	push   $0x802d50
  800ceb:	e8 77 02 00 00       	call   800f67 <cprintf>
  800cf0:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800cf3:	a1 00 40 80 00       	mov    0x804000,%eax
  800cf8:	ff 75 0c             	pushl  0xc(%ebp)
  800cfb:	ff 75 08             	pushl  0x8(%ebp)
  800cfe:	50                   	push   %eax
  800cff:	68 55 2d 80 00       	push   $0x802d55
  800d04:	e8 5e 02 00 00       	call   800f67 <cprintf>
  800d09:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800d0c:	8b 45 10             	mov    0x10(%ebp),%eax
  800d0f:	83 ec 08             	sub    $0x8,%esp
  800d12:	ff 75 f4             	pushl  -0xc(%ebp)
  800d15:	50                   	push   %eax
  800d16:	e8 e1 01 00 00       	call   800efc <vcprintf>
  800d1b:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800d1e:	83 ec 08             	sub    $0x8,%esp
  800d21:	6a 00                	push   $0x0
  800d23:	68 71 2d 80 00       	push   $0x802d71
  800d28:	e8 cf 01 00 00       	call   800efc <vcprintf>
  800d2d:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800d30:	e8 82 ff ff ff       	call   800cb7 <exit>

	// should not return here
	while (1) ;
  800d35:	eb fe                	jmp    800d35 <_panic+0x70>

00800d37 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800d37:	55                   	push   %ebp
  800d38:	89 e5                	mov    %esp,%ebp
  800d3a:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800d3d:	a1 20 40 80 00       	mov    0x804020,%eax
  800d42:	8b 50 74             	mov    0x74(%eax),%edx
  800d45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d48:	39 c2                	cmp    %eax,%edx
  800d4a:	74 14                	je     800d60 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800d4c:	83 ec 04             	sub    $0x4,%esp
  800d4f:	68 74 2d 80 00       	push   $0x802d74
  800d54:	6a 26                	push   $0x26
  800d56:	68 c0 2d 80 00       	push   $0x802dc0
  800d5b:	e8 65 ff ff ff       	call   800cc5 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800d60:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800d67:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800d6e:	e9 b6 00 00 00       	jmp    800e29 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800d73:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d76:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800d7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d80:	01 d0                	add    %edx,%eax
  800d82:	8b 00                	mov    (%eax),%eax
  800d84:	85 c0                	test   %eax,%eax
  800d86:	75 08                	jne    800d90 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800d88:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800d8b:	e9 96 00 00 00       	jmp    800e26 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800d90:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800d97:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800d9e:	eb 5d                	jmp    800dfd <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800da0:	a1 20 40 80 00       	mov    0x804020,%eax
  800da5:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800dab:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800dae:	c1 e2 04             	shl    $0x4,%edx
  800db1:	01 d0                	add    %edx,%eax
  800db3:	8a 40 04             	mov    0x4(%eax),%al
  800db6:	84 c0                	test   %al,%al
  800db8:	75 40                	jne    800dfa <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800dba:	a1 20 40 80 00       	mov    0x804020,%eax
  800dbf:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800dc5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800dc8:	c1 e2 04             	shl    $0x4,%edx
  800dcb:	01 d0                	add    %edx,%eax
  800dcd:	8b 00                	mov    (%eax),%eax
  800dcf:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800dd2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800dd5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800dda:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800ddc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ddf:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800de6:	8b 45 08             	mov    0x8(%ebp),%eax
  800de9:	01 c8                	add    %ecx,%eax
  800deb:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800ded:	39 c2                	cmp    %eax,%edx
  800def:	75 09                	jne    800dfa <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800df1:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800df8:	eb 12                	jmp    800e0c <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800dfa:	ff 45 e8             	incl   -0x18(%ebp)
  800dfd:	a1 20 40 80 00       	mov    0x804020,%eax
  800e02:	8b 50 74             	mov    0x74(%eax),%edx
  800e05:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800e08:	39 c2                	cmp    %eax,%edx
  800e0a:	77 94                	ja     800da0 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800e0c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800e10:	75 14                	jne    800e26 <CheckWSWithoutLastIndex+0xef>
			panic(
  800e12:	83 ec 04             	sub    $0x4,%esp
  800e15:	68 cc 2d 80 00       	push   $0x802dcc
  800e1a:	6a 3a                	push   $0x3a
  800e1c:	68 c0 2d 80 00       	push   $0x802dc0
  800e21:	e8 9f fe ff ff       	call   800cc5 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800e26:	ff 45 f0             	incl   -0x10(%ebp)
  800e29:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e2c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800e2f:	0f 8c 3e ff ff ff    	jl     800d73 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800e35:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800e3c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800e43:	eb 20                	jmp    800e65 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800e45:	a1 20 40 80 00       	mov    0x804020,%eax
  800e4a:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800e50:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e53:	c1 e2 04             	shl    $0x4,%edx
  800e56:	01 d0                	add    %edx,%eax
  800e58:	8a 40 04             	mov    0x4(%eax),%al
  800e5b:	3c 01                	cmp    $0x1,%al
  800e5d:	75 03                	jne    800e62 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800e5f:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800e62:	ff 45 e0             	incl   -0x20(%ebp)
  800e65:	a1 20 40 80 00       	mov    0x804020,%eax
  800e6a:	8b 50 74             	mov    0x74(%eax),%edx
  800e6d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e70:	39 c2                	cmp    %eax,%edx
  800e72:	77 d1                	ja     800e45 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800e74:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e77:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800e7a:	74 14                	je     800e90 <CheckWSWithoutLastIndex+0x159>
		panic(
  800e7c:	83 ec 04             	sub    $0x4,%esp
  800e7f:	68 20 2e 80 00       	push   $0x802e20
  800e84:	6a 44                	push   $0x44
  800e86:	68 c0 2d 80 00       	push   $0x802dc0
  800e8b:	e8 35 fe ff ff       	call   800cc5 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800e90:	90                   	nop
  800e91:	c9                   	leave  
  800e92:	c3                   	ret    

00800e93 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800e93:	55                   	push   %ebp
  800e94:	89 e5                	mov    %esp,%ebp
  800e96:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800e99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9c:	8b 00                	mov    (%eax),%eax
  800e9e:	8d 48 01             	lea    0x1(%eax),%ecx
  800ea1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ea4:	89 0a                	mov    %ecx,(%edx)
  800ea6:	8b 55 08             	mov    0x8(%ebp),%edx
  800ea9:	88 d1                	mov    %dl,%cl
  800eab:	8b 55 0c             	mov    0xc(%ebp),%edx
  800eae:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800eb2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb5:	8b 00                	mov    (%eax),%eax
  800eb7:	3d ff 00 00 00       	cmp    $0xff,%eax
  800ebc:	75 2c                	jne    800eea <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800ebe:	a0 24 40 80 00       	mov    0x804024,%al
  800ec3:	0f b6 c0             	movzbl %al,%eax
  800ec6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ec9:	8b 12                	mov    (%edx),%edx
  800ecb:	89 d1                	mov    %edx,%ecx
  800ecd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ed0:	83 c2 08             	add    $0x8,%edx
  800ed3:	83 ec 04             	sub    $0x4,%esp
  800ed6:	50                   	push   %eax
  800ed7:	51                   	push   %ecx
  800ed8:	52                   	push   %edx
  800ed9:	e8 87 11 00 00       	call   802065 <sys_cputs>
  800ede:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800ee1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ee4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800eea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eed:	8b 40 04             	mov    0x4(%eax),%eax
  800ef0:	8d 50 01             	lea    0x1(%eax),%edx
  800ef3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef6:	89 50 04             	mov    %edx,0x4(%eax)
}
  800ef9:	90                   	nop
  800efa:	c9                   	leave  
  800efb:	c3                   	ret    

00800efc <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800efc:	55                   	push   %ebp
  800efd:	89 e5                	mov    %esp,%ebp
  800eff:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800f05:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800f0c:	00 00 00 
	b.cnt = 0;
  800f0f:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800f16:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800f19:	ff 75 0c             	pushl  0xc(%ebp)
  800f1c:	ff 75 08             	pushl  0x8(%ebp)
  800f1f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800f25:	50                   	push   %eax
  800f26:	68 93 0e 80 00       	push   $0x800e93
  800f2b:	e8 11 02 00 00       	call   801141 <vprintfmt>
  800f30:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800f33:	a0 24 40 80 00       	mov    0x804024,%al
  800f38:	0f b6 c0             	movzbl %al,%eax
  800f3b:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800f41:	83 ec 04             	sub    $0x4,%esp
  800f44:	50                   	push   %eax
  800f45:	52                   	push   %edx
  800f46:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800f4c:	83 c0 08             	add    $0x8,%eax
  800f4f:	50                   	push   %eax
  800f50:	e8 10 11 00 00       	call   802065 <sys_cputs>
  800f55:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800f58:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  800f5f:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800f65:	c9                   	leave  
  800f66:	c3                   	ret    

00800f67 <cprintf>:

int cprintf(const char *fmt, ...) {
  800f67:	55                   	push   %ebp
  800f68:	89 e5                	mov    %esp,%ebp
  800f6a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800f6d:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  800f74:	8d 45 0c             	lea    0xc(%ebp),%eax
  800f77:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800f7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7d:	83 ec 08             	sub    $0x8,%esp
  800f80:	ff 75 f4             	pushl  -0xc(%ebp)
  800f83:	50                   	push   %eax
  800f84:	e8 73 ff ff ff       	call   800efc <vcprintf>
  800f89:	83 c4 10             	add    $0x10,%esp
  800f8c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800f8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800f92:	c9                   	leave  
  800f93:	c3                   	ret    

00800f94 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800f94:	55                   	push   %ebp
  800f95:	89 e5                	mov    %esp,%ebp
  800f97:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800f9a:	e8 d7 12 00 00       	call   802276 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800f9f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800fa2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800fa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa8:	83 ec 08             	sub    $0x8,%esp
  800fab:	ff 75 f4             	pushl  -0xc(%ebp)
  800fae:	50                   	push   %eax
  800faf:	e8 48 ff ff ff       	call   800efc <vcprintf>
  800fb4:	83 c4 10             	add    $0x10,%esp
  800fb7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800fba:	e8 d1 12 00 00       	call   802290 <sys_enable_interrupt>
	return cnt;
  800fbf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800fc2:	c9                   	leave  
  800fc3:	c3                   	ret    

00800fc4 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800fc4:	55                   	push   %ebp
  800fc5:	89 e5                	mov    %esp,%ebp
  800fc7:	53                   	push   %ebx
  800fc8:	83 ec 14             	sub    $0x14,%esp
  800fcb:	8b 45 10             	mov    0x10(%ebp),%eax
  800fce:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fd1:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800fd7:	8b 45 18             	mov    0x18(%ebp),%eax
  800fda:	ba 00 00 00 00       	mov    $0x0,%edx
  800fdf:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800fe2:	77 55                	ja     801039 <printnum+0x75>
  800fe4:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800fe7:	72 05                	jb     800fee <printnum+0x2a>
  800fe9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fec:	77 4b                	ja     801039 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800fee:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800ff1:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800ff4:	8b 45 18             	mov    0x18(%ebp),%eax
  800ff7:	ba 00 00 00 00       	mov    $0x0,%edx
  800ffc:	52                   	push   %edx
  800ffd:	50                   	push   %eax
  800ffe:	ff 75 f4             	pushl  -0xc(%ebp)
  801001:	ff 75 f0             	pushl  -0x10(%ebp)
  801004:	e8 8f 16 00 00       	call   802698 <__udivdi3>
  801009:	83 c4 10             	add    $0x10,%esp
  80100c:	83 ec 04             	sub    $0x4,%esp
  80100f:	ff 75 20             	pushl  0x20(%ebp)
  801012:	53                   	push   %ebx
  801013:	ff 75 18             	pushl  0x18(%ebp)
  801016:	52                   	push   %edx
  801017:	50                   	push   %eax
  801018:	ff 75 0c             	pushl  0xc(%ebp)
  80101b:	ff 75 08             	pushl  0x8(%ebp)
  80101e:	e8 a1 ff ff ff       	call   800fc4 <printnum>
  801023:	83 c4 20             	add    $0x20,%esp
  801026:	eb 1a                	jmp    801042 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  801028:	83 ec 08             	sub    $0x8,%esp
  80102b:	ff 75 0c             	pushl  0xc(%ebp)
  80102e:	ff 75 20             	pushl  0x20(%ebp)
  801031:	8b 45 08             	mov    0x8(%ebp),%eax
  801034:	ff d0                	call   *%eax
  801036:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801039:	ff 4d 1c             	decl   0x1c(%ebp)
  80103c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  801040:	7f e6                	jg     801028 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801042:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801045:	bb 00 00 00 00       	mov    $0x0,%ebx
  80104a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80104d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801050:	53                   	push   %ebx
  801051:	51                   	push   %ecx
  801052:	52                   	push   %edx
  801053:	50                   	push   %eax
  801054:	e8 4f 17 00 00       	call   8027a8 <__umoddi3>
  801059:	83 c4 10             	add    $0x10,%esp
  80105c:	05 94 30 80 00       	add    $0x803094,%eax
  801061:	8a 00                	mov    (%eax),%al
  801063:	0f be c0             	movsbl %al,%eax
  801066:	83 ec 08             	sub    $0x8,%esp
  801069:	ff 75 0c             	pushl  0xc(%ebp)
  80106c:	50                   	push   %eax
  80106d:	8b 45 08             	mov    0x8(%ebp),%eax
  801070:	ff d0                	call   *%eax
  801072:	83 c4 10             	add    $0x10,%esp
}
  801075:	90                   	nop
  801076:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801079:	c9                   	leave  
  80107a:	c3                   	ret    

0080107b <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80107b:	55                   	push   %ebp
  80107c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80107e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801082:	7e 1c                	jle    8010a0 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801084:	8b 45 08             	mov    0x8(%ebp),%eax
  801087:	8b 00                	mov    (%eax),%eax
  801089:	8d 50 08             	lea    0x8(%eax),%edx
  80108c:	8b 45 08             	mov    0x8(%ebp),%eax
  80108f:	89 10                	mov    %edx,(%eax)
  801091:	8b 45 08             	mov    0x8(%ebp),%eax
  801094:	8b 00                	mov    (%eax),%eax
  801096:	83 e8 08             	sub    $0x8,%eax
  801099:	8b 50 04             	mov    0x4(%eax),%edx
  80109c:	8b 00                	mov    (%eax),%eax
  80109e:	eb 40                	jmp    8010e0 <getuint+0x65>
	else if (lflag)
  8010a0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010a4:	74 1e                	je     8010c4 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8010a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a9:	8b 00                	mov    (%eax),%eax
  8010ab:	8d 50 04             	lea    0x4(%eax),%edx
  8010ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b1:	89 10                	mov    %edx,(%eax)
  8010b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b6:	8b 00                	mov    (%eax),%eax
  8010b8:	83 e8 04             	sub    $0x4,%eax
  8010bb:	8b 00                	mov    (%eax),%eax
  8010bd:	ba 00 00 00 00       	mov    $0x0,%edx
  8010c2:	eb 1c                	jmp    8010e0 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8010c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c7:	8b 00                	mov    (%eax),%eax
  8010c9:	8d 50 04             	lea    0x4(%eax),%edx
  8010cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cf:	89 10                	mov    %edx,(%eax)
  8010d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d4:	8b 00                	mov    (%eax),%eax
  8010d6:	83 e8 04             	sub    $0x4,%eax
  8010d9:	8b 00                	mov    (%eax),%eax
  8010db:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8010e0:	5d                   	pop    %ebp
  8010e1:	c3                   	ret    

008010e2 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8010e2:	55                   	push   %ebp
  8010e3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8010e5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8010e9:	7e 1c                	jle    801107 <getint+0x25>
		return va_arg(*ap, long long);
  8010eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ee:	8b 00                	mov    (%eax),%eax
  8010f0:	8d 50 08             	lea    0x8(%eax),%edx
  8010f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f6:	89 10                	mov    %edx,(%eax)
  8010f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fb:	8b 00                	mov    (%eax),%eax
  8010fd:	83 e8 08             	sub    $0x8,%eax
  801100:	8b 50 04             	mov    0x4(%eax),%edx
  801103:	8b 00                	mov    (%eax),%eax
  801105:	eb 38                	jmp    80113f <getint+0x5d>
	else if (lflag)
  801107:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80110b:	74 1a                	je     801127 <getint+0x45>
		return va_arg(*ap, long);
  80110d:	8b 45 08             	mov    0x8(%ebp),%eax
  801110:	8b 00                	mov    (%eax),%eax
  801112:	8d 50 04             	lea    0x4(%eax),%edx
  801115:	8b 45 08             	mov    0x8(%ebp),%eax
  801118:	89 10                	mov    %edx,(%eax)
  80111a:	8b 45 08             	mov    0x8(%ebp),%eax
  80111d:	8b 00                	mov    (%eax),%eax
  80111f:	83 e8 04             	sub    $0x4,%eax
  801122:	8b 00                	mov    (%eax),%eax
  801124:	99                   	cltd   
  801125:	eb 18                	jmp    80113f <getint+0x5d>
	else
		return va_arg(*ap, int);
  801127:	8b 45 08             	mov    0x8(%ebp),%eax
  80112a:	8b 00                	mov    (%eax),%eax
  80112c:	8d 50 04             	lea    0x4(%eax),%edx
  80112f:	8b 45 08             	mov    0x8(%ebp),%eax
  801132:	89 10                	mov    %edx,(%eax)
  801134:	8b 45 08             	mov    0x8(%ebp),%eax
  801137:	8b 00                	mov    (%eax),%eax
  801139:	83 e8 04             	sub    $0x4,%eax
  80113c:	8b 00                	mov    (%eax),%eax
  80113e:	99                   	cltd   
}
  80113f:	5d                   	pop    %ebp
  801140:	c3                   	ret    

00801141 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801141:	55                   	push   %ebp
  801142:	89 e5                	mov    %esp,%ebp
  801144:	56                   	push   %esi
  801145:	53                   	push   %ebx
  801146:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801149:	eb 17                	jmp    801162 <vprintfmt+0x21>
			if (ch == '\0')
  80114b:	85 db                	test   %ebx,%ebx
  80114d:	0f 84 af 03 00 00    	je     801502 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801153:	83 ec 08             	sub    $0x8,%esp
  801156:	ff 75 0c             	pushl  0xc(%ebp)
  801159:	53                   	push   %ebx
  80115a:	8b 45 08             	mov    0x8(%ebp),%eax
  80115d:	ff d0                	call   *%eax
  80115f:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801162:	8b 45 10             	mov    0x10(%ebp),%eax
  801165:	8d 50 01             	lea    0x1(%eax),%edx
  801168:	89 55 10             	mov    %edx,0x10(%ebp)
  80116b:	8a 00                	mov    (%eax),%al
  80116d:	0f b6 d8             	movzbl %al,%ebx
  801170:	83 fb 25             	cmp    $0x25,%ebx
  801173:	75 d6                	jne    80114b <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801175:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  801179:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801180:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801187:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80118e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801195:	8b 45 10             	mov    0x10(%ebp),%eax
  801198:	8d 50 01             	lea    0x1(%eax),%edx
  80119b:	89 55 10             	mov    %edx,0x10(%ebp)
  80119e:	8a 00                	mov    (%eax),%al
  8011a0:	0f b6 d8             	movzbl %al,%ebx
  8011a3:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8011a6:	83 f8 55             	cmp    $0x55,%eax
  8011a9:	0f 87 2b 03 00 00    	ja     8014da <vprintfmt+0x399>
  8011af:	8b 04 85 b8 30 80 00 	mov    0x8030b8(,%eax,4),%eax
  8011b6:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8011b8:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8011bc:	eb d7                	jmp    801195 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8011be:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8011c2:	eb d1                	jmp    801195 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8011c4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8011cb:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8011ce:	89 d0                	mov    %edx,%eax
  8011d0:	c1 e0 02             	shl    $0x2,%eax
  8011d3:	01 d0                	add    %edx,%eax
  8011d5:	01 c0                	add    %eax,%eax
  8011d7:	01 d8                	add    %ebx,%eax
  8011d9:	83 e8 30             	sub    $0x30,%eax
  8011dc:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8011df:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e2:	8a 00                	mov    (%eax),%al
  8011e4:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8011e7:	83 fb 2f             	cmp    $0x2f,%ebx
  8011ea:	7e 3e                	jle    80122a <vprintfmt+0xe9>
  8011ec:	83 fb 39             	cmp    $0x39,%ebx
  8011ef:	7f 39                	jg     80122a <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8011f1:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8011f4:	eb d5                	jmp    8011cb <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8011f6:	8b 45 14             	mov    0x14(%ebp),%eax
  8011f9:	83 c0 04             	add    $0x4,%eax
  8011fc:	89 45 14             	mov    %eax,0x14(%ebp)
  8011ff:	8b 45 14             	mov    0x14(%ebp),%eax
  801202:	83 e8 04             	sub    $0x4,%eax
  801205:	8b 00                	mov    (%eax),%eax
  801207:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80120a:	eb 1f                	jmp    80122b <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80120c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801210:	79 83                	jns    801195 <vprintfmt+0x54>
				width = 0;
  801212:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801219:	e9 77 ff ff ff       	jmp    801195 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80121e:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801225:	e9 6b ff ff ff       	jmp    801195 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80122a:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80122b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80122f:	0f 89 60 ff ff ff    	jns    801195 <vprintfmt+0x54>
				width = precision, precision = -1;
  801235:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801238:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80123b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801242:	e9 4e ff ff ff       	jmp    801195 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801247:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80124a:	e9 46 ff ff ff       	jmp    801195 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80124f:	8b 45 14             	mov    0x14(%ebp),%eax
  801252:	83 c0 04             	add    $0x4,%eax
  801255:	89 45 14             	mov    %eax,0x14(%ebp)
  801258:	8b 45 14             	mov    0x14(%ebp),%eax
  80125b:	83 e8 04             	sub    $0x4,%eax
  80125e:	8b 00                	mov    (%eax),%eax
  801260:	83 ec 08             	sub    $0x8,%esp
  801263:	ff 75 0c             	pushl  0xc(%ebp)
  801266:	50                   	push   %eax
  801267:	8b 45 08             	mov    0x8(%ebp),%eax
  80126a:	ff d0                	call   *%eax
  80126c:	83 c4 10             	add    $0x10,%esp
			break;
  80126f:	e9 89 02 00 00       	jmp    8014fd <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801274:	8b 45 14             	mov    0x14(%ebp),%eax
  801277:	83 c0 04             	add    $0x4,%eax
  80127a:	89 45 14             	mov    %eax,0x14(%ebp)
  80127d:	8b 45 14             	mov    0x14(%ebp),%eax
  801280:	83 e8 04             	sub    $0x4,%eax
  801283:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801285:	85 db                	test   %ebx,%ebx
  801287:	79 02                	jns    80128b <vprintfmt+0x14a>
				err = -err;
  801289:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80128b:	83 fb 64             	cmp    $0x64,%ebx
  80128e:	7f 0b                	jg     80129b <vprintfmt+0x15a>
  801290:	8b 34 9d 00 2f 80 00 	mov    0x802f00(,%ebx,4),%esi
  801297:	85 f6                	test   %esi,%esi
  801299:	75 19                	jne    8012b4 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80129b:	53                   	push   %ebx
  80129c:	68 a5 30 80 00       	push   $0x8030a5
  8012a1:	ff 75 0c             	pushl  0xc(%ebp)
  8012a4:	ff 75 08             	pushl  0x8(%ebp)
  8012a7:	e8 5e 02 00 00       	call   80150a <printfmt>
  8012ac:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8012af:	e9 49 02 00 00       	jmp    8014fd <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8012b4:	56                   	push   %esi
  8012b5:	68 ae 30 80 00       	push   $0x8030ae
  8012ba:	ff 75 0c             	pushl  0xc(%ebp)
  8012bd:	ff 75 08             	pushl  0x8(%ebp)
  8012c0:	e8 45 02 00 00       	call   80150a <printfmt>
  8012c5:	83 c4 10             	add    $0x10,%esp
			break;
  8012c8:	e9 30 02 00 00       	jmp    8014fd <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8012cd:	8b 45 14             	mov    0x14(%ebp),%eax
  8012d0:	83 c0 04             	add    $0x4,%eax
  8012d3:	89 45 14             	mov    %eax,0x14(%ebp)
  8012d6:	8b 45 14             	mov    0x14(%ebp),%eax
  8012d9:	83 e8 04             	sub    $0x4,%eax
  8012dc:	8b 30                	mov    (%eax),%esi
  8012de:	85 f6                	test   %esi,%esi
  8012e0:	75 05                	jne    8012e7 <vprintfmt+0x1a6>
				p = "(null)";
  8012e2:	be b1 30 80 00       	mov    $0x8030b1,%esi
			if (width > 0 && padc != '-')
  8012e7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8012eb:	7e 6d                	jle    80135a <vprintfmt+0x219>
  8012ed:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8012f1:	74 67                	je     80135a <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8012f3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8012f6:	83 ec 08             	sub    $0x8,%esp
  8012f9:	50                   	push   %eax
  8012fa:	56                   	push   %esi
  8012fb:	e8 0c 03 00 00       	call   80160c <strnlen>
  801300:	83 c4 10             	add    $0x10,%esp
  801303:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801306:	eb 16                	jmp    80131e <vprintfmt+0x1dd>
					putch(padc, putdat);
  801308:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80130c:	83 ec 08             	sub    $0x8,%esp
  80130f:	ff 75 0c             	pushl  0xc(%ebp)
  801312:	50                   	push   %eax
  801313:	8b 45 08             	mov    0x8(%ebp),%eax
  801316:	ff d0                	call   *%eax
  801318:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80131b:	ff 4d e4             	decl   -0x1c(%ebp)
  80131e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801322:	7f e4                	jg     801308 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801324:	eb 34                	jmp    80135a <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801326:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80132a:	74 1c                	je     801348 <vprintfmt+0x207>
  80132c:	83 fb 1f             	cmp    $0x1f,%ebx
  80132f:	7e 05                	jle    801336 <vprintfmt+0x1f5>
  801331:	83 fb 7e             	cmp    $0x7e,%ebx
  801334:	7e 12                	jle    801348 <vprintfmt+0x207>
					putch('?', putdat);
  801336:	83 ec 08             	sub    $0x8,%esp
  801339:	ff 75 0c             	pushl  0xc(%ebp)
  80133c:	6a 3f                	push   $0x3f
  80133e:	8b 45 08             	mov    0x8(%ebp),%eax
  801341:	ff d0                	call   *%eax
  801343:	83 c4 10             	add    $0x10,%esp
  801346:	eb 0f                	jmp    801357 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801348:	83 ec 08             	sub    $0x8,%esp
  80134b:	ff 75 0c             	pushl  0xc(%ebp)
  80134e:	53                   	push   %ebx
  80134f:	8b 45 08             	mov    0x8(%ebp),%eax
  801352:	ff d0                	call   *%eax
  801354:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801357:	ff 4d e4             	decl   -0x1c(%ebp)
  80135a:	89 f0                	mov    %esi,%eax
  80135c:	8d 70 01             	lea    0x1(%eax),%esi
  80135f:	8a 00                	mov    (%eax),%al
  801361:	0f be d8             	movsbl %al,%ebx
  801364:	85 db                	test   %ebx,%ebx
  801366:	74 24                	je     80138c <vprintfmt+0x24b>
  801368:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80136c:	78 b8                	js     801326 <vprintfmt+0x1e5>
  80136e:	ff 4d e0             	decl   -0x20(%ebp)
  801371:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801375:	79 af                	jns    801326 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801377:	eb 13                	jmp    80138c <vprintfmt+0x24b>
				putch(' ', putdat);
  801379:	83 ec 08             	sub    $0x8,%esp
  80137c:	ff 75 0c             	pushl  0xc(%ebp)
  80137f:	6a 20                	push   $0x20
  801381:	8b 45 08             	mov    0x8(%ebp),%eax
  801384:	ff d0                	call   *%eax
  801386:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801389:	ff 4d e4             	decl   -0x1c(%ebp)
  80138c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801390:	7f e7                	jg     801379 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801392:	e9 66 01 00 00       	jmp    8014fd <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801397:	83 ec 08             	sub    $0x8,%esp
  80139a:	ff 75 e8             	pushl  -0x18(%ebp)
  80139d:	8d 45 14             	lea    0x14(%ebp),%eax
  8013a0:	50                   	push   %eax
  8013a1:	e8 3c fd ff ff       	call   8010e2 <getint>
  8013a6:	83 c4 10             	add    $0x10,%esp
  8013a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013ac:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8013af:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013b2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013b5:	85 d2                	test   %edx,%edx
  8013b7:	79 23                	jns    8013dc <vprintfmt+0x29b>
				putch('-', putdat);
  8013b9:	83 ec 08             	sub    $0x8,%esp
  8013bc:	ff 75 0c             	pushl  0xc(%ebp)
  8013bf:	6a 2d                	push   $0x2d
  8013c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c4:	ff d0                	call   *%eax
  8013c6:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8013c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013cf:	f7 d8                	neg    %eax
  8013d1:	83 d2 00             	adc    $0x0,%edx
  8013d4:	f7 da                	neg    %edx
  8013d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013d9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8013dc:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8013e3:	e9 bc 00 00 00       	jmp    8014a4 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8013e8:	83 ec 08             	sub    $0x8,%esp
  8013eb:	ff 75 e8             	pushl  -0x18(%ebp)
  8013ee:	8d 45 14             	lea    0x14(%ebp),%eax
  8013f1:	50                   	push   %eax
  8013f2:	e8 84 fc ff ff       	call   80107b <getuint>
  8013f7:	83 c4 10             	add    $0x10,%esp
  8013fa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013fd:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801400:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801407:	e9 98 00 00 00       	jmp    8014a4 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80140c:	83 ec 08             	sub    $0x8,%esp
  80140f:	ff 75 0c             	pushl  0xc(%ebp)
  801412:	6a 58                	push   $0x58
  801414:	8b 45 08             	mov    0x8(%ebp),%eax
  801417:	ff d0                	call   *%eax
  801419:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80141c:	83 ec 08             	sub    $0x8,%esp
  80141f:	ff 75 0c             	pushl  0xc(%ebp)
  801422:	6a 58                	push   $0x58
  801424:	8b 45 08             	mov    0x8(%ebp),%eax
  801427:	ff d0                	call   *%eax
  801429:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80142c:	83 ec 08             	sub    $0x8,%esp
  80142f:	ff 75 0c             	pushl  0xc(%ebp)
  801432:	6a 58                	push   $0x58
  801434:	8b 45 08             	mov    0x8(%ebp),%eax
  801437:	ff d0                	call   *%eax
  801439:	83 c4 10             	add    $0x10,%esp
			break;
  80143c:	e9 bc 00 00 00       	jmp    8014fd <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801441:	83 ec 08             	sub    $0x8,%esp
  801444:	ff 75 0c             	pushl  0xc(%ebp)
  801447:	6a 30                	push   $0x30
  801449:	8b 45 08             	mov    0x8(%ebp),%eax
  80144c:	ff d0                	call   *%eax
  80144e:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801451:	83 ec 08             	sub    $0x8,%esp
  801454:	ff 75 0c             	pushl  0xc(%ebp)
  801457:	6a 78                	push   $0x78
  801459:	8b 45 08             	mov    0x8(%ebp),%eax
  80145c:	ff d0                	call   *%eax
  80145e:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801461:	8b 45 14             	mov    0x14(%ebp),%eax
  801464:	83 c0 04             	add    $0x4,%eax
  801467:	89 45 14             	mov    %eax,0x14(%ebp)
  80146a:	8b 45 14             	mov    0x14(%ebp),%eax
  80146d:	83 e8 04             	sub    $0x4,%eax
  801470:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801472:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801475:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80147c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801483:	eb 1f                	jmp    8014a4 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801485:	83 ec 08             	sub    $0x8,%esp
  801488:	ff 75 e8             	pushl  -0x18(%ebp)
  80148b:	8d 45 14             	lea    0x14(%ebp),%eax
  80148e:	50                   	push   %eax
  80148f:	e8 e7 fb ff ff       	call   80107b <getuint>
  801494:	83 c4 10             	add    $0x10,%esp
  801497:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80149a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80149d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8014a4:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8014a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8014ab:	83 ec 04             	sub    $0x4,%esp
  8014ae:	52                   	push   %edx
  8014af:	ff 75 e4             	pushl  -0x1c(%ebp)
  8014b2:	50                   	push   %eax
  8014b3:	ff 75 f4             	pushl  -0xc(%ebp)
  8014b6:	ff 75 f0             	pushl  -0x10(%ebp)
  8014b9:	ff 75 0c             	pushl  0xc(%ebp)
  8014bc:	ff 75 08             	pushl  0x8(%ebp)
  8014bf:	e8 00 fb ff ff       	call   800fc4 <printnum>
  8014c4:	83 c4 20             	add    $0x20,%esp
			break;
  8014c7:	eb 34                	jmp    8014fd <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8014c9:	83 ec 08             	sub    $0x8,%esp
  8014cc:	ff 75 0c             	pushl  0xc(%ebp)
  8014cf:	53                   	push   %ebx
  8014d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d3:	ff d0                	call   *%eax
  8014d5:	83 c4 10             	add    $0x10,%esp
			break;
  8014d8:	eb 23                	jmp    8014fd <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8014da:	83 ec 08             	sub    $0x8,%esp
  8014dd:	ff 75 0c             	pushl  0xc(%ebp)
  8014e0:	6a 25                	push   $0x25
  8014e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e5:	ff d0                	call   *%eax
  8014e7:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8014ea:	ff 4d 10             	decl   0x10(%ebp)
  8014ed:	eb 03                	jmp    8014f2 <vprintfmt+0x3b1>
  8014ef:	ff 4d 10             	decl   0x10(%ebp)
  8014f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f5:	48                   	dec    %eax
  8014f6:	8a 00                	mov    (%eax),%al
  8014f8:	3c 25                	cmp    $0x25,%al
  8014fa:	75 f3                	jne    8014ef <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8014fc:	90                   	nop
		}
	}
  8014fd:	e9 47 fc ff ff       	jmp    801149 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801502:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801503:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801506:	5b                   	pop    %ebx
  801507:	5e                   	pop    %esi
  801508:	5d                   	pop    %ebp
  801509:	c3                   	ret    

0080150a <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80150a:	55                   	push   %ebp
  80150b:	89 e5                	mov    %esp,%ebp
  80150d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801510:	8d 45 10             	lea    0x10(%ebp),%eax
  801513:	83 c0 04             	add    $0x4,%eax
  801516:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801519:	8b 45 10             	mov    0x10(%ebp),%eax
  80151c:	ff 75 f4             	pushl  -0xc(%ebp)
  80151f:	50                   	push   %eax
  801520:	ff 75 0c             	pushl  0xc(%ebp)
  801523:	ff 75 08             	pushl  0x8(%ebp)
  801526:	e8 16 fc ff ff       	call   801141 <vprintfmt>
  80152b:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80152e:	90                   	nop
  80152f:	c9                   	leave  
  801530:	c3                   	ret    

00801531 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801531:	55                   	push   %ebp
  801532:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801534:	8b 45 0c             	mov    0xc(%ebp),%eax
  801537:	8b 40 08             	mov    0x8(%eax),%eax
  80153a:	8d 50 01             	lea    0x1(%eax),%edx
  80153d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801540:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801543:	8b 45 0c             	mov    0xc(%ebp),%eax
  801546:	8b 10                	mov    (%eax),%edx
  801548:	8b 45 0c             	mov    0xc(%ebp),%eax
  80154b:	8b 40 04             	mov    0x4(%eax),%eax
  80154e:	39 c2                	cmp    %eax,%edx
  801550:	73 12                	jae    801564 <sprintputch+0x33>
		*b->buf++ = ch;
  801552:	8b 45 0c             	mov    0xc(%ebp),%eax
  801555:	8b 00                	mov    (%eax),%eax
  801557:	8d 48 01             	lea    0x1(%eax),%ecx
  80155a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80155d:	89 0a                	mov    %ecx,(%edx)
  80155f:	8b 55 08             	mov    0x8(%ebp),%edx
  801562:	88 10                	mov    %dl,(%eax)
}
  801564:	90                   	nop
  801565:	5d                   	pop    %ebp
  801566:	c3                   	ret    

00801567 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801567:	55                   	push   %ebp
  801568:	89 e5                	mov    %esp,%ebp
  80156a:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80156d:	8b 45 08             	mov    0x8(%ebp),%eax
  801570:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801573:	8b 45 0c             	mov    0xc(%ebp),%eax
  801576:	8d 50 ff             	lea    -0x1(%eax),%edx
  801579:	8b 45 08             	mov    0x8(%ebp),%eax
  80157c:	01 d0                	add    %edx,%eax
  80157e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801581:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801588:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80158c:	74 06                	je     801594 <vsnprintf+0x2d>
  80158e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801592:	7f 07                	jg     80159b <vsnprintf+0x34>
		return -E_INVAL;
  801594:	b8 03 00 00 00       	mov    $0x3,%eax
  801599:	eb 20                	jmp    8015bb <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80159b:	ff 75 14             	pushl  0x14(%ebp)
  80159e:	ff 75 10             	pushl  0x10(%ebp)
  8015a1:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8015a4:	50                   	push   %eax
  8015a5:	68 31 15 80 00       	push   $0x801531
  8015aa:	e8 92 fb ff ff       	call   801141 <vprintfmt>
  8015af:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8015b2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8015b5:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8015b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8015bb:	c9                   	leave  
  8015bc:	c3                   	ret    

008015bd <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8015bd:	55                   	push   %ebp
  8015be:	89 e5                	mov    %esp,%ebp
  8015c0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8015c3:	8d 45 10             	lea    0x10(%ebp),%eax
  8015c6:	83 c0 04             	add    $0x4,%eax
  8015c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8015cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8015cf:	ff 75 f4             	pushl  -0xc(%ebp)
  8015d2:	50                   	push   %eax
  8015d3:	ff 75 0c             	pushl  0xc(%ebp)
  8015d6:	ff 75 08             	pushl  0x8(%ebp)
  8015d9:	e8 89 ff ff ff       	call   801567 <vsnprintf>
  8015de:	83 c4 10             	add    $0x10,%esp
  8015e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8015e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8015e7:	c9                   	leave  
  8015e8:	c3                   	ret    

008015e9 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8015e9:	55                   	push   %ebp
  8015ea:	89 e5                	mov    %esp,%ebp
  8015ec:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8015ef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015f6:	eb 06                	jmp    8015fe <strlen+0x15>
		n++;
  8015f8:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8015fb:	ff 45 08             	incl   0x8(%ebp)
  8015fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801601:	8a 00                	mov    (%eax),%al
  801603:	84 c0                	test   %al,%al
  801605:	75 f1                	jne    8015f8 <strlen+0xf>
		n++;
	return n;
  801607:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80160a:	c9                   	leave  
  80160b:	c3                   	ret    

0080160c <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80160c:	55                   	push   %ebp
  80160d:	89 e5                	mov    %esp,%ebp
  80160f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801612:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801619:	eb 09                	jmp    801624 <strnlen+0x18>
		n++;
  80161b:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80161e:	ff 45 08             	incl   0x8(%ebp)
  801621:	ff 4d 0c             	decl   0xc(%ebp)
  801624:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801628:	74 09                	je     801633 <strnlen+0x27>
  80162a:	8b 45 08             	mov    0x8(%ebp),%eax
  80162d:	8a 00                	mov    (%eax),%al
  80162f:	84 c0                	test   %al,%al
  801631:	75 e8                	jne    80161b <strnlen+0xf>
		n++;
	return n;
  801633:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801636:	c9                   	leave  
  801637:	c3                   	ret    

00801638 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801638:	55                   	push   %ebp
  801639:	89 e5                	mov    %esp,%ebp
  80163b:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80163e:	8b 45 08             	mov    0x8(%ebp),%eax
  801641:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801644:	90                   	nop
  801645:	8b 45 08             	mov    0x8(%ebp),%eax
  801648:	8d 50 01             	lea    0x1(%eax),%edx
  80164b:	89 55 08             	mov    %edx,0x8(%ebp)
  80164e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801651:	8d 4a 01             	lea    0x1(%edx),%ecx
  801654:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801657:	8a 12                	mov    (%edx),%dl
  801659:	88 10                	mov    %dl,(%eax)
  80165b:	8a 00                	mov    (%eax),%al
  80165d:	84 c0                	test   %al,%al
  80165f:	75 e4                	jne    801645 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801661:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801664:	c9                   	leave  
  801665:	c3                   	ret    

00801666 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801666:	55                   	push   %ebp
  801667:	89 e5                	mov    %esp,%ebp
  801669:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80166c:	8b 45 08             	mov    0x8(%ebp),%eax
  80166f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801672:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801679:	eb 1f                	jmp    80169a <strncpy+0x34>
		*dst++ = *src;
  80167b:	8b 45 08             	mov    0x8(%ebp),%eax
  80167e:	8d 50 01             	lea    0x1(%eax),%edx
  801681:	89 55 08             	mov    %edx,0x8(%ebp)
  801684:	8b 55 0c             	mov    0xc(%ebp),%edx
  801687:	8a 12                	mov    (%edx),%dl
  801689:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80168b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80168e:	8a 00                	mov    (%eax),%al
  801690:	84 c0                	test   %al,%al
  801692:	74 03                	je     801697 <strncpy+0x31>
			src++;
  801694:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801697:	ff 45 fc             	incl   -0x4(%ebp)
  80169a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80169d:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016a0:	72 d9                	jb     80167b <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8016a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016a5:	c9                   	leave  
  8016a6:	c3                   	ret    

008016a7 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8016a7:	55                   	push   %ebp
  8016a8:	89 e5                	mov    %esp,%ebp
  8016aa:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8016ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8016b3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016b7:	74 30                	je     8016e9 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8016b9:	eb 16                	jmp    8016d1 <strlcpy+0x2a>
			*dst++ = *src++;
  8016bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016be:	8d 50 01             	lea    0x1(%eax),%edx
  8016c1:	89 55 08             	mov    %edx,0x8(%ebp)
  8016c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016c7:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016ca:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8016cd:	8a 12                	mov    (%edx),%dl
  8016cf:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8016d1:	ff 4d 10             	decl   0x10(%ebp)
  8016d4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016d8:	74 09                	je     8016e3 <strlcpy+0x3c>
  8016da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016dd:	8a 00                	mov    (%eax),%al
  8016df:	84 c0                	test   %al,%al
  8016e1:	75 d8                	jne    8016bb <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8016e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e6:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8016e9:	8b 55 08             	mov    0x8(%ebp),%edx
  8016ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016ef:	29 c2                	sub    %eax,%edx
  8016f1:	89 d0                	mov    %edx,%eax
}
  8016f3:	c9                   	leave  
  8016f4:	c3                   	ret    

008016f5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8016f5:	55                   	push   %ebp
  8016f6:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8016f8:	eb 06                	jmp    801700 <strcmp+0xb>
		p++, q++;
  8016fa:	ff 45 08             	incl   0x8(%ebp)
  8016fd:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801700:	8b 45 08             	mov    0x8(%ebp),%eax
  801703:	8a 00                	mov    (%eax),%al
  801705:	84 c0                	test   %al,%al
  801707:	74 0e                	je     801717 <strcmp+0x22>
  801709:	8b 45 08             	mov    0x8(%ebp),%eax
  80170c:	8a 10                	mov    (%eax),%dl
  80170e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801711:	8a 00                	mov    (%eax),%al
  801713:	38 c2                	cmp    %al,%dl
  801715:	74 e3                	je     8016fa <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801717:	8b 45 08             	mov    0x8(%ebp),%eax
  80171a:	8a 00                	mov    (%eax),%al
  80171c:	0f b6 d0             	movzbl %al,%edx
  80171f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801722:	8a 00                	mov    (%eax),%al
  801724:	0f b6 c0             	movzbl %al,%eax
  801727:	29 c2                	sub    %eax,%edx
  801729:	89 d0                	mov    %edx,%eax
}
  80172b:	5d                   	pop    %ebp
  80172c:	c3                   	ret    

0080172d <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80172d:	55                   	push   %ebp
  80172e:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801730:	eb 09                	jmp    80173b <strncmp+0xe>
		n--, p++, q++;
  801732:	ff 4d 10             	decl   0x10(%ebp)
  801735:	ff 45 08             	incl   0x8(%ebp)
  801738:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80173b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80173f:	74 17                	je     801758 <strncmp+0x2b>
  801741:	8b 45 08             	mov    0x8(%ebp),%eax
  801744:	8a 00                	mov    (%eax),%al
  801746:	84 c0                	test   %al,%al
  801748:	74 0e                	je     801758 <strncmp+0x2b>
  80174a:	8b 45 08             	mov    0x8(%ebp),%eax
  80174d:	8a 10                	mov    (%eax),%dl
  80174f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801752:	8a 00                	mov    (%eax),%al
  801754:	38 c2                	cmp    %al,%dl
  801756:	74 da                	je     801732 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801758:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80175c:	75 07                	jne    801765 <strncmp+0x38>
		return 0;
  80175e:	b8 00 00 00 00       	mov    $0x0,%eax
  801763:	eb 14                	jmp    801779 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801765:	8b 45 08             	mov    0x8(%ebp),%eax
  801768:	8a 00                	mov    (%eax),%al
  80176a:	0f b6 d0             	movzbl %al,%edx
  80176d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801770:	8a 00                	mov    (%eax),%al
  801772:	0f b6 c0             	movzbl %al,%eax
  801775:	29 c2                	sub    %eax,%edx
  801777:	89 d0                	mov    %edx,%eax
}
  801779:	5d                   	pop    %ebp
  80177a:	c3                   	ret    

0080177b <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80177b:	55                   	push   %ebp
  80177c:	89 e5                	mov    %esp,%ebp
  80177e:	83 ec 04             	sub    $0x4,%esp
  801781:	8b 45 0c             	mov    0xc(%ebp),%eax
  801784:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801787:	eb 12                	jmp    80179b <strchr+0x20>
		if (*s == c)
  801789:	8b 45 08             	mov    0x8(%ebp),%eax
  80178c:	8a 00                	mov    (%eax),%al
  80178e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801791:	75 05                	jne    801798 <strchr+0x1d>
			return (char *) s;
  801793:	8b 45 08             	mov    0x8(%ebp),%eax
  801796:	eb 11                	jmp    8017a9 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801798:	ff 45 08             	incl   0x8(%ebp)
  80179b:	8b 45 08             	mov    0x8(%ebp),%eax
  80179e:	8a 00                	mov    (%eax),%al
  8017a0:	84 c0                	test   %al,%al
  8017a2:	75 e5                	jne    801789 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8017a4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017a9:	c9                   	leave  
  8017aa:	c3                   	ret    

008017ab <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8017ab:	55                   	push   %ebp
  8017ac:	89 e5                	mov    %esp,%ebp
  8017ae:	83 ec 04             	sub    $0x4,%esp
  8017b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8017b7:	eb 0d                	jmp    8017c6 <strfind+0x1b>
		if (*s == c)
  8017b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bc:	8a 00                	mov    (%eax),%al
  8017be:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8017c1:	74 0e                	je     8017d1 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8017c3:	ff 45 08             	incl   0x8(%ebp)
  8017c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c9:	8a 00                	mov    (%eax),%al
  8017cb:	84 c0                	test   %al,%al
  8017cd:	75 ea                	jne    8017b9 <strfind+0xe>
  8017cf:	eb 01                	jmp    8017d2 <strfind+0x27>
		if (*s == c)
			break;
  8017d1:	90                   	nop
	return (char *) s;
  8017d2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8017d5:	c9                   	leave  
  8017d6:	c3                   	ret    

008017d7 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8017d7:	55                   	push   %ebp
  8017d8:	89 e5                	mov    %esp,%ebp
  8017da:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8017dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8017e3:	8b 45 10             	mov    0x10(%ebp),%eax
  8017e6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8017e9:	eb 0e                	jmp    8017f9 <memset+0x22>
		*p++ = c;
  8017eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017ee:	8d 50 01             	lea    0x1(%eax),%edx
  8017f1:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8017f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017f7:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8017f9:	ff 4d f8             	decl   -0x8(%ebp)
  8017fc:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801800:	79 e9                	jns    8017eb <memset+0x14>
		*p++ = c;

	return v;
  801802:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801805:	c9                   	leave  
  801806:	c3                   	ret    

00801807 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801807:	55                   	push   %ebp
  801808:	89 e5                	mov    %esp,%ebp
  80180a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80180d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801810:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801813:	8b 45 08             	mov    0x8(%ebp),%eax
  801816:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801819:	eb 16                	jmp    801831 <memcpy+0x2a>
		*d++ = *s++;
  80181b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80181e:	8d 50 01             	lea    0x1(%eax),%edx
  801821:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801824:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801827:	8d 4a 01             	lea    0x1(%edx),%ecx
  80182a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80182d:	8a 12                	mov    (%edx),%dl
  80182f:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801831:	8b 45 10             	mov    0x10(%ebp),%eax
  801834:	8d 50 ff             	lea    -0x1(%eax),%edx
  801837:	89 55 10             	mov    %edx,0x10(%ebp)
  80183a:	85 c0                	test   %eax,%eax
  80183c:	75 dd                	jne    80181b <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80183e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801841:	c9                   	leave  
  801842:	c3                   	ret    

00801843 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801843:	55                   	push   %ebp
  801844:	89 e5                	mov    %esp,%ebp
  801846:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801849:	8b 45 0c             	mov    0xc(%ebp),%eax
  80184c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80184f:	8b 45 08             	mov    0x8(%ebp),%eax
  801852:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801855:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801858:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80185b:	73 50                	jae    8018ad <memmove+0x6a>
  80185d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801860:	8b 45 10             	mov    0x10(%ebp),%eax
  801863:	01 d0                	add    %edx,%eax
  801865:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801868:	76 43                	jbe    8018ad <memmove+0x6a>
		s += n;
  80186a:	8b 45 10             	mov    0x10(%ebp),%eax
  80186d:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801870:	8b 45 10             	mov    0x10(%ebp),%eax
  801873:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801876:	eb 10                	jmp    801888 <memmove+0x45>
			*--d = *--s;
  801878:	ff 4d f8             	decl   -0x8(%ebp)
  80187b:	ff 4d fc             	decl   -0x4(%ebp)
  80187e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801881:	8a 10                	mov    (%eax),%dl
  801883:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801886:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801888:	8b 45 10             	mov    0x10(%ebp),%eax
  80188b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80188e:	89 55 10             	mov    %edx,0x10(%ebp)
  801891:	85 c0                	test   %eax,%eax
  801893:	75 e3                	jne    801878 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801895:	eb 23                	jmp    8018ba <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801897:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80189a:	8d 50 01             	lea    0x1(%eax),%edx
  80189d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8018a0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018a3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8018a6:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8018a9:	8a 12                	mov    (%edx),%dl
  8018ab:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8018ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8018b0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8018b3:	89 55 10             	mov    %edx,0x10(%ebp)
  8018b6:	85 c0                	test   %eax,%eax
  8018b8:	75 dd                	jne    801897 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8018ba:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8018bd:	c9                   	leave  
  8018be:	c3                   	ret    

008018bf <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8018bf:	55                   	push   %ebp
  8018c0:	89 e5                	mov    %esp,%ebp
  8018c2:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8018c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8018cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018ce:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8018d1:	eb 2a                	jmp    8018fd <memcmp+0x3e>
		if (*s1 != *s2)
  8018d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018d6:	8a 10                	mov    (%eax),%dl
  8018d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018db:	8a 00                	mov    (%eax),%al
  8018dd:	38 c2                	cmp    %al,%dl
  8018df:	74 16                	je     8018f7 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8018e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018e4:	8a 00                	mov    (%eax),%al
  8018e6:	0f b6 d0             	movzbl %al,%edx
  8018e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018ec:	8a 00                	mov    (%eax),%al
  8018ee:	0f b6 c0             	movzbl %al,%eax
  8018f1:	29 c2                	sub    %eax,%edx
  8018f3:	89 d0                	mov    %edx,%eax
  8018f5:	eb 18                	jmp    80190f <memcmp+0x50>
		s1++, s2++;
  8018f7:	ff 45 fc             	incl   -0x4(%ebp)
  8018fa:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8018fd:	8b 45 10             	mov    0x10(%ebp),%eax
  801900:	8d 50 ff             	lea    -0x1(%eax),%edx
  801903:	89 55 10             	mov    %edx,0x10(%ebp)
  801906:	85 c0                	test   %eax,%eax
  801908:	75 c9                	jne    8018d3 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80190a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80190f:	c9                   	leave  
  801910:	c3                   	ret    

00801911 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801911:	55                   	push   %ebp
  801912:	89 e5                	mov    %esp,%ebp
  801914:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801917:	8b 55 08             	mov    0x8(%ebp),%edx
  80191a:	8b 45 10             	mov    0x10(%ebp),%eax
  80191d:	01 d0                	add    %edx,%eax
  80191f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801922:	eb 15                	jmp    801939 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801924:	8b 45 08             	mov    0x8(%ebp),%eax
  801927:	8a 00                	mov    (%eax),%al
  801929:	0f b6 d0             	movzbl %al,%edx
  80192c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80192f:	0f b6 c0             	movzbl %al,%eax
  801932:	39 c2                	cmp    %eax,%edx
  801934:	74 0d                	je     801943 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801936:	ff 45 08             	incl   0x8(%ebp)
  801939:	8b 45 08             	mov    0x8(%ebp),%eax
  80193c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80193f:	72 e3                	jb     801924 <memfind+0x13>
  801941:	eb 01                	jmp    801944 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801943:	90                   	nop
	return (void *) s;
  801944:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801947:	c9                   	leave  
  801948:	c3                   	ret    

00801949 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801949:	55                   	push   %ebp
  80194a:	89 e5                	mov    %esp,%ebp
  80194c:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80194f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801956:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80195d:	eb 03                	jmp    801962 <strtol+0x19>
		s++;
  80195f:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801962:	8b 45 08             	mov    0x8(%ebp),%eax
  801965:	8a 00                	mov    (%eax),%al
  801967:	3c 20                	cmp    $0x20,%al
  801969:	74 f4                	je     80195f <strtol+0x16>
  80196b:	8b 45 08             	mov    0x8(%ebp),%eax
  80196e:	8a 00                	mov    (%eax),%al
  801970:	3c 09                	cmp    $0x9,%al
  801972:	74 eb                	je     80195f <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801974:	8b 45 08             	mov    0x8(%ebp),%eax
  801977:	8a 00                	mov    (%eax),%al
  801979:	3c 2b                	cmp    $0x2b,%al
  80197b:	75 05                	jne    801982 <strtol+0x39>
		s++;
  80197d:	ff 45 08             	incl   0x8(%ebp)
  801980:	eb 13                	jmp    801995 <strtol+0x4c>
	else if (*s == '-')
  801982:	8b 45 08             	mov    0x8(%ebp),%eax
  801985:	8a 00                	mov    (%eax),%al
  801987:	3c 2d                	cmp    $0x2d,%al
  801989:	75 0a                	jne    801995 <strtol+0x4c>
		s++, neg = 1;
  80198b:	ff 45 08             	incl   0x8(%ebp)
  80198e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801995:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801999:	74 06                	je     8019a1 <strtol+0x58>
  80199b:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80199f:	75 20                	jne    8019c1 <strtol+0x78>
  8019a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a4:	8a 00                	mov    (%eax),%al
  8019a6:	3c 30                	cmp    $0x30,%al
  8019a8:	75 17                	jne    8019c1 <strtol+0x78>
  8019aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ad:	40                   	inc    %eax
  8019ae:	8a 00                	mov    (%eax),%al
  8019b0:	3c 78                	cmp    $0x78,%al
  8019b2:	75 0d                	jne    8019c1 <strtol+0x78>
		s += 2, base = 16;
  8019b4:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8019b8:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8019bf:	eb 28                	jmp    8019e9 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8019c1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8019c5:	75 15                	jne    8019dc <strtol+0x93>
  8019c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ca:	8a 00                	mov    (%eax),%al
  8019cc:	3c 30                	cmp    $0x30,%al
  8019ce:	75 0c                	jne    8019dc <strtol+0x93>
		s++, base = 8;
  8019d0:	ff 45 08             	incl   0x8(%ebp)
  8019d3:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8019da:	eb 0d                	jmp    8019e9 <strtol+0xa0>
	else if (base == 0)
  8019dc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8019e0:	75 07                	jne    8019e9 <strtol+0xa0>
		base = 10;
  8019e2:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8019e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ec:	8a 00                	mov    (%eax),%al
  8019ee:	3c 2f                	cmp    $0x2f,%al
  8019f0:	7e 19                	jle    801a0b <strtol+0xc2>
  8019f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f5:	8a 00                	mov    (%eax),%al
  8019f7:	3c 39                	cmp    $0x39,%al
  8019f9:	7f 10                	jg     801a0b <strtol+0xc2>
			dig = *s - '0';
  8019fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fe:	8a 00                	mov    (%eax),%al
  801a00:	0f be c0             	movsbl %al,%eax
  801a03:	83 e8 30             	sub    $0x30,%eax
  801a06:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801a09:	eb 42                	jmp    801a4d <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801a0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0e:	8a 00                	mov    (%eax),%al
  801a10:	3c 60                	cmp    $0x60,%al
  801a12:	7e 19                	jle    801a2d <strtol+0xe4>
  801a14:	8b 45 08             	mov    0x8(%ebp),%eax
  801a17:	8a 00                	mov    (%eax),%al
  801a19:	3c 7a                	cmp    $0x7a,%al
  801a1b:	7f 10                	jg     801a2d <strtol+0xe4>
			dig = *s - 'a' + 10;
  801a1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a20:	8a 00                	mov    (%eax),%al
  801a22:	0f be c0             	movsbl %al,%eax
  801a25:	83 e8 57             	sub    $0x57,%eax
  801a28:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801a2b:	eb 20                	jmp    801a4d <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801a2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a30:	8a 00                	mov    (%eax),%al
  801a32:	3c 40                	cmp    $0x40,%al
  801a34:	7e 39                	jle    801a6f <strtol+0x126>
  801a36:	8b 45 08             	mov    0x8(%ebp),%eax
  801a39:	8a 00                	mov    (%eax),%al
  801a3b:	3c 5a                	cmp    $0x5a,%al
  801a3d:	7f 30                	jg     801a6f <strtol+0x126>
			dig = *s - 'A' + 10;
  801a3f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a42:	8a 00                	mov    (%eax),%al
  801a44:	0f be c0             	movsbl %al,%eax
  801a47:	83 e8 37             	sub    $0x37,%eax
  801a4a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801a4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a50:	3b 45 10             	cmp    0x10(%ebp),%eax
  801a53:	7d 19                	jge    801a6e <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801a55:	ff 45 08             	incl   0x8(%ebp)
  801a58:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a5b:	0f af 45 10          	imul   0x10(%ebp),%eax
  801a5f:	89 c2                	mov    %eax,%edx
  801a61:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a64:	01 d0                	add    %edx,%eax
  801a66:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801a69:	e9 7b ff ff ff       	jmp    8019e9 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801a6e:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801a6f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801a73:	74 08                	je     801a7d <strtol+0x134>
		*endptr = (char *) s;
  801a75:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a78:	8b 55 08             	mov    0x8(%ebp),%edx
  801a7b:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801a7d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801a81:	74 07                	je     801a8a <strtol+0x141>
  801a83:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a86:	f7 d8                	neg    %eax
  801a88:	eb 03                	jmp    801a8d <strtol+0x144>
  801a8a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801a8d:	c9                   	leave  
  801a8e:	c3                   	ret    

00801a8f <ltostr>:

void
ltostr(long value, char *str)
{
  801a8f:	55                   	push   %ebp
  801a90:	89 e5                	mov    %esp,%ebp
  801a92:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801a95:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801a9c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801aa3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801aa7:	79 13                	jns    801abc <ltostr+0x2d>
	{
		neg = 1;
  801aa9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801ab0:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ab3:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801ab6:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801ab9:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801abc:	8b 45 08             	mov    0x8(%ebp),%eax
  801abf:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801ac4:	99                   	cltd   
  801ac5:	f7 f9                	idiv   %ecx
  801ac7:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801aca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801acd:	8d 50 01             	lea    0x1(%eax),%edx
  801ad0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801ad3:	89 c2                	mov    %eax,%edx
  801ad5:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ad8:	01 d0                	add    %edx,%eax
  801ada:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801add:	83 c2 30             	add    $0x30,%edx
  801ae0:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801ae2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801ae5:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801aea:	f7 e9                	imul   %ecx
  801aec:	c1 fa 02             	sar    $0x2,%edx
  801aef:	89 c8                	mov    %ecx,%eax
  801af1:	c1 f8 1f             	sar    $0x1f,%eax
  801af4:	29 c2                	sub    %eax,%edx
  801af6:	89 d0                	mov    %edx,%eax
  801af8:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801afb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801afe:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801b03:	f7 e9                	imul   %ecx
  801b05:	c1 fa 02             	sar    $0x2,%edx
  801b08:	89 c8                	mov    %ecx,%eax
  801b0a:	c1 f8 1f             	sar    $0x1f,%eax
  801b0d:	29 c2                	sub    %eax,%edx
  801b0f:	89 d0                	mov    %edx,%eax
  801b11:	c1 e0 02             	shl    $0x2,%eax
  801b14:	01 d0                	add    %edx,%eax
  801b16:	01 c0                	add    %eax,%eax
  801b18:	29 c1                	sub    %eax,%ecx
  801b1a:	89 ca                	mov    %ecx,%edx
  801b1c:	85 d2                	test   %edx,%edx
  801b1e:	75 9c                	jne    801abc <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801b20:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801b27:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b2a:	48                   	dec    %eax
  801b2b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801b2e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801b32:	74 3d                	je     801b71 <ltostr+0xe2>
		start = 1 ;
  801b34:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801b3b:	eb 34                	jmp    801b71 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801b3d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b40:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b43:	01 d0                	add    %edx,%eax
  801b45:	8a 00                	mov    (%eax),%al
  801b47:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801b4a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b4d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b50:	01 c2                	add    %eax,%edx
  801b52:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801b55:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b58:	01 c8                	add    %ecx,%eax
  801b5a:	8a 00                	mov    (%eax),%al
  801b5c:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801b5e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801b61:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b64:	01 c2                	add    %eax,%edx
  801b66:	8a 45 eb             	mov    -0x15(%ebp),%al
  801b69:	88 02                	mov    %al,(%edx)
		start++ ;
  801b6b:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801b6e:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801b71:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b74:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b77:	7c c4                	jl     801b3d <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801b79:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801b7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b7f:	01 d0                	add    %edx,%eax
  801b81:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801b84:	90                   	nop
  801b85:	c9                   	leave  
  801b86:	c3                   	ret    

00801b87 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801b87:	55                   	push   %ebp
  801b88:	89 e5                	mov    %esp,%ebp
  801b8a:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801b8d:	ff 75 08             	pushl  0x8(%ebp)
  801b90:	e8 54 fa ff ff       	call   8015e9 <strlen>
  801b95:	83 c4 04             	add    $0x4,%esp
  801b98:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801b9b:	ff 75 0c             	pushl  0xc(%ebp)
  801b9e:	e8 46 fa ff ff       	call   8015e9 <strlen>
  801ba3:	83 c4 04             	add    $0x4,%esp
  801ba6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801ba9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801bb0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801bb7:	eb 17                	jmp    801bd0 <strcconcat+0x49>
		final[s] = str1[s] ;
  801bb9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801bbc:	8b 45 10             	mov    0x10(%ebp),%eax
  801bbf:	01 c2                	add    %eax,%edx
  801bc1:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801bc4:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc7:	01 c8                	add    %ecx,%eax
  801bc9:	8a 00                	mov    (%eax),%al
  801bcb:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801bcd:	ff 45 fc             	incl   -0x4(%ebp)
  801bd0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801bd3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801bd6:	7c e1                	jl     801bb9 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801bd8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801bdf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801be6:	eb 1f                	jmp    801c07 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801be8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801beb:	8d 50 01             	lea    0x1(%eax),%edx
  801bee:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801bf1:	89 c2                	mov    %eax,%edx
  801bf3:	8b 45 10             	mov    0x10(%ebp),%eax
  801bf6:	01 c2                	add    %eax,%edx
  801bf8:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801bfb:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bfe:	01 c8                	add    %ecx,%eax
  801c00:	8a 00                	mov    (%eax),%al
  801c02:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801c04:	ff 45 f8             	incl   -0x8(%ebp)
  801c07:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c0a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c0d:	7c d9                	jl     801be8 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801c0f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c12:	8b 45 10             	mov    0x10(%ebp),%eax
  801c15:	01 d0                	add    %edx,%eax
  801c17:	c6 00 00             	movb   $0x0,(%eax)
}
  801c1a:	90                   	nop
  801c1b:	c9                   	leave  
  801c1c:	c3                   	ret    

00801c1d <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801c1d:	55                   	push   %ebp
  801c1e:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801c20:	8b 45 14             	mov    0x14(%ebp),%eax
  801c23:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801c29:	8b 45 14             	mov    0x14(%ebp),%eax
  801c2c:	8b 00                	mov    (%eax),%eax
  801c2e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c35:	8b 45 10             	mov    0x10(%ebp),%eax
  801c38:	01 d0                	add    %edx,%eax
  801c3a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801c40:	eb 0c                	jmp    801c4e <strsplit+0x31>
			*string++ = 0;
  801c42:	8b 45 08             	mov    0x8(%ebp),%eax
  801c45:	8d 50 01             	lea    0x1(%eax),%edx
  801c48:	89 55 08             	mov    %edx,0x8(%ebp)
  801c4b:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801c4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c51:	8a 00                	mov    (%eax),%al
  801c53:	84 c0                	test   %al,%al
  801c55:	74 18                	je     801c6f <strsplit+0x52>
  801c57:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5a:	8a 00                	mov    (%eax),%al
  801c5c:	0f be c0             	movsbl %al,%eax
  801c5f:	50                   	push   %eax
  801c60:	ff 75 0c             	pushl  0xc(%ebp)
  801c63:	e8 13 fb ff ff       	call   80177b <strchr>
  801c68:	83 c4 08             	add    $0x8,%esp
  801c6b:	85 c0                	test   %eax,%eax
  801c6d:	75 d3                	jne    801c42 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801c6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c72:	8a 00                	mov    (%eax),%al
  801c74:	84 c0                	test   %al,%al
  801c76:	74 5a                	je     801cd2 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801c78:	8b 45 14             	mov    0x14(%ebp),%eax
  801c7b:	8b 00                	mov    (%eax),%eax
  801c7d:	83 f8 0f             	cmp    $0xf,%eax
  801c80:	75 07                	jne    801c89 <strsplit+0x6c>
		{
			return 0;
  801c82:	b8 00 00 00 00       	mov    $0x0,%eax
  801c87:	eb 66                	jmp    801cef <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801c89:	8b 45 14             	mov    0x14(%ebp),%eax
  801c8c:	8b 00                	mov    (%eax),%eax
  801c8e:	8d 48 01             	lea    0x1(%eax),%ecx
  801c91:	8b 55 14             	mov    0x14(%ebp),%edx
  801c94:	89 0a                	mov    %ecx,(%edx)
  801c96:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c9d:	8b 45 10             	mov    0x10(%ebp),%eax
  801ca0:	01 c2                	add    %eax,%edx
  801ca2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca5:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ca7:	eb 03                	jmp    801cac <strsplit+0x8f>
			string++;
  801ca9:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801cac:	8b 45 08             	mov    0x8(%ebp),%eax
  801caf:	8a 00                	mov    (%eax),%al
  801cb1:	84 c0                	test   %al,%al
  801cb3:	74 8b                	je     801c40 <strsplit+0x23>
  801cb5:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb8:	8a 00                	mov    (%eax),%al
  801cba:	0f be c0             	movsbl %al,%eax
  801cbd:	50                   	push   %eax
  801cbe:	ff 75 0c             	pushl  0xc(%ebp)
  801cc1:	e8 b5 fa ff ff       	call   80177b <strchr>
  801cc6:	83 c4 08             	add    $0x8,%esp
  801cc9:	85 c0                	test   %eax,%eax
  801ccb:	74 dc                	je     801ca9 <strsplit+0x8c>
			string++;
	}
  801ccd:	e9 6e ff ff ff       	jmp    801c40 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801cd2:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801cd3:	8b 45 14             	mov    0x14(%ebp),%eax
  801cd6:	8b 00                	mov    (%eax),%eax
  801cd8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801cdf:	8b 45 10             	mov    0x10(%ebp),%eax
  801ce2:	01 d0                	add    %edx,%eax
  801ce4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801cea:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801cef:	c9                   	leave  
  801cf0:	c3                   	ret    

00801cf1 <malloc>:
int changes = 0;
int sizeofarray = 0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size) {
  801cf1:	55                   	push   %ebp
  801cf2:	89 e5                	mov    %esp,%ebp
  801cf4:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  801cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  801cfa:	c1 e8 0c             	shr    $0xc,%eax
  801cfd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	//sizeofarray++;
	if (size % PAGE_SIZE != 0)
  801d00:	8b 45 08             	mov    0x8(%ebp),%eax
  801d03:	25 ff 0f 00 00       	and    $0xfff,%eax
  801d08:	85 c0                	test   %eax,%eax
  801d0a:	74 03                	je     801d0f <malloc+0x1e>
		num++;
  801d0c:	ff 45 f4             	incl   -0xc(%ebp)
//		addresses[sizeofarray] = last_addres;
//		changed[sizeofarray] = 1;
//		sizeofarray++;
//		return (void*) return_addres;
	//} else {
	if (changes == 0) {
  801d0f:	a1 28 40 80 00       	mov    0x804028,%eax
  801d14:	85 c0                	test   %eax,%eax
  801d16:	75 71                	jne    801d89 <malloc+0x98>
		sys_allocateMem(last_addres, size);
  801d18:	a1 04 40 80 00       	mov    0x804004,%eax
  801d1d:	83 ec 08             	sub    $0x8,%esp
  801d20:	ff 75 08             	pushl  0x8(%ebp)
  801d23:	50                   	push   %eax
  801d24:	e8 e4 04 00 00       	call   80220d <sys_allocateMem>
  801d29:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  801d2c:	a1 04 40 80 00       	mov    0x804004,%eax
  801d31:	89 45 d8             	mov    %eax,-0x28(%ebp)
		last_addres += num * PAGE_SIZE;
  801d34:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d37:	c1 e0 0c             	shl    $0xc,%eax
  801d3a:	89 c2                	mov    %eax,%edx
  801d3c:	a1 04 40 80 00       	mov    0x804004,%eax
  801d41:	01 d0                	add    %edx,%eax
  801d43:	a3 04 40 80 00       	mov    %eax,0x804004
		numOfPages[sizeofarray] = num;
  801d48:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801d4d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801d50:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
		addresses[sizeofarray] = return_addres;
  801d57:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801d5c:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801d5f:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
		changed[sizeofarray] = 1;
  801d66:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801d6b:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  801d72:	01 00 00 00 
		sizeofarray++;
  801d76:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801d7b:	40                   	inc    %eax
  801d7c:	a3 2c 40 80 00       	mov    %eax,0x80402c
		return (void*) return_addres;
  801d81:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801d84:	e9 f7 00 00 00       	jmp    801e80 <malloc+0x18f>
	} else {
		int count = 0;
  801d89:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 1000;
  801d90:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
		int index = -1;
  801d97:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
  801d9e:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801da5:	eb 7c                	jmp    801e23 <malloc+0x132>
		{
			uint32 *pg = NULL;
  801da7:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
			for (int j = 0; j < sizeofarray; j++) {
  801dae:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801db5:	eb 1a                	jmp    801dd1 <malloc+0xe0>
				if (addresses[j] == i) {
  801db7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801dba:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  801dc1:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801dc4:	75 08                	jne    801dce <malloc+0xdd>
					index = j;
  801dc6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801dc9:	89 45 e8             	mov    %eax,-0x18(%ebp)
					break;
  801dcc:	eb 0d                	jmp    801ddb <malloc+0xea>
		int index = -1;
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
		{
			uint32 *pg = NULL;
			for (int j = 0; j < sizeofarray; j++) {
  801dce:	ff 45 dc             	incl   -0x24(%ebp)
  801dd1:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801dd6:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801dd9:	7c dc                	jl     801db7 <malloc+0xc6>
					index = j;
					break;
				}
			}

			if (index == -1) {
  801ddb:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801ddf:	75 05                	jne    801de6 <malloc+0xf5>
				count++;
  801de1:	ff 45 f0             	incl   -0x10(%ebp)
  801de4:	eb 36                	jmp    801e1c <malloc+0x12b>
			} else {
				if (changed[index] == 0) {
  801de6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801de9:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  801df0:	85 c0                	test   %eax,%eax
  801df2:	75 05                	jne    801df9 <malloc+0x108>
					count++;
  801df4:	ff 45 f0             	incl   -0x10(%ebp)
  801df7:	eb 23                	jmp    801e1c <malloc+0x12b>
				} else {
					if (count < min && count >= num) {
  801df9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801dfc:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801dff:	7d 14                	jge    801e15 <malloc+0x124>
  801e01:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e04:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801e07:	7c 0c                	jl     801e15 <malloc+0x124>
						min = count;
  801e09:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801e0c:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss = i;
  801e0f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801e12:	89 45 e4             	mov    %eax,-0x1c(%ebp)
					}
					count = 0;
  801e15:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	} else {
		int count = 0;
		int min = 1000;
		int index = -1;
		uint32 min_addresss;
		for (uint32 i = USER_HEAP_START; i < USER_HEAP_MAX; i += PAGE_SIZE)
  801e1c:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801e23:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801e2a:	0f 86 77 ff ff ff    	jbe    801da7 <malloc+0xb6>

			}

		}

		sys_allocateMem(min_addresss, size);
  801e30:	83 ec 08             	sub    $0x8,%esp
  801e33:	ff 75 08             	pushl  0x8(%ebp)
  801e36:	ff 75 e4             	pushl  -0x1c(%ebp)
  801e39:	e8 cf 03 00 00       	call   80220d <sys_allocateMem>
  801e3e:	83 c4 10             	add    $0x10,%esp
		numOfPages[sizeofarray] = num;
  801e41:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801e46:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801e49:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
		addresses[sizeofarray] = last_addres;
  801e50:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801e55:	8b 15 04 40 80 00    	mov    0x804004,%edx
  801e5b:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
		changed[sizeofarray] = 1;
  801e62:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801e67:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  801e6e:	01 00 00 00 
		sizeofarray++;
  801e72:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801e77:	40                   	inc    %eax
  801e78:	a3 2c 40 80 00       	mov    %eax,0x80402c
		return (void*) min_addresss;
  801e7d:	8b 45 e4             	mov    -0x1c(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  801e80:	c9                   	leave  
  801e81:	c3                   	ret    

00801e82 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801e82:	55                   	push   %ebp
  801e83:	89 e5                	mov    %esp,%ebp
  801e85:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801e88:	8b 45 08             	mov    0x8(%ebp),%eax
  801e8b:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  801e8e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801e95:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801e9c:	eb 30                	jmp    801ece <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  801e9e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801ea1:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  801ea8:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801eab:	75 1e                	jne    801ecb <free+0x49>
  801ead:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801eb0:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  801eb7:	83 f8 01             	cmp    $0x1,%eax
  801eba:	75 0f                	jne    801ecb <free+0x49>
			is_found = 1;
  801ebc:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  801ec3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801ec6:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  801ec9:	eb 0d                	jmp    801ed8 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801ecb:	ff 45 ec             	incl   -0x14(%ebp)
  801ece:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801ed3:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801ed6:	7c c6                	jl     801e9e <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  801ed8:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801edc:	75 4f                	jne    801f2d <free+0xab>
		size = numOfPages[index] * PAGE_SIZE;
  801ede:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ee1:	8b 04 85 20 76 8c 00 	mov    0x8c7620(,%eax,4),%eax
  801ee8:	c1 e0 0c             	shl    $0xc,%eax
  801eeb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		cprintf("the size form the free is %d \n", size);
  801eee:	83 ec 08             	sub    $0x8,%esp
  801ef1:	ff 75 e4             	pushl  -0x1c(%ebp)
  801ef4:	68 10 32 80 00       	push   $0x803210
  801ef9:	e8 69 f0 ff ff       	call   800f67 <cprintf>
  801efe:	83 c4 10             	add    $0x10,%esp
		sys_freeMem(va, size);
  801f01:	83 ec 08             	sub    $0x8,%esp
  801f04:	ff 75 e4             	pushl  -0x1c(%ebp)
  801f07:	ff 75 e8             	pushl  -0x18(%ebp)
  801f0a:	e8 e2 02 00 00       	call   8021f1 <sys_freeMem>
  801f0f:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801f12:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f15:	c7 04 85 a0 5b 86 00 	movl   $0x0,0x865ba0(,%eax,4)
  801f1c:	00 00 00 00 
		changes++;
  801f20:	a1 28 40 80 00       	mov    0x804028,%eax
  801f25:	40                   	inc    %eax
  801f26:	a3 28 40 80 00       	mov    %eax,0x804028
		sys_freeMem(va, size);
		changed[index] = 0;
	}

	//refer to the project presentation and documentation for details
}
  801f2b:	eb 39                	jmp    801f66 <free+0xe4>
		cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
		changed[index] = 0;
		changes++;
	} else {
		size = 513 * PAGE_SIZE;
  801f2d:	c7 45 e4 00 10 20 00 	movl   $0x201000,-0x1c(%ebp)
		cprintf("the size form the free is %d \n", size);
  801f34:	83 ec 08             	sub    $0x8,%esp
  801f37:	ff 75 e4             	pushl  -0x1c(%ebp)
  801f3a:	68 10 32 80 00       	push   $0x803210
  801f3f:	e8 23 f0 ff ff       	call   800f67 <cprintf>
  801f44:	83 c4 10             	add    $0x10,%esp
		sys_freeMem(va, size);
  801f47:	83 ec 08             	sub    $0x8,%esp
  801f4a:	ff 75 e4             	pushl  -0x1c(%ebp)
  801f4d:	ff 75 e8             	pushl  -0x18(%ebp)
  801f50:	e8 9c 02 00 00       	call   8021f1 <sys_freeMem>
  801f55:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  801f58:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801f5b:	c7 04 85 a0 5b 86 00 	movl   $0x0,0x865ba0(,%eax,4)
  801f62:	00 00 00 00 
	}

	//refer to the project presentation and documentation for details
}
  801f66:	90                   	nop
  801f67:	c9                   	leave  
  801f68:	c3                   	ret    

00801f69 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  801f69:	55                   	push   %ebp
  801f6a:	89 e5                	mov    %esp,%ebp
  801f6c:	83 ec 18             	sub    $0x18,%esp
  801f6f:	8b 45 10             	mov    0x10(%ebp),%eax
  801f72:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801f75:	83 ec 04             	sub    $0x4,%esp
  801f78:	68 30 32 80 00       	push   $0x803230
  801f7d:	68 9d 00 00 00       	push   $0x9d
  801f82:	68 53 32 80 00       	push   $0x803253
  801f87:	e8 39 ed ff ff       	call   800cc5 <_panic>

00801f8c <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  801f8c:	55                   	push   %ebp
  801f8d:	89 e5                	mov    %esp,%ebp
  801f8f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801f92:	83 ec 04             	sub    $0x4,%esp
  801f95:	68 30 32 80 00       	push   $0x803230
  801f9a:	68 a2 00 00 00       	push   $0xa2
  801f9f:	68 53 32 80 00       	push   $0x803253
  801fa4:	e8 1c ed ff ff       	call   800cc5 <_panic>

00801fa9 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  801fa9:	55                   	push   %ebp
  801faa:	89 e5                	mov    %esp,%ebp
  801fac:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801faf:	83 ec 04             	sub    $0x4,%esp
  801fb2:	68 30 32 80 00       	push   $0x803230
  801fb7:	68 a7 00 00 00       	push   $0xa7
  801fbc:	68 53 32 80 00       	push   $0x803253
  801fc1:	e8 ff ec ff ff       	call   800cc5 <_panic>

00801fc6 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  801fc6:	55                   	push   %ebp
  801fc7:	89 e5                	mov    %esp,%ebp
  801fc9:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801fcc:	83 ec 04             	sub    $0x4,%esp
  801fcf:	68 30 32 80 00       	push   $0x803230
  801fd4:	68 ab 00 00 00       	push   $0xab
  801fd9:	68 53 32 80 00       	push   $0x803253
  801fde:	e8 e2 ec ff ff       	call   800cc5 <_panic>

00801fe3 <expand>:
	return 0;
}

void expand(uint32 newSize) {
  801fe3:	55                   	push   %ebp
  801fe4:	89 e5                	mov    %esp,%ebp
  801fe6:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801fe9:	83 ec 04             	sub    $0x4,%esp
  801fec:	68 30 32 80 00       	push   $0x803230
  801ff1:	68 b0 00 00 00       	push   $0xb0
  801ff6:	68 53 32 80 00       	push   $0x803253
  801ffb:	e8 c5 ec ff ff       	call   800cc5 <_panic>

00802000 <shrink>:
}
void shrink(uint32 newSize) {
  802000:	55                   	push   %ebp
  802001:	89 e5                	mov    %esp,%ebp
  802003:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802006:	83 ec 04             	sub    $0x4,%esp
  802009:	68 30 32 80 00       	push   $0x803230
  80200e:	68 b3 00 00 00       	push   $0xb3
  802013:	68 53 32 80 00       	push   $0x803253
  802018:	e8 a8 ec ff ff       	call   800cc5 <_panic>

0080201d <freeHeap>:
}

void freeHeap(void* virtual_address) {
  80201d:	55                   	push   %ebp
  80201e:	89 e5                	mov    %esp,%ebp
  802020:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802023:	83 ec 04             	sub    $0x4,%esp
  802026:	68 30 32 80 00       	push   $0x803230
  80202b:	68 b7 00 00 00       	push   $0xb7
  802030:	68 53 32 80 00       	push   $0x803253
  802035:	e8 8b ec ff ff       	call   800cc5 <_panic>

0080203a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80203a:	55                   	push   %ebp
  80203b:	89 e5                	mov    %esp,%ebp
  80203d:	57                   	push   %edi
  80203e:	56                   	push   %esi
  80203f:	53                   	push   %ebx
  802040:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802043:	8b 45 08             	mov    0x8(%ebp),%eax
  802046:	8b 55 0c             	mov    0xc(%ebp),%edx
  802049:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80204c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80204f:	8b 7d 18             	mov    0x18(%ebp),%edi
  802052:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802055:	cd 30                	int    $0x30
  802057:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80205a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80205d:	83 c4 10             	add    $0x10,%esp
  802060:	5b                   	pop    %ebx
  802061:	5e                   	pop    %esi
  802062:	5f                   	pop    %edi
  802063:	5d                   	pop    %ebp
  802064:	c3                   	ret    

00802065 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802065:	55                   	push   %ebp
  802066:	89 e5                	mov    %esp,%ebp
  802068:	83 ec 04             	sub    $0x4,%esp
  80206b:	8b 45 10             	mov    0x10(%ebp),%eax
  80206e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802071:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802075:	8b 45 08             	mov    0x8(%ebp),%eax
  802078:	6a 00                	push   $0x0
  80207a:	6a 00                	push   $0x0
  80207c:	52                   	push   %edx
  80207d:	ff 75 0c             	pushl  0xc(%ebp)
  802080:	50                   	push   %eax
  802081:	6a 00                	push   $0x0
  802083:	e8 b2 ff ff ff       	call   80203a <syscall>
  802088:	83 c4 18             	add    $0x18,%esp
}
  80208b:	90                   	nop
  80208c:	c9                   	leave  
  80208d:	c3                   	ret    

0080208e <sys_cgetc>:

int
sys_cgetc(void)
{
  80208e:	55                   	push   %ebp
  80208f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802091:	6a 00                	push   $0x0
  802093:	6a 00                	push   $0x0
  802095:	6a 00                	push   $0x0
  802097:	6a 00                	push   $0x0
  802099:	6a 00                	push   $0x0
  80209b:	6a 01                	push   $0x1
  80209d:	e8 98 ff ff ff       	call   80203a <syscall>
  8020a2:	83 c4 18             	add    $0x18,%esp
}
  8020a5:	c9                   	leave  
  8020a6:	c3                   	ret    

008020a7 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8020a7:	55                   	push   %ebp
  8020a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8020aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ad:	6a 00                	push   $0x0
  8020af:	6a 00                	push   $0x0
  8020b1:	6a 00                	push   $0x0
  8020b3:	6a 00                	push   $0x0
  8020b5:	50                   	push   %eax
  8020b6:	6a 05                	push   $0x5
  8020b8:	e8 7d ff ff ff       	call   80203a <syscall>
  8020bd:	83 c4 18             	add    $0x18,%esp
}
  8020c0:	c9                   	leave  
  8020c1:	c3                   	ret    

008020c2 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8020c2:	55                   	push   %ebp
  8020c3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8020c5:	6a 00                	push   $0x0
  8020c7:	6a 00                	push   $0x0
  8020c9:	6a 00                	push   $0x0
  8020cb:	6a 00                	push   $0x0
  8020cd:	6a 00                	push   $0x0
  8020cf:	6a 02                	push   $0x2
  8020d1:	e8 64 ff ff ff       	call   80203a <syscall>
  8020d6:	83 c4 18             	add    $0x18,%esp
}
  8020d9:	c9                   	leave  
  8020da:	c3                   	ret    

008020db <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8020db:	55                   	push   %ebp
  8020dc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8020de:	6a 00                	push   $0x0
  8020e0:	6a 00                	push   $0x0
  8020e2:	6a 00                	push   $0x0
  8020e4:	6a 00                	push   $0x0
  8020e6:	6a 00                	push   $0x0
  8020e8:	6a 03                	push   $0x3
  8020ea:	e8 4b ff ff ff       	call   80203a <syscall>
  8020ef:	83 c4 18             	add    $0x18,%esp
}
  8020f2:	c9                   	leave  
  8020f3:	c3                   	ret    

008020f4 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8020f4:	55                   	push   %ebp
  8020f5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8020f7:	6a 00                	push   $0x0
  8020f9:	6a 00                	push   $0x0
  8020fb:	6a 00                	push   $0x0
  8020fd:	6a 00                	push   $0x0
  8020ff:	6a 00                	push   $0x0
  802101:	6a 04                	push   $0x4
  802103:	e8 32 ff ff ff       	call   80203a <syscall>
  802108:	83 c4 18             	add    $0x18,%esp
}
  80210b:	c9                   	leave  
  80210c:	c3                   	ret    

0080210d <sys_env_exit>:


void sys_env_exit(void)
{
  80210d:	55                   	push   %ebp
  80210e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802110:	6a 00                	push   $0x0
  802112:	6a 00                	push   $0x0
  802114:	6a 00                	push   $0x0
  802116:	6a 00                	push   $0x0
  802118:	6a 00                	push   $0x0
  80211a:	6a 06                	push   $0x6
  80211c:	e8 19 ff ff ff       	call   80203a <syscall>
  802121:	83 c4 18             	add    $0x18,%esp
}
  802124:	90                   	nop
  802125:	c9                   	leave  
  802126:	c3                   	ret    

00802127 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802127:	55                   	push   %ebp
  802128:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80212a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80212d:	8b 45 08             	mov    0x8(%ebp),%eax
  802130:	6a 00                	push   $0x0
  802132:	6a 00                	push   $0x0
  802134:	6a 00                	push   $0x0
  802136:	52                   	push   %edx
  802137:	50                   	push   %eax
  802138:	6a 07                	push   $0x7
  80213a:	e8 fb fe ff ff       	call   80203a <syscall>
  80213f:	83 c4 18             	add    $0x18,%esp
}
  802142:	c9                   	leave  
  802143:	c3                   	ret    

00802144 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802144:	55                   	push   %ebp
  802145:	89 e5                	mov    %esp,%ebp
  802147:	56                   	push   %esi
  802148:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802149:	8b 75 18             	mov    0x18(%ebp),%esi
  80214c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80214f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802152:	8b 55 0c             	mov    0xc(%ebp),%edx
  802155:	8b 45 08             	mov    0x8(%ebp),%eax
  802158:	56                   	push   %esi
  802159:	53                   	push   %ebx
  80215a:	51                   	push   %ecx
  80215b:	52                   	push   %edx
  80215c:	50                   	push   %eax
  80215d:	6a 08                	push   $0x8
  80215f:	e8 d6 fe ff ff       	call   80203a <syscall>
  802164:	83 c4 18             	add    $0x18,%esp
}
  802167:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80216a:	5b                   	pop    %ebx
  80216b:	5e                   	pop    %esi
  80216c:	5d                   	pop    %ebp
  80216d:	c3                   	ret    

0080216e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80216e:	55                   	push   %ebp
  80216f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802171:	8b 55 0c             	mov    0xc(%ebp),%edx
  802174:	8b 45 08             	mov    0x8(%ebp),%eax
  802177:	6a 00                	push   $0x0
  802179:	6a 00                	push   $0x0
  80217b:	6a 00                	push   $0x0
  80217d:	52                   	push   %edx
  80217e:	50                   	push   %eax
  80217f:	6a 09                	push   $0x9
  802181:	e8 b4 fe ff ff       	call   80203a <syscall>
  802186:	83 c4 18             	add    $0x18,%esp
}
  802189:	c9                   	leave  
  80218a:	c3                   	ret    

0080218b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80218b:	55                   	push   %ebp
  80218c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80218e:	6a 00                	push   $0x0
  802190:	6a 00                	push   $0x0
  802192:	6a 00                	push   $0x0
  802194:	ff 75 0c             	pushl  0xc(%ebp)
  802197:	ff 75 08             	pushl  0x8(%ebp)
  80219a:	6a 0a                	push   $0xa
  80219c:	e8 99 fe ff ff       	call   80203a <syscall>
  8021a1:	83 c4 18             	add    $0x18,%esp
}
  8021a4:	c9                   	leave  
  8021a5:	c3                   	ret    

008021a6 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8021a6:	55                   	push   %ebp
  8021a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8021a9:	6a 00                	push   $0x0
  8021ab:	6a 00                	push   $0x0
  8021ad:	6a 00                	push   $0x0
  8021af:	6a 00                	push   $0x0
  8021b1:	6a 00                	push   $0x0
  8021b3:	6a 0b                	push   $0xb
  8021b5:	e8 80 fe ff ff       	call   80203a <syscall>
  8021ba:	83 c4 18             	add    $0x18,%esp
}
  8021bd:	c9                   	leave  
  8021be:	c3                   	ret    

008021bf <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8021bf:	55                   	push   %ebp
  8021c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8021c2:	6a 00                	push   $0x0
  8021c4:	6a 00                	push   $0x0
  8021c6:	6a 00                	push   $0x0
  8021c8:	6a 00                	push   $0x0
  8021ca:	6a 00                	push   $0x0
  8021cc:	6a 0c                	push   $0xc
  8021ce:	e8 67 fe ff ff       	call   80203a <syscall>
  8021d3:	83 c4 18             	add    $0x18,%esp
}
  8021d6:	c9                   	leave  
  8021d7:	c3                   	ret    

008021d8 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8021d8:	55                   	push   %ebp
  8021d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8021db:	6a 00                	push   $0x0
  8021dd:	6a 00                	push   $0x0
  8021df:	6a 00                	push   $0x0
  8021e1:	6a 00                	push   $0x0
  8021e3:	6a 00                	push   $0x0
  8021e5:	6a 0d                	push   $0xd
  8021e7:	e8 4e fe ff ff       	call   80203a <syscall>
  8021ec:	83 c4 18             	add    $0x18,%esp
}
  8021ef:	c9                   	leave  
  8021f0:	c3                   	ret    

008021f1 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8021f1:	55                   	push   %ebp
  8021f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8021f4:	6a 00                	push   $0x0
  8021f6:	6a 00                	push   $0x0
  8021f8:	6a 00                	push   $0x0
  8021fa:	ff 75 0c             	pushl  0xc(%ebp)
  8021fd:	ff 75 08             	pushl  0x8(%ebp)
  802200:	6a 11                	push   $0x11
  802202:	e8 33 fe ff ff       	call   80203a <syscall>
  802207:	83 c4 18             	add    $0x18,%esp
	return;
  80220a:	90                   	nop
}
  80220b:	c9                   	leave  
  80220c:	c3                   	ret    

0080220d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80220d:	55                   	push   %ebp
  80220e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802210:	6a 00                	push   $0x0
  802212:	6a 00                	push   $0x0
  802214:	6a 00                	push   $0x0
  802216:	ff 75 0c             	pushl  0xc(%ebp)
  802219:	ff 75 08             	pushl  0x8(%ebp)
  80221c:	6a 12                	push   $0x12
  80221e:	e8 17 fe ff ff       	call   80203a <syscall>
  802223:	83 c4 18             	add    $0x18,%esp
	return ;
  802226:	90                   	nop
}
  802227:	c9                   	leave  
  802228:	c3                   	ret    

00802229 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802229:	55                   	push   %ebp
  80222a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80222c:	6a 00                	push   $0x0
  80222e:	6a 00                	push   $0x0
  802230:	6a 00                	push   $0x0
  802232:	6a 00                	push   $0x0
  802234:	6a 00                	push   $0x0
  802236:	6a 0e                	push   $0xe
  802238:	e8 fd fd ff ff       	call   80203a <syscall>
  80223d:	83 c4 18             	add    $0x18,%esp
}
  802240:	c9                   	leave  
  802241:	c3                   	ret    

00802242 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802242:	55                   	push   %ebp
  802243:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802245:	6a 00                	push   $0x0
  802247:	6a 00                	push   $0x0
  802249:	6a 00                	push   $0x0
  80224b:	6a 00                	push   $0x0
  80224d:	ff 75 08             	pushl  0x8(%ebp)
  802250:	6a 0f                	push   $0xf
  802252:	e8 e3 fd ff ff       	call   80203a <syscall>
  802257:	83 c4 18             	add    $0x18,%esp
}
  80225a:	c9                   	leave  
  80225b:	c3                   	ret    

0080225c <sys_scarce_memory>:

void sys_scarce_memory()
{
  80225c:	55                   	push   %ebp
  80225d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80225f:	6a 00                	push   $0x0
  802261:	6a 00                	push   $0x0
  802263:	6a 00                	push   $0x0
  802265:	6a 00                	push   $0x0
  802267:	6a 00                	push   $0x0
  802269:	6a 10                	push   $0x10
  80226b:	e8 ca fd ff ff       	call   80203a <syscall>
  802270:	83 c4 18             	add    $0x18,%esp
}
  802273:	90                   	nop
  802274:	c9                   	leave  
  802275:	c3                   	ret    

00802276 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802276:	55                   	push   %ebp
  802277:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802279:	6a 00                	push   $0x0
  80227b:	6a 00                	push   $0x0
  80227d:	6a 00                	push   $0x0
  80227f:	6a 00                	push   $0x0
  802281:	6a 00                	push   $0x0
  802283:	6a 14                	push   $0x14
  802285:	e8 b0 fd ff ff       	call   80203a <syscall>
  80228a:	83 c4 18             	add    $0x18,%esp
}
  80228d:	90                   	nop
  80228e:	c9                   	leave  
  80228f:	c3                   	ret    

00802290 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802290:	55                   	push   %ebp
  802291:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802293:	6a 00                	push   $0x0
  802295:	6a 00                	push   $0x0
  802297:	6a 00                	push   $0x0
  802299:	6a 00                	push   $0x0
  80229b:	6a 00                	push   $0x0
  80229d:	6a 15                	push   $0x15
  80229f:	e8 96 fd ff ff       	call   80203a <syscall>
  8022a4:	83 c4 18             	add    $0x18,%esp
}
  8022a7:	90                   	nop
  8022a8:	c9                   	leave  
  8022a9:	c3                   	ret    

008022aa <sys_cputc>:


void
sys_cputc(const char c)
{
  8022aa:	55                   	push   %ebp
  8022ab:	89 e5                	mov    %esp,%ebp
  8022ad:	83 ec 04             	sub    $0x4,%esp
  8022b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8022b3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8022b6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8022ba:	6a 00                	push   $0x0
  8022bc:	6a 00                	push   $0x0
  8022be:	6a 00                	push   $0x0
  8022c0:	6a 00                	push   $0x0
  8022c2:	50                   	push   %eax
  8022c3:	6a 16                	push   $0x16
  8022c5:	e8 70 fd ff ff       	call   80203a <syscall>
  8022ca:	83 c4 18             	add    $0x18,%esp
}
  8022cd:	90                   	nop
  8022ce:	c9                   	leave  
  8022cf:	c3                   	ret    

008022d0 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8022d0:	55                   	push   %ebp
  8022d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8022d3:	6a 00                	push   $0x0
  8022d5:	6a 00                	push   $0x0
  8022d7:	6a 00                	push   $0x0
  8022d9:	6a 00                	push   $0x0
  8022db:	6a 00                	push   $0x0
  8022dd:	6a 17                	push   $0x17
  8022df:	e8 56 fd ff ff       	call   80203a <syscall>
  8022e4:	83 c4 18             	add    $0x18,%esp
}
  8022e7:	90                   	nop
  8022e8:	c9                   	leave  
  8022e9:	c3                   	ret    

008022ea <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8022ea:	55                   	push   %ebp
  8022eb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8022ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8022f0:	6a 00                	push   $0x0
  8022f2:	6a 00                	push   $0x0
  8022f4:	6a 00                	push   $0x0
  8022f6:	ff 75 0c             	pushl  0xc(%ebp)
  8022f9:	50                   	push   %eax
  8022fa:	6a 18                	push   $0x18
  8022fc:	e8 39 fd ff ff       	call   80203a <syscall>
  802301:	83 c4 18             	add    $0x18,%esp
}
  802304:	c9                   	leave  
  802305:	c3                   	ret    

00802306 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802306:	55                   	push   %ebp
  802307:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802309:	8b 55 0c             	mov    0xc(%ebp),%edx
  80230c:	8b 45 08             	mov    0x8(%ebp),%eax
  80230f:	6a 00                	push   $0x0
  802311:	6a 00                	push   $0x0
  802313:	6a 00                	push   $0x0
  802315:	52                   	push   %edx
  802316:	50                   	push   %eax
  802317:	6a 1b                	push   $0x1b
  802319:	e8 1c fd ff ff       	call   80203a <syscall>
  80231e:	83 c4 18             	add    $0x18,%esp
}
  802321:	c9                   	leave  
  802322:	c3                   	ret    

00802323 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802323:	55                   	push   %ebp
  802324:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802326:	8b 55 0c             	mov    0xc(%ebp),%edx
  802329:	8b 45 08             	mov    0x8(%ebp),%eax
  80232c:	6a 00                	push   $0x0
  80232e:	6a 00                	push   $0x0
  802330:	6a 00                	push   $0x0
  802332:	52                   	push   %edx
  802333:	50                   	push   %eax
  802334:	6a 19                	push   $0x19
  802336:	e8 ff fc ff ff       	call   80203a <syscall>
  80233b:	83 c4 18             	add    $0x18,%esp
}
  80233e:	90                   	nop
  80233f:	c9                   	leave  
  802340:	c3                   	ret    

00802341 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802341:	55                   	push   %ebp
  802342:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802344:	8b 55 0c             	mov    0xc(%ebp),%edx
  802347:	8b 45 08             	mov    0x8(%ebp),%eax
  80234a:	6a 00                	push   $0x0
  80234c:	6a 00                	push   $0x0
  80234e:	6a 00                	push   $0x0
  802350:	52                   	push   %edx
  802351:	50                   	push   %eax
  802352:	6a 1a                	push   $0x1a
  802354:	e8 e1 fc ff ff       	call   80203a <syscall>
  802359:	83 c4 18             	add    $0x18,%esp
}
  80235c:	90                   	nop
  80235d:	c9                   	leave  
  80235e:	c3                   	ret    

0080235f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80235f:	55                   	push   %ebp
  802360:	89 e5                	mov    %esp,%ebp
  802362:	83 ec 04             	sub    $0x4,%esp
  802365:	8b 45 10             	mov    0x10(%ebp),%eax
  802368:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80236b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80236e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802372:	8b 45 08             	mov    0x8(%ebp),%eax
  802375:	6a 00                	push   $0x0
  802377:	51                   	push   %ecx
  802378:	52                   	push   %edx
  802379:	ff 75 0c             	pushl  0xc(%ebp)
  80237c:	50                   	push   %eax
  80237d:	6a 1c                	push   $0x1c
  80237f:	e8 b6 fc ff ff       	call   80203a <syscall>
  802384:	83 c4 18             	add    $0x18,%esp
}
  802387:	c9                   	leave  
  802388:	c3                   	ret    

00802389 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802389:	55                   	push   %ebp
  80238a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80238c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80238f:	8b 45 08             	mov    0x8(%ebp),%eax
  802392:	6a 00                	push   $0x0
  802394:	6a 00                	push   $0x0
  802396:	6a 00                	push   $0x0
  802398:	52                   	push   %edx
  802399:	50                   	push   %eax
  80239a:	6a 1d                	push   $0x1d
  80239c:	e8 99 fc ff ff       	call   80203a <syscall>
  8023a1:	83 c4 18             	add    $0x18,%esp
}
  8023a4:	c9                   	leave  
  8023a5:	c3                   	ret    

008023a6 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8023a6:	55                   	push   %ebp
  8023a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8023a9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8023ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023af:	8b 45 08             	mov    0x8(%ebp),%eax
  8023b2:	6a 00                	push   $0x0
  8023b4:	6a 00                	push   $0x0
  8023b6:	51                   	push   %ecx
  8023b7:	52                   	push   %edx
  8023b8:	50                   	push   %eax
  8023b9:	6a 1e                	push   $0x1e
  8023bb:	e8 7a fc ff ff       	call   80203a <syscall>
  8023c0:	83 c4 18             	add    $0x18,%esp
}
  8023c3:	c9                   	leave  
  8023c4:	c3                   	ret    

008023c5 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8023c5:	55                   	push   %ebp
  8023c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8023c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8023ce:	6a 00                	push   $0x0
  8023d0:	6a 00                	push   $0x0
  8023d2:	6a 00                	push   $0x0
  8023d4:	52                   	push   %edx
  8023d5:	50                   	push   %eax
  8023d6:	6a 1f                	push   $0x1f
  8023d8:	e8 5d fc ff ff       	call   80203a <syscall>
  8023dd:	83 c4 18             	add    $0x18,%esp
}
  8023e0:	c9                   	leave  
  8023e1:	c3                   	ret    

008023e2 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8023e2:	55                   	push   %ebp
  8023e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8023e5:	6a 00                	push   $0x0
  8023e7:	6a 00                	push   $0x0
  8023e9:	6a 00                	push   $0x0
  8023eb:	6a 00                	push   $0x0
  8023ed:	6a 00                	push   $0x0
  8023ef:	6a 20                	push   $0x20
  8023f1:	e8 44 fc ff ff       	call   80203a <syscall>
  8023f6:	83 c4 18             	add    $0x18,%esp
}
  8023f9:	c9                   	leave  
  8023fa:	c3                   	ret    

008023fb <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8023fb:	55                   	push   %ebp
  8023fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8023fe:	8b 45 08             	mov    0x8(%ebp),%eax
  802401:	6a 00                	push   $0x0
  802403:	ff 75 14             	pushl  0x14(%ebp)
  802406:	ff 75 10             	pushl  0x10(%ebp)
  802409:	ff 75 0c             	pushl  0xc(%ebp)
  80240c:	50                   	push   %eax
  80240d:	6a 21                	push   $0x21
  80240f:	e8 26 fc ff ff       	call   80203a <syscall>
  802414:	83 c4 18             	add    $0x18,%esp
}
  802417:	c9                   	leave  
  802418:	c3                   	ret    

00802419 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802419:	55                   	push   %ebp
  80241a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80241c:	8b 45 08             	mov    0x8(%ebp),%eax
  80241f:	6a 00                	push   $0x0
  802421:	6a 00                	push   $0x0
  802423:	6a 00                	push   $0x0
  802425:	6a 00                	push   $0x0
  802427:	50                   	push   %eax
  802428:	6a 22                	push   $0x22
  80242a:	e8 0b fc ff ff       	call   80203a <syscall>
  80242f:	83 c4 18             	add    $0x18,%esp
}
  802432:	90                   	nop
  802433:	c9                   	leave  
  802434:	c3                   	ret    

00802435 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802435:	55                   	push   %ebp
  802436:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802438:	8b 45 08             	mov    0x8(%ebp),%eax
  80243b:	6a 00                	push   $0x0
  80243d:	6a 00                	push   $0x0
  80243f:	6a 00                	push   $0x0
  802441:	6a 00                	push   $0x0
  802443:	50                   	push   %eax
  802444:	6a 23                	push   $0x23
  802446:	e8 ef fb ff ff       	call   80203a <syscall>
  80244b:	83 c4 18             	add    $0x18,%esp
}
  80244e:	90                   	nop
  80244f:	c9                   	leave  
  802450:	c3                   	ret    

00802451 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802451:	55                   	push   %ebp
  802452:	89 e5                	mov    %esp,%ebp
  802454:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802457:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80245a:	8d 50 04             	lea    0x4(%eax),%edx
  80245d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802460:	6a 00                	push   $0x0
  802462:	6a 00                	push   $0x0
  802464:	6a 00                	push   $0x0
  802466:	52                   	push   %edx
  802467:	50                   	push   %eax
  802468:	6a 24                	push   $0x24
  80246a:	e8 cb fb ff ff       	call   80203a <syscall>
  80246f:	83 c4 18             	add    $0x18,%esp
	return result;
  802472:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802475:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802478:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80247b:	89 01                	mov    %eax,(%ecx)
  80247d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802480:	8b 45 08             	mov    0x8(%ebp),%eax
  802483:	c9                   	leave  
  802484:	c2 04 00             	ret    $0x4

00802487 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802487:	55                   	push   %ebp
  802488:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80248a:	6a 00                	push   $0x0
  80248c:	6a 00                	push   $0x0
  80248e:	ff 75 10             	pushl  0x10(%ebp)
  802491:	ff 75 0c             	pushl  0xc(%ebp)
  802494:	ff 75 08             	pushl  0x8(%ebp)
  802497:	6a 13                	push   $0x13
  802499:	e8 9c fb ff ff       	call   80203a <syscall>
  80249e:	83 c4 18             	add    $0x18,%esp
	return ;
  8024a1:	90                   	nop
}
  8024a2:	c9                   	leave  
  8024a3:	c3                   	ret    

008024a4 <sys_rcr2>:
uint32 sys_rcr2()
{
  8024a4:	55                   	push   %ebp
  8024a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8024a7:	6a 00                	push   $0x0
  8024a9:	6a 00                	push   $0x0
  8024ab:	6a 00                	push   $0x0
  8024ad:	6a 00                	push   $0x0
  8024af:	6a 00                	push   $0x0
  8024b1:	6a 25                	push   $0x25
  8024b3:	e8 82 fb ff ff       	call   80203a <syscall>
  8024b8:	83 c4 18             	add    $0x18,%esp
}
  8024bb:	c9                   	leave  
  8024bc:	c3                   	ret    

008024bd <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8024bd:	55                   	push   %ebp
  8024be:	89 e5                	mov    %esp,%ebp
  8024c0:	83 ec 04             	sub    $0x4,%esp
  8024c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8024c6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8024c9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8024cd:	6a 00                	push   $0x0
  8024cf:	6a 00                	push   $0x0
  8024d1:	6a 00                	push   $0x0
  8024d3:	6a 00                	push   $0x0
  8024d5:	50                   	push   %eax
  8024d6:	6a 26                	push   $0x26
  8024d8:	e8 5d fb ff ff       	call   80203a <syscall>
  8024dd:	83 c4 18             	add    $0x18,%esp
	return ;
  8024e0:	90                   	nop
}
  8024e1:	c9                   	leave  
  8024e2:	c3                   	ret    

008024e3 <rsttst>:
void rsttst()
{
  8024e3:	55                   	push   %ebp
  8024e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8024e6:	6a 00                	push   $0x0
  8024e8:	6a 00                	push   $0x0
  8024ea:	6a 00                	push   $0x0
  8024ec:	6a 00                	push   $0x0
  8024ee:	6a 00                	push   $0x0
  8024f0:	6a 28                	push   $0x28
  8024f2:	e8 43 fb ff ff       	call   80203a <syscall>
  8024f7:	83 c4 18             	add    $0x18,%esp
	return ;
  8024fa:	90                   	nop
}
  8024fb:	c9                   	leave  
  8024fc:	c3                   	ret    

008024fd <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8024fd:	55                   	push   %ebp
  8024fe:	89 e5                	mov    %esp,%ebp
  802500:	83 ec 04             	sub    $0x4,%esp
  802503:	8b 45 14             	mov    0x14(%ebp),%eax
  802506:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802509:	8b 55 18             	mov    0x18(%ebp),%edx
  80250c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802510:	52                   	push   %edx
  802511:	50                   	push   %eax
  802512:	ff 75 10             	pushl  0x10(%ebp)
  802515:	ff 75 0c             	pushl  0xc(%ebp)
  802518:	ff 75 08             	pushl  0x8(%ebp)
  80251b:	6a 27                	push   $0x27
  80251d:	e8 18 fb ff ff       	call   80203a <syscall>
  802522:	83 c4 18             	add    $0x18,%esp
	return ;
  802525:	90                   	nop
}
  802526:	c9                   	leave  
  802527:	c3                   	ret    

00802528 <chktst>:
void chktst(uint32 n)
{
  802528:	55                   	push   %ebp
  802529:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80252b:	6a 00                	push   $0x0
  80252d:	6a 00                	push   $0x0
  80252f:	6a 00                	push   $0x0
  802531:	6a 00                	push   $0x0
  802533:	ff 75 08             	pushl  0x8(%ebp)
  802536:	6a 29                	push   $0x29
  802538:	e8 fd fa ff ff       	call   80203a <syscall>
  80253d:	83 c4 18             	add    $0x18,%esp
	return ;
  802540:	90                   	nop
}
  802541:	c9                   	leave  
  802542:	c3                   	ret    

00802543 <inctst>:

void inctst()
{
  802543:	55                   	push   %ebp
  802544:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802546:	6a 00                	push   $0x0
  802548:	6a 00                	push   $0x0
  80254a:	6a 00                	push   $0x0
  80254c:	6a 00                	push   $0x0
  80254e:	6a 00                	push   $0x0
  802550:	6a 2a                	push   $0x2a
  802552:	e8 e3 fa ff ff       	call   80203a <syscall>
  802557:	83 c4 18             	add    $0x18,%esp
	return ;
  80255a:	90                   	nop
}
  80255b:	c9                   	leave  
  80255c:	c3                   	ret    

0080255d <gettst>:
uint32 gettst()
{
  80255d:	55                   	push   %ebp
  80255e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802560:	6a 00                	push   $0x0
  802562:	6a 00                	push   $0x0
  802564:	6a 00                	push   $0x0
  802566:	6a 00                	push   $0x0
  802568:	6a 00                	push   $0x0
  80256a:	6a 2b                	push   $0x2b
  80256c:	e8 c9 fa ff ff       	call   80203a <syscall>
  802571:	83 c4 18             	add    $0x18,%esp
}
  802574:	c9                   	leave  
  802575:	c3                   	ret    

00802576 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802576:	55                   	push   %ebp
  802577:	89 e5                	mov    %esp,%ebp
  802579:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80257c:	6a 00                	push   $0x0
  80257e:	6a 00                	push   $0x0
  802580:	6a 00                	push   $0x0
  802582:	6a 00                	push   $0x0
  802584:	6a 00                	push   $0x0
  802586:	6a 2c                	push   $0x2c
  802588:	e8 ad fa ff ff       	call   80203a <syscall>
  80258d:	83 c4 18             	add    $0x18,%esp
  802590:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802593:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802597:	75 07                	jne    8025a0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802599:	b8 01 00 00 00       	mov    $0x1,%eax
  80259e:	eb 05                	jmp    8025a5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8025a0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8025a5:	c9                   	leave  
  8025a6:	c3                   	ret    

008025a7 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8025a7:	55                   	push   %ebp
  8025a8:	89 e5                	mov    %esp,%ebp
  8025aa:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8025ad:	6a 00                	push   $0x0
  8025af:	6a 00                	push   $0x0
  8025b1:	6a 00                	push   $0x0
  8025b3:	6a 00                	push   $0x0
  8025b5:	6a 00                	push   $0x0
  8025b7:	6a 2c                	push   $0x2c
  8025b9:	e8 7c fa ff ff       	call   80203a <syscall>
  8025be:	83 c4 18             	add    $0x18,%esp
  8025c1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8025c4:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8025c8:	75 07                	jne    8025d1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8025ca:	b8 01 00 00 00       	mov    $0x1,%eax
  8025cf:	eb 05                	jmp    8025d6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8025d1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8025d6:	c9                   	leave  
  8025d7:	c3                   	ret    

008025d8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8025d8:	55                   	push   %ebp
  8025d9:	89 e5                	mov    %esp,%ebp
  8025db:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8025de:	6a 00                	push   $0x0
  8025e0:	6a 00                	push   $0x0
  8025e2:	6a 00                	push   $0x0
  8025e4:	6a 00                	push   $0x0
  8025e6:	6a 00                	push   $0x0
  8025e8:	6a 2c                	push   $0x2c
  8025ea:	e8 4b fa ff ff       	call   80203a <syscall>
  8025ef:	83 c4 18             	add    $0x18,%esp
  8025f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8025f5:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8025f9:	75 07                	jne    802602 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8025fb:	b8 01 00 00 00       	mov    $0x1,%eax
  802600:	eb 05                	jmp    802607 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802602:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802607:	c9                   	leave  
  802608:	c3                   	ret    

00802609 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802609:	55                   	push   %ebp
  80260a:	89 e5                	mov    %esp,%ebp
  80260c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80260f:	6a 00                	push   $0x0
  802611:	6a 00                	push   $0x0
  802613:	6a 00                	push   $0x0
  802615:	6a 00                	push   $0x0
  802617:	6a 00                	push   $0x0
  802619:	6a 2c                	push   $0x2c
  80261b:	e8 1a fa ff ff       	call   80203a <syscall>
  802620:	83 c4 18             	add    $0x18,%esp
  802623:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802626:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80262a:	75 07                	jne    802633 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80262c:	b8 01 00 00 00       	mov    $0x1,%eax
  802631:	eb 05                	jmp    802638 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802633:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802638:	c9                   	leave  
  802639:	c3                   	ret    

0080263a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80263a:	55                   	push   %ebp
  80263b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80263d:	6a 00                	push   $0x0
  80263f:	6a 00                	push   $0x0
  802641:	6a 00                	push   $0x0
  802643:	6a 00                	push   $0x0
  802645:	ff 75 08             	pushl  0x8(%ebp)
  802648:	6a 2d                	push   $0x2d
  80264a:	e8 eb f9 ff ff       	call   80203a <syscall>
  80264f:	83 c4 18             	add    $0x18,%esp
	return ;
  802652:	90                   	nop
}
  802653:	c9                   	leave  
  802654:	c3                   	ret    

00802655 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802655:	55                   	push   %ebp
  802656:	89 e5                	mov    %esp,%ebp
  802658:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802659:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80265c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80265f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802662:	8b 45 08             	mov    0x8(%ebp),%eax
  802665:	6a 00                	push   $0x0
  802667:	53                   	push   %ebx
  802668:	51                   	push   %ecx
  802669:	52                   	push   %edx
  80266a:	50                   	push   %eax
  80266b:	6a 2e                	push   $0x2e
  80266d:	e8 c8 f9 ff ff       	call   80203a <syscall>
  802672:	83 c4 18             	add    $0x18,%esp
}
  802675:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802678:	c9                   	leave  
  802679:	c3                   	ret    

0080267a <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80267a:	55                   	push   %ebp
  80267b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80267d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802680:	8b 45 08             	mov    0x8(%ebp),%eax
  802683:	6a 00                	push   $0x0
  802685:	6a 00                	push   $0x0
  802687:	6a 00                	push   $0x0
  802689:	52                   	push   %edx
  80268a:	50                   	push   %eax
  80268b:	6a 2f                	push   $0x2f
  80268d:	e8 a8 f9 ff ff       	call   80203a <syscall>
  802692:	83 c4 18             	add    $0x18,%esp
}
  802695:	c9                   	leave  
  802696:	c3                   	ret    
  802697:	90                   	nop

00802698 <__udivdi3>:
  802698:	55                   	push   %ebp
  802699:	57                   	push   %edi
  80269a:	56                   	push   %esi
  80269b:	53                   	push   %ebx
  80269c:	83 ec 1c             	sub    $0x1c,%esp
  80269f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8026a3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8026a7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8026ab:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8026af:	89 ca                	mov    %ecx,%edx
  8026b1:	89 f8                	mov    %edi,%eax
  8026b3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8026b7:	85 f6                	test   %esi,%esi
  8026b9:	75 2d                	jne    8026e8 <__udivdi3+0x50>
  8026bb:	39 cf                	cmp    %ecx,%edi
  8026bd:	77 65                	ja     802724 <__udivdi3+0x8c>
  8026bf:	89 fd                	mov    %edi,%ebp
  8026c1:	85 ff                	test   %edi,%edi
  8026c3:	75 0b                	jne    8026d0 <__udivdi3+0x38>
  8026c5:	b8 01 00 00 00       	mov    $0x1,%eax
  8026ca:	31 d2                	xor    %edx,%edx
  8026cc:	f7 f7                	div    %edi
  8026ce:	89 c5                	mov    %eax,%ebp
  8026d0:	31 d2                	xor    %edx,%edx
  8026d2:	89 c8                	mov    %ecx,%eax
  8026d4:	f7 f5                	div    %ebp
  8026d6:	89 c1                	mov    %eax,%ecx
  8026d8:	89 d8                	mov    %ebx,%eax
  8026da:	f7 f5                	div    %ebp
  8026dc:	89 cf                	mov    %ecx,%edi
  8026de:	89 fa                	mov    %edi,%edx
  8026e0:	83 c4 1c             	add    $0x1c,%esp
  8026e3:	5b                   	pop    %ebx
  8026e4:	5e                   	pop    %esi
  8026e5:	5f                   	pop    %edi
  8026e6:	5d                   	pop    %ebp
  8026e7:	c3                   	ret    
  8026e8:	39 ce                	cmp    %ecx,%esi
  8026ea:	77 28                	ja     802714 <__udivdi3+0x7c>
  8026ec:	0f bd fe             	bsr    %esi,%edi
  8026ef:	83 f7 1f             	xor    $0x1f,%edi
  8026f2:	75 40                	jne    802734 <__udivdi3+0x9c>
  8026f4:	39 ce                	cmp    %ecx,%esi
  8026f6:	72 0a                	jb     802702 <__udivdi3+0x6a>
  8026f8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8026fc:	0f 87 9e 00 00 00    	ja     8027a0 <__udivdi3+0x108>
  802702:	b8 01 00 00 00       	mov    $0x1,%eax
  802707:	89 fa                	mov    %edi,%edx
  802709:	83 c4 1c             	add    $0x1c,%esp
  80270c:	5b                   	pop    %ebx
  80270d:	5e                   	pop    %esi
  80270e:	5f                   	pop    %edi
  80270f:	5d                   	pop    %ebp
  802710:	c3                   	ret    
  802711:	8d 76 00             	lea    0x0(%esi),%esi
  802714:	31 ff                	xor    %edi,%edi
  802716:	31 c0                	xor    %eax,%eax
  802718:	89 fa                	mov    %edi,%edx
  80271a:	83 c4 1c             	add    $0x1c,%esp
  80271d:	5b                   	pop    %ebx
  80271e:	5e                   	pop    %esi
  80271f:	5f                   	pop    %edi
  802720:	5d                   	pop    %ebp
  802721:	c3                   	ret    
  802722:	66 90                	xchg   %ax,%ax
  802724:	89 d8                	mov    %ebx,%eax
  802726:	f7 f7                	div    %edi
  802728:	31 ff                	xor    %edi,%edi
  80272a:	89 fa                	mov    %edi,%edx
  80272c:	83 c4 1c             	add    $0x1c,%esp
  80272f:	5b                   	pop    %ebx
  802730:	5e                   	pop    %esi
  802731:	5f                   	pop    %edi
  802732:	5d                   	pop    %ebp
  802733:	c3                   	ret    
  802734:	bd 20 00 00 00       	mov    $0x20,%ebp
  802739:	89 eb                	mov    %ebp,%ebx
  80273b:	29 fb                	sub    %edi,%ebx
  80273d:	89 f9                	mov    %edi,%ecx
  80273f:	d3 e6                	shl    %cl,%esi
  802741:	89 c5                	mov    %eax,%ebp
  802743:	88 d9                	mov    %bl,%cl
  802745:	d3 ed                	shr    %cl,%ebp
  802747:	89 e9                	mov    %ebp,%ecx
  802749:	09 f1                	or     %esi,%ecx
  80274b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80274f:	89 f9                	mov    %edi,%ecx
  802751:	d3 e0                	shl    %cl,%eax
  802753:	89 c5                	mov    %eax,%ebp
  802755:	89 d6                	mov    %edx,%esi
  802757:	88 d9                	mov    %bl,%cl
  802759:	d3 ee                	shr    %cl,%esi
  80275b:	89 f9                	mov    %edi,%ecx
  80275d:	d3 e2                	shl    %cl,%edx
  80275f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802763:	88 d9                	mov    %bl,%cl
  802765:	d3 e8                	shr    %cl,%eax
  802767:	09 c2                	or     %eax,%edx
  802769:	89 d0                	mov    %edx,%eax
  80276b:	89 f2                	mov    %esi,%edx
  80276d:	f7 74 24 0c          	divl   0xc(%esp)
  802771:	89 d6                	mov    %edx,%esi
  802773:	89 c3                	mov    %eax,%ebx
  802775:	f7 e5                	mul    %ebp
  802777:	39 d6                	cmp    %edx,%esi
  802779:	72 19                	jb     802794 <__udivdi3+0xfc>
  80277b:	74 0b                	je     802788 <__udivdi3+0xf0>
  80277d:	89 d8                	mov    %ebx,%eax
  80277f:	31 ff                	xor    %edi,%edi
  802781:	e9 58 ff ff ff       	jmp    8026de <__udivdi3+0x46>
  802786:	66 90                	xchg   %ax,%ax
  802788:	8b 54 24 08          	mov    0x8(%esp),%edx
  80278c:	89 f9                	mov    %edi,%ecx
  80278e:	d3 e2                	shl    %cl,%edx
  802790:	39 c2                	cmp    %eax,%edx
  802792:	73 e9                	jae    80277d <__udivdi3+0xe5>
  802794:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802797:	31 ff                	xor    %edi,%edi
  802799:	e9 40 ff ff ff       	jmp    8026de <__udivdi3+0x46>
  80279e:	66 90                	xchg   %ax,%ax
  8027a0:	31 c0                	xor    %eax,%eax
  8027a2:	e9 37 ff ff ff       	jmp    8026de <__udivdi3+0x46>
  8027a7:	90                   	nop

008027a8 <__umoddi3>:
  8027a8:	55                   	push   %ebp
  8027a9:	57                   	push   %edi
  8027aa:	56                   	push   %esi
  8027ab:	53                   	push   %ebx
  8027ac:	83 ec 1c             	sub    $0x1c,%esp
  8027af:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8027b3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8027b7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8027bb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8027bf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8027c3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8027c7:	89 f3                	mov    %esi,%ebx
  8027c9:	89 fa                	mov    %edi,%edx
  8027cb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8027cf:	89 34 24             	mov    %esi,(%esp)
  8027d2:	85 c0                	test   %eax,%eax
  8027d4:	75 1a                	jne    8027f0 <__umoddi3+0x48>
  8027d6:	39 f7                	cmp    %esi,%edi
  8027d8:	0f 86 a2 00 00 00    	jbe    802880 <__umoddi3+0xd8>
  8027de:	89 c8                	mov    %ecx,%eax
  8027e0:	89 f2                	mov    %esi,%edx
  8027e2:	f7 f7                	div    %edi
  8027e4:	89 d0                	mov    %edx,%eax
  8027e6:	31 d2                	xor    %edx,%edx
  8027e8:	83 c4 1c             	add    $0x1c,%esp
  8027eb:	5b                   	pop    %ebx
  8027ec:	5e                   	pop    %esi
  8027ed:	5f                   	pop    %edi
  8027ee:	5d                   	pop    %ebp
  8027ef:	c3                   	ret    
  8027f0:	39 f0                	cmp    %esi,%eax
  8027f2:	0f 87 ac 00 00 00    	ja     8028a4 <__umoddi3+0xfc>
  8027f8:	0f bd e8             	bsr    %eax,%ebp
  8027fb:	83 f5 1f             	xor    $0x1f,%ebp
  8027fe:	0f 84 ac 00 00 00    	je     8028b0 <__umoddi3+0x108>
  802804:	bf 20 00 00 00       	mov    $0x20,%edi
  802809:	29 ef                	sub    %ebp,%edi
  80280b:	89 fe                	mov    %edi,%esi
  80280d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802811:	89 e9                	mov    %ebp,%ecx
  802813:	d3 e0                	shl    %cl,%eax
  802815:	89 d7                	mov    %edx,%edi
  802817:	89 f1                	mov    %esi,%ecx
  802819:	d3 ef                	shr    %cl,%edi
  80281b:	09 c7                	or     %eax,%edi
  80281d:	89 e9                	mov    %ebp,%ecx
  80281f:	d3 e2                	shl    %cl,%edx
  802821:	89 14 24             	mov    %edx,(%esp)
  802824:	89 d8                	mov    %ebx,%eax
  802826:	d3 e0                	shl    %cl,%eax
  802828:	89 c2                	mov    %eax,%edx
  80282a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80282e:	d3 e0                	shl    %cl,%eax
  802830:	89 44 24 04          	mov    %eax,0x4(%esp)
  802834:	8b 44 24 08          	mov    0x8(%esp),%eax
  802838:	89 f1                	mov    %esi,%ecx
  80283a:	d3 e8                	shr    %cl,%eax
  80283c:	09 d0                	or     %edx,%eax
  80283e:	d3 eb                	shr    %cl,%ebx
  802840:	89 da                	mov    %ebx,%edx
  802842:	f7 f7                	div    %edi
  802844:	89 d3                	mov    %edx,%ebx
  802846:	f7 24 24             	mull   (%esp)
  802849:	89 c6                	mov    %eax,%esi
  80284b:	89 d1                	mov    %edx,%ecx
  80284d:	39 d3                	cmp    %edx,%ebx
  80284f:	0f 82 87 00 00 00    	jb     8028dc <__umoddi3+0x134>
  802855:	0f 84 91 00 00 00    	je     8028ec <__umoddi3+0x144>
  80285b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80285f:	29 f2                	sub    %esi,%edx
  802861:	19 cb                	sbb    %ecx,%ebx
  802863:	89 d8                	mov    %ebx,%eax
  802865:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802869:	d3 e0                	shl    %cl,%eax
  80286b:	89 e9                	mov    %ebp,%ecx
  80286d:	d3 ea                	shr    %cl,%edx
  80286f:	09 d0                	or     %edx,%eax
  802871:	89 e9                	mov    %ebp,%ecx
  802873:	d3 eb                	shr    %cl,%ebx
  802875:	89 da                	mov    %ebx,%edx
  802877:	83 c4 1c             	add    $0x1c,%esp
  80287a:	5b                   	pop    %ebx
  80287b:	5e                   	pop    %esi
  80287c:	5f                   	pop    %edi
  80287d:	5d                   	pop    %ebp
  80287e:	c3                   	ret    
  80287f:	90                   	nop
  802880:	89 fd                	mov    %edi,%ebp
  802882:	85 ff                	test   %edi,%edi
  802884:	75 0b                	jne    802891 <__umoddi3+0xe9>
  802886:	b8 01 00 00 00       	mov    $0x1,%eax
  80288b:	31 d2                	xor    %edx,%edx
  80288d:	f7 f7                	div    %edi
  80288f:	89 c5                	mov    %eax,%ebp
  802891:	89 f0                	mov    %esi,%eax
  802893:	31 d2                	xor    %edx,%edx
  802895:	f7 f5                	div    %ebp
  802897:	89 c8                	mov    %ecx,%eax
  802899:	f7 f5                	div    %ebp
  80289b:	89 d0                	mov    %edx,%eax
  80289d:	e9 44 ff ff ff       	jmp    8027e6 <__umoddi3+0x3e>
  8028a2:	66 90                	xchg   %ax,%ax
  8028a4:	89 c8                	mov    %ecx,%eax
  8028a6:	89 f2                	mov    %esi,%edx
  8028a8:	83 c4 1c             	add    $0x1c,%esp
  8028ab:	5b                   	pop    %ebx
  8028ac:	5e                   	pop    %esi
  8028ad:	5f                   	pop    %edi
  8028ae:	5d                   	pop    %ebp
  8028af:	c3                   	ret    
  8028b0:	3b 04 24             	cmp    (%esp),%eax
  8028b3:	72 06                	jb     8028bb <__umoddi3+0x113>
  8028b5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8028b9:	77 0f                	ja     8028ca <__umoddi3+0x122>
  8028bb:	89 f2                	mov    %esi,%edx
  8028bd:	29 f9                	sub    %edi,%ecx
  8028bf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8028c3:	89 14 24             	mov    %edx,(%esp)
  8028c6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8028ca:	8b 44 24 04          	mov    0x4(%esp),%eax
  8028ce:	8b 14 24             	mov    (%esp),%edx
  8028d1:	83 c4 1c             	add    $0x1c,%esp
  8028d4:	5b                   	pop    %ebx
  8028d5:	5e                   	pop    %esi
  8028d6:	5f                   	pop    %edi
  8028d7:	5d                   	pop    %ebp
  8028d8:	c3                   	ret    
  8028d9:	8d 76 00             	lea    0x0(%esi),%esi
  8028dc:	2b 04 24             	sub    (%esp),%eax
  8028df:	19 fa                	sbb    %edi,%edx
  8028e1:	89 d1                	mov    %edx,%ecx
  8028e3:	89 c6                	mov    %eax,%esi
  8028e5:	e9 71 ff ff ff       	jmp    80285b <__umoddi3+0xb3>
  8028ea:	66 90                	xchg   %ax,%ax
  8028ec:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8028f0:	72 ea                	jb     8028dc <__umoddi3+0x134>
  8028f2:	89 d9                	mov    %ebx,%ecx
  8028f4:	e9 62 ff ff ff       	jmp    80285b <__umoddi3+0xb3>
