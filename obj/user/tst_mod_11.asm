
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
  800073:	e8 17 22 00 00       	call   80228f <sys_calculate_free_frames>
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
  8000c6:	e8 c4 21 00 00       	call   80228f <sys_calculate_free_frames>
  8000cb:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8000ce:	e8 3f 22 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
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
  800100:	68 00 2a 80 00       	push   $0x802a00
  800105:	6a 2c                	push   $0x2c
  800107:	68 65 2a 80 00       	push   $0x802a65
  80010c:	e8 b4 0b 00 00       	call   800cc5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512 ) panic("Extra or less pages are allocated in PageFile");
  800111:	e8 fc 21 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
  800116:	2b 45 bc             	sub    -0x44(%ebp),%eax
  800119:	3d 00 02 00 00       	cmp    $0x200,%eax
  80011e:	74 14                	je     800134 <_main+0xfc>
  800120:	83 ec 04             	sub    $0x4,%esp
  800123:	68 78 2a 80 00       	push   $0x802a78
  800128:	6a 2d                	push   $0x2d
  80012a:	68 65 2a 80 00       	push   $0x802a65
  80012f:	e8 91 0b 00 00       	call   800cc5 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800134:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  800137:	e8 53 21 00 00       	call   80228f <sys_calculate_free_frames>
  80013c:	29 c3                	sub    %eax,%ebx
  80013e:	89 d8                	mov    %ebx,%eax
  800140:	83 f8 01             	cmp    $0x1,%eax
  800143:	74 14                	je     800159 <_main+0x121>
  800145:	83 ec 04             	sub    $0x4,%esp
  800148:	68 a8 2a 80 00       	push   $0x802aa8
  80014d:	6a 2e                	push   $0x2e
  80014f:	68 65 2a 80 00       	push   $0x802a65
  800154:	e8 6c 0b 00 00       	call   800cc5 <_panic>
		lastIndices[0] = (2*Mega-kilo)/sizeof(char) - 1;
  800159:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80015c:	01 c0                	add    %eax,%eax
  80015e:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800161:	48                   	dec    %eax
  800162:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)

		//2 MB
		freeFrames = sys_calculate_free_frames() ;
  800168:	e8 22 21 00 00       	call   80228f <sys_calculate_free_frames>
  80016d:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800170:	e8 9d 21 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
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
  8001ab:	68 00 2a 80 00       	push   $0x802a00
  8001b0:	6a 35                	push   $0x35
  8001b2:	68 65 2a 80 00       	push   $0x802a65
  8001b7:	e8 09 0b 00 00       	call   800cc5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512 ) panic("Extra or less pages are allocated in PageFile");
  8001bc:	e8 51 21 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
  8001c1:	2b 45 bc             	sub    -0x44(%ebp),%eax
  8001c4:	3d 00 02 00 00       	cmp    $0x200,%eax
  8001c9:	74 14                	je     8001df <_main+0x1a7>
  8001cb:	83 ec 04             	sub    $0x4,%esp
  8001ce:	68 78 2a 80 00       	push   $0x802a78
  8001d3:	6a 36                	push   $0x36
  8001d5:	68 65 2a 80 00       	push   $0x802a65
  8001da:	e8 e6 0a 00 00       	call   800cc5 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  8001df:	e8 ab 20 00 00       	call   80228f <sys_calculate_free_frames>
  8001e4:	89 c2                	mov    %eax,%edx
  8001e6:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001e9:	39 c2                	cmp    %eax,%edx
  8001eb:	74 14                	je     800201 <_main+0x1c9>
  8001ed:	83 ec 04             	sub    $0x4,%esp
  8001f0:	68 a8 2a 80 00       	push   $0x802aa8
  8001f5:	6a 37                	push   $0x37
  8001f7:	68 65 2a 80 00       	push   $0x802a65
  8001fc:	e8 c4 0a 00 00       	call   800cc5 <_panic>
		lastIndices[1] = (2*Mega-kilo)/sizeof(char) - 1;
  800201:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800204:	01 c0                	add    %eax,%eax
  800206:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800209:	48                   	dec    %eax
  80020a:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  800210:	e8 7a 20 00 00       	call   80228f <sys_calculate_free_frames>
  800215:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800218:	e8 f5 20 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
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
  800251:	68 00 2a 80 00       	push   $0x802a00
  800256:	6a 3e                	push   $0x3e
  800258:	68 65 2a 80 00       	push   $0x802a65
  80025d:	e8 63 0a 00 00       	call   800cc5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1 ) panic("Extra or less pages are allocated in PageFile");
  800262:	e8 ab 20 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
  800267:	2b 45 bc             	sub    -0x44(%ebp),%eax
  80026a:	83 f8 01             	cmp    $0x1,%eax
  80026d:	74 14                	je     800283 <_main+0x24b>
  80026f:	83 ec 04             	sub    $0x4,%esp
  800272:	68 78 2a 80 00       	push   $0x802a78
  800277:	6a 3f                	push   $0x3f
  800279:	68 65 2a 80 00       	push   $0x802a65
  80027e:	e8 42 0a 00 00       	call   800cc5 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800283:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  800286:	e8 04 20 00 00       	call   80228f <sys_calculate_free_frames>
  80028b:	29 c3                	sub    %eax,%ebx
  80028d:	89 d8                	mov    %ebx,%eax
  80028f:	83 f8 01             	cmp    $0x1,%eax
  800292:	74 14                	je     8002a8 <_main+0x270>
  800294:	83 ec 04             	sub    $0x4,%esp
  800297:	68 a8 2a 80 00       	push   $0x802aa8
  80029c:	6a 40                	push   $0x40
  80029e:	68 65 2a 80 00       	push   $0x802a65
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
  8002df:	e8 ab 1f 00 00       	call   80228f <sys_calculate_free_frames>
  8002e4:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8002e7:	e8 26 20 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
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
  80032a:	68 00 2a 80 00       	push   $0x802a00
  80032f:	6a 4c                	push   $0x4c
  800331:	68 65 2a 80 00       	push   $0x802a65
  800336:	e8 8a 09 00 00       	call   800cc5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1 ) panic("Extra or less pages are allocated in PageFile");
  80033b:	e8 d2 1f 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
  800340:	2b 45 bc             	sub    -0x44(%ebp),%eax
  800343:	83 f8 01             	cmp    $0x1,%eax
  800346:	74 14                	je     80035c <_main+0x324>
  800348:	83 ec 04             	sub    $0x4,%esp
  80034b:	68 78 2a 80 00       	push   $0x802a78
  800350:	6a 4d                	push   $0x4d
  800352:	68 65 2a 80 00       	push   $0x802a65
  800357:	e8 69 09 00 00       	call   800cc5 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  80035c:	e8 2e 1f 00 00       	call   80228f <sys_calculate_free_frames>
  800361:	89 c2                	mov    %eax,%edx
  800363:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800366:	39 c2                	cmp    %eax,%edx
  800368:	74 14                	je     80037e <_main+0x346>
  80036a:	83 ec 04             	sub    $0x4,%esp
  80036d:	68 a8 2a 80 00       	push   $0x802aa8
  800372:	6a 4e                	push   $0x4e
  800374:	68 65 2a 80 00       	push   $0x802a65
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
  8003b5:	e8 d5 1e 00 00       	call   80228f <sys_calculate_free_frames>
  8003ba:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8003bd:	e8 50 1f 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
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
  800408:	68 00 2a 80 00       	push   $0x802a00
  80040d:	6a 5a                	push   $0x5a
  80040f:	68 65 2a 80 00       	push   $0x802a65
  800414:	e8 ac 08 00 00       	call   800cc5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2 ) panic("Extra or less pages are allocated in PageFile");
  800419:	e8 f4 1e 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
  80041e:	2b 45 bc             	sub    -0x44(%ebp),%eax
  800421:	83 f8 02             	cmp    $0x2,%eax
  800424:	74 14                	je     80043a <_main+0x402>
  800426:	83 ec 04             	sub    $0x4,%esp
  800429:	68 78 2a 80 00       	push   $0x802a78
  80042e:	6a 5b                	push   $0x5b
  800430:	68 65 2a 80 00       	push   $0x802a65
  800435:	e8 8b 08 00 00       	call   800cc5 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  80043a:	e8 50 1e 00 00       	call   80228f <sys_calculate_free_frames>
  80043f:	89 c2                	mov    %eax,%edx
  800441:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800444:	39 c2                	cmp    %eax,%edx
  800446:	74 14                	je     80045c <_main+0x424>
  800448:	83 ec 04             	sub    $0x4,%esp
  80044b:	68 a8 2a 80 00       	push   $0x802aa8
  800450:	6a 5c                	push   $0x5c
  800452:	68 65 2a 80 00       	push   $0x802a65
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
  80049e:	68 12 2b 80 00       	push   $0x802b12
  8004a3:	e8 bf 0a 00 00       	call   800f67 <cprintf>
  8004a8:	83 c4 10             	add    $0x10,%esp

		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  8004ab:	e8 df 1d 00 00       	call   80228f <sys_calculate_free_frames>
  8004b0:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8004b3:	e8 5a 1e 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
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
  8004fd:	68 00 2a 80 00       	push   $0x802a00
  800502:	6a 6a                	push   $0x6a
  800504:	68 65 2a 80 00       	push   $0x802a65
  800509:	e8 b7 07 00 00       	call   800cc5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 768 ) panic("Extra or less pages are allocated in PageFile");
  80050e:	e8 ff 1d 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
  800513:	2b 45 bc             	sub    -0x44(%ebp),%eax
  800516:	3d 00 03 00 00       	cmp    $0x300,%eax
  80051b:	74 14                	je     800531 <_main+0x4f9>
  80051d:	83 ec 04             	sub    $0x4,%esp
  800520:	68 78 2a 80 00       	push   $0x802a78
  800525:	6a 6b                	push   $0x6b
  800527:	68 65 2a 80 00       	push   $0x802a65
  80052c:	e8 94 07 00 00       	call   800cc5 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800531:	e8 59 1d 00 00       	call   80228f <sys_calculate_free_frames>
  800536:	89 c2                	mov    %eax,%edx
  800538:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80053b:	39 c2                	cmp    %eax,%edx
  80053d:	74 14                	je     800553 <_main+0x51b>
  80053f:	83 ec 04             	sub    $0x4,%esp
  800542:	68 a8 2a 80 00       	push   $0x802aa8
  800547:	6a 6c                	push   $0x6c
  800549:	68 65 2a 80 00       	push   $0x802a65
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
  800598:	68 17 2b 80 00       	push   $0x802b17
  80059d:	e8 c5 09 00 00       	call   800f67 <cprintf>
  8005a2:	83 c4 10             	add    $0x10,%esp

		//6 MB
		freeFrames = sys_calculate_free_frames() ;
  8005a5:	e8 e5 1c 00 00       	call   80228f <sys_calculate_free_frames>
  8005aa:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8005ad:	e8 60 1d 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
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
  8005fd:	68 00 2a 80 00       	push   $0x802a00
  800602:	6a 7a                	push   $0x7a
  800604:	68 65 2a 80 00       	push   $0x802a65
  800609:	e8 b7 06 00 00       	call   800cc5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1536 ) panic("Extra or less pages are allocated in PageFile");
  80060e:	e8 ff 1c 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
  800613:	2b 45 bc             	sub    -0x44(%ebp),%eax
  800616:	3d 00 06 00 00       	cmp    $0x600,%eax
  80061b:	74 14                	je     800631 <_main+0x5f9>
  80061d:	83 ec 04             	sub    $0x4,%esp
  800620:	68 78 2a 80 00       	push   $0x802a78
  800625:	6a 7b                	push   $0x7b
  800627:	68 65 2a 80 00       	push   $0x802a65
  80062c:	e8 94 06 00 00       	call   800cc5 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800631:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  800634:	e8 56 1c 00 00       	call   80228f <sys_calculate_free_frames>
  800639:	29 c3                	sub    %eax,%ebx
  80063b:	89 d8                	mov    %ebx,%eax
  80063d:	83 f8 02             	cmp    $0x2,%eax
  800640:	74 14                	je     800656 <_main+0x61e>
  800642:	83 ec 04             	sub    $0x4,%esp
  800645:	68 a8 2a 80 00       	push   $0x802aa8
  80064a:	6a 7c                	push   $0x7c
  80064c:	68 65 2a 80 00       	push   $0x802a65
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
  8006f4:	68 1c 2b 80 00       	push   $0x802b1c
  8006f9:	e8 69 08 00 00       	call   800f67 <cprintf>
  8006fe:	83 c4 10             	add    $0x10,%esp
	}


	//Shrink last allocated variable to 5 MB instead of 6 MB
	{
		freeFrames = sys_calculate_free_frames() ;
  800701:	e8 89 1b 00 00       	call   80228f <sys_calculate_free_frames>
  800706:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800709:	e8 04 1c 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
  80070e:	89 45 bc             	mov    %eax,-0x44(%ebp)

		shrink(5*Mega) ;
  800711:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800714:	89 d0                	mov    %edx,%eax
  800716:	c1 e0 02             	shl    $0x2,%eax
  800719:	01 d0                	add    %edx,%eax
  80071b:	83 ec 0c             	sub    $0xc,%esp
  80071e:	50                   	push   %eax
  80071f:	e8 c5 19 00 00       	call   8020e9 <shrink>
  800724:	83 c4 10             	add    $0x10,%esp

		assert(usedDiskPages - sys_pf_calculate_allocated_pages() == 256) ;
  800727:	e8 e6 1b 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
  80072c:	8b 55 bc             	mov    -0x44(%ebp),%edx
  80072f:	29 c2                	sub    %eax,%edx
  800731:	89 d0                	mov    %edx,%eax
  800733:	3d 00 01 00 00       	cmp    $0x100,%eax
  800738:	74 19                	je     800753 <_main+0x71b>
  80073a:	68 24 2b 80 00       	push   $0x802b24
  80073f:	68 5e 2b 80 00       	push   $0x802b5e
  800744:	68 99 00 00 00       	push   $0x99
  800749:	68 65 2a 80 00       	push   $0x802a65
  80074e:	e8 72 05 00 00       	call   800cc5 <_panic>
		assert(sys_calculate_free_frames() - freeFrames == expectedNumOfFrames1) ;
  800753:	e8 37 1b 00 00       	call   80228f <sys_calculate_free_frames>
  800758:	89 c2                	mov    %eax,%edx
  80075a:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80075d:	29 c2                	sub    %eax,%edx
  80075f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800762:	39 c2                	cmp    %eax,%edx
  800764:	74 19                	je     80077f <_main+0x747>
  800766:	68 74 2b 80 00       	push   $0x802b74
  80076b:	68 5e 2b 80 00       	push   $0x802b5e
  800770:	68 9a 00 00 00       	push   $0x9a
  800775:	68 65 2a 80 00       	push   $0x802a65
  80077a:	e8 46 05 00 00       	call   800cc5 <_panic>
	}
	cprintf("4/9\n");
  80077f:	83 ec 0c             	sub    $0xc,%esp
  800782:	68 b5 2b 80 00       	push   $0x802bb5
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
  8007c8:	68 ba 2b 80 00       	push   $0x802bba
  8007cd:	68 5e 2b 80 00       	push   $0x802b5e
  8007d2:	68 a4 00 00 00       	push   $0xa4
  8007d7:	68 65 2a 80 00       	push   $0x802a65
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
  80083e:	68 c6 2b 80 00       	push   $0x802bc6
  800843:	e8 1f 07 00 00       	call   800f67 <cprintf>
  800848:	83 c4 10             	add    $0x10,%esp

		//Bypass the PAGE FAULT on <MOVB immediate, reg> instruction by setting its length
		//and continue executing the remaining code
		sys_bypassPageFault(3);
  80084b:	83 ec 0c             	sub    $0xc,%esp
  80084e:	6a 03                	push   $0x3
  800850:	e8 51 1d 00 00       	call   8025a6 <sys_bypassPageFault>
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
  800875:	e8 13 1d 00 00       	call   80258d <sys_rcr2>
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
  800891:	68 cc 2b 80 00       	push   $0x802bcc
  800896:	68 5e 2b 80 00       	push   $0x802b5e
  80089b:	68 b9 00 00 00       	push   $0xb9
  8008a0:	68 65 2a 80 00       	push   $0x802a65
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
  8008c6:	e8 c2 1c 00 00       	call   80258d <sys_rcr2>
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
  8008ea:	68 f4 2b 80 00       	push   $0x802bf4
  8008ef:	68 5e 2b 80 00       	push   $0x802b5e
  8008f4:	68 bc 00 00 00       	push   $0xbc
  8008f9:	68 65 2a 80 00       	push   $0x802a65
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
  80091b:	e8 6d 1c 00 00       	call   80258d <sys_rcr2>
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
  80093b:	68 20 2c 80 00       	push   $0x802c20
  800940:	68 5e 2b 80 00       	push   $0x802b5e
  800945:	68 bf 00 00 00       	push   $0xbf
  80094a:	68 65 2a 80 00       	push   $0x802a65
  80094f:	e8 71 03 00 00       	call   800cc5 <_panic>

		//set it to 0 again to cancel the bypassing option
		sys_bypassPageFault(0);
  800954:	83 ec 0c             	sub    $0xc,%esp
  800957:	6a 00                	push   $0x0
  800959:	e8 48 1c 00 00       	call   8025a6 <sys_bypassPageFault>
  80095e:	83 c4 10             	add    $0x10,%esp
	}

	cprintf("6/9\n");
  800961:	83 ec 0c             	sub    $0xc,%esp
  800964:	68 4c 2c 80 00       	push   $0x802c4c
  800969:	e8 f9 05 00 00       	call   800f67 <cprintf>
  80096e:	83 c4 10             	add    $0x10,%esp

	//Shrink it again to 2 MB instead of 5 MB
	{
		freeFrames = sys_calculate_free_frames() ;
  800971:	e8 19 19 00 00       	call   80228f <sys_calculate_free_frames>
  800976:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800979:	e8 94 19 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
  80097e:	89 45 bc             	mov    %eax,-0x44(%ebp)

		shrink(2*Mega) ;
  800981:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800984:	01 c0                	add    %eax,%eax
  800986:	83 ec 0c             	sub    $0xc,%esp
  800989:	50                   	push   %eax
  80098a:	e8 5a 17 00 00       	call   8020e9 <shrink>
  80098f:	83 c4 10             	add    $0x10,%esp

		assert(usedDiskPages - sys_pf_calculate_allocated_pages() == 768) ;
  800992:	e8 7b 19 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
  800997:	8b 55 bc             	mov    -0x44(%ebp),%edx
  80099a:	29 c2                	sub    %eax,%edx
  80099c:	89 d0                	mov    %edx,%eax
  80099e:	3d 00 03 00 00       	cmp    $0x300,%eax
  8009a3:	74 19                	je     8009be <_main+0x986>
  8009a5:	68 54 2c 80 00       	push   $0x802c54
  8009aa:	68 5e 2b 80 00       	push   $0x802b5e
  8009af:	68 ce 00 00 00       	push   $0xce
  8009b4:	68 65 2a 80 00       	push   $0x802a65
  8009b9:	e8 07 03 00 00       	call   800cc5 <_panic>
		assert(sys_calculate_free_frames() - freeFrames == expectedNumOfFrames2 + 1 /*table*/) ;
  8009be:	e8 cc 18 00 00       	call   80228f <sys_calculate_free_frames>
  8009c3:	89 c2                	mov    %eax,%edx
  8009c5:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8009c8:	29 c2                	sub    %eax,%edx
  8009ca:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009cd:	40                   	inc    %eax
  8009ce:	39 c2                	cmp    %eax,%edx
  8009d0:	74 19                	je     8009eb <_main+0x9b3>
  8009d2:	68 90 2c 80 00       	push   $0x802c90
  8009d7:	68 5e 2b 80 00       	push   $0x802b5e
  8009dc:	68 cf 00 00 00       	push   $0xcf
  8009e1:	68 65 2a 80 00       	push   $0x802a65
  8009e6:	e8 da 02 00 00       	call   800cc5 <_panic>
	}

	cprintf("7/9\n");
  8009eb:	83 ec 0c             	sub    $0xc,%esp
  8009ee:	68 d5 2c 80 00       	push   $0x802cd5
  8009f3:	e8 6f 05 00 00       	call   800f67 <cprintf>
  8009f8:	83 c4 10             	add    $0x10,%esp

	//Allocate after shrinking last var
	{
		//4 MB
		freeFrames = sys_calculate_free_frames() ;
  8009fb:	e8 8f 18 00 00       	call   80228f <sys_calculate_free_frames>
  800a00:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800a03:	e8 0a 19 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
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
  800a55:	68 dc 2c 80 00       	push   $0x802cdc
  800a5a:	68 da 00 00 00       	push   $0xda
  800a5f:	68 65 2a 80 00       	push   $0x802a65
  800a64:	e8 5c 02 00 00       	call   800cc5 <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 4*Mega/PAGE_SIZE ) panic("Extra or less pages are allocated in PageFile");
  800a69:	e8 a4 18 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
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
  800a8c:	68 78 2a 80 00       	push   $0x802a78
  800a91:	68 db 00 00 00       	push   $0xdb
  800a96:	68 65 2a 80 00       	push   $0x802a65
  800a9b:	e8 25 02 00 00       	call   800cc5 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: either extra pages are allocated in memory or pages not allocated correctly on PageFile");
  800aa0:	e8 ea 17 00 00       	call   80228f <sys_calculate_free_frames>
  800aa5:	89 c2                	mov    %eax,%edx
  800aa7:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800aaa:	39 c2                	cmp    %eax,%edx
  800aac:	74 17                	je     800ac5 <_main+0xa8d>
  800aae:	83 ec 04             	sub    $0x4,%esp
  800ab1:	68 a8 2a 80 00       	push   $0x802aa8
  800ab6:	68 dc 00 00 00       	push   $0xdc
  800abb:	68 65 2a 80 00       	push   $0x802a65
  800ac0:	e8 00 02 00 00       	call   800cc5 <_panic>
	}

	cprintf("8/9\n");
  800ac5:	83 ec 0c             	sub    $0xc,%esp
  800ac8:	68 03 2d 80 00       	push   $0x802d03
  800acd:	e8 95 04 00 00       	call   800f67 <cprintf>
  800ad2:	83 c4 10             	add    $0x10,%esp

	//free the shrunk variable
	{
		//kfree 2 MB (shrunk)
		freeFrames = sys_calculate_free_frames() ;
  800ad5:	e8 b5 17 00 00       	call   80228f <sys_calculate_free_frames>
  800ada:	89 45 c0             	mov    %eax,-0x40(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800add:	e8 30 18 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
  800ae2:	89 45 bc             	mov    %eax,-0x44(%ebp)
		free(ptr_allocations[6]);
  800ae5:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  800aeb:	83 ec 0c             	sub    $0xc,%esp
  800aee:	50                   	push   %eax
  800aef:	e8 c5 14 00 00       	call   801fb9 <free>
  800af4:	83 c4 10             	add    $0x10,%esp
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2*Mega/PAGE_SIZE ) panic("Extra or less pages are allocated in PageFile");
  800af7:	e8 16 18 00 00       	call   802312 <sys_pf_calculate_allocated_pages>
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
  800b19:	68 78 2a 80 00       	push   $0x802a78
  800b1e:	68 e7 00 00 00       	push   $0xe7
  800b23:	68 65 2a 80 00       	push   $0x802a65
  800b28:	e8 98 01 00 00       	call   800cc5 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != expectedNumOfFrames3 + 1 /*table*/) panic("Wrong kfree: attempt to kfree a non-existing ptr. It should do nothing");
  800b2d:	e8 5d 17 00 00       	call   80228f <sys_calculate_free_frames>
  800b32:	89 c2                	mov    %eax,%edx
  800b34:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800b37:	29 c2                	sub    %eax,%edx
  800b39:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b3c:	40                   	inc    %eax
  800b3d:	39 c2                	cmp    %eax,%edx
  800b3f:	74 17                	je     800b58 <_main+0xb20>
  800b41:	83 ec 04             	sub    $0x4,%esp
  800b44:	68 08 2d 80 00       	push   $0x802d08
  800b49:	68 e8 00 00 00       	push   $0xe8
  800b4e:	68 65 2a 80 00       	push   $0x802a65
  800b53:	e8 6d 01 00 00       	call   800cc5 <_panic>
//		shrink(4*Mega - 20*kilo) ;
//
//		assert(usedDiskPages  - sys_pf_calculate_allocated_pages() == 5) ;
//		assert(sys_calculate_free_frames() - freeFrames == 0) ;
//	}
	cprintf("9/9\n");
  800b58:	83 ec 0c             	sub    $0xc,%esp
  800b5b:	68 4f 2d 80 00       	push   $0x802d4f
  800b60:	e8 02 04 00 00       	call   800f67 <cprintf>
  800b65:	83 c4 10             	add    $0x10,%esp

	cprintf("\nCongratulations!! your modification is run successfully.\n");
  800b68:	83 ec 0c             	sub    $0xc,%esp
  800b6b:	68 54 2d 80 00       	push   $0x802d54
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
  800b86:	e8 39 16 00 00       	call   8021c4 <sys_getenvindex>
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
  800c03:	e8 57 17 00 00       	call   80235f <sys_disable_interrupt>
	cprintf("**************************************\n");
  800c08:	83 ec 0c             	sub    $0xc,%esp
  800c0b:	68 a8 2d 80 00       	push   $0x802da8
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
  800c33:	68 d0 2d 80 00       	push   $0x802dd0
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
  800c5b:	68 f8 2d 80 00       	push   $0x802df8
  800c60:	e8 02 03 00 00       	call   800f67 <cprintf>
  800c65:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800c68:	a1 20 40 80 00       	mov    0x804020,%eax
  800c6d:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800c73:	83 ec 08             	sub    $0x8,%esp
  800c76:	50                   	push   %eax
  800c77:	68 39 2e 80 00       	push   $0x802e39
  800c7c:	e8 e6 02 00 00       	call   800f67 <cprintf>
  800c81:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800c84:	83 ec 0c             	sub    $0xc,%esp
  800c87:	68 a8 2d 80 00       	push   $0x802da8
  800c8c:	e8 d6 02 00 00       	call   800f67 <cprintf>
  800c91:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800c94:	e8 e0 16 00 00       	call   802379 <sys_enable_interrupt>

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
  800cac:	e8 df 14 00 00       	call   802190 <sys_env_destroy>
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
  800cbd:	e8 34 15 00 00       	call   8021f6 <sys_env_exit>
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
  800ce6:	68 50 2e 80 00       	push   $0x802e50
  800ceb:	e8 77 02 00 00       	call   800f67 <cprintf>
  800cf0:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800cf3:	a1 00 40 80 00       	mov    0x804000,%eax
  800cf8:	ff 75 0c             	pushl  0xc(%ebp)
  800cfb:	ff 75 08             	pushl  0x8(%ebp)
  800cfe:	50                   	push   %eax
  800cff:	68 55 2e 80 00       	push   $0x802e55
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
  800d23:	68 71 2e 80 00       	push   $0x802e71
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
  800d4f:	68 74 2e 80 00       	push   $0x802e74
  800d54:	6a 26                	push   $0x26
  800d56:	68 c0 2e 80 00       	push   $0x802ec0
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
  800e15:	68 cc 2e 80 00       	push   $0x802ecc
  800e1a:	6a 3a                	push   $0x3a
  800e1c:	68 c0 2e 80 00       	push   $0x802ec0
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
  800e7f:	68 20 2f 80 00       	push   $0x802f20
  800e84:	6a 44                	push   $0x44
  800e86:	68 c0 2e 80 00       	push   $0x802ec0
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
  800ed9:	e8 70 12 00 00       	call   80214e <sys_cputs>
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
  800f50:	e8 f9 11 00 00       	call   80214e <sys_cputs>
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
  800f9a:	e8 c0 13 00 00       	call   80235f <sys_disable_interrupt>
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
  800fba:	e8 ba 13 00 00       	call   802379 <sys_enable_interrupt>
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
  801004:	e8 77 17 00 00       	call   802780 <__udivdi3>
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
  801054:	e8 37 18 00 00       	call   802890 <__umoddi3>
  801059:	83 c4 10             	add    $0x10,%esp
  80105c:	05 94 31 80 00       	add    $0x803194,%eax
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
  8011af:	8b 04 85 b8 31 80 00 	mov    0x8031b8(,%eax,4),%eax
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
  801290:	8b 34 9d 00 30 80 00 	mov    0x803000(,%ebx,4),%esi
  801297:	85 f6                	test   %esi,%esi
  801299:	75 19                	jne    8012b4 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80129b:	53                   	push   %ebx
  80129c:	68 a5 31 80 00       	push   $0x8031a5
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
  8012b5:	68 ae 31 80 00       	push   $0x8031ae
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
  8012e2:	be b1 31 80 00       	mov    $0x8031b1,%esi
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
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  801cf1:	55                   	push   %ebp
  801cf2:	89 e5                	mov    %esp,%ebp
  801cf4:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  801cf7:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  801cfe:	76 0a                	jbe    801d0a <malloc+0x19>
		return NULL;
  801d00:	b8 00 00 00 00       	mov    $0x0,%eax
  801d05:	e9 ad 02 00 00       	jmp    801fb7 <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  801d0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d0d:	c1 e8 0c             	shr    $0xc,%eax
  801d10:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  801d13:	8b 45 08             	mov    0x8(%ebp),%eax
  801d16:	25 ff 0f 00 00       	and    $0xfff,%eax
  801d1b:	85 c0                	test   %eax,%eax
  801d1d:	74 03                	je     801d22 <malloc+0x31>
		num++;
  801d1f:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  801d22:	a1 28 40 80 00       	mov    0x804028,%eax
  801d27:	85 c0                	test   %eax,%eax
  801d29:	75 71                	jne    801d9c <malloc+0xab>
		sys_allocateMem(last_addres, size);
  801d2b:	a1 04 40 80 00       	mov    0x804004,%eax
  801d30:	83 ec 08             	sub    $0x8,%esp
  801d33:	ff 75 08             	pushl  0x8(%ebp)
  801d36:	50                   	push   %eax
  801d37:	e8 ba 05 00 00       	call   8022f6 <sys_allocateMem>
  801d3c:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  801d3f:	a1 04 40 80 00       	mov    0x804004,%eax
  801d44:	89 45 c8             	mov    %eax,-0x38(%ebp)
		last_addres += num * PAGE_SIZE;
  801d47:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d4a:	c1 e0 0c             	shl    $0xc,%eax
  801d4d:	89 c2                	mov    %eax,%edx
  801d4f:	a1 04 40 80 00       	mov    0x804004,%eax
  801d54:	01 d0                	add    %edx,%eax
  801d56:	a3 04 40 80 00       	mov    %eax,0x804004
		numOfPages[sizeofarray] = num;
  801d5b:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801d60:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801d63:	89 14 85 a0 90 92 00 	mov    %edx,0x9290a0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  801d6a:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801d6f:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801d72:	89 14 85 a0 5b 86 00 	mov    %edx,0x865ba0(,%eax,4)
		changed[sizeofarray] = 1;
  801d79:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801d7e:	c7 04 85 20 76 8c 00 	movl   $0x1,0x8c7620(,%eax,4)
  801d85:	01 00 00 00 
		sizeofarray++;
  801d89:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801d8e:	40                   	inc    %eax
  801d8f:	a3 2c 40 80 00       	mov    %eax,0x80402c
		return (void*) return_addres;
  801d94:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801d97:	e9 1b 02 00 00       	jmp    801fb7 <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  801d9c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  801da3:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  801daa:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  801db1:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  801db8:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  801dbf:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801dc6:	eb 72                	jmp    801e3a <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  801dc8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801dcb:	8b 04 85 20 76 8c 00 	mov    0x8c7620(,%eax,4),%eax
  801dd2:	85 c0                	test   %eax,%eax
  801dd4:	75 12                	jne    801de8 <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  801dd6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801dd9:	8b 04 85 a0 90 92 00 	mov    0x9290a0(,%eax,4),%eax
  801de0:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  801de3:	ff 45 dc             	incl   -0x24(%ebp)
  801de6:	eb 4f                	jmp    801e37 <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  801de8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801deb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801dee:	7d 39                	jge    801e29 <malloc+0x138>
  801df0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801df3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801df6:	7c 31                	jl     801e29 <malloc+0x138>
					{
						min=count;
  801df8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801dfb:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  801dfe:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801e01:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  801e08:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801e0b:	c1 e2 0c             	shl    $0xc,%edx
  801e0e:	29 d0                	sub    %edx,%eax
  801e10:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  801e13:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801e16:	2b 45 dc             	sub    -0x24(%ebp),%eax
  801e19:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  801e1c:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  801e23:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801e26:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  801e29:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  801e30:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  801e37:	ff 45 d4             	incl   -0x2c(%ebp)
  801e3a:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801e3f:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  801e42:	7c 84                	jl     801dc8 <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  801e44:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  801e48:	0f 85 e3 00 00 00    	jne    801f31 <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  801e4e:	83 ec 08             	sub    $0x8,%esp
  801e51:	ff 75 08             	pushl  0x8(%ebp)
  801e54:	ff 75 e0             	pushl  -0x20(%ebp)
  801e57:	e8 9a 04 00 00       	call   8022f6 <sys_allocateMem>
  801e5c:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  801e5f:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801e64:	40                   	inc    %eax
  801e65:	a3 2c 40 80 00       	mov    %eax,0x80402c
				for(int i=sizeofarray-1;i>index;i--)
  801e6a:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801e6f:	48                   	dec    %eax
  801e70:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801e73:	eb 42                	jmp    801eb7 <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  801e75:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801e78:	48                   	dec    %eax
  801e79:	8b 14 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%edx
  801e80:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801e83:	89 14 85 a0 5b 86 00 	mov    %edx,0x865ba0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  801e8a:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801e8d:	48                   	dec    %eax
  801e8e:	8b 14 85 a0 90 92 00 	mov    0x9290a0(,%eax,4),%edx
  801e95:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801e98:	89 14 85 a0 90 92 00 	mov    %edx,0x9290a0(,%eax,4)
					changed[i]=changed[i-1];
  801e9f:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801ea2:	48                   	dec    %eax
  801ea3:	8b 14 85 20 76 8c 00 	mov    0x8c7620(,%eax,4),%edx
  801eaa:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801ead:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  801eb4:	ff 4d d0             	decl   -0x30(%ebp)
  801eb7:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801eba:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801ebd:	7f b6                	jg     801e75 <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  801ebf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801ec2:	40                   	inc    %eax
  801ec3:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  801ec6:	8b 55 08             	mov    0x8(%ebp),%edx
  801ec9:	01 ca                	add    %ecx,%edx
  801ecb:	89 14 85 a0 5b 86 00 	mov    %edx,0x865ba0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  801ed2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801ed5:	8d 50 01             	lea    0x1(%eax),%edx
  801ed8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801edb:	8b 04 85 a0 90 92 00 	mov    0x9290a0(,%eax,4),%eax
  801ee2:	2b 45 f4             	sub    -0xc(%ebp),%eax
  801ee5:	89 04 95 a0 90 92 00 	mov    %eax,0x9290a0(,%edx,4)
				changed[index+1]=0;
  801eec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801eef:	40                   	inc    %eax
  801ef0:	c7 04 85 20 76 8c 00 	movl   $0x0,0x8c7620(,%eax,4)
  801ef7:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  801efb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801efe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801f01:	89 14 85 a0 90 92 00 	mov    %edx,0x9290a0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  801f08:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801f0b:	89 45 cc             	mov    %eax,-0x34(%ebp)
  801f0e:	eb 11                	jmp    801f21 <malloc+0x230>
				{
					changed[index] = 1;
  801f10:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801f13:	c7 04 85 20 76 8c 00 	movl   $0x1,0x8c7620(,%eax,4)
  801f1a:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  801f1e:	ff 45 cc             	incl   -0x34(%ebp)
  801f21:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801f24:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801f27:	7c e7                	jl     801f10 <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  801f29:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801f2c:	e9 86 00 00 00       	jmp    801fb7 <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  801f31:	a1 04 40 80 00       	mov    0x804004,%eax
  801f36:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  801f3b:	29 c2                	sub    %eax,%edx
  801f3d:	89 d0                	mov    %edx,%eax
  801f3f:	3b 45 08             	cmp    0x8(%ebp),%eax
  801f42:	73 07                	jae    801f4b <malloc+0x25a>
						return NULL;
  801f44:	b8 00 00 00 00       	mov    $0x0,%eax
  801f49:	eb 6c                	jmp    801fb7 <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  801f4b:	a1 04 40 80 00       	mov    0x804004,%eax
  801f50:	83 ec 08             	sub    $0x8,%esp
  801f53:	ff 75 08             	pushl  0x8(%ebp)
  801f56:	50                   	push   %eax
  801f57:	e8 9a 03 00 00       	call   8022f6 <sys_allocateMem>
  801f5c:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  801f5f:	a1 04 40 80 00       	mov    0x804004,%eax
  801f64:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  801f67:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f6a:	c1 e0 0c             	shl    $0xc,%eax
  801f6d:	89 c2                	mov    %eax,%edx
  801f6f:	a1 04 40 80 00       	mov    0x804004,%eax
  801f74:	01 d0                	add    %edx,%eax
  801f76:	a3 04 40 80 00       	mov    %eax,0x804004
					numOfPages[sizeofarray] = num;
  801f7b:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801f80:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801f83:	89 14 85 a0 90 92 00 	mov    %edx,0x9290a0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  801f8a:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801f8f:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801f92:	89 14 85 a0 5b 86 00 	mov    %edx,0x865ba0(,%eax,4)
					changed[sizeofarray] = 1;
  801f99:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801f9e:	c7 04 85 20 76 8c 00 	movl   $0x1,0x8c7620(,%eax,4)
  801fa5:	01 00 00 00 
					sizeofarray++;
  801fa9:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801fae:	40                   	inc    %eax
  801faf:	a3 2c 40 80 00       	mov    %eax,0x80402c
					return (void*) return_addres;
  801fb4:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  801fb7:	c9                   	leave  
  801fb8:	c3                   	ret    

00801fb9 <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801fb9:	55                   	push   %ebp
  801fba:	89 e5                	mov    %esp,%ebp
  801fbc:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801fbf:	8b 45 08             	mov    0x8(%ebp),%eax
  801fc2:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  801fc5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801fcc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801fd3:	eb 30                	jmp    802005 <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  801fd5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801fd8:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  801fdf:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801fe2:	75 1e                	jne    802002 <free+0x49>
  801fe4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801fe7:	8b 04 85 20 76 8c 00 	mov    0x8c7620(,%eax,4),%eax
  801fee:	83 f8 01             	cmp    $0x1,%eax
  801ff1:	75 0f                	jne    802002 <free+0x49>
			is_found = 1;
  801ff3:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  801ffa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801ffd:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  802000:	eb 0d                	jmp    80200f <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  802002:	ff 45 ec             	incl   -0x14(%ebp)
  802005:	a1 2c 40 80 00       	mov    0x80402c,%eax
  80200a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  80200d:	7c c6                	jl     801fd5 <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  80200f:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  802013:	75 3a                	jne    80204f <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  802015:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802018:	8b 04 85 a0 90 92 00 	mov    0x9290a0(,%eax,4),%eax
  80201f:	c1 e0 0c             	shl    $0xc,%eax
  802022:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  802025:	83 ec 08             	sub    $0x8,%esp
  802028:	ff 75 e4             	pushl  -0x1c(%ebp)
  80202b:	ff 75 e8             	pushl  -0x18(%ebp)
  80202e:	e8 a7 02 00 00       	call   8022da <sys_freeMem>
  802033:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  802036:	8b 45 f0             	mov    -0x10(%ebp),%eax
  802039:	c7 04 85 20 76 8c 00 	movl   $0x0,0x8c7620(,%eax,4)
  802040:	00 00 00 00 
		changes++;
  802044:	a1 28 40 80 00       	mov    0x804028,%eax
  802049:	40                   	inc    %eax
  80204a:	a3 28 40 80 00       	mov    %eax,0x804028
	}
	//refer to the project presentation and documentation for details
}
  80204f:	90                   	nop
  802050:	c9                   	leave  
  802051:	c3                   	ret    

00802052 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  802052:	55                   	push   %ebp
  802053:	89 e5                	mov    %esp,%ebp
  802055:	83 ec 18             	sub    $0x18,%esp
  802058:	8b 45 10             	mov    0x10(%ebp),%eax
  80205b:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  80205e:	83 ec 04             	sub    $0x4,%esp
  802061:	68 10 33 80 00       	push   $0x803310
  802066:	68 b6 00 00 00       	push   $0xb6
  80206b:	68 33 33 80 00       	push   $0x803333
  802070:	e8 50 ec ff ff       	call   800cc5 <_panic>

00802075 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  802075:	55                   	push   %ebp
  802076:	89 e5                	mov    %esp,%ebp
  802078:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80207b:	83 ec 04             	sub    $0x4,%esp
  80207e:	68 10 33 80 00       	push   $0x803310
  802083:	68 bb 00 00 00       	push   $0xbb
  802088:	68 33 33 80 00       	push   $0x803333
  80208d:	e8 33 ec ff ff       	call   800cc5 <_panic>

00802092 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  802092:	55                   	push   %ebp
  802093:	89 e5                	mov    %esp,%ebp
  802095:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802098:	83 ec 04             	sub    $0x4,%esp
  80209b:	68 10 33 80 00       	push   $0x803310
  8020a0:	68 c0 00 00 00       	push   $0xc0
  8020a5:	68 33 33 80 00       	push   $0x803333
  8020aa:	e8 16 ec ff ff       	call   800cc5 <_panic>

008020af <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  8020af:	55                   	push   %ebp
  8020b0:	89 e5                	mov    %esp,%ebp
  8020b2:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8020b5:	83 ec 04             	sub    $0x4,%esp
  8020b8:	68 10 33 80 00       	push   $0x803310
  8020bd:	68 c4 00 00 00       	push   $0xc4
  8020c2:	68 33 33 80 00       	push   $0x803333
  8020c7:	e8 f9 eb ff ff       	call   800cc5 <_panic>

008020cc <expand>:
	return 0;
}

void expand(uint32 newSize) {
  8020cc:	55                   	push   %ebp
  8020cd:	89 e5                	mov    %esp,%ebp
  8020cf:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8020d2:	83 ec 04             	sub    $0x4,%esp
  8020d5:	68 10 33 80 00       	push   $0x803310
  8020da:	68 c9 00 00 00       	push   $0xc9
  8020df:	68 33 33 80 00       	push   $0x803333
  8020e4:	e8 dc eb ff ff       	call   800cc5 <_panic>

008020e9 <shrink>:
}
void shrink(uint32 newSize) {
  8020e9:	55                   	push   %ebp
  8020ea:	89 e5                	mov    %esp,%ebp
  8020ec:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8020ef:	83 ec 04             	sub    $0x4,%esp
  8020f2:	68 10 33 80 00       	push   $0x803310
  8020f7:	68 cc 00 00 00       	push   $0xcc
  8020fc:	68 33 33 80 00       	push   $0x803333
  802101:	e8 bf eb ff ff       	call   800cc5 <_panic>

00802106 <freeHeap>:
}

void freeHeap(void* virtual_address) {
  802106:	55                   	push   %ebp
  802107:	89 e5                	mov    %esp,%ebp
  802109:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80210c:	83 ec 04             	sub    $0x4,%esp
  80210f:	68 10 33 80 00       	push   $0x803310
  802114:	68 d0 00 00 00       	push   $0xd0
  802119:	68 33 33 80 00       	push   $0x803333
  80211e:	e8 a2 eb ff ff       	call   800cc5 <_panic>

00802123 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  802123:	55                   	push   %ebp
  802124:	89 e5                	mov    %esp,%ebp
  802126:	57                   	push   %edi
  802127:	56                   	push   %esi
  802128:	53                   	push   %ebx
  802129:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80212c:	8b 45 08             	mov    0x8(%ebp),%eax
  80212f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802132:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802135:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802138:	8b 7d 18             	mov    0x18(%ebp),%edi
  80213b:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80213e:	cd 30                	int    $0x30
  802140:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802143:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802146:	83 c4 10             	add    $0x10,%esp
  802149:	5b                   	pop    %ebx
  80214a:	5e                   	pop    %esi
  80214b:	5f                   	pop    %edi
  80214c:	5d                   	pop    %ebp
  80214d:	c3                   	ret    

0080214e <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80214e:	55                   	push   %ebp
  80214f:	89 e5                	mov    %esp,%ebp
  802151:	83 ec 04             	sub    $0x4,%esp
  802154:	8b 45 10             	mov    0x10(%ebp),%eax
  802157:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80215a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80215e:	8b 45 08             	mov    0x8(%ebp),%eax
  802161:	6a 00                	push   $0x0
  802163:	6a 00                	push   $0x0
  802165:	52                   	push   %edx
  802166:	ff 75 0c             	pushl  0xc(%ebp)
  802169:	50                   	push   %eax
  80216a:	6a 00                	push   $0x0
  80216c:	e8 b2 ff ff ff       	call   802123 <syscall>
  802171:	83 c4 18             	add    $0x18,%esp
}
  802174:	90                   	nop
  802175:	c9                   	leave  
  802176:	c3                   	ret    

00802177 <sys_cgetc>:

int
sys_cgetc(void)
{
  802177:	55                   	push   %ebp
  802178:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80217a:	6a 00                	push   $0x0
  80217c:	6a 00                	push   $0x0
  80217e:	6a 00                	push   $0x0
  802180:	6a 00                	push   $0x0
  802182:	6a 00                	push   $0x0
  802184:	6a 01                	push   $0x1
  802186:	e8 98 ff ff ff       	call   802123 <syscall>
  80218b:	83 c4 18             	add    $0x18,%esp
}
  80218e:	c9                   	leave  
  80218f:	c3                   	ret    

00802190 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802190:	55                   	push   %ebp
  802191:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802193:	8b 45 08             	mov    0x8(%ebp),%eax
  802196:	6a 00                	push   $0x0
  802198:	6a 00                	push   $0x0
  80219a:	6a 00                	push   $0x0
  80219c:	6a 00                	push   $0x0
  80219e:	50                   	push   %eax
  80219f:	6a 05                	push   $0x5
  8021a1:	e8 7d ff ff ff       	call   802123 <syscall>
  8021a6:	83 c4 18             	add    $0x18,%esp
}
  8021a9:	c9                   	leave  
  8021aa:	c3                   	ret    

008021ab <sys_getenvid>:

int32 sys_getenvid(void)
{
  8021ab:	55                   	push   %ebp
  8021ac:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8021ae:	6a 00                	push   $0x0
  8021b0:	6a 00                	push   $0x0
  8021b2:	6a 00                	push   $0x0
  8021b4:	6a 00                	push   $0x0
  8021b6:	6a 00                	push   $0x0
  8021b8:	6a 02                	push   $0x2
  8021ba:	e8 64 ff ff ff       	call   802123 <syscall>
  8021bf:	83 c4 18             	add    $0x18,%esp
}
  8021c2:	c9                   	leave  
  8021c3:	c3                   	ret    

008021c4 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8021c4:	55                   	push   %ebp
  8021c5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8021c7:	6a 00                	push   $0x0
  8021c9:	6a 00                	push   $0x0
  8021cb:	6a 00                	push   $0x0
  8021cd:	6a 00                	push   $0x0
  8021cf:	6a 00                	push   $0x0
  8021d1:	6a 03                	push   $0x3
  8021d3:	e8 4b ff ff ff       	call   802123 <syscall>
  8021d8:	83 c4 18             	add    $0x18,%esp
}
  8021db:	c9                   	leave  
  8021dc:	c3                   	ret    

008021dd <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8021dd:	55                   	push   %ebp
  8021de:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8021e0:	6a 00                	push   $0x0
  8021e2:	6a 00                	push   $0x0
  8021e4:	6a 00                	push   $0x0
  8021e6:	6a 00                	push   $0x0
  8021e8:	6a 00                	push   $0x0
  8021ea:	6a 04                	push   $0x4
  8021ec:	e8 32 ff ff ff       	call   802123 <syscall>
  8021f1:	83 c4 18             	add    $0x18,%esp
}
  8021f4:	c9                   	leave  
  8021f5:	c3                   	ret    

008021f6 <sys_env_exit>:


void sys_env_exit(void)
{
  8021f6:	55                   	push   %ebp
  8021f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8021f9:	6a 00                	push   $0x0
  8021fb:	6a 00                	push   $0x0
  8021fd:	6a 00                	push   $0x0
  8021ff:	6a 00                	push   $0x0
  802201:	6a 00                	push   $0x0
  802203:	6a 06                	push   $0x6
  802205:	e8 19 ff ff ff       	call   802123 <syscall>
  80220a:	83 c4 18             	add    $0x18,%esp
}
  80220d:	90                   	nop
  80220e:	c9                   	leave  
  80220f:	c3                   	ret    

00802210 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802210:	55                   	push   %ebp
  802211:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  802213:	8b 55 0c             	mov    0xc(%ebp),%edx
  802216:	8b 45 08             	mov    0x8(%ebp),%eax
  802219:	6a 00                	push   $0x0
  80221b:	6a 00                	push   $0x0
  80221d:	6a 00                	push   $0x0
  80221f:	52                   	push   %edx
  802220:	50                   	push   %eax
  802221:	6a 07                	push   $0x7
  802223:	e8 fb fe ff ff       	call   802123 <syscall>
  802228:	83 c4 18             	add    $0x18,%esp
}
  80222b:	c9                   	leave  
  80222c:	c3                   	ret    

0080222d <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80222d:	55                   	push   %ebp
  80222e:	89 e5                	mov    %esp,%ebp
  802230:	56                   	push   %esi
  802231:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802232:	8b 75 18             	mov    0x18(%ebp),%esi
  802235:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802238:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80223b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80223e:	8b 45 08             	mov    0x8(%ebp),%eax
  802241:	56                   	push   %esi
  802242:	53                   	push   %ebx
  802243:	51                   	push   %ecx
  802244:	52                   	push   %edx
  802245:	50                   	push   %eax
  802246:	6a 08                	push   $0x8
  802248:	e8 d6 fe ff ff       	call   802123 <syscall>
  80224d:	83 c4 18             	add    $0x18,%esp
}
  802250:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802253:	5b                   	pop    %ebx
  802254:	5e                   	pop    %esi
  802255:	5d                   	pop    %ebp
  802256:	c3                   	ret    

00802257 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802257:	55                   	push   %ebp
  802258:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80225a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80225d:	8b 45 08             	mov    0x8(%ebp),%eax
  802260:	6a 00                	push   $0x0
  802262:	6a 00                	push   $0x0
  802264:	6a 00                	push   $0x0
  802266:	52                   	push   %edx
  802267:	50                   	push   %eax
  802268:	6a 09                	push   $0x9
  80226a:	e8 b4 fe ff ff       	call   802123 <syscall>
  80226f:	83 c4 18             	add    $0x18,%esp
}
  802272:	c9                   	leave  
  802273:	c3                   	ret    

00802274 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802274:	55                   	push   %ebp
  802275:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802277:	6a 00                	push   $0x0
  802279:	6a 00                	push   $0x0
  80227b:	6a 00                	push   $0x0
  80227d:	ff 75 0c             	pushl  0xc(%ebp)
  802280:	ff 75 08             	pushl  0x8(%ebp)
  802283:	6a 0a                	push   $0xa
  802285:	e8 99 fe ff ff       	call   802123 <syscall>
  80228a:	83 c4 18             	add    $0x18,%esp
}
  80228d:	c9                   	leave  
  80228e:	c3                   	ret    

0080228f <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80228f:	55                   	push   %ebp
  802290:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802292:	6a 00                	push   $0x0
  802294:	6a 00                	push   $0x0
  802296:	6a 00                	push   $0x0
  802298:	6a 00                	push   $0x0
  80229a:	6a 00                	push   $0x0
  80229c:	6a 0b                	push   $0xb
  80229e:	e8 80 fe ff ff       	call   802123 <syscall>
  8022a3:	83 c4 18             	add    $0x18,%esp
}
  8022a6:	c9                   	leave  
  8022a7:	c3                   	ret    

008022a8 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8022a8:	55                   	push   %ebp
  8022a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8022ab:	6a 00                	push   $0x0
  8022ad:	6a 00                	push   $0x0
  8022af:	6a 00                	push   $0x0
  8022b1:	6a 00                	push   $0x0
  8022b3:	6a 00                	push   $0x0
  8022b5:	6a 0c                	push   $0xc
  8022b7:	e8 67 fe ff ff       	call   802123 <syscall>
  8022bc:	83 c4 18             	add    $0x18,%esp
}
  8022bf:	c9                   	leave  
  8022c0:	c3                   	ret    

008022c1 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8022c1:	55                   	push   %ebp
  8022c2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8022c4:	6a 00                	push   $0x0
  8022c6:	6a 00                	push   $0x0
  8022c8:	6a 00                	push   $0x0
  8022ca:	6a 00                	push   $0x0
  8022cc:	6a 00                	push   $0x0
  8022ce:	6a 0d                	push   $0xd
  8022d0:	e8 4e fe ff ff       	call   802123 <syscall>
  8022d5:	83 c4 18             	add    $0x18,%esp
}
  8022d8:	c9                   	leave  
  8022d9:	c3                   	ret    

008022da <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8022da:	55                   	push   %ebp
  8022db:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8022dd:	6a 00                	push   $0x0
  8022df:	6a 00                	push   $0x0
  8022e1:	6a 00                	push   $0x0
  8022e3:	ff 75 0c             	pushl  0xc(%ebp)
  8022e6:	ff 75 08             	pushl  0x8(%ebp)
  8022e9:	6a 11                	push   $0x11
  8022eb:	e8 33 fe ff ff       	call   802123 <syscall>
  8022f0:	83 c4 18             	add    $0x18,%esp
	return;
  8022f3:	90                   	nop
}
  8022f4:	c9                   	leave  
  8022f5:	c3                   	ret    

008022f6 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8022f6:	55                   	push   %ebp
  8022f7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8022f9:	6a 00                	push   $0x0
  8022fb:	6a 00                	push   $0x0
  8022fd:	6a 00                	push   $0x0
  8022ff:	ff 75 0c             	pushl  0xc(%ebp)
  802302:	ff 75 08             	pushl  0x8(%ebp)
  802305:	6a 12                	push   $0x12
  802307:	e8 17 fe ff ff       	call   802123 <syscall>
  80230c:	83 c4 18             	add    $0x18,%esp
	return ;
  80230f:	90                   	nop
}
  802310:	c9                   	leave  
  802311:	c3                   	ret    

00802312 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  802312:	55                   	push   %ebp
  802313:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  802315:	6a 00                	push   $0x0
  802317:	6a 00                	push   $0x0
  802319:	6a 00                	push   $0x0
  80231b:	6a 00                	push   $0x0
  80231d:	6a 00                	push   $0x0
  80231f:	6a 0e                	push   $0xe
  802321:	e8 fd fd ff ff       	call   802123 <syscall>
  802326:	83 c4 18             	add    $0x18,%esp
}
  802329:	c9                   	leave  
  80232a:	c3                   	ret    

0080232b <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80232b:	55                   	push   %ebp
  80232c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80232e:	6a 00                	push   $0x0
  802330:	6a 00                	push   $0x0
  802332:	6a 00                	push   $0x0
  802334:	6a 00                	push   $0x0
  802336:	ff 75 08             	pushl  0x8(%ebp)
  802339:	6a 0f                	push   $0xf
  80233b:	e8 e3 fd ff ff       	call   802123 <syscall>
  802340:	83 c4 18             	add    $0x18,%esp
}
  802343:	c9                   	leave  
  802344:	c3                   	ret    

00802345 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802345:	55                   	push   %ebp
  802346:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802348:	6a 00                	push   $0x0
  80234a:	6a 00                	push   $0x0
  80234c:	6a 00                	push   $0x0
  80234e:	6a 00                	push   $0x0
  802350:	6a 00                	push   $0x0
  802352:	6a 10                	push   $0x10
  802354:	e8 ca fd ff ff       	call   802123 <syscall>
  802359:	83 c4 18             	add    $0x18,%esp
}
  80235c:	90                   	nop
  80235d:	c9                   	leave  
  80235e:	c3                   	ret    

0080235f <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80235f:	55                   	push   %ebp
  802360:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802362:	6a 00                	push   $0x0
  802364:	6a 00                	push   $0x0
  802366:	6a 00                	push   $0x0
  802368:	6a 00                	push   $0x0
  80236a:	6a 00                	push   $0x0
  80236c:	6a 14                	push   $0x14
  80236e:	e8 b0 fd ff ff       	call   802123 <syscall>
  802373:	83 c4 18             	add    $0x18,%esp
}
  802376:	90                   	nop
  802377:	c9                   	leave  
  802378:	c3                   	ret    

00802379 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802379:	55                   	push   %ebp
  80237a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80237c:	6a 00                	push   $0x0
  80237e:	6a 00                	push   $0x0
  802380:	6a 00                	push   $0x0
  802382:	6a 00                	push   $0x0
  802384:	6a 00                	push   $0x0
  802386:	6a 15                	push   $0x15
  802388:	e8 96 fd ff ff       	call   802123 <syscall>
  80238d:	83 c4 18             	add    $0x18,%esp
}
  802390:	90                   	nop
  802391:	c9                   	leave  
  802392:	c3                   	ret    

00802393 <sys_cputc>:


void
sys_cputc(const char c)
{
  802393:	55                   	push   %ebp
  802394:	89 e5                	mov    %esp,%ebp
  802396:	83 ec 04             	sub    $0x4,%esp
  802399:	8b 45 08             	mov    0x8(%ebp),%eax
  80239c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80239f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8023a3:	6a 00                	push   $0x0
  8023a5:	6a 00                	push   $0x0
  8023a7:	6a 00                	push   $0x0
  8023a9:	6a 00                	push   $0x0
  8023ab:	50                   	push   %eax
  8023ac:	6a 16                	push   $0x16
  8023ae:	e8 70 fd ff ff       	call   802123 <syscall>
  8023b3:	83 c4 18             	add    $0x18,%esp
}
  8023b6:	90                   	nop
  8023b7:	c9                   	leave  
  8023b8:	c3                   	ret    

008023b9 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8023b9:	55                   	push   %ebp
  8023ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8023bc:	6a 00                	push   $0x0
  8023be:	6a 00                	push   $0x0
  8023c0:	6a 00                	push   $0x0
  8023c2:	6a 00                	push   $0x0
  8023c4:	6a 00                	push   $0x0
  8023c6:	6a 17                	push   $0x17
  8023c8:	e8 56 fd ff ff       	call   802123 <syscall>
  8023cd:	83 c4 18             	add    $0x18,%esp
}
  8023d0:	90                   	nop
  8023d1:	c9                   	leave  
  8023d2:	c3                   	ret    

008023d3 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8023d3:	55                   	push   %ebp
  8023d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8023d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8023d9:	6a 00                	push   $0x0
  8023db:	6a 00                	push   $0x0
  8023dd:	6a 00                	push   $0x0
  8023df:	ff 75 0c             	pushl  0xc(%ebp)
  8023e2:	50                   	push   %eax
  8023e3:	6a 18                	push   $0x18
  8023e5:	e8 39 fd ff ff       	call   802123 <syscall>
  8023ea:	83 c4 18             	add    $0x18,%esp
}
  8023ed:	c9                   	leave  
  8023ee:	c3                   	ret    

008023ef <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8023ef:	55                   	push   %ebp
  8023f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8023f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8023f8:	6a 00                	push   $0x0
  8023fa:	6a 00                	push   $0x0
  8023fc:	6a 00                	push   $0x0
  8023fe:	52                   	push   %edx
  8023ff:	50                   	push   %eax
  802400:	6a 1b                	push   $0x1b
  802402:	e8 1c fd ff ff       	call   802123 <syscall>
  802407:	83 c4 18             	add    $0x18,%esp
}
  80240a:	c9                   	leave  
  80240b:	c3                   	ret    

0080240c <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80240c:	55                   	push   %ebp
  80240d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80240f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802412:	8b 45 08             	mov    0x8(%ebp),%eax
  802415:	6a 00                	push   $0x0
  802417:	6a 00                	push   $0x0
  802419:	6a 00                	push   $0x0
  80241b:	52                   	push   %edx
  80241c:	50                   	push   %eax
  80241d:	6a 19                	push   $0x19
  80241f:	e8 ff fc ff ff       	call   802123 <syscall>
  802424:	83 c4 18             	add    $0x18,%esp
}
  802427:	90                   	nop
  802428:	c9                   	leave  
  802429:	c3                   	ret    

0080242a <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80242a:	55                   	push   %ebp
  80242b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80242d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802430:	8b 45 08             	mov    0x8(%ebp),%eax
  802433:	6a 00                	push   $0x0
  802435:	6a 00                	push   $0x0
  802437:	6a 00                	push   $0x0
  802439:	52                   	push   %edx
  80243a:	50                   	push   %eax
  80243b:	6a 1a                	push   $0x1a
  80243d:	e8 e1 fc ff ff       	call   802123 <syscall>
  802442:	83 c4 18             	add    $0x18,%esp
}
  802445:	90                   	nop
  802446:	c9                   	leave  
  802447:	c3                   	ret    

00802448 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802448:	55                   	push   %ebp
  802449:	89 e5                	mov    %esp,%ebp
  80244b:	83 ec 04             	sub    $0x4,%esp
  80244e:	8b 45 10             	mov    0x10(%ebp),%eax
  802451:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802454:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802457:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80245b:	8b 45 08             	mov    0x8(%ebp),%eax
  80245e:	6a 00                	push   $0x0
  802460:	51                   	push   %ecx
  802461:	52                   	push   %edx
  802462:	ff 75 0c             	pushl  0xc(%ebp)
  802465:	50                   	push   %eax
  802466:	6a 1c                	push   $0x1c
  802468:	e8 b6 fc ff ff       	call   802123 <syscall>
  80246d:	83 c4 18             	add    $0x18,%esp
}
  802470:	c9                   	leave  
  802471:	c3                   	ret    

00802472 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802472:	55                   	push   %ebp
  802473:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802475:	8b 55 0c             	mov    0xc(%ebp),%edx
  802478:	8b 45 08             	mov    0x8(%ebp),%eax
  80247b:	6a 00                	push   $0x0
  80247d:	6a 00                	push   $0x0
  80247f:	6a 00                	push   $0x0
  802481:	52                   	push   %edx
  802482:	50                   	push   %eax
  802483:	6a 1d                	push   $0x1d
  802485:	e8 99 fc ff ff       	call   802123 <syscall>
  80248a:	83 c4 18             	add    $0x18,%esp
}
  80248d:	c9                   	leave  
  80248e:	c3                   	ret    

0080248f <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80248f:	55                   	push   %ebp
  802490:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802492:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802495:	8b 55 0c             	mov    0xc(%ebp),%edx
  802498:	8b 45 08             	mov    0x8(%ebp),%eax
  80249b:	6a 00                	push   $0x0
  80249d:	6a 00                	push   $0x0
  80249f:	51                   	push   %ecx
  8024a0:	52                   	push   %edx
  8024a1:	50                   	push   %eax
  8024a2:	6a 1e                	push   $0x1e
  8024a4:	e8 7a fc ff ff       	call   802123 <syscall>
  8024a9:	83 c4 18             	add    $0x18,%esp
}
  8024ac:	c9                   	leave  
  8024ad:	c3                   	ret    

008024ae <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8024ae:	55                   	push   %ebp
  8024af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8024b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8024b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8024b7:	6a 00                	push   $0x0
  8024b9:	6a 00                	push   $0x0
  8024bb:	6a 00                	push   $0x0
  8024bd:	52                   	push   %edx
  8024be:	50                   	push   %eax
  8024bf:	6a 1f                	push   $0x1f
  8024c1:	e8 5d fc ff ff       	call   802123 <syscall>
  8024c6:	83 c4 18             	add    $0x18,%esp
}
  8024c9:	c9                   	leave  
  8024ca:	c3                   	ret    

008024cb <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8024cb:	55                   	push   %ebp
  8024cc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8024ce:	6a 00                	push   $0x0
  8024d0:	6a 00                	push   $0x0
  8024d2:	6a 00                	push   $0x0
  8024d4:	6a 00                	push   $0x0
  8024d6:	6a 00                	push   $0x0
  8024d8:	6a 20                	push   $0x20
  8024da:	e8 44 fc ff ff       	call   802123 <syscall>
  8024df:	83 c4 18             	add    $0x18,%esp
}
  8024e2:	c9                   	leave  
  8024e3:	c3                   	ret    

008024e4 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8024e4:	55                   	push   %ebp
  8024e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8024e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8024ea:	6a 00                	push   $0x0
  8024ec:	ff 75 14             	pushl  0x14(%ebp)
  8024ef:	ff 75 10             	pushl  0x10(%ebp)
  8024f2:	ff 75 0c             	pushl  0xc(%ebp)
  8024f5:	50                   	push   %eax
  8024f6:	6a 21                	push   $0x21
  8024f8:	e8 26 fc ff ff       	call   802123 <syscall>
  8024fd:	83 c4 18             	add    $0x18,%esp
}
  802500:	c9                   	leave  
  802501:	c3                   	ret    

00802502 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802502:	55                   	push   %ebp
  802503:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802505:	8b 45 08             	mov    0x8(%ebp),%eax
  802508:	6a 00                	push   $0x0
  80250a:	6a 00                	push   $0x0
  80250c:	6a 00                	push   $0x0
  80250e:	6a 00                	push   $0x0
  802510:	50                   	push   %eax
  802511:	6a 22                	push   $0x22
  802513:	e8 0b fc ff ff       	call   802123 <syscall>
  802518:	83 c4 18             	add    $0x18,%esp
}
  80251b:	90                   	nop
  80251c:	c9                   	leave  
  80251d:	c3                   	ret    

0080251e <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80251e:	55                   	push   %ebp
  80251f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802521:	8b 45 08             	mov    0x8(%ebp),%eax
  802524:	6a 00                	push   $0x0
  802526:	6a 00                	push   $0x0
  802528:	6a 00                	push   $0x0
  80252a:	6a 00                	push   $0x0
  80252c:	50                   	push   %eax
  80252d:	6a 23                	push   $0x23
  80252f:	e8 ef fb ff ff       	call   802123 <syscall>
  802534:	83 c4 18             	add    $0x18,%esp
}
  802537:	90                   	nop
  802538:	c9                   	leave  
  802539:	c3                   	ret    

0080253a <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80253a:	55                   	push   %ebp
  80253b:	89 e5                	mov    %esp,%ebp
  80253d:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802540:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802543:	8d 50 04             	lea    0x4(%eax),%edx
  802546:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802549:	6a 00                	push   $0x0
  80254b:	6a 00                	push   $0x0
  80254d:	6a 00                	push   $0x0
  80254f:	52                   	push   %edx
  802550:	50                   	push   %eax
  802551:	6a 24                	push   $0x24
  802553:	e8 cb fb ff ff       	call   802123 <syscall>
  802558:	83 c4 18             	add    $0x18,%esp
	return result;
  80255b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80255e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802561:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802564:	89 01                	mov    %eax,(%ecx)
  802566:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802569:	8b 45 08             	mov    0x8(%ebp),%eax
  80256c:	c9                   	leave  
  80256d:	c2 04 00             	ret    $0x4

00802570 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802570:	55                   	push   %ebp
  802571:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802573:	6a 00                	push   $0x0
  802575:	6a 00                	push   $0x0
  802577:	ff 75 10             	pushl  0x10(%ebp)
  80257a:	ff 75 0c             	pushl  0xc(%ebp)
  80257d:	ff 75 08             	pushl  0x8(%ebp)
  802580:	6a 13                	push   $0x13
  802582:	e8 9c fb ff ff       	call   802123 <syscall>
  802587:	83 c4 18             	add    $0x18,%esp
	return ;
  80258a:	90                   	nop
}
  80258b:	c9                   	leave  
  80258c:	c3                   	ret    

0080258d <sys_rcr2>:
uint32 sys_rcr2()
{
  80258d:	55                   	push   %ebp
  80258e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802590:	6a 00                	push   $0x0
  802592:	6a 00                	push   $0x0
  802594:	6a 00                	push   $0x0
  802596:	6a 00                	push   $0x0
  802598:	6a 00                	push   $0x0
  80259a:	6a 25                	push   $0x25
  80259c:	e8 82 fb ff ff       	call   802123 <syscall>
  8025a1:	83 c4 18             	add    $0x18,%esp
}
  8025a4:	c9                   	leave  
  8025a5:	c3                   	ret    

008025a6 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8025a6:	55                   	push   %ebp
  8025a7:	89 e5                	mov    %esp,%ebp
  8025a9:	83 ec 04             	sub    $0x4,%esp
  8025ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8025af:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8025b2:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8025b6:	6a 00                	push   $0x0
  8025b8:	6a 00                	push   $0x0
  8025ba:	6a 00                	push   $0x0
  8025bc:	6a 00                	push   $0x0
  8025be:	50                   	push   %eax
  8025bf:	6a 26                	push   $0x26
  8025c1:	e8 5d fb ff ff       	call   802123 <syscall>
  8025c6:	83 c4 18             	add    $0x18,%esp
	return ;
  8025c9:	90                   	nop
}
  8025ca:	c9                   	leave  
  8025cb:	c3                   	ret    

008025cc <rsttst>:
void rsttst()
{
  8025cc:	55                   	push   %ebp
  8025cd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8025cf:	6a 00                	push   $0x0
  8025d1:	6a 00                	push   $0x0
  8025d3:	6a 00                	push   $0x0
  8025d5:	6a 00                	push   $0x0
  8025d7:	6a 00                	push   $0x0
  8025d9:	6a 28                	push   $0x28
  8025db:	e8 43 fb ff ff       	call   802123 <syscall>
  8025e0:	83 c4 18             	add    $0x18,%esp
	return ;
  8025e3:	90                   	nop
}
  8025e4:	c9                   	leave  
  8025e5:	c3                   	ret    

008025e6 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8025e6:	55                   	push   %ebp
  8025e7:	89 e5                	mov    %esp,%ebp
  8025e9:	83 ec 04             	sub    $0x4,%esp
  8025ec:	8b 45 14             	mov    0x14(%ebp),%eax
  8025ef:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8025f2:	8b 55 18             	mov    0x18(%ebp),%edx
  8025f5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8025f9:	52                   	push   %edx
  8025fa:	50                   	push   %eax
  8025fb:	ff 75 10             	pushl  0x10(%ebp)
  8025fe:	ff 75 0c             	pushl  0xc(%ebp)
  802601:	ff 75 08             	pushl  0x8(%ebp)
  802604:	6a 27                	push   $0x27
  802606:	e8 18 fb ff ff       	call   802123 <syscall>
  80260b:	83 c4 18             	add    $0x18,%esp
	return ;
  80260e:	90                   	nop
}
  80260f:	c9                   	leave  
  802610:	c3                   	ret    

00802611 <chktst>:
void chktst(uint32 n)
{
  802611:	55                   	push   %ebp
  802612:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802614:	6a 00                	push   $0x0
  802616:	6a 00                	push   $0x0
  802618:	6a 00                	push   $0x0
  80261a:	6a 00                	push   $0x0
  80261c:	ff 75 08             	pushl  0x8(%ebp)
  80261f:	6a 29                	push   $0x29
  802621:	e8 fd fa ff ff       	call   802123 <syscall>
  802626:	83 c4 18             	add    $0x18,%esp
	return ;
  802629:	90                   	nop
}
  80262a:	c9                   	leave  
  80262b:	c3                   	ret    

0080262c <inctst>:

void inctst()
{
  80262c:	55                   	push   %ebp
  80262d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80262f:	6a 00                	push   $0x0
  802631:	6a 00                	push   $0x0
  802633:	6a 00                	push   $0x0
  802635:	6a 00                	push   $0x0
  802637:	6a 00                	push   $0x0
  802639:	6a 2a                	push   $0x2a
  80263b:	e8 e3 fa ff ff       	call   802123 <syscall>
  802640:	83 c4 18             	add    $0x18,%esp
	return ;
  802643:	90                   	nop
}
  802644:	c9                   	leave  
  802645:	c3                   	ret    

00802646 <gettst>:
uint32 gettst()
{
  802646:	55                   	push   %ebp
  802647:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802649:	6a 00                	push   $0x0
  80264b:	6a 00                	push   $0x0
  80264d:	6a 00                	push   $0x0
  80264f:	6a 00                	push   $0x0
  802651:	6a 00                	push   $0x0
  802653:	6a 2b                	push   $0x2b
  802655:	e8 c9 fa ff ff       	call   802123 <syscall>
  80265a:	83 c4 18             	add    $0x18,%esp
}
  80265d:	c9                   	leave  
  80265e:	c3                   	ret    

0080265f <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80265f:	55                   	push   %ebp
  802660:	89 e5                	mov    %esp,%ebp
  802662:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802665:	6a 00                	push   $0x0
  802667:	6a 00                	push   $0x0
  802669:	6a 00                	push   $0x0
  80266b:	6a 00                	push   $0x0
  80266d:	6a 00                	push   $0x0
  80266f:	6a 2c                	push   $0x2c
  802671:	e8 ad fa ff ff       	call   802123 <syscall>
  802676:	83 c4 18             	add    $0x18,%esp
  802679:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80267c:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802680:	75 07                	jne    802689 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802682:	b8 01 00 00 00       	mov    $0x1,%eax
  802687:	eb 05                	jmp    80268e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802689:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80268e:	c9                   	leave  
  80268f:	c3                   	ret    

00802690 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802690:	55                   	push   %ebp
  802691:	89 e5                	mov    %esp,%ebp
  802693:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802696:	6a 00                	push   $0x0
  802698:	6a 00                	push   $0x0
  80269a:	6a 00                	push   $0x0
  80269c:	6a 00                	push   $0x0
  80269e:	6a 00                	push   $0x0
  8026a0:	6a 2c                	push   $0x2c
  8026a2:	e8 7c fa ff ff       	call   802123 <syscall>
  8026a7:	83 c4 18             	add    $0x18,%esp
  8026aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8026ad:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8026b1:	75 07                	jne    8026ba <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8026b3:	b8 01 00 00 00       	mov    $0x1,%eax
  8026b8:	eb 05                	jmp    8026bf <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8026ba:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8026bf:	c9                   	leave  
  8026c0:	c3                   	ret    

008026c1 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8026c1:	55                   	push   %ebp
  8026c2:	89 e5                	mov    %esp,%ebp
  8026c4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8026c7:	6a 00                	push   $0x0
  8026c9:	6a 00                	push   $0x0
  8026cb:	6a 00                	push   $0x0
  8026cd:	6a 00                	push   $0x0
  8026cf:	6a 00                	push   $0x0
  8026d1:	6a 2c                	push   $0x2c
  8026d3:	e8 4b fa ff ff       	call   802123 <syscall>
  8026d8:	83 c4 18             	add    $0x18,%esp
  8026db:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8026de:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8026e2:	75 07                	jne    8026eb <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8026e4:	b8 01 00 00 00       	mov    $0x1,%eax
  8026e9:	eb 05                	jmp    8026f0 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8026eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8026f0:	c9                   	leave  
  8026f1:	c3                   	ret    

008026f2 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8026f2:	55                   	push   %ebp
  8026f3:	89 e5                	mov    %esp,%ebp
  8026f5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8026f8:	6a 00                	push   $0x0
  8026fa:	6a 00                	push   $0x0
  8026fc:	6a 00                	push   $0x0
  8026fe:	6a 00                	push   $0x0
  802700:	6a 00                	push   $0x0
  802702:	6a 2c                	push   $0x2c
  802704:	e8 1a fa ff ff       	call   802123 <syscall>
  802709:	83 c4 18             	add    $0x18,%esp
  80270c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80270f:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802713:	75 07                	jne    80271c <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802715:	b8 01 00 00 00       	mov    $0x1,%eax
  80271a:	eb 05                	jmp    802721 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80271c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802721:	c9                   	leave  
  802722:	c3                   	ret    

00802723 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802723:	55                   	push   %ebp
  802724:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802726:	6a 00                	push   $0x0
  802728:	6a 00                	push   $0x0
  80272a:	6a 00                	push   $0x0
  80272c:	6a 00                	push   $0x0
  80272e:	ff 75 08             	pushl  0x8(%ebp)
  802731:	6a 2d                	push   $0x2d
  802733:	e8 eb f9 ff ff       	call   802123 <syscall>
  802738:	83 c4 18             	add    $0x18,%esp
	return ;
  80273b:	90                   	nop
}
  80273c:	c9                   	leave  
  80273d:	c3                   	ret    

0080273e <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80273e:	55                   	push   %ebp
  80273f:	89 e5                	mov    %esp,%ebp
  802741:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802742:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802745:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802748:	8b 55 0c             	mov    0xc(%ebp),%edx
  80274b:	8b 45 08             	mov    0x8(%ebp),%eax
  80274e:	6a 00                	push   $0x0
  802750:	53                   	push   %ebx
  802751:	51                   	push   %ecx
  802752:	52                   	push   %edx
  802753:	50                   	push   %eax
  802754:	6a 2e                	push   $0x2e
  802756:	e8 c8 f9 ff ff       	call   802123 <syscall>
  80275b:	83 c4 18             	add    $0x18,%esp
}
  80275e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802761:	c9                   	leave  
  802762:	c3                   	ret    

00802763 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802763:	55                   	push   %ebp
  802764:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802766:	8b 55 0c             	mov    0xc(%ebp),%edx
  802769:	8b 45 08             	mov    0x8(%ebp),%eax
  80276c:	6a 00                	push   $0x0
  80276e:	6a 00                	push   $0x0
  802770:	6a 00                	push   $0x0
  802772:	52                   	push   %edx
  802773:	50                   	push   %eax
  802774:	6a 2f                	push   $0x2f
  802776:	e8 a8 f9 ff ff       	call   802123 <syscall>
  80277b:	83 c4 18             	add    $0x18,%esp
}
  80277e:	c9                   	leave  
  80277f:	c3                   	ret    

00802780 <__udivdi3>:
  802780:	55                   	push   %ebp
  802781:	57                   	push   %edi
  802782:	56                   	push   %esi
  802783:	53                   	push   %ebx
  802784:	83 ec 1c             	sub    $0x1c,%esp
  802787:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80278b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80278f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802793:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802797:	89 ca                	mov    %ecx,%edx
  802799:	89 f8                	mov    %edi,%eax
  80279b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80279f:	85 f6                	test   %esi,%esi
  8027a1:	75 2d                	jne    8027d0 <__udivdi3+0x50>
  8027a3:	39 cf                	cmp    %ecx,%edi
  8027a5:	77 65                	ja     80280c <__udivdi3+0x8c>
  8027a7:	89 fd                	mov    %edi,%ebp
  8027a9:	85 ff                	test   %edi,%edi
  8027ab:	75 0b                	jne    8027b8 <__udivdi3+0x38>
  8027ad:	b8 01 00 00 00       	mov    $0x1,%eax
  8027b2:	31 d2                	xor    %edx,%edx
  8027b4:	f7 f7                	div    %edi
  8027b6:	89 c5                	mov    %eax,%ebp
  8027b8:	31 d2                	xor    %edx,%edx
  8027ba:	89 c8                	mov    %ecx,%eax
  8027bc:	f7 f5                	div    %ebp
  8027be:	89 c1                	mov    %eax,%ecx
  8027c0:	89 d8                	mov    %ebx,%eax
  8027c2:	f7 f5                	div    %ebp
  8027c4:	89 cf                	mov    %ecx,%edi
  8027c6:	89 fa                	mov    %edi,%edx
  8027c8:	83 c4 1c             	add    $0x1c,%esp
  8027cb:	5b                   	pop    %ebx
  8027cc:	5e                   	pop    %esi
  8027cd:	5f                   	pop    %edi
  8027ce:	5d                   	pop    %ebp
  8027cf:	c3                   	ret    
  8027d0:	39 ce                	cmp    %ecx,%esi
  8027d2:	77 28                	ja     8027fc <__udivdi3+0x7c>
  8027d4:	0f bd fe             	bsr    %esi,%edi
  8027d7:	83 f7 1f             	xor    $0x1f,%edi
  8027da:	75 40                	jne    80281c <__udivdi3+0x9c>
  8027dc:	39 ce                	cmp    %ecx,%esi
  8027de:	72 0a                	jb     8027ea <__udivdi3+0x6a>
  8027e0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8027e4:	0f 87 9e 00 00 00    	ja     802888 <__udivdi3+0x108>
  8027ea:	b8 01 00 00 00       	mov    $0x1,%eax
  8027ef:	89 fa                	mov    %edi,%edx
  8027f1:	83 c4 1c             	add    $0x1c,%esp
  8027f4:	5b                   	pop    %ebx
  8027f5:	5e                   	pop    %esi
  8027f6:	5f                   	pop    %edi
  8027f7:	5d                   	pop    %ebp
  8027f8:	c3                   	ret    
  8027f9:	8d 76 00             	lea    0x0(%esi),%esi
  8027fc:	31 ff                	xor    %edi,%edi
  8027fe:	31 c0                	xor    %eax,%eax
  802800:	89 fa                	mov    %edi,%edx
  802802:	83 c4 1c             	add    $0x1c,%esp
  802805:	5b                   	pop    %ebx
  802806:	5e                   	pop    %esi
  802807:	5f                   	pop    %edi
  802808:	5d                   	pop    %ebp
  802809:	c3                   	ret    
  80280a:	66 90                	xchg   %ax,%ax
  80280c:	89 d8                	mov    %ebx,%eax
  80280e:	f7 f7                	div    %edi
  802810:	31 ff                	xor    %edi,%edi
  802812:	89 fa                	mov    %edi,%edx
  802814:	83 c4 1c             	add    $0x1c,%esp
  802817:	5b                   	pop    %ebx
  802818:	5e                   	pop    %esi
  802819:	5f                   	pop    %edi
  80281a:	5d                   	pop    %ebp
  80281b:	c3                   	ret    
  80281c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802821:	89 eb                	mov    %ebp,%ebx
  802823:	29 fb                	sub    %edi,%ebx
  802825:	89 f9                	mov    %edi,%ecx
  802827:	d3 e6                	shl    %cl,%esi
  802829:	89 c5                	mov    %eax,%ebp
  80282b:	88 d9                	mov    %bl,%cl
  80282d:	d3 ed                	shr    %cl,%ebp
  80282f:	89 e9                	mov    %ebp,%ecx
  802831:	09 f1                	or     %esi,%ecx
  802833:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802837:	89 f9                	mov    %edi,%ecx
  802839:	d3 e0                	shl    %cl,%eax
  80283b:	89 c5                	mov    %eax,%ebp
  80283d:	89 d6                	mov    %edx,%esi
  80283f:	88 d9                	mov    %bl,%cl
  802841:	d3 ee                	shr    %cl,%esi
  802843:	89 f9                	mov    %edi,%ecx
  802845:	d3 e2                	shl    %cl,%edx
  802847:	8b 44 24 08          	mov    0x8(%esp),%eax
  80284b:	88 d9                	mov    %bl,%cl
  80284d:	d3 e8                	shr    %cl,%eax
  80284f:	09 c2                	or     %eax,%edx
  802851:	89 d0                	mov    %edx,%eax
  802853:	89 f2                	mov    %esi,%edx
  802855:	f7 74 24 0c          	divl   0xc(%esp)
  802859:	89 d6                	mov    %edx,%esi
  80285b:	89 c3                	mov    %eax,%ebx
  80285d:	f7 e5                	mul    %ebp
  80285f:	39 d6                	cmp    %edx,%esi
  802861:	72 19                	jb     80287c <__udivdi3+0xfc>
  802863:	74 0b                	je     802870 <__udivdi3+0xf0>
  802865:	89 d8                	mov    %ebx,%eax
  802867:	31 ff                	xor    %edi,%edi
  802869:	e9 58 ff ff ff       	jmp    8027c6 <__udivdi3+0x46>
  80286e:	66 90                	xchg   %ax,%ax
  802870:	8b 54 24 08          	mov    0x8(%esp),%edx
  802874:	89 f9                	mov    %edi,%ecx
  802876:	d3 e2                	shl    %cl,%edx
  802878:	39 c2                	cmp    %eax,%edx
  80287a:	73 e9                	jae    802865 <__udivdi3+0xe5>
  80287c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80287f:	31 ff                	xor    %edi,%edi
  802881:	e9 40 ff ff ff       	jmp    8027c6 <__udivdi3+0x46>
  802886:	66 90                	xchg   %ax,%ax
  802888:	31 c0                	xor    %eax,%eax
  80288a:	e9 37 ff ff ff       	jmp    8027c6 <__udivdi3+0x46>
  80288f:	90                   	nop

00802890 <__umoddi3>:
  802890:	55                   	push   %ebp
  802891:	57                   	push   %edi
  802892:	56                   	push   %esi
  802893:	53                   	push   %ebx
  802894:	83 ec 1c             	sub    $0x1c,%esp
  802897:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80289b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80289f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8028a3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8028a7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8028ab:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8028af:	89 f3                	mov    %esi,%ebx
  8028b1:	89 fa                	mov    %edi,%edx
  8028b3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8028b7:	89 34 24             	mov    %esi,(%esp)
  8028ba:	85 c0                	test   %eax,%eax
  8028bc:	75 1a                	jne    8028d8 <__umoddi3+0x48>
  8028be:	39 f7                	cmp    %esi,%edi
  8028c0:	0f 86 a2 00 00 00    	jbe    802968 <__umoddi3+0xd8>
  8028c6:	89 c8                	mov    %ecx,%eax
  8028c8:	89 f2                	mov    %esi,%edx
  8028ca:	f7 f7                	div    %edi
  8028cc:	89 d0                	mov    %edx,%eax
  8028ce:	31 d2                	xor    %edx,%edx
  8028d0:	83 c4 1c             	add    $0x1c,%esp
  8028d3:	5b                   	pop    %ebx
  8028d4:	5e                   	pop    %esi
  8028d5:	5f                   	pop    %edi
  8028d6:	5d                   	pop    %ebp
  8028d7:	c3                   	ret    
  8028d8:	39 f0                	cmp    %esi,%eax
  8028da:	0f 87 ac 00 00 00    	ja     80298c <__umoddi3+0xfc>
  8028e0:	0f bd e8             	bsr    %eax,%ebp
  8028e3:	83 f5 1f             	xor    $0x1f,%ebp
  8028e6:	0f 84 ac 00 00 00    	je     802998 <__umoddi3+0x108>
  8028ec:	bf 20 00 00 00       	mov    $0x20,%edi
  8028f1:	29 ef                	sub    %ebp,%edi
  8028f3:	89 fe                	mov    %edi,%esi
  8028f5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8028f9:	89 e9                	mov    %ebp,%ecx
  8028fb:	d3 e0                	shl    %cl,%eax
  8028fd:	89 d7                	mov    %edx,%edi
  8028ff:	89 f1                	mov    %esi,%ecx
  802901:	d3 ef                	shr    %cl,%edi
  802903:	09 c7                	or     %eax,%edi
  802905:	89 e9                	mov    %ebp,%ecx
  802907:	d3 e2                	shl    %cl,%edx
  802909:	89 14 24             	mov    %edx,(%esp)
  80290c:	89 d8                	mov    %ebx,%eax
  80290e:	d3 e0                	shl    %cl,%eax
  802910:	89 c2                	mov    %eax,%edx
  802912:	8b 44 24 08          	mov    0x8(%esp),%eax
  802916:	d3 e0                	shl    %cl,%eax
  802918:	89 44 24 04          	mov    %eax,0x4(%esp)
  80291c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802920:	89 f1                	mov    %esi,%ecx
  802922:	d3 e8                	shr    %cl,%eax
  802924:	09 d0                	or     %edx,%eax
  802926:	d3 eb                	shr    %cl,%ebx
  802928:	89 da                	mov    %ebx,%edx
  80292a:	f7 f7                	div    %edi
  80292c:	89 d3                	mov    %edx,%ebx
  80292e:	f7 24 24             	mull   (%esp)
  802931:	89 c6                	mov    %eax,%esi
  802933:	89 d1                	mov    %edx,%ecx
  802935:	39 d3                	cmp    %edx,%ebx
  802937:	0f 82 87 00 00 00    	jb     8029c4 <__umoddi3+0x134>
  80293d:	0f 84 91 00 00 00    	je     8029d4 <__umoddi3+0x144>
  802943:	8b 54 24 04          	mov    0x4(%esp),%edx
  802947:	29 f2                	sub    %esi,%edx
  802949:	19 cb                	sbb    %ecx,%ebx
  80294b:	89 d8                	mov    %ebx,%eax
  80294d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802951:	d3 e0                	shl    %cl,%eax
  802953:	89 e9                	mov    %ebp,%ecx
  802955:	d3 ea                	shr    %cl,%edx
  802957:	09 d0                	or     %edx,%eax
  802959:	89 e9                	mov    %ebp,%ecx
  80295b:	d3 eb                	shr    %cl,%ebx
  80295d:	89 da                	mov    %ebx,%edx
  80295f:	83 c4 1c             	add    $0x1c,%esp
  802962:	5b                   	pop    %ebx
  802963:	5e                   	pop    %esi
  802964:	5f                   	pop    %edi
  802965:	5d                   	pop    %ebp
  802966:	c3                   	ret    
  802967:	90                   	nop
  802968:	89 fd                	mov    %edi,%ebp
  80296a:	85 ff                	test   %edi,%edi
  80296c:	75 0b                	jne    802979 <__umoddi3+0xe9>
  80296e:	b8 01 00 00 00       	mov    $0x1,%eax
  802973:	31 d2                	xor    %edx,%edx
  802975:	f7 f7                	div    %edi
  802977:	89 c5                	mov    %eax,%ebp
  802979:	89 f0                	mov    %esi,%eax
  80297b:	31 d2                	xor    %edx,%edx
  80297d:	f7 f5                	div    %ebp
  80297f:	89 c8                	mov    %ecx,%eax
  802981:	f7 f5                	div    %ebp
  802983:	89 d0                	mov    %edx,%eax
  802985:	e9 44 ff ff ff       	jmp    8028ce <__umoddi3+0x3e>
  80298a:	66 90                	xchg   %ax,%ax
  80298c:	89 c8                	mov    %ecx,%eax
  80298e:	89 f2                	mov    %esi,%edx
  802990:	83 c4 1c             	add    $0x1c,%esp
  802993:	5b                   	pop    %ebx
  802994:	5e                   	pop    %esi
  802995:	5f                   	pop    %edi
  802996:	5d                   	pop    %ebp
  802997:	c3                   	ret    
  802998:	3b 04 24             	cmp    (%esp),%eax
  80299b:	72 06                	jb     8029a3 <__umoddi3+0x113>
  80299d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8029a1:	77 0f                	ja     8029b2 <__umoddi3+0x122>
  8029a3:	89 f2                	mov    %esi,%edx
  8029a5:	29 f9                	sub    %edi,%ecx
  8029a7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8029ab:	89 14 24             	mov    %edx,(%esp)
  8029ae:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8029b2:	8b 44 24 04          	mov    0x4(%esp),%eax
  8029b6:	8b 14 24             	mov    (%esp),%edx
  8029b9:	83 c4 1c             	add    $0x1c,%esp
  8029bc:	5b                   	pop    %ebx
  8029bd:	5e                   	pop    %esi
  8029be:	5f                   	pop    %edi
  8029bf:	5d                   	pop    %ebp
  8029c0:	c3                   	ret    
  8029c1:	8d 76 00             	lea    0x0(%esi),%esi
  8029c4:	2b 04 24             	sub    (%esp),%eax
  8029c7:	19 fa                	sbb    %edi,%edx
  8029c9:	89 d1                	mov    %edx,%ecx
  8029cb:	89 c6                	mov    %eax,%esi
  8029cd:	e9 71 ff ff ff       	jmp    802943 <__umoddi3+0xb3>
  8029d2:	66 90                	xchg   %ax,%ax
  8029d4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8029d8:	72 ea                	jb     8029c4 <__umoddi3+0x134>
  8029da:	89 d9                	mov    %ebx,%ecx
  8029dc:	e9 62 ff ff ff       	jmp    802943 <__umoddi3+0xb3>
