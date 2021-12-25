
obj/user/tst_nextfit:     file format elf32-i386


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
  800031:	e8 1c 0b 00 00       	call   800b52 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* *********************************************************** */

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	81 ec 30 08 00 00    	sub    $0x830,%esp
	int Mega = 1024*1024;
  800043:	c7 45 e0 00 00 10 00 	movl   $0x100000,-0x20(%ebp)
	int kilo = 1024;
  80004a:	c7 45 dc 00 04 00 00 	movl   $0x400,-0x24(%ebp)

	//Make sure that the heap size is 512 MB
	int numOf2MBsInHeap = (USER_HEAP_MAX - USER_HEAP_START) / (2*Mega);
  800051:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800054:	01 c0                	add    %eax,%eax
  800056:	89 c7                	mov    %eax,%edi
  800058:	b8 00 00 00 20       	mov    $0x20000000,%eax
  80005d:	ba 00 00 00 00       	mov    $0x0,%edx
  800062:	f7 f7                	div    %edi
  800064:	89 45 d8             	mov    %eax,-0x28(%ebp)
	assert(numOf2MBsInHeap == 256);
  800067:	81 7d d8 00 01 00 00 	cmpl   $0x100,-0x28(%ebp)
  80006e:	74 16                	je     800086 <_main+0x4e>
  800070:	68 c0 29 80 00       	push   $0x8029c0
  800075:	68 d7 29 80 00       	push   $0x8029d7
  80007a:	6a 0e                	push   $0xe
  80007c:	68 ec 29 80 00       	push   $0x8029ec
  800081:	e8 11 0c 00 00       	call   800c97 <_panic>




	sys_set_uheap_strategy(UHP_PLACE_NEXTFIT);
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	6a 03                	push   $0x3
  80008b:	e8 65 26 00 00       	call   8026f5 <sys_set_uheap_strategy>
  800090:	83 c4 10             	add    $0x10,%esp

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  800093:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800097:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80009e:	eb 23                	jmp    8000c3 <_main+0x8b>
		{
			if (myEnv->__uptr_pws[i].empty)
  8000a0:	a1 20 40 80 00       	mov    0x804020,%eax
  8000a5:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000ab:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8000ae:	c1 e2 04             	shl    $0x4,%edx
  8000b1:	01 d0                	add    %edx,%eax
  8000b3:	8a 40 04             	mov    0x4(%eax),%al
  8000b6:	84 c0                	test   %al,%al
  8000b8:	74 06                	je     8000c0 <_main+0x88>
			{
				fullWS = 0;
  8000ba:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  8000be:	eb 12                	jmp    8000d2 <_main+0x9a>
	sys_set_uheap_strategy(UHP_PLACE_NEXTFIT);

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  8000c0:	ff 45 f0             	incl   -0x10(%ebp)
  8000c3:	a1 20 40 80 00       	mov    0x804020,%eax
  8000c8:	8b 50 74             	mov    0x74(%eax),%edx
  8000cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000ce:	39 c2                	cmp    %eax,%edx
  8000d0:	77 ce                	ja     8000a0 <_main+0x68>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  8000d2:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  8000d6:	74 14                	je     8000ec <_main+0xb4>
  8000d8:	83 ec 04             	sub    $0x4,%esp
  8000db:	68 ff 29 80 00       	push   $0x8029ff
  8000e0:	6a 20                	push   $0x20
  8000e2:	68 ec 29 80 00       	push   $0x8029ec
  8000e7:	e8 ab 0b 00 00       	call   800c97 <_panic>

	int freeFrames ;
	int usedDiskPages;

	//[0] Make sure there're available places in the WS
	int w = 0 ;
  8000ec:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	int requiredNumOfEmptyWSLocs = 2;
  8000f3:	c7 45 d4 02 00 00 00 	movl   $0x2,-0x2c(%ebp)
	int numOfEmptyWSLocs = 0;
  8000fa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	for (w = 0 ; w < myEnv->page_WS_max_size ; w++)
  800101:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800108:	eb 20                	jmp    80012a <_main+0xf2>
	{
		if( myEnv->__uptr_pws[w].empty == 1)
  80010a:	a1 20 40 80 00       	mov    0x804020,%eax
  80010f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800115:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800118:	c1 e2 04             	shl    $0x4,%edx
  80011b:	01 d0                	add    %edx,%eax
  80011d:	8a 40 04             	mov    0x4(%eax),%al
  800120:	3c 01                	cmp    $0x1,%al
  800122:	75 03                	jne    800127 <_main+0xef>
			numOfEmptyWSLocs++;
  800124:	ff 45 e8             	incl   -0x18(%ebp)

	//[0] Make sure there're available places in the WS
	int w = 0 ;
	int requiredNumOfEmptyWSLocs = 2;
	int numOfEmptyWSLocs = 0;
	for (w = 0 ; w < myEnv->page_WS_max_size ; w++)
  800127:	ff 45 ec             	incl   -0x14(%ebp)
  80012a:	a1 20 40 80 00       	mov    0x804020,%eax
  80012f:	8b 50 74             	mov    0x74(%eax),%edx
  800132:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800135:	39 c2                	cmp    %eax,%edx
  800137:	77 d1                	ja     80010a <_main+0xd2>
	{
		if( myEnv->__uptr_pws[w].empty == 1)
			numOfEmptyWSLocs++;
	}
	if (numOfEmptyWSLocs < requiredNumOfEmptyWSLocs)
  800139:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80013c:	3b 45 d4             	cmp    -0x2c(%ebp),%eax
  80013f:	7d 14                	jge    800155 <_main+0x11d>
		panic("Insufficient number of WS empty locations! please increase the PAGE_WS_MAX_SIZE");
  800141:	83 ec 04             	sub    $0x4,%esp
  800144:	68 1c 2a 80 00       	push   $0x802a1c
  800149:	6a 31                	push   $0x31
  80014b:	68 ec 29 80 00       	push   $0x8029ec
  800150:	e8 42 0b 00 00       	call   800c97 <_panic>


	void* ptr_allocations[512] = {0};
  800155:	8d 95 c8 f7 ff ff    	lea    -0x838(%ebp),%edx
  80015b:	b9 00 02 00 00       	mov    $0x200,%ecx
  800160:	b8 00 00 00 00       	mov    $0x0,%eax
  800165:	89 d7                	mov    %edx,%edi
  800167:	f3 ab                	rep stos %eax,%es:(%edi)
	int i;

	cprintf("This test has THREE cases. A pass message will be displayed after each one.\n");
  800169:	83 ec 0c             	sub    $0xc,%esp
  80016c:	68 6c 2a 80 00       	push   $0x802a6c
  800171:	e8 c3 0d 00 00       	call   800f39 <cprintf>
  800176:	83 c4 10             	add    $0x10,%esp

	// allocate pages
	freeFrames = sys_calculate_free_frames() ;
  800179:	e8 e3 20 00 00       	call   802261 <sys_calculate_free_frames>
  80017e:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800181:	e8 5e 21 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  800186:	89 45 cc             	mov    %eax,-0x34(%ebp)
	for(i = 0; i< 256;i++)
  800189:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800190:	eb 20                	jmp    8001b2 <_main+0x17a>
	{
		ptr_allocations[i] = malloc(2*Mega);
  800192:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800195:	01 c0                	add    %eax,%eax
  800197:	83 ec 0c             	sub    $0xc,%esp
  80019a:	50                   	push   %eax
  80019b:	e8 23 1b 00 00       	call   801cc3 <malloc>
  8001a0:	83 c4 10             	add    $0x10,%esp
  8001a3:	89 c2                	mov    %eax,%edx
  8001a5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001a8:	89 94 85 c8 f7 ff ff 	mov    %edx,-0x838(%ebp,%eax,4)
	cprintf("This test has THREE cases. A pass message will be displayed after each one.\n");

	// allocate pages
	freeFrames = sys_calculate_free_frames() ;
	usedDiskPages = sys_pf_calculate_allocated_pages();
	for(i = 0; i< 256;i++)
  8001af:	ff 45 e4             	incl   -0x1c(%ebp)
  8001b2:	81 7d e4 ff 00 00 00 	cmpl   $0xff,-0x1c(%ebp)
  8001b9:	7e d7                	jle    800192 <_main+0x15a>
	{
		ptr_allocations[i] = malloc(2*Mega);
	}

	// randomly check the addresses of the allocation
	if( 	(uint32)ptr_allocations[0] != 0x80000000 ||
  8001bb:	8b 85 c8 f7 ff ff    	mov    -0x838(%ebp),%eax
  8001c1:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8001c6:	75 5b                	jne    800223 <_main+0x1eb>
			(uint32)ptr_allocations[2] != 0x80400000 ||
  8001c8:	8b 85 d0 f7 ff ff    	mov    -0x830(%ebp),%eax
	{
		ptr_allocations[i] = malloc(2*Mega);
	}

	// randomly check the addresses of the allocation
	if( 	(uint32)ptr_allocations[0] != 0x80000000 ||
  8001ce:	3d 00 00 40 80       	cmp    $0x80400000,%eax
  8001d3:	75 4e                	jne    800223 <_main+0x1eb>
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
  8001d5:	8b 85 e8 f7 ff ff    	mov    -0x818(%ebp),%eax
		ptr_allocations[i] = malloc(2*Mega);
	}

	// randomly check the addresses of the allocation
	if( 	(uint32)ptr_allocations[0] != 0x80000000 ||
			(uint32)ptr_allocations[2] != 0x80400000 ||
  8001db:	3d 00 00 00 81       	cmp    $0x81000000,%eax
  8001e0:	75 41                	jne    800223 <_main+0x1eb>
			(uint32)ptr_allocations[8] != 0x81000000 ||
			(uint32)ptr_allocations[10] != 0x81400000 ||
  8001e2:	8b 85 f0 f7 ff ff    	mov    -0x810(%ebp),%eax
	}

	// randomly check the addresses of the allocation
	if( 	(uint32)ptr_allocations[0] != 0x80000000 ||
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
  8001e8:	3d 00 00 40 81       	cmp    $0x81400000,%eax
  8001ed:	75 34                	jne    800223 <_main+0x1eb>
			(uint32)ptr_allocations[10] != 0x81400000 ||
			(uint32)ptr_allocations[15] != 0x81e00000 ||
  8001ef:	8b 85 04 f8 ff ff    	mov    -0x7fc(%ebp),%eax

	// randomly check the addresses of the allocation
	if( 	(uint32)ptr_allocations[0] != 0x80000000 ||
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
			(uint32)ptr_allocations[10] != 0x81400000 ||
  8001f5:	3d 00 00 e0 81       	cmp    $0x81e00000,%eax
  8001fa:	75 27                	jne    800223 <_main+0x1eb>
			(uint32)ptr_allocations[15] != 0x81e00000 ||
			(uint32)ptr_allocations[20] != 0x82800000 ||
  8001fc:	8b 85 18 f8 ff ff    	mov    -0x7e8(%ebp),%eax
	// randomly check the addresses of the allocation
	if( 	(uint32)ptr_allocations[0] != 0x80000000 ||
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
			(uint32)ptr_allocations[10] != 0x81400000 ||
			(uint32)ptr_allocations[15] != 0x81e00000 ||
  800202:	3d 00 00 80 82       	cmp    $0x82800000,%eax
  800207:	75 1a                	jne    800223 <_main+0x1eb>
			(uint32)ptr_allocations[20] != 0x82800000 ||
			(uint32)ptr_allocations[25] != 0x83200000 ||
  800209:	8b 85 2c f8 ff ff    	mov    -0x7d4(%ebp),%eax
	if( 	(uint32)ptr_allocations[0] != 0x80000000 ||
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
			(uint32)ptr_allocations[10] != 0x81400000 ||
			(uint32)ptr_allocations[15] != 0x81e00000 ||
			(uint32)ptr_allocations[20] != 0x82800000 ||
  80020f:	3d 00 00 20 83       	cmp    $0x83200000,%eax
  800214:	75 0d                	jne    800223 <_main+0x1eb>
			(uint32)ptr_allocations[25] != 0x83200000 ||
			(uint32)ptr_allocations[255] != 0x9FE00000)
  800216:	8b 85 c4 fb ff ff    	mov    -0x43c(%ebp),%eax
			(uint32)ptr_allocations[2] != 0x80400000 ||
			(uint32)ptr_allocations[8] != 0x81000000 ||
			(uint32)ptr_allocations[10] != 0x81400000 ||
			(uint32)ptr_allocations[15] != 0x81e00000 ||
			(uint32)ptr_allocations[20] != 0x82800000 ||
			(uint32)ptr_allocations[25] != 0x83200000 ||
  80021c:	3d 00 00 e0 9f       	cmp    $0x9fe00000,%eax
  800221:	74 14                	je     800237 <_main+0x1ff>
			(uint32)ptr_allocations[255] != 0x9FE00000)
		panic("Wrong allocation, Check fitting strategy is working correctly");
  800223:	83 ec 04             	sub    $0x4,%esp
  800226:	68 bc 2a 80 00       	push   $0x802abc
  80022b:	6a 4a                	push   $0x4a
  80022d:	68 ec 29 80 00       	push   $0x8029ec
  800232:	e8 60 0a 00 00       	call   800c97 <_panic>

	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  800237:	e8 a8 20 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  80023c:	2b 45 cc             	sub    -0x34(%ebp),%eax
  80023f:	89 c2                	mov    %eax,%edx
  800241:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800244:	c1 e0 09             	shl    $0x9,%eax
  800247:	85 c0                	test   %eax,%eax
  800249:	79 05                	jns    800250 <_main+0x218>
  80024b:	05 ff 0f 00 00       	add    $0xfff,%eax
  800250:	c1 f8 0c             	sar    $0xc,%eax
  800253:	39 c2                	cmp    %eax,%edx
  800255:	74 14                	je     80026b <_main+0x233>
  800257:	83 ec 04             	sub    $0x4,%esp
  80025a:	68 fa 2a 80 00       	push   $0x802afa
  80025f:	6a 4c                	push   $0x4c
  800261:	68 ec 29 80 00       	push   $0x8029ec
  800266:	e8 2c 0a 00 00       	call   800c97 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != (512*Mega)/(1024*PAGE_SIZE) ) panic("Wrong allocation");
  80026b:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  80026e:	e8 ee 1f 00 00       	call   802261 <sys_calculate_free_frames>
  800273:	29 c3                	sub    %eax,%ebx
  800275:	89 da                	mov    %ebx,%edx
  800277:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80027a:	c1 e0 09             	shl    $0x9,%eax
  80027d:	85 c0                	test   %eax,%eax
  80027f:	79 05                	jns    800286 <_main+0x24e>
  800281:	05 ff ff 3f 00       	add    $0x3fffff,%eax
  800286:	c1 f8 16             	sar    $0x16,%eax
  800289:	39 c2                	cmp    %eax,%edx
  80028b:	74 14                	je     8002a1 <_main+0x269>
  80028d:	83 ec 04             	sub    $0x4,%esp
  800290:	68 17 2b 80 00       	push   $0x802b17
  800295:	6a 4d                	push   $0x4d
  800297:	68 ec 29 80 00       	push   $0x8029ec
  80029c:	e8 f6 09 00 00       	call   800c97 <_panic>

	// Make memory holes.
	freeFrames = sys_calculate_free_frames() ;
  8002a1:	e8 bb 1f 00 00       	call   802261 <sys_calculate_free_frames>
  8002a6:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8002a9:	e8 36 20 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  8002ae:	89 45 cc             	mov    %eax,-0x34(%ebp)

	free(ptr_allocations[0]);		// Hole 1 = 2 M
  8002b1:	8b 85 c8 f7 ff ff    	mov    -0x838(%ebp),%eax
  8002b7:	83 ec 0c             	sub    $0xc,%esp
  8002ba:	50                   	push   %eax
  8002bb:	e8 cb 1c 00 00       	call   801f8b <free>
  8002c0:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[2]);		// Hole 2 = 4 M
  8002c3:	8b 85 d0 f7 ff ff    	mov    -0x830(%ebp),%eax
  8002c9:	83 ec 0c             	sub    $0xc,%esp
  8002cc:	50                   	push   %eax
  8002cd:	e8 b9 1c 00 00       	call   801f8b <free>
  8002d2:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[3]);
  8002d5:	8b 85 d4 f7 ff ff    	mov    -0x82c(%ebp),%eax
  8002db:	83 ec 0c             	sub    $0xc,%esp
  8002de:	50                   	push   %eax
  8002df:	e8 a7 1c 00 00       	call   801f8b <free>
  8002e4:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[5]);		// Hole 3 = 2 M
  8002e7:	8b 85 dc f7 ff ff    	mov    -0x824(%ebp),%eax
  8002ed:	83 ec 0c             	sub    $0xc,%esp
  8002f0:	50                   	push   %eax
  8002f1:	e8 95 1c 00 00       	call   801f8b <free>
  8002f6:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[10]);		// Hole 4 = 6 M
  8002f9:	8b 85 f0 f7 ff ff    	mov    -0x810(%ebp),%eax
  8002ff:	83 ec 0c             	sub    $0xc,%esp
  800302:	50                   	push   %eax
  800303:	e8 83 1c 00 00       	call   801f8b <free>
  800308:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[12]);
  80030b:	8b 85 f8 f7 ff ff    	mov    -0x808(%ebp),%eax
  800311:	83 ec 0c             	sub    $0xc,%esp
  800314:	50                   	push   %eax
  800315:	e8 71 1c 00 00       	call   801f8b <free>
  80031a:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[11]);
  80031d:	8b 85 f4 f7 ff ff    	mov    -0x80c(%ebp),%eax
  800323:	83 ec 0c             	sub    $0xc,%esp
  800326:	50                   	push   %eax
  800327:	e8 5f 1c 00 00       	call   801f8b <free>
  80032c:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[20]);		// Hole 5 = 2 M
  80032f:	8b 85 18 f8 ff ff    	mov    -0x7e8(%ebp),%eax
  800335:	83 ec 0c             	sub    $0xc,%esp
  800338:	50                   	push   %eax
  800339:	e8 4d 1c 00 00       	call   801f8b <free>
  80033e:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[25]);		// Hole 6 = 2 M
  800341:	8b 85 2c f8 ff ff    	mov    -0x7d4(%ebp),%eax
  800347:	83 ec 0c             	sub    $0xc,%esp
  80034a:	50                   	push   %eax
  80034b:	e8 3b 1c 00 00       	call   801f8b <free>
  800350:	83 c4 10             	add    $0x10,%esp
	free(ptr_allocations[255]);		// Hole 7 = 2 M
  800353:	8b 85 c4 fb ff ff    	mov    -0x43c(%ebp),%eax
  800359:	83 ec 0c             	sub    $0xc,%esp
  80035c:	50                   	push   %eax
  80035d:	e8 29 1c 00 00       	call   801f8b <free>
  800362:	83 c4 10             	add    $0x10,%esp

	if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 10*(2*Mega)/PAGE_SIZE) panic("Wrong free: Extra or less pages are removed from PageFile");
  800365:	e8 7a 1f 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  80036a:	8b 55 cc             	mov    -0x34(%ebp),%edx
  80036d:	89 d1                	mov    %edx,%ecx
  80036f:	29 c1                	sub    %eax,%ecx
  800371:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800374:	89 d0                	mov    %edx,%eax
  800376:	c1 e0 02             	shl    $0x2,%eax
  800379:	01 d0                	add    %edx,%eax
  80037b:	c1 e0 02             	shl    $0x2,%eax
  80037e:	85 c0                	test   %eax,%eax
  800380:	79 05                	jns    800387 <_main+0x34f>
  800382:	05 ff 0f 00 00       	add    $0xfff,%eax
  800387:	c1 f8 0c             	sar    $0xc,%eax
  80038a:	39 c1                	cmp    %eax,%ecx
  80038c:	74 14                	je     8003a2 <_main+0x36a>
  80038e:	83 ec 04             	sub    $0x4,%esp
  800391:	68 28 2b 80 00       	push   $0x802b28
  800396:	6a 5e                	push   $0x5e
  800398:	68 ec 29 80 00       	push   $0x8029ec
  80039d:	e8 f5 08 00 00       	call   800c97 <_panic>
	if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: Extra or less pages are removed from main memory");
  8003a2:	e8 ba 1e 00 00       	call   802261 <sys_calculate_free_frames>
  8003a7:	89 c2                	mov    %eax,%edx
  8003a9:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8003ac:	39 c2                	cmp    %eax,%edx
  8003ae:	74 14                	je     8003c4 <_main+0x38c>
  8003b0:	83 ec 04             	sub    $0x4,%esp
  8003b3:	68 64 2b 80 00       	push   $0x802b64
  8003b8:	6a 5f                	push   $0x5f
  8003ba:	68 ec 29 80 00       	push   $0x8029ec
  8003bf:	e8 d3 08 00 00       	call   800c97 <_panic>

	// Test next fit

	freeFrames = sys_calculate_free_frames() ;
  8003c4:	e8 98 1e 00 00       	call   802261 <sys_calculate_free_frames>
  8003c9:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8003cc:	e8 13 1f 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  8003d1:	89 45 cc             	mov    %eax,-0x34(%ebp)
	void* tempAddress = malloc(Mega-kilo);		// Use Hole 1 -> Hole 1 = 1 M
  8003d4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003d7:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8003da:	83 ec 0c             	sub    $0xc,%esp
  8003dd:	50                   	push   %eax
  8003de:	e8 e0 18 00 00       	call   801cc3 <malloc>
  8003e3:	83 c4 10             	add    $0x10,%esp
  8003e6:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x80000000)
  8003e9:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8003ec:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8003f1:	74 14                	je     800407 <_main+0x3cf>
		panic("Next Fit not working correctly");
  8003f3:	83 ec 04             	sub    $0x4,%esp
  8003f6:	68 a4 2b 80 00       	push   $0x802ba4
  8003fb:	6a 67                	push   $0x67
  8003fd:	68 ec 29 80 00       	push   $0x8029ec
  800402:	e8 90 08 00 00       	call   800c97 <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  800407:	e8 d8 1e 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  80040c:	2b 45 cc             	sub    -0x34(%ebp),%eax
  80040f:	89 c2                	mov    %eax,%edx
  800411:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800414:	85 c0                	test   %eax,%eax
  800416:	79 05                	jns    80041d <_main+0x3e5>
  800418:	05 ff 0f 00 00       	add    $0xfff,%eax
  80041d:	c1 f8 0c             	sar    $0xc,%eax
  800420:	39 c2                	cmp    %eax,%edx
  800422:	74 14                	je     800438 <_main+0x400>
  800424:	83 ec 04             	sub    $0x4,%esp
  800427:	68 fa 2a 80 00       	push   $0x802afa
  80042c:	6a 68                	push   $0x68
  80042e:	68 ec 29 80 00       	push   $0x8029ec
  800433:	e8 5f 08 00 00       	call   800c97 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800438:	e8 24 1e 00 00       	call   802261 <sys_calculate_free_frames>
  80043d:	89 c2                	mov    %eax,%edx
  80043f:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800442:	39 c2                	cmp    %eax,%edx
  800444:	74 14                	je     80045a <_main+0x422>
  800446:	83 ec 04             	sub    $0x4,%esp
  800449:	68 17 2b 80 00       	push   $0x802b17
  80044e:	6a 69                	push   $0x69
  800450:	68 ec 29 80 00       	push   $0x8029ec
  800455:	e8 3d 08 00 00       	call   800c97 <_panic>

	freeFrames = sys_calculate_free_frames() ;
  80045a:	e8 02 1e 00 00       	call   802261 <sys_calculate_free_frames>
  80045f:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800462:	e8 7d 1e 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  800467:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(kilo);					// Use Hole 1 -> Hole 1 = 1 M - Kilo
  80046a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80046d:	83 ec 0c             	sub    $0xc,%esp
  800470:	50                   	push   %eax
  800471:	e8 4d 18 00 00       	call   801cc3 <malloc>
  800476:	83 c4 10             	add    $0x10,%esp
  800479:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x80100000)
  80047c:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80047f:	3d 00 00 10 80       	cmp    $0x80100000,%eax
  800484:	74 14                	je     80049a <_main+0x462>
		panic("Next Fit not working correctly");
  800486:	83 ec 04             	sub    $0x4,%esp
  800489:	68 a4 2b 80 00       	push   $0x802ba4
  80048e:	6a 6f                	push   $0x6f
  800490:	68 ec 29 80 00       	push   $0x8029ec
  800495:	e8 fd 07 00 00       	call   800c97 <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  4*kilo/PAGE_SIZE) panic("Wrong page file allocation: ");
  80049a:	e8 45 1e 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  80049f:	2b 45 cc             	sub    -0x34(%ebp),%eax
  8004a2:	89 c2                	mov    %eax,%edx
  8004a4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8004a7:	c1 e0 02             	shl    $0x2,%eax
  8004aa:	85 c0                	test   %eax,%eax
  8004ac:	79 05                	jns    8004b3 <_main+0x47b>
  8004ae:	05 ff 0f 00 00       	add    $0xfff,%eax
  8004b3:	c1 f8 0c             	sar    $0xc,%eax
  8004b6:	39 c2                	cmp    %eax,%edx
  8004b8:	74 14                	je     8004ce <_main+0x496>
  8004ba:	83 ec 04             	sub    $0x4,%esp
  8004bd:	68 fa 2a 80 00       	push   $0x802afa
  8004c2:	6a 70                	push   $0x70
  8004c4:	68 ec 29 80 00       	push   $0x8029ec
  8004c9:	e8 c9 07 00 00       	call   800c97 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  8004ce:	e8 8e 1d 00 00       	call   802261 <sys_calculate_free_frames>
  8004d3:	89 c2                	mov    %eax,%edx
  8004d5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8004d8:	39 c2                	cmp    %eax,%edx
  8004da:	74 14                	je     8004f0 <_main+0x4b8>
  8004dc:	83 ec 04             	sub    $0x4,%esp
  8004df:	68 17 2b 80 00       	push   $0x802b17
  8004e4:	6a 71                	push   $0x71
  8004e6:	68 ec 29 80 00       	push   $0x8029ec
  8004eb:	e8 a7 07 00 00       	call   800c97 <_panic>

	freeFrames = sys_calculate_free_frames() ;
  8004f0:	e8 6c 1d 00 00       	call   802261 <sys_calculate_free_frames>
  8004f5:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8004f8:	e8 e7 1d 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  8004fd:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(5*Mega); 			   // Use Hole 4 -> Hole 4 = 1 M
  800500:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800503:	89 d0                	mov    %edx,%eax
  800505:	c1 e0 02             	shl    $0x2,%eax
  800508:	01 d0                	add    %edx,%eax
  80050a:	83 ec 0c             	sub    $0xc,%esp
  80050d:	50                   	push   %eax
  80050e:	e8 b0 17 00 00       	call   801cc3 <malloc>
  800513:	83 c4 10             	add    $0x10,%esp
  800516:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x81400000)
  800519:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80051c:	3d 00 00 40 81       	cmp    $0x81400000,%eax
  800521:	74 14                	je     800537 <_main+0x4ff>
		panic("Next Fit not working correctly");
  800523:	83 ec 04             	sub    $0x4,%esp
  800526:	68 a4 2b 80 00       	push   $0x802ba4
  80052b:	6a 77                	push   $0x77
  80052d:	68 ec 29 80 00       	push   $0x8029ec
  800532:	e8 60 07 00 00       	call   800c97 <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  800537:	e8 a8 1d 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  80053c:	2b 45 cc             	sub    -0x34(%ebp),%eax
  80053f:	89 c1                	mov    %eax,%ecx
  800541:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800544:	89 d0                	mov    %edx,%eax
  800546:	c1 e0 02             	shl    $0x2,%eax
  800549:	01 d0                	add    %edx,%eax
  80054b:	85 c0                	test   %eax,%eax
  80054d:	79 05                	jns    800554 <_main+0x51c>
  80054f:	05 ff 0f 00 00       	add    $0xfff,%eax
  800554:	c1 f8 0c             	sar    $0xc,%eax
  800557:	39 c1                	cmp    %eax,%ecx
  800559:	74 14                	je     80056f <_main+0x537>
  80055b:	83 ec 04             	sub    $0x4,%esp
  80055e:	68 fa 2a 80 00       	push   $0x802afa
  800563:	6a 78                	push   $0x78
  800565:	68 ec 29 80 00       	push   $0x8029ec
  80056a:	e8 28 07 00 00       	call   800c97 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  80056f:	e8 ed 1c 00 00       	call   802261 <sys_calculate_free_frames>
  800574:	89 c2                	mov    %eax,%edx
  800576:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800579:	39 c2                	cmp    %eax,%edx
  80057b:	74 14                	je     800591 <_main+0x559>
  80057d:	83 ec 04             	sub    $0x4,%esp
  800580:	68 17 2b 80 00       	push   $0x802b17
  800585:	6a 79                	push   $0x79
  800587:	68 ec 29 80 00       	push   $0x8029ec
  80058c:	e8 06 07 00 00       	call   800c97 <_panic>

	freeFrames = sys_calculate_free_frames() ;
  800591:	e8 cb 1c 00 00       	call   802261 <sys_calculate_free_frames>
  800596:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800599:	e8 46 1d 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  80059e:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(1*Mega); 			   // Use Hole 4 -> Hole 4 = 0 M
  8005a1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005a4:	83 ec 0c             	sub    $0xc,%esp
  8005a7:	50                   	push   %eax
  8005a8:	e8 16 17 00 00       	call   801cc3 <malloc>
  8005ad:	83 c4 10             	add    $0x10,%esp
  8005b0:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x81900000)
  8005b3:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8005b6:	3d 00 00 90 81       	cmp    $0x81900000,%eax
  8005bb:	74 14                	je     8005d1 <_main+0x599>
		panic("Next Fit not working correctly");
  8005bd:	83 ec 04             	sub    $0x4,%esp
  8005c0:	68 a4 2b 80 00       	push   $0x802ba4
  8005c5:	6a 7f                	push   $0x7f
  8005c7:	68 ec 29 80 00       	push   $0x8029ec
  8005cc:	e8 c6 06 00 00       	call   800c97 <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  8005d1:	e8 0e 1d 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  8005d6:	2b 45 cc             	sub    -0x34(%ebp),%eax
  8005d9:	89 c2                	mov    %eax,%edx
  8005db:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005de:	85 c0                	test   %eax,%eax
  8005e0:	79 05                	jns    8005e7 <_main+0x5af>
  8005e2:	05 ff 0f 00 00       	add    $0xfff,%eax
  8005e7:	c1 f8 0c             	sar    $0xc,%eax
  8005ea:	39 c2                	cmp    %eax,%edx
  8005ec:	74 17                	je     800605 <_main+0x5cd>
  8005ee:	83 ec 04             	sub    $0x4,%esp
  8005f1:	68 fa 2a 80 00       	push   $0x802afa
  8005f6:	68 80 00 00 00       	push   $0x80
  8005fb:	68 ec 29 80 00       	push   $0x8029ec
  800600:	e8 92 06 00 00       	call   800c97 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800605:	e8 57 1c 00 00       	call   802261 <sys_calculate_free_frames>
  80060a:	89 c2                	mov    %eax,%edx
  80060c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80060f:	39 c2                	cmp    %eax,%edx
  800611:	74 17                	je     80062a <_main+0x5f2>
  800613:	83 ec 04             	sub    $0x4,%esp
  800616:	68 17 2b 80 00       	push   $0x802b17
  80061b:	68 81 00 00 00       	push   $0x81
  800620:	68 ec 29 80 00       	push   $0x8029ec
  800625:	e8 6d 06 00 00       	call   800c97 <_panic>


	freeFrames = sys_calculate_free_frames() ;
  80062a:	e8 32 1c 00 00       	call   802261 <sys_calculate_free_frames>
  80062f:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800632:	e8 ad 1c 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  800637:	89 45 cc             	mov    %eax,-0x34(%ebp)
	free(ptr_allocations[15]);					// Make a new hole => 2 M
  80063a:	8b 85 04 f8 ff ff    	mov    -0x7fc(%ebp),%eax
  800640:	83 ec 0c             	sub    $0xc,%esp
  800643:	50                   	push   %eax
  800644:	e8 42 19 00 00       	call   801f8b <free>
  800649:	83 c4 10             	add    $0x10,%esp
	if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2*Mega/PAGE_SIZE) panic("Wrong free: Extra or less pages are removed from PageFile");
  80064c:	e8 93 1c 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  800651:	8b 55 cc             	mov    -0x34(%ebp),%edx
  800654:	29 c2                	sub    %eax,%edx
  800656:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800659:	01 c0                	add    %eax,%eax
  80065b:	85 c0                	test   %eax,%eax
  80065d:	79 05                	jns    800664 <_main+0x62c>
  80065f:	05 ff 0f 00 00       	add    $0xfff,%eax
  800664:	c1 f8 0c             	sar    $0xc,%eax
  800667:	39 c2                	cmp    %eax,%edx
  800669:	74 17                	je     800682 <_main+0x64a>
  80066b:	83 ec 04             	sub    $0x4,%esp
  80066e:	68 28 2b 80 00       	push   $0x802b28
  800673:	68 87 00 00 00       	push   $0x87
  800678:	68 ec 29 80 00       	push   $0x8029ec
  80067d:	e8 15 06 00 00       	call   800c97 <_panic>
	if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: Extra or less pages are removed from main memory");
  800682:	e8 da 1b 00 00       	call   802261 <sys_calculate_free_frames>
  800687:	89 c2                	mov    %eax,%edx
  800689:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80068c:	39 c2                	cmp    %eax,%edx
  80068e:	74 17                	je     8006a7 <_main+0x66f>
  800690:	83 ec 04             	sub    $0x4,%esp
  800693:	68 64 2b 80 00       	push   $0x802b64
  800698:	68 88 00 00 00       	push   $0x88
  80069d:	68 ec 29 80 00       	push   $0x8029ec
  8006a2:	e8 f0 05 00 00       	call   800c97 <_panic>

	//[NEXT FIT Case]
	freeFrames = sys_calculate_free_frames() ;
  8006a7:	e8 b5 1b 00 00       	call   802261 <sys_calculate_free_frames>
  8006ac:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8006af:	e8 30 1c 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  8006b4:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(kilo); 			   // Use new Hole = 2 M - 4 kilo
  8006b7:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8006ba:	83 ec 0c             	sub    $0xc,%esp
  8006bd:	50                   	push   %eax
  8006be:	e8 00 16 00 00       	call   801cc3 <malloc>
  8006c3:	83 c4 10             	add    $0x10,%esp
  8006c6:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x81E00000)
  8006c9:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8006cc:	3d 00 00 e0 81       	cmp    $0x81e00000,%eax
  8006d1:	74 17                	je     8006ea <_main+0x6b2>
		panic("Next Fit not working correctly");
  8006d3:	83 ec 04             	sub    $0x4,%esp
  8006d6:	68 a4 2b 80 00       	push   $0x802ba4
  8006db:	68 8f 00 00 00       	push   $0x8f
  8006e0:	68 ec 29 80 00       	push   $0x8029ec
  8006e5:	e8 ad 05 00 00       	call   800c97 <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  4*kilo/PAGE_SIZE) panic("Wrong page file allocation: ");
  8006ea:	e8 f5 1b 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  8006ef:	2b 45 cc             	sub    -0x34(%ebp),%eax
  8006f2:	89 c2                	mov    %eax,%edx
  8006f4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8006f7:	c1 e0 02             	shl    $0x2,%eax
  8006fa:	85 c0                	test   %eax,%eax
  8006fc:	79 05                	jns    800703 <_main+0x6cb>
  8006fe:	05 ff 0f 00 00       	add    $0xfff,%eax
  800703:	c1 f8 0c             	sar    $0xc,%eax
  800706:	39 c2                	cmp    %eax,%edx
  800708:	74 17                	je     800721 <_main+0x6e9>
  80070a:	83 ec 04             	sub    $0x4,%esp
  80070d:	68 fa 2a 80 00       	push   $0x802afa
  800712:	68 90 00 00 00       	push   $0x90
  800717:	68 ec 29 80 00       	push   $0x8029ec
  80071c:	e8 76 05 00 00       	call   800c97 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800721:	e8 3b 1b 00 00       	call   802261 <sys_calculate_free_frames>
  800726:	89 c2                	mov    %eax,%edx
  800728:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80072b:	39 c2                	cmp    %eax,%edx
  80072d:	74 17                	je     800746 <_main+0x70e>
  80072f:	83 ec 04             	sub    $0x4,%esp
  800732:	68 17 2b 80 00       	push   $0x802b17
  800737:	68 91 00 00 00       	push   $0x91
  80073c:	68 ec 29 80 00       	push   $0x8029ec
  800741:	e8 51 05 00 00       	call   800c97 <_panic>

	freeFrames = sys_calculate_free_frames() ;
  800746:	e8 16 1b 00 00       	call   802261 <sys_calculate_free_frames>
  80074b:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  80074e:	e8 91 1b 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  800753:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(Mega + 1016*kilo); 	// Use new Hole = 4 kilo
  800756:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800759:	c1 e0 03             	shl    $0x3,%eax
  80075c:	89 c2                	mov    %eax,%edx
  80075e:	c1 e2 07             	shl    $0x7,%edx
  800761:	29 c2                	sub    %eax,%edx
  800763:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800766:	01 d0                	add    %edx,%eax
  800768:	83 ec 0c             	sub    $0xc,%esp
  80076b:	50                   	push   %eax
  80076c:	e8 52 15 00 00       	call   801cc3 <malloc>
  800771:	83 c4 10             	add    $0x10,%esp
  800774:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x81E01000)
  800777:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80077a:	3d 00 10 e0 81       	cmp    $0x81e01000,%eax
  80077f:	74 17                	je     800798 <_main+0x760>
		panic("Next Fit not working correctly");
  800781:	83 ec 04             	sub    $0x4,%esp
  800784:	68 a4 2b 80 00       	push   $0x802ba4
  800789:	68 97 00 00 00       	push   $0x97
  80078e:	68 ec 29 80 00       	push   $0x8029ec
  800793:	e8 ff 04 00 00       	call   800c97 <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  (1*Mega+1016*kilo)/PAGE_SIZE) panic("Wrong page file allocation: ");
  800798:	e8 47 1b 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  80079d:	2b 45 cc             	sub    -0x34(%ebp),%eax
  8007a0:	89 c2                	mov    %eax,%edx
  8007a2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007a5:	c1 e0 03             	shl    $0x3,%eax
  8007a8:	89 c1                	mov    %eax,%ecx
  8007aa:	c1 e1 07             	shl    $0x7,%ecx
  8007ad:	29 c1                	sub    %eax,%ecx
  8007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007b2:	01 c8                	add    %ecx,%eax
  8007b4:	85 c0                	test   %eax,%eax
  8007b6:	79 05                	jns    8007bd <_main+0x785>
  8007b8:	05 ff 0f 00 00       	add    $0xfff,%eax
  8007bd:	c1 f8 0c             	sar    $0xc,%eax
  8007c0:	39 c2                	cmp    %eax,%edx
  8007c2:	74 17                	je     8007db <_main+0x7a3>
  8007c4:	83 ec 04             	sub    $0x4,%esp
  8007c7:	68 fa 2a 80 00       	push   $0x802afa
  8007cc:	68 98 00 00 00       	push   $0x98
  8007d1:	68 ec 29 80 00       	push   $0x8029ec
  8007d6:	e8 bc 04 00 00       	call   800c97 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  8007db:	e8 81 1a 00 00       	call   802261 <sys_calculate_free_frames>
  8007e0:	89 c2                	mov    %eax,%edx
  8007e2:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8007e5:	39 c2                	cmp    %eax,%edx
  8007e7:	74 17                	je     800800 <_main+0x7c8>
  8007e9:	83 ec 04             	sub    $0x4,%esp
  8007ec:	68 17 2b 80 00       	push   $0x802b17
  8007f1:	68 99 00 00 00       	push   $0x99
  8007f6:	68 ec 29 80 00       	push   $0x8029ec
  8007fb:	e8 97 04 00 00       	call   800c97 <_panic>

	freeFrames = sys_calculate_free_frames() ;
  800800:	e8 5c 1a 00 00       	call   802261 <sys_calculate_free_frames>
  800805:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800808:	e8 d7 1a 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  80080d:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(512*kilo); 			   // Use Hole 5 -> Hole 5 = 1.5 M
  800810:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800813:	c1 e0 09             	shl    $0x9,%eax
  800816:	83 ec 0c             	sub    $0xc,%esp
  800819:	50                   	push   %eax
  80081a:	e8 a4 14 00 00       	call   801cc3 <malloc>
  80081f:	83 c4 10             	add    $0x10,%esp
  800822:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x82800000)
  800825:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800828:	3d 00 00 80 82       	cmp    $0x82800000,%eax
  80082d:	74 17                	je     800846 <_main+0x80e>
		panic("Next Fit not working correctly");
  80082f:	83 ec 04             	sub    $0x4,%esp
  800832:	68 a4 2b 80 00       	push   $0x802ba4
  800837:	68 9f 00 00 00       	push   $0x9f
  80083c:	68 ec 29 80 00       	push   $0x8029ec
  800841:	e8 51 04 00 00       	call   800c97 <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512*kilo/PAGE_SIZE) panic("Wrong page file allocation: ");
  800846:	e8 99 1a 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  80084b:	2b 45 cc             	sub    -0x34(%ebp),%eax
  80084e:	89 c2                	mov    %eax,%edx
  800850:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800853:	c1 e0 09             	shl    $0x9,%eax
  800856:	85 c0                	test   %eax,%eax
  800858:	79 05                	jns    80085f <_main+0x827>
  80085a:	05 ff 0f 00 00       	add    $0xfff,%eax
  80085f:	c1 f8 0c             	sar    $0xc,%eax
  800862:	39 c2                	cmp    %eax,%edx
  800864:	74 17                	je     80087d <_main+0x845>
  800866:	83 ec 04             	sub    $0x4,%esp
  800869:	68 fa 2a 80 00       	push   $0x802afa
  80086e:	68 a0 00 00 00       	push   $0xa0
  800873:	68 ec 29 80 00       	push   $0x8029ec
  800878:	e8 1a 04 00 00       	call   800c97 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  80087d:	e8 df 19 00 00       	call   802261 <sys_calculate_free_frames>
  800882:	89 c2                	mov    %eax,%edx
  800884:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800887:	39 c2                	cmp    %eax,%edx
  800889:	74 17                	je     8008a2 <_main+0x86a>
  80088b:	83 ec 04             	sub    $0x4,%esp
  80088e:	68 17 2b 80 00       	push   $0x802b17
  800893:	68 a1 00 00 00       	push   $0xa1
  800898:	68 ec 29 80 00       	push   $0x8029ec
  80089d:	e8 f5 03 00 00       	call   800c97 <_panic>

	cprintf("\nCASE1: (next fit without looping back) is succeeded...\n") ;
  8008a2:	83 ec 0c             	sub    $0xc,%esp
  8008a5:	68 c4 2b 80 00       	push   $0x802bc4
  8008aa:	e8 8a 06 00 00       	call   800f39 <cprintf>
  8008af:	83 c4 10             	add    $0x10,%esp

	// Check that next fit is looping back to check for free space
	freeFrames = sys_calculate_free_frames() ;
  8008b2:	e8 aa 19 00 00       	call   802261 <sys_calculate_free_frames>
  8008b7:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8008ba:	e8 25 1a 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  8008bf:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(3*Mega + 512*kilo); 			   // Use Hole 2 -> Hole 2 = 0.5 M
  8008c2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008c5:	89 c2                	mov    %eax,%edx
  8008c7:	01 d2                	add    %edx,%edx
  8008c9:	01 c2                	add    %eax,%edx
  8008cb:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8008ce:	c1 e0 09             	shl    $0x9,%eax
  8008d1:	01 d0                	add    %edx,%eax
  8008d3:	83 ec 0c             	sub    $0xc,%esp
  8008d6:	50                   	push   %eax
  8008d7:	e8 e7 13 00 00       	call   801cc3 <malloc>
  8008dc:	83 c4 10             	add    $0x10,%esp
  8008df:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x80400000)
  8008e2:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8008e5:	3d 00 00 40 80       	cmp    $0x80400000,%eax
  8008ea:	74 17                	je     800903 <_main+0x8cb>
		panic("Next Fit not working correctly");
  8008ec:	83 ec 04             	sub    $0x4,%esp
  8008ef:	68 a4 2b 80 00       	push   $0x802ba4
  8008f4:	68 aa 00 00 00       	push   $0xaa
  8008f9:	68 ec 29 80 00       	push   $0x8029ec
  8008fe:	e8 94 03 00 00       	call   800c97 <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  (3*Mega+512*kilo)/PAGE_SIZE) panic("Wrong page file allocation: ");
  800903:	e8 dc 19 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  800908:	2b 45 cc             	sub    -0x34(%ebp),%eax
  80090b:	89 c2                	mov    %eax,%edx
  80090d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800910:	89 c1                	mov    %eax,%ecx
  800912:	01 c9                	add    %ecx,%ecx
  800914:	01 c1                	add    %eax,%ecx
  800916:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800919:	c1 e0 09             	shl    $0x9,%eax
  80091c:	01 c8                	add    %ecx,%eax
  80091e:	85 c0                	test   %eax,%eax
  800920:	79 05                	jns    800927 <_main+0x8ef>
  800922:	05 ff 0f 00 00       	add    $0xfff,%eax
  800927:	c1 f8 0c             	sar    $0xc,%eax
  80092a:	39 c2                	cmp    %eax,%edx
  80092c:	74 17                	je     800945 <_main+0x90d>
  80092e:	83 ec 04             	sub    $0x4,%esp
  800931:	68 fa 2a 80 00       	push   $0x802afa
  800936:	68 ab 00 00 00       	push   $0xab
  80093b:	68 ec 29 80 00       	push   $0x8029ec
  800940:	e8 52 03 00 00       	call   800c97 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800945:	e8 17 19 00 00       	call   802261 <sys_calculate_free_frames>
  80094a:	89 c2                	mov    %eax,%edx
  80094c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80094f:	39 c2                	cmp    %eax,%edx
  800951:	74 17                	je     80096a <_main+0x932>
  800953:	83 ec 04             	sub    $0x4,%esp
  800956:	68 17 2b 80 00       	push   $0x802b17
  80095b:	68 ac 00 00 00       	push   $0xac
  800960:	68 ec 29 80 00       	push   $0x8029ec
  800965:	e8 2d 03 00 00       	call   800c97 <_panic>


	freeFrames = sys_calculate_free_frames() ;
  80096a:	e8 f2 18 00 00       	call   802261 <sys_calculate_free_frames>
  80096f:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800972:	e8 6d 19 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  800977:	89 45 cc             	mov    %eax,-0x34(%ebp)
	free(ptr_allocations[24]);		// Increase size of Hole 6 to 4 M
  80097a:	8b 85 28 f8 ff ff    	mov    -0x7d8(%ebp),%eax
  800980:	83 ec 0c             	sub    $0xc,%esp
  800983:	50                   	push   %eax
  800984:	e8 02 16 00 00       	call   801f8b <free>
  800989:	83 c4 10             	add    $0x10,%esp
	if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 2*Mega/PAGE_SIZE) panic("Wrong free: Extra or less pages are removed from PageFile");
  80098c:	e8 53 19 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  800991:	8b 55 cc             	mov    -0x34(%ebp),%edx
  800994:	29 c2                	sub    %eax,%edx
  800996:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800999:	01 c0                	add    %eax,%eax
  80099b:	85 c0                	test   %eax,%eax
  80099d:	79 05                	jns    8009a4 <_main+0x96c>
  80099f:	05 ff 0f 00 00       	add    $0xfff,%eax
  8009a4:	c1 f8 0c             	sar    $0xc,%eax
  8009a7:	39 c2                	cmp    %eax,%edx
  8009a9:	74 17                	je     8009c2 <_main+0x98a>
  8009ab:	83 ec 04             	sub    $0x4,%esp
  8009ae:	68 28 2b 80 00       	push   $0x802b28
  8009b3:	68 b2 00 00 00       	push   $0xb2
  8009b8:	68 ec 29 80 00       	push   $0x8029ec
  8009bd:	e8 d5 02 00 00       	call   800c97 <_panic>
	if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: Extra or less pages are removed from main memory");
  8009c2:	e8 9a 18 00 00       	call   802261 <sys_calculate_free_frames>
  8009c7:	89 c2                	mov    %eax,%edx
  8009c9:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8009cc:	39 c2                	cmp    %eax,%edx
  8009ce:	74 17                	je     8009e7 <_main+0x9af>
  8009d0:	83 ec 04             	sub    $0x4,%esp
  8009d3:	68 64 2b 80 00       	push   $0x802b64
  8009d8:	68 b3 00 00 00       	push   $0xb3
  8009dd:	68 ec 29 80 00       	push   $0x8029ec
  8009e2:	e8 b0 02 00 00       	call   800c97 <_panic>


	freeFrames = sys_calculate_free_frames() ;
  8009e7:	e8 75 18 00 00       	call   802261 <sys_calculate_free_frames>
  8009ec:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  8009ef:	e8 f0 18 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  8009f4:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(4*Mega-kilo);		// Use Hole 6 -> Hole 6 = 0 M
  8009f7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009fa:	c1 e0 02             	shl    $0x2,%eax
  8009fd:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800a00:	83 ec 0c             	sub    $0xc,%esp
  800a03:	50                   	push   %eax
  800a04:	e8 ba 12 00 00       	call   801cc3 <malloc>
  800a09:	83 c4 10             	add    $0x10,%esp
  800a0c:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x83000000)
  800a0f:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800a12:	3d 00 00 00 83       	cmp    $0x83000000,%eax
  800a17:	74 17                	je     800a30 <_main+0x9f8>
		panic("Next Fit not working correctly");
  800a19:	83 ec 04             	sub    $0x4,%esp
  800a1c:	68 a4 2b 80 00       	push   $0x802ba4
  800a21:	68 ba 00 00 00       	push   $0xba
  800a26:	68 ec 29 80 00       	push   $0x8029ec
  800a2b:	e8 67 02 00 00       	call   800c97 <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  4*Mega/PAGE_SIZE) panic("Wrong page file allocation: ");
  800a30:	e8 af 18 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  800a35:	2b 45 cc             	sub    -0x34(%ebp),%eax
  800a38:	89 c2                	mov    %eax,%edx
  800a3a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a3d:	c1 e0 02             	shl    $0x2,%eax
  800a40:	85 c0                	test   %eax,%eax
  800a42:	79 05                	jns    800a49 <_main+0xa11>
  800a44:	05 ff 0f 00 00       	add    $0xfff,%eax
  800a49:	c1 f8 0c             	sar    $0xc,%eax
  800a4c:	39 c2                	cmp    %eax,%edx
  800a4e:	74 17                	je     800a67 <_main+0xa2f>
  800a50:	83 ec 04             	sub    $0x4,%esp
  800a53:	68 fa 2a 80 00       	push   $0x802afa
  800a58:	68 bb 00 00 00       	push   $0xbb
  800a5d:	68 ec 29 80 00       	push   $0x8029ec
  800a62:	e8 30 02 00 00       	call   800c97 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800a67:	e8 f5 17 00 00       	call   802261 <sys_calculate_free_frames>
  800a6c:	89 c2                	mov    %eax,%edx
  800a6e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800a71:	39 c2                	cmp    %eax,%edx
  800a73:	74 17                	je     800a8c <_main+0xa54>
  800a75:	83 ec 04             	sub    $0x4,%esp
  800a78:	68 17 2b 80 00       	push   $0x802b17
  800a7d:	68 bc 00 00 00       	push   $0xbc
  800a82:	68 ec 29 80 00       	push   $0x8029ec
  800a87:	e8 0b 02 00 00       	call   800c97 <_panic>

	cprintf("\nCASE2: (next fit WITH looping back) is succeeded...\n") ;
  800a8c:	83 ec 0c             	sub    $0xc,%esp
  800a8f:	68 00 2c 80 00       	push   $0x802c00
  800a94:	e8 a0 04 00 00       	call   800f39 <cprintf>
  800a99:	83 c4 10             	add    $0x10,%esp

	// Check that next fit returns null in case all holes are not free
	freeFrames = sys_calculate_free_frames() ;
  800a9c:	e8 c0 17 00 00       	call   802261 <sys_calculate_free_frames>
  800aa1:	89 45 d0             	mov    %eax,-0x30(%ebp)
	usedDiskPages = sys_pf_calculate_allocated_pages();
  800aa4:	e8 3b 18 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  800aa9:	89 45 cc             	mov    %eax,-0x34(%ebp)
	tempAddress = malloc(6*Mega); 			   // No Suitable Hole is available
  800aac:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800aaf:	89 d0                	mov    %edx,%eax
  800ab1:	01 c0                	add    %eax,%eax
  800ab3:	01 d0                	add    %edx,%eax
  800ab5:	01 c0                	add    %eax,%eax
  800ab7:	83 ec 0c             	sub    $0xc,%esp
  800aba:	50                   	push   %eax
  800abb:	e8 03 12 00 00       	call   801cc3 <malloc>
  800ac0:	83 c4 10             	add    $0x10,%esp
  800ac3:	89 45 c8             	mov    %eax,-0x38(%ebp)
	if((uint32)tempAddress != 0x0)
  800ac6:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800ac9:	85 c0                	test   %eax,%eax
  800acb:	74 17                	je     800ae4 <_main+0xaac>
		panic("Next Fit not working correctly");
  800acd:	83 ec 04             	sub    $0x4,%esp
  800ad0:	68 a4 2b 80 00       	push   $0x802ba4
  800ad5:	68 c5 00 00 00       	push   $0xc5
  800ada:	68 ec 29 80 00       	push   $0x8029ec
  800adf:	e8 b3 01 00 00       	call   800c97 <_panic>
	if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  800ae4:	e8 fb 17 00 00       	call   8022e4 <sys_pf_calculate_allocated_pages>
  800ae9:	3b 45 cc             	cmp    -0x34(%ebp),%eax
  800aec:	74 17                	je     800b05 <_main+0xacd>
  800aee:	83 ec 04             	sub    $0x4,%esp
  800af1:	68 fa 2a 80 00       	push   $0x802afa
  800af6:	68 c6 00 00 00       	push   $0xc6
  800afb:	68 ec 29 80 00       	push   $0x8029ec
  800b00:	e8 92 01 00 00       	call   800c97 <_panic>
	if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation");
  800b05:	e8 57 17 00 00       	call   802261 <sys_calculate_free_frames>
  800b0a:	89 c2                	mov    %eax,%edx
  800b0c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800b0f:	39 c2                	cmp    %eax,%edx
  800b11:	74 17                	je     800b2a <_main+0xaf2>
  800b13:	83 ec 04             	sub    $0x4,%esp
  800b16:	68 17 2b 80 00       	push   $0x802b17
  800b1b:	68 c7 00 00 00       	push   $0xc7
  800b20:	68 ec 29 80 00       	push   $0x8029ec
  800b25:	e8 6d 01 00 00       	call   800c97 <_panic>

	cprintf("\nCASE3: (next fit with insufficient space) is succeeded...\n") ;
  800b2a:	83 ec 0c             	sub    $0xc,%esp
  800b2d:	68 38 2c 80 00       	push   $0x802c38
  800b32:	e8 02 04 00 00       	call   800f39 <cprintf>
  800b37:	83 c4 10             	add    $0x10,%esp

	cprintf("Congratulations!! test Next Fit completed successfully.\n");
  800b3a:	83 ec 0c             	sub    $0xc,%esp
  800b3d:	68 74 2c 80 00       	push   $0x802c74
  800b42:	e8 f2 03 00 00       	call   800f39 <cprintf>
  800b47:	83 c4 10             	add    $0x10,%esp

	return;
  800b4a:	90                   	nop
}
  800b4b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b4e:	5b                   	pop    %ebx
  800b4f:	5f                   	pop    %edi
  800b50:	5d                   	pop    %ebp
  800b51:	c3                   	ret    

00800b52 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800b52:	55                   	push   %ebp
  800b53:	89 e5                	mov    %esp,%ebp
  800b55:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800b58:	e8 39 16 00 00       	call   802196 <sys_getenvindex>
  800b5d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800b60:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b63:	89 d0                	mov    %edx,%eax
  800b65:	c1 e0 03             	shl    $0x3,%eax
  800b68:	01 d0                	add    %edx,%eax
  800b6a:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800b71:	01 c8                	add    %ecx,%eax
  800b73:	01 c0                	add    %eax,%eax
  800b75:	01 d0                	add    %edx,%eax
  800b77:	01 c0                	add    %eax,%eax
  800b79:	01 d0                	add    %edx,%eax
  800b7b:	89 c2                	mov    %eax,%edx
  800b7d:	c1 e2 05             	shl    $0x5,%edx
  800b80:	29 c2                	sub    %eax,%edx
  800b82:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800b89:	89 c2                	mov    %eax,%edx
  800b8b:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800b91:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800b96:	a1 20 40 80 00       	mov    0x804020,%eax
  800b9b:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800ba1:	84 c0                	test   %al,%al
  800ba3:	74 0f                	je     800bb4 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800ba5:	a1 20 40 80 00       	mov    0x804020,%eax
  800baa:	05 40 3c 01 00       	add    $0x13c40,%eax
  800baf:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800bb4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800bb8:	7e 0a                	jle    800bc4 <libmain+0x72>
		binaryname = argv[0];
  800bba:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bbd:	8b 00                	mov    (%eax),%eax
  800bbf:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  800bc4:	83 ec 08             	sub    $0x8,%esp
  800bc7:	ff 75 0c             	pushl  0xc(%ebp)
  800bca:	ff 75 08             	pushl  0x8(%ebp)
  800bcd:	e8 66 f4 ff ff       	call   800038 <_main>
  800bd2:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800bd5:	e8 57 17 00 00       	call   802331 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800bda:	83 ec 0c             	sub    $0xc,%esp
  800bdd:	68 c8 2c 80 00       	push   $0x802cc8
  800be2:	e8 52 03 00 00       	call   800f39 <cprintf>
  800be7:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800bea:	a1 20 40 80 00       	mov    0x804020,%eax
  800bef:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800bf5:	a1 20 40 80 00       	mov    0x804020,%eax
  800bfa:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800c00:	83 ec 04             	sub    $0x4,%esp
  800c03:	52                   	push   %edx
  800c04:	50                   	push   %eax
  800c05:	68 f0 2c 80 00       	push   $0x802cf0
  800c0a:	e8 2a 03 00 00       	call   800f39 <cprintf>
  800c0f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800c12:	a1 20 40 80 00       	mov    0x804020,%eax
  800c17:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800c1d:	a1 20 40 80 00       	mov    0x804020,%eax
  800c22:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800c28:	83 ec 04             	sub    $0x4,%esp
  800c2b:	52                   	push   %edx
  800c2c:	50                   	push   %eax
  800c2d:	68 18 2d 80 00       	push   $0x802d18
  800c32:	e8 02 03 00 00       	call   800f39 <cprintf>
  800c37:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800c3a:	a1 20 40 80 00       	mov    0x804020,%eax
  800c3f:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800c45:	83 ec 08             	sub    $0x8,%esp
  800c48:	50                   	push   %eax
  800c49:	68 59 2d 80 00       	push   $0x802d59
  800c4e:	e8 e6 02 00 00       	call   800f39 <cprintf>
  800c53:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800c56:	83 ec 0c             	sub    $0xc,%esp
  800c59:	68 c8 2c 80 00       	push   $0x802cc8
  800c5e:	e8 d6 02 00 00       	call   800f39 <cprintf>
  800c63:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800c66:	e8 e0 16 00 00       	call   80234b <sys_enable_interrupt>

	// exit gracefully
	exit();
  800c6b:	e8 19 00 00 00       	call   800c89 <exit>
}
  800c70:	90                   	nop
  800c71:	c9                   	leave  
  800c72:	c3                   	ret    

00800c73 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800c73:	55                   	push   %ebp
  800c74:	89 e5                	mov    %esp,%ebp
  800c76:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800c79:	83 ec 0c             	sub    $0xc,%esp
  800c7c:	6a 00                	push   $0x0
  800c7e:	e8 df 14 00 00       	call   802162 <sys_env_destroy>
  800c83:	83 c4 10             	add    $0x10,%esp
}
  800c86:	90                   	nop
  800c87:	c9                   	leave  
  800c88:	c3                   	ret    

00800c89 <exit>:

void
exit(void)
{
  800c89:	55                   	push   %ebp
  800c8a:	89 e5                	mov    %esp,%ebp
  800c8c:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800c8f:	e8 34 15 00 00       	call   8021c8 <sys_env_exit>
}
  800c94:	90                   	nop
  800c95:	c9                   	leave  
  800c96:	c3                   	ret    

00800c97 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800c97:	55                   	push   %ebp
  800c98:	89 e5                	mov    %esp,%ebp
  800c9a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800c9d:	8d 45 10             	lea    0x10(%ebp),%eax
  800ca0:	83 c0 04             	add    $0x4,%eax
  800ca3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800ca6:	a1 18 41 80 00       	mov    0x804118,%eax
  800cab:	85 c0                	test   %eax,%eax
  800cad:	74 16                	je     800cc5 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800caf:	a1 18 41 80 00       	mov    0x804118,%eax
  800cb4:	83 ec 08             	sub    $0x8,%esp
  800cb7:	50                   	push   %eax
  800cb8:	68 70 2d 80 00       	push   $0x802d70
  800cbd:	e8 77 02 00 00       	call   800f39 <cprintf>
  800cc2:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800cc5:	a1 00 40 80 00       	mov    0x804000,%eax
  800cca:	ff 75 0c             	pushl  0xc(%ebp)
  800ccd:	ff 75 08             	pushl  0x8(%ebp)
  800cd0:	50                   	push   %eax
  800cd1:	68 75 2d 80 00       	push   $0x802d75
  800cd6:	e8 5e 02 00 00       	call   800f39 <cprintf>
  800cdb:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800cde:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce1:	83 ec 08             	sub    $0x8,%esp
  800ce4:	ff 75 f4             	pushl  -0xc(%ebp)
  800ce7:	50                   	push   %eax
  800ce8:	e8 e1 01 00 00       	call   800ece <vcprintf>
  800ced:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800cf0:	83 ec 08             	sub    $0x8,%esp
  800cf3:	6a 00                	push   $0x0
  800cf5:	68 91 2d 80 00       	push   $0x802d91
  800cfa:	e8 cf 01 00 00       	call   800ece <vcprintf>
  800cff:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800d02:	e8 82 ff ff ff       	call   800c89 <exit>

	// should not return here
	while (1) ;
  800d07:	eb fe                	jmp    800d07 <_panic+0x70>

00800d09 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800d09:	55                   	push   %ebp
  800d0a:	89 e5                	mov    %esp,%ebp
  800d0c:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800d0f:	a1 20 40 80 00       	mov    0x804020,%eax
  800d14:	8b 50 74             	mov    0x74(%eax),%edx
  800d17:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1a:	39 c2                	cmp    %eax,%edx
  800d1c:	74 14                	je     800d32 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800d1e:	83 ec 04             	sub    $0x4,%esp
  800d21:	68 94 2d 80 00       	push   $0x802d94
  800d26:	6a 26                	push   $0x26
  800d28:	68 e0 2d 80 00       	push   $0x802de0
  800d2d:	e8 65 ff ff ff       	call   800c97 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800d32:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800d39:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800d40:	e9 b6 00 00 00       	jmp    800dfb <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800d45:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d48:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d52:	01 d0                	add    %edx,%eax
  800d54:	8b 00                	mov    (%eax),%eax
  800d56:	85 c0                	test   %eax,%eax
  800d58:	75 08                	jne    800d62 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800d5a:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800d5d:	e9 96 00 00 00       	jmp    800df8 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800d62:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800d69:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800d70:	eb 5d                	jmp    800dcf <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800d72:	a1 20 40 80 00       	mov    0x804020,%eax
  800d77:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800d7d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800d80:	c1 e2 04             	shl    $0x4,%edx
  800d83:	01 d0                	add    %edx,%eax
  800d85:	8a 40 04             	mov    0x4(%eax),%al
  800d88:	84 c0                	test   %al,%al
  800d8a:	75 40                	jne    800dcc <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800d8c:	a1 20 40 80 00       	mov    0x804020,%eax
  800d91:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800d97:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800d9a:	c1 e2 04             	shl    $0x4,%edx
  800d9d:	01 d0                	add    %edx,%eax
  800d9f:	8b 00                	mov    (%eax),%eax
  800da1:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800da4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800da7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800dac:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800dae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800db1:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800db8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbb:	01 c8                	add    %ecx,%eax
  800dbd:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800dbf:	39 c2                	cmp    %eax,%edx
  800dc1:	75 09                	jne    800dcc <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800dc3:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800dca:	eb 12                	jmp    800dde <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800dcc:	ff 45 e8             	incl   -0x18(%ebp)
  800dcf:	a1 20 40 80 00       	mov    0x804020,%eax
  800dd4:	8b 50 74             	mov    0x74(%eax),%edx
  800dd7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800dda:	39 c2                	cmp    %eax,%edx
  800ddc:	77 94                	ja     800d72 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800dde:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800de2:	75 14                	jne    800df8 <CheckWSWithoutLastIndex+0xef>
			panic(
  800de4:	83 ec 04             	sub    $0x4,%esp
  800de7:	68 ec 2d 80 00       	push   $0x802dec
  800dec:	6a 3a                	push   $0x3a
  800dee:	68 e0 2d 80 00       	push   $0x802de0
  800df3:	e8 9f fe ff ff       	call   800c97 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800df8:	ff 45 f0             	incl   -0x10(%ebp)
  800dfb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dfe:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800e01:	0f 8c 3e ff ff ff    	jl     800d45 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800e07:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800e0e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800e15:	eb 20                	jmp    800e37 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800e17:	a1 20 40 80 00       	mov    0x804020,%eax
  800e1c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800e22:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e25:	c1 e2 04             	shl    $0x4,%edx
  800e28:	01 d0                	add    %edx,%eax
  800e2a:	8a 40 04             	mov    0x4(%eax),%al
  800e2d:	3c 01                	cmp    $0x1,%al
  800e2f:	75 03                	jne    800e34 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800e31:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800e34:	ff 45 e0             	incl   -0x20(%ebp)
  800e37:	a1 20 40 80 00       	mov    0x804020,%eax
  800e3c:	8b 50 74             	mov    0x74(%eax),%edx
  800e3f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e42:	39 c2                	cmp    %eax,%edx
  800e44:	77 d1                	ja     800e17 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800e46:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e49:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800e4c:	74 14                	je     800e62 <CheckWSWithoutLastIndex+0x159>
		panic(
  800e4e:	83 ec 04             	sub    $0x4,%esp
  800e51:	68 40 2e 80 00       	push   $0x802e40
  800e56:	6a 44                	push   $0x44
  800e58:	68 e0 2d 80 00       	push   $0x802de0
  800e5d:	e8 35 fe ff ff       	call   800c97 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800e62:	90                   	nop
  800e63:	c9                   	leave  
  800e64:	c3                   	ret    

00800e65 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800e65:	55                   	push   %ebp
  800e66:	89 e5                	mov    %esp,%ebp
  800e68:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800e6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6e:	8b 00                	mov    (%eax),%eax
  800e70:	8d 48 01             	lea    0x1(%eax),%ecx
  800e73:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e76:	89 0a                	mov    %ecx,(%edx)
  800e78:	8b 55 08             	mov    0x8(%ebp),%edx
  800e7b:	88 d1                	mov    %dl,%cl
  800e7d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e80:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800e84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e87:	8b 00                	mov    (%eax),%eax
  800e89:	3d ff 00 00 00       	cmp    $0xff,%eax
  800e8e:	75 2c                	jne    800ebc <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800e90:	a0 24 40 80 00       	mov    0x804024,%al
  800e95:	0f b6 c0             	movzbl %al,%eax
  800e98:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e9b:	8b 12                	mov    (%edx),%edx
  800e9d:	89 d1                	mov    %edx,%ecx
  800e9f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ea2:	83 c2 08             	add    $0x8,%edx
  800ea5:	83 ec 04             	sub    $0x4,%esp
  800ea8:	50                   	push   %eax
  800ea9:	51                   	push   %ecx
  800eaa:	52                   	push   %edx
  800eab:	e8 70 12 00 00       	call   802120 <sys_cputs>
  800eb0:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800eb3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800ebc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ebf:	8b 40 04             	mov    0x4(%eax),%eax
  800ec2:	8d 50 01             	lea    0x1(%eax),%edx
  800ec5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec8:	89 50 04             	mov    %edx,0x4(%eax)
}
  800ecb:	90                   	nop
  800ecc:	c9                   	leave  
  800ecd:	c3                   	ret    

00800ece <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800ece:	55                   	push   %ebp
  800ecf:	89 e5                	mov    %esp,%ebp
  800ed1:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800ed7:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800ede:	00 00 00 
	b.cnt = 0;
  800ee1:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800ee8:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800eeb:	ff 75 0c             	pushl  0xc(%ebp)
  800eee:	ff 75 08             	pushl  0x8(%ebp)
  800ef1:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800ef7:	50                   	push   %eax
  800ef8:	68 65 0e 80 00       	push   $0x800e65
  800efd:	e8 11 02 00 00       	call   801113 <vprintfmt>
  800f02:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800f05:	a0 24 40 80 00       	mov    0x804024,%al
  800f0a:	0f b6 c0             	movzbl %al,%eax
  800f0d:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800f13:	83 ec 04             	sub    $0x4,%esp
  800f16:	50                   	push   %eax
  800f17:	52                   	push   %edx
  800f18:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800f1e:	83 c0 08             	add    $0x8,%eax
  800f21:	50                   	push   %eax
  800f22:	e8 f9 11 00 00       	call   802120 <sys_cputs>
  800f27:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800f2a:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  800f31:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800f37:	c9                   	leave  
  800f38:	c3                   	ret    

00800f39 <cprintf>:

int cprintf(const char *fmt, ...) {
  800f39:	55                   	push   %ebp
  800f3a:	89 e5                	mov    %esp,%ebp
  800f3c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800f3f:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  800f46:	8d 45 0c             	lea    0xc(%ebp),%eax
  800f49:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800f4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4f:	83 ec 08             	sub    $0x8,%esp
  800f52:	ff 75 f4             	pushl  -0xc(%ebp)
  800f55:	50                   	push   %eax
  800f56:	e8 73 ff ff ff       	call   800ece <vcprintf>
  800f5b:	83 c4 10             	add    $0x10,%esp
  800f5e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800f61:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800f64:	c9                   	leave  
  800f65:	c3                   	ret    

00800f66 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800f66:	55                   	push   %ebp
  800f67:	89 e5                	mov    %esp,%ebp
  800f69:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800f6c:	e8 c0 13 00 00       	call   802331 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800f71:	8d 45 0c             	lea    0xc(%ebp),%eax
  800f74:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800f77:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7a:	83 ec 08             	sub    $0x8,%esp
  800f7d:	ff 75 f4             	pushl  -0xc(%ebp)
  800f80:	50                   	push   %eax
  800f81:	e8 48 ff ff ff       	call   800ece <vcprintf>
  800f86:	83 c4 10             	add    $0x10,%esp
  800f89:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800f8c:	e8 ba 13 00 00       	call   80234b <sys_enable_interrupt>
	return cnt;
  800f91:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800f94:	c9                   	leave  
  800f95:	c3                   	ret    

00800f96 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800f96:	55                   	push   %ebp
  800f97:	89 e5                	mov    %esp,%ebp
  800f99:	53                   	push   %ebx
  800f9a:	83 ec 14             	sub    $0x14,%esp
  800f9d:	8b 45 10             	mov    0x10(%ebp),%eax
  800fa0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fa3:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800fa9:	8b 45 18             	mov    0x18(%ebp),%eax
  800fac:	ba 00 00 00 00       	mov    $0x0,%edx
  800fb1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800fb4:	77 55                	ja     80100b <printnum+0x75>
  800fb6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800fb9:	72 05                	jb     800fc0 <printnum+0x2a>
  800fbb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fbe:	77 4b                	ja     80100b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800fc0:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800fc3:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800fc6:	8b 45 18             	mov    0x18(%ebp),%eax
  800fc9:	ba 00 00 00 00       	mov    $0x0,%edx
  800fce:	52                   	push   %edx
  800fcf:	50                   	push   %eax
  800fd0:	ff 75 f4             	pushl  -0xc(%ebp)
  800fd3:	ff 75 f0             	pushl  -0x10(%ebp)
  800fd6:	e8 79 17 00 00       	call   802754 <__udivdi3>
  800fdb:	83 c4 10             	add    $0x10,%esp
  800fde:	83 ec 04             	sub    $0x4,%esp
  800fe1:	ff 75 20             	pushl  0x20(%ebp)
  800fe4:	53                   	push   %ebx
  800fe5:	ff 75 18             	pushl  0x18(%ebp)
  800fe8:	52                   	push   %edx
  800fe9:	50                   	push   %eax
  800fea:	ff 75 0c             	pushl  0xc(%ebp)
  800fed:	ff 75 08             	pushl  0x8(%ebp)
  800ff0:	e8 a1 ff ff ff       	call   800f96 <printnum>
  800ff5:	83 c4 20             	add    $0x20,%esp
  800ff8:	eb 1a                	jmp    801014 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800ffa:	83 ec 08             	sub    $0x8,%esp
  800ffd:	ff 75 0c             	pushl  0xc(%ebp)
  801000:	ff 75 20             	pushl  0x20(%ebp)
  801003:	8b 45 08             	mov    0x8(%ebp),%eax
  801006:	ff d0                	call   *%eax
  801008:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80100b:	ff 4d 1c             	decl   0x1c(%ebp)
  80100e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  801012:	7f e6                	jg     800ffa <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  801014:	8b 4d 18             	mov    0x18(%ebp),%ecx
  801017:	bb 00 00 00 00       	mov    $0x0,%ebx
  80101c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80101f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801022:	53                   	push   %ebx
  801023:	51                   	push   %ecx
  801024:	52                   	push   %edx
  801025:	50                   	push   %eax
  801026:	e8 39 18 00 00       	call   802864 <__umoddi3>
  80102b:	83 c4 10             	add    $0x10,%esp
  80102e:	05 b4 30 80 00       	add    $0x8030b4,%eax
  801033:	8a 00                	mov    (%eax),%al
  801035:	0f be c0             	movsbl %al,%eax
  801038:	83 ec 08             	sub    $0x8,%esp
  80103b:	ff 75 0c             	pushl  0xc(%ebp)
  80103e:	50                   	push   %eax
  80103f:	8b 45 08             	mov    0x8(%ebp),%eax
  801042:	ff d0                	call   *%eax
  801044:	83 c4 10             	add    $0x10,%esp
}
  801047:	90                   	nop
  801048:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80104b:	c9                   	leave  
  80104c:	c3                   	ret    

0080104d <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80104d:	55                   	push   %ebp
  80104e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801050:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801054:	7e 1c                	jle    801072 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  801056:	8b 45 08             	mov    0x8(%ebp),%eax
  801059:	8b 00                	mov    (%eax),%eax
  80105b:	8d 50 08             	lea    0x8(%eax),%edx
  80105e:	8b 45 08             	mov    0x8(%ebp),%eax
  801061:	89 10                	mov    %edx,(%eax)
  801063:	8b 45 08             	mov    0x8(%ebp),%eax
  801066:	8b 00                	mov    (%eax),%eax
  801068:	83 e8 08             	sub    $0x8,%eax
  80106b:	8b 50 04             	mov    0x4(%eax),%edx
  80106e:	8b 00                	mov    (%eax),%eax
  801070:	eb 40                	jmp    8010b2 <getuint+0x65>
	else if (lflag)
  801072:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801076:	74 1e                	je     801096 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  801078:	8b 45 08             	mov    0x8(%ebp),%eax
  80107b:	8b 00                	mov    (%eax),%eax
  80107d:	8d 50 04             	lea    0x4(%eax),%edx
  801080:	8b 45 08             	mov    0x8(%ebp),%eax
  801083:	89 10                	mov    %edx,(%eax)
  801085:	8b 45 08             	mov    0x8(%ebp),%eax
  801088:	8b 00                	mov    (%eax),%eax
  80108a:	83 e8 04             	sub    $0x4,%eax
  80108d:	8b 00                	mov    (%eax),%eax
  80108f:	ba 00 00 00 00       	mov    $0x0,%edx
  801094:	eb 1c                	jmp    8010b2 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801096:	8b 45 08             	mov    0x8(%ebp),%eax
  801099:	8b 00                	mov    (%eax),%eax
  80109b:	8d 50 04             	lea    0x4(%eax),%edx
  80109e:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a1:	89 10                	mov    %edx,(%eax)
  8010a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a6:	8b 00                	mov    (%eax),%eax
  8010a8:	83 e8 04             	sub    $0x4,%eax
  8010ab:	8b 00                	mov    (%eax),%eax
  8010ad:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8010b2:	5d                   	pop    %ebp
  8010b3:	c3                   	ret    

008010b4 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8010b4:	55                   	push   %ebp
  8010b5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8010b7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8010bb:	7e 1c                	jle    8010d9 <getint+0x25>
		return va_arg(*ap, long long);
  8010bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c0:	8b 00                	mov    (%eax),%eax
  8010c2:	8d 50 08             	lea    0x8(%eax),%edx
  8010c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c8:	89 10                	mov    %edx,(%eax)
  8010ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cd:	8b 00                	mov    (%eax),%eax
  8010cf:	83 e8 08             	sub    $0x8,%eax
  8010d2:	8b 50 04             	mov    0x4(%eax),%edx
  8010d5:	8b 00                	mov    (%eax),%eax
  8010d7:	eb 38                	jmp    801111 <getint+0x5d>
	else if (lflag)
  8010d9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010dd:	74 1a                	je     8010f9 <getint+0x45>
		return va_arg(*ap, long);
  8010df:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e2:	8b 00                	mov    (%eax),%eax
  8010e4:	8d 50 04             	lea    0x4(%eax),%edx
  8010e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ea:	89 10                	mov    %edx,(%eax)
  8010ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ef:	8b 00                	mov    (%eax),%eax
  8010f1:	83 e8 04             	sub    $0x4,%eax
  8010f4:	8b 00                	mov    (%eax),%eax
  8010f6:	99                   	cltd   
  8010f7:	eb 18                	jmp    801111 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8010f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fc:	8b 00                	mov    (%eax),%eax
  8010fe:	8d 50 04             	lea    0x4(%eax),%edx
  801101:	8b 45 08             	mov    0x8(%ebp),%eax
  801104:	89 10                	mov    %edx,(%eax)
  801106:	8b 45 08             	mov    0x8(%ebp),%eax
  801109:	8b 00                	mov    (%eax),%eax
  80110b:	83 e8 04             	sub    $0x4,%eax
  80110e:	8b 00                	mov    (%eax),%eax
  801110:	99                   	cltd   
}
  801111:	5d                   	pop    %ebp
  801112:	c3                   	ret    

00801113 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  801113:	55                   	push   %ebp
  801114:	89 e5                	mov    %esp,%ebp
  801116:	56                   	push   %esi
  801117:	53                   	push   %ebx
  801118:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80111b:	eb 17                	jmp    801134 <vprintfmt+0x21>
			if (ch == '\0')
  80111d:	85 db                	test   %ebx,%ebx
  80111f:	0f 84 af 03 00 00    	je     8014d4 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  801125:	83 ec 08             	sub    $0x8,%esp
  801128:	ff 75 0c             	pushl  0xc(%ebp)
  80112b:	53                   	push   %ebx
  80112c:	8b 45 08             	mov    0x8(%ebp),%eax
  80112f:	ff d0                	call   *%eax
  801131:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801134:	8b 45 10             	mov    0x10(%ebp),%eax
  801137:	8d 50 01             	lea    0x1(%eax),%edx
  80113a:	89 55 10             	mov    %edx,0x10(%ebp)
  80113d:	8a 00                	mov    (%eax),%al
  80113f:	0f b6 d8             	movzbl %al,%ebx
  801142:	83 fb 25             	cmp    $0x25,%ebx
  801145:	75 d6                	jne    80111d <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  801147:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80114b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  801152:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  801159:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801160:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801167:	8b 45 10             	mov    0x10(%ebp),%eax
  80116a:	8d 50 01             	lea    0x1(%eax),%edx
  80116d:	89 55 10             	mov    %edx,0x10(%ebp)
  801170:	8a 00                	mov    (%eax),%al
  801172:	0f b6 d8             	movzbl %al,%ebx
  801175:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801178:	83 f8 55             	cmp    $0x55,%eax
  80117b:	0f 87 2b 03 00 00    	ja     8014ac <vprintfmt+0x399>
  801181:	8b 04 85 d8 30 80 00 	mov    0x8030d8(,%eax,4),%eax
  801188:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80118a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80118e:	eb d7                	jmp    801167 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801190:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801194:	eb d1                	jmp    801167 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801196:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80119d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8011a0:	89 d0                	mov    %edx,%eax
  8011a2:	c1 e0 02             	shl    $0x2,%eax
  8011a5:	01 d0                	add    %edx,%eax
  8011a7:	01 c0                	add    %eax,%eax
  8011a9:	01 d8                	add    %ebx,%eax
  8011ab:	83 e8 30             	sub    $0x30,%eax
  8011ae:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8011b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b4:	8a 00                	mov    (%eax),%al
  8011b6:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8011b9:	83 fb 2f             	cmp    $0x2f,%ebx
  8011bc:	7e 3e                	jle    8011fc <vprintfmt+0xe9>
  8011be:	83 fb 39             	cmp    $0x39,%ebx
  8011c1:	7f 39                	jg     8011fc <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8011c3:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8011c6:	eb d5                	jmp    80119d <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8011c8:	8b 45 14             	mov    0x14(%ebp),%eax
  8011cb:	83 c0 04             	add    $0x4,%eax
  8011ce:	89 45 14             	mov    %eax,0x14(%ebp)
  8011d1:	8b 45 14             	mov    0x14(%ebp),%eax
  8011d4:	83 e8 04             	sub    $0x4,%eax
  8011d7:	8b 00                	mov    (%eax),%eax
  8011d9:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8011dc:	eb 1f                	jmp    8011fd <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8011de:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8011e2:	79 83                	jns    801167 <vprintfmt+0x54>
				width = 0;
  8011e4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8011eb:	e9 77 ff ff ff       	jmp    801167 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8011f0:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8011f7:	e9 6b ff ff ff       	jmp    801167 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8011fc:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8011fd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801201:	0f 89 60 ff ff ff    	jns    801167 <vprintfmt+0x54>
				width = precision, precision = -1;
  801207:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80120a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80120d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801214:	e9 4e ff ff ff       	jmp    801167 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801219:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80121c:	e9 46 ff ff ff       	jmp    801167 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801221:	8b 45 14             	mov    0x14(%ebp),%eax
  801224:	83 c0 04             	add    $0x4,%eax
  801227:	89 45 14             	mov    %eax,0x14(%ebp)
  80122a:	8b 45 14             	mov    0x14(%ebp),%eax
  80122d:	83 e8 04             	sub    $0x4,%eax
  801230:	8b 00                	mov    (%eax),%eax
  801232:	83 ec 08             	sub    $0x8,%esp
  801235:	ff 75 0c             	pushl  0xc(%ebp)
  801238:	50                   	push   %eax
  801239:	8b 45 08             	mov    0x8(%ebp),%eax
  80123c:	ff d0                	call   *%eax
  80123e:	83 c4 10             	add    $0x10,%esp
			break;
  801241:	e9 89 02 00 00       	jmp    8014cf <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801246:	8b 45 14             	mov    0x14(%ebp),%eax
  801249:	83 c0 04             	add    $0x4,%eax
  80124c:	89 45 14             	mov    %eax,0x14(%ebp)
  80124f:	8b 45 14             	mov    0x14(%ebp),%eax
  801252:	83 e8 04             	sub    $0x4,%eax
  801255:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801257:	85 db                	test   %ebx,%ebx
  801259:	79 02                	jns    80125d <vprintfmt+0x14a>
				err = -err;
  80125b:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80125d:	83 fb 64             	cmp    $0x64,%ebx
  801260:	7f 0b                	jg     80126d <vprintfmt+0x15a>
  801262:	8b 34 9d 20 2f 80 00 	mov    0x802f20(,%ebx,4),%esi
  801269:	85 f6                	test   %esi,%esi
  80126b:	75 19                	jne    801286 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80126d:	53                   	push   %ebx
  80126e:	68 c5 30 80 00       	push   $0x8030c5
  801273:	ff 75 0c             	pushl  0xc(%ebp)
  801276:	ff 75 08             	pushl  0x8(%ebp)
  801279:	e8 5e 02 00 00       	call   8014dc <printfmt>
  80127e:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801281:	e9 49 02 00 00       	jmp    8014cf <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801286:	56                   	push   %esi
  801287:	68 ce 30 80 00       	push   $0x8030ce
  80128c:	ff 75 0c             	pushl  0xc(%ebp)
  80128f:	ff 75 08             	pushl  0x8(%ebp)
  801292:	e8 45 02 00 00       	call   8014dc <printfmt>
  801297:	83 c4 10             	add    $0x10,%esp
			break;
  80129a:	e9 30 02 00 00       	jmp    8014cf <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80129f:	8b 45 14             	mov    0x14(%ebp),%eax
  8012a2:	83 c0 04             	add    $0x4,%eax
  8012a5:	89 45 14             	mov    %eax,0x14(%ebp)
  8012a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8012ab:	83 e8 04             	sub    $0x4,%eax
  8012ae:	8b 30                	mov    (%eax),%esi
  8012b0:	85 f6                	test   %esi,%esi
  8012b2:	75 05                	jne    8012b9 <vprintfmt+0x1a6>
				p = "(null)";
  8012b4:	be d1 30 80 00       	mov    $0x8030d1,%esi
			if (width > 0 && padc != '-')
  8012b9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8012bd:	7e 6d                	jle    80132c <vprintfmt+0x219>
  8012bf:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8012c3:	74 67                	je     80132c <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8012c5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8012c8:	83 ec 08             	sub    $0x8,%esp
  8012cb:	50                   	push   %eax
  8012cc:	56                   	push   %esi
  8012cd:	e8 0c 03 00 00       	call   8015de <strnlen>
  8012d2:	83 c4 10             	add    $0x10,%esp
  8012d5:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8012d8:	eb 16                	jmp    8012f0 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8012da:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8012de:	83 ec 08             	sub    $0x8,%esp
  8012e1:	ff 75 0c             	pushl  0xc(%ebp)
  8012e4:	50                   	push   %eax
  8012e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e8:	ff d0                	call   *%eax
  8012ea:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8012ed:	ff 4d e4             	decl   -0x1c(%ebp)
  8012f0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8012f4:	7f e4                	jg     8012da <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8012f6:	eb 34                	jmp    80132c <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8012f8:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8012fc:	74 1c                	je     80131a <vprintfmt+0x207>
  8012fe:	83 fb 1f             	cmp    $0x1f,%ebx
  801301:	7e 05                	jle    801308 <vprintfmt+0x1f5>
  801303:	83 fb 7e             	cmp    $0x7e,%ebx
  801306:	7e 12                	jle    80131a <vprintfmt+0x207>
					putch('?', putdat);
  801308:	83 ec 08             	sub    $0x8,%esp
  80130b:	ff 75 0c             	pushl  0xc(%ebp)
  80130e:	6a 3f                	push   $0x3f
  801310:	8b 45 08             	mov    0x8(%ebp),%eax
  801313:	ff d0                	call   *%eax
  801315:	83 c4 10             	add    $0x10,%esp
  801318:	eb 0f                	jmp    801329 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80131a:	83 ec 08             	sub    $0x8,%esp
  80131d:	ff 75 0c             	pushl  0xc(%ebp)
  801320:	53                   	push   %ebx
  801321:	8b 45 08             	mov    0x8(%ebp),%eax
  801324:	ff d0                	call   *%eax
  801326:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801329:	ff 4d e4             	decl   -0x1c(%ebp)
  80132c:	89 f0                	mov    %esi,%eax
  80132e:	8d 70 01             	lea    0x1(%eax),%esi
  801331:	8a 00                	mov    (%eax),%al
  801333:	0f be d8             	movsbl %al,%ebx
  801336:	85 db                	test   %ebx,%ebx
  801338:	74 24                	je     80135e <vprintfmt+0x24b>
  80133a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80133e:	78 b8                	js     8012f8 <vprintfmt+0x1e5>
  801340:	ff 4d e0             	decl   -0x20(%ebp)
  801343:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801347:	79 af                	jns    8012f8 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801349:	eb 13                	jmp    80135e <vprintfmt+0x24b>
				putch(' ', putdat);
  80134b:	83 ec 08             	sub    $0x8,%esp
  80134e:	ff 75 0c             	pushl  0xc(%ebp)
  801351:	6a 20                	push   $0x20
  801353:	8b 45 08             	mov    0x8(%ebp),%eax
  801356:	ff d0                	call   *%eax
  801358:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80135b:	ff 4d e4             	decl   -0x1c(%ebp)
  80135e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801362:	7f e7                	jg     80134b <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801364:	e9 66 01 00 00       	jmp    8014cf <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801369:	83 ec 08             	sub    $0x8,%esp
  80136c:	ff 75 e8             	pushl  -0x18(%ebp)
  80136f:	8d 45 14             	lea    0x14(%ebp),%eax
  801372:	50                   	push   %eax
  801373:	e8 3c fd ff ff       	call   8010b4 <getint>
  801378:	83 c4 10             	add    $0x10,%esp
  80137b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80137e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801381:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801384:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801387:	85 d2                	test   %edx,%edx
  801389:	79 23                	jns    8013ae <vprintfmt+0x29b>
				putch('-', putdat);
  80138b:	83 ec 08             	sub    $0x8,%esp
  80138e:	ff 75 0c             	pushl  0xc(%ebp)
  801391:	6a 2d                	push   $0x2d
  801393:	8b 45 08             	mov    0x8(%ebp),%eax
  801396:	ff d0                	call   *%eax
  801398:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80139b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80139e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013a1:	f7 d8                	neg    %eax
  8013a3:	83 d2 00             	adc    $0x0,%edx
  8013a6:	f7 da                	neg    %edx
  8013a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013ab:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8013ae:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8013b5:	e9 bc 00 00 00       	jmp    801476 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8013ba:	83 ec 08             	sub    $0x8,%esp
  8013bd:	ff 75 e8             	pushl  -0x18(%ebp)
  8013c0:	8d 45 14             	lea    0x14(%ebp),%eax
  8013c3:	50                   	push   %eax
  8013c4:	e8 84 fc ff ff       	call   80104d <getuint>
  8013c9:	83 c4 10             	add    $0x10,%esp
  8013cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8013cf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8013d2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8013d9:	e9 98 00 00 00       	jmp    801476 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8013de:	83 ec 08             	sub    $0x8,%esp
  8013e1:	ff 75 0c             	pushl  0xc(%ebp)
  8013e4:	6a 58                	push   $0x58
  8013e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e9:	ff d0                	call   *%eax
  8013eb:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8013ee:	83 ec 08             	sub    $0x8,%esp
  8013f1:	ff 75 0c             	pushl  0xc(%ebp)
  8013f4:	6a 58                	push   $0x58
  8013f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f9:	ff d0                	call   *%eax
  8013fb:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8013fe:	83 ec 08             	sub    $0x8,%esp
  801401:	ff 75 0c             	pushl  0xc(%ebp)
  801404:	6a 58                	push   $0x58
  801406:	8b 45 08             	mov    0x8(%ebp),%eax
  801409:	ff d0                	call   *%eax
  80140b:	83 c4 10             	add    $0x10,%esp
			break;
  80140e:	e9 bc 00 00 00       	jmp    8014cf <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801413:	83 ec 08             	sub    $0x8,%esp
  801416:	ff 75 0c             	pushl  0xc(%ebp)
  801419:	6a 30                	push   $0x30
  80141b:	8b 45 08             	mov    0x8(%ebp),%eax
  80141e:	ff d0                	call   *%eax
  801420:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801423:	83 ec 08             	sub    $0x8,%esp
  801426:	ff 75 0c             	pushl  0xc(%ebp)
  801429:	6a 78                	push   $0x78
  80142b:	8b 45 08             	mov    0x8(%ebp),%eax
  80142e:	ff d0                	call   *%eax
  801430:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801433:	8b 45 14             	mov    0x14(%ebp),%eax
  801436:	83 c0 04             	add    $0x4,%eax
  801439:	89 45 14             	mov    %eax,0x14(%ebp)
  80143c:	8b 45 14             	mov    0x14(%ebp),%eax
  80143f:	83 e8 04             	sub    $0x4,%eax
  801442:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801444:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801447:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80144e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801455:	eb 1f                	jmp    801476 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801457:	83 ec 08             	sub    $0x8,%esp
  80145a:	ff 75 e8             	pushl  -0x18(%ebp)
  80145d:	8d 45 14             	lea    0x14(%ebp),%eax
  801460:	50                   	push   %eax
  801461:	e8 e7 fb ff ff       	call   80104d <getuint>
  801466:	83 c4 10             	add    $0x10,%esp
  801469:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80146c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80146f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801476:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80147a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80147d:	83 ec 04             	sub    $0x4,%esp
  801480:	52                   	push   %edx
  801481:	ff 75 e4             	pushl  -0x1c(%ebp)
  801484:	50                   	push   %eax
  801485:	ff 75 f4             	pushl  -0xc(%ebp)
  801488:	ff 75 f0             	pushl  -0x10(%ebp)
  80148b:	ff 75 0c             	pushl  0xc(%ebp)
  80148e:	ff 75 08             	pushl  0x8(%ebp)
  801491:	e8 00 fb ff ff       	call   800f96 <printnum>
  801496:	83 c4 20             	add    $0x20,%esp
			break;
  801499:	eb 34                	jmp    8014cf <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80149b:	83 ec 08             	sub    $0x8,%esp
  80149e:	ff 75 0c             	pushl  0xc(%ebp)
  8014a1:	53                   	push   %ebx
  8014a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a5:	ff d0                	call   *%eax
  8014a7:	83 c4 10             	add    $0x10,%esp
			break;
  8014aa:	eb 23                	jmp    8014cf <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8014ac:	83 ec 08             	sub    $0x8,%esp
  8014af:	ff 75 0c             	pushl  0xc(%ebp)
  8014b2:	6a 25                	push   $0x25
  8014b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b7:	ff d0                	call   *%eax
  8014b9:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8014bc:	ff 4d 10             	decl   0x10(%ebp)
  8014bf:	eb 03                	jmp    8014c4 <vprintfmt+0x3b1>
  8014c1:	ff 4d 10             	decl   0x10(%ebp)
  8014c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c7:	48                   	dec    %eax
  8014c8:	8a 00                	mov    (%eax),%al
  8014ca:	3c 25                	cmp    $0x25,%al
  8014cc:	75 f3                	jne    8014c1 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8014ce:	90                   	nop
		}
	}
  8014cf:	e9 47 fc ff ff       	jmp    80111b <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8014d4:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8014d5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8014d8:	5b                   	pop    %ebx
  8014d9:	5e                   	pop    %esi
  8014da:	5d                   	pop    %ebp
  8014db:	c3                   	ret    

008014dc <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8014dc:	55                   	push   %ebp
  8014dd:	89 e5                	mov    %esp,%ebp
  8014df:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8014e2:	8d 45 10             	lea    0x10(%ebp),%eax
  8014e5:	83 c0 04             	add    $0x4,%eax
  8014e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8014eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ee:	ff 75 f4             	pushl  -0xc(%ebp)
  8014f1:	50                   	push   %eax
  8014f2:	ff 75 0c             	pushl  0xc(%ebp)
  8014f5:	ff 75 08             	pushl  0x8(%ebp)
  8014f8:	e8 16 fc ff ff       	call   801113 <vprintfmt>
  8014fd:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801500:	90                   	nop
  801501:	c9                   	leave  
  801502:	c3                   	ret    

00801503 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801503:	55                   	push   %ebp
  801504:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801506:	8b 45 0c             	mov    0xc(%ebp),%eax
  801509:	8b 40 08             	mov    0x8(%eax),%eax
  80150c:	8d 50 01             	lea    0x1(%eax),%edx
  80150f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801512:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801515:	8b 45 0c             	mov    0xc(%ebp),%eax
  801518:	8b 10                	mov    (%eax),%edx
  80151a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80151d:	8b 40 04             	mov    0x4(%eax),%eax
  801520:	39 c2                	cmp    %eax,%edx
  801522:	73 12                	jae    801536 <sprintputch+0x33>
		*b->buf++ = ch;
  801524:	8b 45 0c             	mov    0xc(%ebp),%eax
  801527:	8b 00                	mov    (%eax),%eax
  801529:	8d 48 01             	lea    0x1(%eax),%ecx
  80152c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80152f:	89 0a                	mov    %ecx,(%edx)
  801531:	8b 55 08             	mov    0x8(%ebp),%edx
  801534:	88 10                	mov    %dl,(%eax)
}
  801536:	90                   	nop
  801537:	5d                   	pop    %ebp
  801538:	c3                   	ret    

00801539 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801539:	55                   	push   %ebp
  80153a:	89 e5                	mov    %esp,%ebp
  80153c:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80153f:	8b 45 08             	mov    0x8(%ebp),%eax
  801542:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801545:	8b 45 0c             	mov    0xc(%ebp),%eax
  801548:	8d 50 ff             	lea    -0x1(%eax),%edx
  80154b:	8b 45 08             	mov    0x8(%ebp),%eax
  80154e:	01 d0                	add    %edx,%eax
  801550:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801553:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80155a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80155e:	74 06                	je     801566 <vsnprintf+0x2d>
  801560:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801564:	7f 07                	jg     80156d <vsnprintf+0x34>
		return -E_INVAL;
  801566:	b8 03 00 00 00       	mov    $0x3,%eax
  80156b:	eb 20                	jmp    80158d <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80156d:	ff 75 14             	pushl  0x14(%ebp)
  801570:	ff 75 10             	pushl  0x10(%ebp)
  801573:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801576:	50                   	push   %eax
  801577:	68 03 15 80 00       	push   $0x801503
  80157c:	e8 92 fb ff ff       	call   801113 <vprintfmt>
  801581:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801584:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801587:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80158a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80158d:	c9                   	leave  
  80158e:	c3                   	ret    

0080158f <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80158f:	55                   	push   %ebp
  801590:	89 e5                	mov    %esp,%ebp
  801592:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801595:	8d 45 10             	lea    0x10(%ebp),%eax
  801598:	83 c0 04             	add    $0x4,%eax
  80159b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80159e:	8b 45 10             	mov    0x10(%ebp),%eax
  8015a1:	ff 75 f4             	pushl  -0xc(%ebp)
  8015a4:	50                   	push   %eax
  8015a5:	ff 75 0c             	pushl  0xc(%ebp)
  8015a8:	ff 75 08             	pushl  0x8(%ebp)
  8015ab:	e8 89 ff ff ff       	call   801539 <vsnprintf>
  8015b0:	83 c4 10             	add    $0x10,%esp
  8015b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8015b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8015b9:	c9                   	leave  
  8015ba:	c3                   	ret    

008015bb <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8015bb:	55                   	push   %ebp
  8015bc:	89 e5                	mov    %esp,%ebp
  8015be:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8015c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015c8:	eb 06                	jmp    8015d0 <strlen+0x15>
		n++;
  8015ca:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8015cd:	ff 45 08             	incl   0x8(%ebp)
  8015d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d3:	8a 00                	mov    (%eax),%al
  8015d5:	84 c0                	test   %al,%al
  8015d7:	75 f1                	jne    8015ca <strlen+0xf>
		n++;
	return n;
  8015d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8015dc:	c9                   	leave  
  8015dd:	c3                   	ret    

008015de <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8015de:	55                   	push   %ebp
  8015df:	89 e5                	mov    %esp,%ebp
  8015e1:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8015e4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015eb:	eb 09                	jmp    8015f6 <strnlen+0x18>
		n++;
  8015ed:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8015f0:	ff 45 08             	incl   0x8(%ebp)
  8015f3:	ff 4d 0c             	decl   0xc(%ebp)
  8015f6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8015fa:	74 09                	je     801605 <strnlen+0x27>
  8015fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ff:	8a 00                	mov    (%eax),%al
  801601:	84 c0                	test   %al,%al
  801603:	75 e8                	jne    8015ed <strnlen+0xf>
		n++;
	return n;
  801605:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801608:	c9                   	leave  
  801609:	c3                   	ret    

0080160a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80160a:	55                   	push   %ebp
  80160b:	89 e5                	mov    %esp,%ebp
  80160d:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801610:	8b 45 08             	mov    0x8(%ebp),%eax
  801613:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801616:	90                   	nop
  801617:	8b 45 08             	mov    0x8(%ebp),%eax
  80161a:	8d 50 01             	lea    0x1(%eax),%edx
  80161d:	89 55 08             	mov    %edx,0x8(%ebp)
  801620:	8b 55 0c             	mov    0xc(%ebp),%edx
  801623:	8d 4a 01             	lea    0x1(%edx),%ecx
  801626:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801629:	8a 12                	mov    (%edx),%dl
  80162b:	88 10                	mov    %dl,(%eax)
  80162d:	8a 00                	mov    (%eax),%al
  80162f:	84 c0                	test   %al,%al
  801631:	75 e4                	jne    801617 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801633:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801636:	c9                   	leave  
  801637:	c3                   	ret    

00801638 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801638:	55                   	push   %ebp
  801639:	89 e5                	mov    %esp,%ebp
  80163b:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80163e:	8b 45 08             	mov    0x8(%ebp),%eax
  801641:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801644:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80164b:	eb 1f                	jmp    80166c <strncpy+0x34>
		*dst++ = *src;
  80164d:	8b 45 08             	mov    0x8(%ebp),%eax
  801650:	8d 50 01             	lea    0x1(%eax),%edx
  801653:	89 55 08             	mov    %edx,0x8(%ebp)
  801656:	8b 55 0c             	mov    0xc(%ebp),%edx
  801659:	8a 12                	mov    (%edx),%dl
  80165b:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80165d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801660:	8a 00                	mov    (%eax),%al
  801662:	84 c0                	test   %al,%al
  801664:	74 03                	je     801669 <strncpy+0x31>
			src++;
  801666:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801669:	ff 45 fc             	incl   -0x4(%ebp)
  80166c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80166f:	3b 45 10             	cmp    0x10(%ebp),%eax
  801672:	72 d9                	jb     80164d <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801674:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801677:	c9                   	leave  
  801678:	c3                   	ret    

00801679 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801679:	55                   	push   %ebp
  80167a:	89 e5                	mov    %esp,%ebp
  80167c:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80167f:	8b 45 08             	mov    0x8(%ebp),%eax
  801682:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801685:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801689:	74 30                	je     8016bb <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80168b:	eb 16                	jmp    8016a3 <strlcpy+0x2a>
			*dst++ = *src++;
  80168d:	8b 45 08             	mov    0x8(%ebp),%eax
  801690:	8d 50 01             	lea    0x1(%eax),%edx
  801693:	89 55 08             	mov    %edx,0x8(%ebp)
  801696:	8b 55 0c             	mov    0xc(%ebp),%edx
  801699:	8d 4a 01             	lea    0x1(%edx),%ecx
  80169c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80169f:	8a 12                	mov    (%edx),%dl
  8016a1:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8016a3:	ff 4d 10             	decl   0x10(%ebp)
  8016a6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016aa:	74 09                	je     8016b5 <strlcpy+0x3c>
  8016ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016af:	8a 00                	mov    (%eax),%al
  8016b1:	84 c0                	test   %al,%al
  8016b3:	75 d8                	jne    80168d <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8016b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b8:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8016bb:	8b 55 08             	mov    0x8(%ebp),%edx
  8016be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016c1:	29 c2                	sub    %eax,%edx
  8016c3:	89 d0                	mov    %edx,%eax
}
  8016c5:	c9                   	leave  
  8016c6:	c3                   	ret    

008016c7 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8016c7:	55                   	push   %ebp
  8016c8:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8016ca:	eb 06                	jmp    8016d2 <strcmp+0xb>
		p++, q++;
  8016cc:	ff 45 08             	incl   0x8(%ebp)
  8016cf:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8016d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d5:	8a 00                	mov    (%eax),%al
  8016d7:	84 c0                	test   %al,%al
  8016d9:	74 0e                	je     8016e9 <strcmp+0x22>
  8016db:	8b 45 08             	mov    0x8(%ebp),%eax
  8016de:	8a 10                	mov    (%eax),%dl
  8016e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016e3:	8a 00                	mov    (%eax),%al
  8016e5:	38 c2                	cmp    %al,%dl
  8016e7:	74 e3                	je     8016cc <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8016e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ec:	8a 00                	mov    (%eax),%al
  8016ee:	0f b6 d0             	movzbl %al,%edx
  8016f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016f4:	8a 00                	mov    (%eax),%al
  8016f6:	0f b6 c0             	movzbl %al,%eax
  8016f9:	29 c2                	sub    %eax,%edx
  8016fb:	89 d0                	mov    %edx,%eax
}
  8016fd:	5d                   	pop    %ebp
  8016fe:	c3                   	ret    

008016ff <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8016ff:	55                   	push   %ebp
  801700:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801702:	eb 09                	jmp    80170d <strncmp+0xe>
		n--, p++, q++;
  801704:	ff 4d 10             	decl   0x10(%ebp)
  801707:	ff 45 08             	incl   0x8(%ebp)
  80170a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80170d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801711:	74 17                	je     80172a <strncmp+0x2b>
  801713:	8b 45 08             	mov    0x8(%ebp),%eax
  801716:	8a 00                	mov    (%eax),%al
  801718:	84 c0                	test   %al,%al
  80171a:	74 0e                	je     80172a <strncmp+0x2b>
  80171c:	8b 45 08             	mov    0x8(%ebp),%eax
  80171f:	8a 10                	mov    (%eax),%dl
  801721:	8b 45 0c             	mov    0xc(%ebp),%eax
  801724:	8a 00                	mov    (%eax),%al
  801726:	38 c2                	cmp    %al,%dl
  801728:	74 da                	je     801704 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80172a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80172e:	75 07                	jne    801737 <strncmp+0x38>
		return 0;
  801730:	b8 00 00 00 00       	mov    $0x0,%eax
  801735:	eb 14                	jmp    80174b <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801737:	8b 45 08             	mov    0x8(%ebp),%eax
  80173a:	8a 00                	mov    (%eax),%al
  80173c:	0f b6 d0             	movzbl %al,%edx
  80173f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801742:	8a 00                	mov    (%eax),%al
  801744:	0f b6 c0             	movzbl %al,%eax
  801747:	29 c2                	sub    %eax,%edx
  801749:	89 d0                	mov    %edx,%eax
}
  80174b:	5d                   	pop    %ebp
  80174c:	c3                   	ret    

0080174d <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80174d:	55                   	push   %ebp
  80174e:	89 e5                	mov    %esp,%ebp
  801750:	83 ec 04             	sub    $0x4,%esp
  801753:	8b 45 0c             	mov    0xc(%ebp),%eax
  801756:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801759:	eb 12                	jmp    80176d <strchr+0x20>
		if (*s == c)
  80175b:	8b 45 08             	mov    0x8(%ebp),%eax
  80175e:	8a 00                	mov    (%eax),%al
  801760:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801763:	75 05                	jne    80176a <strchr+0x1d>
			return (char *) s;
  801765:	8b 45 08             	mov    0x8(%ebp),%eax
  801768:	eb 11                	jmp    80177b <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80176a:	ff 45 08             	incl   0x8(%ebp)
  80176d:	8b 45 08             	mov    0x8(%ebp),%eax
  801770:	8a 00                	mov    (%eax),%al
  801772:	84 c0                	test   %al,%al
  801774:	75 e5                	jne    80175b <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801776:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80177b:	c9                   	leave  
  80177c:	c3                   	ret    

0080177d <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80177d:	55                   	push   %ebp
  80177e:	89 e5                	mov    %esp,%ebp
  801780:	83 ec 04             	sub    $0x4,%esp
  801783:	8b 45 0c             	mov    0xc(%ebp),%eax
  801786:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801789:	eb 0d                	jmp    801798 <strfind+0x1b>
		if (*s == c)
  80178b:	8b 45 08             	mov    0x8(%ebp),%eax
  80178e:	8a 00                	mov    (%eax),%al
  801790:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801793:	74 0e                	je     8017a3 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801795:	ff 45 08             	incl   0x8(%ebp)
  801798:	8b 45 08             	mov    0x8(%ebp),%eax
  80179b:	8a 00                	mov    (%eax),%al
  80179d:	84 c0                	test   %al,%al
  80179f:	75 ea                	jne    80178b <strfind+0xe>
  8017a1:	eb 01                	jmp    8017a4 <strfind+0x27>
		if (*s == c)
			break;
  8017a3:	90                   	nop
	return (char *) s;
  8017a4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8017a7:	c9                   	leave  
  8017a8:	c3                   	ret    

008017a9 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8017a9:	55                   	push   %ebp
  8017aa:	89 e5                	mov    %esp,%ebp
  8017ac:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8017af:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8017b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8017b8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8017bb:	eb 0e                	jmp    8017cb <memset+0x22>
		*p++ = c;
  8017bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017c0:	8d 50 01             	lea    0x1(%eax),%edx
  8017c3:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8017c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017c9:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8017cb:	ff 4d f8             	decl   -0x8(%ebp)
  8017ce:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8017d2:	79 e9                	jns    8017bd <memset+0x14>
		*p++ = c;

	return v;
  8017d4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8017d7:	c9                   	leave  
  8017d8:	c3                   	ret    

008017d9 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8017d9:	55                   	push   %ebp
  8017da:	89 e5                	mov    %esp,%ebp
  8017dc:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8017df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8017e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8017eb:	eb 16                	jmp    801803 <memcpy+0x2a>
		*d++ = *s++;
  8017ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017f0:	8d 50 01             	lea    0x1(%eax),%edx
  8017f3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017f6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8017f9:	8d 4a 01             	lea    0x1(%edx),%ecx
  8017fc:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8017ff:	8a 12                	mov    (%edx),%dl
  801801:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801803:	8b 45 10             	mov    0x10(%ebp),%eax
  801806:	8d 50 ff             	lea    -0x1(%eax),%edx
  801809:	89 55 10             	mov    %edx,0x10(%ebp)
  80180c:	85 c0                	test   %eax,%eax
  80180e:	75 dd                	jne    8017ed <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801810:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801813:	c9                   	leave  
  801814:	c3                   	ret    

00801815 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801815:	55                   	push   %ebp
  801816:	89 e5                	mov    %esp,%ebp
  801818:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80181b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80181e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801821:	8b 45 08             	mov    0x8(%ebp),%eax
  801824:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801827:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80182a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80182d:	73 50                	jae    80187f <memmove+0x6a>
  80182f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801832:	8b 45 10             	mov    0x10(%ebp),%eax
  801835:	01 d0                	add    %edx,%eax
  801837:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80183a:	76 43                	jbe    80187f <memmove+0x6a>
		s += n;
  80183c:	8b 45 10             	mov    0x10(%ebp),%eax
  80183f:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801842:	8b 45 10             	mov    0x10(%ebp),%eax
  801845:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801848:	eb 10                	jmp    80185a <memmove+0x45>
			*--d = *--s;
  80184a:	ff 4d f8             	decl   -0x8(%ebp)
  80184d:	ff 4d fc             	decl   -0x4(%ebp)
  801850:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801853:	8a 10                	mov    (%eax),%dl
  801855:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801858:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80185a:	8b 45 10             	mov    0x10(%ebp),%eax
  80185d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801860:	89 55 10             	mov    %edx,0x10(%ebp)
  801863:	85 c0                	test   %eax,%eax
  801865:	75 e3                	jne    80184a <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801867:	eb 23                	jmp    80188c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801869:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80186c:	8d 50 01             	lea    0x1(%eax),%edx
  80186f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801872:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801875:	8d 4a 01             	lea    0x1(%edx),%ecx
  801878:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80187b:	8a 12                	mov    (%edx),%dl
  80187d:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80187f:	8b 45 10             	mov    0x10(%ebp),%eax
  801882:	8d 50 ff             	lea    -0x1(%eax),%edx
  801885:	89 55 10             	mov    %edx,0x10(%ebp)
  801888:	85 c0                	test   %eax,%eax
  80188a:	75 dd                	jne    801869 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80188c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80188f:	c9                   	leave  
  801890:	c3                   	ret    

00801891 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801891:	55                   	push   %ebp
  801892:	89 e5                	mov    %esp,%ebp
  801894:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801897:	8b 45 08             	mov    0x8(%ebp),%eax
  80189a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80189d:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a0:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8018a3:	eb 2a                	jmp    8018cf <memcmp+0x3e>
		if (*s1 != *s2)
  8018a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018a8:	8a 10                	mov    (%eax),%dl
  8018aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018ad:	8a 00                	mov    (%eax),%al
  8018af:	38 c2                	cmp    %al,%dl
  8018b1:	74 16                	je     8018c9 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8018b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018b6:	8a 00                	mov    (%eax),%al
  8018b8:	0f b6 d0             	movzbl %al,%edx
  8018bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018be:	8a 00                	mov    (%eax),%al
  8018c0:	0f b6 c0             	movzbl %al,%eax
  8018c3:	29 c2                	sub    %eax,%edx
  8018c5:	89 d0                	mov    %edx,%eax
  8018c7:	eb 18                	jmp    8018e1 <memcmp+0x50>
		s1++, s2++;
  8018c9:	ff 45 fc             	incl   -0x4(%ebp)
  8018cc:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8018cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8018d2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8018d5:	89 55 10             	mov    %edx,0x10(%ebp)
  8018d8:	85 c0                	test   %eax,%eax
  8018da:	75 c9                	jne    8018a5 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8018dc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8018e1:	c9                   	leave  
  8018e2:	c3                   	ret    

008018e3 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8018e3:	55                   	push   %ebp
  8018e4:	89 e5                	mov    %esp,%ebp
  8018e6:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8018e9:	8b 55 08             	mov    0x8(%ebp),%edx
  8018ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ef:	01 d0                	add    %edx,%eax
  8018f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8018f4:	eb 15                	jmp    80190b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8018f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f9:	8a 00                	mov    (%eax),%al
  8018fb:	0f b6 d0             	movzbl %al,%edx
  8018fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801901:	0f b6 c0             	movzbl %al,%eax
  801904:	39 c2                	cmp    %eax,%edx
  801906:	74 0d                	je     801915 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801908:	ff 45 08             	incl   0x8(%ebp)
  80190b:	8b 45 08             	mov    0x8(%ebp),%eax
  80190e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801911:	72 e3                	jb     8018f6 <memfind+0x13>
  801913:	eb 01                	jmp    801916 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801915:	90                   	nop
	return (void *) s;
  801916:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801919:	c9                   	leave  
  80191a:	c3                   	ret    

0080191b <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80191b:	55                   	push   %ebp
  80191c:	89 e5                	mov    %esp,%ebp
  80191e:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801921:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801928:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80192f:	eb 03                	jmp    801934 <strtol+0x19>
		s++;
  801931:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801934:	8b 45 08             	mov    0x8(%ebp),%eax
  801937:	8a 00                	mov    (%eax),%al
  801939:	3c 20                	cmp    $0x20,%al
  80193b:	74 f4                	je     801931 <strtol+0x16>
  80193d:	8b 45 08             	mov    0x8(%ebp),%eax
  801940:	8a 00                	mov    (%eax),%al
  801942:	3c 09                	cmp    $0x9,%al
  801944:	74 eb                	je     801931 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801946:	8b 45 08             	mov    0x8(%ebp),%eax
  801949:	8a 00                	mov    (%eax),%al
  80194b:	3c 2b                	cmp    $0x2b,%al
  80194d:	75 05                	jne    801954 <strtol+0x39>
		s++;
  80194f:	ff 45 08             	incl   0x8(%ebp)
  801952:	eb 13                	jmp    801967 <strtol+0x4c>
	else if (*s == '-')
  801954:	8b 45 08             	mov    0x8(%ebp),%eax
  801957:	8a 00                	mov    (%eax),%al
  801959:	3c 2d                	cmp    $0x2d,%al
  80195b:	75 0a                	jne    801967 <strtol+0x4c>
		s++, neg = 1;
  80195d:	ff 45 08             	incl   0x8(%ebp)
  801960:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801967:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80196b:	74 06                	je     801973 <strtol+0x58>
  80196d:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801971:	75 20                	jne    801993 <strtol+0x78>
  801973:	8b 45 08             	mov    0x8(%ebp),%eax
  801976:	8a 00                	mov    (%eax),%al
  801978:	3c 30                	cmp    $0x30,%al
  80197a:	75 17                	jne    801993 <strtol+0x78>
  80197c:	8b 45 08             	mov    0x8(%ebp),%eax
  80197f:	40                   	inc    %eax
  801980:	8a 00                	mov    (%eax),%al
  801982:	3c 78                	cmp    $0x78,%al
  801984:	75 0d                	jne    801993 <strtol+0x78>
		s += 2, base = 16;
  801986:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80198a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801991:	eb 28                	jmp    8019bb <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801993:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801997:	75 15                	jne    8019ae <strtol+0x93>
  801999:	8b 45 08             	mov    0x8(%ebp),%eax
  80199c:	8a 00                	mov    (%eax),%al
  80199e:	3c 30                	cmp    $0x30,%al
  8019a0:	75 0c                	jne    8019ae <strtol+0x93>
		s++, base = 8;
  8019a2:	ff 45 08             	incl   0x8(%ebp)
  8019a5:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8019ac:	eb 0d                	jmp    8019bb <strtol+0xa0>
	else if (base == 0)
  8019ae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8019b2:	75 07                	jne    8019bb <strtol+0xa0>
		base = 10;
  8019b4:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8019bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019be:	8a 00                	mov    (%eax),%al
  8019c0:	3c 2f                	cmp    $0x2f,%al
  8019c2:	7e 19                	jle    8019dd <strtol+0xc2>
  8019c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c7:	8a 00                	mov    (%eax),%al
  8019c9:	3c 39                	cmp    $0x39,%al
  8019cb:	7f 10                	jg     8019dd <strtol+0xc2>
			dig = *s - '0';
  8019cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d0:	8a 00                	mov    (%eax),%al
  8019d2:	0f be c0             	movsbl %al,%eax
  8019d5:	83 e8 30             	sub    $0x30,%eax
  8019d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8019db:	eb 42                	jmp    801a1f <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8019dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e0:	8a 00                	mov    (%eax),%al
  8019e2:	3c 60                	cmp    $0x60,%al
  8019e4:	7e 19                	jle    8019ff <strtol+0xe4>
  8019e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e9:	8a 00                	mov    (%eax),%al
  8019eb:	3c 7a                	cmp    $0x7a,%al
  8019ed:	7f 10                	jg     8019ff <strtol+0xe4>
			dig = *s - 'a' + 10;
  8019ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f2:	8a 00                	mov    (%eax),%al
  8019f4:	0f be c0             	movsbl %al,%eax
  8019f7:	83 e8 57             	sub    $0x57,%eax
  8019fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8019fd:	eb 20                	jmp    801a1f <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8019ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801a02:	8a 00                	mov    (%eax),%al
  801a04:	3c 40                	cmp    $0x40,%al
  801a06:	7e 39                	jle    801a41 <strtol+0x126>
  801a08:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0b:	8a 00                	mov    (%eax),%al
  801a0d:	3c 5a                	cmp    $0x5a,%al
  801a0f:	7f 30                	jg     801a41 <strtol+0x126>
			dig = *s - 'A' + 10;
  801a11:	8b 45 08             	mov    0x8(%ebp),%eax
  801a14:	8a 00                	mov    (%eax),%al
  801a16:	0f be c0             	movsbl %al,%eax
  801a19:	83 e8 37             	sub    $0x37,%eax
  801a1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801a1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a22:	3b 45 10             	cmp    0x10(%ebp),%eax
  801a25:	7d 19                	jge    801a40 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801a27:	ff 45 08             	incl   0x8(%ebp)
  801a2a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a2d:	0f af 45 10          	imul   0x10(%ebp),%eax
  801a31:	89 c2                	mov    %eax,%edx
  801a33:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a36:	01 d0                	add    %edx,%eax
  801a38:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801a3b:	e9 7b ff ff ff       	jmp    8019bb <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801a40:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801a41:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801a45:	74 08                	je     801a4f <strtol+0x134>
		*endptr = (char *) s;
  801a47:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a4a:	8b 55 08             	mov    0x8(%ebp),%edx
  801a4d:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801a4f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801a53:	74 07                	je     801a5c <strtol+0x141>
  801a55:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a58:	f7 d8                	neg    %eax
  801a5a:	eb 03                	jmp    801a5f <strtol+0x144>
  801a5c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801a5f:	c9                   	leave  
  801a60:	c3                   	ret    

00801a61 <ltostr>:

void
ltostr(long value, char *str)
{
  801a61:	55                   	push   %ebp
  801a62:	89 e5                	mov    %esp,%ebp
  801a64:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801a67:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801a6e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801a75:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801a79:	79 13                	jns    801a8e <ltostr+0x2d>
	{
		neg = 1;
  801a7b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801a82:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a85:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801a88:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801a8b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801a8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a91:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801a96:	99                   	cltd   
  801a97:	f7 f9                	idiv   %ecx
  801a99:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801a9c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a9f:	8d 50 01             	lea    0x1(%eax),%edx
  801aa2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801aa5:	89 c2                	mov    %eax,%edx
  801aa7:	8b 45 0c             	mov    0xc(%ebp),%eax
  801aaa:	01 d0                	add    %edx,%eax
  801aac:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801aaf:	83 c2 30             	add    $0x30,%edx
  801ab2:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801ab4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801ab7:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801abc:	f7 e9                	imul   %ecx
  801abe:	c1 fa 02             	sar    $0x2,%edx
  801ac1:	89 c8                	mov    %ecx,%eax
  801ac3:	c1 f8 1f             	sar    $0x1f,%eax
  801ac6:	29 c2                	sub    %eax,%edx
  801ac8:	89 d0                	mov    %edx,%eax
  801aca:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801acd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801ad0:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801ad5:	f7 e9                	imul   %ecx
  801ad7:	c1 fa 02             	sar    $0x2,%edx
  801ada:	89 c8                	mov    %ecx,%eax
  801adc:	c1 f8 1f             	sar    $0x1f,%eax
  801adf:	29 c2                	sub    %eax,%edx
  801ae1:	89 d0                	mov    %edx,%eax
  801ae3:	c1 e0 02             	shl    $0x2,%eax
  801ae6:	01 d0                	add    %edx,%eax
  801ae8:	01 c0                	add    %eax,%eax
  801aea:	29 c1                	sub    %eax,%ecx
  801aec:	89 ca                	mov    %ecx,%edx
  801aee:	85 d2                	test   %edx,%edx
  801af0:	75 9c                	jne    801a8e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801af2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801af9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801afc:	48                   	dec    %eax
  801afd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801b00:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801b04:	74 3d                	je     801b43 <ltostr+0xe2>
		start = 1 ;
  801b06:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801b0d:	eb 34                	jmp    801b43 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801b0f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b12:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b15:	01 d0                	add    %edx,%eax
  801b17:	8a 00                	mov    (%eax),%al
  801b19:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801b1c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b22:	01 c2                	add    %eax,%edx
  801b24:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801b27:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b2a:	01 c8                	add    %ecx,%eax
  801b2c:	8a 00                	mov    (%eax),%al
  801b2e:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801b30:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801b33:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b36:	01 c2                	add    %eax,%edx
  801b38:	8a 45 eb             	mov    -0x15(%ebp),%al
  801b3b:	88 02                	mov    %al,(%edx)
		start++ ;
  801b3d:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801b40:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801b43:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b46:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801b49:	7c c4                	jl     801b0f <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801b4b:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801b4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b51:	01 d0                	add    %edx,%eax
  801b53:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801b56:	90                   	nop
  801b57:	c9                   	leave  
  801b58:	c3                   	ret    

00801b59 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801b59:	55                   	push   %ebp
  801b5a:	89 e5                	mov    %esp,%ebp
  801b5c:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801b5f:	ff 75 08             	pushl  0x8(%ebp)
  801b62:	e8 54 fa ff ff       	call   8015bb <strlen>
  801b67:	83 c4 04             	add    $0x4,%esp
  801b6a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801b6d:	ff 75 0c             	pushl  0xc(%ebp)
  801b70:	e8 46 fa ff ff       	call   8015bb <strlen>
  801b75:	83 c4 04             	add    $0x4,%esp
  801b78:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801b7b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801b82:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801b89:	eb 17                	jmp    801ba2 <strcconcat+0x49>
		final[s] = str1[s] ;
  801b8b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b8e:	8b 45 10             	mov    0x10(%ebp),%eax
  801b91:	01 c2                	add    %eax,%edx
  801b93:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801b96:	8b 45 08             	mov    0x8(%ebp),%eax
  801b99:	01 c8                	add    %ecx,%eax
  801b9b:	8a 00                	mov    (%eax),%al
  801b9d:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801b9f:	ff 45 fc             	incl   -0x4(%ebp)
  801ba2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ba5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801ba8:	7c e1                	jl     801b8b <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801baa:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801bb1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801bb8:	eb 1f                	jmp    801bd9 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801bba:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801bbd:	8d 50 01             	lea    0x1(%eax),%edx
  801bc0:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801bc3:	89 c2                	mov    %eax,%edx
  801bc5:	8b 45 10             	mov    0x10(%ebp),%eax
  801bc8:	01 c2                	add    %eax,%edx
  801bca:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801bcd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bd0:	01 c8                	add    %ecx,%eax
  801bd2:	8a 00                	mov    (%eax),%al
  801bd4:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801bd6:	ff 45 f8             	incl   -0x8(%ebp)
  801bd9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801bdc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801bdf:	7c d9                	jl     801bba <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801be1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801be4:	8b 45 10             	mov    0x10(%ebp),%eax
  801be7:	01 d0                	add    %edx,%eax
  801be9:	c6 00 00             	movb   $0x0,(%eax)
}
  801bec:	90                   	nop
  801bed:	c9                   	leave  
  801bee:	c3                   	ret    

00801bef <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801bef:	55                   	push   %ebp
  801bf0:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801bf2:	8b 45 14             	mov    0x14(%ebp),%eax
  801bf5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801bfb:	8b 45 14             	mov    0x14(%ebp),%eax
  801bfe:	8b 00                	mov    (%eax),%eax
  801c00:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c07:	8b 45 10             	mov    0x10(%ebp),%eax
  801c0a:	01 d0                	add    %edx,%eax
  801c0c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801c12:	eb 0c                	jmp    801c20 <strsplit+0x31>
			*string++ = 0;
  801c14:	8b 45 08             	mov    0x8(%ebp),%eax
  801c17:	8d 50 01             	lea    0x1(%eax),%edx
  801c1a:	89 55 08             	mov    %edx,0x8(%ebp)
  801c1d:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801c20:	8b 45 08             	mov    0x8(%ebp),%eax
  801c23:	8a 00                	mov    (%eax),%al
  801c25:	84 c0                	test   %al,%al
  801c27:	74 18                	je     801c41 <strsplit+0x52>
  801c29:	8b 45 08             	mov    0x8(%ebp),%eax
  801c2c:	8a 00                	mov    (%eax),%al
  801c2e:	0f be c0             	movsbl %al,%eax
  801c31:	50                   	push   %eax
  801c32:	ff 75 0c             	pushl  0xc(%ebp)
  801c35:	e8 13 fb ff ff       	call   80174d <strchr>
  801c3a:	83 c4 08             	add    $0x8,%esp
  801c3d:	85 c0                	test   %eax,%eax
  801c3f:	75 d3                	jne    801c14 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801c41:	8b 45 08             	mov    0x8(%ebp),%eax
  801c44:	8a 00                	mov    (%eax),%al
  801c46:	84 c0                	test   %al,%al
  801c48:	74 5a                	je     801ca4 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801c4a:	8b 45 14             	mov    0x14(%ebp),%eax
  801c4d:	8b 00                	mov    (%eax),%eax
  801c4f:	83 f8 0f             	cmp    $0xf,%eax
  801c52:	75 07                	jne    801c5b <strsplit+0x6c>
		{
			return 0;
  801c54:	b8 00 00 00 00       	mov    $0x0,%eax
  801c59:	eb 66                	jmp    801cc1 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801c5b:	8b 45 14             	mov    0x14(%ebp),%eax
  801c5e:	8b 00                	mov    (%eax),%eax
  801c60:	8d 48 01             	lea    0x1(%eax),%ecx
  801c63:	8b 55 14             	mov    0x14(%ebp),%edx
  801c66:	89 0a                	mov    %ecx,(%edx)
  801c68:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c6f:	8b 45 10             	mov    0x10(%ebp),%eax
  801c72:	01 c2                	add    %eax,%edx
  801c74:	8b 45 08             	mov    0x8(%ebp),%eax
  801c77:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801c79:	eb 03                	jmp    801c7e <strsplit+0x8f>
			string++;
  801c7b:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801c7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c81:	8a 00                	mov    (%eax),%al
  801c83:	84 c0                	test   %al,%al
  801c85:	74 8b                	je     801c12 <strsplit+0x23>
  801c87:	8b 45 08             	mov    0x8(%ebp),%eax
  801c8a:	8a 00                	mov    (%eax),%al
  801c8c:	0f be c0             	movsbl %al,%eax
  801c8f:	50                   	push   %eax
  801c90:	ff 75 0c             	pushl  0xc(%ebp)
  801c93:	e8 b5 fa ff ff       	call   80174d <strchr>
  801c98:	83 c4 08             	add    $0x8,%esp
  801c9b:	85 c0                	test   %eax,%eax
  801c9d:	74 dc                	je     801c7b <strsplit+0x8c>
			string++;
	}
  801c9f:	e9 6e ff ff ff       	jmp    801c12 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801ca4:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801ca5:	8b 45 14             	mov    0x14(%ebp),%eax
  801ca8:	8b 00                	mov    (%eax),%eax
  801caa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801cb1:	8b 45 10             	mov    0x10(%ebp),%eax
  801cb4:	01 d0                	add    %edx,%eax
  801cb6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801cbc:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801cc1:	c9                   	leave  
  801cc2:	c3                   	ret    

00801cc3 <malloc>:
int changed[100000];
int numOfPages[100000];
uint32 freeArray[100000];


void* malloc(uint32 size) {
  801cc3:	55                   	push   %ebp
  801cc4:	89 e5                	mov    %esp,%ebp
  801cc6:	83 ec 38             	sub    $0x38,%esp

	if(size>USER_HEAP_MAX - USER_HEAP_START)
  801cc9:	81 7d 08 00 00 00 20 	cmpl   $0x20000000,0x8(%ebp)
  801cd0:	76 0a                	jbe    801cdc <malloc+0x19>
		return NULL;
  801cd2:	b8 00 00 00 00       	mov    $0x0,%eax
  801cd7:	e9 ad 02 00 00       	jmp    801f89 <malloc+0x2c6>
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	int num = size / PAGE_SIZE;
  801cdc:	8b 45 08             	mov    0x8(%ebp),%eax
  801cdf:	c1 e8 0c             	shr    $0xc,%eax
  801ce2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32 return_addres;
	if (size % PAGE_SIZE != 0)
  801ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce8:	25 ff 0f 00 00       	and    $0xfff,%eax
  801ced:	85 c0                	test   %eax,%eax
  801cef:	74 03                	je     801cf4 <malloc+0x31>
		num++;
  801cf1:	ff 45 f4             	incl   -0xc(%ebp)
	if (changes == 0) {
  801cf4:	a1 28 40 80 00       	mov    0x804028,%eax
  801cf9:	85 c0                	test   %eax,%eax
  801cfb:	75 71                	jne    801d6e <malloc+0xab>
		sys_allocateMem(last_addres, size);
  801cfd:	a1 04 40 80 00       	mov    0x804004,%eax
  801d02:	83 ec 08             	sub    $0x8,%esp
  801d05:	ff 75 08             	pushl  0x8(%ebp)
  801d08:	50                   	push   %eax
  801d09:	e8 ba 05 00 00       	call   8022c8 <sys_allocateMem>
  801d0e:	83 c4 10             	add    $0x10,%esp
		return_addres = last_addres;
  801d11:	a1 04 40 80 00       	mov    0x804004,%eax
  801d16:	89 45 c8             	mov    %eax,-0x38(%ebp)
		last_addres += num * PAGE_SIZE;
  801d19:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d1c:	c1 e0 0c             	shl    $0xc,%eax
  801d1f:	89 c2                	mov    %eax,%edx
  801d21:	a1 04 40 80 00       	mov    0x804004,%eax
  801d26:	01 d0                	add    %edx,%eax
  801d28:	a3 04 40 80 00       	mov    %eax,0x804004
		numOfPages[sizeofarray] = num;
  801d2d:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801d32:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801d35:	89 14 85 a0 90 92 00 	mov    %edx,0x9290a0(,%eax,4)
		addresses[sizeofarray] = return_addres;
  801d3c:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801d41:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801d44:	89 14 85 a0 5b 86 00 	mov    %edx,0x865ba0(,%eax,4)
		changed[sizeofarray] = 1;
  801d4b:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801d50:	c7 04 85 20 76 8c 00 	movl   $0x1,0x8c7620(,%eax,4)
  801d57:	01 00 00 00 
		sizeofarray++;
  801d5b:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801d60:	40                   	inc    %eax
  801d61:	a3 2c 40 80 00       	mov    %eax,0x80402c
		return (void*) return_addres;
  801d66:	8b 45 c8             	mov    -0x38(%ebp),%eax
  801d69:	e9 1b 02 00 00       	jmp    801f89 <malloc+0x2c6>
	}
	else
	{

		int count = 0;
  801d6e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int min = 4000;
  801d75:	c7 45 ec a0 0f 00 00 	movl   $0xfa0,-0x14(%ebp)
		int lastindex;
		int index = -1;
  801d7c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		uint32 min_addresss;
		int f=0;
  801d83:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		int bool=0;
  801d8a:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
			for(int i=0;i<sizeofarray;i++)
  801d91:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  801d98:	eb 72                	jmp    801e0c <malloc+0x149>
			{
				//cprintf("size of array and changed and num of pages %d %d %d  \n\n",sizeofarray,changed[i],numOfPages[i]);
				if(changed[i]==0)
  801d9a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801d9d:	8b 04 85 20 76 8c 00 	mov    0x8c7620(,%eax,4),%eax
  801da4:	85 c0                	test   %eax,%eax
  801da6:	75 12                	jne    801dba <malloc+0xf7>
				{
					/*cprintf("yes   \n\n");
					cprintf("size of changed %d\n   \n\n",numOfPages[i]*PAGE_SIZE);*/
					count+=numOfPages[i];
  801da8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801dab:	8b 04 85 a0 90 92 00 	mov    0x9290a0(,%eax,4),%eax
  801db2:	01 45 f0             	add    %eax,-0x10(%ebp)
					f++;
  801db5:	ff 45 dc             	incl   -0x24(%ebp)
  801db8:	eb 4f                	jmp    801e09 <malloc+0x146>
				}
				else
				{
					//cprintf("no   \n\n");
					if(count<min&&count>=num)
  801dba:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801dbd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801dc0:	7d 39                	jge    801dfb <malloc+0x138>
  801dc2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801dc5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801dc8:	7c 31                	jl     801dfb <malloc+0x138>
					{
						min=count;
  801dca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801dcd:	89 45 ec             	mov    %eax,-0x14(%ebp)
						min_addresss=addresses[i]-count*PAGE_SIZE;
  801dd0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801dd3:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  801dda:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801ddd:	c1 e2 0c             	shl    $0xc,%edx
  801de0:	29 d0                	sub    %edx,%eax
  801de2:	89 45 e0             	mov    %eax,-0x20(%ebp)
						index=i-f;
  801de5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801de8:	2b 45 dc             	sub    -0x24(%ebp),%eax
  801deb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
						bool=1;
  801dee:	c7 45 d8 01 00 00 00 	movl   $0x1,-0x28(%ebp)
						lastindex=i;
  801df5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  801df8:	89 45 e8             	mov    %eax,-0x18(%ebp)
						//cprintf("now address is: and count is %x %d\n",min_addresss,count);
					}
					f=0;
  801dfb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
					count=0;
  801e02:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		int lastindex;
		int index = -1;
		uint32 min_addresss;
		int f=0;
		int bool=0;
			for(int i=0;i<sizeofarray;i++)
  801e09:	ff 45 d4             	incl   -0x2c(%ebp)
  801e0c:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801e11:	39 45 d4             	cmp    %eax,-0x2c(%ebp)
  801e14:	7c 84                	jl     801d9a <malloc+0xd7>
					}
					f=0;
					count=0;
				}
			}
			if(bool==1)
  801e16:	83 7d d8 01          	cmpl   $0x1,-0x28(%ebp)
  801e1a:	0f 85 e3 00 00 00    	jne    801f03 <malloc+0x240>
			{

				sys_allocateMem(min_addresss, size);
  801e20:	83 ec 08             	sub    $0x8,%esp
  801e23:	ff 75 08             	pushl  0x8(%ebp)
  801e26:	ff 75 e0             	pushl  -0x20(%ebp)
  801e29:	e8 9a 04 00 00       	call   8022c8 <sys_allocateMem>
  801e2e:	83 c4 10             	add    $0x10,%esp
				sizeofarray++;
  801e31:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801e36:	40                   	inc    %eax
  801e37:	a3 2c 40 80 00       	mov    %eax,0x80402c
				for(int i=sizeofarray-1;i>index;i--)
  801e3c:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801e41:	48                   	dec    %eax
  801e42:	89 45 d0             	mov    %eax,-0x30(%ebp)
  801e45:	eb 42                	jmp    801e89 <malloc+0x1c6>
				{
					addresses[i]=addresses[i-1];
  801e47:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801e4a:	48                   	dec    %eax
  801e4b:	8b 14 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%edx
  801e52:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801e55:	89 14 85 a0 5b 86 00 	mov    %edx,0x865ba0(,%eax,4)
					numOfPages[i]=numOfPages[i-1];
  801e5c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801e5f:	48                   	dec    %eax
  801e60:	8b 14 85 a0 90 92 00 	mov    0x9290a0(,%eax,4),%edx
  801e67:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801e6a:	89 14 85 a0 90 92 00 	mov    %edx,0x9290a0(,%eax,4)
					changed[i]=changed[i-1];
  801e71:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801e74:	48                   	dec    %eax
  801e75:	8b 14 85 20 76 8c 00 	mov    0x8c7620(,%eax,4),%edx
  801e7c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801e7f:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
			if(bool==1)
			{

				sys_allocateMem(min_addresss, size);
				sizeofarray++;
				for(int i=sizeofarray-1;i>index;i--)
  801e86:	ff 4d d0             	decl   -0x30(%ebp)
  801e89:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801e8c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801e8f:	7f b6                	jg     801e47 <malloc+0x184>
				{
					addresses[i]=addresses[i-1];
					numOfPages[i]=numOfPages[i-1];
					changed[i]=changed[i-1];
				}
				addresses[index+1]=min_addresss+size;
  801e91:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801e94:	40                   	inc    %eax
  801e95:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  801e98:	8b 55 08             	mov    0x8(%ebp),%edx
  801e9b:	01 ca                	add    %ecx,%edx
  801e9d:	89 14 85 a0 5b 86 00 	mov    %edx,0x865ba0(,%eax,4)
				numOfPages[index+1]=numOfPages[index]-num;
  801ea4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801ea7:	8d 50 01             	lea    0x1(%eax),%edx
  801eaa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801ead:	8b 04 85 a0 90 92 00 	mov    0x9290a0(,%eax,4),%eax
  801eb4:	2b 45 f4             	sub    -0xc(%ebp),%eax
  801eb7:	89 04 95 a0 90 92 00 	mov    %eax,0x9290a0(,%edx,4)
				changed[index+1]=0;
  801ebe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801ec1:	40                   	inc    %eax
  801ec2:	c7 04 85 20 76 8c 00 	movl   $0x0,0x8c7620(,%eax,4)
  801ec9:	00 00 00 00 
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
  801ecd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801ed0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801ed3:	89 14 85 a0 90 92 00 	mov    %edx,0x9290a0(,%eax,4)
				for(int i=index;i<lastindex;i++)
  801eda:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801edd:	89 45 cc             	mov    %eax,-0x34(%ebp)
  801ee0:	eb 11                	jmp    801ef3 <malloc+0x230>
				{
					changed[index] = 1;
  801ee2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  801ee5:	c7 04 85 20 76 8c 00 	movl   $0x1,0x8c7620(,%eax,4)
  801eec:	01 00 00 00 
				changed[index+1]=0;
				/*cprintf("\n\n\n index is: %x\n\n\n",min_addresss+size);
				cprintf("\n\n\n index33 is: %x\n\n\n",addresses[sizeofarray-1]);
				cprintf("\n\n\n numpages is: %d\n\n\n",numOfPages[sizeofarray-1]);*/
				numOfPages[index] = num;
				for(int i=index;i<lastindex;i++)
  801ef0:	ff 45 cc             	incl   -0x34(%ebp)
  801ef3:	8b 45 cc             	mov    -0x34(%ebp),%eax
  801ef6:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801ef9:	7c e7                	jl     801ee2 <malloc+0x21f>
				{
					changed[index] = 1;
				}
				return (void*) min_addresss;
  801efb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801efe:	e9 86 00 00 00       	jmp    801f89 <malloc+0x2c6>
					}
				else
				{
					if(size>(USER_HEAP_MAX-last_addres))
  801f03:	a1 04 40 80 00       	mov    0x804004,%eax
  801f08:	ba 00 00 00 a0       	mov    $0xa0000000,%edx
  801f0d:	29 c2                	sub    %eax,%edx
  801f0f:	89 d0                	mov    %edx,%eax
  801f11:	3b 45 08             	cmp    0x8(%ebp),%eax
  801f14:	73 07                	jae    801f1d <malloc+0x25a>
						return NULL;
  801f16:	b8 00 00 00 00       	mov    $0x0,%eax
  801f1b:	eb 6c                	jmp    801f89 <malloc+0x2c6>
					sys_allocateMem(last_addres, size);
  801f1d:	a1 04 40 80 00       	mov    0x804004,%eax
  801f22:	83 ec 08             	sub    $0x8,%esp
  801f25:	ff 75 08             	pushl  0x8(%ebp)
  801f28:	50                   	push   %eax
  801f29:	e8 9a 03 00 00       	call   8022c8 <sys_allocateMem>
  801f2e:	83 c4 10             	add    $0x10,%esp
					return_addres = last_addres;
  801f31:	a1 04 40 80 00       	mov    0x804004,%eax
  801f36:	89 45 c8             	mov    %eax,-0x38(%ebp)
					last_addres += num * PAGE_SIZE;
  801f39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801f3c:	c1 e0 0c             	shl    $0xc,%eax
  801f3f:	89 c2                	mov    %eax,%edx
  801f41:	a1 04 40 80 00       	mov    0x804004,%eax
  801f46:	01 d0                	add    %edx,%eax
  801f48:	a3 04 40 80 00       	mov    %eax,0x804004
					numOfPages[sizeofarray] = num;
  801f4d:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801f52:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801f55:	89 14 85 a0 90 92 00 	mov    %edx,0x9290a0(,%eax,4)
					addresses[sizeofarray] = return_addres;
  801f5c:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801f61:	8b 55 c8             	mov    -0x38(%ebp),%edx
  801f64:	89 14 85 a0 5b 86 00 	mov    %edx,0x865ba0(,%eax,4)
					changed[sizeofarray] = 1;
  801f6b:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801f70:	c7 04 85 20 76 8c 00 	movl   $0x1,0x8c7620(,%eax,4)
  801f77:	01 00 00 00 
					sizeofarray++;
  801f7b:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801f80:	40                   	inc    %eax
  801f81:	a3 2c 40 80 00       	mov    %eax,0x80402c
					return (void*) return_addres;
  801f86:	8b 45 c8             	mov    -0x38(%ebp),%eax

	//refer to the project presentation and documentation for details

	return NULL;

}
  801f89:	c9                   	leave  
  801f8a:	c3                   	ret    

00801f8b <free>:
//	We can use sys_freeMem(uint32 virtual_address, uint32 size); which
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address) {
  801f8b:	55                   	push   %ebp
  801f8c:	89 e5                	mov    %esp,%ebp
  801f8e:	83 ec 28             	sub    $0x28,%esp
		cprintf("at index %d adders = %x\n", j, addresses[j]);
		cprintf("at index %d the size is %d \n", j, numOfPages[j] * PAGE_SIZE);
	}
	cprintf("---------------------------------------------------\n");*/
	//---------------------------
	uint32 va = (uint32) virtual_address;
  801f91:	8b 45 08             	mov    0x8(%ebp),%eax
  801f94:	89 45 e8             	mov    %eax,-0x18(%ebp)
	uint32 size;
	int is_found = 0;
  801f97:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801f9e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801fa5:	eb 30                	jmp    801fd7 <free+0x4c>
		if (addresses[i] == va && changed[i] == 1) {
  801fa7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801faa:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  801fb1:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801fb4:	75 1e                	jne    801fd4 <free+0x49>
  801fb6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801fb9:	8b 04 85 20 76 8c 00 	mov    0x8c7620(,%eax,4),%eax
  801fc0:	83 f8 01             	cmp    $0x1,%eax
  801fc3:	75 0f                	jne    801fd4 <free+0x49>
			is_found = 1;
  801fc5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
			index = i;
  801fcc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801fcf:	89 45 f0             	mov    %eax,-0x10(%ebp)
			break;
  801fd2:	eb 0d                	jmp    801fe1 <free+0x56>
	//---------------------------
	uint32 va = (uint32) virtual_address;
	uint32 size;
	int is_found = 0;
	int index;
	for (int i = 0; i < sizeofarray; i++) {
  801fd4:	ff 45 ec             	incl   -0x14(%ebp)
  801fd7:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801fdc:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801fdf:	7c c6                	jl     801fa7 <free+0x1c>
			is_found = 1;
			index = i;
			break;
		}
	}
	if (is_found == 1) {
  801fe1:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801fe5:	75 3a                	jne    802021 <free+0x96>
		size = numOfPages[index] * PAGE_SIZE;
  801fe7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801fea:	8b 04 85 a0 90 92 00 	mov    0x9290a0(,%eax,4),%eax
  801ff1:	c1 e0 0c             	shl    $0xc,%eax
  801ff4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		//cprintf("the size form the free is %d \n", size);
		sys_freeMem(va, size);
  801ff7:	83 ec 08             	sub    $0x8,%esp
  801ffa:	ff 75 e4             	pushl  -0x1c(%ebp)
  801ffd:	ff 75 e8             	pushl  -0x18(%ebp)
  802000:	e8 a7 02 00 00       	call   8022ac <sys_freeMem>
  802005:	83 c4 10             	add    $0x10,%esp
		changed[index] = 0;
  802008:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80200b:	c7 04 85 20 76 8c 00 	movl   $0x0,0x8c7620(,%eax,4)
  802012:	00 00 00 00 
		changes++;
  802016:	a1 28 40 80 00       	mov    0x804028,%eax
  80201b:	40                   	inc    %eax
  80201c:	a3 28 40 80 00       	mov    %eax,0x804028
	}
	//refer to the project presentation and documentation for details
}
  802021:	90                   	nop
  802022:	c9                   	leave  
  802023:	c3                   	ret    

00802024 <smalloc>:

//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable) {
  802024:	55                   	push   %ebp
  802025:	89 e5                	mov    %esp,%ebp
  802027:	83 ec 18             	sub    $0x18,%esp
  80202a:	8b 45 10             	mov    0x10(%ebp),%eax
  80202d:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  802030:	83 ec 04             	sub    $0x4,%esp
  802033:	68 30 32 80 00       	push   $0x803230
  802038:	68 b6 00 00 00       	push   $0xb6
  80203d:	68 53 32 80 00       	push   $0x803253
  802042:	e8 50 ec ff ff       	call   800c97 <_panic>

00802047 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName) {
  802047:	55                   	push   %ebp
  802048:	89 e5                	mov    %esp,%ebp
  80204a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80204d:	83 ec 04             	sub    $0x4,%esp
  802050:	68 30 32 80 00       	push   $0x803230
  802055:	68 bb 00 00 00       	push   $0xbb
  80205a:	68 53 32 80 00       	push   $0x803253
  80205f:	e8 33 ec ff ff       	call   800c97 <_panic>

00802064 <sfree>:
	return 0;
}

void sfree(void* virtual_address) {
  802064:	55                   	push   %ebp
  802065:	89 e5                	mov    %esp,%ebp
  802067:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80206a:	83 ec 04             	sub    $0x4,%esp
  80206d:	68 30 32 80 00       	push   $0x803230
  802072:	68 c0 00 00 00       	push   $0xc0
  802077:	68 53 32 80 00       	push   $0x803253
  80207c:	e8 16 ec ff ff       	call   800c97 <_panic>

00802081 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size) {
  802081:	55                   	push   %ebp
  802082:	89 e5                	mov    %esp,%ebp
  802084:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802087:	83 ec 04             	sub    $0x4,%esp
  80208a:	68 30 32 80 00       	push   $0x803230
  80208f:	68 c4 00 00 00       	push   $0xc4
  802094:	68 53 32 80 00       	push   $0x803253
  802099:	e8 f9 eb ff ff       	call   800c97 <_panic>

0080209e <expand>:
	return 0;
}

void expand(uint32 newSize) {
  80209e:	55                   	push   %ebp
  80209f:	89 e5                	mov    %esp,%ebp
  8020a1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8020a4:	83 ec 04             	sub    $0x4,%esp
  8020a7:	68 30 32 80 00       	push   $0x803230
  8020ac:	68 c9 00 00 00       	push   $0xc9
  8020b1:	68 53 32 80 00       	push   $0x803253
  8020b6:	e8 dc eb ff ff       	call   800c97 <_panic>

008020bb <shrink>:
}
void shrink(uint32 newSize) {
  8020bb:	55                   	push   %ebp
  8020bc:	89 e5                	mov    %esp,%ebp
  8020be:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8020c1:	83 ec 04             	sub    $0x4,%esp
  8020c4:	68 30 32 80 00       	push   $0x803230
  8020c9:	68 cc 00 00 00       	push   $0xcc
  8020ce:	68 53 32 80 00       	push   $0x803253
  8020d3:	e8 bf eb ff ff       	call   800c97 <_panic>

008020d8 <freeHeap>:
}

void freeHeap(void* virtual_address) {
  8020d8:	55                   	push   %ebp
  8020d9:	89 e5                	mov    %esp,%ebp
  8020db:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8020de:	83 ec 04             	sub    $0x4,%esp
  8020e1:	68 30 32 80 00       	push   $0x803230
  8020e6:	68 d0 00 00 00       	push   $0xd0
  8020eb:	68 53 32 80 00       	push   $0x803253
  8020f0:	e8 a2 eb ff ff       	call   800c97 <_panic>

008020f5 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8020f5:	55                   	push   %ebp
  8020f6:	89 e5                	mov    %esp,%ebp
  8020f8:	57                   	push   %edi
  8020f9:	56                   	push   %esi
  8020fa:	53                   	push   %ebx
  8020fb:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8020fe:	8b 45 08             	mov    0x8(%ebp),%eax
  802101:	8b 55 0c             	mov    0xc(%ebp),%edx
  802104:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802107:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80210a:	8b 7d 18             	mov    0x18(%ebp),%edi
  80210d:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802110:	cd 30                	int    $0x30
  802112:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  802115:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  802118:	83 c4 10             	add    $0x10,%esp
  80211b:	5b                   	pop    %ebx
  80211c:	5e                   	pop    %esi
  80211d:	5f                   	pop    %edi
  80211e:	5d                   	pop    %ebp
  80211f:	c3                   	ret    

00802120 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802120:	55                   	push   %ebp
  802121:	89 e5                	mov    %esp,%ebp
  802123:	83 ec 04             	sub    $0x4,%esp
  802126:	8b 45 10             	mov    0x10(%ebp),%eax
  802129:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80212c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802130:	8b 45 08             	mov    0x8(%ebp),%eax
  802133:	6a 00                	push   $0x0
  802135:	6a 00                	push   $0x0
  802137:	52                   	push   %edx
  802138:	ff 75 0c             	pushl  0xc(%ebp)
  80213b:	50                   	push   %eax
  80213c:	6a 00                	push   $0x0
  80213e:	e8 b2 ff ff ff       	call   8020f5 <syscall>
  802143:	83 c4 18             	add    $0x18,%esp
}
  802146:	90                   	nop
  802147:	c9                   	leave  
  802148:	c3                   	ret    

00802149 <sys_cgetc>:

int
sys_cgetc(void)
{
  802149:	55                   	push   %ebp
  80214a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80214c:	6a 00                	push   $0x0
  80214e:	6a 00                	push   $0x0
  802150:	6a 00                	push   $0x0
  802152:	6a 00                	push   $0x0
  802154:	6a 00                	push   $0x0
  802156:	6a 01                	push   $0x1
  802158:	e8 98 ff ff ff       	call   8020f5 <syscall>
  80215d:	83 c4 18             	add    $0x18,%esp
}
  802160:	c9                   	leave  
  802161:	c3                   	ret    

00802162 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802162:	55                   	push   %ebp
  802163:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  802165:	8b 45 08             	mov    0x8(%ebp),%eax
  802168:	6a 00                	push   $0x0
  80216a:	6a 00                	push   $0x0
  80216c:	6a 00                	push   $0x0
  80216e:	6a 00                	push   $0x0
  802170:	50                   	push   %eax
  802171:	6a 05                	push   $0x5
  802173:	e8 7d ff ff ff       	call   8020f5 <syscall>
  802178:	83 c4 18             	add    $0x18,%esp
}
  80217b:	c9                   	leave  
  80217c:	c3                   	ret    

0080217d <sys_getenvid>:

int32 sys_getenvid(void)
{
  80217d:	55                   	push   %ebp
  80217e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802180:	6a 00                	push   $0x0
  802182:	6a 00                	push   $0x0
  802184:	6a 00                	push   $0x0
  802186:	6a 00                	push   $0x0
  802188:	6a 00                	push   $0x0
  80218a:	6a 02                	push   $0x2
  80218c:	e8 64 ff ff ff       	call   8020f5 <syscall>
  802191:	83 c4 18             	add    $0x18,%esp
}
  802194:	c9                   	leave  
  802195:	c3                   	ret    

00802196 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802196:	55                   	push   %ebp
  802197:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802199:	6a 00                	push   $0x0
  80219b:	6a 00                	push   $0x0
  80219d:	6a 00                	push   $0x0
  80219f:	6a 00                	push   $0x0
  8021a1:	6a 00                	push   $0x0
  8021a3:	6a 03                	push   $0x3
  8021a5:	e8 4b ff ff ff       	call   8020f5 <syscall>
  8021aa:	83 c4 18             	add    $0x18,%esp
}
  8021ad:	c9                   	leave  
  8021ae:	c3                   	ret    

008021af <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8021af:	55                   	push   %ebp
  8021b0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8021b2:	6a 00                	push   $0x0
  8021b4:	6a 00                	push   $0x0
  8021b6:	6a 00                	push   $0x0
  8021b8:	6a 00                	push   $0x0
  8021ba:	6a 00                	push   $0x0
  8021bc:	6a 04                	push   $0x4
  8021be:	e8 32 ff ff ff       	call   8020f5 <syscall>
  8021c3:	83 c4 18             	add    $0x18,%esp
}
  8021c6:	c9                   	leave  
  8021c7:	c3                   	ret    

008021c8 <sys_env_exit>:


void sys_env_exit(void)
{
  8021c8:	55                   	push   %ebp
  8021c9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8021cb:	6a 00                	push   $0x0
  8021cd:	6a 00                	push   $0x0
  8021cf:	6a 00                	push   $0x0
  8021d1:	6a 00                	push   $0x0
  8021d3:	6a 00                	push   $0x0
  8021d5:	6a 06                	push   $0x6
  8021d7:	e8 19 ff ff ff       	call   8020f5 <syscall>
  8021dc:	83 c4 18             	add    $0x18,%esp
}
  8021df:	90                   	nop
  8021e0:	c9                   	leave  
  8021e1:	c3                   	ret    

008021e2 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8021e2:	55                   	push   %ebp
  8021e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8021e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8021eb:	6a 00                	push   $0x0
  8021ed:	6a 00                	push   $0x0
  8021ef:	6a 00                	push   $0x0
  8021f1:	52                   	push   %edx
  8021f2:	50                   	push   %eax
  8021f3:	6a 07                	push   $0x7
  8021f5:	e8 fb fe ff ff       	call   8020f5 <syscall>
  8021fa:	83 c4 18             	add    $0x18,%esp
}
  8021fd:	c9                   	leave  
  8021fe:	c3                   	ret    

008021ff <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8021ff:	55                   	push   %ebp
  802200:	89 e5                	mov    %esp,%ebp
  802202:	56                   	push   %esi
  802203:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802204:	8b 75 18             	mov    0x18(%ebp),%esi
  802207:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80220a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80220d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802210:	8b 45 08             	mov    0x8(%ebp),%eax
  802213:	56                   	push   %esi
  802214:	53                   	push   %ebx
  802215:	51                   	push   %ecx
  802216:	52                   	push   %edx
  802217:	50                   	push   %eax
  802218:	6a 08                	push   $0x8
  80221a:	e8 d6 fe ff ff       	call   8020f5 <syscall>
  80221f:	83 c4 18             	add    $0x18,%esp
}
  802222:	8d 65 f8             	lea    -0x8(%ebp),%esp
  802225:	5b                   	pop    %ebx
  802226:	5e                   	pop    %esi
  802227:	5d                   	pop    %ebp
  802228:	c3                   	ret    

00802229 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802229:	55                   	push   %ebp
  80222a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80222c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80222f:	8b 45 08             	mov    0x8(%ebp),%eax
  802232:	6a 00                	push   $0x0
  802234:	6a 00                	push   $0x0
  802236:	6a 00                	push   $0x0
  802238:	52                   	push   %edx
  802239:	50                   	push   %eax
  80223a:	6a 09                	push   $0x9
  80223c:	e8 b4 fe ff ff       	call   8020f5 <syscall>
  802241:	83 c4 18             	add    $0x18,%esp
}
  802244:	c9                   	leave  
  802245:	c3                   	ret    

00802246 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802246:	55                   	push   %ebp
  802247:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802249:	6a 00                	push   $0x0
  80224b:	6a 00                	push   $0x0
  80224d:	6a 00                	push   $0x0
  80224f:	ff 75 0c             	pushl  0xc(%ebp)
  802252:	ff 75 08             	pushl  0x8(%ebp)
  802255:	6a 0a                	push   $0xa
  802257:	e8 99 fe ff ff       	call   8020f5 <syscall>
  80225c:	83 c4 18             	add    $0x18,%esp
}
  80225f:	c9                   	leave  
  802260:	c3                   	ret    

00802261 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802261:	55                   	push   %ebp
  802262:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802264:	6a 00                	push   $0x0
  802266:	6a 00                	push   $0x0
  802268:	6a 00                	push   $0x0
  80226a:	6a 00                	push   $0x0
  80226c:	6a 00                	push   $0x0
  80226e:	6a 0b                	push   $0xb
  802270:	e8 80 fe ff ff       	call   8020f5 <syscall>
  802275:	83 c4 18             	add    $0x18,%esp
}
  802278:	c9                   	leave  
  802279:	c3                   	ret    

0080227a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80227a:	55                   	push   %ebp
  80227b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80227d:	6a 00                	push   $0x0
  80227f:	6a 00                	push   $0x0
  802281:	6a 00                	push   $0x0
  802283:	6a 00                	push   $0x0
  802285:	6a 00                	push   $0x0
  802287:	6a 0c                	push   $0xc
  802289:	e8 67 fe ff ff       	call   8020f5 <syscall>
  80228e:	83 c4 18             	add    $0x18,%esp
}
  802291:	c9                   	leave  
  802292:	c3                   	ret    

00802293 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  802293:	55                   	push   %ebp
  802294:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802296:	6a 00                	push   $0x0
  802298:	6a 00                	push   $0x0
  80229a:	6a 00                	push   $0x0
  80229c:	6a 00                	push   $0x0
  80229e:	6a 00                	push   $0x0
  8022a0:	6a 0d                	push   $0xd
  8022a2:	e8 4e fe ff ff       	call   8020f5 <syscall>
  8022a7:	83 c4 18             	add    $0x18,%esp
}
  8022aa:	c9                   	leave  
  8022ab:	c3                   	ret    

008022ac <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8022ac:	55                   	push   %ebp
  8022ad:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8022af:	6a 00                	push   $0x0
  8022b1:	6a 00                	push   $0x0
  8022b3:	6a 00                	push   $0x0
  8022b5:	ff 75 0c             	pushl  0xc(%ebp)
  8022b8:	ff 75 08             	pushl  0x8(%ebp)
  8022bb:	6a 11                	push   $0x11
  8022bd:	e8 33 fe ff ff       	call   8020f5 <syscall>
  8022c2:	83 c4 18             	add    $0x18,%esp
	return;
  8022c5:	90                   	nop
}
  8022c6:	c9                   	leave  
  8022c7:	c3                   	ret    

008022c8 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8022c8:	55                   	push   %ebp
  8022c9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8022cb:	6a 00                	push   $0x0
  8022cd:	6a 00                	push   $0x0
  8022cf:	6a 00                	push   $0x0
  8022d1:	ff 75 0c             	pushl  0xc(%ebp)
  8022d4:	ff 75 08             	pushl  0x8(%ebp)
  8022d7:	6a 12                	push   $0x12
  8022d9:	e8 17 fe ff ff       	call   8020f5 <syscall>
  8022de:	83 c4 18             	add    $0x18,%esp
	return ;
  8022e1:	90                   	nop
}
  8022e2:	c9                   	leave  
  8022e3:	c3                   	ret    

008022e4 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8022e4:	55                   	push   %ebp
  8022e5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8022e7:	6a 00                	push   $0x0
  8022e9:	6a 00                	push   $0x0
  8022eb:	6a 00                	push   $0x0
  8022ed:	6a 00                	push   $0x0
  8022ef:	6a 00                	push   $0x0
  8022f1:	6a 0e                	push   $0xe
  8022f3:	e8 fd fd ff ff       	call   8020f5 <syscall>
  8022f8:	83 c4 18             	add    $0x18,%esp
}
  8022fb:	c9                   	leave  
  8022fc:	c3                   	ret    

008022fd <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8022fd:	55                   	push   %ebp
  8022fe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802300:	6a 00                	push   $0x0
  802302:	6a 00                	push   $0x0
  802304:	6a 00                	push   $0x0
  802306:	6a 00                	push   $0x0
  802308:	ff 75 08             	pushl  0x8(%ebp)
  80230b:	6a 0f                	push   $0xf
  80230d:	e8 e3 fd ff ff       	call   8020f5 <syscall>
  802312:	83 c4 18             	add    $0x18,%esp
}
  802315:	c9                   	leave  
  802316:	c3                   	ret    

00802317 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802317:	55                   	push   %ebp
  802318:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80231a:	6a 00                	push   $0x0
  80231c:	6a 00                	push   $0x0
  80231e:	6a 00                	push   $0x0
  802320:	6a 00                	push   $0x0
  802322:	6a 00                	push   $0x0
  802324:	6a 10                	push   $0x10
  802326:	e8 ca fd ff ff       	call   8020f5 <syscall>
  80232b:	83 c4 18             	add    $0x18,%esp
}
  80232e:	90                   	nop
  80232f:	c9                   	leave  
  802330:	c3                   	ret    

00802331 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802331:	55                   	push   %ebp
  802332:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802334:	6a 00                	push   $0x0
  802336:	6a 00                	push   $0x0
  802338:	6a 00                	push   $0x0
  80233a:	6a 00                	push   $0x0
  80233c:	6a 00                	push   $0x0
  80233e:	6a 14                	push   $0x14
  802340:	e8 b0 fd ff ff       	call   8020f5 <syscall>
  802345:	83 c4 18             	add    $0x18,%esp
}
  802348:	90                   	nop
  802349:	c9                   	leave  
  80234a:	c3                   	ret    

0080234b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80234b:	55                   	push   %ebp
  80234c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80234e:	6a 00                	push   $0x0
  802350:	6a 00                	push   $0x0
  802352:	6a 00                	push   $0x0
  802354:	6a 00                	push   $0x0
  802356:	6a 00                	push   $0x0
  802358:	6a 15                	push   $0x15
  80235a:	e8 96 fd ff ff       	call   8020f5 <syscall>
  80235f:	83 c4 18             	add    $0x18,%esp
}
  802362:	90                   	nop
  802363:	c9                   	leave  
  802364:	c3                   	ret    

00802365 <sys_cputc>:


void
sys_cputc(const char c)
{
  802365:	55                   	push   %ebp
  802366:	89 e5                	mov    %esp,%ebp
  802368:	83 ec 04             	sub    $0x4,%esp
  80236b:	8b 45 08             	mov    0x8(%ebp),%eax
  80236e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802371:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802375:	6a 00                	push   $0x0
  802377:	6a 00                	push   $0x0
  802379:	6a 00                	push   $0x0
  80237b:	6a 00                	push   $0x0
  80237d:	50                   	push   %eax
  80237e:	6a 16                	push   $0x16
  802380:	e8 70 fd ff ff       	call   8020f5 <syscall>
  802385:	83 c4 18             	add    $0x18,%esp
}
  802388:	90                   	nop
  802389:	c9                   	leave  
  80238a:	c3                   	ret    

0080238b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80238b:	55                   	push   %ebp
  80238c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80238e:	6a 00                	push   $0x0
  802390:	6a 00                	push   $0x0
  802392:	6a 00                	push   $0x0
  802394:	6a 00                	push   $0x0
  802396:	6a 00                	push   $0x0
  802398:	6a 17                	push   $0x17
  80239a:	e8 56 fd ff ff       	call   8020f5 <syscall>
  80239f:	83 c4 18             	add    $0x18,%esp
}
  8023a2:	90                   	nop
  8023a3:	c9                   	leave  
  8023a4:	c3                   	ret    

008023a5 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8023a5:	55                   	push   %ebp
  8023a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8023a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8023ab:	6a 00                	push   $0x0
  8023ad:	6a 00                	push   $0x0
  8023af:	6a 00                	push   $0x0
  8023b1:	ff 75 0c             	pushl  0xc(%ebp)
  8023b4:	50                   	push   %eax
  8023b5:	6a 18                	push   $0x18
  8023b7:	e8 39 fd ff ff       	call   8020f5 <syscall>
  8023bc:	83 c4 18             	add    $0x18,%esp
}
  8023bf:	c9                   	leave  
  8023c0:	c3                   	ret    

008023c1 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8023c1:	55                   	push   %ebp
  8023c2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8023c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8023ca:	6a 00                	push   $0x0
  8023cc:	6a 00                	push   $0x0
  8023ce:	6a 00                	push   $0x0
  8023d0:	52                   	push   %edx
  8023d1:	50                   	push   %eax
  8023d2:	6a 1b                	push   $0x1b
  8023d4:	e8 1c fd ff ff       	call   8020f5 <syscall>
  8023d9:	83 c4 18             	add    $0x18,%esp
}
  8023dc:	c9                   	leave  
  8023dd:	c3                   	ret    

008023de <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8023de:	55                   	push   %ebp
  8023df:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8023e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8023e7:	6a 00                	push   $0x0
  8023e9:	6a 00                	push   $0x0
  8023eb:	6a 00                	push   $0x0
  8023ed:	52                   	push   %edx
  8023ee:	50                   	push   %eax
  8023ef:	6a 19                	push   $0x19
  8023f1:	e8 ff fc ff ff       	call   8020f5 <syscall>
  8023f6:	83 c4 18             	add    $0x18,%esp
}
  8023f9:	90                   	nop
  8023fa:	c9                   	leave  
  8023fb:	c3                   	ret    

008023fc <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8023fc:	55                   	push   %ebp
  8023fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8023ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  802402:	8b 45 08             	mov    0x8(%ebp),%eax
  802405:	6a 00                	push   $0x0
  802407:	6a 00                	push   $0x0
  802409:	6a 00                	push   $0x0
  80240b:	52                   	push   %edx
  80240c:	50                   	push   %eax
  80240d:	6a 1a                	push   $0x1a
  80240f:	e8 e1 fc ff ff       	call   8020f5 <syscall>
  802414:	83 c4 18             	add    $0x18,%esp
}
  802417:	90                   	nop
  802418:	c9                   	leave  
  802419:	c3                   	ret    

0080241a <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80241a:	55                   	push   %ebp
  80241b:	89 e5                	mov    %esp,%ebp
  80241d:	83 ec 04             	sub    $0x4,%esp
  802420:	8b 45 10             	mov    0x10(%ebp),%eax
  802423:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802426:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802429:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80242d:	8b 45 08             	mov    0x8(%ebp),%eax
  802430:	6a 00                	push   $0x0
  802432:	51                   	push   %ecx
  802433:	52                   	push   %edx
  802434:	ff 75 0c             	pushl  0xc(%ebp)
  802437:	50                   	push   %eax
  802438:	6a 1c                	push   $0x1c
  80243a:	e8 b6 fc ff ff       	call   8020f5 <syscall>
  80243f:	83 c4 18             	add    $0x18,%esp
}
  802442:	c9                   	leave  
  802443:	c3                   	ret    

00802444 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802444:	55                   	push   %ebp
  802445:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802447:	8b 55 0c             	mov    0xc(%ebp),%edx
  80244a:	8b 45 08             	mov    0x8(%ebp),%eax
  80244d:	6a 00                	push   $0x0
  80244f:	6a 00                	push   $0x0
  802451:	6a 00                	push   $0x0
  802453:	52                   	push   %edx
  802454:	50                   	push   %eax
  802455:	6a 1d                	push   $0x1d
  802457:	e8 99 fc ff ff       	call   8020f5 <syscall>
  80245c:	83 c4 18             	add    $0x18,%esp
}
  80245f:	c9                   	leave  
  802460:	c3                   	ret    

00802461 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802461:	55                   	push   %ebp
  802462:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802464:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802467:	8b 55 0c             	mov    0xc(%ebp),%edx
  80246a:	8b 45 08             	mov    0x8(%ebp),%eax
  80246d:	6a 00                	push   $0x0
  80246f:	6a 00                	push   $0x0
  802471:	51                   	push   %ecx
  802472:	52                   	push   %edx
  802473:	50                   	push   %eax
  802474:	6a 1e                	push   $0x1e
  802476:	e8 7a fc ff ff       	call   8020f5 <syscall>
  80247b:	83 c4 18             	add    $0x18,%esp
}
  80247e:	c9                   	leave  
  80247f:	c3                   	ret    

00802480 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802480:	55                   	push   %ebp
  802481:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802483:	8b 55 0c             	mov    0xc(%ebp),%edx
  802486:	8b 45 08             	mov    0x8(%ebp),%eax
  802489:	6a 00                	push   $0x0
  80248b:	6a 00                	push   $0x0
  80248d:	6a 00                	push   $0x0
  80248f:	52                   	push   %edx
  802490:	50                   	push   %eax
  802491:	6a 1f                	push   $0x1f
  802493:	e8 5d fc ff ff       	call   8020f5 <syscall>
  802498:	83 c4 18             	add    $0x18,%esp
}
  80249b:	c9                   	leave  
  80249c:	c3                   	ret    

0080249d <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80249d:	55                   	push   %ebp
  80249e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8024a0:	6a 00                	push   $0x0
  8024a2:	6a 00                	push   $0x0
  8024a4:	6a 00                	push   $0x0
  8024a6:	6a 00                	push   $0x0
  8024a8:	6a 00                	push   $0x0
  8024aa:	6a 20                	push   $0x20
  8024ac:	e8 44 fc ff ff       	call   8020f5 <syscall>
  8024b1:	83 c4 18             	add    $0x18,%esp
}
  8024b4:	c9                   	leave  
  8024b5:	c3                   	ret    

008024b6 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8024b6:	55                   	push   %ebp
  8024b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8024b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8024bc:	6a 00                	push   $0x0
  8024be:	ff 75 14             	pushl  0x14(%ebp)
  8024c1:	ff 75 10             	pushl  0x10(%ebp)
  8024c4:	ff 75 0c             	pushl  0xc(%ebp)
  8024c7:	50                   	push   %eax
  8024c8:	6a 21                	push   $0x21
  8024ca:	e8 26 fc ff ff       	call   8020f5 <syscall>
  8024cf:	83 c4 18             	add    $0x18,%esp
}
  8024d2:	c9                   	leave  
  8024d3:	c3                   	ret    

008024d4 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8024d4:	55                   	push   %ebp
  8024d5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8024d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8024da:	6a 00                	push   $0x0
  8024dc:	6a 00                	push   $0x0
  8024de:	6a 00                	push   $0x0
  8024e0:	6a 00                	push   $0x0
  8024e2:	50                   	push   %eax
  8024e3:	6a 22                	push   $0x22
  8024e5:	e8 0b fc ff ff       	call   8020f5 <syscall>
  8024ea:	83 c4 18             	add    $0x18,%esp
}
  8024ed:	90                   	nop
  8024ee:	c9                   	leave  
  8024ef:	c3                   	ret    

008024f0 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8024f0:	55                   	push   %ebp
  8024f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8024f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8024f6:	6a 00                	push   $0x0
  8024f8:	6a 00                	push   $0x0
  8024fa:	6a 00                	push   $0x0
  8024fc:	6a 00                	push   $0x0
  8024fe:	50                   	push   %eax
  8024ff:	6a 23                	push   $0x23
  802501:	e8 ef fb ff ff       	call   8020f5 <syscall>
  802506:	83 c4 18             	add    $0x18,%esp
}
  802509:	90                   	nop
  80250a:	c9                   	leave  
  80250b:	c3                   	ret    

0080250c <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80250c:	55                   	push   %ebp
  80250d:	89 e5                	mov    %esp,%ebp
  80250f:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802512:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802515:	8d 50 04             	lea    0x4(%eax),%edx
  802518:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80251b:	6a 00                	push   $0x0
  80251d:	6a 00                	push   $0x0
  80251f:	6a 00                	push   $0x0
  802521:	52                   	push   %edx
  802522:	50                   	push   %eax
  802523:	6a 24                	push   $0x24
  802525:	e8 cb fb ff ff       	call   8020f5 <syscall>
  80252a:	83 c4 18             	add    $0x18,%esp
	return result;
  80252d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802530:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802533:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802536:	89 01                	mov    %eax,(%ecx)
  802538:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80253b:	8b 45 08             	mov    0x8(%ebp),%eax
  80253e:	c9                   	leave  
  80253f:	c2 04 00             	ret    $0x4

00802542 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802542:	55                   	push   %ebp
  802543:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802545:	6a 00                	push   $0x0
  802547:	6a 00                	push   $0x0
  802549:	ff 75 10             	pushl  0x10(%ebp)
  80254c:	ff 75 0c             	pushl  0xc(%ebp)
  80254f:	ff 75 08             	pushl  0x8(%ebp)
  802552:	6a 13                	push   $0x13
  802554:	e8 9c fb ff ff       	call   8020f5 <syscall>
  802559:	83 c4 18             	add    $0x18,%esp
	return ;
  80255c:	90                   	nop
}
  80255d:	c9                   	leave  
  80255e:	c3                   	ret    

0080255f <sys_rcr2>:
uint32 sys_rcr2()
{
  80255f:	55                   	push   %ebp
  802560:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802562:	6a 00                	push   $0x0
  802564:	6a 00                	push   $0x0
  802566:	6a 00                	push   $0x0
  802568:	6a 00                	push   $0x0
  80256a:	6a 00                	push   $0x0
  80256c:	6a 25                	push   $0x25
  80256e:	e8 82 fb ff ff       	call   8020f5 <syscall>
  802573:	83 c4 18             	add    $0x18,%esp
}
  802576:	c9                   	leave  
  802577:	c3                   	ret    

00802578 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802578:	55                   	push   %ebp
  802579:	89 e5                	mov    %esp,%ebp
  80257b:	83 ec 04             	sub    $0x4,%esp
  80257e:	8b 45 08             	mov    0x8(%ebp),%eax
  802581:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802584:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802588:	6a 00                	push   $0x0
  80258a:	6a 00                	push   $0x0
  80258c:	6a 00                	push   $0x0
  80258e:	6a 00                	push   $0x0
  802590:	50                   	push   %eax
  802591:	6a 26                	push   $0x26
  802593:	e8 5d fb ff ff       	call   8020f5 <syscall>
  802598:	83 c4 18             	add    $0x18,%esp
	return ;
  80259b:	90                   	nop
}
  80259c:	c9                   	leave  
  80259d:	c3                   	ret    

0080259e <rsttst>:
void rsttst()
{
  80259e:	55                   	push   %ebp
  80259f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8025a1:	6a 00                	push   $0x0
  8025a3:	6a 00                	push   $0x0
  8025a5:	6a 00                	push   $0x0
  8025a7:	6a 00                	push   $0x0
  8025a9:	6a 00                	push   $0x0
  8025ab:	6a 28                	push   $0x28
  8025ad:	e8 43 fb ff ff       	call   8020f5 <syscall>
  8025b2:	83 c4 18             	add    $0x18,%esp
	return ;
  8025b5:	90                   	nop
}
  8025b6:	c9                   	leave  
  8025b7:	c3                   	ret    

008025b8 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8025b8:	55                   	push   %ebp
  8025b9:	89 e5                	mov    %esp,%ebp
  8025bb:	83 ec 04             	sub    $0x4,%esp
  8025be:	8b 45 14             	mov    0x14(%ebp),%eax
  8025c1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8025c4:	8b 55 18             	mov    0x18(%ebp),%edx
  8025c7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8025cb:	52                   	push   %edx
  8025cc:	50                   	push   %eax
  8025cd:	ff 75 10             	pushl  0x10(%ebp)
  8025d0:	ff 75 0c             	pushl  0xc(%ebp)
  8025d3:	ff 75 08             	pushl  0x8(%ebp)
  8025d6:	6a 27                	push   $0x27
  8025d8:	e8 18 fb ff ff       	call   8020f5 <syscall>
  8025dd:	83 c4 18             	add    $0x18,%esp
	return ;
  8025e0:	90                   	nop
}
  8025e1:	c9                   	leave  
  8025e2:	c3                   	ret    

008025e3 <chktst>:
void chktst(uint32 n)
{
  8025e3:	55                   	push   %ebp
  8025e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8025e6:	6a 00                	push   $0x0
  8025e8:	6a 00                	push   $0x0
  8025ea:	6a 00                	push   $0x0
  8025ec:	6a 00                	push   $0x0
  8025ee:	ff 75 08             	pushl  0x8(%ebp)
  8025f1:	6a 29                	push   $0x29
  8025f3:	e8 fd fa ff ff       	call   8020f5 <syscall>
  8025f8:	83 c4 18             	add    $0x18,%esp
	return ;
  8025fb:	90                   	nop
}
  8025fc:	c9                   	leave  
  8025fd:	c3                   	ret    

008025fe <inctst>:

void inctst()
{
  8025fe:	55                   	push   %ebp
  8025ff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802601:	6a 00                	push   $0x0
  802603:	6a 00                	push   $0x0
  802605:	6a 00                	push   $0x0
  802607:	6a 00                	push   $0x0
  802609:	6a 00                	push   $0x0
  80260b:	6a 2a                	push   $0x2a
  80260d:	e8 e3 fa ff ff       	call   8020f5 <syscall>
  802612:	83 c4 18             	add    $0x18,%esp
	return ;
  802615:	90                   	nop
}
  802616:	c9                   	leave  
  802617:	c3                   	ret    

00802618 <gettst>:
uint32 gettst()
{
  802618:	55                   	push   %ebp
  802619:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80261b:	6a 00                	push   $0x0
  80261d:	6a 00                	push   $0x0
  80261f:	6a 00                	push   $0x0
  802621:	6a 00                	push   $0x0
  802623:	6a 00                	push   $0x0
  802625:	6a 2b                	push   $0x2b
  802627:	e8 c9 fa ff ff       	call   8020f5 <syscall>
  80262c:	83 c4 18             	add    $0x18,%esp
}
  80262f:	c9                   	leave  
  802630:	c3                   	ret    

00802631 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802631:	55                   	push   %ebp
  802632:	89 e5                	mov    %esp,%ebp
  802634:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802637:	6a 00                	push   $0x0
  802639:	6a 00                	push   $0x0
  80263b:	6a 00                	push   $0x0
  80263d:	6a 00                	push   $0x0
  80263f:	6a 00                	push   $0x0
  802641:	6a 2c                	push   $0x2c
  802643:	e8 ad fa ff ff       	call   8020f5 <syscall>
  802648:	83 c4 18             	add    $0x18,%esp
  80264b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80264e:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802652:	75 07                	jne    80265b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802654:	b8 01 00 00 00       	mov    $0x1,%eax
  802659:	eb 05                	jmp    802660 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80265b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802660:	c9                   	leave  
  802661:	c3                   	ret    

00802662 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802662:	55                   	push   %ebp
  802663:	89 e5                	mov    %esp,%ebp
  802665:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802668:	6a 00                	push   $0x0
  80266a:	6a 00                	push   $0x0
  80266c:	6a 00                	push   $0x0
  80266e:	6a 00                	push   $0x0
  802670:	6a 00                	push   $0x0
  802672:	6a 2c                	push   $0x2c
  802674:	e8 7c fa ff ff       	call   8020f5 <syscall>
  802679:	83 c4 18             	add    $0x18,%esp
  80267c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80267f:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802683:	75 07                	jne    80268c <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802685:	b8 01 00 00 00       	mov    $0x1,%eax
  80268a:	eb 05                	jmp    802691 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80268c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802691:	c9                   	leave  
  802692:	c3                   	ret    

00802693 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802693:	55                   	push   %ebp
  802694:	89 e5                	mov    %esp,%ebp
  802696:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802699:	6a 00                	push   $0x0
  80269b:	6a 00                	push   $0x0
  80269d:	6a 00                	push   $0x0
  80269f:	6a 00                	push   $0x0
  8026a1:	6a 00                	push   $0x0
  8026a3:	6a 2c                	push   $0x2c
  8026a5:	e8 4b fa ff ff       	call   8020f5 <syscall>
  8026aa:	83 c4 18             	add    $0x18,%esp
  8026ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8026b0:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8026b4:	75 07                	jne    8026bd <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8026b6:	b8 01 00 00 00       	mov    $0x1,%eax
  8026bb:	eb 05                	jmp    8026c2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8026bd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8026c2:	c9                   	leave  
  8026c3:	c3                   	ret    

008026c4 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8026c4:	55                   	push   %ebp
  8026c5:	89 e5                	mov    %esp,%ebp
  8026c7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8026ca:	6a 00                	push   $0x0
  8026cc:	6a 00                	push   $0x0
  8026ce:	6a 00                	push   $0x0
  8026d0:	6a 00                	push   $0x0
  8026d2:	6a 00                	push   $0x0
  8026d4:	6a 2c                	push   $0x2c
  8026d6:	e8 1a fa ff ff       	call   8020f5 <syscall>
  8026db:	83 c4 18             	add    $0x18,%esp
  8026de:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8026e1:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8026e5:	75 07                	jne    8026ee <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8026e7:	b8 01 00 00 00       	mov    $0x1,%eax
  8026ec:	eb 05                	jmp    8026f3 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8026ee:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8026f3:	c9                   	leave  
  8026f4:	c3                   	ret    

008026f5 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8026f5:	55                   	push   %ebp
  8026f6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8026f8:	6a 00                	push   $0x0
  8026fa:	6a 00                	push   $0x0
  8026fc:	6a 00                	push   $0x0
  8026fe:	6a 00                	push   $0x0
  802700:	ff 75 08             	pushl  0x8(%ebp)
  802703:	6a 2d                	push   $0x2d
  802705:	e8 eb f9 ff ff       	call   8020f5 <syscall>
  80270a:	83 c4 18             	add    $0x18,%esp
	return ;
  80270d:	90                   	nop
}
  80270e:	c9                   	leave  
  80270f:	c3                   	ret    

00802710 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802710:	55                   	push   %ebp
  802711:	89 e5                	mov    %esp,%ebp
  802713:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802714:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802717:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80271a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80271d:	8b 45 08             	mov    0x8(%ebp),%eax
  802720:	6a 00                	push   $0x0
  802722:	53                   	push   %ebx
  802723:	51                   	push   %ecx
  802724:	52                   	push   %edx
  802725:	50                   	push   %eax
  802726:	6a 2e                	push   $0x2e
  802728:	e8 c8 f9 ff ff       	call   8020f5 <syscall>
  80272d:	83 c4 18             	add    $0x18,%esp
}
  802730:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802733:	c9                   	leave  
  802734:	c3                   	ret    

00802735 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802735:	55                   	push   %ebp
  802736:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802738:	8b 55 0c             	mov    0xc(%ebp),%edx
  80273b:	8b 45 08             	mov    0x8(%ebp),%eax
  80273e:	6a 00                	push   $0x0
  802740:	6a 00                	push   $0x0
  802742:	6a 00                	push   $0x0
  802744:	52                   	push   %edx
  802745:	50                   	push   %eax
  802746:	6a 2f                	push   $0x2f
  802748:	e8 a8 f9 ff ff       	call   8020f5 <syscall>
  80274d:	83 c4 18             	add    $0x18,%esp
}
  802750:	c9                   	leave  
  802751:	c3                   	ret    
  802752:	66 90                	xchg   %ax,%ax

00802754 <__udivdi3>:
  802754:	55                   	push   %ebp
  802755:	57                   	push   %edi
  802756:	56                   	push   %esi
  802757:	53                   	push   %ebx
  802758:	83 ec 1c             	sub    $0x1c,%esp
  80275b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80275f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802763:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802767:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80276b:	89 ca                	mov    %ecx,%edx
  80276d:	89 f8                	mov    %edi,%eax
  80276f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802773:	85 f6                	test   %esi,%esi
  802775:	75 2d                	jne    8027a4 <__udivdi3+0x50>
  802777:	39 cf                	cmp    %ecx,%edi
  802779:	77 65                	ja     8027e0 <__udivdi3+0x8c>
  80277b:	89 fd                	mov    %edi,%ebp
  80277d:	85 ff                	test   %edi,%edi
  80277f:	75 0b                	jne    80278c <__udivdi3+0x38>
  802781:	b8 01 00 00 00       	mov    $0x1,%eax
  802786:	31 d2                	xor    %edx,%edx
  802788:	f7 f7                	div    %edi
  80278a:	89 c5                	mov    %eax,%ebp
  80278c:	31 d2                	xor    %edx,%edx
  80278e:	89 c8                	mov    %ecx,%eax
  802790:	f7 f5                	div    %ebp
  802792:	89 c1                	mov    %eax,%ecx
  802794:	89 d8                	mov    %ebx,%eax
  802796:	f7 f5                	div    %ebp
  802798:	89 cf                	mov    %ecx,%edi
  80279a:	89 fa                	mov    %edi,%edx
  80279c:	83 c4 1c             	add    $0x1c,%esp
  80279f:	5b                   	pop    %ebx
  8027a0:	5e                   	pop    %esi
  8027a1:	5f                   	pop    %edi
  8027a2:	5d                   	pop    %ebp
  8027a3:	c3                   	ret    
  8027a4:	39 ce                	cmp    %ecx,%esi
  8027a6:	77 28                	ja     8027d0 <__udivdi3+0x7c>
  8027a8:	0f bd fe             	bsr    %esi,%edi
  8027ab:	83 f7 1f             	xor    $0x1f,%edi
  8027ae:	75 40                	jne    8027f0 <__udivdi3+0x9c>
  8027b0:	39 ce                	cmp    %ecx,%esi
  8027b2:	72 0a                	jb     8027be <__udivdi3+0x6a>
  8027b4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8027b8:	0f 87 9e 00 00 00    	ja     80285c <__udivdi3+0x108>
  8027be:	b8 01 00 00 00       	mov    $0x1,%eax
  8027c3:	89 fa                	mov    %edi,%edx
  8027c5:	83 c4 1c             	add    $0x1c,%esp
  8027c8:	5b                   	pop    %ebx
  8027c9:	5e                   	pop    %esi
  8027ca:	5f                   	pop    %edi
  8027cb:	5d                   	pop    %ebp
  8027cc:	c3                   	ret    
  8027cd:	8d 76 00             	lea    0x0(%esi),%esi
  8027d0:	31 ff                	xor    %edi,%edi
  8027d2:	31 c0                	xor    %eax,%eax
  8027d4:	89 fa                	mov    %edi,%edx
  8027d6:	83 c4 1c             	add    $0x1c,%esp
  8027d9:	5b                   	pop    %ebx
  8027da:	5e                   	pop    %esi
  8027db:	5f                   	pop    %edi
  8027dc:	5d                   	pop    %ebp
  8027dd:	c3                   	ret    
  8027de:	66 90                	xchg   %ax,%ax
  8027e0:	89 d8                	mov    %ebx,%eax
  8027e2:	f7 f7                	div    %edi
  8027e4:	31 ff                	xor    %edi,%edi
  8027e6:	89 fa                	mov    %edi,%edx
  8027e8:	83 c4 1c             	add    $0x1c,%esp
  8027eb:	5b                   	pop    %ebx
  8027ec:	5e                   	pop    %esi
  8027ed:	5f                   	pop    %edi
  8027ee:	5d                   	pop    %ebp
  8027ef:	c3                   	ret    
  8027f0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8027f5:	89 eb                	mov    %ebp,%ebx
  8027f7:	29 fb                	sub    %edi,%ebx
  8027f9:	89 f9                	mov    %edi,%ecx
  8027fb:	d3 e6                	shl    %cl,%esi
  8027fd:	89 c5                	mov    %eax,%ebp
  8027ff:	88 d9                	mov    %bl,%cl
  802801:	d3 ed                	shr    %cl,%ebp
  802803:	89 e9                	mov    %ebp,%ecx
  802805:	09 f1                	or     %esi,%ecx
  802807:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80280b:	89 f9                	mov    %edi,%ecx
  80280d:	d3 e0                	shl    %cl,%eax
  80280f:	89 c5                	mov    %eax,%ebp
  802811:	89 d6                	mov    %edx,%esi
  802813:	88 d9                	mov    %bl,%cl
  802815:	d3 ee                	shr    %cl,%esi
  802817:	89 f9                	mov    %edi,%ecx
  802819:	d3 e2                	shl    %cl,%edx
  80281b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80281f:	88 d9                	mov    %bl,%cl
  802821:	d3 e8                	shr    %cl,%eax
  802823:	09 c2                	or     %eax,%edx
  802825:	89 d0                	mov    %edx,%eax
  802827:	89 f2                	mov    %esi,%edx
  802829:	f7 74 24 0c          	divl   0xc(%esp)
  80282d:	89 d6                	mov    %edx,%esi
  80282f:	89 c3                	mov    %eax,%ebx
  802831:	f7 e5                	mul    %ebp
  802833:	39 d6                	cmp    %edx,%esi
  802835:	72 19                	jb     802850 <__udivdi3+0xfc>
  802837:	74 0b                	je     802844 <__udivdi3+0xf0>
  802839:	89 d8                	mov    %ebx,%eax
  80283b:	31 ff                	xor    %edi,%edi
  80283d:	e9 58 ff ff ff       	jmp    80279a <__udivdi3+0x46>
  802842:	66 90                	xchg   %ax,%ax
  802844:	8b 54 24 08          	mov    0x8(%esp),%edx
  802848:	89 f9                	mov    %edi,%ecx
  80284a:	d3 e2                	shl    %cl,%edx
  80284c:	39 c2                	cmp    %eax,%edx
  80284e:	73 e9                	jae    802839 <__udivdi3+0xe5>
  802850:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802853:	31 ff                	xor    %edi,%edi
  802855:	e9 40 ff ff ff       	jmp    80279a <__udivdi3+0x46>
  80285a:	66 90                	xchg   %ax,%ax
  80285c:	31 c0                	xor    %eax,%eax
  80285e:	e9 37 ff ff ff       	jmp    80279a <__udivdi3+0x46>
  802863:	90                   	nop

00802864 <__umoddi3>:
  802864:	55                   	push   %ebp
  802865:	57                   	push   %edi
  802866:	56                   	push   %esi
  802867:	53                   	push   %ebx
  802868:	83 ec 1c             	sub    $0x1c,%esp
  80286b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80286f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802873:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802877:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80287b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80287f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802883:	89 f3                	mov    %esi,%ebx
  802885:	89 fa                	mov    %edi,%edx
  802887:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80288b:	89 34 24             	mov    %esi,(%esp)
  80288e:	85 c0                	test   %eax,%eax
  802890:	75 1a                	jne    8028ac <__umoddi3+0x48>
  802892:	39 f7                	cmp    %esi,%edi
  802894:	0f 86 a2 00 00 00    	jbe    80293c <__umoddi3+0xd8>
  80289a:	89 c8                	mov    %ecx,%eax
  80289c:	89 f2                	mov    %esi,%edx
  80289e:	f7 f7                	div    %edi
  8028a0:	89 d0                	mov    %edx,%eax
  8028a2:	31 d2                	xor    %edx,%edx
  8028a4:	83 c4 1c             	add    $0x1c,%esp
  8028a7:	5b                   	pop    %ebx
  8028a8:	5e                   	pop    %esi
  8028a9:	5f                   	pop    %edi
  8028aa:	5d                   	pop    %ebp
  8028ab:	c3                   	ret    
  8028ac:	39 f0                	cmp    %esi,%eax
  8028ae:	0f 87 ac 00 00 00    	ja     802960 <__umoddi3+0xfc>
  8028b4:	0f bd e8             	bsr    %eax,%ebp
  8028b7:	83 f5 1f             	xor    $0x1f,%ebp
  8028ba:	0f 84 ac 00 00 00    	je     80296c <__umoddi3+0x108>
  8028c0:	bf 20 00 00 00       	mov    $0x20,%edi
  8028c5:	29 ef                	sub    %ebp,%edi
  8028c7:	89 fe                	mov    %edi,%esi
  8028c9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8028cd:	89 e9                	mov    %ebp,%ecx
  8028cf:	d3 e0                	shl    %cl,%eax
  8028d1:	89 d7                	mov    %edx,%edi
  8028d3:	89 f1                	mov    %esi,%ecx
  8028d5:	d3 ef                	shr    %cl,%edi
  8028d7:	09 c7                	or     %eax,%edi
  8028d9:	89 e9                	mov    %ebp,%ecx
  8028db:	d3 e2                	shl    %cl,%edx
  8028dd:	89 14 24             	mov    %edx,(%esp)
  8028e0:	89 d8                	mov    %ebx,%eax
  8028e2:	d3 e0                	shl    %cl,%eax
  8028e4:	89 c2                	mov    %eax,%edx
  8028e6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8028ea:	d3 e0                	shl    %cl,%eax
  8028ec:	89 44 24 04          	mov    %eax,0x4(%esp)
  8028f0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8028f4:	89 f1                	mov    %esi,%ecx
  8028f6:	d3 e8                	shr    %cl,%eax
  8028f8:	09 d0                	or     %edx,%eax
  8028fa:	d3 eb                	shr    %cl,%ebx
  8028fc:	89 da                	mov    %ebx,%edx
  8028fe:	f7 f7                	div    %edi
  802900:	89 d3                	mov    %edx,%ebx
  802902:	f7 24 24             	mull   (%esp)
  802905:	89 c6                	mov    %eax,%esi
  802907:	89 d1                	mov    %edx,%ecx
  802909:	39 d3                	cmp    %edx,%ebx
  80290b:	0f 82 87 00 00 00    	jb     802998 <__umoddi3+0x134>
  802911:	0f 84 91 00 00 00    	je     8029a8 <__umoddi3+0x144>
  802917:	8b 54 24 04          	mov    0x4(%esp),%edx
  80291b:	29 f2                	sub    %esi,%edx
  80291d:	19 cb                	sbb    %ecx,%ebx
  80291f:	89 d8                	mov    %ebx,%eax
  802921:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802925:	d3 e0                	shl    %cl,%eax
  802927:	89 e9                	mov    %ebp,%ecx
  802929:	d3 ea                	shr    %cl,%edx
  80292b:	09 d0                	or     %edx,%eax
  80292d:	89 e9                	mov    %ebp,%ecx
  80292f:	d3 eb                	shr    %cl,%ebx
  802931:	89 da                	mov    %ebx,%edx
  802933:	83 c4 1c             	add    $0x1c,%esp
  802936:	5b                   	pop    %ebx
  802937:	5e                   	pop    %esi
  802938:	5f                   	pop    %edi
  802939:	5d                   	pop    %ebp
  80293a:	c3                   	ret    
  80293b:	90                   	nop
  80293c:	89 fd                	mov    %edi,%ebp
  80293e:	85 ff                	test   %edi,%edi
  802940:	75 0b                	jne    80294d <__umoddi3+0xe9>
  802942:	b8 01 00 00 00       	mov    $0x1,%eax
  802947:	31 d2                	xor    %edx,%edx
  802949:	f7 f7                	div    %edi
  80294b:	89 c5                	mov    %eax,%ebp
  80294d:	89 f0                	mov    %esi,%eax
  80294f:	31 d2                	xor    %edx,%edx
  802951:	f7 f5                	div    %ebp
  802953:	89 c8                	mov    %ecx,%eax
  802955:	f7 f5                	div    %ebp
  802957:	89 d0                	mov    %edx,%eax
  802959:	e9 44 ff ff ff       	jmp    8028a2 <__umoddi3+0x3e>
  80295e:	66 90                	xchg   %ax,%ax
  802960:	89 c8                	mov    %ecx,%eax
  802962:	89 f2                	mov    %esi,%edx
  802964:	83 c4 1c             	add    $0x1c,%esp
  802967:	5b                   	pop    %ebx
  802968:	5e                   	pop    %esi
  802969:	5f                   	pop    %edi
  80296a:	5d                   	pop    %ebp
  80296b:	c3                   	ret    
  80296c:	3b 04 24             	cmp    (%esp),%eax
  80296f:	72 06                	jb     802977 <__umoddi3+0x113>
  802971:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802975:	77 0f                	ja     802986 <__umoddi3+0x122>
  802977:	89 f2                	mov    %esi,%edx
  802979:	29 f9                	sub    %edi,%ecx
  80297b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80297f:	89 14 24             	mov    %edx,(%esp)
  802982:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802986:	8b 44 24 04          	mov    0x4(%esp),%eax
  80298a:	8b 14 24             	mov    (%esp),%edx
  80298d:	83 c4 1c             	add    $0x1c,%esp
  802990:	5b                   	pop    %ebx
  802991:	5e                   	pop    %esi
  802992:	5f                   	pop    %edi
  802993:	5d                   	pop    %ebp
  802994:	c3                   	ret    
  802995:	8d 76 00             	lea    0x0(%esi),%esi
  802998:	2b 04 24             	sub    (%esp),%eax
  80299b:	19 fa                	sbb    %edi,%edx
  80299d:	89 d1                	mov    %edx,%ecx
  80299f:	89 c6                	mov    %eax,%esi
  8029a1:	e9 71 ff ff ff       	jmp    802917 <__umoddi3+0xb3>
  8029a6:	66 90                	xchg   %ax,%ax
  8029a8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8029ac:	72 ea                	jb     802998 <__umoddi3+0x134>
  8029ae:	89 d9                	mov    %ebx,%ecx
  8029b0:	e9 62 ff ff ff       	jmp    802917 <__umoddi3+0xb3>
