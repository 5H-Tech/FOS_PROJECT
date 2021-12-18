
obj/user/tst_mod_6:     file format elf32-i386


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
  800031:	e8 5e 05 00 00       	call   800594 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
///MAKE SURE PAGE_WS_MAX_SIZE = 4000
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	83 ec 64             	sub    $0x64,%esp
	int envID = sys_getenvid();
  80003f:	e8 30 1a 00 00       	call   801a74 <sys_getenvid>
  800044:	89 45 e8             	mov    %eax,-0x18(%ebp)
	cprintf("envID = %d\n",envID);
  800047:	83 ec 08             	sub    $0x8,%esp
  80004a:	ff 75 e8             	pushl  -0x18(%ebp)
  80004d:	68 c0 22 80 00       	push   $0x8022c0
  800052:	e8 24 09 00 00       	call   80097b <cprintf>
  800057:	83 c4 10             	add    $0x10,%esp

	int Mega = 1024*1024;
  80005a:	c7 45 e4 00 00 10 00 	movl   $0x100000,-0x1c(%ebp)
	int kilo = 1024;
  800061:	c7 45 e0 00 04 00 00 	movl   $0x400,-0x20(%ebp)

	//[0] Make sure there're available places in the WS
	int w = 0 ;
  800068:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int requiredNumOfEmptyWSLocs = 5;
  80006f:	c7 45 dc 05 00 00 00 	movl   $0x5,-0x24(%ebp)
	int numOfEmptyWSLocs = 0;
  800076:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	for (w = 0 ; w < myEnv->page_WS_max_size ; w++)
  80007d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800084:	eb 20                	jmp    8000a6 <_main+0x6e>
	{
		if( myEnv->__uptr_pws[w].empty == 1)
  800086:	a1 20 30 80 00       	mov    0x803020,%eax
  80008b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800091:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800094:	c1 e2 04             	shl    $0x4,%edx
  800097:	01 d0                	add    %edx,%eax
  800099:	8a 40 04             	mov    0x4(%eax),%al
  80009c:	3c 01                	cmp    $0x1,%al
  80009e:	75 03                	jne    8000a3 <_main+0x6b>
			numOfEmptyWSLocs++;
  8000a0:	ff 45 f0             	incl   -0x10(%ebp)

	//[0] Make sure there're available places in the WS
	int w = 0 ;
	int requiredNumOfEmptyWSLocs = 5;
	int numOfEmptyWSLocs = 0;
	for (w = 0 ; w < myEnv->page_WS_max_size ; w++)
  8000a3:	ff 45 f4             	incl   -0xc(%ebp)
  8000a6:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ab:	8b 50 74             	mov    0x74(%eax),%edx
  8000ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000b1:	39 c2                	cmp    %eax,%edx
  8000b3:	77 d1                	ja     800086 <_main+0x4e>
	{
		if( myEnv->__uptr_pws[w].empty == 1)
			numOfEmptyWSLocs++;
	}
	if ((numOfEmptyWSLocs == 0))
  8000b5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8000b9:	75 14                	jne    8000cf <_main+0x97>
			panic("InitialWSError1: No empty locations in WS! please increase its size to 8000 and try again!!!");
  8000bb:	83 ec 04             	sub    $0x4,%esp
  8000be:	68 cc 22 80 00       	push   $0x8022cc
  8000c3:	6a 16                	push   $0x16
  8000c5:	68 29 23 80 00       	push   $0x802329
  8000ca:	e8 0a 06 00 00       	call   8006d9 <_panic>
	else if (numOfEmptyWSLocs != requiredNumOfEmptyWSLocs)
  8000cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000d2:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8000d5:	74 26                	je     8000fd <_main+0xc5>
		panic("InitialWSError1: Wrong number of WS empty locations! please set its size to %d OR ASK your TA!!!", myEnv->page_WS_max_size + requiredNumOfEmptyWSLocs - numOfEmptyWSLocs);
  8000d7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000dc:	8b 50 74             	mov    0x74(%eax),%edx
  8000df:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8000e2:	01 c2                	add    %eax,%edx
  8000e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000e7:	29 c2                	sub    %eax,%edx
  8000e9:	89 d0                	mov    %edx,%eax
  8000eb:	50                   	push   %eax
  8000ec:	68 3c 23 80 00       	push   $0x80233c
  8000f1:	6a 18                	push   $0x18
  8000f3:	68 29 23 80 00       	push   $0x802329
  8000f8:	e8 dc 05 00 00       	call   8006d9 <_panic>


	int8 *x = (int8 *)0x80000000;
  8000fd:	c7 45 d8 00 00 00 80 	movl   $0x80000000,-0x28(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800104:	e8 d2 1a 00 00       	call   801bdb <sys_pf_calculate_allocated_pages>
  800109:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	{
		//allocate 9 kilo in the heap
		int freeFrames = sys_calculate_free_frames() ;
  80010c:	e8 47 1a 00 00       	call   801b58 <sys_calculate_free_frames>
  800111:	89 45 d0             	mov    %eax,-0x30(%ebp)
		//sys_allocateMem(0x80000000,9*kilo) ;
		assert((uint32)malloc(9*kilo) == 0x80000000);
  800114:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800117:	89 d0                	mov    %edx,%eax
  800119:	c1 e0 03             	shl    $0x3,%eax
  80011c:	01 d0                	add    %edx,%eax
  80011e:	83 ec 0c             	sub    $0xc,%esp
  800121:	50                   	push   %eax
  800122:	e8 de 15 00 00       	call   801705 <malloc>
  800127:	83 c4 10             	add    $0x10,%esp
  80012a:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  80012f:	74 16                	je     800147 <_main+0x10f>
  800131:	68 a0 23 80 00       	push   $0x8023a0
  800136:	68 c5 23 80 00       	push   $0x8023c5
  80013b:	6a 21                	push   $0x21
  80013d:	68 29 23 80 00       	push   $0x802329
  800142:	e8 92 05 00 00       	call   8006d9 <_panic>
		assert((freeFrames - sys_calculate_free_frames()) == (1+ 1 + ROUNDUP(9 * kilo, PAGE_SIZE) / PAGE_SIZE));
  800147:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  80014a:	e8 09 1a 00 00       	call   801b58 <sys_calculate_free_frames>
  80014f:	29 c3                	sub    %eax,%ebx
  800151:	89 d9                	mov    %ebx,%ecx
  800153:	c7 45 cc 00 10 00 00 	movl   $0x1000,-0x34(%ebp)
  80015a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80015d:	89 d0                	mov    %edx,%eax
  80015f:	c1 e0 03             	shl    $0x3,%eax
  800162:	01 d0                	add    %edx,%eax
  800164:	89 c2                	mov    %eax,%edx
  800166:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800169:	01 d0                	add    %edx,%eax
  80016b:	48                   	dec    %eax
  80016c:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80016f:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800172:	ba 00 00 00 00       	mov    $0x0,%edx
  800177:	f7 75 cc             	divl   -0x34(%ebp)
  80017a:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80017d:	29 d0                	sub    %edx,%eax
  80017f:	85 c0                	test   %eax,%eax
  800181:	79 05                	jns    800188 <_main+0x150>
  800183:	05 ff 0f 00 00       	add    $0xfff,%eax
  800188:	c1 f8 0c             	sar    $0xc,%eax
  80018b:	83 c0 02             	add    $0x2,%eax
  80018e:	39 c1                	cmp    %eax,%ecx
  800190:	74 16                	je     8001a8 <_main+0x170>
  800192:	68 dc 23 80 00       	push   $0x8023dc
  800197:	68 c5 23 80 00       	push   $0x8023c5
  80019c:	6a 22                	push   $0x22
  80019e:	68 29 23 80 00       	push   $0x802329
  8001a3:	e8 31 05 00 00       	call   8006d9 <_panic>

		//allocate 2 MB in the heap
		freeFrames = sys_calculate_free_frames() ;
  8001a8:	e8 ab 19 00 00       	call   801b58 <sys_calculate_free_frames>
  8001ad:	89 45 d0             	mov    %eax,-0x30(%ebp)
		//sys_allocateMem(0x80003000,2*Mega) ;
		assert((uint32)malloc(2*Mega) == 0x80003000);
  8001b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001b3:	01 c0                	add    %eax,%eax
  8001b5:	83 ec 0c             	sub    $0xc,%esp
  8001b8:	50                   	push   %eax
  8001b9:	e8 47 15 00 00       	call   801705 <malloc>
  8001be:	83 c4 10             	add    $0x10,%esp
  8001c1:	3d 00 30 00 80       	cmp    $0x80003000,%eax
  8001c6:	74 16                	je     8001de <_main+0x1a6>
  8001c8:	68 3c 24 80 00       	push   $0x80243c
  8001cd:	68 c5 23 80 00       	push   $0x8023c5
  8001d2:	6a 27                	push   $0x27
  8001d4:	68 29 23 80 00       	push   $0x802329
  8001d9:	e8 fb 04 00 00       	call   8006d9 <_panic>
		assert((freeFrames - sys_calculate_free_frames()) == 2);
  8001de:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  8001e1:	e8 72 19 00 00       	call   801b58 <sys_calculate_free_frames>
  8001e6:	29 c3                	sub    %eax,%ebx
  8001e8:	89 d8                	mov    %ebx,%eax
  8001ea:	83 f8 02             	cmp    $0x2,%eax
  8001ed:	74 16                	je     800205 <_main+0x1cd>
  8001ef:	68 64 24 80 00       	push   $0x802464
  8001f4:	68 c5 23 80 00       	push   $0x8023c5
  8001f9:	6a 28                	push   $0x28
  8001fb:	68 29 23 80 00       	push   $0x802329
  800200:	e8 d4 04 00 00       	call   8006d9 <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800205:	e8 4e 19 00 00       	call   801b58 <sys_calculate_free_frames>
  80020a:	89 45 d0             	mov    %eax,-0x30(%ebp)
		//sys_allocateMem(0x80203000,3*Mega) ;
		assert((uint32)malloc(3*Mega) == 0x80203000);
  80020d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800210:	89 c2                	mov    %eax,%edx
  800212:	01 d2                	add    %edx,%edx
  800214:	01 d0                	add    %edx,%eax
  800216:	83 ec 0c             	sub    $0xc,%esp
  800219:	50                   	push   %eax
  80021a:	e8 e6 14 00 00       	call   801705 <malloc>
  80021f:	83 c4 10             	add    $0x10,%esp
  800222:	3d 00 30 20 80       	cmp    $0x80203000,%eax
  800227:	74 16                	je     80023f <_main+0x207>
  800229:	68 94 24 80 00       	push   $0x802494
  80022e:	68 c5 23 80 00       	push   $0x8023c5
  800233:	6a 2c                	push   $0x2c
  800235:	68 29 23 80 00       	push   $0x802329
  80023a:	e8 9a 04 00 00       	call   8006d9 <_panic>
		assert((freeFrames - sys_calculate_free_frames()) == 1);
  80023f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  800242:	e8 11 19 00 00       	call   801b58 <sys_calculate_free_frames>
  800247:	29 c3                	sub    %eax,%ebx
  800249:	89 d8                	mov    %ebx,%eax
  80024b:	83 f8 01             	cmp    $0x1,%eax
  80024e:	74 16                	je     800266 <_main+0x22e>
  800250:	68 bc 24 80 00       	push   $0x8024bc
  800255:	68 c5 23 80 00       	push   $0x8023c5
  80025a:	6a 2d                	push   $0x2d
  80025c:	68 29 23 80 00       	push   $0x802329
  800261:	e8 73 04 00 00       	call   8006d9 <_panic>

	}
	//cprintf("Allocated Disk pages = %d\n",sys_pf_calculate_allocated_pages() - usedDiskPages) ;
	assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 768+512+3);
  800266:	e8 70 19 00 00       	call   801bdb <sys_pf_calculate_allocated_pages>
  80026b:	2b 45 d4             	sub    -0x2c(%ebp),%eax
  80026e:	3d 03 05 00 00       	cmp    $0x503,%eax
  800273:	74 16                	je     80028b <_main+0x253>
  800275:	68 ec 24 80 00       	push   $0x8024ec
  80027a:	68 c5 23 80 00       	push   $0x8023c5
  80027f:	6a 31                	push   $0x31
  800281:	68 29 23 80 00       	push   $0x802329
  800286:	e8 4e 04 00 00       	call   8006d9 <_panic>

	///====================


	int freeFrames = sys_calculate_free_frames() ;
  80028b:	e8 c8 18 00 00       	call   801b58 <sys_calculate_free_frames>
  800290:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	{
		x[0] = -1 ;
  800293:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800296:	c6 00 ff             	movb   $0xff,(%eax)
		x[4*kilo] = -1 ;
  800299:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80029c:	c1 e0 02             	shl    $0x2,%eax
  80029f:	89 c2                	mov    %eax,%edx
  8002a1:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8002a4:	01 d0                	add    %edx,%eax
  8002a6:	c6 00 ff             	movb   $0xff,(%eax)
		x[8*kilo] = -1 ;
  8002a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002ac:	c1 e0 03             	shl    $0x3,%eax
  8002af:	89 c2                	mov    %eax,%edx
  8002b1:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8002b4:	01 d0                	add    %edx,%eax
  8002b6:	c6 00 ff             	movb   $0xff,(%eax)
		x[12*kilo] = -1 ;
  8002b9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8002bc:	89 d0                	mov    %edx,%eax
  8002be:	01 c0                	add    %eax,%eax
  8002c0:	01 d0                	add    %edx,%eax
  8002c2:	c1 e0 02             	shl    $0x2,%eax
  8002c5:	89 c2                	mov    %eax,%edx
  8002c7:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8002ca:	01 d0                	add    %edx,%eax
  8002cc:	c6 00 ff             	movb   $0xff,(%eax)
		x[16*kilo] = -1 ;
  8002cf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002d2:	c1 e0 04             	shl    $0x4,%eax
  8002d5:	89 c2                	mov    %eax,%edx
  8002d7:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8002da:	01 d0                	add    %edx,%eax
  8002dc:	c6 00 ff             	movb   $0xff,(%eax)
	}

	assert(x[0] == -1 );
  8002df:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8002e2:	8a 00                	mov    (%eax),%al
  8002e4:	3c ff                	cmp    $0xff,%al
  8002e6:	74 16                	je     8002fe <_main+0x2c6>
  8002e8:	68 2e 25 80 00       	push   $0x80252e
  8002ed:	68 c5 23 80 00       	push   $0x8023c5
  8002f2:	6a 3f                	push   $0x3f
  8002f4:	68 29 23 80 00       	push   $0x802329
  8002f9:	e8 db 03 00 00       	call   8006d9 <_panic>
	assert(x[4*kilo] == -1 );
  8002fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800301:	c1 e0 02             	shl    $0x2,%eax
  800304:	89 c2                	mov    %eax,%edx
  800306:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800309:	01 d0                	add    %edx,%eax
  80030b:	8a 00                	mov    (%eax),%al
  80030d:	3c ff                	cmp    $0xff,%al
  80030f:	74 16                	je     800327 <_main+0x2ef>
  800311:	68 39 25 80 00       	push   $0x802539
  800316:	68 c5 23 80 00       	push   $0x8023c5
  80031b:	6a 40                	push   $0x40
  80031d:	68 29 23 80 00       	push   $0x802329
  800322:	e8 b2 03 00 00       	call   8006d9 <_panic>
	assert(x[8*kilo] == -1 );
  800327:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80032a:	c1 e0 03             	shl    $0x3,%eax
  80032d:	89 c2                	mov    %eax,%edx
  80032f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800332:	01 d0                	add    %edx,%eax
  800334:	8a 00                	mov    (%eax),%al
  800336:	3c ff                	cmp    $0xff,%al
  800338:	74 16                	je     800350 <_main+0x318>
  80033a:	68 49 25 80 00       	push   $0x802549
  80033f:	68 c5 23 80 00       	push   $0x8023c5
  800344:	6a 41                	push   $0x41
  800346:	68 29 23 80 00       	push   $0x802329
  80034b:	e8 89 03 00 00       	call   8006d9 <_panic>
	assert(x[12*kilo] == -1 );
  800350:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800353:	89 d0                	mov    %edx,%eax
  800355:	01 c0                	add    %eax,%eax
  800357:	01 d0                	add    %edx,%eax
  800359:	c1 e0 02             	shl    $0x2,%eax
  80035c:	89 c2                	mov    %eax,%edx
  80035e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800361:	01 d0                	add    %edx,%eax
  800363:	8a 00                	mov    (%eax),%al
  800365:	3c ff                	cmp    $0xff,%al
  800367:	74 16                	je     80037f <_main+0x347>
  800369:	68 59 25 80 00       	push   $0x802559
  80036e:	68 c5 23 80 00       	push   $0x8023c5
  800373:	6a 42                	push   $0x42
  800375:	68 29 23 80 00       	push   $0x802329
  80037a:	e8 5a 03 00 00       	call   8006d9 <_panic>
	assert(x[16*kilo] == -1 );
  80037f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800382:	c1 e0 04             	shl    $0x4,%eax
  800385:	89 c2                	mov    %eax,%edx
  800387:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80038a:	01 d0                	add    %edx,%eax
  80038c:	8a 00                	mov    (%eax),%al
  80038e:	3c ff                	cmp    $0xff,%al
  800390:	74 16                	je     8003a8 <_main+0x370>
  800392:	68 6a 25 80 00       	push   $0x80256a
  800397:	68 c5 23 80 00       	push   $0x8023c5
  80039c:	6a 43                	push   $0x43
  80039e:	68 29 23 80 00       	push   $0x802329
  8003a3:	e8 31 03 00 00       	call   8006d9 <_panic>

	assert((freeFrames - sys_calculate_free_frames()) == 0 );
  8003a8:	e8 ab 17 00 00       	call   801b58 <sys_calculate_free_frames>
  8003ad:	89 c2                	mov    %eax,%edx
  8003af:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8003b2:	39 c2                	cmp    %eax,%edx
  8003b4:	74 16                	je     8003cc <_main+0x394>
  8003b6:	68 7c 25 80 00       	push   $0x80257c
  8003bb:	68 c5 23 80 00       	push   $0x8023c5
  8003c0:	6a 45                	push   $0x45
  8003c2:	68 29 23 80 00       	push   $0x802329
  8003c7:	e8 0d 03 00 00       	call   8006d9 <_panic>

	int found = 0;
  8003cc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	for (w = 0 ; w < myEnv->page_WS_max_size; w++)
  8003d3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8003da:	e9 72 01 00 00       	jmp    800551 <_main+0x519>
	{
		if( myEnv->__uptr_pws[w].empty == 1)
  8003df:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e4:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8003ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003ed:	c1 e2 04             	shl    $0x4,%edx
  8003f0:	01 d0                	add    %edx,%eax
  8003f2:	8a 40 04             	mov    0x4(%eax),%al
  8003f5:	3c 01                	cmp    $0x1,%al
  8003f7:	75 14                	jne    80040d <_main+0x3d5>
			panic("Allocated pages are not placed correctly in the WS");
  8003f9:	83 ec 04             	sub    $0x4,%esp
  8003fc:	68 ac 25 80 00       	push   $0x8025ac
  800401:	6a 4b                	push   $0x4b
  800403:	68 29 23 80 00       	push   $0x802329
  800408:	e8 cc 02 00 00       	call   8006d9 <_panic>

		if(ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(x[0])), PAGE_SIZE)) found++;
  80040d:	a1 20 30 80 00       	mov    0x803020,%eax
  800412:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800418:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80041b:	c1 e2 04             	shl    $0x4,%edx
  80041e:	01 d0                	add    %edx,%eax
  800420:	8b 00                	mov    (%eax),%eax
  800422:	89 45 c0             	mov    %eax,-0x40(%ebp)
  800425:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800428:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80042d:	89 c2                	mov    %eax,%edx
  80042f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800432:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800435:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800438:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80043d:	39 c2                	cmp    %eax,%edx
  80043f:	75 03                	jne    800444 <_main+0x40c>
  800441:	ff 45 ec             	incl   -0x14(%ebp)
		if(ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(x[4*kilo])), PAGE_SIZE)) found++;
  800444:	a1 20 30 80 00       	mov    0x803020,%eax
  800449:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80044f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800452:	c1 e2 04             	shl    $0x4,%edx
  800455:	01 d0                	add    %edx,%eax
  800457:	8b 00                	mov    (%eax),%eax
  800459:	89 45 b8             	mov    %eax,-0x48(%ebp)
  80045c:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80045f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800464:	89 c2                	mov    %eax,%edx
  800466:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800469:	c1 e0 02             	shl    $0x2,%eax
  80046c:	89 c1                	mov    %eax,%ecx
  80046e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800471:	01 c8                	add    %ecx,%eax
  800473:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  800476:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800479:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80047e:	39 c2                	cmp    %eax,%edx
  800480:	75 03                	jne    800485 <_main+0x44d>
  800482:	ff 45 ec             	incl   -0x14(%ebp)
		if(ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(x[8*kilo])), PAGE_SIZE)) found++;
  800485:	a1 20 30 80 00       	mov    0x803020,%eax
  80048a:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800490:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800493:	c1 e2 04             	shl    $0x4,%edx
  800496:	01 d0                	add    %edx,%eax
  800498:	8b 00                	mov    (%eax),%eax
  80049a:	89 45 b0             	mov    %eax,-0x50(%ebp)
  80049d:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8004a0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004a5:	89 c2                	mov    %eax,%edx
  8004a7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8004aa:	c1 e0 03             	shl    $0x3,%eax
  8004ad:	89 c1                	mov    %eax,%ecx
  8004af:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8004b2:	01 c8                	add    %ecx,%eax
  8004b4:	89 45 ac             	mov    %eax,-0x54(%ebp)
  8004b7:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8004ba:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004bf:	39 c2                	cmp    %eax,%edx
  8004c1:	75 03                	jne    8004c6 <_main+0x48e>
  8004c3:	ff 45 ec             	incl   -0x14(%ebp)
		if(ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(x[12*kilo])), PAGE_SIZE)) found++;
  8004c6:	a1 20 30 80 00       	mov    0x803020,%eax
  8004cb:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8004d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8004d4:	c1 e2 04             	shl    $0x4,%edx
  8004d7:	01 d0                	add    %edx,%eax
  8004d9:	8b 00                	mov    (%eax),%eax
  8004db:	89 45 a8             	mov    %eax,-0x58(%ebp)
  8004de:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8004e1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004e6:	89 c1                	mov    %eax,%ecx
  8004e8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004eb:	89 d0                	mov    %edx,%eax
  8004ed:	01 c0                	add    %eax,%eax
  8004ef:	01 d0                	add    %edx,%eax
  8004f1:	c1 e0 02             	shl    $0x2,%eax
  8004f4:	89 c2                	mov    %eax,%edx
  8004f6:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8004f9:	01 d0                	add    %edx,%eax
  8004fb:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  8004fe:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800501:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800506:	39 c1                	cmp    %eax,%ecx
  800508:	75 03                	jne    80050d <_main+0x4d5>
  80050a:	ff 45 ec             	incl   -0x14(%ebp)
		if(ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(x[16*kilo])), PAGE_SIZE)) found++;
  80050d:	a1 20 30 80 00       	mov    0x803020,%eax
  800512:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800518:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80051b:	c1 e2 04             	shl    $0x4,%edx
  80051e:	01 d0                	add    %edx,%eax
  800520:	8b 00                	mov    (%eax),%eax
  800522:	89 45 a0             	mov    %eax,-0x60(%ebp)
  800525:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800528:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80052d:	89 c2                	mov    %eax,%edx
  80052f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800532:	c1 e0 04             	shl    $0x4,%eax
  800535:	89 c1                	mov    %eax,%ecx
  800537:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80053a:	01 c8                	add    %ecx,%eax
  80053c:	89 45 9c             	mov    %eax,-0x64(%ebp)
  80053f:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800542:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800547:	39 c2                	cmp    %eax,%edx
  800549:	75 03                	jne    80054e <_main+0x516>
  80054b:	ff 45 ec             	incl   -0x14(%ebp)
	assert(x[16*kilo] == -1 );

	assert((freeFrames - sys_calculate_free_frames()) == 0 );

	int found = 0;
	for (w = 0 ; w < myEnv->page_WS_max_size; w++)
  80054e:	ff 45 f4             	incl   -0xc(%ebp)
  800551:	a1 20 30 80 00       	mov    0x803020,%eax
  800556:	8b 50 74             	mov    0x74(%eax),%edx
  800559:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80055c:	39 c2                	cmp    %eax,%edx
  80055e:	0f 87 7b fe ff ff    	ja     8003df <_main+0x3a7>
		if(ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(x[8*kilo])), PAGE_SIZE)) found++;
		if(ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(x[12*kilo])), PAGE_SIZE)) found++;
		if(ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(x[16*kilo])), PAGE_SIZE)) found++;
	}

	if (found != 5) panic("malloc: page is not added correctly to WS");
  800564:	83 7d ec 05          	cmpl   $0x5,-0x14(%ebp)
  800568:	74 14                	je     80057e <_main+0x546>
  80056a:	83 ec 04             	sub    $0x4,%esp
  80056d:	68 e0 25 80 00       	push   $0x8025e0
  800572:	6a 54                	push   $0x54
  800574:	68 29 23 80 00       	push   $0x802329
  800579:	e8 5b 01 00 00       	call   8006d9 <_panic>

	cprintf("Congratulations!! your modification is completed successfully.\n");
  80057e:	83 ec 0c             	sub    $0xc,%esp
  800581:	68 0c 26 80 00       	push   $0x80260c
  800586:	e8 f0 03 00 00       	call   80097b <cprintf>
  80058b:	83 c4 10             	add    $0x10,%esp

	return;
  80058e:	90                   	nop
}
  80058f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800592:	c9                   	leave  
  800593:	c3                   	ret    

00800594 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800594:	55                   	push   %ebp
  800595:	89 e5                	mov    %esp,%ebp
  800597:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80059a:	e8 ee 14 00 00       	call   801a8d <sys_getenvindex>
  80059f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005a5:	89 d0                	mov    %edx,%eax
  8005a7:	c1 e0 03             	shl    $0x3,%eax
  8005aa:	01 d0                	add    %edx,%eax
  8005ac:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8005b3:	01 c8                	add    %ecx,%eax
  8005b5:	01 c0                	add    %eax,%eax
  8005b7:	01 d0                	add    %edx,%eax
  8005b9:	01 c0                	add    %eax,%eax
  8005bb:	01 d0                	add    %edx,%eax
  8005bd:	89 c2                	mov    %eax,%edx
  8005bf:	c1 e2 05             	shl    $0x5,%edx
  8005c2:	29 c2                	sub    %eax,%edx
  8005c4:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8005cb:	89 c2                	mov    %eax,%edx
  8005cd:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8005d3:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005d8:	a1 20 30 80 00       	mov    0x803020,%eax
  8005dd:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8005e3:	84 c0                	test   %al,%al
  8005e5:	74 0f                	je     8005f6 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8005e7:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ec:	05 40 3c 01 00       	add    $0x13c40,%eax
  8005f1:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8005f6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8005fa:	7e 0a                	jle    800606 <libmain+0x72>
		binaryname = argv[0];
  8005fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005ff:	8b 00                	mov    (%eax),%eax
  800601:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800606:	83 ec 08             	sub    $0x8,%esp
  800609:	ff 75 0c             	pushl  0xc(%ebp)
  80060c:	ff 75 08             	pushl  0x8(%ebp)
  80060f:	e8 24 fa ff ff       	call   800038 <_main>
  800614:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800617:	e8 0c 16 00 00       	call   801c28 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80061c:	83 ec 0c             	sub    $0xc,%esp
  80061f:	68 64 26 80 00       	push   $0x802664
  800624:	e8 52 03 00 00       	call   80097b <cprintf>
  800629:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80062c:	a1 20 30 80 00       	mov    0x803020,%eax
  800631:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800637:	a1 20 30 80 00       	mov    0x803020,%eax
  80063c:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800642:	83 ec 04             	sub    $0x4,%esp
  800645:	52                   	push   %edx
  800646:	50                   	push   %eax
  800647:	68 8c 26 80 00       	push   $0x80268c
  80064c:	e8 2a 03 00 00       	call   80097b <cprintf>
  800651:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800654:	a1 20 30 80 00       	mov    0x803020,%eax
  800659:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80065f:	a1 20 30 80 00       	mov    0x803020,%eax
  800664:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80066a:	83 ec 04             	sub    $0x4,%esp
  80066d:	52                   	push   %edx
  80066e:	50                   	push   %eax
  80066f:	68 b4 26 80 00       	push   $0x8026b4
  800674:	e8 02 03 00 00       	call   80097b <cprintf>
  800679:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80067c:	a1 20 30 80 00       	mov    0x803020,%eax
  800681:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800687:	83 ec 08             	sub    $0x8,%esp
  80068a:	50                   	push   %eax
  80068b:	68 f5 26 80 00       	push   $0x8026f5
  800690:	e8 e6 02 00 00       	call   80097b <cprintf>
  800695:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800698:	83 ec 0c             	sub    $0xc,%esp
  80069b:	68 64 26 80 00       	push   $0x802664
  8006a0:	e8 d6 02 00 00       	call   80097b <cprintf>
  8006a5:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006a8:	e8 95 15 00 00       	call   801c42 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006ad:	e8 19 00 00 00       	call   8006cb <exit>
}
  8006b2:	90                   	nop
  8006b3:	c9                   	leave  
  8006b4:	c3                   	ret    

008006b5 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006b5:	55                   	push   %ebp
  8006b6:	89 e5                	mov    %esp,%ebp
  8006b8:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006bb:	83 ec 0c             	sub    $0xc,%esp
  8006be:	6a 00                	push   $0x0
  8006c0:	e8 94 13 00 00       	call   801a59 <sys_env_destroy>
  8006c5:	83 c4 10             	add    $0x10,%esp
}
  8006c8:	90                   	nop
  8006c9:	c9                   	leave  
  8006ca:	c3                   	ret    

008006cb <exit>:

void
exit(void)
{
  8006cb:	55                   	push   %ebp
  8006cc:	89 e5                	mov    %esp,%ebp
  8006ce:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006d1:	e8 e9 13 00 00       	call   801abf <sys_env_exit>
}
  8006d6:	90                   	nop
  8006d7:	c9                   	leave  
  8006d8:	c3                   	ret    

008006d9 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006d9:	55                   	push   %ebp
  8006da:	89 e5                	mov    %esp,%ebp
  8006dc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006df:	8d 45 10             	lea    0x10(%ebp),%eax
  8006e2:	83 c0 04             	add    $0x4,%eax
  8006e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006e8:	a1 18 31 80 00       	mov    0x803118,%eax
  8006ed:	85 c0                	test   %eax,%eax
  8006ef:	74 16                	je     800707 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006f1:	a1 18 31 80 00       	mov    0x803118,%eax
  8006f6:	83 ec 08             	sub    $0x8,%esp
  8006f9:	50                   	push   %eax
  8006fa:	68 0c 27 80 00       	push   $0x80270c
  8006ff:	e8 77 02 00 00       	call   80097b <cprintf>
  800704:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800707:	a1 00 30 80 00       	mov    0x803000,%eax
  80070c:	ff 75 0c             	pushl  0xc(%ebp)
  80070f:	ff 75 08             	pushl  0x8(%ebp)
  800712:	50                   	push   %eax
  800713:	68 11 27 80 00       	push   $0x802711
  800718:	e8 5e 02 00 00       	call   80097b <cprintf>
  80071d:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800720:	8b 45 10             	mov    0x10(%ebp),%eax
  800723:	83 ec 08             	sub    $0x8,%esp
  800726:	ff 75 f4             	pushl  -0xc(%ebp)
  800729:	50                   	push   %eax
  80072a:	e8 e1 01 00 00       	call   800910 <vcprintf>
  80072f:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800732:	83 ec 08             	sub    $0x8,%esp
  800735:	6a 00                	push   $0x0
  800737:	68 2d 27 80 00       	push   $0x80272d
  80073c:	e8 cf 01 00 00       	call   800910 <vcprintf>
  800741:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800744:	e8 82 ff ff ff       	call   8006cb <exit>

	// should not return here
	while (1) ;
  800749:	eb fe                	jmp    800749 <_panic+0x70>

0080074b <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80074b:	55                   	push   %ebp
  80074c:	89 e5                	mov    %esp,%ebp
  80074e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800751:	a1 20 30 80 00       	mov    0x803020,%eax
  800756:	8b 50 74             	mov    0x74(%eax),%edx
  800759:	8b 45 0c             	mov    0xc(%ebp),%eax
  80075c:	39 c2                	cmp    %eax,%edx
  80075e:	74 14                	je     800774 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800760:	83 ec 04             	sub    $0x4,%esp
  800763:	68 30 27 80 00       	push   $0x802730
  800768:	6a 26                	push   $0x26
  80076a:	68 7c 27 80 00       	push   $0x80277c
  80076f:	e8 65 ff ff ff       	call   8006d9 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800774:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80077b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800782:	e9 b6 00 00 00       	jmp    80083d <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800787:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80078a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800791:	8b 45 08             	mov    0x8(%ebp),%eax
  800794:	01 d0                	add    %edx,%eax
  800796:	8b 00                	mov    (%eax),%eax
  800798:	85 c0                	test   %eax,%eax
  80079a:	75 08                	jne    8007a4 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80079c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80079f:	e9 96 00 00 00       	jmp    80083a <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8007a4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007ab:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007b2:	eb 5d                	jmp    800811 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007b4:	a1 20 30 80 00       	mov    0x803020,%eax
  8007b9:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007bf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007c2:	c1 e2 04             	shl    $0x4,%edx
  8007c5:	01 d0                	add    %edx,%eax
  8007c7:	8a 40 04             	mov    0x4(%eax),%al
  8007ca:	84 c0                	test   %al,%al
  8007cc:	75 40                	jne    80080e <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007ce:	a1 20 30 80 00       	mov    0x803020,%eax
  8007d3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007d9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007dc:	c1 e2 04             	shl    $0x4,%edx
  8007df:	01 d0                	add    %edx,%eax
  8007e1:	8b 00                	mov    (%eax),%eax
  8007e3:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007e6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007e9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007ee:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8007f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007f3:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8007fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8007fd:	01 c8                	add    %ecx,%eax
  8007ff:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800801:	39 c2                	cmp    %eax,%edx
  800803:	75 09                	jne    80080e <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800805:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80080c:	eb 12                	jmp    800820 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80080e:	ff 45 e8             	incl   -0x18(%ebp)
  800811:	a1 20 30 80 00       	mov    0x803020,%eax
  800816:	8b 50 74             	mov    0x74(%eax),%edx
  800819:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80081c:	39 c2                	cmp    %eax,%edx
  80081e:	77 94                	ja     8007b4 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800820:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800824:	75 14                	jne    80083a <CheckWSWithoutLastIndex+0xef>
			panic(
  800826:	83 ec 04             	sub    $0x4,%esp
  800829:	68 88 27 80 00       	push   $0x802788
  80082e:	6a 3a                	push   $0x3a
  800830:	68 7c 27 80 00       	push   $0x80277c
  800835:	e8 9f fe ff ff       	call   8006d9 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80083a:	ff 45 f0             	incl   -0x10(%ebp)
  80083d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800840:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800843:	0f 8c 3e ff ff ff    	jl     800787 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800849:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800850:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800857:	eb 20                	jmp    800879 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800859:	a1 20 30 80 00       	mov    0x803020,%eax
  80085e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800864:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800867:	c1 e2 04             	shl    $0x4,%edx
  80086a:	01 d0                	add    %edx,%eax
  80086c:	8a 40 04             	mov    0x4(%eax),%al
  80086f:	3c 01                	cmp    $0x1,%al
  800871:	75 03                	jne    800876 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800873:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800876:	ff 45 e0             	incl   -0x20(%ebp)
  800879:	a1 20 30 80 00       	mov    0x803020,%eax
  80087e:	8b 50 74             	mov    0x74(%eax),%edx
  800881:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800884:	39 c2                	cmp    %eax,%edx
  800886:	77 d1                	ja     800859 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800888:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80088b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80088e:	74 14                	je     8008a4 <CheckWSWithoutLastIndex+0x159>
		panic(
  800890:	83 ec 04             	sub    $0x4,%esp
  800893:	68 dc 27 80 00       	push   $0x8027dc
  800898:	6a 44                	push   $0x44
  80089a:	68 7c 27 80 00       	push   $0x80277c
  80089f:	e8 35 fe ff ff       	call   8006d9 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008a4:	90                   	nop
  8008a5:	c9                   	leave  
  8008a6:	c3                   	ret    

008008a7 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008a7:	55                   	push   %ebp
  8008a8:	89 e5                	mov    %esp,%ebp
  8008aa:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b0:	8b 00                	mov    (%eax),%eax
  8008b2:	8d 48 01             	lea    0x1(%eax),%ecx
  8008b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008b8:	89 0a                	mov    %ecx,(%edx)
  8008ba:	8b 55 08             	mov    0x8(%ebp),%edx
  8008bd:	88 d1                	mov    %dl,%cl
  8008bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008c2:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c9:	8b 00                	mov    (%eax),%eax
  8008cb:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008d0:	75 2c                	jne    8008fe <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008d2:	a0 24 30 80 00       	mov    0x803024,%al
  8008d7:	0f b6 c0             	movzbl %al,%eax
  8008da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008dd:	8b 12                	mov    (%edx),%edx
  8008df:	89 d1                	mov    %edx,%ecx
  8008e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008e4:	83 c2 08             	add    $0x8,%edx
  8008e7:	83 ec 04             	sub    $0x4,%esp
  8008ea:	50                   	push   %eax
  8008eb:	51                   	push   %ecx
  8008ec:	52                   	push   %edx
  8008ed:	e8 25 11 00 00       	call   801a17 <sys_cputs>
  8008f2:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8008f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8008fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800901:	8b 40 04             	mov    0x4(%eax),%eax
  800904:	8d 50 01             	lea    0x1(%eax),%edx
  800907:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090a:	89 50 04             	mov    %edx,0x4(%eax)
}
  80090d:	90                   	nop
  80090e:	c9                   	leave  
  80090f:	c3                   	ret    

00800910 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800910:	55                   	push   %ebp
  800911:	89 e5                	mov    %esp,%ebp
  800913:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800919:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800920:	00 00 00 
	b.cnt = 0;
  800923:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80092a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80092d:	ff 75 0c             	pushl  0xc(%ebp)
  800930:	ff 75 08             	pushl  0x8(%ebp)
  800933:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800939:	50                   	push   %eax
  80093a:	68 a7 08 80 00       	push   $0x8008a7
  80093f:	e8 11 02 00 00       	call   800b55 <vprintfmt>
  800944:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800947:	a0 24 30 80 00       	mov    0x803024,%al
  80094c:	0f b6 c0             	movzbl %al,%eax
  80094f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800955:	83 ec 04             	sub    $0x4,%esp
  800958:	50                   	push   %eax
  800959:	52                   	push   %edx
  80095a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800960:	83 c0 08             	add    $0x8,%eax
  800963:	50                   	push   %eax
  800964:	e8 ae 10 00 00       	call   801a17 <sys_cputs>
  800969:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80096c:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800973:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800979:	c9                   	leave  
  80097a:	c3                   	ret    

0080097b <cprintf>:

int cprintf(const char *fmt, ...) {
  80097b:	55                   	push   %ebp
  80097c:	89 e5                	mov    %esp,%ebp
  80097e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800981:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800988:	8d 45 0c             	lea    0xc(%ebp),%eax
  80098b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80098e:	8b 45 08             	mov    0x8(%ebp),%eax
  800991:	83 ec 08             	sub    $0x8,%esp
  800994:	ff 75 f4             	pushl  -0xc(%ebp)
  800997:	50                   	push   %eax
  800998:	e8 73 ff ff ff       	call   800910 <vcprintf>
  80099d:	83 c4 10             	add    $0x10,%esp
  8009a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009a6:	c9                   	leave  
  8009a7:	c3                   	ret    

008009a8 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009a8:	55                   	push   %ebp
  8009a9:	89 e5                	mov    %esp,%ebp
  8009ab:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009ae:	e8 75 12 00 00       	call   801c28 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009b3:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bc:	83 ec 08             	sub    $0x8,%esp
  8009bf:	ff 75 f4             	pushl  -0xc(%ebp)
  8009c2:	50                   	push   %eax
  8009c3:	e8 48 ff ff ff       	call   800910 <vcprintf>
  8009c8:	83 c4 10             	add    $0x10,%esp
  8009cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009ce:	e8 6f 12 00 00       	call   801c42 <sys_enable_interrupt>
	return cnt;
  8009d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009d6:	c9                   	leave  
  8009d7:	c3                   	ret    

008009d8 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009d8:	55                   	push   %ebp
  8009d9:	89 e5                	mov    %esp,%ebp
  8009db:	53                   	push   %ebx
  8009dc:	83 ec 14             	sub    $0x14,%esp
  8009df:	8b 45 10             	mov    0x10(%ebp),%eax
  8009e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009e5:	8b 45 14             	mov    0x14(%ebp),%eax
  8009e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8009eb:	8b 45 18             	mov    0x18(%ebp),%eax
  8009ee:	ba 00 00 00 00       	mov    $0x0,%edx
  8009f3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009f6:	77 55                	ja     800a4d <printnum+0x75>
  8009f8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009fb:	72 05                	jb     800a02 <printnum+0x2a>
  8009fd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a00:	77 4b                	ja     800a4d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a02:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a05:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a08:	8b 45 18             	mov    0x18(%ebp),%eax
  800a0b:	ba 00 00 00 00       	mov    $0x0,%edx
  800a10:	52                   	push   %edx
  800a11:	50                   	push   %eax
  800a12:	ff 75 f4             	pushl  -0xc(%ebp)
  800a15:	ff 75 f0             	pushl  -0x10(%ebp)
  800a18:	e8 2f 16 00 00       	call   80204c <__udivdi3>
  800a1d:	83 c4 10             	add    $0x10,%esp
  800a20:	83 ec 04             	sub    $0x4,%esp
  800a23:	ff 75 20             	pushl  0x20(%ebp)
  800a26:	53                   	push   %ebx
  800a27:	ff 75 18             	pushl  0x18(%ebp)
  800a2a:	52                   	push   %edx
  800a2b:	50                   	push   %eax
  800a2c:	ff 75 0c             	pushl  0xc(%ebp)
  800a2f:	ff 75 08             	pushl  0x8(%ebp)
  800a32:	e8 a1 ff ff ff       	call   8009d8 <printnum>
  800a37:	83 c4 20             	add    $0x20,%esp
  800a3a:	eb 1a                	jmp    800a56 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a3c:	83 ec 08             	sub    $0x8,%esp
  800a3f:	ff 75 0c             	pushl  0xc(%ebp)
  800a42:	ff 75 20             	pushl  0x20(%ebp)
  800a45:	8b 45 08             	mov    0x8(%ebp),%eax
  800a48:	ff d0                	call   *%eax
  800a4a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a4d:	ff 4d 1c             	decl   0x1c(%ebp)
  800a50:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a54:	7f e6                	jg     800a3c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a56:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a59:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a5e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a61:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a64:	53                   	push   %ebx
  800a65:	51                   	push   %ecx
  800a66:	52                   	push   %edx
  800a67:	50                   	push   %eax
  800a68:	e8 ef 16 00 00       	call   80215c <__umoddi3>
  800a6d:	83 c4 10             	add    $0x10,%esp
  800a70:	05 54 2a 80 00       	add    $0x802a54,%eax
  800a75:	8a 00                	mov    (%eax),%al
  800a77:	0f be c0             	movsbl %al,%eax
  800a7a:	83 ec 08             	sub    $0x8,%esp
  800a7d:	ff 75 0c             	pushl  0xc(%ebp)
  800a80:	50                   	push   %eax
  800a81:	8b 45 08             	mov    0x8(%ebp),%eax
  800a84:	ff d0                	call   *%eax
  800a86:	83 c4 10             	add    $0x10,%esp
}
  800a89:	90                   	nop
  800a8a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a8d:	c9                   	leave  
  800a8e:	c3                   	ret    

00800a8f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800a8f:	55                   	push   %ebp
  800a90:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a92:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a96:	7e 1c                	jle    800ab4 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800a98:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9b:	8b 00                	mov    (%eax),%eax
  800a9d:	8d 50 08             	lea    0x8(%eax),%edx
  800aa0:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa3:	89 10                	mov    %edx,(%eax)
  800aa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa8:	8b 00                	mov    (%eax),%eax
  800aaa:	83 e8 08             	sub    $0x8,%eax
  800aad:	8b 50 04             	mov    0x4(%eax),%edx
  800ab0:	8b 00                	mov    (%eax),%eax
  800ab2:	eb 40                	jmp    800af4 <getuint+0x65>
	else if (lflag)
  800ab4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ab8:	74 1e                	je     800ad8 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800aba:	8b 45 08             	mov    0x8(%ebp),%eax
  800abd:	8b 00                	mov    (%eax),%eax
  800abf:	8d 50 04             	lea    0x4(%eax),%edx
  800ac2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac5:	89 10                	mov    %edx,(%eax)
  800ac7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aca:	8b 00                	mov    (%eax),%eax
  800acc:	83 e8 04             	sub    $0x4,%eax
  800acf:	8b 00                	mov    (%eax),%eax
  800ad1:	ba 00 00 00 00       	mov    $0x0,%edx
  800ad6:	eb 1c                	jmp    800af4 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  800adb:	8b 00                	mov    (%eax),%eax
  800add:	8d 50 04             	lea    0x4(%eax),%edx
  800ae0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae3:	89 10                	mov    %edx,(%eax)
  800ae5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae8:	8b 00                	mov    (%eax),%eax
  800aea:	83 e8 04             	sub    $0x4,%eax
  800aed:	8b 00                	mov    (%eax),%eax
  800aef:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800af4:	5d                   	pop    %ebp
  800af5:	c3                   	ret    

00800af6 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800af6:	55                   	push   %ebp
  800af7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800af9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800afd:	7e 1c                	jle    800b1b <getint+0x25>
		return va_arg(*ap, long long);
  800aff:	8b 45 08             	mov    0x8(%ebp),%eax
  800b02:	8b 00                	mov    (%eax),%eax
  800b04:	8d 50 08             	lea    0x8(%eax),%edx
  800b07:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0a:	89 10                	mov    %edx,(%eax)
  800b0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0f:	8b 00                	mov    (%eax),%eax
  800b11:	83 e8 08             	sub    $0x8,%eax
  800b14:	8b 50 04             	mov    0x4(%eax),%edx
  800b17:	8b 00                	mov    (%eax),%eax
  800b19:	eb 38                	jmp    800b53 <getint+0x5d>
	else if (lflag)
  800b1b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b1f:	74 1a                	je     800b3b <getint+0x45>
		return va_arg(*ap, long);
  800b21:	8b 45 08             	mov    0x8(%ebp),%eax
  800b24:	8b 00                	mov    (%eax),%eax
  800b26:	8d 50 04             	lea    0x4(%eax),%edx
  800b29:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2c:	89 10                	mov    %edx,(%eax)
  800b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b31:	8b 00                	mov    (%eax),%eax
  800b33:	83 e8 04             	sub    $0x4,%eax
  800b36:	8b 00                	mov    (%eax),%eax
  800b38:	99                   	cltd   
  800b39:	eb 18                	jmp    800b53 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3e:	8b 00                	mov    (%eax),%eax
  800b40:	8d 50 04             	lea    0x4(%eax),%edx
  800b43:	8b 45 08             	mov    0x8(%ebp),%eax
  800b46:	89 10                	mov    %edx,(%eax)
  800b48:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4b:	8b 00                	mov    (%eax),%eax
  800b4d:	83 e8 04             	sub    $0x4,%eax
  800b50:	8b 00                	mov    (%eax),%eax
  800b52:	99                   	cltd   
}
  800b53:	5d                   	pop    %ebp
  800b54:	c3                   	ret    

00800b55 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b55:	55                   	push   %ebp
  800b56:	89 e5                	mov    %esp,%ebp
  800b58:	56                   	push   %esi
  800b59:	53                   	push   %ebx
  800b5a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b5d:	eb 17                	jmp    800b76 <vprintfmt+0x21>
			if (ch == '\0')
  800b5f:	85 db                	test   %ebx,%ebx
  800b61:	0f 84 af 03 00 00    	je     800f16 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b67:	83 ec 08             	sub    $0x8,%esp
  800b6a:	ff 75 0c             	pushl  0xc(%ebp)
  800b6d:	53                   	push   %ebx
  800b6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b71:	ff d0                	call   *%eax
  800b73:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b76:	8b 45 10             	mov    0x10(%ebp),%eax
  800b79:	8d 50 01             	lea    0x1(%eax),%edx
  800b7c:	89 55 10             	mov    %edx,0x10(%ebp)
  800b7f:	8a 00                	mov    (%eax),%al
  800b81:	0f b6 d8             	movzbl %al,%ebx
  800b84:	83 fb 25             	cmp    $0x25,%ebx
  800b87:	75 d6                	jne    800b5f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b89:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b8d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800b94:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800b9b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800ba2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800ba9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bac:	8d 50 01             	lea    0x1(%eax),%edx
  800baf:	89 55 10             	mov    %edx,0x10(%ebp)
  800bb2:	8a 00                	mov    (%eax),%al
  800bb4:	0f b6 d8             	movzbl %al,%ebx
  800bb7:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bba:	83 f8 55             	cmp    $0x55,%eax
  800bbd:	0f 87 2b 03 00 00    	ja     800eee <vprintfmt+0x399>
  800bc3:	8b 04 85 78 2a 80 00 	mov    0x802a78(,%eax,4),%eax
  800bca:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bcc:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800bd0:	eb d7                	jmp    800ba9 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800bd2:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800bd6:	eb d1                	jmp    800ba9 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bd8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800bdf:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800be2:	89 d0                	mov    %edx,%eax
  800be4:	c1 e0 02             	shl    $0x2,%eax
  800be7:	01 d0                	add    %edx,%eax
  800be9:	01 c0                	add    %eax,%eax
  800beb:	01 d8                	add    %ebx,%eax
  800bed:	83 e8 30             	sub    $0x30,%eax
  800bf0:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800bf3:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf6:	8a 00                	mov    (%eax),%al
  800bf8:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800bfb:	83 fb 2f             	cmp    $0x2f,%ebx
  800bfe:	7e 3e                	jle    800c3e <vprintfmt+0xe9>
  800c00:	83 fb 39             	cmp    $0x39,%ebx
  800c03:	7f 39                	jg     800c3e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c05:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c08:	eb d5                	jmp    800bdf <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c0a:	8b 45 14             	mov    0x14(%ebp),%eax
  800c0d:	83 c0 04             	add    $0x4,%eax
  800c10:	89 45 14             	mov    %eax,0x14(%ebp)
  800c13:	8b 45 14             	mov    0x14(%ebp),%eax
  800c16:	83 e8 04             	sub    $0x4,%eax
  800c19:	8b 00                	mov    (%eax),%eax
  800c1b:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c1e:	eb 1f                	jmp    800c3f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c20:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c24:	79 83                	jns    800ba9 <vprintfmt+0x54>
				width = 0;
  800c26:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c2d:	e9 77 ff ff ff       	jmp    800ba9 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c32:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c39:	e9 6b ff ff ff       	jmp    800ba9 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c3e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c3f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c43:	0f 89 60 ff ff ff    	jns    800ba9 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c49:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c4c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c4f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c56:	e9 4e ff ff ff       	jmp    800ba9 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c5b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c5e:	e9 46 ff ff ff       	jmp    800ba9 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c63:	8b 45 14             	mov    0x14(%ebp),%eax
  800c66:	83 c0 04             	add    $0x4,%eax
  800c69:	89 45 14             	mov    %eax,0x14(%ebp)
  800c6c:	8b 45 14             	mov    0x14(%ebp),%eax
  800c6f:	83 e8 04             	sub    $0x4,%eax
  800c72:	8b 00                	mov    (%eax),%eax
  800c74:	83 ec 08             	sub    $0x8,%esp
  800c77:	ff 75 0c             	pushl  0xc(%ebp)
  800c7a:	50                   	push   %eax
  800c7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7e:	ff d0                	call   *%eax
  800c80:	83 c4 10             	add    $0x10,%esp
			break;
  800c83:	e9 89 02 00 00       	jmp    800f11 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c88:	8b 45 14             	mov    0x14(%ebp),%eax
  800c8b:	83 c0 04             	add    $0x4,%eax
  800c8e:	89 45 14             	mov    %eax,0x14(%ebp)
  800c91:	8b 45 14             	mov    0x14(%ebp),%eax
  800c94:	83 e8 04             	sub    $0x4,%eax
  800c97:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800c99:	85 db                	test   %ebx,%ebx
  800c9b:	79 02                	jns    800c9f <vprintfmt+0x14a>
				err = -err;
  800c9d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800c9f:	83 fb 64             	cmp    $0x64,%ebx
  800ca2:	7f 0b                	jg     800caf <vprintfmt+0x15a>
  800ca4:	8b 34 9d c0 28 80 00 	mov    0x8028c0(,%ebx,4),%esi
  800cab:	85 f6                	test   %esi,%esi
  800cad:	75 19                	jne    800cc8 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800caf:	53                   	push   %ebx
  800cb0:	68 65 2a 80 00       	push   $0x802a65
  800cb5:	ff 75 0c             	pushl  0xc(%ebp)
  800cb8:	ff 75 08             	pushl  0x8(%ebp)
  800cbb:	e8 5e 02 00 00       	call   800f1e <printfmt>
  800cc0:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cc3:	e9 49 02 00 00       	jmp    800f11 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cc8:	56                   	push   %esi
  800cc9:	68 6e 2a 80 00       	push   $0x802a6e
  800cce:	ff 75 0c             	pushl  0xc(%ebp)
  800cd1:	ff 75 08             	pushl  0x8(%ebp)
  800cd4:	e8 45 02 00 00       	call   800f1e <printfmt>
  800cd9:	83 c4 10             	add    $0x10,%esp
			break;
  800cdc:	e9 30 02 00 00       	jmp    800f11 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ce1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce4:	83 c0 04             	add    $0x4,%eax
  800ce7:	89 45 14             	mov    %eax,0x14(%ebp)
  800cea:	8b 45 14             	mov    0x14(%ebp),%eax
  800ced:	83 e8 04             	sub    $0x4,%eax
  800cf0:	8b 30                	mov    (%eax),%esi
  800cf2:	85 f6                	test   %esi,%esi
  800cf4:	75 05                	jne    800cfb <vprintfmt+0x1a6>
				p = "(null)";
  800cf6:	be 71 2a 80 00       	mov    $0x802a71,%esi
			if (width > 0 && padc != '-')
  800cfb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cff:	7e 6d                	jle    800d6e <vprintfmt+0x219>
  800d01:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d05:	74 67                	je     800d6e <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d07:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d0a:	83 ec 08             	sub    $0x8,%esp
  800d0d:	50                   	push   %eax
  800d0e:	56                   	push   %esi
  800d0f:	e8 0c 03 00 00       	call   801020 <strnlen>
  800d14:	83 c4 10             	add    $0x10,%esp
  800d17:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d1a:	eb 16                	jmp    800d32 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d1c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d20:	83 ec 08             	sub    $0x8,%esp
  800d23:	ff 75 0c             	pushl  0xc(%ebp)
  800d26:	50                   	push   %eax
  800d27:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2a:	ff d0                	call   *%eax
  800d2c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d2f:	ff 4d e4             	decl   -0x1c(%ebp)
  800d32:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d36:	7f e4                	jg     800d1c <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d38:	eb 34                	jmp    800d6e <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d3a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d3e:	74 1c                	je     800d5c <vprintfmt+0x207>
  800d40:	83 fb 1f             	cmp    $0x1f,%ebx
  800d43:	7e 05                	jle    800d4a <vprintfmt+0x1f5>
  800d45:	83 fb 7e             	cmp    $0x7e,%ebx
  800d48:	7e 12                	jle    800d5c <vprintfmt+0x207>
					putch('?', putdat);
  800d4a:	83 ec 08             	sub    $0x8,%esp
  800d4d:	ff 75 0c             	pushl  0xc(%ebp)
  800d50:	6a 3f                	push   $0x3f
  800d52:	8b 45 08             	mov    0x8(%ebp),%eax
  800d55:	ff d0                	call   *%eax
  800d57:	83 c4 10             	add    $0x10,%esp
  800d5a:	eb 0f                	jmp    800d6b <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d5c:	83 ec 08             	sub    $0x8,%esp
  800d5f:	ff 75 0c             	pushl  0xc(%ebp)
  800d62:	53                   	push   %ebx
  800d63:	8b 45 08             	mov    0x8(%ebp),%eax
  800d66:	ff d0                	call   *%eax
  800d68:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d6b:	ff 4d e4             	decl   -0x1c(%ebp)
  800d6e:	89 f0                	mov    %esi,%eax
  800d70:	8d 70 01             	lea    0x1(%eax),%esi
  800d73:	8a 00                	mov    (%eax),%al
  800d75:	0f be d8             	movsbl %al,%ebx
  800d78:	85 db                	test   %ebx,%ebx
  800d7a:	74 24                	je     800da0 <vprintfmt+0x24b>
  800d7c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d80:	78 b8                	js     800d3a <vprintfmt+0x1e5>
  800d82:	ff 4d e0             	decl   -0x20(%ebp)
  800d85:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d89:	79 af                	jns    800d3a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d8b:	eb 13                	jmp    800da0 <vprintfmt+0x24b>
				putch(' ', putdat);
  800d8d:	83 ec 08             	sub    $0x8,%esp
  800d90:	ff 75 0c             	pushl  0xc(%ebp)
  800d93:	6a 20                	push   $0x20
  800d95:	8b 45 08             	mov    0x8(%ebp),%eax
  800d98:	ff d0                	call   *%eax
  800d9a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d9d:	ff 4d e4             	decl   -0x1c(%ebp)
  800da0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800da4:	7f e7                	jg     800d8d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800da6:	e9 66 01 00 00       	jmp    800f11 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800dab:	83 ec 08             	sub    $0x8,%esp
  800dae:	ff 75 e8             	pushl  -0x18(%ebp)
  800db1:	8d 45 14             	lea    0x14(%ebp),%eax
  800db4:	50                   	push   %eax
  800db5:	e8 3c fd ff ff       	call   800af6 <getint>
  800dba:	83 c4 10             	add    $0x10,%esp
  800dbd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dc0:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800dc3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dc6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dc9:	85 d2                	test   %edx,%edx
  800dcb:	79 23                	jns    800df0 <vprintfmt+0x29b>
				putch('-', putdat);
  800dcd:	83 ec 08             	sub    $0x8,%esp
  800dd0:	ff 75 0c             	pushl  0xc(%ebp)
  800dd3:	6a 2d                	push   $0x2d
  800dd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd8:	ff d0                	call   *%eax
  800dda:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ddd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800de0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800de3:	f7 d8                	neg    %eax
  800de5:	83 d2 00             	adc    $0x0,%edx
  800de8:	f7 da                	neg    %edx
  800dea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ded:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800df0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800df7:	e9 bc 00 00 00       	jmp    800eb8 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800dfc:	83 ec 08             	sub    $0x8,%esp
  800dff:	ff 75 e8             	pushl  -0x18(%ebp)
  800e02:	8d 45 14             	lea    0x14(%ebp),%eax
  800e05:	50                   	push   %eax
  800e06:	e8 84 fc ff ff       	call   800a8f <getuint>
  800e0b:	83 c4 10             	add    $0x10,%esp
  800e0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e11:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e14:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e1b:	e9 98 00 00 00       	jmp    800eb8 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e20:	83 ec 08             	sub    $0x8,%esp
  800e23:	ff 75 0c             	pushl  0xc(%ebp)
  800e26:	6a 58                	push   $0x58
  800e28:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2b:	ff d0                	call   *%eax
  800e2d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e30:	83 ec 08             	sub    $0x8,%esp
  800e33:	ff 75 0c             	pushl  0xc(%ebp)
  800e36:	6a 58                	push   $0x58
  800e38:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3b:	ff d0                	call   *%eax
  800e3d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e40:	83 ec 08             	sub    $0x8,%esp
  800e43:	ff 75 0c             	pushl  0xc(%ebp)
  800e46:	6a 58                	push   $0x58
  800e48:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4b:	ff d0                	call   *%eax
  800e4d:	83 c4 10             	add    $0x10,%esp
			break;
  800e50:	e9 bc 00 00 00       	jmp    800f11 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e55:	83 ec 08             	sub    $0x8,%esp
  800e58:	ff 75 0c             	pushl  0xc(%ebp)
  800e5b:	6a 30                	push   $0x30
  800e5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e60:	ff d0                	call   *%eax
  800e62:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e65:	83 ec 08             	sub    $0x8,%esp
  800e68:	ff 75 0c             	pushl  0xc(%ebp)
  800e6b:	6a 78                	push   $0x78
  800e6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e70:	ff d0                	call   *%eax
  800e72:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e75:	8b 45 14             	mov    0x14(%ebp),%eax
  800e78:	83 c0 04             	add    $0x4,%eax
  800e7b:	89 45 14             	mov    %eax,0x14(%ebp)
  800e7e:	8b 45 14             	mov    0x14(%ebp),%eax
  800e81:	83 e8 04             	sub    $0x4,%eax
  800e84:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e86:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e89:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800e90:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800e97:	eb 1f                	jmp    800eb8 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800e99:	83 ec 08             	sub    $0x8,%esp
  800e9c:	ff 75 e8             	pushl  -0x18(%ebp)
  800e9f:	8d 45 14             	lea    0x14(%ebp),%eax
  800ea2:	50                   	push   %eax
  800ea3:	e8 e7 fb ff ff       	call   800a8f <getuint>
  800ea8:	83 c4 10             	add    $0x10,%esp
  800eab:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eae:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800eb1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800eb8:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ebc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ebf:	83 ec 04             	sub    $0x4,%esp
  800ec2:	52                   	push   %edx
  800ec3:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ec6:	50                   	push   %eax
  800ec7:	ff 75 f4             	pushl  -0xc(%ebp)
  800eca:	ff 75 f0             	pushl  -0x10(%ebp)
  800ecd:	ff 75 0c             	pushl  0xc(%ebp)
  800ed0:	ff 75 08             	pushl  0x8(%ebp)
  800ed3:	e8 00 fb ff ff       	call   8009d8 <printnum>
  800ed8:	83 c4 20             	add    $0x20,%esp
			break;
  800edb:	eb 34                	jmp    800f11 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800edd:	83 ec 08             	sub    $0x8,%esp
  800ee0:	ff 75 0c             	pushl  0xc(%ebp)
  800ee3:	53                   	push   %ebx
  800ee4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee7:	ff d0                	call   *%eax
  800ee9:	83 c4 10             	add    $0x10,%esp
			break;
  800eec:	eb 23                	jmp    800f11 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800eee:	83 ec 08             	sub    $0x8,%esp
  800ef1:	ff 75 0c             	pushl  0xc(%ebp)
  800ef4:	6a 25                	push   $0x25
  800ef6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef9:	ff d0                	call   *%eax
  800efb:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800efe:	ff 4d 10             	decl   0x10(%ebp)
  800f01:	eb 03                	jmp    800f06 <vprintfmt+0x3b1>
  800f03:	ff 4d 10             	decl   0x10(%ebp)
  800f06:	8b 45 10             	mov    0x10(%ebp),%eax
  800f09:	48                   	dec    %eax
  800f0a:	8a 00                	mov    (%eax),%al
  800f0c:	3c 25                	cmp    $0x25,%al
  800f0e:	75 f3                	jne    800f03 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f10:	90                   	nop
		}
	}
  800f11:	e9 47 fc ff ff       	jmp    800b5d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f16:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f17:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f1a:	5b                   	pop    %ebx
  800f1b:	5e                   	pop    %esi
  800f1c:	5d                   	pop    %ebp
  800f1d:	c3                   	ret    

00800f1e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f1e:	55                   	push   %ebp
  800f1f:	89 e5                	mov    %esp,%ebp
  800f21:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f24:	8d 45 10             	lea    0x10(%ebp),%eax
  800f27:	83 c0 04             	add    $0x4,%eax
  800f2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f2d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f30:	ff 75 f4             	pushl  -0xc(%ebp)
  800f33:	50                   	push   %eax
  800f34:	ff 75 0c             	pushl  0xc(%ebp)
  800f37:	ff 75 08             	pushl  0x8(%ebp)
  800f3a:	e8 16 fc ff ff       	call   800b55 <vprintfmt>
  800f3f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f42:	90                   	nop
  800f43:	c9                   	leave  
  800f44:	c3                   	ret    

00800f45 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f45:	55                   	push   %ebp
  800f46:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4b:	8b 40 08             	mov    0x8(%eax),%eax
  800f4e:	8d 50 01             	lea    0x1(%eax),%edx
  800f51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f54:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5a:	8b 10                	mov    (%eax),%edx
  800f5c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5f:	8b 40 04             	mov    0x4(%eax),%eax
  800f62:	39 c2                	cmp    %eax,%edx
  800f64:	73 12                	jae    800f78 <sprintputch+0x33>
		*b->buf++ = ch;
  800f66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f69:	8b 00                	mov    (%eax),%eax
  800f6b:	8d 48 01             	lea    0x1(%eax),%ecx
  800f6e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f71:	89 0a                	mov    %ecx,(%edx)
  800f73:	8b 55 08             	mov    0x8(%ebp),%edx
  800f76:	88 10                	mov    %dl,(%eax)
}
  800f78:	90                   	nop
  800f79:	5d                   	pop    %ebp
  800f7a:	c3                   	ret    

00800f7b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f7b:	55                   	push   %ebp
  800f7c:	89 e5                	mov    %esp,%ebp
  800f7e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f81:	8b 45 08             	mov    0x8(%ebp),%eax
  800f84:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f90:	01 d0                	add    %edx,%eax
  800f92:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f95:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800f9c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fa0:	74 06                	je     800fa8 <vsnprintf+0x2d>
  800fa2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fa6:	7f 07                	jg     800faf <vsnprintf+0x34>
		return -E_INVAL;
  800fa8:	b8 03 00 00 00       	mov    $0x3,%eax
  800fad:	eb 20                	jmp    800fcf <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800faf:	ff 75 14             	pushl  0x14(%ebp)
  800fb2:	ff 75 10             	pushl  0x10(%ebp)
  800fb5:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fb8:	50                   	push   %eax
  800fb9:	68 45 0f 80 00       	push   $0x800f45
  800fbe:	e8 92 fb ff ff       	call   800b55 <vprintfmt>
  800fc3:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800fc6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fc9:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fcc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800fcf:	c9                   	leave  
  800fd0:	c3                   	ret    

00800fd1 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fd1:	55                   	push   %ebp
  800fd2:	89 e5                	mov    %esp,%ebp
  800fd4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fd7:	8d 45 10             	lea    0x10(%ebp),%eax
  800fda:	83 c0 04             	add    $0x4,%eax
  800fdd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800fe0:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe3:	ff 75 f4             	pushl  -0xc(%ebp)
  800fe6:	50                   	push   %eax
  800fe7:	ff 75 0c             	pushl  0xc(%ebp)
  800fea:	ff 75 08             	pushl  0x8(%ebp)
  800fed:	e8 89 ff ff ff       	call   800f7b <vsnprintf>
  800ff2:	83 c4 10             	add    $0x10,%esp
  800ff5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ff8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ffb:	c9                   	leave  
  800ffc:	c3                   	ret    

00800ffd <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800ffd:	55                   	push   %ebp
  800ffe:	89 e5                	mov    %esp,%ebp
  801000:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801003:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80100a:	eb 06                	jmp    801012 <strlen+0x15>
		n++;
  80100c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80100f:	ff 45 08             	incl   0x8(%ebp)
  801012:	8b 45 08             	mov    0x8(%ebp),%eax
  801015:	8a 00                	mov    (%eax),%al
  801017:	84 c0                	test   %al,%al
  801019:	75 f1                	jne    80100c <strlen+0xf>
		n++;
	return n;
  80101b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80101e:	c9                   	leave  
  80101f:	c3                   	ret    

00801020 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801020:	55                   	push   %ebp
  801021:	89 e5                	mov    %esp,%ebp
  801023:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801026:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80102d:	eb 09                	jmp    801038 <strnlen+0x18>
		n++;
  80102f:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801032:	ff 45 08             	incl   0x8(%ebp)
  801035:	ff 4d 0c             	decl   0xc(%ebp)
  801038:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80103c:	74 09                	je     801047 <strnlen+0x27>
  80103e:	8b 45 08             	mov    0x8(%ebp),%eax
  801041:	8a 00                	mov    (%eax),%al
  801043:	84 c0                	test   %al,%al
  801045:	75 e8                	jne    80102f <strnlen+0xf>
		n++;
	return n;
  801047:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80104a:	c9                   	leave  
  80104b:	c3                   	ret    

0080104c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80104c:	55                   	push   %ebp
  80104d:	89 e5                	mov    %esp,%ebp
  80104f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801052:	8b 45 08             	mov    0x8(%ebp),%eax
  801055:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801058:	90                   	nop
  801059:	8b 45 08             	mov    0x8(%ebp),%eax
  80105c:	8d 50 01             	lea    0x1(%eax),%edx
  80105f:	89 55 08             	mov    %edx,0x8(%ebp)
  801062:	8b 55 0c             	mov    0xc(%ebp),%edx
  801065:	8d 4a 01             	lea    0x1(%edx),%ecx
  801068:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80106b:	8a 12                	mov    (%edx),%dl
  80106d:	88 10                	mov    %dl,(%eax)
  80106f:	8a 00                	mov    (%eax),%al
  801071:	84 c0                	test   %al,%al
  801073:	75 e4                	jne    801059 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801075:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801078:	c9                   	leave  
  801079:	c3                   	ret    

0080107a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80107a:	55                   	push   %ebp
  80107b:	89 e5                	mov    %esp,%ebp
  80107d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801080:	8b 45 08             	mov    0x8(%ebp),%eax
  801083:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801086:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80108d:	eb 1f                	jmp    8010ae <strncpy+0x34>
		*dst++ = *src;
  80108f:	8b 45 08             	mov    0x8(%ebp),%eax
  801092:	8d 50 01             	lea    0x1(%eax),%edx
  801095:	89 55 08             	mov    %edx,0x8(%ebp)
  801098:	8b 55 0c             	mov    0xc(%ebp),%edx
  80109b:	8a 12                	mov    (%edx),%dl
  80109d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80109f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010a2:	8a 00                	mov    (%eax),%al
  8010a4:	84 c0                	test   %al,%al
  8010a6:	74 03                	je     8010ab <strncpy+0x31>
			src++;
  8010a8:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010ab:	ff 45 fc             	incl   -0x4(%ebp)
  8010ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010b1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010b4:	72 d9                	jb     80108f <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010b9:	c9                   	leave  
  8010ba:	c3                   	ret    

008010bb <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010bb:	55                   	push   %ebp
  8010bc:	89 e5                	mov    %esp,%ebp
  8010be:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010c7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010cb:	74 30                	je     8010fd <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8010cd:	eb 16                	jmp    8010e5 <strlcpy+0x2a>
			*dst++ = *src++;
  8010cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d2:	8d 50 01             	lea    0x1(%eax),%edx
  8010d5:	89 55 08             	mov    %edx,0x8(%ebp)
  8010d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010db:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010de:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010e1:	8a 12                	mov    (%edx),%dl
  8010e3:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8010e5:	ff 4d 10             	decl   0x10(%ebp)
  8010e8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010ec:	74 09                	je     8010f7 <strlcpy+0x3c>
  8010ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f1:	8a 00                	mov    (%eax),%al
  8010f3:	84 c0                	test   %al,%al
  8010f5:	75 d8                	jne    8010cf <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8010f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fa:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8010fd:	8b 55 08             	mov    0x8(%ebp),%edx
  801100:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801103:	29 c2                	sub    %eax,%edx
  801105:	89 d0                	mov    %edx,%eax
}
  801107:	c9                   	leave  
  801108:	c3                   	ret    

00801109 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801109:	55                   	push   %ebp
  80110a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80110c:	eb 06                	jmp    801114 <strcmp+0xb>
		p++, q++;
  80110e:	ff 45 08             	incl   0x8(%ebp)
  801111:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801114:	8b 45 08             	mov    0x8(%ebp),%eax
  801117:	8a 00                	mov    (%eax),%al
  801119:	84 c0                	test   %al,%al
  80111b:	74 0e                	je     80112b <strcmp+0x22>
  80111d:	8b 45 08             	mov    0x8(%ebp),%eax
  801120:	8a 10                	mov    (%eax),%dl
  801122:	8b 45 0c             	mov    0xc(%ebp),%eax
  801125:	8a 00                	mov    (%eax),%al
  801127:	38 c2                	cmp    %al,%dl
  801129:	74 e3                	je     80110e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80112b:	8b 45 08             	mov    0x8(%ebp),%eax
  80112e:	8a 00                	mov    (%eax),%al
  801130:	0f b6 d0             	movzbl %al,%edx
  801133:	8b 45 0c             	mov    0xc(%ebp),%eax
  801136:	8a 00                	mov    (%eax),%al
  801138:	0f b6 c0             	movzbl %al,%eax
  80113b:	29 c2                	sub    %eax,%edx
  80113d:	89 d0                	mov    %edx,%eax
}
  80113f:	5d                   	pop    %ebp
  801140:	c3                   	ret    

00801141 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801141:	55                   	push   %ebp
  801142:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801144:	eb 09                	jmp    80114f <strncmp+0xe>
		n--, p++, q++;
  801146:	ff 4d 10             	decl   0x10(%ebp)
  801149:	ff 45 08             	incl   0x8(%ebp)
  80114c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80114f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801153:	74 17                	je     80116c <strncmp+0x2b>
  801155:	8b 45 08             	mov    0x8(%ebp),%eax
  801158:	8a 00                	mov    (%eax),%al
  80115a:	84 c0                	test   %al,%al
  80115c:	74 0e                	je     80116c <strncmp+0x2b>
  80115e:	8b 45 08             	mov    0x8(%ebp),%eax
  801161:	8a 10                	mov    (%eax),%dl
  801163:	8b 45 0c             	mov    0xc(%ebp),%eax
  801166:	8a 00                	mov    (%eax),%al
  801168:	38 c2                	cmp    %al,%dl
  80116a:	74 da                	je     801146 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80116c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801170:	75 07                	jne    801179 <strncmp+0x38>
		return 0;
  801172:	b8 00 00 00 00       	mov    $0x0,%eax
  801177:	eb 14                	jmp    80118d <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801179:	8b 45 08             	mov    0x8(%ebp),%eax
  80117c:	8a 00                	mov    (%eax),%al
  80117e:	0f b6 d0             	movzbl %al,%edx
  801181:	8b 45 0c             	mov    0xc(%ebp),%eax
  801184:	8a 00                	mov    (%eax),%al
  801186:	0f b6 c0             	movzbl %al,%eax
  801189:	29 c2                	sub    %eax,%edx
  80118b:	89 d0                	mov    %edx,%eax
}
  80118d:	5d                   	pop    %ebp
  80118e:	c3                   	ret    

0080118f <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80118f:	55                   	push   %ebp
  801190:	89 e5                	mov    %esp,%ebp
  801192:	83 ec 04             	sub    $0x4,%esp
  801195:	8b 45 0c             	mov    0xc(%ebp),%eax
  801198:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80119b:	eb 12                	jmp    8011af <strchr+0x20>
		if (*s == c)
  80119d:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a0:	8a 00                	mov    (%eax),%al
  8011a2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011a5:	75 05                	jne    8011ac <strchr+0x1d>
			return (char *) s;
  8011a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011aa:	eb 11                	jmp    8011bd <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011ac:	ff 45 08             	incl   0x8(%ebp)
  8011af:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b2:	8a 00                	mov    (%eax),%al
  8011b4:	84 c0                	test   %al,%al
  8011b6:	75 e5                	jne    80119d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011b8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011bd:	c9                   	leave  
  8011be:	c3                   	ret    

008011bf <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011bf:	55                   	push   %ebp
  8011c0:	89 e5                	mov    %esp,%ebp
  8011c2:	83 ec 04             	sub    $0x4,%esp
  8011c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011cb:	eb 0d                	jmp    8011da <strfind+0x1b>
		if (*s == c)
  8011cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d0:	8a 00                	mov    (%eax),%al
  8011d2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011d5:	74 0e                	je     8011e5 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011d7:	ff 45 08             	incl   0x8(%ebp)
  8011da:	8b 45 08             	mov    0x8(%ebp),%eax
  8011dd:	8a 00                	mov    (%eax),%al
  8011df:	84 c0                	test   %al,%al
  8011e1:	75 ea                	jne    8011cd <strfind+0xe>
  8011e3:	eb 01                	jmp    8011e6 <strfind+0x27>
		if (*s == c)
			break;
  8011e5:	90                   	nop
	return (char *) s;
  8011e6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011e9:	c9                   	leave  
  8011ea:	c3                   	ret    

008011eb <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8011eb:	55                   	push   %ebp
  8011ec:	89 e5                	mov    %esp,%ebp
  8011ee:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8011f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8011f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8011fd:	eb 0e                	jmp    80120d <memset+0x22>
		*p++ = c;
  8011ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801202:	8d 50 01             	lea    0x1(%eax),%edx
  801205:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801208:	8b 55 0c             	mov    0xc(%ebp),%edx
  80120b:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80120d:	ff 4d f8             	decl   -0x8(%ebp)
  801210:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801214:	79 e9                	jns    8011ff <memset+0x14>
		*p++ = c;

	return v;
  801216:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801219:	c9                   	leave  
  80121a:	c3                   	ret    

0080121b <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80121b:	55                   	push   %ebp
  80121c:	89 e5                	mov    %esp,%ebp
  80121e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801221:	8b 45 0c             	mov    0xc(%ebp),%eax
  801224:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801227:	8b 45 08             	mov    0x8(%ebp),%eax
  80122a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80122d:	eb 16                	jmp    801245 <memcpy+0x2a>
		*d++ = *s++;
  80122f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801232:	8d 50 01             	lea    0x1(%eax),%edx
  801235:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801238:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80123b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80123e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801241:	8a 12                	mov    (%edx),%dl
  801243:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801245:	8b 45 10             	mov    0x10(%ebp),%eax
  801248:	8d 50 ff             	lea    -0x1(%eax),%edx
  80124b:	89 55 10             	mov    %edx,0x10(%ebp)
  80124e:	85 c0                	test   %eax,%eax
  801250:	75 dd                	jne    80122f <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801252:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801255:	c9                   	leave  
  801256:	c3                   	ret    

00801257 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801257:	55                   	push   %ebp
  801258:	89 e5                	mov    %esp,%ebp
  80125a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80125d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801260:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801263:	8b 45 08             	mov    0x8(%ebp),%eax
  801266:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801269:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80126c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80126f:	73 50                	jae    8012c1 <memmove+0x6a>
  801271:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801274:	8b 45 10             	mov    0x10(%ebp),%eax
  801277:	01 d0                	add    %edx,%eax
  801279:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80127c:	76 43                	jbe    8012c1 <memmove+0x6a>
		s += n;
  80127e:	8b 45 10             	mov    0x10(%ebp),%eax
  801281:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801284:	8b 45 10             	mov    0x10(%ebp),%eax
  801287:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80128a:	eb 10                	jmp    80129c <memmove+0x45>
			*--d = *--s;
  80128c:	ff 4d f8             	decl   -0x8(%ebp)
  80128f:	ff 4d fc             	decl   -0x4(%ebp)
  801292:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801295:	8a 10                	mov    (%eax),%dl
  801297:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80129a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80129c:	8b 45 10             	mov    0x10(%ebp),%eax
  80129f:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012a2:	89 55 10             	mov    %edx,0x10(%ebp)
  8012a5:	85 c0                	test   %eax,%eax
  8012a7:	75 e3                	jne    80128c <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012a9:	eb 23                	jmp    8012ce <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ae:	8d 50 01             	lea    0x1(%eax),%edx
  8012b1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012b4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012b7:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012ba:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012bd:	8a 12                	mov    (%edx),%dl
  8012bf:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012c4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012c7:	89 55 10             	mov    %edx,0x10(%ebp)
  8012ca:	85 c0                	test   %eax,%eax
  8012cc:	75 dd                	jne    8012ab <memmove+0x54>
			*d++ = *s++;

	return dst;
  8012ce:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012d1:	c9                   	leave  
  8012d2:	c3                   	ret    

008012d3 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012d3:	55                   	push   %ebp
  8012d4:	89 e5                	mov    %esp,%ebp
  8012d6:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8012df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e2:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8012e5:	eb 2a                	jmp    801311 <memcmp+0x3e>
		if (*s1 != *s2)
  8012e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012ea:	8a 10                	mov    (%eax),%dl
  8012ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012ef:	8a 00                	mov    (%eax),%al
  8012f1:	38 c2                	cmp    %al,%dl
  8012f3:	74 16                	je     80130b <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8012f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012f8:	8a 00                	mov    (%eax),%al
  8012fa:	0f b6 d0             	movzbl %al,%edx
  8012fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801300:	8a 00                	mov    (%eax),%al
  801302:	0f b6 c0             	movzbl %al,%eax
  801305:	29 c2                	sub    %eax,%edx
  801307:	89 d0                	mov    %edx,%eax
  801309:	eb 18                	jmp    801323 <memcmp+0x50>
		s1++, s2++;
  80130b:	ff 45 fc             	incl   -0x4(%ebp)
  80130e:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801311:	8b 45 10             	mov    0x10(%ebp),%eax
  801314:	8d 50 ff             	lea    -0x1(%eax),%edx
  801317:	89 55 10             	mov    %edx,0x10(%ebp)
  80131a:	85 c0                	test   %eax,%eax
  80131c:	75 c9                	jne    8012e7 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80131e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801323:	c9                   	leave  
  801324:	c3                   	ret    

00801325 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801325:	55                   	push   %ebp
  801326:	89 e5                	mov    %esp,%ebp
  801328:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80132b:	8b 55 08             	mov    0x8(%ebp),%edx
  80132e:	8b 45 10             	mov    0x10(%ebp),%eax
  801331:	01 d0                	add    %edx,%eax
  801333:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801336:	eb 15                	jmp    80134d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801338:	8b 45 08             	mov    0x8(%ebp),%eax
  80133b:	8a 00                	mov    (%eax),%al
  80133d:	0f b6 d0             	movzbl %al,%edx
  801340:	8b 45 0c             	mov    0xc(%ebp),%eax
  801343:	0f b6 c0             	movzbl %al,%eax
  801346:	39 c2                	cmp    %eax,%edx
  801348:	74 0d                	je     801357 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80134a:	ff 45 08             	incl   0x8(%ebp)
  80134d:	8b 45 08             	mov    0x8(%ebp),%eax
  801350:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801353:	72 e3                	jb     801338 <memfind+0x13>
  801355:	eb 01                	jmp    801358 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801357:	90                   	nop
	return (void *) s;
  801358:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80135b:	c9                   	leave  
  80135c:	c3                   	ret    

0080135d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80135d:	55                   	push   %ebp
  80135e:	89 e5                	mov    %esp,%ebp
  801360:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801363:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80136a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801371:	eb 03                	jmp    801376 <strtol+0x19>
		s++;
  801373:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801376:	8b 45 08             	mov    0x8(%ebp),%eax
  801379:	8a 00                	mov    (%eax),%al
  80137b:	3c 20                	cmp    $0x20,%al
  80137d:	74 f4                	je     801373 <strtol+0x16>
  80137f:	8b 45 08             	mov    0x8(%ebp),%eax
  801382:	8a 00                	mov    (%eax),%al
  801384:	3c 09                	cmp    $0x9,%al
  801386:	74 eb                	je     801373 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801388:	8b 45 08             	mov    0x8(%ebp),%eax
  80138b:	8a 00                	mov    (%eax),%al
  80138d:	3c 2b                	cmp    $0x2b,%al
  80138f:	75 05                	jne    801396 <strtol+0x39>
		s++;
  801391:	ff 45 08             	incl   0x8(%ebp)
  801394:	eb 13                	jmp    8013a9 <strtol+0x4c>
	else if (*s == '-')
  801396:	8b 45 08             	mov    0x8(%ebp),%eax
  801399:	8a 00                	mov    (%eax),%al
  80139b:	3c 2d                	cmp    $0x2d,%al
  80139d:	75 0a                	jne    8013a9 <strtol+0x4c>
		s++, neg = 1;
  80139f:	ff 45 08             	incl   0x8(%ebp)
  8013a2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013a9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013ad:	74 06                	je     8013b5 <strtol+0x58>
  8013af:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013b3:	75 20                	jne    8013d5 <strtol+0x78>
  8013b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b8:	8a 00                	mov    (%eax),%al
  8013ba:	3c 30                	cmp    $0x30,%al
  8013bc:	75 17                	jne    8013d5 <strtol+0x78>
  8013be:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c1:	40                   	inc    %eax
  8013c2:	8a 00                	mov    (%eax),%al
  8013c4:	3c 78                	cmp    $0x78,%al
  8013c6:	75 0d                	jne    8013d5 <strtol+0x78>
		s += 2, base = 16;
  8013c8:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013cc:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013d3:	eb 28                	jmp    8013fd <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8013d5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013d9:	75 15                	jne    8013f0 <strtol+0x93>
  8013db:	8b 45 08             	mov    0x8(%ebp),%eax
  8013de:	8a 00                	mov    (%eax),%al
  8013e0:	3c 30                	cmp    $0x30,%al
  8013e2:	75 0c                	jne    8013f0 <strtol+0x93>
		s++, base = 8;
  8013e4:	ff 45 08             	incl   0x8(%ebp)
  8013e7:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8013ee:	eb 0d                	jmp    8013fd <strtol+0xa0>
	else if (base == 0)
  8013f0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013f4:	75 07                	jne    8013fd <strtol+0xa0>
		base = 10;
  8013f6:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8013fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801400:	8a 00                	mov    (%eax),%al
  801402:	3c 2f                	cmp    $0x2f,%al
  801404:	7e 19                	jle    80141f <strtol+0xc2>
  801406:	8b 45 08             	mov    0x8(%ebp),%eax
  801409:	8a 00                	mov    (%eax),%al
  80140b:	3c 39                	cmp    $0x39,%al
  80140d:	7f 10                	jg     80141f <strtol+0xc2>
			dig = *s - '0';
  80140f:	8b 45 08             	mov    0x8(%ebp),%eax
  801412:	8a 00                	mov    (%eax),%al
  801414:	0f be c0             	movsbl %al,%eax
  801417:	83 e8 30             	sub    $0x30,%eax
  80141a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80141d:	eb 42                	jmp    801461 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80141f:	8b 45 08             	mov    0x8(%ebp),%eax
  801422:	8a 00                	mov    (%eax),%al
  801424:	3c 60                	cmp    $0x60,%al
  801426:	7e 19                	jle    801441 <strtol+0xe4>
  801428:	8b 45 08             	mov    0x8(%ebp),%eax
  80142b:	8a 00                	mov    (%eax),%al
  80142d:	3c 7a                	cmp    $0x7a,%al
  80142f:	7f 10                	jg     801441 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801431:	8b 45 08             	mov    0x8(%ebp),%eax
  801434:	8a 00                	mov    (%eax),%al
  801436:	0f be c0             	movsbl %al,%eax
  801439:	83 e8 57             	sub    $0x57,%eax
  80143c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80143f:	eb 20                	jmp    801461 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801441:	8b 45 08             	mov    0x8(%ebp),%eax
  801444:	8a 00                	mov    (%eax),%al
  801446:	3c 40                	cmp    $0x40,%al
  801448:	7e 39                	jle    801483 <strtol+0x126>
  80144a:	8b 45 08             	mov    0x8(%ebp),%eax
  80144d:	8a 00                	mov    (%eax),%al
  80144f:	3c 5a                	cmp    $0x5a,%al
  801451:	7f 30                	jg     801483 <strtol+0x126>
			dig = *s - 'A' + 10;
  801453:	8b 45 08             	mov    0x8(%ebp),%eax
  801456:	8a 00                	mov    (%eax),%al
  801458:	0f be c0             	movsbl %al,%eax
  80145b:	83 e8 37             	sub    $0x37,%eax
  80145e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801461:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801464:	3b 45 10             	cmp    0x10(%ebp),%eax
  801467:	7d 19                	jge    801482 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801469:	ff 45 08             	incl   0x8(%ebp)
  80146c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80146f:	0f af 45 10          	imul   0x10(%ebp),%eax
  801473:	89 c2                	mov    %eax,%edx
  801475:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801478:	01 d0                	add    %edx,%eax
  80147a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80147d:	e9 7b ff ff ff       	jmp    8013fd <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801482:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801483:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801487:	74 08                	je     801491 <strtol+0x134>
		*endptr = (char *) s;
  801489:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148c:	8b 55 08             	mov    0x8(%ebp),%edx
  80148f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801491:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801495:	74 07                	je     80149e <strtol+0x141>
  801497:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80149a:	f7 d8                	neg    %eax
  80149c:	eb 03                	jmp    8014a1 <strtol+0x144>
  80149e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014a1:	c9                   	leave  
  8014a2:	c3                   	ret    

008014a3 <ltostr>:

void
ltostr(long value, char *str)
{
  8014a3:	55                   	push   %ebp
  8014a4:	89 e5                	mov    %esp,%ebp
  8014a6:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014b0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014b7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014bb:	79 13                	jns    8014d0 <ltostr+0x2d>
	{
		neg = 1;
  8014bd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c7:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014ca:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8014cd:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014d8:	99                   	cltd   
  8014d9:	f7 f9                	idiv   %ecx
  8014db:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8014de:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014e1:	8d 50 01             	lea    0x1(%eax),%edx
  8014e4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014e7:	89 c2                	mov    %eax,%edx
  8014e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ec:	01 d0                	add    %edx,%eax
  8014ee:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014f1:	83 c2 30             	add    $0x30,%edx
  8014f4:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8014f6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014f9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014fe:	f7 e9                	imul   %ecx
  801500:	c1 fa 02             	sar    $0x2,%edx
  801503:	89 c8                	mov    %ecx,%eax
  801505:	c1 f8 1f             	sar    $0x1f,%eax
  801508:	29 c2                	sub    %eax,%edx
  80150a:	89 d0                	mov    %edx,%eax
  80150c:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80150f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801512:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801517:	f7 e9                	imul   %ecx
  801519:	c1 fa 02             	sar    $0x2,%edx
  80151c:	89 c8                	mov    %ecx,%eax
  80151e:	c1 f8 1f             	sar    $0x1f,%eax
  801521:	29 c2                	sub    %eax,%edx
  801523:	89 d0                	mov    %edx,%eax
  801525:	c1 e0 02             	shl    $0x2,%eax
  801528:	01 d0                	add    %edx,%eax
  80152a:	01 c0                	add    %eax,%eax
  80152c:	29 c1                	sub    %eax,%ecx
  80152e:	89 ca                	mov    %ecx,%edx
  801530:	85 d2                	test   %edx,%edx
  801532:	75 9c                	jne    8014d0 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801534:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80153b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80153e:	48                   	dec    %eax
  80153f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801542:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801546:	74 3d                	je     801585 <ltostr+0xe2>
		start = 1 ;
  801548:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80154f:	eb 34                	jmp    801585 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801551:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801554:	8b 45 0c             	mov    0xc(%ebp),%eax
  801557:	01 d0                	add    %edx,%eax
  801559:	8a 00                	mov    (%eax),%al
  80155b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80155e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801561:	8b 45 0c             	mov    0xc(%ebp),%eax
  801564:	01 c2                	add    %eax,%edx
  801566:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801569:	8b 45 0c             	mov    0xc(%ebp),%eax
  80156c:	01 c8                	add    %ecx,%eax
  80156e:	8a 00                	mov    (%eax),%al
  801570:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801572:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801575:	8b 45 0c             	mov    0xc(%ebp),%eax
  801578:	01 c2                	add    %eax,%edx
  80157a:	8a 45 eb             	mov    -0x15(%ebp),%al
  80157d:	88 02                	mov    %al,(%edx)
		start++ ;
  80157f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801582:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801585:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801588:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80158b:	7c c4                	jl     801551 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80158d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801590:	8b 45 0c             	mov    0xc(%ebp),%eax
  801593:	01 d0                	add    %edx,%eax
  801595:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801598:	90                   	nop
  801599:	c9                   	leave  
  80159a:	c3                   	ret    

0080159b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80159b:	55                   	push   %ebp
  80159c:	89 e5                	mov    %esp,%ebp
  80159e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015a1:	ff 75 08             	pushl  0x8(%ebp)
  8015a4:	e8 54 fa ff ff       	call   800ffd <strlen>
  8015a9:	83 c4 04             	add    $0x4,%esp
  8015ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015af:	ff 75 0c             	pushl  0xc(%ebp)
  8015b2:	e8 46 fa ff ff       	call   800ffd <strlen>
  8015b7:	83 c4 04             	add    $0x4,%esp
  8015ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015cb:	eb 17                	jmp    8015e4 <strcconcat+0x49>
		final[s] = str1[s] ;
  8015cd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d3:	01 c2                	add    %eax,%edx
  8015d5:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015db:	01 c8                	add    %ecx,%eax
  8015dd:	8a 00                	mov    (%eax),%al
  8015df:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8015e1:	ff 45 fc             	incl   -0x4(%ebp)
  8015e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015e7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015ea:	7c e1                	jl     8015cd <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8015ec:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8015f3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8015fa:	eb 1f                	jmp    80161b <strcconcat+0x80>
		final[s++] = str2[i] ;
  8015fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015ff:	8d 50 01             	lea    0x1(%eax),%edx
  801602:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801605:	89 c2                	mov    %eax,%edx
  801607:	8b 45 10             	mov    0x10(%ebp),%eax
  80160a:	01 c2                	add    %eax,%edx
  80160c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80160f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801612:	01 c8                	add    %ecx,%eax
  801614:	8a 00                	mov    (%eax),%al
  801616:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801618:	ff 45 f8             	incl   -0x8(%ebp)
  80161b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80161e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801621:	7c d9                	jl     8015fc <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801623:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801626:	8b 45 10             	mov    0x10(%ebp),%eax
  801629:	01 d0                	add    %edx,%eax
  80162b:	c6 00 00             	movb   $0x0,(%eax)
}
  80162e:	90                   	nop
  80162f:	c9                   	leave  
  801630:	c3                   	ret    

00801631 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801631:	55                   	push   %ebp
  801632:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801634:	8b 45 14             	mov    0x14(%ebp),%eax
  801637:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80163d:	8b 45 14             	mov    0x14(%ebp),%eax
  801640:	8b 00                	mov    (%eax),%eax
  801642:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801649:	8b 45 10             	mov    0x10(%ebp),%eax
  80164c:	01 d0                	add    %edx,%eax
  80164e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801654:	eb 0c                	jmp    801662 <strsplit+0x31>
			*string++ = 0;
  801656:	8b 45 08             	mov    0x8(%ebp),%eax
  801659:	8d 50 01             	lea    0x1(%eax),%edx
  80165c:	89 55 08             	mov    %edx,0x8(%ebp)
  80165f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801662:	8b 45 08             	mov    0x8(%ebp),%eax
  801665:	8a 00                	mov    (%eax),%al
  801667:	84 c0                	test   %al,%al
  801669:	74 18                	je     801683 <strsplit+0x52>
  80166b:	8b 45 08             	mov    0x8(%ebp),%eax
  80166e:	8a 00                	mov    (%eax),%al
  801670:	0f be c0             	movsbl %al,%eax
  801673:	50                   	push   %eax
  801674:	ff 75 0c             	pushl  0xc(%ebp)
  801677:	e8 13 fb ff ff       	call   80118f <strchr>
  80167c:	83 c4 08             	add    $0x8,%esp
  80167f:	85 c0                	test   %eax,%eax
  801681:	75 d3                	jne    801656 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801683:	8b 45 08             	mov    0x8(%ebp),%eax
  801686:	8a 00                	mov    (%eax),%al
  801688:	84 c0                	test   %al,%al
  80168a:	74 5a                	je     8016e6 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80168c:	8b 45 14             	mov    0x14(%ebp),%eax
  80168f:	8b 00                	mov    (%eax),%eax
  801691:	83 f8 0f             	cmp    $0xf,%eax
  801694:	75 07                	jne    80169d <strsplit+0x6c>
		{
			return 0;
  801696:	b8 00 00 00 00       	mov    $0x0,%eax
  80169b:	eb 66                	jmp    801703 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80169d:	8b 45 14             	mov    0x14(%ebp),%eax
  8016a0:	8b 00                	mov    (%eax),%eax
  8016a2:	8d 48 01             	lea    0x1(%eax),%ecx
  8016a5:	8b 55 14             	mov    0x14(%ebp),%edx
  8016a8:	89 0a                	mov    %ecx,(%edx)
  8016aa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8016b4:	01 c2                	add    %eax,%edx
  8016b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b9:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016bb:	eb 03                	jmp    8016c0 <strsplit+0x8f>
			string++;
  8016bd:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c3:	8a 00                	mov    (%eax),%al
  8016c5:	84 c0                	test   %al,%al
  8016c7:	74 8b                	je     801654 <strsplit+0x23>
  8016c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016cc:	8a 00                	mov    (%eax),%al
  8016ce:	0f be c0             	movsbl %al,%eax
  8016d1:	50                   	push   %eax
  8016d2:	ff 75 0c             	pushl  0xc(%ebp)
  8016d5:	e8 b5 fa ff ff       	call   80118f <strchr>
  8016da:	83 c4 08             	add    $0x8,%esp
  8016dd:	85 c0                	test   %eax,%eax
  8016df:	74 dc                	je     8016bd <strsplit+0x8c>
			string++;
	}
  8016e1:	e9 6e ff ff ff       	jmp    801654 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8016e6:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8016e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8016ea:	8b 00                	mov    (%eax),%eax
  8016ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8016f6:	01 d0                	add    %edx,%eax
  8016f8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8016fe:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801703:	c9                   	leave  
  801704:	c3                   	ret    

00801705 <malloc>:
int sizeofarray=0;
uint32 addresses[1000];
int changed[1000];
int numOfPages[1000];
void* malloc(uint32 size)
{
  801705:	55                   	push   %ebp
  801706:	89 e5                	mov    %esp,%ebp
  801708:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  80170b:	8b 45 08             	mov    0x8(%ebp),%eax
  80170e:	c1 e8 0c             	shr    $0xc,%eax
  801711:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  801714:	8b 45 08             	mov    0x8(%ebp),%eax
  801717:	25 ff 0f 00 00       	and    $0xfff,%eax
  80171c:	85 c0                	test   %eax,%eax
  80171e:	74 03                	je     801723 <malloc+0x1e>
			num++;
  801720:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  801723:	a1 04 30 80 00       	mov    0x803004,%eax
  801728:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  80172d:	75 73                	jne    8017a2 <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  80172f:	83 ec 08             	sub    $0x8,%esp
  801732:	ff 75 08             	pushl  0x8(%ebp)
  801735:	68 00 00 00 80       	push   $0x80000000
  80173a:	e8 80 04 00 00       	call   801bbf <sys_allocateMem>
  80173f:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  801742:	a1 04 30 80 00       	mov    0x803004,%eax
  801747:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  80174a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80174d:	c1 e0 0c             	shl    $0xc,%eax
  801750:	89 c2                	mov    %eax,%edx
  801752:	a1 04 30 80 00       	mov    0x803004,%eax
  801757:	01 d0                	add    %edx,%eax
  801759:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  80175e:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801763:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801766:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
			addresses[sizeofarray]=last_addres;
  80176d:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801772:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801778:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  80177f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801784:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  80178b:	01 00 00 00 
			sizeofarray++;
  80178f:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801794:	40                   	inc    %eax
  801795:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  80179a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80179d:	e9 71 01 00 00       	jmp    801913 <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  8017a2:	a1 28 30 80 00       	mov    0x803028,%eax
  8017a7:	85 c0                	test   %eax,%eax
  8017a9:	75 71                	jne    80181c <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  8017ab:	a1 04 30 80 00       	mov    0x803004,%eax
  8017b0:	83 ec 08             	sub    $0x8,%esp
  8017b3:	ff 75 08             	pushl  0x8(%ebp)
  8017b6:	50                   	push   %eax
  8017b7:	e8 03 04 00 00       	call   801bbf <sys_allocateMem>
  8017bc:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  8017bf:	a1 04 30 80 00       	mov    0x803004,%eax
  8017c4:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  8017c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017ca:	c1 e0 0c             	shl    $0xc,%eax
  8017cd:	89 c2                	mov    %eax,%edx
  8017cf:	a1 04 30 80 00       	mov    0x803004,%eax
  8017d4:	01 d0                	add    %edx,%eax
  8017d6:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  8017db:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017e0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017e3:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=return_addres;
  8017ea:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017ef:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8017f2:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  8017f9:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8017fe:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  801805:	01 00 00 00 
				sizeofarray++;
  801809:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80180e:	40                   	inc    %eax
  80180f:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  801814:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801817:	e9 f7 00 00 00       	jmp    801913 <malloc+0x20e>
			}
			else{
				int count=0;
  80181c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801823:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  80182a:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801831:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801838:	eb 7c                	jmp    8018b6 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  80183a:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  801841:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801848:	eb 1a                	jmp    801864 <malloc+0x15f>
					{
						if(addresses[j]==i)
  80184a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80184d:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801854:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801857:	75 08                	jne    801861 <malloc+0x15c>
						{
							index=j;
  801859:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80185c:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  80185f:	eb 0d                	jmp    80186e <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801861:	ff 45 dc             	incl   -0x24(%ebp)
  801864:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801869:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  80186c:	7c dc                	jl     80184a <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  80186e:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801872:	75 05                	jne    801879 <malloc+0x174>
					{
						count++;
  801874:	ff 45 f0             	incl   -0x10(%ebp)
  801877:	eb 36                	jmp    8018af <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  801879:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80187c:	8b 04 85 c0 40 80 00 	mov    0x8040c0(,%eax,4),%eax
  801883:	85 c0                	test   %eax,%eax
  801885:	75 05                	jne    80188c <malloc+0x187>
						{
							count++;
  801887:	ff 45 f0             	incl   -0x10(%ebp)
  80188a:	eb 23                	jmp    8018af <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  80188c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80188f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801892:	7d 14                	jge    8018a8 <malloc+0x1a3>
  801894:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801897:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80189a:	7c 0c                	jl     8018a8 <malloc+0x1a3>
							{
								min=count;
  80189c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80189f:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  8018a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8018a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  8018a8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8018af:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  8018b6:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  8018bd:	0f 86 77 ff ff ff    	jbe    80183a <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  8018c3:	83 ec 08             	sub    $0x8,%esp
  8018c6:	ff 75 08             	pushl  0x8(%ebp)
  8018c9:	ff 75 e4             	pushl  -0x1c(%ebp)
  8018cc:	e8 ee 02 00 00       	call   801bbf <sys_allocateMem>
  8018d1:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  8018d4:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8018d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018dc:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=last_addres;
  8018e3:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8018e8:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8018ee:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  8018f5:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8018fa:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  801901:	01 00 00 00 
				sizeofarray++;
  801905:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80190a:	40                   	inc    %eax
  80190b:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return(void*) min_addresss;
  801910:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801913:	c9                   	leave  
  801914:	c3                   	ret    

00801915 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801915:	55                   	push   %ebp
  801916:	89 e5                	mov    %esp,%ebp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address

	//refer to the project presentation and documentation for details
}
  801918:	90                   	nop
  801919:	5d                   	pop    %ebp
  80191a:	c3                   	ret    

0080191b <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80191b:	55                   	push   %ebp
  80191c:	89 e5                	mov    %esp,%ebp
  80191e:	83 ec 18             	sub    $0x18,%esp
  801921:	8b 45 10             	mov    0x10(%ebp),%eax
  801924:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801927:	83 ec 04             	sub    $0x4,%esp
  80192a:	68 d0 2b 80 00       	push   $0x802bd0
  80192f:	68 8d 00 00 00       	push   $0x8d
  801934:	68 f3 2b 80 00       	push   $0x802bf3
  801939:	e8 9b ed ff ff       	call   8006d9 <_panic>

0080193e <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80193e:	55                   	push   %ebp
  80193f:	89 e5                	mov    %esp,%ebp
  801941:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801944:	83 ec 04             	sub    $0x4,%esp
  801947:	68 d0 2b 80 00       	push   $0x802bd0
  80194c:	68 93 00 00 00       	push   $0x93
  801951:	68 f3 2b 80 00       	push   $0x802bf3
  801956:	e8 7e ed ff ff       	call   8006d9 <_panic>

0080195b <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  80195b:	55                   	push   %ebp
  80195c:	89 e5                	mov    %esp,%ebp
  80195e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801961:	83 ec 04             	sub    $0x4,%esp
  801964:	68 d0 2b 80 00       	push   $0x802bd0
  801969:	68 99 00 00 00       	push   $0x99
  80196e:	68 f3 2b 80 00       	push   $0x802bf3
  801973:	e8 61 ed ff ff       	call   8006d9 <_panic>

00801978 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801978:	55                   	push   %ebp
  801979:	89 e5                	mov    %esp,%ebp
  80197b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80197e:	83 ec 04             	sub    $0x4,%esp
  801981:	68 d0 2b 80 00       	push   $0x802bd0
  801986:	68 9e 00 00 00       	push   $0x9e
  80198b:	68 f3 2b 80 00       	push   $0x802bf3
  801990:	e8 44 ed ff ff       	call   8006d9 <_panic>

00801995 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801995:	55                   	push   %ebp
  801996:	89 e5                	mov    %esp,%ebp
  801998:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80199b:	83 ec 04             	sub    $0x4,%esp
  80199e:	68 d0 2b 80 00       	push   $0x802bd0
  8019a3:	68 a4 00 00 00       	push   $0xa4
  8019a8:	68 f3 2b 80 00       	push   $0x802bf3
  8019ad:	e8 27 ed ff ff       	call   8006d9 <_panic>

008019b2 <shrink>:
}
void shrink(uint32 newSize)
{
  8019b2:	55                   	push   %ebp
  8019b3:	89 e5                	mov    %esp,%ebp
  8019b5:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8019b8:	83 ec 04             	sub    $0x4,%esp
  8019bb:	68 d0 2b 80 00       	push   $0x802bd0
  8019c0:	68 a8 00 00 00       	push   $0xa8
  8019c5:	68 f3 2b 80 00       	push   $0x802bf3
  8019ca:	e8 0a ed ff ff       	call   8006d9 <_panic>

008019cf <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8019cf:	55                   	push   %ebp
  8019d0:	89 e5                	mov    %esp,%ebp
  8019d2:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8019d5:	83 ec 04             	sub    $0x4,%esp
  8019d8:	68 d0 2b 80 00       	push   $0x802bd0
  8019dd:	68 ad 00 00 00       	push   $0xad
  8019e2:	68 f3 2b 80 00       	push   $0x802bf3
  8019e7:	e8 ed ec ff ff       	call   8006d9 <_panic>

008019ec <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8019ec:	55                   	push   %ebp
  8019ed:	89 e5                	mov    %esp,%ebp
  8019ef:	57                   	push   %edi
  8019f0:	56                   	push   %esi
  8019f1:	53                   	push   %ebx
  8019f2:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8019f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019fb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8019fe:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a01:	8b 7d 18             	mov    0x18(%ebp),%edi
  801a04:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801a07:	cd 30                	int    $0x30
  801a09:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801a0c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a0f:	83 c4 10             	add    $0x10,%esp
  801a12:	5b                   	pop    %ebx
  801a13:	5e                   	pop    %esi
  801a14:	5f                   	pop    %edi
  801a15:	5d                   	pop    %ebp
  801a16:	c3                   	ret    

00801a17 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801a17:	55                   	push   %ebp
  801a18:	89 e5                	mov    %esp,%ebp
  801a1a:	83 ec 04             	sub    $0x4,%esp
  801a1d:	8b 45 10             	mov    0x10(%ebp),%eax
  801a20:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801a23:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a27:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2a:	6a 00                	push   $0x0
  801a2c:	6a 00                	push   $0x0
  801a2e:	52                   	push   %edx
  801a2f:	ff 75 0c             	pushl  0xc(%ebp)
  801a32:	50                   	push   %eax
  801a33:	6a 00                	push   $0x0
  801a35:	e8 b2 ff ff ff       	call   8019ec <syscall>
  801a3a:	83 c4 18             	add    $0x18,%esp
}
  801a3d:	90                   	nop
  801a3e:	c9                   	leave  
  801a3f:	c3                   	ret    

00801a40 <sys_cgetc>:

int
sys_cgetc(void)
{
  801a40:	55                   	push   %ebp
  801a41:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801a43:	6a 00                	push   $0x0
  801a45:	6a 00                	push   $0x0
  801a47:	6a 00                	push   $0x0
  801a49:	6a 00                	push   $0x0
  801a4b:	6a 00                	push   $0x0
  801a4d:	6a 01                	push   $0x1
  801a4f:	e8 98 ff ff ff       	call   8019ec <syscall>
  801a54:	83 c4 18             	add    $0x18,%esp
}
  801a57:	c9                   	leave  
  801a58:	c3                   	ret    

00801a59 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801a59:	55                   	push   %ebp
  801a5a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801a5c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5f:	6a 00                	push   $0x0
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	50                   	push   %eax
  801a68:	6a 05                	push   $0x5
  801a6a:	e8 7d ff ff ff       	call   8019ec <syscall>
  801a6f:	83 c4 18             	add    $0x18,%esp
}
  801a72:	c9                   	leave  
  801a73:	c3                   	ret    

00801a74 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801a74:	55                   	push   %ebp
  801a75:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801a77:	6a 00                	push   $0x0
  801a79:	6a 00                	push   $0x0
  801a7b:	6a 00                	push   $0x0
  801a7d:	6a 00                	push   $0x0
  801a7f:	6a 00                	push   $0x0
  801a81:	6a 02                	push   $0x2
  801a83:	e8 64 ff ff ff       	call   8019ec <syscall>
  801a88:	83 c4 18             	add    $0x18,%esp
}
  801a8b:	c9                   	leave  
  801a8c:	c3                   	ret    

00801a8d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801a8d:	55                   	push   %ebp
  801a8e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801a90:	6a 00                	push   $0x0
  801a92:	6a 00                	push   $0x0
  801a94:	6a 00                	push   $0x0
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 03                	push   $0x3
  801a9c:	e8 4b ff ff ff       	call   8019ec <syscall>
  801aa1:	83 c4 18             	add    $0x18,%esp
}
  801aa4:	c9                   	leave  
  801aa5:	c3                   	ret    

00801aa6 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801aa6:	55                   	push   %ebp
  801aa7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801aa9:	6a 00                	push   $0x0
  801aab:	6a 00                	push   $0x0
  801aad:	6a 00                	push   $0x0
  801aaf:	6a 00                	push   $0x0
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 04                	push   $0x4
  801ab5:	e8 32 ff ff ff       	call   8019ec <syscall>
  801aba:	83 c4 18             	add    $0x18,%esp
}
  801abd:	c9                   	leave  
  801abe:	c3                   	ret    

00801abf <sys_env_exit>:


void sys_env_exit(void)
{
  801abf:	55                   	push   %ebp
  801ac0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801ac2:	6a 00                	push   $0x0
  801ac4:	6a 00                	push   $0x0
  801ac6:	6a 00                	push   $0x0
  801ac8:	6a 00                	push   $0x0
  801aca:	6a 00                	push   $0x0
  801acc:	6a 06                	push   $0x6
  801ace:	e8 19 ff ff ff       	call   8019ec <syscall>
  801ad3:	83 c4 18             	add    $0x18,%esp
}
  801ad6:	90                   	nop
  801ad7:	c9                   	leave  
  801ad8:	c3                   	ret    

00801ad9 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801ad9:	55                   	push   %ebp
  801ada:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801adc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801adf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae2:	6a 00                	push   $0x0
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	52                   	push   %edx
  801ae9:	50                   	push   %eax
  801aea:	6a 07                	push   $0x7
  801aec:	e8 fb fe ff ff       	call   8019ec <syscall>
  801af1:	83 c4 18             	add    $0x18,%esp
}
  801af4:	c9                   	leave  
  801af5:	c3                   	ret    

00801af6 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801af6:	55                   	push   %ebp
  801af7:	89 e5                	mov    %esp,%ebp
  801af9:	56                   	push   %esi
  801afa:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801afb:	8b 75 18             	mov    0x18(%ebp),%esi
  801afe:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b01:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b04:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b07:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0a:	56                   	push   %esi
  801b0b:	53                   	push   %ebx
  801b0c:	51                   	push   %ecx
  801b0d:	52                   	push   %edx
  801b0e:	50                   	push   %eax
  801b0f:	6a 08                	push   $0x8
  801b11:	e8 d6 fe ff ff       	call   8019ec <syscall>
  801b16:	83 c4 18             	add    $0x18,%esp
}
  801b19:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801b1c:	5b                   	pop    %ebx
  801b1d:	5e                   	pop    %esi
  801b1e:	5d                   	pop    %ebp
  801b1f:	c3                   	ret    

00801b20 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801b20:	55                   	push   %ebp
  801b21:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801b23:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b26:	8b 45 08             	mov    0x8(%ebp),%eax
  801b29:	6a 00                	push   $0x0
  801b2b:	6a 00                	push   $0x0
  801b2d:	6a 00                	push   $0x0
  801b2f:	52                   	push   %edx
  801b30:	50                   	push   %eax
  801b31:	6a 09                	push   $0x9
  801b33:	e8 b4 fe ff ff       	call   8019ec <syscall>
  801b38:	83 c4 18             	add    $0x18,%esp
}
  801b3b:	c9                   	leave  
  801b3c:	c3                   	ret    

00801b3d <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801b3d:	55                   	push   %ebp
  801b3e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801b40:	6a 00                	push   $0x0
  801b42:	6a 00                	push   $0x0
  801b44:	6a 00                	push   $0x0
  801b46:	ff 75 0c             	pushl  0xc(%ebp)
  801b49:	ff 75 08             	pushl  0x8(%ebp)
  801b4c:	6a 0a                	push   $0xa
  801b4e:	e8 99 fe ff ff       	call   8019ec <syscall>
  801b53:	83 c4 18             	add    $0x18,%esp
}
  801b56:	c9                   	leave  
  801b57:	c3                   	ret    

00801b58 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801b58:	55                   	push   %ebp
  801b59:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801b5b:	6a 00                	push   $0x0
  801b5d:	6a 00                	push   $0x0
  801b5f:	6a 00                	push   $0x0
  801b61:	6a 00                	push   $0x0
  801b63:	6a 00                	push   $0x0
  801b65:	6a 0b                	push   $0xb
  801b67:	e8 80 fe ff ff       	call   8019ec <syscall>
  801b6c:	83 c4 18             	add    $0x18,%esp
}
  801b6f:	c9                   	leave  
  801b70:	c3                   	ret    

00801b71 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801b71:	55                   	push   %ebp
  801b72:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801b74:	6a 00                	push   $0x0
  801b76:	6a 00                	push   $0x0
  801b78:	6a 00                	push   $0x0
  801b7a:	6a 00                	push   $0x0
  801b7c:	6a 00                	push   $0x0
  801b7e:	6a 0c                	push   $0xc
  801b80:	e8 67 fe ff ff       	call   8019ec <syscall>
  801b85:	83 c4 18             	add    $0x18,%esp
}
  801b88:	c9                   	leave  
  801b89:	c3                   	ret    

00801b8a <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801b8a:	55                   	push   %ebp
  801b8b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801b8d:	6a 00                	push   $0x0
  801b8f:	6a 00                	push   $0x0
  801b91:	6a 00                	push   $0x0
  801b93:	6a 00                	push   $0x0
  801b95:	6a 00                	push   $0x0
  801b97:	6a 0d                	push   $0xd
  801b99:	e8 4e fe ff ff       	call   8019ec <syscall>
  801b9e:	83 c4 18             	add    $0x18,%esp
}
  801ba1:	c9                   	leave  
  801ba2:	c3                   	ret    

00801ba3 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801ba3:	55                   	push   %ebp
  801ba4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801ba6:	6a 00                	push   $0x0
  801ba8:	6a 00                	push   $0x0
  801baa:	6a 00                	push   $0x0
  801bac:	ff 75 0c             	pushl  0xc(%ebp)
  801baf:	ff 75 08             	pushl  0x8(%ebp)
  801bb2:	6a 11                	push   $0x11
  801bb4:	e8 33 fe ff ff       	call   8019ec <syscall>
  801bb9:	83 c4 18             	add    $0x18,%esp
	return;
  801bbc:	90                   	nop
}
  801bbd:	c9                   	leave  
  801bbe:	c3                   	ret    

00801bbf <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801bbf:	55                   	push   %ebp
  801bc0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801bc2:	6a 00                	push   $0x0
  801bc4:	6a 00                	push   $0x0
  801bc6:	6a 00                	push   $0x0
  801bc8:	ff 75 0c             	pushl  0xc(%ebp)
  801bcb:	ff 75 08             	pushl  0x8(%ebp)
  801bce:	6a 12                	push   $0x12
  801bd0:	e8 17 fe ff ff       	call   8019ec <syscall>
  801bd5:	83 c4 18             	add    $0x18,%esp
	return ;
  801bd8:	90                   	nop
}
  801bd9:	c9                   	leave  
  801bda:	c3                   	ret    

00801bdb <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801bdb:	55                   	push   %ebp
  801bdc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801bde:	6a 00                	push   $0x0
  801be0:	6a 00                	push   $0x0
  801be2:	6a 00                	push   $0x0
  801be4:	6a 00                	push   $0x0
  801be6:	6a 00                	push   $0x0
  801be8:	6a 0e                	push   $0xe
  801bea:	e8 fd fd ff ff       	call   8019ec <syscall>
  801bef:	83 c4 18             	add    $0x18,%esp
}
  801bf2:	c9                   	leave  
  801bf3:	c3                   	ret    

00801bf4 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801bf4:	55                   	push   %ebp
  801bf5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801bf7:	6a 00                	push   $0x0
  801bf9:	6a 00                	push   $0x0
  801bfb:	6a 00                	push   $0x0
  801bfd:	6a 00                	push   $0x0
  801bff:	ff 75 08             	pushl  0x8(%ebp)
  801c02:	6a 0f                	push   $0xf
  801c04:	e8 e3 fd ff ff       	call   8019ec <syscall>
  801c09:	83 c4 18             	add    $0x18,%esp
}
  801c0c:	c9                   	leave  
  801c0d:	c3                   	ret    

00801c0e <sys_scarce_memory>:

void sys_scarce_memory()
{
  801c0e:	55                   	push   %ebp
  801c0f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801c11:	6a 00                	push   $0x0
  801c13:	6a 00                	push   $0x0
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	6a 00                	push   $0x0
  801c1b:	6a 10                	push   $0x10
  801c1d:	e8 ca fd ff ff       	call   8019ec <syscall>
  801c22:	83 c4 18             	add    $0x18,%esp
}
  801c25:	90                   	nop
  801c26:	c9                   	leave  
  801c27:	c3                   	ret    

00801c28 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801c28:	55                   	push   %ebp
  801c29:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	6a 00                	push   $0x0
  801c31:	6a 00                	push   $0x0
  801c33:	6a 00                	push   $0x0
  801c35:	6a 14                	push   $0x14
  801c37:	e8 b0 fd ff ff       	call   8019ec <syscall>
  801c3c:	83 c4 18             	add    $0x18,%esp
}
  801c3f:	90                   	nop
  801c40:	c9                   	leave  
  801c41:	c3                   	ret    

00801c42 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801c42:	55                   	push   %ebp
  801c43:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801c45:	6a 00                	push   $0x0
  801c47:	6a 00                	push   $0x0
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 00                	push   $0x0
  801c4d:	6a 00                	push   $0x0
  801c4f:	6a 15                	push   $0x15
  801c51:	e8 96 fd ff ff       	call   8019ec <syscall>
  801c56:	83 c4 18             	add    $0x18,%esp
}
  801c59:	90                   	nop
  801c5a:	c9                   	leave  
  801c5b:	c3                   	ret    

00801c5c <sys_cputc>:


void
sys_cputc(const char c)
{
  801c5c:	55                   	push   %ebp
  801c5d:	89 e5                	mov    %esp,%ebp
  801c5f:	83 ec 04             	sub    $0x4,%esp
  801c62:	8b 45 08             	mov    0x8(%ebp),%eax
  801c65:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801c68:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c6c:	6a 00                	push   $0x0
  801c6e:	6a 00                	push   $0x0
  801c70:	6a 00                	push   $0x0
  801c72:	6a 00                	push   $0x0
  801c74:	50                   	push   %eax
  801c75:	6a 16                	push   $0x16
  801c77:	e8 70 fd ff ff       	call   8019ec <syscall>
  801c7c:	83 c4 18             	add    $0x18,%esp
}
  801c7f:	90                   	nop
  801c80:	c9                   	leave  
  801c81:	c3                   	ret    

00801c82 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801c82:	55                   	push   %ebp
  801c83:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801c85:	6a 00                	push   $0x0
  801c87:	6a 00                	push   $0x0
  801c89:	6a 00                	push   $0x0
  801c8b:	6a 00                	push   $0x0
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 17                	push   $0x17
  801c91:	e8 56 fd ff ff       	call   8019ec <syscall>
  801c96:	83 c4 18             	add    $0x18,%esp
}
  801c99:	90                   	nop
  801c9a:	c9                   	leave  
  801c9b:	c3                   	ret    

00801c9c <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801c9c:	55                   	push   %ebp
  801c9d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801c9f:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca2:	6a 00                	push   $0x0
  801ca4:	6a 00                	push   $0x0
  801ca6:	6a 00                	push   $0x0
  801ca8:	ff 75 0c             	pushl  0xc(%ebp)
  801cab:	50                   	push   %eax
  801cac:	6a 18                	push   $0x18
  801cae:	e8 39 fd ff ff       	call   8019ec <syscall>
  801cb3:	83 c4 18             	add    $0x18,%esp
}
  801cb6:	c9                   	leave  
  801cb7:	c3                   	ret    

00801cb8 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801cb8:	55                   	push   %ebp
  801cb9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cbb:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cbe:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc1:	6a 00                	push   $0x0
  801cc3:	6a 00                	push   $0x0
  801cc5:	6a 00                	push   $0x0
  801cc7:	52                   	push   %edx
  801cc8:	50                   	push   %eax
  801cc9:	6a 1b                	push   $0x1b
  801ccb:	e8 1c fd ff ff       	call   8019ec <syscall>
  801cd0:	83 c4 18             	add    $0x18,%esp
}
  801cd3:	c9                   	leave  
  801cd4:	c3                   	ret    

00801cd5 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801cd5:	55                   	push   %ebp
  801cd6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cd8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cdb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cde:	6a 00                	push   $0x0
  801ce0:	6a 00                	push   $0x0
  801ce2:	6a 00                	push   $0x0
  801ce4:	52                   	push   %edx
  801ce5:	50                   	push   %eax
  801ce6:	6a 19                	push   $0x19
  801ce8:	e8 ff fc ff ff       	call   8019ec <syscall>
  801ced:	83 c4 18             	add    $0x18,%esp
}
  801cf0:	90                   	nop
  801cf1:	c9                   	leave  
  801cf2:	c3                   	ret    

00801cf3 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801cf3:	55                   	push   %ebp
  801cf4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801cf6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cf9:	8b 45 08             	mov    0x8(%ebp),%eax
  801cfc:	6a 00                	push   $0x0
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 00                	push   $0x0
  801d02:	52                   	push   %edx
  801d03:	50                   	push   %eax
  801d04:	6a 1a                	push   $0x1a
  801d06:	e8 e1 fc ff ff       	call   8019ec <syscall>
  801d0b:	83 c4 18             	add    $0x18,%esp
}
  801d0e:	90                   	nop
  801d0f:	c9                   	leave  
  801d10:	c3                   	ret    

00801d11 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801d11:	55                   	push   %ebp
  801d12:	89 e5                	mov    %esp,%ebp
  801d14:	83 ec 04             	sub    $0x4,%esp
  801d17:	8b 45 10             	mov    0x10(%ebp),%eax
  801d1a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801d1d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d20:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d24:	8b 45 08             	mov    0x8(%ebp),%eax
  801d27:	6a 00                	push   $0x0
  801d29:	51                   	push   %ecx
  801d2a:	52                   	push   %edx
  801d2b:	ff 75 0c             	pushl  0xc(%ebp)
  801d2e:	50                   	push   %eax
  801d2f:	6a 1c                	push   $0x1c
  801d31:	e8 b6 fc ff ff       	call   8019ec <syscall>
  801d36:	83 c4 18             	add    $0x18,%esp
}
  801d39:	c9                   	leave  
  801d3a:	c3                   	ret    

00801d3b <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801d3b:	55                   	push   %ebp
  801d3c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801d3e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d41:	8b 45 08             	mov    0x8(%ebp),%eax
  801d44:	6a 00                	push   $0x0
  801d46:	6a 00                	push   $0x0
  801d48:	6a 00                	push   $0x0
  801d4a:	52                   	push   %edx
  801d4b:	50                   	push   %eax
  801d4c:	6a 1d                	push   $0x1d
  801d4e:	e8 99 fc ff ff       	call   8019ec <syscall>
  801d53:	83 c4 18             	add    $0x18,%esp
}
  801d56:	c9                   	leave  
  801d57:	c3                   	ret    

00801d58 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801d58:	55                   	push   %ebp
  801d59:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801d5b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d5e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d61:	8b 45 08             	mov    0x8(%ebp),%eax
  801d64:	6a 00                	push   $0x0
  801d66:	6a 00                	push   $0x0
  801d68:	51                   	push   %ecx
  801d69:	52                   	push   %edx
  801d6a:	50                   	push   %eax
  801d6b:	6a 1e                	push   $0x1e
  801d6d:	e8 7a fc ff ff       	call   8019ec <syscall>
  801d72:	83 c4 18             	add    $0x18,%esp
}
  801d75:	c9                   	leave  
  801d76:	c3                   	ret    

00801d77 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801d77:	55                   	push   %ebp
  801d78:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801d7a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d7d:	8b 45 08             	mov    0x8(%ebp),%eax
  801d80:	6a 00                	push   $0x0
  801d82:	6a 00                	push   $0x0
  801d84:	6a 00                	push   $0x0
  801d86:	52                   	push   %edx
  801d87:	50                   	push   %eax
  801d88:	6a 1f                	push   $0x1f
  801d8a:	e8 5d fc ff ff       	call   8019ec <syscall>
  801d8f:	83 c4 18             	add    $0x18,%esp
}
  801d92:	c9                   	leave  
  801d93:	c3                   	ret    

00801d94 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801d94:	55                   	push   %ebp
  801d95:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801d97:	6a 00                	push   $0x0
  801d99:	6a 00                	push   $0x0
  801d9b:	6a 00                	push   $0x0
  801d9d:	6a 00                	push   $0x0
  801d9f:	6a 00                	push   $0x0
  801da1:	6a 20                	push   $0x20
  801da3:	e8 44 fc ff ff       	call   8019ec <syscall>
  801da8:	83 c4 18             	add    $0x18,%esp
}
  801dab:	c9                   	leave  
  801dac:	c3                   	ret    

00801dad <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801dad:	55                   	push   %ebp
  801dae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801db0:	8b 45 08             	mov    0x8(%ebp),%eax
  801db3:	6a 00                	push   $0x0
  801db5:	ff 75 14             	pushl  0x14(%ebp)
  801db8:	ff 75 10             	pushl  0x10(%ebp)
  801dbb:	ff 75 0c             	pushl  0xc(%ebp)
  801dbe:	50                   	push   %eax
  801dbf:	6a 21                	push   $0x21
  801dc1:	e8 26 fc ff ff       	call   8019ec <syscall>
  801dc6:	83 c4 18             	add    $0x18,%esp
}
  801dc9:	c9                   	leave  
  801dca:	c3                   	ret    

00801dcb <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801dcb:	55                   	push   %ebp
  801dcc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801dce:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd1:	6a 00                	push   $0x0
  801dd3:	6a 00                	push   $0x0
  801dd5:	6a 00                	push   $0x0
  801dd7:	6a 00                	push   $0x0
  801dd9:	50                   	push   %eax
  801dda:	6a 22                	push   $0x22
  801ddc:	e8 0b fc ff ff       	call   8019ec <syscall>
  801de1:	83 c4 18             	add    $0x18,%esp
}
  801de4:	90                   	nop
  801de5:	c9                   	leave  
  801de6:	c3                   	ret    

00801de7 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801de7:	55                   	push   %ebp
  801de8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801dea:	8b 45 08             	mov    0x8(%ebp),%eax
  801ded:	6a 00                	push   $0x0
  801def:	6a 00                	push   $0x0
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	50                   	push   %eax
  801df6:	6a 23                	push   $0x23
  801df8:	e8 ef fb ff ff       	call   8019ec <syscall>
  801dfd:	83 c4 18             	add    $0x18,%esp
}
  801e00:	90                   	nop
  801e01:	c9                   	leave  
  801e02:	c3                   	ret    

00801e03 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801e03:	55                   	push   %ebp
  801e04:	89 e5                	mov    %esp,%ebp
  801e06:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801e09:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e0c:	8d 50 04             	lea    0x4(%eax),%edx
  801e0f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e12:	6a 00                	push   $0x0
  801e14:	6a 00                	push   $0x0
  801e16:	6a 00                	push   $0x0
  801e18:	52                   	push   %edx
  801e19:	50                   	push   %eax
  801e1a:	6a 24                	push   $0x24
  801e1c:	e8 cb fb ff ff       	call   8019ec <syscall>
  801e21:	83 c4 18             	add    $0x18,%esp
	return result;
  801e24:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801e27:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e2a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e2d:	89 01                	mov    %eax,(%ecx)
  801e2f:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801e32:	8b 45 08             	mov    0x8(%ebp),%eax
  801e35:	c9                   	leave  
  801e36:	c2 04 00             	ret    $0x4

00801e39 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801e39:	55                   	push   %ebp
  801e3a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801e3c:	6a 00                	push   $0x0
  801e3e:	6a 00                	push   $0x0
  801e40:	ff 75 10             	pushl  0x10(%ebp)
  801e43:	ff 75 0c             	pushl  0xc(%ebp)
  801e46:	ff 75 08             	pushl  0x8(%ebp)
  801e49:	6a 13                	push   $0x13
  801e4b:	e8 9c fb ff ff       	call   8019ec <syscall>
  801e50:	83 c4 18             	add    $0x18,%esp
	return ;
  801e53:	90                   	nop
}
  801e54:	c9                   	leave  
  801e55:	c3                   	ret    

00801e56 <sys_rcr2>:
uint32 sys_rcr2()
{
  801e56:	55                   	push   %ebp
  801e57:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801e59:	6a 00                	push   $0x0
  801e5b:	6a 00                	push   $0x0
  801e5d:	6a 00                	push   $0x0
  801e5f:	6a 00                	push   $0x0
  801e61:	6a 00                	push   $0x0
  801e63:	6a 25                	push   $0x25
  801e65:	e8 82 fb ff ff       	call   8019ec <syscall>
  801e6a:	83 c4 18             	add    $0x18,%esp
}
  801e6d:	c9                   	leave  
  801e6e:	c3                   	ret    

00801e6f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801e6f:	55                   	push   %ebp
  801e70:	89 e5                	mov    %esp,%ebp
  801e72:	83 ec 04             	sub    $0x4,%esp
  801e75:	8b 45 08             	mov    0x8(%ebp),%eax
  801e78:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801e7b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801e7f:	6a 00                	push   $0x0
  801e81:	6a 00                	push   $0x0
  801e83:	6a 00                	push   $0x0
  801e85:	6a 00                	push   $0x0
  801e87:	50                   	push   %eax
  801e88:	6a 26                	push   $0x26
  801e8a:	e8 5d fb ff ff       	call   8019ec <syscall>
  801e8f:	83 c4 18             	add    $0x18,%esp
	return ;
  801e92:	90                   	nop
}
  801e93:	c9                   	leave  
  801e94:	c3                   	ret    

00801e95 <rsttst>:
void rsttst()
{
  801e95:	55                   	push   %ebp
  801e96:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801e98:	6a 00                	push   $0x0
  801e9a:	6a 00                	push   $0x0
  801e9c:	6a 00                	push   $0x0
  801e9e:	6a 00                	push   $0x0
  801ea0:	6a 00                	push   $0x0
  801ea2:	6a 28                	push   $0x28
  801ea4:	e8 43 fb ff ff       	call   8019ec <syscall>
  801ea9:	83 c4 18             	add    $0x18,%esp
	return ;
  801eac:	90                   	nop
}
  801ead:	c9                   	leave  
  801eae:	c3                   	ret    

00801eaf <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801eaf:	55                   	push   %ebp
  801eb0:	89 e5                	mov    %esp,%ebp
  801eb2:	83 ec 04             	sub    $0x4,%esp
  801eb5:	8b 45 14             	mov    0x14(%ebp),%eax
  801eb8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801ebb:	8b 55 18             	mov    0x18(%ebp),%edx
  801ebe:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ec2:	52                   	push   %edx
  801ec3:	50                   	push   %eax
  801ec4:	ff 75 10             	pushl  0x10(%ebp)
  801ec7:	ff 75 0c             	pushl  0xc(%ebp)
  801eca:	ff 75 08             	pushl  0x8(%ebp)
  801ecd:	6a 27                	push   $0x27
  801ecf:	e8 18 fb ff ff       	call   8019ec <syscall>
  801ed4:	83 c4 18             	add    $0x18,%esp
	return ;
  801ed7:	90                   	nop
}
  801ed8:	c9                   	leave  
  801ed9:	c3                   	ret    

00801eda <chktst>:
void chktst(uint32 n)
{
  801eda:	55                   	push   %ebp
  801edb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 00                	push   $0x0
  801ee3:	6a 00                	push   $0x0
  801ee5:	ff 75 08             	pushl  0x8(%ebp)
  801ee8:	6a 29                	push   $0x29
  801eea:	e8 fd fa ff ff       	call   8019ec <syscall>
  801eef:	83 c4 18             	add    $0x18,%esp
	return ;
  801ef2:	90                   	nop
}
  801ef3:	c9                   	leave  
  801ef4:	c3                   	ret    

00801ef5 <inctst>:

void inctst()
{
  801ef5:	55                   	push   %ebp
  801ef6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801ef8:	6a 00                	push   $0x0
  801efa:	6a 00                	push   $0x0
  801efc:	6a 00                	push   $0x0
  801efe:	6a 00                	push   $0x0
  801f00:	6a 00                	push   $0x0
  801f02:	6a 2a                	push   $0x2a
  801f04:	e8 e3 fa ff ff       	call   8019ec <syscall>
  801f09:	83 c4 18             	add    $0x18,%esp
	return ;
  801f0c:	90                   	nop
}
  801f0d:	c9                   	leave  
  801f0e:	c3                   	ret    

00801f0f <gettst>:
uint32 gettst()
{
  801f0f:	55                   	push   %ebp
  801f10:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801f12:	6a 00                	push   $0x0
  801f14:	6a 00                	push   $0x0
  801f16:	6a 00                	push   $0x0
  801f18:	6a 00                	push   $0x0
  801f1a:	6a 00                	push   $0x0
  801f1c:	6a 2b                	push   $0x2b
  801f1e:	e8 c9 fa ff ff       	call   8019ec <syscall>
  801f23:	83 c4 18             	add    $0x18,%esp
}
  801f26:	c9                   	leave  
  801f27:	c3                   	ret    

00801f28 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801f28:	55                   	push   %ebp
  801f29:	89 e5                	mov    %esp,%ebp
  801f2b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f2e:	6a 00                	push   $0x0
  801f30:	6a 00                	push   $0x0
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 00                	push   $0x0
  801f38:	6a 2c                	push   $0x2c
  801f3a:	e8 ad fa ff ff       	call   8019ec <syscall>
  801f3f:	83 c4 18             	add    $0x18,%esp
  801f42:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801f45:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801f49:	75 07                	jne    801f52 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801f4b:	b8 01 00 00 00       	mov    $0x1,%eax
  801f50:	eb 05                	jmp    801f57 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801f52:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f57:	c9                   	leave  
  801f58:	c3                   	ret    

00801f59 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801f59:	55                   	push   %ebp
  801f5a:	89 e5                	mov    %esp,%ebp
  801f5c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f5f:	6a 00                	push   $0x0
  801f61:	6a 00                	push   $0x0
  801f63:	6a 00                	push   $0x0
  801f65:	6a 00                	push   $0x0
  801f67:	6a 00                	push   $0x0
  801f69:	6a 2c                	push   $0x2c
  801f6b:	e8 7c fa ff ff       	call   8019ec <syscall>
  801f70:	83 c4 18             	add    $0x18,%esp
  801f73:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801f76:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801f7a:	75 07                	jne    801f83 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801f7c:	b8 01 00 00 00       	mov    $0x1,%eax
  801f81:	eb 05                	jmp    801f88 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801f83:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801f88:	c9                   	leave  
  801f89:	c3                   	ret    

00801f8a <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801f8a:	55                   	push   %ebp
  801f8b:	89 e5                	mov    %esp,%ebp
  801f8d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f90:	6a 00                	push   $0x0
  801f92:	6a 00                	push   $0x0
  801f94:	6a 00                	push   $0x0
  801f96:	6a 00                	push   $0x0
  801f98:	6a 00                	push   $0x0
  801f9a:	6a 2c                	push   $0x2c
  801f9c:	e8 4b fa ff ff       	call   8019ec <syscall>
  801fa1:	83 c4 18             	add    $0x18,%esp
  801fa4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801fa7:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801fab:	75 07                	jne    801fb4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801fad:	b8 01 00 00 00       	mov    $0x1,%eax
  801fb2:	eb 05                	jmp    801fb9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801fb4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fb9:	c9                   	leave  
  801fba:	c3                   	ret    

00801fbb <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801fbb:	55                   	push   %ebp
  801fbc:	89 e5                	mov    %esp,%ebp
  801fbe:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fc1:	6a 00                	push   $0x0
  801fc3:	6a 00                	push   $0x0
  801fc5:	6a 00                	push   $0x0
  801fc7:	6a 00                	push   $0x0
  801fc9:	6a 00                	push   $0x0
  801fcb:	6a 2c                	push   $0x2c
  801fcd:	e8 1a fa ff ff       	call   8019ec <syscall>
  801fd2:	83 c4 18             	add    $0x18,%esp
  801fd5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801fd8:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801fdc:	75 07                	jne    801fe5 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801fde:	b8 01 00 00 00       	mov    $0x1,%eax
  801fe3:	eb 05                	jmp    801fea <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801fe5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fea:	c9                   	leave  
  801feb:	c3                   	ret    

00801fec <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801fec:	55                   	push   %ebp
  801fed:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801fef:	6a 00                	push   $0x0
  801ff1:	6a 00                	push   $0x0
  801ff3:	6a 00                	push   $0x0
  801ff5:	6a 00                	push   $0x0
  801ff7:	ff 75 08             	pushl  0x8(%ebp)
  801ffa:	6a 2d                	push   $0x2d
  801ffc:	e8 eb f9 ff ff       	call   8019ec <syscall>
  802001:	83 c4 18             	add    $0x18,%esp
	return ;
  802004:	90                   	nop
}
  802005:	c9                   	leave  
  802006:	c3                   	ret    

00802007 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802007:	55                   	push   %ebp
  802008:	89 e5                	mov    %esp,%ebp
  80200a:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80200b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80200e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802011:	8b 55 0c             	mov    0xc(%ebp),%edx
  802014:	8b 45 08             	mov    0x8(%ebp),%eax
  802017:	6a 00                	push   $0x0
  802019:	53                   	push   %ebx
  80201a:	51                   	push   %ecx
  80201b:	52                   	push   %edx
  80201c:	50                   	push   %eax
  80201d:	6a 2e                	push   $0x2e
  80201f:	e8 c8 f9 ff ff       	call   8019ec <syscall>
  802024:	83 c4 18             	add    $0x18,%esp
}
  802027:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80202a:	c9                   	leave  
  80202b:	c3                   	ret    

0080202c <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80202c:	55                   	push   %ebp
  80202d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80202f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802032:	8b 45 08             	mov    0x8(%ebp),%eax
  802035:	6a 00                	push   $0x0
  802037:	6a 00                	push   $0x0
  802039:	6a 00                	push   $0x0
  80203b:	52                   	push   %edx
  80203c:	50                   	push   %eax
  80203d:	6a 2f                	push   $0x2f
  80203f:	e8 a8 f9 ff ff       	call   8019ec <syscall>
  802044:	83 c4 18             	add    $0x18,%esp
}
  802047:	c9                   	leave  
  802048:	c3                   	ret    
  802049:	66 90                	xchg   %ax,%ax
  80204b:	90                   	nop

0080204c <__udivdi3>:
  80204c:	55                   	push   %ebp
  80204d:	57                   	push   %edi
  80204e:	56                   	push   %esi
  80204f:	53                   	push   %ebx
  802050:	83 ec 1c             	sub    $0x1c,%esp
  802053:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802057:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80205b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80205f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802063:	89 ca                	mov    %ecx,%edx
  802065:	89 f8                	mov    %edi,%eax
  802067:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80206b:	85 f6                	test   %esi,%esi
  80206d:	75 2d                	jne    80209c <__udivdi3+0x50>
  80206f:	39 cf                	cmp    %ecx,%edi
  802071:	77 65                	ja     8020d8 <__udivdi3+0x8c>
  802073:	89 fd                	mov    %edi,%ebp
  802075:	85 ff                	test   %edi,%edi
  802077:	75 0b                	jne    802084 <__udivdi3+0x38>
  802079:	b8 01 00 00 00       	mov    $0x1,%eax
  80207e:	31 d2                	xor    %edx,%edx
  802080:	f7 f7                	div    %edi
  802082:	89 c5                	mov    %eax,%ebp
  802084:	31 d2                	xor    %edx,%edx
  802086:	89 c8                	mov    %ecx,%eax
  802088:	f7 f5                	div    %ebp
  80208a:	89 c1                	mov    %eax,%ecx
  80208c:	89 d8                	mov    %ebx,%eax
  80208e:	f7 f5                	div    %ebp
  802090:	89 cf                	mov    %ecx,%edi
  802092:	89 fa                	mov    %edi,%edx
  802094:	83 c4 1c             	add    $0x1c,%esp
  802097:	5b                   	pop    %ebx
  802098:	5e                   	pop    %esi
  802099:	5f                   	pop    %edi
  80209a:	5d                   	pop    %ebp
  80209b:	c3                   	ret    
  80209c:	39 ce                	cmp    %ecx,%esi
  80209e:	77 28                	ja     8020c8 <__udivdi3+0x7c>
  8020a0:	0f bd fe             	bsr    %esi,%edi
  8020a3:	83 f7 1f             	xor    $0x1f,%edi
  8020a6:	75 40                	jne    8020e8 <__udivdi3+0x9c>
  8020a8:	39 ce                	cmp    %ecx,%esi
  8020aa:	72 0a                	jb     8020b6 <__udivdi3+0x6a>
  8020ac:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8020b0:	0f 87 9e 00 00 00    	ja     802154 <__udivdi3+0x108>
  8020b6:	b8 01 00 00 00       	mov    $0x1,%eax
  8020bb:	89 fa                	mov    %edi,%edx
  8020bd:	83 c4 1c             	add    $0x1c,%esp
  8020c0:	5b                   	pop    %ebx
  8020c1:	5e                   	pop    %esi
  8020c2:	5f                   	pop    %edi
  8020c3:	5d                   	pop    %ebp
  8020c4:	c3                   	ret    
  8020c5:	8d 76 00             	lea    0x0(%esi),%esi
  8020c8:	31 ff                	xor    %edi,%edi
  8020ca:	31 c0                	xor    %eax,%eax
  8020cc:	89 fa                	mov    %edi,%edx
  8020ce:	83 c4 1c             	add    $0x1c,%esp
  8020d1:	5b                   	pop    %ebx
  8020d2:	5e                   	pop    %esi
  8020d3:	5f                   	pop    %edi
  8020d4:	5d                   	pop    %ebp
  8020d5:	c3                   	ret    
  8020d6:	66 90                	xchg   %ax,%ax
  8020d8:	89 d8                	mov    %ebx,%eax
  8020da:	f7 f7                	div    %edi
  8020dc:	31 ff                	xor    %edi,%edi
  8020de:	89 fa                	mov    %edi,%edx
  8020e0:	83 c4 1c             	add    $0x1c,%esp
  8020e3:	5b                   	pop    %ebx
  8020e4:	5e                   	pop    %esi
  8020e5:	5f                   	pop    %edi
  8020e6:	5d                   	pop    %ebp
  8020e7:	c3                   	ret    
  8020e8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8020ed:	89 eb                	mov    %ebp,%ebx
  8020ef:	29 fb                	sub    %edi,%ebx
  8020f1:	89 f9                	mov    %edi,%ecx
  8020f3:	d3 e6                	shl    %cl,%esi
  8020f5:	89 c5                	mov    %eax,%ebp
  8020f7:	88 d9                	mov    %bl,%cl
  8020f9:	d3 ed                	shr    %cl,%ebp
  8020fb:	89 e9                	mov    %ebp,%ecx
  8020fd:	09 f1                	or     %esi,%ecx
  8020ff:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802103:	89 f9                	mov    %edi,%ecx
  802105:	d3 e0                	shl    %cl,%eax
  802107:	89 c5                	mov    %eax,%ebp
  802109:	89 d6                	mov    %edx,%esi
  80210b:	88 d9                	mov    %bl,%cl
  80210d:	d3 ee                	shr    %cl,%esi
  80210f:	89 f9                	mov    %edi,%ecx
  802111:	d3 e2                	shl    %cl,%edx
  802113:	8b 44 24 08          	mov    0x8(%esp),%eax
  802117:	88 d9                	mov    %bl,%cl
  802119:	d3 e8                	shr    %cl,%eax
  80211b:	09 c2                	or     %eax,%edx
  80211d:	89 d0                	mov    %edx,%eax
  80211f:	89 f2                	mov    %esi,%edx
  802121:	f7 74 24 0c          	divl   0xc(%esp)
  802125:	89 d6                	mov    %edx,%esi
  802127:	89 c3                	mov    %eax,%ebx
  802129:	f7 e5                	mul    %ebp
  80212b:	39 d6                	cmp    %edx,%esi
  80212d:	72 19                	jb     802148 <__udivdi3+0xfc>
  80212f:	74 0b                	je     80213c <__udivdi3+0xf0>
  802131:	89 d8                	mov    %ebx,%eax
  802133:	31 ff                	xor    %edi,%edi
  802135:	e9 58 ff ff ff       	jmp    802092 <__udivdi3+0x46>
  80213a:	66 90                	xchg   %ax,%ax
  80213c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802140:	89 f9                	mov    %edi,%ecx
  802142:	d3 e2                	shl    %cl,%edx
  802144:	39 c2                	cmp    %eax,%edx
  802146:	73 e9                	jae    802131 <__udivdi3+0xe5>
  802148:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80214b:	31 ff                	xor    %edi,%edi
  80214d:	e9 40 ff ff ff       	jmp    802092 <__udivdi3+0x46>
  802152:	66 90                	xchg   %ax,%ax
  802154:	31 c0                	xor    %eax,%eax
  802156:	e9 37 ff ff ff       	jmp    802092 <__udivdi3+0x46>
  80215b:	90                   	nop

0080215c <__umoddi3>:
  80215c:	55                   	push   %ebp
  80215d:	57                   	push   %edi
  80215e:	56                   	push   %esi
  80215f:	53                   	push   %ebx
  802160:	83 ec 1c             	sub    $0x1c,%esp
  802163:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802167:	8b 74 24 34          	mov    0x34(%esp),%esi
  80216b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80216f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802173:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802177:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80217b:	89 f3                	mov    %esi,%ebx
  80217d:	89 fa                	mov    %edi,%edx
  80217f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802183:	89 34 24             	mov    %esi,(%esp)
  802186:	85 c0                	test   %eax,%eax
  802188:	75 1a                	jne    8021a4 <__umoddi3+0x48>
  80218a:	39 f7                	cmp    %esi,%edi
  80218c:	0f 86 a2 00 00 00    	jbe    802234 <__umoddi3+0xd8>
  802192:	89 c8                	mov    %ecx,%eax
  802194:	89 f2                	mov    %esi,%edx
  802196:	f7 f7                	div    %edi
  802198:	89 d0                	mov    %edx,%eax
  80219a:	31 d2                	xor    %edx,%edx
  80219c:	83 c4 1c             	add    $0x1c,%esp
  80219f:	5b                   	pop    %ebx
  8021a0:	5e                   	pop    %esi
  8021a1:	5f                   	pop    %edi
  8021a2:	5d                   	pop    %ebp
  8021a3:	c3                   	ret    
  8021a4:	39 f0                	cmp    %esi,%eax
  8021a6:	0f 87 ac 00 00 00    	ja     802258 <__umoddi3+0xfc>
  8021ac:	0f bd e8             	bsr    %eax,%ebp
  8021af:	83 f5 1f             	xor    $0x1f,%ebp
  8021b2:	0f 84 ac 00 00 00    	je     802264 <__umoddi3+0x108>
  8021b8:	bf 20 00 00 00       	mov    $0x20,%edi
  8021bd:	29 ef                	sub    %ebp,%edi
  8021bf:	89 fe                	mov    %edi,%esi
  8021c1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8021c5:	89 e9                	mov    %ebp,%ecx
  8021c7:	d3 e0                	shl    %cl,%eax
  8021c9:	89 d7                	mov    %edx,%edi
  8021cb:	89 f1                	mov    %esi,%ecx
  8021cd:	d3 ef                	shr    %cl,%edi
  8021cf:	09 c7                	or     %eax,%edi
  8021d1:	89 e9                	mov    %ebp,%ecx
  8021d3:	d3 e2                	shl    %cl,%edx
  8021d5:	89 14 24             	mov    %edx,(%esp)
  8021d8:	89 d8                	mov    %ebx,%eax
  8021da:	d3 e0                	shl    %cl,%eax
  8021dc:	89 c2                	mov    %eax,%edx
  8021de:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021e2:	d3 e0                	shl    %cl,%eax
  8021e4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8021e8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021ec:	89 f1                	mov    %esi,%ecx
  8021ee:	d3 e8                	shr    %cl,%eax
  8021f0:	09 d0                	or     %edx,%eax
  8021f2:	d3 eb                	shr    %cl,%ebx
  8021f4:	89 da                	mov    %ebx,%edx
  8021f6:	f7 f7                	div    %edi
  8021f8:	89 d3                	mov    %edx,%ebx
  8021fa:	f7 24 24             	mull   (%esp)
  8021fd:	89 c6                	mov    %eax,%esi
  8021ff:	89 d1                	mov    %edx,%ecx
  802201:	39 d3                	cmp    %edx,%ebx
  802203:	0f 82 87 00 00 00    	jb     802290 <__umoddi3+0x134>
  802209:	0f 84 91 00 00 00    	je     8022a0 <__umoddi3+0x144>
  80220f:	8b 54 24 04          	mov    0x4(%esp),%edx
  802213:	29 f2                	sub    %esi,%edx
  802215:	19 cb                	sbb    %ecx,%ebx
  802217:	89 d8                	mov    %ebx,%eax
  802219:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80221d:	d3 e0                	shl    %cl,%eax
  80221f:	89 e9                	mov    %ebp,%ecx
  802221:	d3 ea                	shr    %cl,%edx
  802223:	09 d0                	or     %edx,%eax
  802225:	89 e9                	mov    %ebp,%ecx
  802227:	d3 eb                	shr    %cl,%ebx
  802229:	89 da                	mov    %ebx,%edx
  80222b:	83 c4 1c             	add    $0x1c,%esp
  80222e:	5b                   	pop    %ebx
  80222f:	5e                   	pop    %esi
  802230:	5f                   	pop    %edi
  802231:	5d                   	pop    %ebp
  802232:	c3                   	ret    
  802233:	90                   	nop
  802234:	89 fd                	mov    %edi,%ebp
  802236:	85 ff                	test   %edi,%edi
  802238:	75 0b                	jne    802245 <__umoddi3+0xe9>
  80223a:	b8 01 00 00 00       	mov    $0x1,%eax
  80223f:	31 d2                	xor    %edx,%edx
  802241:	f7 f7                	div    %edi
  802243:	89 c5                	mov    %eax,%ebp
  802245:	89 f0                	mov    %esi,%eax
  802247:	31 d2                	xor    %edx,%edx
  802249:	f7 f5                	div    %ebp
  80224b:	89 c8                	mov    %ecx,%eax
  80224d:	f7 f5                	div    %ebp
  80224f:	89 d0                	mov    %edx,%eax
  802251:	e9 44 ff ff ff       	jmp    80219a <__umoddi3+0x3e>
  802256:	66 90                	xchg   %ax,%ax
  802258:	89 c8                	mov    %ecx,%eax
  80225a:	89 f2                	mov    %esi,%edx
  80225c:	83 c4 1c             	add    $0x1c,%esp
  80225f:	5b                   	pop    %ebx
  802260:	5e                   	pop    %esi
  802261:	5f                   	pop    %edi
  802262:	5d                   	pop    %ebp
  802263:	c3                   	ret    
  802264:	3b 04 24             	cmp    (%esp),%eax
  802267:	72 06                	jb     80226f <__umoddi3+0x113>
  802269:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80226d:	77 0f                	ja     80227e <__umoddi3+0x122>
  80226f:	89 f2                	mov    %esi,%edx
  802271:	29 f9                	sub    %edi,%ecx
  802273:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802277:	89 14 24             	mov    %edx,(%esp)
  80227a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80227e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802282:	8b 14 24             	mov    (%esp),%edx
  802285:	83 c4 1c             	add    $0x1c,%esp
  802288:	5b                   	pop    %ebx
  802289:	5e                   	pop    %esi
  80228a:	5f                   	pop    %edi
  80228b:	5d                   	pop    %ebp
  80228c:	c3                   	ret    
  80228d:	8d 76 00             	lea    0x0(%esi),%esi
  802290:	2b 04 24             	sub    (%esp),%eax
  802293:	19 fa                	sbb    %edi,%edx
  802295:	89 d1                	mov    %edx,%ecx
  802297:	89 c6                	mov    %eax,%esi
  802299:	e9 71 ff ff ff       	jmp    80220f <__umoddi3+0xb3>
  80229e:	66 90                	xchg   %ax,%ax
  8022a0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8022a4:	72 ea                	jb     802290 <__umoddi3+0x134>
  8022a6:	89 d9                	mov    %ebx,%ecx
  8022a8:	e9 62 ff ff ff       	jmp    80220f <__umoddi3+0xb3>
