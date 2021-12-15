
obj/user/tst_free_3:     file format elf32-i386


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
  800031:	e8 c2 13 00 00       	call   8013f8 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

#define numOfAccessesFor3MB 7
#define numOfAccessesFor8MB 4
void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec 7c 01 00 00    	sub    $0x17c,%esp



	int Mega = 1024*1024;
  800044:	c7 45 d4 00 00 10 00 	movl   $0x100000,-0x2c(%ebp)
	int kilo = 1024;
  80004b:	c7 45 d0 00 04 00 00 	movl   $0x400,-0x30(%ebp)
	char minByte = 1<<7;
  800052:	c6 45 cf 80          	movb   $0x80,-0x31(%ebp)
	char maxByte = 0x7F;
  800056:	c6 45 ce 7f          	movb   $0x7f,-0x32(%ebp)
	short minShort = 1<<15 ;
  80005a:	66 c7 45 cc 00 80    	movw   $0x8000,-0x34(%ebp)
	short maxShort = 0x7FFF;
  800060:	66 c7 45 ca ff 7f    	movw   $0x7fff,-0x36(%ebp)
	int minInt = 1<<31 ;
  800066:	c7 45 c4 00 00 00 80 	movl   $0x80000000,-0x3c(%ebp)
	int maxInt = 0x7FFFFFFF;
  80006d:	c7 45 c0 ff ff ff 7f 	movl   $0x7fffffff,-0x40(%ebp)
	int *intArr;
	int lastIndexOfByte, lastIndexOfByte2, lastIndexOfShort, lastIndexOfShort2, lastIndexOfInt, lastIndexOfStruct;

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800074:	a1 20 40 80 00       	mov    0x804020,%eax
  800079:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80007f:	8b 00                	mov    (%eax),%eax
  800081:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800084:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800087:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008c:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800091:	74 14                	je     8000a7 <_main+0x6f>
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	68 e0 30 80 00       	push   $0x8030e0
  80009b:	6a 1e                	push   $0x1e
  80009d:	68 21 31 80 00       	push   $0x803121
  8000a2:	e8 96 14 00 00       	call   80153d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000a7:	a1 20 40 80 00       	mov    0x804020,%eax
  8000ac:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000b2:	83 c0 10             	add    $0x10,%eax
  8000b5:	8b 00                	mov    (%eax),%eax
  8000b7:	89 45 b8             	mov    %eax,-0x48(%ebp)
  8000ba:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8000bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c2:	3d 00 10 20 00       	cmp    $0x201000,%eax
  8000c7:	74 14                	je     8000dd <_main+0xa5>
  8000c9:	83 ec 04             	sub    $0x4,%esp
  8000cc:	68 e0 30 80 00       	push   $0x8030e0
  8000d1:	6a 1f                	push   $0x1f
  8000d3:	68 21 31 80 00       	push   $0x803121
  8000d8:	e8 60 14 00 00       	call   80153d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000dd:	a1 20 40 80 00       	mov    0x804020,%eax
  8000e2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000e8:	83 c0 20             	add    $0x20,%eax
  8000eb:	8b 00                	mov    (%eax),%eax
  8000ed:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8000f0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8000f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f8:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000fd:	74 14                	je     800113 <_main+0xdb>
  8000ff:	83 ec 04             	sub    $0x4,%esp
  800102:	68 e0 30 80 00       	push   $0x8030e0
  800107:	6a 20                	push   $0x20
  800109:	68 21 31 80 00       	push   $0x803121
  80010e:	e8 2a 14 00 00       	call   80153d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800113:	a1 20 40 80 00       	mov    0x804020,%eax
  800118:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80011e:	83 c0 30             	add    $0x30,%eax
  800121:	8b 00                	mov    (%eax),%eax
  800123:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800126:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012e:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800133:	74 14                	je     800149 <_main+0x111>
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	68 e0 30 80 00       	push   $0x8030e0
  80013d:	6a 21                	push   $0x21
  80013f:	68 21 31 80 00       	push   $0x803121
  800144:	e8 f4 13 00 00       	call   80153d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800149:	a1 20 40 80 00       	mov    0x804020,%eax
  80014e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800154:	83 c0 40             	add    $0x40,%eax
  800157:	8b 00                	mov    (%eax),%eax
  800159:	89 45 ac             	mov    %eax,-0x54(%ebp)
  80015c:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80015f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800164:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800169:	74 14                	je     80017f <_main+0x147>
  80016b:	83 ec 04             	sub    $0x4,%esp
  80016e:	68 e0 30 80 00       	push   $0x8030e0
  800173:	6a 22                	push   $0x22
  800175:	68 21 31 80 00       	push   $0x803121
  80017a:	e8 be 13 00 00       	call   80153d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80017f:	a1 20 40 80 00       	mov    0x804020,%eax
  800184:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80018a:	83 c0 50             	add    $0x50,%eax
  80018d:	8b 00                	mov    (%eax),%eax
  80018f:	89 45 a8             	mov    %eax,-0x58(%ebp)
  800192:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800195:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019a:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80019f:	74 14                	je     8001b5 <_main+0x17d>
  8001a1:	83 ec 04             	sub    $0x4,%esp
  8001a4:	68 e0 30 80 00       	push   $0x8030e0
  8001a9:	6a 23                	push   $0x23
  8001ab:	68 21 31 80 00       	push   $0x803121
  8001b0:	e8 88 13 00 00       	call   80153d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001b5:	a1 20 40 80 00       	mov    0x804020,%eax
  8001ba:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001c0:	83 c0 60             	add    $0x60,%eax
  8001c3:	8b 00                	mov    (%eax),%eax
  8001c5:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  8001c8:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8001cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d0:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001d5:	74 14                	je     8001eb <_main+0x1b3>
  8001d7:	83 ec 04             	sub    $0x4,%esp
  8001da:	68 e0 30 80 00       	push   $0x8030e0
  8001df:	6a 24                	push   $0x24
  8001e1:	68 21 31 80 00       	push   $0x803121
  8001e6:	e8 52 13 00 00       	call   80153d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001eb:	a1 20 40 80 00       	mov    0x804020,%eax
  8001f0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001f6:	83 c0 70             	add    $0x70,%eax
  8001f9:	8b 00                	mov    (%eax),%eax
  8001fb:	89 45 a0             	mov    %eax,-0x60(%ebp)
  8001fe:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800201:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800206:	3d 00 10 80 00       	cmp    $0x801000,%eax
  80020b:	74 14                	je     800221 <_main+0x1e9>
  80020d:	83 ec 04             	sub    $0x4,%esp
  800210:	68 e0 30 80 00       	push   $0x8030e0
  800215:	6a 25                	push   $0x25
  800217:	68 21 31 80 00       	push   $0x803121
  80021c:	e8 1c 13 00 00       	call   80153d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800221:	a1 20 40 80 00       	mov    0x804020,%eax
  800226:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80022c:	83 e8 80             	sub    $0xffffff80,%eax
  80022f:	8b 00                	mov    (%eax),%eax
  800231:	89 45 9c             	mov    %eax,-0x64(%ebp)
  800234:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800237:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80023c:	3d 00 20 80 00       	cmp    $0x802000,%eax
  800241:	74 14                	je     800257 <_main+0x21f>
  800243:	83 ec 04             	sub    $0x4,%esp
  800246:	68 e0 30 80 00       	push   $0x8030e0
  80024b:	6a 26                	push   $0x26
  80024d:	68 21 31 80 00       	push   $0x803121
  800252:	e8 e6 12 00 00       	call   80153d <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800257:	a1 20 40 80 00       	mov    0x804020,%eax
  80025c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800262:	05 90 00 00 00       	add    $0x90,%eax
  800267:	8b 00                	mov    (%eax),%eax
  800269:	89 45 98             	mov    %eax,-0x68(%ebp)
  80026c:	8b 45 98             	mov    -0x68(%ebp),%eax
  80026f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800274:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800279:	74 14                	je     80028f <_main+0x257>
  80027b:	83 ec 04             	sub    $0x4,%esp
  80027e:	68 e0 30 80 00       	push   $0x8030e0
  800283:	6a 27                	push   $0x27
  800285:	68 21 31 80 00       	push   $0x803121
  80028a:	e8 ae 12 00 00       	call   80153d <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  80028f:	a1 20 40 80 00       	mov    0x804020,%eax
  800294:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  80029a:	85 c0                	test   %eax,%eax
  80029c:	74 14                	je     8002b2 <_main+0x27a>
  80029e:	83 ec 04             	sub    $0x4,%esp
  8002a1:	68 34 31 80 00       	push   $0x803134
  8002a6:	6a 28                	push   $0x28
  8002a8:	68 21 31 80 00       	push   $0x803121
  8002ad:	e8 8b 12 00 00       	call   80153d <_panic>
	}

	int start_freeFrames = sys_calculate_free_frames() ;
  8002b2:	e8 bf 26 00 00       	call   802976 <sys_calculate_free_frames>
  8002b7:	89 45 94             	mov    %eax,-0x6c(%ebp)

	int indicesOf3MB[numOfAccessesFor3MB];
	int indicesOf8MB[numOfAccessesFor8MB];
	int var, i, j;

	void* ptr_allocations[20] = {0};
  8002ba:	8d 95 80 fe ff ff    	lea    -0x180(%ebp),%edx
  8002c0:	b9 14 00 00 00       	mov    $0x14,%ecx
  8002c5:	b8 00 00 00 00       	mov    $0x0,%eax
  8002ca:	89 d7                	mov    %edx,%edi
  8002cc:	f3 ab                	rep stos %eax,%es:(%edi)
	{
		/*ALLOCATE 2 MB*/
		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8002ce:	e8 26 27 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  8002d3:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[0] = malloc(2*Mega-kilo);
  8002d6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8002d9:	01 c0                	add    %eax,%eax
  8002db:	2b 45 d0             	sub    -0x30(%ebp),%eax
  8002de:	83 ec 0c             	sub    $0xc,%esp
  8002e1:	50                   	push   %eax
  8002e2:	e8 82 22 00 00       	call   802569 <malloc>
  8002e7:	83 c4 10             	add    $0x10,%esp
  8002ea:	89 85 80 fe ff ff    	mov    %eax,-0x180(%ebp)
		//check return address & page file
		if ((uint32) ptr_allocations[0] <  (USER_HEAP_START) || (uint32) ptr_allocations[0] > (USER_HEAP_START+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8002f0:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
  8002f6:	85 c0                	test   %eax,%eax
  8002f8:	79 0d                	jns    800307 <_main+0x2cf>
  8002fa:	8b 85 80 fe ff ff    	mov    -0x180(%ebp),%eax
  800300:	3d 00 10 00 80       	cmp    $0x80001000,%eax
  800305:	76 14                	jbe    80031b <_main+0x2e3>
  800307:	83 ec 04             	sub    $0x4,%esp
  80030a:	68 7c 31 80 00       	push   $0x80317c
  80030f:	6a 37                	push   $0x37
  800311:	68 21 31 80 00       	push   $0x803121
  800316:	e8 22 12 00 00       	call   80153d <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 512) panic("Extra or less pages are allocated in PageFile");
  80031b:	e8 d9 26 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  800320:	2b 45 90             	sub    -0x70(%ebp),%eax
  800323:	3d 00 02 00 00       	cmp    $0x200,%eax
  800328:	74 14                	je     80033e <_main+0x306>
  80032a:	83 ec 04             	sub    $0x4,%esp
  80032d:	68 e4 31 80 00       	push   $0x8031e4
  800332:	6a 38                	push   $0x38
  800334:	68 21 31 80 00       	push   $0x803121
  800339:	e8 ff 11 00 00       	call   80153d <_panic>

		/*ALLOCATE 3 MB*/
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80033e:	e8 b6 26 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  800343:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[1] = malloc(3*Mega-kilo);
  800346:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800349:	89 c2                	mov    %eax,%edx
  80034b:	01 d2                	add    %edx,%edx
  80034d:	01 d0                	add    %edx,%eax
  80034f:	2b 45 d0             	sub    -0x30(%ebp),%eax
  800352:	83 ec 0c             	sub    $0xc,%esp
  800355:	50                   	push   %eax
  800356:	e8 0e 22 00 00       	call   802569 <malloc>
  80035b:	83 c4 10             	add    $0x10,%esp
  80035e:	89 85 84 fe ff ff    	mov    %eax,-0x17c(%ebp)
		//check return address & page file
		if ((uint32) ptr_allocations[1] < (USER_HEAP_START + 2*Mega) || (uint32) ptr_allocations[1] > (USER_HEAP_START+ 2*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800364:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  80036a:	89 c2                	mov    %eax,%edx
  80036c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80036f:	01 c0                	add    %eax,%eax
  800371:	05 00 00 00 80       	add    $0x80000000,%eax
  800376:	39 c2                	cmp    %eax,%edx
  800378:	72 16                	jb     800390 <_main+0x358>
  80037a:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  800380:	89 c2                	mov    %eax,%edx
  800382:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800385:	01 c0                	add    %eax,%eax
  800387:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  80038c:	39 c2                	cmp    %eax,%edx
  80038e:	76 14                	jbe    8003a4 <_main+0x36c>
  800390:	83 ec 04             	sub    $0x4,%esp
  800393:	68 7c 31 80 00       	push   $0x80317c
  800398:	6a 3e                	push   $0x3e
  80039a:	68 21 31 80 00       	push   $0x803121
  80039f:	e8 99 11 00 00       	call   80153d <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/PAGE_SIZE) panic("Extra or less pages are allocated in PageFile");
  8003a4:	e8 50 26 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  8003a9:	2b 45 90             	sub    -0x70(%ebp),%eax
  8003ac:	89 c2                	mov    %eax,%edx
  8003ae:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003b1:	89 c1                	mov    %eax,%ecx
  8003b3:	01 c9                	add    %ecx,%ecx
  8003b5:	01 c8                	add    %ecx,%eax
  8003b7:	85 c0                	test   %eax,%eax
  8003b9:	79 05                	jns    8003c0 <_main+0x388>
  8003bb:	05 ff 0f 00 00       	add    $0xfff,%eax
  8003c0:	c1 f8 0c             	sar    $0xc,%eax
  8003c3:	39 c2                	cmp    %eax,%edx
  8003c5:	74 14                	je     8003db <_main+0x3a3>
  8003c7:	83 ec 04             	sub    $0x4,%esp
  8003ca:	68 e4 31 80 00       	push   $0x8031e4
  8003cf:	6a 3f                	push   $0x3f
  8003d1:	68 21 31 80 00       	push   $0x803121
  8003d6:	e8 62 11 00 00       	call   80153d <_panic>

		/*ALLOCATE 8 MB*/
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8003db:	e8 19 26 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  8003e0:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[2] = malloc(8*Mega-kilo);
  8003e3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8003e6:	c1 e0 03             	shl    $0x3,%eax
  8003e9:	2b 45 d0             	sub    -0x30(%ebp),%eax
  8003ec:	83 ec 0c             	sub    $0xc,%esp
  8003ef:	50                   	push   %eax
  8003f0:	e8 74 21 00 00       	call   802569 <malloc>
  8003f5:	83 c4 10             	add    $0x10,%esp
  8003f8:	89 85 88 fe ff ff    	mov    %eax,-0x178(%ebp)
		//check return address & page file
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 5*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START+ 5*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8003fe:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800404:	89 c1                	mov    %eax,%ecx
  800406:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800409:	89 d0                	mov    %edx,%eax
  80040b:	c1 e0 02             	shl    $0x2,%eax
  80040e:	01 d0                	add    %edx,%eax
  800410:	05 00 00 00 80       	add    $0x80000000,%eax
  800415:	39 c1                	cmp    %eax,%ecx
  800417:	72 1b                	jb     800434 <_main+0x3fc>
  800419:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  80041f:	89 c1                	mov    %eax,%ecx
  800421:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800424:	89 d0                	mov    %edx,%eax
  800426:	c1 e0 02             	shl    $0x2,%eax
  800429:	01 d0                	add    %edx,%eax
  80042b:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800430:	39 c1                	cmp    %eax,%ecx
  800432:	76 14                	jbe    800448 <_main+0x410>
  800434:	83 ec 04             	sub    $0x4,%esp
  800437:	68 7c 31 80 00       	push   $0x80317c
  80043c:	6a 45                	push   $0x45
  80043e:	68 21 31 80 00       	push   $0x803121
  800443:	e8 f5 10 00 00       	call   80153d <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 8*Mega/PAGE_SIZE) panic("Extra or less pages are allocated in PageFile");
  800448:	e8 ac 25 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  80044d:	2b 45 90             	sub    -0x70(%ebp),%eax
  800450:	89 c2                	mov    %eax,%edx
  800452:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800455:	c1 e0 03             	shl    $0x3,%eax
  800458:	85 c0                	test   %eax,%eax
  80045a:	79 05                	jns    800461 <_main+0x429>
  80045c:	05 ff 0f 00 00       	add    $0xfff,%eax
  800461:	c1 f8 0c             	sar    $0xc,%eax
  800464:	39 c2                	cmp    %eax,%edx
  800466:	74 14                	je     80047c <_main+0x444>
  800468:	83 ec 04             	sub    $0x4,%esp
  80046b:	68 e4 31 80 00       	push   $0x8031e4
  800470:	6a 46                	push   $0x46
  800472:	68 21 31 80 00       	push   $0x803121
  800477:	e8 c1 10 00 00       	call   80153d <_panic>

		/*ALLOCATE 7 MB*/
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80047c:	e8 78 25 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  800481:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[3] = malloc(7*Mega-kilo);
  800484:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800487:	89 d0                	mov    %edx,%eax
  800489:	01 c0                	add    %eax,%eax
  80048b:	01 d0                	add    %edx,%eax
  80048d:	01 c0                	add    %eax,%eax
  80048f:	01 d0                	add    %edx,%eax
  800491:	2b 45 d0             	sub    -0x30(%ebp),%eax
  800494:	83 ec 0c             	sub    $0xc,%esp
  800497:	50                   	push   %eax
  800498:	e8 cc 20 00 00       	call   802569 <malloc>
  80049d:	83 c4 10             	add    $0x10,%esp
  8004a0:	89 85 8c fe ff ff    	mov    %eax,-0x174(%ebp)
		//check return address & page file
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 13*Mega) || (uint32) ptr_allocations[3] > (USER_HEAP_START+ 13*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  8004a6:	8b 85 8c fe ff ff    	mov    -0x174(%ebp),%eax
  8004ac:	89 c1                	mov    %eax,%ecx
  8004ae:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8004b1:	89 d0                	mov    %edx,%eax
  8004b3:	01 c0                	add    %eax,%eax
  8004b5:	01 d0                	add    %edx,%eax
  8004b7:	c1 e0 02             	shl    $0x2,%eax
  8004ba:	01 d0                	add    %edx,%eax
  8004bc:	05 00 00 00 80       	add    $0x80000000,%eax
  8004c1:	39 c1                	cmp    %eax,%ecx
  8004c3:	72 1f                	jb     8004e4 <_main+0x4ac>
  8004c5:	8b 85 8c fe ff ff    	mov    -0x174(%ebp),%eax
  8004cb:	89 c1                	mov    %eax,%ecx
  8004cd:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8004d0:	89 d0                	mov    %edx,%eax
  8004d2:	01 c0                	add    %eax,%eax
  8004d4:	01 d0                	add    %edx,%eax
  8004d6:	c1 e0 02             	shl    $0x2,%eax
  8004d9:	01 d0                	add    %edx,%eax
  8004db:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  8004e0:	39 c1                	cmp    %eax,%ecx
  8004e2:	76 14                	jbe    8004f8 <_main+0x4c0>
  8004e4:	83 ec 04             	sub    $0x4,%esp
  8004e7:	68 7c 31 80 00       	push   $0x80317c
  8004ec:	6a 4c                	push   $0x4c
  8004ee:	68 21 31 80 00       	push   $0x803121
  8004f3:	e8 45 10 00 00       	call   80153d <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 7*Mega/PAGE_SIZE) panic("Extra or less pages are allocated in PageFile");
  8004f8:	e8 fc 24 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  8004fd:	2b 45 90             	sub    -0x70(%ebp),%eax
  800500:	89 c1                	mov    %eax,%ecx
  800502:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800505:	89 d0                	mov    %edx,%eax
  800507:	01 c0                	add    %eax,%eax
  800509:	01 d0                	add    %edx,%eax
  80050b:	01 c0                	add    %eax,%eax
  80050d:	01 d0                	add    %edx,%eax
  80050f:	85 c0                	test   %eax,%eax
  800511:	79 05                	jns    800518 <_main+0x4e0>
  800513:	05 ff 0f 00 00       	add    $0xfff,%eax
  800518:	c1 f8 0c             	sar    $0xc,%eax
  80051b:	39 c1                	cmp    %eax,%ecx
  80051d:	74 14                	je     800533 <_main+0x4fb>
  80051f:	83 ec 04             	sub    $0x4,%esp
  800522:	68 e4 31 80 00       	push   $0x8031e4
  800527:	6a 4d                	push   $0x4d
  800529:	68 21 31 80 00       	push   $0x803121
  80052e:	e8 0a 10 00 00       	call   80153d <_panic>

		/*access 3 MB*/// should bring 6 pages into WS (3 r, 4 w)
		int freeFrames = sys_calculate_free_frames() ;
  800533:	e8 3e 24 00 00       	call   802976 <sys_calculate_free_frames>
  800538:	89 45 8c             	mov    %eax,-0x74(%ebp)
		int modFrames = sys_calculate_modified_frames();
  80053b:	e8 4f 24 00 00       	call   80298f <sys_calculate_modified_frames>
  800540:	89 45 88             	mov    %eax,-0x78(%ebp)
		lastIndexOfByte = (3*Mega-kilo)/sizeof(char) - 1;
  800543:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800546:	89 c2                	mov    %eax,%edx
  800548:	01 d2                	add    %edx,%edx
  80054a:	01 d0                	add    %edx,%eax
  80054c:	2b 45 d0             	sub    -0x30(%ebp),%eax
  80054f:	48                   	dec    %eax
  800550:	89 45 84             	mov    %eax,-0x7c(%ebp)
		int inc = lastIndexOfByte / numOfAccessesFor3MB;
  800553:	8b 45 84             	mov    -0x7c(%ebp),%eax
  800556:	bf 07 00 00 00       	mov    $0x7,%edi
  80055b:	99                   	cltd   
  80055c:	f7 ff                	idiv   %edi
  80055e:	89 45 80             	mov    %eax,-0x80(%ebp)
		for (var = 0; var < numOfAccessesFor3MB; ++var)
  800561:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800568:	eb 16                	jmp    800580 <_main+0x548>
		{
			indicesOf3MB[var] = var * inc ;
  80056a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80056d:	0f af 45 80          	imul   -0x80(%ebp),%eax
  800571:	89 c2                	mov    %eax,%edx
  800573:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800576:	89 94 85 e0 fe ff ff 	mov    %edx,-0x120(%ebp,%eax,4)
		/*access 3 MB*/// should bring 6 pages into WS (3 r, 4 w)
		int freeFrames = sys_calculate_free_frames() ;
		int modFrames = sys_calculate_modified_frames();
		lastIndexOfByte = (3*Mega-kilo)/sizeof(char) - 1;
		int inc = lastIndexOfByte / numOfAccessesFor3MB;
		for (var = 0; var < numOfAccessesFor3MB; ++var)
  80057d:	ff 45 e4             	incl   -0x1c(%ebp)
  800580:	83 7d e4 06          	cmpl   $0x6,-0x1c(%ebp)
  800584:	7e e4                	jle    80056a <_main+0x532>
		{
			indicesOf3MB[var] = var * inc ;
		}
		byteArr = (char *) ptr_allocations[1];
  800586:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  80058c:	89 85 7c ff ff ff    	mov    %eax,-0x84(%ebp)
		//3 reads
		int sum = 0;
  800592:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		for (var = 0; var < numOfAccessesFor3MB/2; ++var)
  800599:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8005a0:	eb 1f                	jmp    8005c1 <_main+0x589>
		{
			sum += byteArr[indicesOf3MB[var]] ;
  8005a2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005a5:	8b 84 85 e0 fe ff ff 	mov    -0x120(%ebp,%eax,4),%eax
  8005ac:	89 c2                	mov    %eax,%edx
  8005ae:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8005b4:	01 d0                	add    %edx,%eax
  8005b6:	8a 00                	mov    (%eax),%al
  8005b8:	0f be c0             	movsbl %al,%eax
  8005bb:	01 45 dc             	add    %eax,-0x24(%ebp)
			indicesOf3MB[var] = var * inc ;
		}
		byteArr = (char *) ptr_allocations[1];
		//3 reads
		int sum = 0;
		for (var = 0; var < numOfAccessesFor3MB/2; ++var)
  8005be:	ff 45 e4             	incl   -0x1c(%ebp)
  8005c1:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
  8005c5:	7e db                	jle    8005a2 <_main+0x56a>
		{
			sum += byteArr[indicesOf3MB[var]] ;
		}
		//4 writes
		for (var = numOfAccessesFor3MB/2; var < numOfAccessesFor3MB; ++var)
  8005c7:	c7 45 e4 03 00 00 00 	movl   $0x3,-0x1c(%ebp)
  8005ce:	eb 1c                	jmp    8005ec <_main+0x5b4>
		{
			byteArr[indicesOf3MB[var]] = maxByte ;
  8005d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005d3:	8b 84 85 e0 fe ff ff 	mov    -0x120(%ebp,%eax,4),%eax
  8005da:	89 c2                	mov    %eax,%edx
  8005dc:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8005e2:	01 c2                	add    %eax,%edx
  8005e4:	8a 45 ce             	mov    -0x32(%ebp),%al
  8005e7:	88 02                	mov    %al,(%edx)
		for (var = 0; var < numOfAccessesFor3MB/2; ++var)
		{
			sum += byteArr[indicesOf3MB[var]] ;
		}
		//4 writes
		for (var = numOfAccessesFor3MB/2; var < numOfAccessesFor3MB; ++var)
  8005e9:	ff 45 e4             	incl   -0x1c(%ebp)
  8005ec:	83 7d e4 06          	cmpl   $0x6,-0x1c(%ebp)
  8005f0:	7e de                	jle    8005d0 <_main+0x598>
		{
			byteArr[indicesOf3MB[var]] = maxByte ;
		}
		//check memory & WS
		if (((freeFrames+modFrames) - (sys_calculate_free_frames()+sys_calculate_modified_frames())) != 0 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8005f2:	8b 55 8c             	mov    -0x74(%ebp),%edx
  8005f5:	8b 45 88             	mov    -0x78(%ebp),%eax
  8005f8:	01 d0                	add    %edx,%eax
  8005fa:	89 c6                	mov    %eax,%esi
  8005fc:	e8 75 23 00 00       	call   802976 <sys_calculate_free_frames>
  800601:	89 c3                	mov    %eax,%ebx
  800603:	e8 87 23 00 00       	call   80298f <sys_calculate_modified_frames>
  800608:	01 d8                	add    %ebx,%eax
  80060a:	29 c6                	sub    %eax,%esi
  80060c:	89 f0                	mov    %esi,%eax
  80060e:	83 f8 02             	cmp    $0x2,%eax
  800611:	74 14                	je     800627 <_main+0x5ef>
  800613:	83 ec 04             	sub    $0x4,%esp
  800616:	68 14 32 80 00       	push   $0x803214
  80061b:	6a 65                	push   $0x65
  80061d:	68 21 31 80 00       	push   $0x803121
  800622:	e8 16 0f 00 00       	call   80153d <_panic>
		int found = 0;
  800627:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
  80062e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800635:	eb 72                	jmp    8006a9 <_main+0x671>
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  800637:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80063e:	eb 57                	jmp    800697 <_main+0x65f>
			{
				if(ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[indicesOf3MB[var]])), PAGE_SIZE))
  800640:	a1 20 40 80 00       	mov    0x804020,%eax
  800645:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80064b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80064e:	c1 e2 04             	shl    $0x4,%edx
  800651:	01 d0                	add    %edx,%eax
  800653:	8b 00                	mov    (%eax),%eax
  800655:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
  80065b:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  800661:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800666:	89 c2                	mov    %eax,%edx
  800668:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80066b:	8b 84 85 e0 fe ff ff 	mov    -0x120(%ebp,%eax,4),%eax
  800672:	89 c1                	mov    %eax,%ecx
  800674:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  80067a:	01 c8                	add    %ecx,%eax
  80067c:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
  800682:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
  800688:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80068d:	39 c2                	cmp    %eax,%edx
  80068f:	75 03                	jne    800694 <_main+0x65c>
				{
					found++;
  800691:	ff 45 d8             	incl   -0x28(%ebp)
		//check memory & WS
		if (((freeFrames+modFrames) - (sys_calculate_free_frames()+sys_calculate_modified_frames())) != 0 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		int found = 0;
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  800694:	ff 45 e0             	incl   -0x20(%ebp)
  800697:	a1 20 40 80 00       	mov    0x804020,%eax
  80069c:	8b 50 74             	mov    0x74(%eax),%edx
  80069f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006a2:	39 c2                	cmp    %eax,%edx
  8006a4:	77 9a                	ja     800640 <_main+0x608>
			byteArr[indicesOf3MB[var]] = maxByte ;
		}
		//check memory & WS
		if (((freeFrames+modFrames) - (sys_calculate_free_frames()+sys_calculate_modified_frames())) != 0 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		int found = 0;
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
  8006a6:	ff 45 e4             	incl   -0x1c(%ebp)
  8006a9:	83 7d e4 06          	cmpl   $0x6,-0x1c(%ebp)
  8006ad:	7e 88                	jle    800637 <_main+0x5ff>
				{
					found++;
				}
			}
		}
		if (found != numOfAccessesFor3MB) panic("malloc: page is not added to WS");
  8006af:	83 7d d8 07          	cmpl   $0x7,-0x28(%ebp)
  8006b3:	74 14                	je     8006c9 <_main+0x691>
  8006b5:	83 ec 04             	sub    $0x4,%esp
  8006b8:	68 58 32 80 00       	push   $0x803258
  8006bd:	6a 71                	push   $0x71
  8006bf:	68 21 31 80 00       	push   $0x803121
  8006c4:	e8 74 0e 00 00       	call   80153d <_panic>

		/*access 8 MB*/// should bring 4 pages into WS (2 r, 2 w) and victimize 4 pages from 3 MB allocation
		freeFrames = sys_calculate_free_frames() ;
  8006c9:	e8 a8 22 00 00       	call   802976 <sys_calculate_free_frames>
  8006ce:	89 45 8c             	mov    %eax,-0x74(%ebp)
		modFrames = sys_calculate_modified_frames();
  8006d1:	e8 b9 22 00 00       	call   80298f <sys_calculate_modified_frames>
  8006d6:	89 45 88             	mov    %eax,-0x78(%ebp)
		lastIndexOfShort = (8*Mega-kilo)/sizeof(short) - 1;
  8006d9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006dc:	c1 e0 03             	shl    $0x3,%eax
  8006df:	2b 45 d0             	sub    -0x30(%ebp),%eax
  8006e2:	d1 e8                	shr    %eax
  8006e4:	48                   	dec    %eax
  8006e5:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		indicesOf8MB[0] = lastIndexOfShort * 1 / 2;
  8006eb:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  8006f1:	89 c2                	mov    %eax,%edx
  8006f3:	c1 ea 1f             	shr    $0x1f,%edx
  8006f6:	01 d0                	add    %edx,%eax
  8006f8:	d1 f8                	sar    %eax
  8006fa:	89 85 d0 fe ff ff    	mov    %eax,-0x130(%ebp)
		indicesOf8MB[1] = lastIndexOfShort * 2 / 3;
  800700:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800706:	01 c0                	add    %eax,%eax
  800708:	89 c1                	mov    %eax,%ecx
  80070a:	b8 56 55 55 55       	mov    $0x55555556,%eax
  80070f:	f7 e9                	imul   %ecx
  800711:	c1 f9 1f             	sar    $0x1f,%ecx
  800714:	89 d0                	mov    %edx,%eax
  800716:	29 c8                	sub    %ecx,%eax
  800718:	89 85 d4 fe ff ff    	mov    %eax,-0x12c(%ebp)
		indicesOf8MB[2] = lastIndexOfShort * 3 / 4;
  80071e:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800724:	89 c2                	mov    %eax,%edx
  800726:	01 d2                	add    %edx,%edx
  800728:	01 d0                	add    %edx,%eax
  80072a:	85 c0                	test   %eax,%eax
  80072c:	79 03                	jns    800731 <_main+0x6f9>
  80072e:	83 c0 03             	add    $0x3,%eax
  800731:	c1 f8 02             	sar    $0x2,%eax
  800734:	89 85 d8 fe ff ff    	mov    %eax,-0x128(%ebp)
		indicesOf8MB[3] = lastIndexOfShort ;
  80073a:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800740:	89 85 dc fe ff ff    	mov    %eax,-0x124(%ebp)

		//use one of the read pages from 3 MB to avoid victimizing it
		sum += byteArr[indicesOf3MB[0]] ;
  800746:	8b 85 e0 fe ff ff    	mov    -0x120(%ebp),%eax
  80074c:	89 c2                	mov    %eax,%edx
  80074e:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  800754:	01 d0                	add    %edx,%eax
  800756:	8a 00                	mov    (%eax),%al
  800758:	0f be c0             	movsbl %al,%eax
  80075b:	01 45 dc             	add    %eax,-0x24(%ebp)

		shortArr = (short *) ptr_allocations[2];
  80075e:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800764:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
		//2 reads
		sum = 0;
  80076a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
		for (var = 0; var < numOfAccessesFor8MB/2; ++var)
  800771:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800778:	eb 20                	jmp    80079a <_main+0x762>
		{
			sum += shortArr[indicesOf8MB[var]] ;
  80077a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80077d:	8b 84 85 d0 fe ff ff 	mov    -0x130(%ebp,%eax,4),%eax
  800784:	01 c0                	add    %eax,%eax
  800786:	89 c2                	mov    %eax,%edx
  800788:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  80078e:	01 d0                	add    %edx,%eax
  800790:	66 8b 00             	mov    (%eax),%ax
  800793:	98                   	cwtl   
  800794:	01 45 dc             	add    %eax,-0x24(%ebp)
		sum += byteArr[indicesOf3MB[0]] ;

		shortArr = (short *) ptr_allocations[2];
		//2 reads
		sum = 0;
		for (var = 0; var < numOfAccessesFor8MB/2; ++var)
  800797:	ff 45 e4             	incl   -0x1c(%ebp)
  80079a:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  80079e:	7e da                	jle    80077a <_main+0x742>
		{
			sum += shortArr[indicesOf8MB[var]] ;
		}
		//2 writes
		for (var = numOfAccessesFor8MB/2; var < numOfAccessesFor8MB; ++var)
  8007a0:	c7 45 e4 02 00 00 00 	movl   $0x2,-0x1c(%ebp)
  8007a7:	eb 20                	jmp    8007c9 <_main+0x791>
		{
			shortArr[indicesOf8MB[var]] = maxShort ;
  8007a9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8007ac:	8b 84 85 d0 fe ff ff 	mov    -0x130(%ebp,%eax,4),%eax
  8007b3:	01 c0                	add    %eax,%eax
  8007b5:	89 c2                	mov    %eax,%edx
  8007b7:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  8007bd:	01 c2                	add    %eax,%edx
  8007bf:	66 8b 45 ca          	mov    -0x36(%ebp),%ax
  8007c3:	66 89 02             	mov    %ax,(%edx)
		for (var = 0; var < numOfAccessesFor8MB/2; ++var)
		{
			sum += shortArr[indicesOf8MB[var]] ;
		}
		//2 writes
		for (var = numOfAccessesFor8MB/2; var < numOfAccessesFor8MB; ++var)
  8007c6:	ff 45 e4             	incl   -0x1c(%ebp)
  8007c9:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8007cd:	7e da                	jle    8007a9 <_main+0x771>
		{
			shortArr[indicesOf8MB[var]] = maxShort ;
		}
		//check memory & WS
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8007cf:	8b 5d 8c             	mov    -0x74(%ebp),%ebx
  8007d2:	e8 9f 21 00 00       	call   802976 <sys_calculate_free_frames>
  8007d7:	29 c3                	sub    %eax,%ebx
  8007d9:	89 d8                	mov    %ebx,%eax
  8007db:	83 f8 04             	cmp    $0x4,%eax
  8007de:	74 17                	je     8007f7 <_main+0x7bf>
  8007e0:	83 ec 04             	sub    $0x4,%esp
  8007e3:	68 14 32 80 00       	push   $0x803214
  8007e8:	68 8c 00 00 00       	push   $0x8c
  8007ed:	68 21 31 80 00       	push   $0x803121
  8007f2:	e8 46 0d 00 00       	call   80153d <_panic>
		if ((modFrames - sys_calculate_modified_frames()) != -2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8007f7:	8b 5d 88             	mov    -0x78(%ebp),%ebx
  8007fa:	e8 90 21 00 00       	call   80298f <sys_calculate_modified_frames>
  8007ff:	29 c3                	sub    %eax,%ebx
  800801:	89 d8                	mov    %ebx,%eax
  800803:	83 f8 fe             	cmp    $0xfffffffe,%eax
  800806:	74 17                	je     80081f <_main+0x7e7>
  800808:	83 ec 04             	sub    $0x4,%esp
  80080b:	68 14 32 80 00       	push   $0x803214
  800810:	68 8d 00 00 00       	push   $0x8d
  800815:	68 21 31 80 00       	push   $0x803121
  80081a:	e8 1e 0d 00 00       	call   80153d <_panic>
		found = 0;
  80081f:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < numOfAccessesFor8MB ; ++var)
  800826:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80082d:	eb 74                	jmp    8008a3 <_main+0x86b>
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  80082f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800836:	eb 59                	jmp    800891 <_main+0x859>
			{
				if(ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[indicesOf8MB[var]])), PAGE_SIZE))
  800838:	a1 20 40 80 00       	mov    0x804020,%eax
  80083d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800843:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800846:	c1 e2 04             	shl    $0x4,%edx
  800849:	01 d0                	add    %edx,%eax
  80084b:	8b 00                	mov    (%eax),%eax
  80084d:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
  800853:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
  800859:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80085e:	89 c2                	mov    %eax,%edx
  800860:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800863:	8b 84 85 d0 fe ff ff 	mov    -0x130(%ebp,%eax,4),%eax
  80086a:	01 c0                	add    %eax,%eax
  80086c:	89 c1                	mov    %eax,%ecx
  80086e:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800874:	01 c8                	add    %ecx,%eax
  800876:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
  80087c:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
  800882:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800887:	39 c2                	cmp    %eax,%edx
  800889:	75 03                	jne    80088e <_main+0x856>
				{
					found++;
  80088b:	ff 45 d8             	incl   -0x28(%ebp)
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		if ((modFrames - sys_calculate_modified_frames()) != -2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < numOfAccessesFor8MB ; ++var)
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  80088e:	ff 45 e0             	incl   -0x20(%ebp)
  800891:	a1 20 40 80 00       	mov    0x804020,%eax
  800896:	8b 50 74             	mov    0x74(%eax),%edx
  800899:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80089c:	39 c2                	cmp    %eax,%edx
  80089e:	77 98                	ja     800838 <_main+0x800>
		}
		//check memory & WS
		if ((freeFrames - sys_calculate_free_frames()) != 2 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		if ((modFrames - sys_calculate_modified_frames()) != -2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < numOfAccessesFor8MB ; ++var)
  8008a0:	ff 45 e4             	incl   -0x1c(%ebp)
  8008a3:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  8008a7:	7e 86                	jle    80082f <_main+0x7f7>
				{
					found++;
				}
			}
		}
		if (found != numOfAccessesFor8MB) panic("malloc: page is not added to WS");
  8008a9:	83 7d d8 04          	cmpl   $0x4,-0x28(%ebp)
  8008ad:	74 17                	je     8008c6 <_main+0x88e>
  8008af:	83 ec 04             	sub    $0x4,%esp
  8008b2:	68 58 32 80 00       	push   $0x803258
  8008b7:	68 99 00 00 00       	push   $0x99
  8008bc:	68 21 31 80 00       	push   $0x803121
  8008c1:	e8 77 0c 00 00       	call   80153d <_panic>

		/* Free 3 MB */// remove 3 pages from WS, 2 from free buffer, 2 from mod buffer and 2 tables
		freeFrames = sys_calculate_free_frames() ;
  8008c6:	e8 ab 20 00 00       	call   802976 <sys_calculate_free_frames>
  8008cb:	89 45 8c             	mov    %eax,-0x74(%ebp)
		modFrames = sys_calculate_modified_frames();
  8008ce:	e8 bc 20 00 00       	call   80298f <sys_calculate_modified_frames>
  8008d3:	89 45 88             	mov    %eax,-0x78(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8008d6:	e8 1e 21 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  8008db:	89 45 90             	mov    %eax,-0x70(%ebp)

		free(ptr_allocations[1]);
  8008de:	8b 85 84 fe ff ff    	mov    -0x17c(%ebp),%eax
  8008e4:	83 ec 0c             	sub    $0xc,%esp
  8008e7:	50                   	push   %eax
  8008e8:	e8 32 1e 00 00       	call   80271f <free>
  8008ed:	83 c4 10             	add    $0x10,%esp

		//check page file
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 3*Mega/PAGE_SIZE) panic("Wrong free: Extra or less pages are removed from PageFile");
  8008f0:	e8 04 21 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  8008f5:	8b 55 90             	mov    -0x70(%ebp),%edx
  8008f8:	89 d1                	mov    %edx,%ecx
  8008fa:	29 c1                	sub    %eax,%ecx
  8008fc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8008ff:	89 c2                	mov    %eax,%edx
  800901:	01 d2                	add    %edx,%edx
  800903:	01 d0                	add    %edx,%eax
  800905:	85 c0                	test   %eax,%eax
  800907:	79 05                	jns    80090e <_main+0x8d6>
  800909:	05 ff 0f 00 00       	add    $0xfff,%eax
  80090e:	c1 f8 0c             	sar    $0xc,%eax
  800911:	39 c1                	cmp    %eax,%ecx
  800913:	74 17                	je     80092c <_main+0x8f4>
  800915:	83 ec 04             	sub    $0x4,%esp
  800918:	68 78 32 80 00       	push   $0x803278
  80091d:	68 a3 00 00 00       	push   $0xa3
  800922:	68 21 31 80 00       	push   $0x803121
  800927:	e8 11 0c 00 00       	call   80153d <_panic>
		//check memory and buffers
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 2 + 2) panic("Wrong free: WS pages in memory, buffers and/or page tables are not freed correctly");
  80092c:	e8 45 20 00 00       	call   802976 <sys_calculate_free_frames>
  800931:	89 c2                	mov    %eax,%edx
  800933:	8b 45 8c             	mov    -0x74(%ebp),%eax
  800936:	29 c2                	sub    %eax,%edx
  800938:	89 d0                	mov    %edx,%eax
  80093a:	83 f8 07             	cmp    $0x7,%eax
  80093d:	74 17                	je     800956 <_main+0x91e>
  80093f:	83 ec 04             	sub    $0x4,%esp
  800942:	68 b4 32 80 00       	push   $0x8032b4
  800947:	68 a5 00 00 00       	push   $0xa5
  80094c:	68 21 31 80 00       	push   $0x803121
  800951:	e8 e7 0b 00 00       	call   80153d <_panic>
		if ((sys_calculate_modified_frames() - modFrames) != 2) panic("Wrong free: pages mod buffers are not freed correctly");
  800956:	e8 34 20 00 00       	call   80298f <sys_calculate_modified_frames>
  80095b:	89 c2                	mov    %eax,%edx
  80095d:	8b 45 88             	mov    -0x78(%ebp),%eax
  800960:	29 c2                	sub    %eax,%edx
  800962:	89 d0                	mov    %edx,%eax
  800964:	83 f8 02             	cmp    $0x2,%eax
  800967:	74 17                	je     800980 <_main+0x948>
  800969:	83 ec 04             	sub    $0x4,%esp
  80096c:	68 08 33 80 00       	push   $0x803308
  800971:	68 a6 00 00 00       	push   $0xa6
  800976:	68 21 31 80 00       	push   $0x803121
  80097b:	e8 bd 0b 00 00       	call   80153d <_panic>
		//check WS
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
  800980:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800987:	e9 86 00 00 00       	jmp    800a12 <_main+0x9da>
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  80098c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800993:	eb 6b                	jmp    800a00 <_main+0x9c8>
			{
				if(ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr[indicesOf3MB[var]])), PAGE_SIZE))
  800995:	a1 20 40 80 00       	mov    0x804020,%eax
  80099a:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8009a0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009a3:	c1 e2 04             	shl    $0x4,%edx
  8009a6:	01 d0                	add    %edx,%eax
  8009a8:	8b 00                	mov    (%eax),%eax
  8009aa:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  8009b0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  8009b6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009bb:	89 c2                	mov    %eax,%edx
  8009bd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8009c0:	8b 84 85 e0 fe ff ff 	mov    -0x120(%ebp,%eax,4),%eax
  8009c7:	89 c1                	mov    %eax,%ecx
  8009c9:	8b 85 7c ff ff ff    	mov    -0x84(%ebp),%eax
  8009cf:	01 c8                	add    %ecx,%eax
  8009d1:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  8009d7:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
  8009dd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009e2:	39 c2                	cmp    %eax,%edx
  8009e4:	75 17                	jne    8009fd <_main+0x9c5>
				{
					panic("free: page is not removed from WS");
  8009e6:	83 ec 04             	sub    $0x4,%esp
  8009e9:	68 40 33 80 00       	push   $0x803340
  8009ee:	68 ae 00 00 00       	push   $0xae
  8009f3:	68 21 31 80 00       	push   $0x803121
  8009f8:	e8 40 0b 00 00       	call   80153d <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 2 + 2) panic("Wrong free: WS pages in memory, buffers and/or page tables are not freed correctly");
		if ((sys_calculate_modified_frames() - modFrames) != 2) panic("Wrong free: pages mod buffers are not freed correctly");
		//check WS
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
		{
			for (i = 0 ; i < (myEnv->page_WS_max_size); i++)
  8009fd:	ff 45 e0             	incl   -0x20(%ebp)
  800a00:	a1 20 40 80 00       	mov    0x804020,%eax
  800a05:	8b 50 74             	mov    0x74(%eax),%edx
  800a08:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a0b:	39 c2                	cmp    %eax,%edx
  800a0d:	77 86                	ja     800995 <_main+0x95d>
		if ((usedDiskPages - sys_pf_calculate_allocated_pages()) != 3*Mega/PAGE_SIZE) panic("Wrong free: Extra or less pages are removed from PageFile");
		//check memory and buffers
		if ((sys_calculate_free_frames() - freeFrames) != 3 + 2 + 2) panic("Wrong free: WS pages in memory, buffers and/or page tables are not freed correctly");
		if ((sys_calculate_modified_frames() - modFrames) != 2) panic("Wrong free: pages mod buffers are not freed correctly");
		//check WS
		for (var = 0; var < numOfAccessesFor3MB ; ++var)
  800a0f:	ff 45 e4             	incl   -0x1c(%ebp)
  800a12:	83 7d e4 06          	cmpl   $0x6,-0x1c(%ebp)
  800a16:	0f 8e 70 ff ff ff    	jle    80098c <_main+0x954>
			}
		}



		freeFrames = sys_calculate_free_frames() ;
  800a1c:	e8 55 1f 00 00       	call   802976 <sys_calculate_free_frames>
  800a21:	89 45 8c             	mov    %eax,-0x74(%ebp)
		shortArr = (short *) ptr_allocations[2];
  800a24:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800a2a:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
  800a30:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800a33:	01 c0                	add    %eax,%eax
  800a35:	2b 45 d0             	sub    -0x30(%ebp),%eax
  800a38:	d1 e8                	shr    %eax
  800a3a:	48                   	dec    %eax
  800a3b:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
		shortArr[0] = minShort;
  800a41:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
  800a47:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800a4a:	66 89 02             	mov    %ax,(%edx)
		shortArr[lastIndexOfShort] = maxShort;
  800a4d:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800a53:	01 c0                	add    %eax,%eax
  800a55:	89 c2                	mov    %eax,%edx
  800a57:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800a5d:	01 c2                	add    %eax,%edx
  800a5f:	66 8b 45 ca          	mov    -0x36(%ebp),%ax
  800a63:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800a66:	8b 5d 8c             	mov    -0x74(%ebp),%ebx
  800a69:	e8 08 1f 00 00       	call   802976 <sys_calculate_free_frames>
  800a6e:	29 c3                	sub    %eax,%ebx
  800a70:	89 d8                	mov    %ebx,%eax
  800a72:	83 f8 02             	cmp    $0x2,%eax
  800a75:	74 17                	je     800a8e <_main+0xa56>
  800a77:	83 ec 04             	sub    $0x4,%esp
  800a7a:	68 14 32 80 00       	push   $0x803214
  800a7f:	68 ba 00 00 00       	push   $0xba
  800a84:	68 21 31 80 00       	push   $0x803121
  800a89:	e8 af 0a 00 00       	call   80153d <_panic>
		found = 0;
  800a8e:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800a95:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800a9c:	e9 9b 00 00 00       	jmp    800b3c <_main+0xb04>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
  800aa1:	a1 20 40 80 00       	mov    0x804020,%eax
  800aa6:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800aac:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800aaf:	c1 e2 04             	shl    $0x4,%edx
  800ab2:	01 d0                	add    %edx,%eax
  800ab4:	8b 00                	mov    (%eax),%eax
  800ab6:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
  800abc:	8b 85 58 ff ff ff    	mov    -0xa8(%ebp),%eax
  800ac2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ac7:	89 c2                	mov    %eax,%edx
  800ac9:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800acf:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
  800ad5:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
  800adb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ae0:	39 c2                	cmp    %eax,%edx
  800ae2:	75 03                	jne    800ae7 <_main+0xaaf>
				found++;
  800ae4:	ff 45 d8             	incl   -0x28(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
  800ae7:	a1 20 40 80 00       	mov    0x804020,%eax
  800aec:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800af2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800af5:	c1 e2 04             	shl    $0x4,%edx
  800af8:	01 d0                	add    %edx,%eax
  800afa:	8b 00                	mov    (%eax),%eax
  800afc:	89 85 50 ff ff ff    	mov    %eax,-0xb0(%ebp)
  800b02:	8b 85 50 ff ff ff    	mov    -0xb0(%ebp),%eax
  800b08:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b0d:	89 c2                	mov    %eax,%edx
  800b0f:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
  800b15:	01 c0                	add    %eax,%eax
  800b17:	89 c1                	mov    %eax,%ecx
  800b19:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
  800b1f:	01 c8                	add    %ecx,%eax
  800b21:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
  800b27:	8b 85 4c ff ff ff    	mov    -0xb4(%ebp),%eax
  800b2d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800b32:	39 c2                	cmp    %eax,%edx
  800b34:	75 03                	jne    800b39 <_main+0xb01>
				found++;
  800b36:	ff 45 d8             	incl   -0x28(%ebp)
		lastIndexOfShort = (2*Mega-kilo)/sizeof(short) - 1;
		shortArr[0] = minShort;
		shortArr[lastIndexOfShort] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2 ) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800b39:	ff 45 e4             	incl   -0x1c(%ebp)
  800b3c:	a1 20 40 80 00       	mov    0x804020,%eax
  800b41:	8b 50 74             	mov    0x74(%eax),%edx
  800b44:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800b47:	39 c2                	cmp    %eax,%edx
  800b49:	0f 87 52 ff ff ff    	ja     800aa1 <_main+0xa69>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr[lastIndexOfShort])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800b4f:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
  800b53:	74 17                	je     800b6c <_main+0xb34>
  800b55:	83 ec 04             	sub    $0x4,%esp
  800b58:	68 58 32 80 00       	push   $0x803258
  800b5d:	68 c3 00 00 00       	push   $0xc3
  800b62:	68 21 31 80 00       	push   $0x803121
  800b67:	e8 d1 09 00 00       	call   80153d <_panic>

		//2 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800b6c:	e8 88 1e 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  800b71:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[2] = malloc(2*kilo);
  800b74:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800b77:	01 c0                	add    %eax,%eax
  800b79:	83 ec 0c             	sub    $0xc,%esp
  800b7c:	50                   	push   %eax
  800b7d:	e8 e7 19 00 00       	call   802569 <malloc>
  800b82:	83 c4 10             	add    $0x10,%esp
  800b85:	89 85 88 fe ff ff    	mov    %eax,-0x178(%ebp)
		if ((uint32) ptr_allocations[2] < (USER_HEAP_START + 4*Mega) || (uint32) ptr_allocations[2] > (USER_HEAP_START+ 4*Mega+PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800b8b:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800b91:	89 c2                	mov    %eax,%edx
  800b93:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800b96:	c1 e0 02             	shl    $0x2,%eax
  800b99:	05 00 00 00 80       	add    $0x80000000,%eax
  800b9e:	39 c2                	cmp    %eax,%edx
  800ba0:	72 17                	jb     800bb9 <_main+0xb81>
  800ba2:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800ba8:	89 c2                	mov    %eax,%edx
  800baa:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800bad:	c1 e0 02             	shl    $0x2,%eax
  800bb0:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800bb5:	39 c2                	cmp    %eax,%edx
  800bb7:	76 17                	jbe    800bd0 <_main+0xb98>
  800bb9:	83 ec 04             	sub    $0x4,%esp
  800bbc:	68 7c 31 80 00       	push   $0x80317c
  800bc1:	68 c8 00 00 00       	push   $0xc8
  800bc6:	68 21 31 80 00       	push   $0x803121
  800bcb:	e8 6d 09 00 00       	call   80153d <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800bd0:	e8 24 1e 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  800bd5:	2b 45 90             	sub    -0x70(%ebp),%eax
  800bd8:	83 f8 01             	cmp    $0x1,%eax
  800bdb:	74 17                	je     800bf4 <_main+0xbbc>
  800bdd:	83 ec 04             	sub    $0x4,%esp
  800be0:	68 e4 31 80 00       	push   $0x8031e4
  800be5:	68 c9 00 00 00       	push   $0xc9
  800bea:	68 21 31 80 00       	push   $0x803121
  800bef:	e8 49 09 00 00       	call   80153d <_panic>

		freeFrames = sys_calculate_free_frames() ;
  800bf4:	e8 7d 1d 00 00       	call   802976 <sys_calculate_free_frames>
  800bf9:	89 45 8c             	mov    %eax,-0x74(%ebp)
		intArr = (int *) ptr_allocations[2];
  800bfc:	8b 85 88 fe ff ff    	mov    -0x178(%ebp),%eax
  800c02:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
  800c08:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800c0b:	01 c0                	add    %eax,%eax
  800c0d:	c1 e8 02             	shr    $0x2,%eax
  800c10:	48                   	dec    %eax
  800c11:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
		intArr[0] = minInt;
  800c17:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800c1d:	8b 55 c4             	mov    -0x3c(%ebp),%edx
  800c20:	89 10                	mov    %edx,(%eax)
		intArr[lastIndexOfInt] = maxInt;
  800c22:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800c28:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800c2f:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800c35:	01 c2                	add    %eax,%edx
  800c37:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800c3a:	89 02                	mov    %eax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  800c3c:	8b 5d 8c             	mov    -0x74(%ebp),%ebx
  800c3f:	e8 32 1d 00 00       	call   802976 <sys_calculate_free_frames>
  800c44:	29 c3                	sub    %eax,%ebx
  800c46:	89 d8                	mov    %ebx,%eax
  800c48:	83 f8 02             	cmp    $0x2,%eax
  800c4b:	74 17                	je     800c64 <_main+0xc2c>
  800c4d:	83 ec 04             	sub    $0x4,%esp
  800c50:	68 14 32 80 00       	push   $0x803214
  800c55:	68 d0 00 00 00       	push   $0xd0
  800c5a:	68 21 31 80 00       	push   $0x803121
  800c5f:	e8 d9 08 00 00       	call   80153d <_panic>
		found = 0;
  800c64:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800c6b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  800c72:	e9 9e 00 00 00       	jmp    800d15 <_main+0xcdd>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
  800c77:	a1 20 40 80 00       	mov    0x804020,%eax
  800c7c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800c82:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800c85:	c1 e2 04             	shl    $0x4,%edx
  800c88:	01 d0                	add    %edx,%eax
  800c8a:	8b 00                	mov    (%eax),%eax
  800c8c:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
  800c92:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  800c98:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800c9d:	89 c2                	mov    %eax,%edx
  800c9f:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800ca5:	89 85 3c ff ff ff    	mov    %eax,-0xc4(%ebp)
  800cab:	8b 85 3c ff ff ff    	mov    -0xc4(%ebp),%eax
  800cb1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800cb6:	39 c2                	cmp    %eax,%edx
  800cb8:	75 03                	jne    800cbd <_main+0xc85>
				found++;
  800cba:	ff 45 d8             	incl   -0x28(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
  800cbd:	a1 20 40 80 00       	mov    0x804020,%eax
  800cc2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800cc8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800ccb:	c1 e2 04             	shl    $0x4,%edx
  800cce:	01 d0                	add    %edx,%eax
  800cd0:	8b 00                	mov    (%eax),%eax
  800cd2:	89 85 38 ff ff ff    	mov    %eax,-0xc8(%ebp)
  800cd8:	8b 85 38 ff ff ff    	mov    -0xc8(%ebp),%eax
  800cde:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800ce3:	89 c2                	mov    %eax,%edx
  800ce5:	8b 85 44 ff ff ff    	mov    -0xbc(%ebp),%eax
  800ceb:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800cf2:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
  800cf8:	01 c8                	add    %ecx,%eax
  800cfa:	89 85 34 ff ff ff    	mov    %eax,-0xcc(%ebp)
  800d00:	8b 85 34 ff ff ff    	mov    -0xcc(%ebp),%eax
  800d06:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800d0b:	39 c2                	cmp    %eax,%edx
  800d0d:	75 03                	jne    800d12 <_main+0xcda>
				found++;
  800d0f:	ff 45 d8             	incl   -0x28(%ebp)
		lastIndexOfInt = (2*kilo)/sizeof(int) - 1;
		intArr[0] = minInt;
		intArr[lastIndexOfInt] = maxInt;
		if ((freeFrames - sys_calculate_free_frames()) != 1 + 1) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  800d12:	ff 45 e4             	incl   -0x1c(%ebp)
  800d15:	a1 20 40 80 00       	mov    0x804020,%eax
  800d1a:	8b 50 74             	mov    0x74(%eax),%edx
  800d1d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800d20:	39 c2                	cmp    %eax,%edx
  800d22:	0f 87 4f ff ff ff    	ja     800c77 <_main+0xc3f>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(intArr[lastIndexOfInt])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  800d28:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
  800d2c:	74 17                	je     800d45 <_main+0xd0d>
  800d2e:	83 ec 04             	sub    $0x4,%esp
  800d31:	68 58 32 80 00       	push   $0x803258
  800d36:	68 d9 00 00 00       	push   $0xd9
  800d3b:	68 21 31 80 00       	push   $0x803121
  800d40:	e8 f8 07 00 00       	call   80153d <_panic>

		//2 KB
		freeFrames = sys_calculate_free_frames() ;
  800d45:	e8 2c 1c 00 00       	call   802976 <sys_calculate_free_frames>
  800d4a:	89 45 8c             	mov    %eax,-0x74(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800d4d:	e8 a7 1c 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  800d52:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[3] = malloc(2*kilo);
  800d55:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800d58:	01 c0                	add    %eax,%eax
  800d5a:	83 ec 0c             	sub    $0xc,%esp
  800d5d:	50                   	push   %eax
  800d5e:	e8 06 18 00 00       	call   802569 <malloc>
  800d63:	83 c4 10             	add    $0x10,%esp
  800d66:	89 85 8c fe ff ff    	mov    %eax,-0x174(%ebp)
		if ((uint32) ptr_allocations[3] < (USER_HEAP_START + 4*Mega + 4*kilo) || (uint32) ptr_allocations[3] > (USER_HEAP_START+ 4*Mega + 4*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800d6c:	8b 85 8c fe ff ff    	mov    -0x174(%ebp),%eax
  800d72:	89 c2                	mov    %eax,%edx
  800d74:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800d77:	c1 e0 02             	shl    $0x2,%eax
  800d7a:	89 c1                	mov    %eax,%ecx
  800d7c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800d7f:	c1 e0 02             	shl    $0x2,%eax
  800d82:	01 c8                	add    %ecx,%eax
  800d84:	05 00 00 00 80       	add    $0x80000000,%eax
  800d89:	39 c2                	cmp    %eax,%edx
  800d8b:	72 21                	jb     800dae <_main+0xd76>
  800d8d:	8b 85 8c fe ff ff    	mov    -0x174(%ebp),%eax
  800d93:	89 c2                	mov    %eax,%edx
  800d95:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800d98:	c1 e0 02             	shl    $0x2,%eax
  800d9b:	89 c1                	mov    %eax,%ecx
  800d9d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800da0:	c1 e0 02             	shl    $0x2,%eax
  800da3:	01 c8                	add    %ecx,%eax
  800da5:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800daa:	39 c2                	cmp    %eax,%edx
  800dac:	76 17                	jbe    800dc5 <_main+0xd8d>
  800dae:	83 ec 04             	sub    $0x4,%esp
  800db1:	68 7c 31 80 00       	push   $0x80317c
  800db6:	68 df 00 00 00       	push   $0xdf
  800dbb:	68 21 31 80 00       	push   $0x803121
  800dc0:	e8 78 07 00 00       	call   80153d <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 1) panic("Extra or less pages are allocated in PageFile");
  800dc5:	e8 2f 1c 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  800dca:	2b 45 90             	sub    -0x70(%ebp),%eax
  800dcd:	83 f8 01             	cmp    $0x1,%eax
  800dd0:	74 17                	je     800de9 <_main+0xdb1>
  800dd2:	83 ec 04             	sub    $0x4,%esp
  800dd5:	68 e4 31 80 00       	push   $0x8031e4
  800dda:	68 e0 00 00 00       	push   $0xe0
  800ddf:	68 21 31 80 00       	push   $0x803121
  800de4:	e8 54 07 00 00       	call   80153d <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//7 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800de9:	e8 0b 1c 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  800dee:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[4] = malloc(7*kilo);
  800df1:	8b 55 d0             	mov    -0x30(%ebp),%edx
  800df4:	89 d0                	mov    %edx,%eax
  800df6:	01 c0                	add    %eax,%eax
  800df8:	01 d0                	add    %edx,%eax
  800dfa:	01 c0                	add    %eax,%eax
  800dfc:	01 d0                	add    %edx,%eax
  800dfe:	83 ec 0c             	sub    $0xc,%esp
  800e01:	50                   	push   %eax
  800e02:	e8 62 17 00 00       	call   802569 <malloc>
  800e07:	83 c4 10             	add    $0x10,%esp
  800e0a:	89 85 90 fe ff ff    	mov    %eax,-0x170(%ebp)
		if ((uint32) ptr_allocations[4] < (USER_HEAP_START + 4*Mega + 8*kilo)|| (uint32) ptr_allocations[4] > (USER_HEAP_START+ 4*Mega + 8*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800e10:	8b 85 90 fe ff ff    	mov    -0x170(%ebp),%eax
  800e16:	89 c2                	mov    %eax,%edx
  800e18:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800e1b:	c1 e0 02             	shl    $0x2,%eax
  800e1e:	89 c1                	mov    %eax,%ecx
  800e20:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800e23:	c1 e0 03             	shl    $0x3,%eax
  800e26:	01 c8                	add    %ecx,%eax
  800e28:	05 00 00 00 80       	add    $0x80000000,%eax
  800e2d:	39 c2                	cmp    %eax,%edx
  800e2f:	72 21                	jb     800e52 <_main+0xe1a>
  800e31:	8b 85 90 fe ff ff    	mov    -0x170(%ebp),%eax
  800e37:	89 c2                	mov    %eax,%edx
  800e39:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800e3c:	c1 e0 02             	shl    $0x2,%eax
  800e3f:	89 c1                	mov    %eax,%ecx
  800e41:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800e44:	c1 e0 03             	shl    $0x3,%eax
  800e47:	01 c8                	add    %ecx,%eax
  800e49:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800e4e:	39 c2                	cmp    %eax,%edx
  800e50:	76 17                	jbe    800e69 <_main+0xe31>
  800e52:	83 ec 04             	sub    $0x4,%esp
  800e55:	68 7c 31 80 00       	push   $0x80317c
  800e5a:	68 e6 00 00 00       	push   $0xe6
  800e5f:	68 21 31 80 00       	push   $0x803121
  800e64:	e8 d4 06 00 00       	call   80153d <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 2) panic("Extra or less pages are allocated in PageFile");
  800e69:	e8 8b 1b 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  800e6e:	2b 45 90             	sub    -0x70(%ebp),%eax
  800e71:	83 f8 02             	cmp    $0x2,%eax
  800e74:	74 17                	je     800e8d <_main+0xe55>
  800e76:	83 ec 04             	sub    $0x4,%esp
  800e79:	68 e4 31 80 00       	push   $0x8031e4
  800e7e:	68 e7 00 00 00       	push   $0xe7
  800e83:	68 21 31 80 00       	push   $0x803121
  800e88:	e8 b0 06 00 00       	call   80153d <_panic>


		//3 MB
		freeFrames = sys_calculate_free_frames() ;
  800e8d:	e8 e4 1a 00 00       	call   802976 <sys_calculate_free_frames>
  800e92:	89 45 8c             	mov    %eax,-0x74(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800e95:	e8 5f 1b 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  800e9a:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[5] = malloc(3*Mega-kilo);
  800e9d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800ea0:	89 c2                	mov    %eax,%edx
  800ea2:	01 d2                	add    %edx,%edx
  800ea4:	01 d0                	add    %edx,%eax
  800ea6:	2b 45 d0             	sub    -0x30(%ebp),%eax
  800ea9:	83 ec 0c             	sub    $0xc,%esp
  800eac:	50                   	push   %eax
  800ead:	e8 b7 16 00 00       	call   802569 <malloc>
  800eb2:	83 c4 10             	add    $0x10,%esp
  800eb5:	89 85 94 fe ff ff    	mov    %eax,-0x16c(%ebp)
		if ((uint32) ptr_allocations[5] < (USER_HEAP_START + 4*Mega + 16*kilo) || (uint32) ptr_allocations[5] > (USER_HEAP_START+ 4*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800ebb:	8b 85 94 fe ff ff    	mov    -0x16c(%ebp),%eax
  800ec1:	89 c2                	mov    %eax,%edx
  800ec3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800ec6:	c1 e0 02             	shl    $0x2,%eax
  800ec9:	89 c1                	mov    %eax,%ecx
  800ecb:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800ece:	c1 e0 04             	shl    $0x4,%eax
  800ed1:	01 c8                	add    %ecx,%eax
  800ed3:	05 00 00 00 80       	add    $0x80000000,%eax
  800ed8:	39 c2                	cmp    %eax,%edx
  800eda:	72 21                	jb     800efd <_main+0xec5>
  800edc:	8b 85 94 fe ff ff    	mov    -0x16c(%ebp),%eax
  800ee2:	89 c2                	mov    %eax,%edx
  800ee4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800ee7:	c1 e0 02             	shl    $0x2,%eax
  800eea:	89 c1                	mov    %eax,%ecx
  800eec:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800eef:	c1 e0 04             	shl    $0x4,%eax
  800ef2:	01 c8                	add    %ecx,%eax
  800ef4:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800ef9:	39 c2                	cmp    %eax,%edx
  800efb:	76 17                	jbe    800f14 <_main+0xedc>
  800efd:	83 ec 04             	sub    $0x4,%esp
  800f00:	68 7c 31 80 00       	push   $0x80317c
  800f05:	68 ee 00 00 00       	push   $0xee
  800f0a:	68 21 31 80 00       	push   $0x803121
  800f0f:	e8 29 06 00 00       	call   80153d <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 3*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800f14:	e8 e0 1a 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  800f19:	2b 45 90             	sub    -0x70(%ebp),%eax
  800f1c:	89 c2                	mov    %eax,%edx
  800f1e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800f21:	89 c1                	mov    %eax,%ecx
  800f23:	01 c9                	add    %ecx,%ecx
  800f25:	01 c8                	add    %ecx,%eax
  800f27:	85 c0                	test   %eax,%eax
  800f29:	79 05                	jns    800f30 <_main+0xef8>
  800f2b:	05 ff 0f 00 00       	add    $0xfff,%eax
  800f30:	c1 f8 0c             	sar    $0xc,%eax
  800f33:	39 c2                	cmp    %eax,%edx
  800f35:	74 17                	je     800f4e <_main+0xf16>
  800f37:	83 ec 04             	sub    $0x4,%esp
  800f3a:	68 e4 31 80 00       	push   $0x8031e4
  800f3f:	68 ef 00 00 00       	push   $0xef
  800f44:	68 21 31 80 00       	push   $0x803121
  800f49:	e8 ef 05 00 00       	call   80153d <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");

		//6 MB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800f4e:	e8 a6 1a 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  800f53:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[6] = malloc(6*Mega-kilo);
  800f56:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800f59:	89 d0                	mov    %edx,%eax
  800f5b:	01 c0                	add    %eax,%eax
  800f5d:	01 d0                	add    %edx,%eax
  800f5f:	01 c0                	add    %eax,%eax
  800f61:	2b 45 d0             	sub    -0x30(%ebp),%eax
  800f64:	83 ec 0c             	sub    $0xc,%esp
  800f67:	50                   	push   %eax
  800f68:	e8 fc 15 00 00       	call   802569 <malloc>
  800f6d:	83 c4 10             	add    $0x10,%esp
  800f70:	89 85 98 fe ff ff    	mov    %eax,-0x168(%ebp)
		if ((uint32) ptr_allocations[6] < (USER_HEAP_START + 7*Mega + 16*kilo) || (uint32) ptr_allocations[6] > (USER_HEAP_START+ 7*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  800f76:	8b 85 98 fe ff ff    	mov    -0x168(%ebp),%eax
  800f7c:	89 c1                	mov    %eax,%ecx
  800f7e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800f81:	89 d0                	mov    %edx,%eax
  800f83:	01 c0                	add    %eax,%eax
  800f85:	01 d0                	add    %edx,%eax
  800f87:	01 c0                	add    %eax,%eax
  800f89:	01 d0                	add    %edx,%eax
  800f8b:	89 c2                	mov    %eax,%edx
  800f8d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800f90:	c1 e0 04             	shl    $0x4,%eax
  800f93:	01 d0                	add    %edx,%eax
  800f95:	05 00 00 00 80       	add    $0x80000000,%eax
  800f9a:	39 c1                	cmp    %eax,%ecx
  800f9c:	72 28                	jb     800fc6 <_main+0xf8e>
  800f9e:	8b 85 98 fe ff ff    	mov    -0x168(%ebp),%eax
  800fa4:	89 c1                	mov    %eax,%ecx
  800fa6:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800fa9:	89 d0                	mov    %edx,%eax
  800fab:	01 c0                	add    %eax,%eax
  800fad:	01 d0                	add    %edx,%eax
  800faf:	01 c0                	add    %eax,%eax
  800fb1:	01 d0                	add    %edx,%eax
  800fb3:	89 c2                	mov    %eax,%edx
  800fb5:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800fb8:	c1 e0 04             	shl    $0x4,%eax
  800fbb:	01 d0                	add    %edx,%eax
  800fbd:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  800fc2:	39 c1                	cmp    %eax,%ecx
  800fc4:	76 17                	jbe    800fdd <_main+0xfa5>
  800fc6:	83 ec 04             	sub    $0x4,%esp
  800fc9:	68 7c 31 80 00       	push   $0x80317c
  800fce:	68 f5 00 00 00       	push   $0xf5
  800fd3:	68 21 31 80 00       	push   $0x803121
  800fd8:	e8 60 05 00 00       	call   80153d <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 6*Mega/4096) panic("Extra or less pages are allocated in PageFile");
  800fdd:	e8 17 1a 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  800fe2:	2b 45 90             	sub    -0x70(%ebp),%eax
  800fe5:	89 c1                	mov    %eax,%ecx
  800fe7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800fea:	89 d0                	mov    %edx,%eax
  800fec:	01 c0                	add    %eax,%eax
  800fee:	01 d0                	add    %edx,%eax
  800ff0:	01 c0                	add    %eax,%eax
  800ff2:	85 c0                	test   %eax,%eax
  800ff4:	79 05                	jns    800ffb <_main+0xfc3>
  800ff6:	05 ff 0f 00 00       	add    $0xfff,%eax
  800ffb:	c1 f8 0c             	sar    $0xc,%eax
  800ffe:	39 c1                	cmp    %eax,%ecx
  801000:	74 17                	je     801019 <_main+0xfe1>
  801002:	83 ec 04             	sub    $0x4,%esp
  801005:	68 e4 31 80 00       	push   $0x8031e4
  80100a:	68 f6 00 00 00       	push   $0xf6
  80100f:	68 21 31 80 00       	push   $0x803121
  801014:	e8 24 05 00 00       	call   80153d <_panic>

		freeFrames = sys_calculate_free_frames() ;
  801019:	e8 58 19 00 00       	call   802976 <sys_calculate_free_frames>
  80101e:	89 45 8c             	mov    %eax,-0x74(%ebp)
		lastIndexOfByte2 = (6*Mega-kilo)/sizeof(char) - 1;
  801021:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801024:	89 d0                	mov    %edx,%eax
  801026:	01 c0                	add    %eax,%eax
  801028:	01 d0                	add    %edx,%eax
  80102a:	01 c0                	add    %eax,%eax
  80102c:	2b 45 d0             	sub    -0x30(%ebp),%eax
  80102f:	48                   	dec    %eax
  801030:	89 85 30 ff ff ff    	mov    %eax,-0xd0(%ebp)
		byteArr2 = (char *) ptr_allocations[6];
  801036:	8b 85 98 fe ff ff    	mov    -0x168(%ebp),%eax
  80103c:	89 85 2c ff ff ff    	mov    %eax,-0xd4(%ebp)
		byteArr2[0] = minByte ;
  801042:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  801048:	8a 55 cf             	mov    -0x31(%ebp),%dl
  80104b:	88 10                	mov    %dl,(%eax)
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
  80104d:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  801053:	89 c2                	mov    %eax,%edx
  801055:	c1 ea 1f             	shr    $0x1f,%edx
  801058:	01 d0                	add    %edx,%eax
  80105a:	d1 f8                	sar    %eax
  80105c:	89 c2                	mov    %eax,%edx
  80105e:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  801064:	01 c2                	add    %eax,%edx
  801066:	8a 45 ce             	mov    -0x32(%ebp),%al
  801069:	88 c1                	mov    %al,%cl
  80106b:	c0 e9 07             	shr    $0x7,%cl
  80106e:	01 c8                	add    %ecx,%eax
  801070:	d0 f8                	sar    %al
  801072:	88 02                	mov    %al,(%edx)
		byteArr2[lastIndexOfByte2] = maxByte ;
  801074:	8b 95 30 ff ff ff    	mov    -0xd0(%ebp),%edx
  80107a:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  801080:	01 c2                	add    %eax,%edx
  801082:	8a 45 ce             	mov    -0x32(%ebp),%al
  801085:	88 02                	mov    %al,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  801087:	8b 5d 8c             	mov    -0x74(%ebp),%ebx
  80108a:	e8 e7 18 00 00       	call   802976 <sys_calculate_free_frames>
  80108f:	29 c3                	sub    %eax,%ebx
  801091:	89 d8                	mov    %ebx,%eax
  801093:	83 f8 05             	cmp    $0x5,%eax
  801096:	74 17                	je     8010af <_main+0x1077>
  801098:	83 ec 04             	sub    $0x4,%esp
  80109b:	68 14 32 80 00       	push   $0x803214
  8010a0:	68 fe 00 00 00       	push   $0xfe
  8010a5:	68 21 31 80 00       	push   $0x803121
  8010aa:	e8 8e 04 00 00       	call   80153d <_panic>
		found = 0;
  8010af:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8010b6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8010bd:	e9 f0 00 00 00       	jmp    8011b2 <_main+0x117a>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[0])), PAGE_SIZE))
  8010c2:	a1 20 40 80 00       	mov    0x804020,%eax
  8010c7:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8010cd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8010d0:	c1 e2 04             	shl    $0x4,%edx
  8010d3:	01 d0                	add    %edx,%eax
  8010d5:	8b 00                	mov    (%eax),%eax
  8010d7:	89 85 28 ff ff ff    	mov    %eax,-0xd8(%ebp)
  8010dd:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
  8010e3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8010e8:	89 c2                	mov    %eax,%edx
  8010ea:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  8010f0:	89 85 24 ff ff ff    	mov    %eax,-0xdc(%ebp)
  8010f6:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
  8010fc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801101:	39 c2                	cmp    %eax,%edx
  801103:	75 03                	jne    801108 <_main+0x10d0>
				found++;
  801105:	ff 45 d8             	incl   -0x28(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
  801108:	a1 20 40 80 00       	mov    0x804020,%eax
  80110d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801113:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801116:	c1 e2 04             	shl    $0x4,%edx
  801119:	01 d0                	add    %edx,%eax
  80111b:	8b 00                	mov    (%eax),%eax
  80111d:	89 85 20 ff ff ff    	mov    %eax,-0xe0(%ebp)
  801123:	8b 85 20 ff ff ff    	mov    -0xe0(%ebp),%eax
  801129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80112e:	89 c2                	mov    %eax,%edx
  801130:	8b 85 30 ff ff ff    	mov    -0xd0(%ebp),%eax
  801136:	89 c1                	mov    %eax,%ecx
  801138:	c1 e9 1f             	shr    $0x1f,%ecx
  80113b:	01 c8                	add    %ecx,%eax
  80113d:	d1 f8                	sar    %eax
  80113f:	89 c1                	mov    %eax,%ecx
  801141:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  801147:	01 c8                	add    %ecx,%eax
  801149:	89 85 1c ff ff ff    	mov    %eax,-0xe4(%ebp)
  80114f:	8b 85 1c ff ff ff    	mov    -0xe4(%ebp),%eax
  801155:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80115a:	39 c2                	cmp    %eax,%edx
  80115c:	75 03                	jne    801161 <_main+0x1129>
				found++;
  80115e:	ff 45 d8             	incl   -0x28(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
  801161:	a1 20 40 80 00       	mov    0x804020,%eax
  801166:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80116c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80116f:	c1 e2 04             	shl    $0x4,%edx
  801172:	01 d0                	add    %edx,%eax
  801174:	8b 00                	mov    (%eax),%eax
  801176:	89 85 18 ff ff ff    	mov    %eax,-0xe8(%ebp)
  80117c:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
  801182:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801187:	89 c1                	mov    %eax,%ecx
  801189:	8b 95 30 ff ff ff    	mov    -0xd0(%ebp),%edx
  80118f:	8b 85 2c ff ff ff    	mov    -0xd4(%ebp),%eax
  801195:	01 d0                	add    %edx,%eax
  801197:	89 85 14 ff ff ff    	mov    %eax,-0xec(%ebp)
  80119d:	8b 85 14 ff ff ff    	mov    -0xec(%ebp),%eax
  8011a3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8011a8:	39 c1                	cmp    %eax,%ecx
  8011aa:	75 03                	jne    8011af <_main+0x1177>
				found++;
  8011ac:	ff 45 d8             	incl   -0x28(%ebp)
		byteArr2[0] = minByte ;
		byteArr2[lastIndexOfByte2 / 2] = maxByte / 2;
		byteArr2[lastIndexOfByte2] = maxByte ;
		if ((freeFrames - sys_calculate_free_frames()) != 3 + 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8011af:	ff 45 e4             	incl   -0x1c(%ebp)
  8011b2:	a1 20 40 80 00       	mov    0x804020,%eax
  8011b7:	8b 50 74             	mov    0x74(%eax),%edx
  8011ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8011bd:	39 c2                	cmp    %eax,%edx
  8011bf:	0f 87 fd fe ff ff    	ja     8010c2 <_main+0x108a>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2/2])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(byteArr2[lastIndexOfByte2])), PAGE_SIZE))
				found++;
		}
		if (found != 3) panic("malloc: page is not added to WS");
  8011c5:	83 7d d8 03          	cmpl   $0x3,-0x28(%ebp)
  8011c9:	74 17                	je     8011e2 <_main+0x11aa>
  8011cb:	83 ec 04             	sub    $0x4,%esp
  8011ce:	68 58 32 80 00       	push   $0x803258
  8011d3:	68 09 01 00 00       	push   $0x109
  8011d8:	68 21 31 80 00       	push   $0x803121
  8011dd:	e8 5b 03 00 00       	call   80153d <_panic>

		//14 KB
		usedDiskPages = sys_pf_calculate_allocated_pages() ;
  8011e2:	e8 12 18 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  8011e7:	89 45 90             	mov    %eax,-0x70(%ebp)
		ptr_allocations[7] = malloc(14*kilo);
  8011ea:	8b 55 d0             	mov    -0x30(%ebp),%edx
  8011ed:	89 d0                	mov    %edx,%eax
  8011ef:	01 c0                	add    %eax,%eax
  8011f1:	01 d0                	add    %edx,%eax
  8011f3:	01 c0                	add    %eax,%eax
  8011f5:	01 d0                	add    %edx,%eax
  8011f7:	01 c0                	add    %eax,%eax
  8011f9:	83 ec 0c             	sub    $0xc,%esp
  8011fc:	50                   	push   %eax
  8011fd:	e8 67 13 00 00       	call   802569 <malloc>
  801202:	83 c4 10             	add    $0x10,%esp
  801205:	89 85 9c fe ff ff    	mov    %eax,-0x164(%ebp)
		if ((uint32) ptr_allocations[7] < (USER_HEAP_START + 13*Mega + 16*kilo)|| (uint32) ptr_allocations[7] > (USER_HEAP_START+ 13*Mega + 16*kilo +PAGE_SIZE)) panic("Wrong start address for the allocated space... check return address of malloc & updating of heap ptr");
  80120b:	8b 85 9c fe ff ff    	mov    -0x164(%ebp),%eax
  801211:	89 c1                	mov    %eax,%ecx
  801213:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  801216:	89 d0                	mov    %edx,%eax
  801218:	01 c0                	add    %eax,%eax
  80121a:	01 d0                	add    %edx,%eax
  80121c:	c1 e0 02             	shl    $0x2,%eax
  80121f:	01 d0                	add    %edx,%eax
  801221:	89 c2                	mov    %eax,%edx
  801223:	8b 45 d0             	mov    -0x30(%ebp),%eax
  801226:	c1 e0 04             	shl    $0x4,%eax
  801229:	01 d0                	add    %edx,%eax
  80122b:	05 00 00 00 80       	add    $0x80000000,%eax
  801230:	39 c1                	cmp    %eax,%ecx
  801232:	72 29                	jb     80125d <_main+0x1225>
  801234:	8b 85 9c fe ff ff    	mov    -0x164(%ebp),%eax
  80123a:	89 c1                	mov    %eax,%ecx
  80123c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80123f:	89 d0                	mov    %edx,%eax
  801241:	01 c0                	add    %eax,%eax
  801243:	01 d0                	add    %edx,%eax
  801245:	c1 e0 02             	shl    $0x2,%eax
  801248:	01 d0                	add    %edx,%eax
  80124a:	89 c2                	mov    %eax,%edx
  80124c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80124f:	c1 e0 04             	shl    $0x4,%eax
  801252:	01 d0                	add    %edx,%eax
  801254:	2d 00 f0 ff 7f       	sub    $0x7ffff000,%eax
  801259:	39 c1                	cmp    %eax,%ecx
  80125b:	76 17                	jbe    801274 <_main+0x123c>
  80125d:	83 ec 04             	sub    $0x4,%esp
  801260:	68 7c 31 80 00       	push   $0x80317c
  801265:	68 0e 01 00 00       	push   $0x10e
  80126a:	68 21 31 80 00       	push   $0x803121
  80126f:	e8 c9 02 00 00       	call   80153d <_panic>
		if ((sys_pf_calculate_allocated_pages() - usedDiskPages) != 4) panic("Extra or less pages are allocated in PageFile");
  801274:	e8 80 17 00 00       	call   8029f9 <sys_pf_calculate_allocated_pages>
  801279:	2b 45 90             	sub    -0x70(%ebp),%eax
  80127c:	83 f8 04             	cmp    $0x4,%eax
  80127f:	74 17                	je     801298 <_main+0x1260>
  801281:	83 ec 04             	sub    $0x4,%esp
  801284:	68 e4 31 80 00       	push   $0x8031e4
  801289:	68 0f 01 00 00       	push   $0x10f
  80128e:	68 21 31 80 00       	push   $0x803121
  801293:	e8 a5 02 00 00       	call   80153d <_panic>

		freeFrames = sys_calculate_free_frames() ;
  801298:	e8 d9 16 00 00       	call   802976 <sys_calculate_free_frames>
  80129d:	89 45 8c             	mov    %eax,-0x74(%ebp)
		shortArr2 = (short *) ptr_allocations[7];
  8012a0:	8b 85 9c fe ff ff    	mov    -0x164(%ebp),%eax
  8012a6:	89 85 10 ff ff ff    	mov    %eax,-0xf0(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
  8012ac:	8b 55 d0             	mov    -0x30(%ebp),%edx
  8012af:	89 d0                	mov    %edx,%eax
  8012b1:	01 c0                	add    %eax,%eax
  8012b3:	01 d0                	add    %edx,%eax
  8012b5:	01 c0                	add    %eax,%eax
  8012b7:	01 d0                	add    %edx,%eax
  8012b9:	01 c0                	add    %eax,%eax
  8012bb:	d1 e8                	shr    %eax
  8012bd:	48                   	dec    %eax
  8012be:	89 85 0c ff ff ff    	mov    %eax,-0xf4(%ebp)
		shortArr2[0] = minShort;
  8012c4:	8b 95 10 ff ff ff    	mov    -0xf0(%ebp),%edx
  8012ca:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8012cd:	66 89 02             	mov    %ax,(%edx)
		shortArr2[lastIndexOfShort2] = maxShort;
  8012d0:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
  8012d6:	01 c0                	add    %eax,%eax
  8012d8:	89 c2                	mov    %eax,%edx
  8012da:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
  8012e0:	01 c2                	add    %eax,%edx
  8012e2:	66 8b 45 ca          	mov    -0x36(%ebp),%ax
  8012e6:	66 89 02             	mov    %ax,(%edx)
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
  8012e9:	8b 5d 8c             	mov    -0x74(%ebp),%ebx
  8012ec:	e8 85 16 00 00       	call   802976 <sys_calculate_free_frames>
  8012f1:	29 c3                	sub    %eax,%ebx
  8012f3:	89 d8                	mov    %ebx,%eax
  8012f5:	83 f8 02             	cmp    $0x2,%eax
  8012f8:	74 17                	je     801311 <_main+0x12d9>
  8012fa:	83 ec 04             	sub    $0x4,%esp
  8012fd:	68 14 32 80 00       	push   $0x803214
  801302:	68 16 01 00 00       	push   $0x116
  801307:	68 21 31 80 00       	push   $0x803121
  80130c:	e8 2c 02 00 00       	call   80153d <_panic>
		found = 0;
  801311:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  801318:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  80131f:	e9 9b 00 00 00       	jmp    8013bf <_main+0x1387>
		{
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
  801324:	a1 20 40 80 00       	mov    0x804020,%eax
  801329:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80132f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801332:	c1 e2 04             	shl    $0x4,%edx
  801335:	01 d0                	add    %edx,%eax
  801337:	8b 00                	mov    (%eax),%eax
  801339:	89 85 08 ff ff ff    	mov    %eax,-0xf8(%ebp)
  80133f:	8b 85 08 ff ff ff    	mov    -0xf8(%ebp),%eax
  801345:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80134a:	89 c2                	mov    %eax,%edx
  80134c:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
  801352:	89 85 04 ff ff ff    	mov    %eax,-0xfc(%ebp)
  801358:	8b 85 04 ff ff ff    	mov    -0xfc(%ebp),%eax
  80135e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801363:	39 c2                	cmp    %eax,%edx
  801365:	75 03                	jne    80136a <_main+0x1332>
				found++;
  801367:	ff 45 d8             	incl   -0x28(%ebp)
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
  80136a:	a1 20 40 80 00       	mov    0x804020,%eax
  80136f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801375:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801378:	c1 e2 04             	shl    $0x4,%edx
  80137b:	01 d0                	add    %edx,%eax
  80137d:	8b 00                	mov    (%eax),%eax
  80137f:	89 85 00 ff ff ff    	mov    %eax,-0x100(%ebp)
  801385:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
  80138b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801390:	89 c2                	mov    %eax,%edx
  801392:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
  801398:	01 c0                	add    %eax,%eax
  80139a:	89 c1                	mov    %eax,%ecx
  80139c:	8b 85 10 ff ff ff    	mov    -0xf0(%ebp),%eax
  8013a2:	01 c8                	add    %ecx,%eax
  8013a4:	89 85 fc fe ff ff    	mov    %eax,-0x104(%ebp)
  8013aa:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
  8013b0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8013b5:	39 c2                	cmp    %eax,%edx
  8013b7:	75 03                	jne    8013bc <_main+0x1384>
				found++;
  8013b9:	ff 45 d8             	incl   -0x28(%ebp)
		lastIndexOfShort2 = (14*kilo)/sizeof(short) - 1;
		shortArr2[0] = minShort;
		shortArr2[lastIndexOfShort2] = maxShort;
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: pages are not loaded successfully into memory/WS");
		found = 0;
		for (var = 0; var < (myEnv->page_WS_max_size); ++var)
  8013bc:	ff 45 e4             	incl   -0x1c(%ebp)
  8013bf:	a1 20 40 80 00       	mov    0x804020,%eax
  8013c4:	8b 50 74             	mov    0x74(%eax),%edx
  8013c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8013ca:	39 c2                	cmp    %eax,%edx
  8013cc:	0f 87 52 ff ff ff    	ja     801324 <_main+0x12ec>
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[0])), PAGE_SIZE))
				found++;
			if(ROUNDDOWN(myEnv->__uptr_pws[var].virtual_address,PAGE_SIZE) == ROUNDDOWN((uint32)(&(shortArr2[lastIndexOfShort2])), PAGE_SIZE))
				found++;
		}
		if (found != 2) panic("malloc: page is not added to WS");
  8013d2:	83 7d d8 02          	cmpl   $0x2,-0x28(%ebp)
  8013d6:	74 17                	je     8013ef <_main+0x13b7>
  8013d8:	83 ec 04             	sub    $0x4,%esp
  8013db:	68 58 32 80 00       	push   $0x803258
  8013e0:	68 1f 01 00 00       	push   $0x11f
  8013e5:	68 21 31 80 00       	push   $0x803121
  8013ea:	e8 4e 01 00 00       	call   80153d <_panic>
		if(start_freeFrames != (sys_calculate_free_frames() + 4)) {panic("Wrong free: not all pages removed correctly at end");}
	}

	cprintf("Congratulations!! test free [1] completed successfully.\n");
*/
	return;
  8013ef:	90                   	nop
}
  8013f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8013f3:	5b                   	pop    %ebx
  8013f4:	5e                   	pop    %esi
  8013f5:	5f                   	pop    %edi
  8013f6:	5d                   	pop    %ebp
  8013f7:	c3                   	ret    

008013f8 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8013f8:	55                   	push   %ebp
  8013f9:	89 e5                	mov    %esp,%ebp
  8013fb:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8013fe:	e8 a8 14 00 00       	call   8028ab <sys_getenvindex>
  801403:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  801406:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801409:	89 d0                	mov    %edx,%eax
  80140b:	c1 e0 03             	shl    $0x3,%eax
  80140e:	01 d0                	add    %edx,%eax
  801410:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  801417:	01 c8                	add    %ecx,%eax
  801419:	01 c0                	add    %eax,%eax
  80141b:	01 d0                	add    %edx,%eax
  80141d:	01 c0                	add    %eax,%eax
  80141f:	01 d0                	add    %edx,%eax
  801421:	89 c2                	mov    %eax,%edx
  801423:	c1 e2 05             	shl    $0x5,%edx
  801426:	29 c2                	sub    %eax,%edx
  801428:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80142f:	89 c2                	mov    %eax,%edx
  801431:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  801437:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80143c:	a1 20 40 80 00       	mov    0x804020,%eax
  801441:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  801447:	84 c0                	test   %al,%al
  801449:	74 0f                	je     80145a <libmain+0x62>
		binaryname = myEnv->prog_name;
  80144b:	a1 20 40 80 00       	mov    0x804020,%eax
  801450:	05 40 3c 01 00       	add    $0x13c40,%eax
  801455:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80145a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80145e:	7e 0a                	jle    80146a <libmain+0x72>
		binaryname = argv[0];
  801460:	8b 45 0c             	mov    0xc(%ebp),%eax
  801463:	8b 00                	mov    (%eax),%eax
  801465:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  80146a:	83 ec 08             	sub    $0x8,%esp
  80146d:	ff 75 0c             	pushl  0xc(%ebp)
  801470:	ff 75 08             	pushl  0x8(%ebp)
  801473:	e8 c0 eb ff ff       	call   800038 <_main>
  801478:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80147b:	e8 c6 15 00 00       	call   802a46 <sys_disable_interrupt>
	cprintf("**************************************\n");
  801480:	83 ec 0c             	sub    $0xc,%esp
  801483:	68 7c 33 80 00       	push   $0x80337c
  801488:	e8 52 03 00 00       	call   8017df <cprintf>
  80148d:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  801490:	a1 20 40 80 00       	mov    0x804020,%eax
  801495:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80149b:	a1 20 40 80 00       	mov    0x804020,%eax
  8014a0:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8014a6:	83 ec 04             	sub    $0x4,%esp
  8014a9:	52                   	push   %edx
  8014aa:	50                   	push   %eax
  8014ab:	68 a4 33 80 00       	push   $0x8033a4
  8014b0:	e8 2a 03 00 00       	call   8017df <cprintf>
  8014b5:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8014b8:	a1 20 40 80 00       	mov    0x804020,%eax
  8014bd:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8014c3:	a1 20 40 80 00       	mov    0x804020,%eax
  8014c8:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8014ce:	83 ec 04             	sub    $0x4,%esp
  8014d1:	52                   	push   %edx
  8014d2:	50                   	push   %eax
  8014d3:	68 cc 33 80 00       	push   $0x8033cc
  8014d8:	e8 02 03 00 00       	call   8017df <cprintf>
  8014dd:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8014e0:	a1 20 40 80 00       	mov    0x804020,%eax
  8014e5:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8014eb:	83 ec 08             	sub    $0x8,%esp
  8014ee:	50                   	push   %eax
  8014ef:	68 0d 34 80 00       	push   $0x80340d
  8014f4:	e8 e6 02 00 00       	call   8017df <cprintf>
  8014f9:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8014fc:	83 ec 0c             	sub    $0xc,%esp
  8014ff:	68 7c 33 80 00       	push   $0x80337c
  801504:	e8 d6 02 00 00       	call   8017df <cprintf>
  801509:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80150c:	e8 4f 15 00 00       	call   802a60 <sys_enable_interrupt>

	// exit gracefully
	exit();
  801511:	e8 19 00 00 00       	call   80152f <exit>
}
  801516:	90                   	nop
  801517:	c9                   	leave  
  801518:	c3                   	ret    

00801519 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  801519:	55                   	push   %ebp
  80151a:	89 e5                	mov    %esp,%ebp
  80151c:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80151f:	83 ec 0c             	sub    $0xc,%esp
  801522:	6a 00                	push   $0x0
  801524:	e8 4e 13 00 00       	call   802877 <sys_env_destroy>
  801529:	83 c4 10             	add    $0x10,%esp
}
  80152c:	90                   	nop
  80152d:	c9                   	leave  
  80152e:	c3                   	ret    

0080152f <exit>:

void
exit(void)
{
  80152f:	55                   	push   %ebp
  801530:	89 e5                	mov    %esp,%ebp
  801532:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  801535:	e8 a3 13 00 00       	call   8028dd <sys_env_exit>
}
  80153a:	90                   	nop
  80153b:	c9                   	leave  
  80153c:	c3                   	ret    

0080153d <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80153d:	55                   	push   %ebp
  80153e:	89 e5                	mov    %esp,%ebp
  801540:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801543:	8d 45 10             	lea    0x10(%ebp),%eax
  801546:	83 c0 04             	add    $0x4,%eax
  801549:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80154c:	a1 18 41 80 00       	mov    0x804118,%eax
  801551:	85 c0                	test   %eax,%eax
  801553:	74 16                	je     80156b <_panic+0x2e>
		cprintf("%s: ", argv0);
  801555:	a1 18 41 80 00       	mov    0x804118,%eax
  80155a:	83 ec 08             	sub    $0x8,%esp
  80155d:	50                   	push   %eax
  80155e:	68 24 34 80 00       	push   $0x803424
  801563:	e8 77 02 00 00       	call   8017df <cprintf>
  801568:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80156b:	a1 00 40 80 00       	mov    0x804000,%eax
  801570:	ff 75 0c             	pushl  0xc(%ebp)
  801573:	ff 75 08             	pushl  0x8(%ebp)
  801576:	50                   	push   %eax
  801577:	68 29 34 80 00       	push   $0x803429
  80157c:	e8 5e 02 00 00       	call   8017df <cprintf>
  801581:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801584:	8b 45 10             	mov    0x10(%ebp),%eax
  801587:	83 ec 08             	sub    $0x8,%esp
  80158a:	ff 75 f4             	pushl  -0xc(%ebp)
  80158d:	50                   	push   %eax
  80158e:	e8 e1 01 00 00       	call   801774 <vcprintf>
  801593:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801596:	83 ec 08             	sub    $0x8,%esp
  801599:	6a 00                	push   $0x0
  80159b:	68 45 34 80 00       	push   $0x803445
  8015a0:	e8 cf 01 00 00       	call   801774 <vcprintf>
  8015a5:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8015a8:	e8 82 ff ff ff       	call   80152f <exit>

	// should not return here
	while (1) ;
  8015ad:	eb fe                	jmp    8015ad <_panic+0x70>

008015af <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8015af:	55                   	push   %ebp
  8015b0:	89 e5                	mov    %esp,%ebp
  8015b2:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8015b5:	a1 20 40 80 00       	mov    0x804020,%eax
  8015ba:	8b 50 74             	mov    0x74(%eax),%edx
  8015bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015c0:	39 c2                	cmp    %eax,%edx
  8015c2:	74 14                	je     8015d8 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8015c4:	83 ec 04             	sub    $0x4,%esp
  8015c7:	68 48 34 80 00       	push   $0x803448
  8015cc:	6a 26                	push   $0x26
  8015ce:	68 94 34 80 00       	push   $0x803494
  8015d3:	e8 65 ff ff ff       	call   80153d <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8015d8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8015df:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8015e6:	e9 b6 00 00 00       	jmp    8016a1 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8015eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015ee:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f8:	01 d0                	add    %edx,%eax
  8015fa:	8b 00                	mov    (%eax),%eax
  8015fc:	85 c0                	test   %eax,%eax
  8015fe:	75 08                	jne    801608 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801600:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801603:	e9 96 00 00 00       	jmp    80169e <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  801608:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80160f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801616:	eb 5d                	jmp    801675 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801618:	a1 20 40 80 00       	mov    0x804020,%eax
  80161d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801623:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801626:	c1 e2 04             	shl    $0x4,%edx
  801629:	01 d0                	add    %edx,%eax
  80162b:	8a 40 04             	mov    0x4(%eax),%al
  80162e:	84 c0                	test   %al,%al
  801630:	75 40                	jne    801672 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801632:	a1 20 40 80 00       	mov    0x804020,%eax
  801637:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80163d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801640:	c1 e2 04             	shl    $0x4,%edx
  801643:	01 d0                	add    %edx,%eax
  801645:	8b 00                	mov    (%eax),%eax
  801647:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80164a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80164d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801652:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801654:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801657:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80165e:	8b 45 08             	mov    0x8(%ebp),%eax
  801661:	01 c8                	add    %ecx,%eax
  801663:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801665:	39 c2                	cmp    %eax,%edx
  801667:	75 09                	jne    801672 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  801669:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801670:	eb 12                	jmp    801684 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801672:	ff 45 e8             	incl   -0x18(%ebp)
  801675:	a1 20 40 80 00       	mov    0x804020,%eax
  80167a:	8b 50 74             	mov    0x74(%eax),%edx
  80167d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801680:	39 c2                	cmp    %eax,%edx
  801682:	77 94                	ja     801618 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801684:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801688:	75 14                	jne    80169e <CheckWSWithoutLastIndex+0xef>
			panic(
  80168a:	83 ec 04             	sub    $0x4,%esp
  80168d:	68 a0 34 80 00       	push   $0x8034a0
  801692:	6a 3a                	push   $0x3a
  801694:	68 94 34 80 00       	push   $0x803494
  801699:	e8 9f fe ff ff       	call   80153d <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80169e:	ff 45 f0             	incl   -0x10(%ebp)
  8016a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016a4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8016a7:	0f 8c 3e ff ff ff    	jl     8015eb <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8016ad:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8016b4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8016bb:	eb 20                	jmp    8016dd <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8016bd:	a1 20 40 80 00       	mov    0x804020,%eax
  8016c2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8016c8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8016cb:	c1 e2 04             	shl    $0x4,%edx
  8016ce:	01 d0                	add    %edx,%eax
  8016d0:	8a 40 04             	mov    0x4(%eax),%al
  8016d3:	3c 01                	cmp    $0x1,%al
  8016d5:	75 03                	jne    8016da <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8016d7:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8016da:	ff 45 e0             	incl   -0x20(%ebp)
  8016dd:	a1 20 40 80 00       	mov    0x804020,%eax
  8016e2:	8b 50 74             	mov    0x74(%eax),%edx
  8016e5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8016e8:	39 c2                	cmp    %eax,%edx
  8016ea:	77 d1                	ja     8016bd <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8016ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016ef:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8016f2:	74 14                	je     801708 <CheckWSWithoutLastIndex+0x159>
		panic(
  8016f4:	83 ec 04             	sub    $0x4,%esp
  8016f7:	68 f4 34 80 00       	push   $0x8034f4
  8016fc:	6a 44                	push   $0x44
  8016fe:	68 94 34 80 00       	push   $0x803494
  801703:	e8 35 fe ff ff       	call   80153d <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801708:	90                   	nop
  801709:	c9                   	leave  
  80170a:	c3                   	ret    

0080170b <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80170b:	55                   	push   %ebp
  80170c:	89 e5                	mov    %esp,%ebp
  80170e:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  801711:	8b 45 0c             	mov    0xc(%ebp),%eax
  801714:	8b 00                	mov    (%eax),%eax
  801716:	8d 48 01             	lea    0x1(%eax),%ecx
  801719:	8b 55 0c             	mov    0xc(%ebp),%edx
  80171c:	89 0a                	mov    %ecx,(%edx)
  80171e:	8b 55 08             	mov    0x8(%ebp),%edx
  801721:	88 d1                	mov    %dl,%cl
  801723:	8b 55 0c             	mov    0xc(%ebp),%edx
  801726:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80172a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80172d:	8b 00                	mov    (%eax),%eax
  80172f:	3d ff 00 00 00       	cmp    $0xff,%eax
  801734:	75 2c                	jne    801762 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  801736:	a0 24 40 80 00       	mov    0x804024,%al
  80173b:	0f b6 c0             	movzbl %al,%eax
  80173e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801741:	8b 12                	mov    (%edx),%edx
  801743:	89 d1                	mov    %edx,%ecx
  801745:	8b 55 0c             	mov    0xc(%ebp),%edx
  801748:	83 c2 08             	add    $0x8,%edx
  80174b:	83 ec 04             	sub    $0x4,%esp
  80174e:	50                   	push   %eax
  80174f:	51                   	push   %ecx
  801750:	52                   	push   %edx
  801751:	e8 df 10 00 00       	call   802835 <sys_cputs>
  801756:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  801759:	8b 45 0c             	mov    0xc(%ebp),%eax
  80175c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  801762:	8b 45 0c             	mov    0xc(%ebp),%eax
  801765:	8b 40 04             	mov    0x4(%eax),%eax
  801768:	8d 50 01             	lea    0x1(%eax),%edx
  80176b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80176e:	89 50 04             	mov    %edx,0x4(%eax)
}
  801771:	90                   	nop
  801772:	c9                   	leave  
  801773:	c3                   	ret    

00801774 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  801774:	55                   	push   %ebp
  801775:	89 e5                	mov    %esp,%ebp
  801777:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80177d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  801784:	00 00 00 
	b.cnt = 0;
  801787:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80178e:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  801791:	ff 75 0c             	pushl  0xc(%ebp)
  801794:	ff 75 08             	pushl  0x8(%ebp)
  801797:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80179d:	50                   	push   %eax
  80179e:	68 0b 17 80 00       	push   $0x80170b
  8017a3:	e8 11 02 00 00       	call   8019b9 <vprintfmt>
  8017a8:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8017ab:	a0 24 40 80 00       	mov    0x804024,%al
  8017b0:	0f b6 c0             	movzbl %al,%eax
  8017b3:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8017b9:	83 ec 04             	sub    $0x4,%esp
  8017bc:	50                   	push   %eax
  8017bd:	52                   	push   %edx
  8017be:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8017c4:	83 c0 08             	add    $0x8,%eax
  8017c7:	50                   	push   %eax
  8017c8:	e8 68 10 00 00       	call   802835 <sys_cputs>
  8017cd:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8017d0:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  8017d7:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8017dd:	c9                   	leave  
  8017de:	c3                   	ret    

008017df <cprintf>:

int cprintf(const char *fmt, ...) {
  8017df:	55                   	push   %ebp
  8017e0:	89 e5                	mov    %esp,%ebp
  8017e2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8017e5:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  8017ec:	8d 45 0c             	lea    0xc(%ebp),%eax
  8017ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8017f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f5:	83 ec 08             	sub    $0x8,%esp
  8017f8:	ff 75 f4             	pushl  -0xc(%ebp)
  8017fb:	50                   	push   %eax
  8017fc:	e8 73 ff ff ff       	call   801774 <vcprintf>
  801801:	83 c4 10             	add    $0x10,%esp
  801804:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  801807:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80180a:	c9                   	leave  
  80180b:	c3                   	ret    

0080180c <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80180c:	55                   	push   %ebp
  80180d:	89 e5                	mov    %esp,%ebp
  80180f:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801812:	e8 2f 12 00 00       	call   802a46 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  801817:	8d 45 0c             	lea    0xc(%ebp),%eax
  80181a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80181d:	8b 45 08             	mov    0x8(%ebp),%eax
  801820:	83 ec 08             	sub    $0x8,%esp
  801823:	ff 75 f4             	pushl  -0xc(%ebp)
  801826:	50                   	push   %eax
  801827:	e8 48 ff ff ff       	call   801774 <vcprintf>
  80182c:	83 c4 10             	add    $0x10,%esp
  80182f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801832:	e8 29 12 00 00       	call   802a60 <sys_enable_interrupt>
	return cnt;
  801837:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80183a:	c9                   	leave  
  80183b:	c3                   	ret    

0080183c <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80183c:	55                   	push   %ebp
  80183d:	89 e5                	mov    %esp,%ebp
  80183f:	53                   	push   %ebx
  801840:	83 ec 14             	sub    $0x14,%esp
  801843:	8b 45 10             	mov    0x10(%ebp),%eax
  801846:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801849:	8b 45 14             	mov    0x14(%ebp),%eax
  80184c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80184f:	8b 45 18             	mov    0x18(%ebp),%eax
  801852:	ba 00 00 00 00       	mov    $0x0,%edx
  801857:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80185a:	77 55                	ja     8018b1 <printnum+0x75>
  80185c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80185f:	72 05                	jb     801866 <printnum+0x2a>
  801861:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801864:	77 4b                	ja     8018b1 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  801866:	8b 45 1c             	mov    0x1c(%ebp),%eax
  801869:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80186c:	8b 45 18             	mov    0x18(%ebp),%eax
  80186f:	ba 00 00 00 00       	mov    $0x0,%edx
  801874:	52                   	push   %edx
  801875:	50                   	push   %eax
  801876:	ff 75 f4             	pushl  -0xc(%ebp)
  801879:	ff 75 f0             	pushl  -0x10(%ebp)
  80187c:	e8 e7 15 00 00       	call   802e68 <__udivdi3>
  801881:	83 c4 10             	add    $0x10,%esp
  801884:	83 ec 04             	sub    $0x4,%esp
  801887:	ff 75 20             	pushl  0x20(%ebp)
  80188a:	53                   	push   %ebx
  80188b:	ff 75 18             	pushl  0x18(%ebp)
  80188e:	52                   	push   %edx
  80188f:	50                   	push   %eax
  801890:	ff 75 0c             	pushl  0xc(%ebp)
  801893:	ff 75 08             	pushl  0x8(%ebp)
  801896:	e8 a1 ff ff ff       	call   80183c <printnum>
  80189b:	83 c4 20             	add    $0x20,%esp
  80189e:	eb 1a                	jmp    8018ba <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8018a0:	83 ec 08             	sub    $0x8,%esp
  8018a3:	ff 75 0c             	pushl  0xc(%ebp)
  8018a6:	ff 75 20             	pushl  0x20(%ebp)
  8018a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ac:	ff d0                	call   *%eax
  8018ae:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8018b1:	ff 4d 1c             	decl   0x1c(%ebp)
  8018b4:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8018b8:	7f e6                	jg     8018a0 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8018ba:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8018bd:	bb 00 00 00 00       	mov    $0x0,%ebx
  8018c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8018c8:	53                   	push   %ebx
  8018c9:	51                   	push   %ecx
  8018ca:	52                   	push   %edx
  8018cb:	50                   	push   %eax
  8018cc:	e8 a7 16 00 00       	call   802f78 <__umoddi3>
  8018d1:	83 c4 10             	add    $0x10,%esp
  8018d4:	05 54 37 80 00       	add    $0x803754,%eax
  8018d9:	8a 00                	mov    (%eax),%al
  8018db:	0f be c0             	movsbl %al,%eax
  8018de:	83 ec 08             	sub    $0x8,%esp
  8018e1:	ff 75 0c             	pushl  0xc(%ebp)
  8018e4:	50                   	push   %eax
  8018e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e8:	ff d0                	call   *%eax
  8018ea:	83 c4 10             	add    $0x10,%esp
}
  8018ed:	90                   	nop
  8018ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8018f1:	c9                   	leave  
  8018f2:	c3                   	ret    

008018f3 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8018f3:	55                   	push   %ebp
  8018f4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8018f6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8018fa:	7e 1c                	jle    801918 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8018fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ff:	8b 00                	mov    (%eax),%eax
  801901:	8d 50 08             	lea    0x8(%eax),%edx
  801904:	8b 45 08             	mov    0x8(%ebp),%eax
  801907:	89 10                	mov    %edx,(%eax)
  801909:	8b 45 08             	mov    0x8(%ebp),%eax
  80190c:	8b 00                	mov    (%eax),%eax
  80190e:	83 e8 08             	sub    $0x8,%eax
  801911:	8b 50 04             	mov    0x4(%eax),%edx
  801914:	8b 00                	mov    (%eax),%eax
  801916:	eb 40                	jmp    801958 <getuint+0x65>
	else if (lflag)
  801918:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80191c:	74 1e                	je     80193c <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80191e:	8b 45 08             	mov    0x8(%ebp),%eax
  801921:	8b 00                	mov    (%eax),%eax
  801923:	8d 50 04             	lea    0x4(%eax),%edx
  801926:	8b 45 08             	mov    0x8(%ebp),%eax
  801929:	89 10                	mov    %edx,(%eax)
  80192b:	8b 45 08             	mov    0x8(%ebp),%eax
  80192e:	8b 00                	mov    (%eax),%eax
  801930:	83 e8 04             	sub    $0x4,%eax
  801933:	8b 00                	mov    (%eax),%eax
  801935:	ba 00 00 00 00       	mov    $0x0,%edx
  80193a:	eb 1c                	jmp    801958 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80193c:	8b 45 08             	mov    0x8(%ebp),%eax
  80193f:	8b 00                	mov    (%eax),%eax
  801941:	8d 50 04             	lea    0x4(%eax),%edx
  801944:	8b 45 08             	mov    0x8(%ebp),%eax
  801947:	89 10                	mov    %edx,(%eax)
  801949:	8b 45 08             	mov    0x8(%ebp),%eax
  80194c:	8b 00                	mov    (%eax),%eax
  80194e:	83 e8 04             	sub    $0x4,%eax
  801951:	8b 00                	mov    (%eax),%eax
  801953:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801958:	5d                   	pop    %ebp
  801959:	c3                   	ret    

0080195a <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80195a:	55                   	push   %ebp
  80195b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80195d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801961:	7e 1c                	jle    80197f <getint+0x25>
		return va_arg(*ap, long long);
  801963:	8b 45 08             	mov    0x8(%ebp),%eax
  801966:	8b 00                	mov    (%eax),%eax
  801968:	8d 50 08             	lea    0x8(%eax),%edx
  80196b:	8b 45 08             	mov    0x8(%ebp),%eax
  80196e:	89 10                	mov    %edx,(%eax)
  801970:	8b 45 08             	mov    0x8(%ebp),%eax
  801973:	8b 00                	mov    (%eax),%eax
  801975:	83 e8 08             	sub    $0x8,%eax
  801978:	8b 50 04             	mov    0x4(%eax),%edx
  80197b:	8b 00                	mov    (%eax),%eax
  80197d:	eb 38                	jmp    8019b7 <getint+0x5d>
	else if (lflag)
  80197f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801983:	74 1a                	je     80199f <getint+0x45>
		return va_arg(*ap, long);
  801985:	8b 45 08             	mov    0x8(%ebp),%eax
  801988:	8b 00                	mov    (%eax),%eax
  80198a:	8d 50 04             	lea    0x4(%eax),%edx
  80198d:	8b 45 08             	mov    0x8(%ebp),%eax
  801990:	89 10                	mov    %edx,(%eax)
  801992:	8b 45 08             	mov    0x8(%ebp),%eax
  801995:	8b 00                	mov    (%eax),%eax
  801997:	83 e8 04             	sub    $0x4,%eax
  80199a:	8b 00                	mov    (%eax),%eax
  80199c:	99                   	cltd   
  80199d:	eb 18                	jmp    8019b7 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80199f:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a2:	8b 00                	mov    (%eax),%eax
  8019a4:	8d 50 04             	lea    0x4(%eax),%edx
  8019a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019aa:	89 10                	mov    %edx,(%eax)
  8019ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8019af:	8b 00                	mov    (%eax),%eax
  8019b1:	83 e8 04             	sub    $0x4,%eax
  8019b4:	8b 00                	mov    (%eax),%eax
  8019b6:	99                   	cltd   
}
  8019b7:	5d                   	pop    %ebp
  8019b8:	c3                   	ret    

008019b9 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8019b9:	55                   	push   %ebp
  8019ba:	89 e5                	mov    %esp,%ebp
  8019bc:	56                   	push   %esi
  8019bd:	53                   	push   %ebx
  8019be:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8019c1:	eb 17                	jmp    8019da <vprintfmt+0x21>
			if (ch == '\0')
  8019c3:	85 db                	test   %ebx,%ebx
  8019c5:	0f 84 af 03 00 00    	je     801d7a <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8019cb:	83 ec 08             	sub    $0x8,%esp
  8019ce:	ff 75 0c             	pushl  0xc(%ebp)
  8019d1:	53                   	push   %ebx
  8019d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d5:	ff d0                	call   *%eax
  8019d7:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8019da:	8b 45 10             	mov    0x10(%ebp),%eax
  8019dd:	8d 50 01             	lea    0x1(%eax),%edx
  8019e0:	89 55 10             	mov    %edx,0x10(%ebp)
  8019e3:	8a 00                	mov    (%eax),%al
  8019e5:	0f b6 d8             	movzbl %al,%ebx
  8019e8:	83 fb 25             	cmp    $0x25,%ebx
  8019eb:	75 d6                	jne    8019c3 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8019ed:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8019f1:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8019f8:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8019ff:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  801a06:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  801a0d:	8b 45 10             	mov    0x10(%ebp),%eax
  801a10:	8d 50 01             	lea    0x1(%eax),%edx
  801a13:	89 55 10             	mov    %edx,0x10(%ebp)
  801a16:	8a 00                	mov    (%eax),%al
  801a18:	0f b6 d8             	movzbl %al,%ebx
  801a1b:	8d 43 dd             	lea    -0x23(%ebx),%eax
  801a1e:	83 f8 55             	cmp    $0x55,%eax
  801a21:	0f 87 2b 03 00 00    	ja     801d52 <vprintfmt+0x399>
  801a27:	8b 04 85 78 37 80 00 	mov    0x803778(,%eax,4),%eax
  801a2e:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801a30:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801a34:	eb d7                	jmp    801a0d <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801a36:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801a3a:	eb d1                	jmp    801a0d <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801a3c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801a43:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801a46:	89 d0                	mov    %edx,%eax
  801a48:	c1 e0 02             	shl    $0x2,%eax
  801a4b:	01 d0                	add    %edx,%eax
  801a4d:	01 c0                	add    %eax,%eax
  801a4f:	01 d8                	add    %ebx,%eax
  801a51:	83 e8 30             	sub    $0x30,%eax
  801a54:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801a57:	8b 45 10             	mov    0x10(%ebp),%eax
  801a5a:	8a 00                	mov    (%eax),%al
  801a5c:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801a5f:	83 fb 2f             	cmp    $0x2f,%ebx
  801a62:	7e 3e                	jle    801aa2 <vprintfmt+0xe9>
  801a64:	83 fb 39             	cmp    $0x39,%ebx
  801a67:	7f 39                	jg     801aa2 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801a69:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801a6c:	eb d5                	jmp    801a43 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801a6e:	8b 45 14             	mov    0x14(%ebp),%eax
  801a71:	83 c0 04             	add    $0x4,%eax
  801a74:	89 45 14             	mov    %eax,0x14(%ebp)
  801a77:	8b 45 14             	mov    0x14(%ebp),%eax
  801a7a:	83 e8 04             	sub    $0x4,%eax
  801a7d:	8b 00                	mov    (%eax),%eax
  801a7f:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801a82:	eb 1f                	jmp    801aa3 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801a84:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801a88:	79 83                	jns    801a0d <vprintfmt+0x54>
				width = 0;
  801a8a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801a91:	e9 77 ff ff ff       	jmp    801a0d <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801a96:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801a9d:	e9 6b ff ff ff       	jmp    801a0d <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801aa2:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801aa3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801aa7:	0f 89 60 ff ff ff    	jns    801a0d <vprintfmt+0x54>
				width = precision, precision = -1;
  801aad:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ab0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801ab3:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  801aba:	e9 4e ff ff ff       	jmp    801a0d <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801abf:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801ac2:	e9 46 ff ff ff       	jmp    801a0d <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801ac7:	8b 45 14             	mov    0x14(%ebp),%eax
  801aca:	83 c0 04             	add    $0x4,%eax
  801acd:	89 45 14             	mov    %eax,0x14(%ebp)
  801ad0:	8b 45 14             	mov    0x14(%ebp),%eax
  801ad3:	83 e8 04             	sub    $0x4,%eax
  801ad6:	8b 00                	mov    (%eax),%eax
  801ad8:	83 ec 08             	sub    $0x8,%esp
  801adb:	ff 75 0c             	pushl  0xc(%ebp)
  801ade:	50                   	push   %eax
  801adf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae2:	ff d0                	call   *%eax
  801ae4:	83 c4 10             	add    $0x10,%esp
			break;
  801ae7:	e9 89 02 00 00       	jmp    801d75 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  801aec:	8b 45 14             	mov    0x14(%ebp),%eax
  801aef:	83 c0 04             	add    $0x4,%eax
  801af2:	89 45 14             	mov    %eax,0x14(%ebp)
  801af5:	8b 45 14             	mov    0x14(%ebp),%eax
  801af8:	83 e8 04             	sub    $0x4,%eax
  801afb:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  801afd:	85 db                	test   %ebx,%ebx
  801aff:	79 02                	jns    801b03 <vprintfmt+0x14a>
				err = -err;
  801b01:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  801b03:	83 fb 64             	cmp    $0x64,%ebx
  801b06:	7f 0b                	jg     801b13 <vprintfmt+0x15a>
  801b08:	8b 34 9d c0 35 80 00 	mov    0x8035c0(,%ebx,4),%esi
  801b0f:	85 f6                	test   %esi,%esi
  801b11:	75 19                	jne    801b2c <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  801b13:	53                   	push   %ebx
  801b14:	68 65 37 80 00       	push   $0x803765
  801b19:	ff 75 0c             	pushl  0xc(%ebp)
  801b1c:	ff 75 08             	pushl  0x8(%ebp)
  801b1f:	e8 5e 02 00 00       	call   801d82 <printfmt>
  801b24:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801b27:	e9 49 02 00 00       	jmp    801d75 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801b2c:	56                   	push   %esi
  801b2d:	68 6e 37 80 00       	push   $0x80376e
  801b32:	ff 75 0c             	pushl  0xc(%ebp)
  801b35:	ff 75 08             	pushl  0x8(%ebp)
  801b38:	e8 45 02 00 00       	call   801d82 <printfmt>
  801b3d:	83 c4 10             	add    $0x10,%esp
			break;
  801b40:	e9 30 02 00 00       	jmp    801d75 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801b45:	8b 45 14             	mov    0x14(%ebp),%eax
  801b48:	83 c0 04             	add    $0x4,%eax
  801b4b:	89 45 14             	mov    %eax,0x14(%ebp)
  801b4e:	8b 45 14             	mov    0x14(%ebp),%eax
  801b51:	83 e8 04             	sub    $0x4,%eax
  801b54:	8b 30                	mov    (%eax),%esi
  801b56:	85 f6                	test   %esi,%esi
  801b58:	75 05                	jne    801b5f <vprintfmt+0x1a6>
				p = "(null)";
  801b5a:	be 71 37 80 00       	mov    $0x803771,%esi
			if (width > 0 && padc != '-')
  801b5f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801b63:	7e 6d                	jle    801bd2 <vprintfmt+0x219>
  801b65:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801b69:	74 67                	je     801bd2 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801b6b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b6e:	83 ec 08             	sub    $0x8,%esp
  801b71:	50                   	push   %eax
  801b72:	56                   	push   %esi
  801b73:	e8 0c 03 00 00       	call   801e84 <strnlen>
  801b78:	83 c4 10             	add    $0x10,%esp
  801b7b:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801b7e:	eb 16                	jmp    801b96 <vprintfmt+0x1dd>
					putch(padc, putdat);
  801b80:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801b84:	83 ec 08             	sub    $0x8,%esp
  801b87:	ff 75 0c             	pushl  0xc(%ebp)
  801b8a:	50                   	push   %eax
  801b8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8e:	ff d0                	call   *%eax
  801b90:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801b93:	ff 4d e4             	decl   -0x1c(%ebp)
  801b96:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801b9a:	7f e4                	jg     801b80 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801b9c:	eb 34                	jmp    801bd2 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801b9e:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801ba2:	74 1c                	je     801bc0 <vprintfmt+0x207>
  801ba4:	83 fb 1f             	cmp    $0x1f,%ebx
  801ba7:	7e 05                	jle    801bae <vprintfmt+0x1f5>
  801ba9:	83 fb 7e             	cmp    $0x7e,%ebx
  801bac:	7e 12                	jle    801bc0 <vprintfmt+0x207>
					putch('?', putdat);
  801bae:	83 ec 08             	sub    $0x8,%esp
  801bb1:	ff 75 0c             	pushl  0xc(%ebp)
  801bb4:	6a 3f                	push   $0x3f
  801bb6:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb9:	ff d0                	call   *%eax
  801bbb:	83 c4 10             	add    $0x10,%esp
  801bbe:	eb 0f                	jmp    801bcf <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801bc0:	83 ec 08             	sub    $0x8,%esp
  801bc3:	ff 75 0c             	pushl  0xc(%ebp)
  801bc6:	53                   	push   %ebx
  801bc7:	8b 45 08             	mov    0x8(%ebp),%eax
  801bca:	ff d0                	call   *%eax
  801bcc:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801bcf:	ff 4d e4             	decl   -0x1c(%ebp)
  801bd2:	89 f0                	mov    %esi,%eax
  801bd4:	8d 70 01             	lea    0x1(%eax),%esi
  801bd7:	8a 00                	mov    (%eax),%al
  801bd9:	0f be d8             	movsbl %al,%ebx
  801bdc:	85 db                	test   %ebx,%ebx
  801bde:	74 24                	je     801c04 <vprintfmt+0x24b>
  801be0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801be4:	78 b8                	js     801b9e <vprintfmt+0x1e5>
  801be6:	ff 4d e0             	decl   -0x20(%ebp)
  801be9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801bed:	79 af                	jns    801b9e <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801bef:	eb 13                	jmp    801c04 <vprintfmt+0x24b>
				putch(' ', putdat);
  801bf1:	83 ec 08             	sub    $0x8,%esp
  801bf4:	ff 75 0c             	pushl  0xc(%ebp)
  801bf7:	6a 20                	push   $0x20
  801bf9:	8b 45 08             	mov    0x8(%ebp),%eax
  801bfc:	ff d0                	call   *%eax
  801bfe:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801c01:	ff 4d e4             	decl   -0x1c(%ebp)
  801c04:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801c08:	7f e7                	jg     801bf1 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801c0a:	e9 66 01 00 00       	jmp    801d75 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801c0f:	83 ec 08             	sub    $0x8,%esp
  801c12:	ff 75 e8             	pushl  -0x18(%ebp)
  801c15:	8d 45 14             	lea    0x14(%ebp),%eax
  801c18:	50                   	push   %eax
  801c19:	e8 3c fd ff ff       	call   80195a <getint>
  801c1e:	83 c4 10             	add    $0x10,%esp
  801c21:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c24:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801c27:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c2a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c2d:	85 d2                	test   %edx,%edx
  801c2f:	79 23                	jns    801c54 <vprintfmt+0x29b>
				putch('-', putdat);
  801c31:	83 ec 08             	sub    $0x8,%esp
  801c34:	ff 75 0c             	pushl  0xc(%ebp)
  801c37:	6a 2d                	push   $0x2d
  801c39:	8b 45 08             	mov    0x8(%ebp),%eax
  801c3c:	ff d0                	call   *%eax
  801c3e:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801c41:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801c44:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801c47:	f7 d8                	neg    %eax
  801c49:	83 d2 00             	adc    $0x0,%edx
  801c4c:	f7 da                	neg    %edx
  801c4e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c51:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801c54:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801c5b:	e9 bc 00 00 00       	jmp    801d1c <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801c60:	83 ec 08             	sub    $0x8,%esp
  801c63:	ff 75 e8             	pushl  -0x18(%ebp)
  801c66:	8d 45 14             	lea    0x14(%ebp),%eax
  801c69:	50                   	push   %eax
  801c6a:	e8 84 fc ff ff       	call   8018f3 <getuint>
  801c6f:	83 c4 10             	add    $0x10,%esp
  801c72:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801c75:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801c78:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801c7f:	e9 98 00 00 00       	jmp    801d1c <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801c84:	83 ec 08             	sub    $0x8,%esp
  801c87:	ff 75 0c             	pushl  0xc(%ebp)
  801c8a:	6a 58                	push   $0x58
  801c8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c8f:	ff d0                	call   *%eax
  801c91:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801c94:	83 ec 08             	sub    $0x8,%esp
  801c97:	ff 75 0c             	pushl  0xc(%ebp)
  801c9a:	6a 58                	push   $0x58
  801c9c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c9f:	ff d0                	call   *%eax
  801ca1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801ca4:	83 ec 08             	sub    $0x8,%esp
  801ca7:	ff 75 0c             	pushl  0xc(%ebp)
  801caa:	6a 58                	push   $0x58
  801cac:	8b 45 08             	mov    0x8(%ebp),%eax
  801caf:	ff d0                	call   *%eax
  801cb1:	83 c4 10             	add    $0x10,%esp
			break;
  801cb4:	e9 bc 00 00 00       	jmp    801d75 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801cb9:	83 ec 08             	sub    $0x8,%esp
  801cbc:	ff 75 0c             	pushl  0xc(%ebp)
  801cbf:	6a 30                	push   $0x30
  801cc1:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc4:	ff d0                	call   *%eax
  801cc6:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801cc9:	83 ec 08             	sub    $0x8,%esp
  801ccc:	ff 75 0c             	pushl  0xc(%ebp)
  801ccf:	6a 78                	push   $0x78
  801cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd4:	ff d0                	call   *%eax
  801cd6:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801cd9:	8b 45 14             	mov    0x14(%ebp),%eax
  801cdc:	83 c0 04             	add    $0x4,%eax
  801cdf:	89 45 14             	mov    %eax,0x14(%ebp)
  801ce2:	8b 45 14             	mov    0x14(%ebp),%eax
  801ce5:	83 e8 04             	sub    $0x4,%eax
  801ce8:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801cea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801ced:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  801cf4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801cfb:	eb 1f                	jmp    801d1c <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801cfd:	83 ec 08             	sub    $0x8,%esp
  801d00:	ff 75 e8             	pushl  -0x18(%ebp)
  801d03:	8d 45 14             	lea    0x14(%ebp),%eax
  801d06:	50                   	push   %eax
  801d07:	e8 e7 fb ff ff       	call   8018f3 <getuint>
  801d0c:	83 c4 10             	add    $0x10,%esp
  801d0f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801d12:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801d15:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801d1c:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801d20:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d23:	83 ec 04             	sub    $0x4,%esp
  801d26:	52                   	push   %edx
  801d27:	ff 75 e4             	pushl  -0x1c(%ebp)
  801d2a:	50                   	push   %eax
  801d2b:	ff 75 f4             	pushl  -0xc(%ebp)
  801d2e:	ff 75 f0             	pushl  -0x10(%ebp)
  801d31:	ff 75 0c             	pushl  0xc(%ebp)
  801d34:	ff 75 08             	pushl  0x8(%ebp)
  801d37:	e8 00 fb ff ff       	call   80183c <printnum>
  801d3c:	83 c4 20             	add    $0x20,%esp
			break;
  801d3f:	eb 34                	jmp    801d75 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801d41:	83 ec 08             	sub    $0x8,%esp
  801d44:	ff 75 0c             	pushl  0xc(%ebp)
  801d47:	53                   	push   %ebx
  801d48:	8b 45 08             	mov    0x8(%ebp),%eax
  801d4b:	ff d0                	call   *%eax
  801d4d:	83 c4 10             	add    $0x10,%esp
			break;
  801d50:	eb 23                	jmp    801d75 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801d52:	83 ec 08             	sub    $0x8,%esp
  801d55:	ff 75 0c             	pushl  0xc(%ebp)
  801d58:	6a 25                	push   $0x25
  801d5a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d5d:	ff d0                	call   *%eax
  801d5f:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801d62:	ff 4d 10             	decl   0x10(%ebp)
  801d65:	eb 03                	jmp    801d6a <vprintfmt+0x3b1>
  801d67:	ff 4d 10             	decl   0x10(%ebp)
  801d6a:	8b 45 10             	mov    0x10(%ebp),%eax
  801d6d:	48                   	dec    %eax
  801d6e:	8a 00                	mov    (%eax),%al
  801d70:	3c 25                	cmp    $0x25,%al
  801d72:	75 f3                	jne    801d67 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801d74:	90                   	nop
		}
	}
  801d75:	e9 47 fc ff ff       	jmp    8019c1 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801d7a:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801d7b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d7e:	5b                   	pop    %ebx
  801d7f:	5e                   	pop    %esi
  801d80:	5d                   	pop    %ebp
  801d81:	c3                   	ret    

00801d82 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801d82:	55                   	push   %ebp
  801d83:	89 e5                	mov    %esp,%ebp
  801d85:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801d88:	8d 45 10             	lea    0x10(%ebp),%eax
  801d8b:	83 c0 04             	add    $0x4,%eax
  801d8e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801d91:	8b 45 10             	mov    0x10(%ebp),%eax
  801d94:	ff 75 f4             	pushl  -0xc(%ebp)
  801d97:	50                   	push   %eax
  801d98:	ff 75 0c             	pushl  0xc(%ebp)
  801d9b:	ff 75 08             	pushl  0x8(%ebp)
  801d9e:	e8 16 fc ff ff       	call   8019b9 <vprintfmt>
  801da3:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801da6:	90                   	nop
  801da7:	c9                   	leave  
  801da8:	c3                   	ret    

00801da9 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801da9:	55                   	push   %ebp
  801daa:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801dac:	8b 45 0c             	mov    0xc(%ebp),%eax
  801daf:	8b 40 08             	mov    0x8(%eax),%eax
  801db2:	8d 50 01             	lea    0x1(%eax),%edx
  801db5:	8b 45 0c             	mov    0xc(%ebp),%eax
  801db8:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801dbb:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dbe:	8b 10                	mov    (%eax),%edx
  801dc0:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dc3:	8b 40 04             	mov    0x4(%eax),%eax
  801dc6:	39 c2                	cmp    %eax,%edx
  801dc8:	73 12                	jae    801ddc <sprintputch+0x33>
		*b->buf++ = ch;
  801dca:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dcd:	8b 00                	mov    (%eax),%eax
  801dcf:	8d 48 01             	lea    0x1(%eax),%ecx
  801dd2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dd5:	89 0a                	mov    %ecx,(%edx)
  801dd7:	8b 55 08             	mov    0x8(%ebp),%edx
  801dda:	88 10                	mov    %dl,(%eax)
}
  801ddc:	90                   	nop
  801ddd:	5d                   	pop    %ebp
  801dde:	c3                   	ret    

00801ddf <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801ddf:	55                   	push   %ebp
  801de0:	89 e5                	mov    %esp,%ebp
  801de2:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801de5:	8b 45 08             	mov    0x8(%ebp),%eax
  801de8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801deb:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dee:	8d 50 ff             	lea    -0x1(%eax),%edx
  801df1:	8b 45 08             	mov    0x8(%ebp),%eax
  801df4:	01 d0                	add    %edx,%eax
  801df6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801df9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801e00:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801e04:	74 06                	je     801e0c <vsnprintf+0x2d>
  801e06:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801e0a:	7f 07                	jg     801e13 <vsnprintf+0x34>
		return -E_INVAL;
  801e0c:	b8 03 00 00 00       	mov    $0x3,%eax
  801e11:	eb 20                	jmp    801e33 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801e13:	ff 75 14             	pushl  0x14(%ebp)
  801e16:	ff 75 10             	pushl  0x10(%ebp)
  801e19:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801e1c:	50                   	push   %eax
  801e1d:	68 a9 1d 80 00       	push   $0x801da9
  801e22:	e8 92 fb ff ff       	call   8019b9 <vprintfmt>
  801e27:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801e2a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801e2d:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801e30:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801e33:	c9                   	leave  
  801e34:	c3                   	ret    

00801e35 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801e35:	55                   	push   %ebp
  801e36:	89 e5                	mov    %esp,%ebp
  801e38:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801e3b:	8d 45 10             	lea    0x10(%ebp),%eax
  801e3e:	83 c0 04             	add    $0x4,%eax
  801e41:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801e44:	8b 45 10             	mov    0x10(%ebp),%eax
  801e47:	ff 75 f4             	pushl  -0xc(%ebp)
  801e4a:	50                   	push   %eax
  801e4b:	ff 75 0c             	pushl  0xc(%ebp)
  801e4e:	ff 75 08             	pushl  0x8(%ebp)
  801e51:	e8 89 ff ff ff       	call   801ddf <vsnprintf>
  801e56:	83 c4 10             	add    $0x10,%esp
  801e59:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801e5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801e5f:	c9                   	leave  
  801e60:	c3                   	ret    

00801e61 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801e61:	55                   	push   %ebp
  801e62:	89 e5                	mov    %esp,%ebp
  801e64:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801e67:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801e6e:	eb 06                	jmp    801e76 <strlen+0x15>
		n++;
  801e70:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801e73:	ff 45 08             	incl   0x8(%ebp)
  801e76:	8b 45 08             	mov    0x8(%ebp),%eax
  801e79:	8a 00                	mov    (%eax),%al
  801e7b:	84 c0                	test   %al,%al
  801e7d:	75 f1                	jne    801e70 <strlen+0xf>
		n++;
	return n;
  801e7f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801e82:	c9                   	leave  
  801e83:	c3                   	ret    

00801e84 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801e84:	55                   	push   %ebp
  801e85:	89 e5                	mov    %esp,%ebp
  801e87:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801e8a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801e91:	eb 09                	jmp    801e9c <strnlen+0x18>
		n++;
  801e93:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801e96:	ff 45 08             	incl   0x8(%ebp)
  801e99:	ff 4d 0c             	decl   0xc(%ebp)
  801e9c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801ea0:	74 09                	je     801eab <strnlen+0x27>
  801ea2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ea5:	8a 00                	mov    (%eax),%al
  801ea7:	84 c0                	test   %al,%al
  801ea9:	75 e8                	jne    801e93 <strnlen+0xf>
		n++;
	return n;
  801eab:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801eae:	c9                   	leave  
  801eaf:	c3                   	ret    

00801eb0 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801eb0:	55                   	push   %ebp
  801eb1:	89 e5                	mov    %esp,%ebp
  801eb3:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801eb6:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801ebc:	90                   	nop
  801ebd:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec0:	8d 50 01             	lea    0x1(%eax),%edx
  801ec3:	89 55 08             	mov    %edx,0x8(%ebp)
  801ec6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ec9:	8d 4a 01             	lea    0x1(%edx),%ecx
  801ecc:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801ecf:	8a 12                	mov    (%edx),%dl
  801ed1:	88 10                	mov    %dl,(%eax)
  801ed3:	8a 00                	mov    (%eax),%al
  801ed5:	84 c0                	test   %al,%al
  801ed7:	75 e4                	jne    801ebd <strcpy+0xd>
		/* do nothing */;
	return ret;
  801ed9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801edc:	c9                   	leave  
  801edd:	c3                   	ret    

00801ede <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801ede:	55                   	push   %ebp
  801edf:	89 e5                	mov    %esp,%ebp
  801ee1:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801ee4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801eea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801ef1:	eb 1f                	jmp    801f12 <strncpy+0x34>
		*dst++ = *src;
  801ef3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef6:	8d 50 01             	lea    0x1(%eax),%edx
  801ef9:	89 55 08             	mov    %edx,0x8(%ebp)
  801efc:	8b 55 0c             	mov    0xc(%ebp),%edx
  801eff:	8a 12                	mov    (%edx),%dl
  801f01:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801f03:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f06:	8a 00                	mov    (%eax),%al
  801f08:	84 c0                	test   %al,%al
  801f0a:	74 03                	je     801f0f <strncpy+0x31>
			src++;
  801f0c:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801f0f:	ff 45 fc             	incl   -0x4(%ebp)
  801f12:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801f15:	3b 45 10             	cmp    0x10(%ebp),%eax
  801f18:	72 d9                	jb     801ef3 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801f1a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801f1d:	c9                   	leave  
  801f1e:	c3                   	ret    

00801f1f <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801f1f:	55                   	push   %ebp
  801f20:	89 e5                	mov    %esp,%ebp
  801f22:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801f25:	8b 45 08             	mov    0x8(%ebp),%eax
  801f28:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801f2b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801f2f:	74 30                	je     801f61 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801f31:	eb 16                	jmp    801f49 <strlcpy+0x2a>
			*dst++ = *src++;
  801f33:	8b 45 08             	mov    0x8(%ebp),%eax
  801f36:	8d 50 01             	lea    0x1(%eax),%edx
  801f39:	89 55 08             	mov    %edx,0x8(%ebp)
  801f3c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f3f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801f42:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801f45:	8a 12                	mov    (%edx),%dl
  801f47:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801f49:	ff 4d 10             	decl   0x10(%ebp)
  801f4c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801f50:	74 09                	je     801f5b <strlcpy+0x3c>
  801f52:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f55:	8a 00                	mov    (%eax),%al
  801f57:	84 c0                	test   %al,%al
  801f59:	75 d8                	jne    801f33 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801f5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f5e:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801f61:	8b 55 08             	mov    0x8(%ebp),%edx
  801f64:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801f67:	29 c2                	sub    %eax,%edx
  801f69:	89 d0                	mov    %edx,%eax
}
  801f6b:	c9                   	leave  
  801f6c:	c3                   	ret    

00801f6d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801f6d:	55                   	push   %ebp
  801f6e:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801f70:	eb 06                	jmp    801f78 <strcmp+0xb>
		p++, q++;
  801f72:	ff 45 08             	incl   0x8(%ebp)
  801f75:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801f78:	8b 45 08             	mov    0x8(%ebp),%eax
  801f7b:	8a 00                	mov    (%eax),%al
  801f7d:	84 c0                	test   %al,%al
  801f7f:	74 0e                	je     801f8f <strcmp+0x22>
  801f81:	8b 45 08             	mov    0x8(%ebp),%eax
  801f84:	8a 10                	mov    (%eax),%dl
  801f86:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f89:	8a 00                	mov    (%eax),%al
  801f8b:	38 c2                	cmp    %al,%dl
  801f8d:	74 e3                	je     801f72 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801f8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f92:	8a 00                	mov    (%eax),%al
  801f94:	0f b6 d0             	movzbl %al,%edx
  801f97:	8b 45 0c             	mov    0xc(%ebp),%eax
  801f9a:	8a 00                	mov    (%eax),%al
  801f9c:	0f b6 c0             	movzbl %al,%eax
  801f9f:	29 c2                	sub    %eax,%edx
  801fa1:	89 d0                	mov    %edx,%eax
}
  801fa3:	5d                   	pop    %ebp
  801fa4:	c3                   	ret    

00801fa5 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801fa5:	55                   	push   %ebp
  801fa6:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801fa8:	eb 09                	jmp    801fb3 <strncmp+0xe>
		n--, p++, q++;
  801faa:	ff 4d 10             	decl   0x10(%ebp)
  801fad:	ff 45 08             	incl   0x8(%ebp)
  801fb0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801fb3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801fb7:	74 17                	je     801fd0 <strncmp+0x2b>
  801fb9:	8b 45 08             	mov    0x8(%ebp),%eax
  801fbc:	8a 00                	mov    (%eax),%al
  801fbe:	84 c0                	test   %al,%al
  801fc0:	74 0e                	je     801fd0 <strncmp+0x2b>
  801fc2:	8b 45 08             	mov    0x8(%ebp),%eax
  801fc5:	8a 10                	mov    (%eax),%dl
  801fc7:	8b 45 0c             	mov    0xc(%ebp),%eax
  801fca:	8a 00                	mov    (%eax),%al
  801fcc:	38 c2                	cmp    %al,%dl
  801fce:	74 da                	je     801faa <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801fd0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801fd4:	75 07                	jne    801fdd <strncmp+0x38>
		return 0;
  801fd6:	b8 00 00 00 00       	mov    $0x0,%eax
  801fdb:	eb 14                	jmp    801ff1 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801fdd:	8b 45 08             	mov    0x8(%ebp),%eax
  801fe0:	8a 00                	mov    (%eax),%al
  801fe2:	0f b6 d0             	movzbl %al,%edx
  801fe5:	8b 45 0c             	mov    0xc(%ebp),%eax
  801fe8:	8a 00                	mov    (%eax),%al
  801fea:	0f b6 c0             	movzbl %al,%eax
  801fed:	29 c2                	sub    %eax,%edx
  801fef:	89 d0                	mov    %edx,%eax
}
  801ff1:	5d                   	pop    %ebp
  801ff2:	c3                   	ret    

00801ff3 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801ff3:	55                   	push   %ebp
  801ff4:	89 e5                	mov    %esp,%ebp
  801ff6:	83 ec 04             	sub    $0x4,%esp
  801ff9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ffc:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801fff:	eb 12                	jmp    802013 <strchr+0x20>
		if (*s == c)
  802001:	8b 45 08             	mov    0x8(%ebp),%eax
  802004:	8a 00                	mov    (%eax),%al
  802006:	3a 45 fc             	cmp    -0x4(%ebp),%al
  802009:	75 05                	jne    802010 <strchr+0x1d>
			return (char *) s;
  80200b:	8b 45 08             	mov    0x8(%ebp),%eax
  80200e:	eb 11                	jmp    802021 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  802010:	ff 45 08             	incl   0x8(%ebp)
  802013:	8b 45 08             	mov    0x8(%ebp),%eax
  802016:	8a 00                	mov    (%eax),%al
  802018:	84 c0                	test   %al,%al
  80201a:	75 e5                	jne    802001 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80201c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802021:	c9                   	leave  
  802022:	c3                   	ret    

00802023 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  802023:	55                   	push   %ebp
  802024:	89 e5                	mov    %esp,%ebp
  802026:	83 ec 04             	sub    $0x4,%esp
  802029:	8b 45 0c             	mov    0xc(%ebp),%eax
  80202c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80202f:	eb 0d                	jmp    80203e <strfind+0x1b>
		if (*s == c)
  802031:	8b 45 08             	mov    0x8(%ebp),%eax
  802034:	8a 00                	mov    (%eax),%al
  802036:	3a 45 fc             	cmp    -0x4(%ebp),%al
  802039:	74 0e                	je     802049 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80203b:	ff 45 08             	incl   0x8(%ebp)
  80203e:	8b 45 08             	mov    0x8(%ebp),%eax
  802041:	8a 00                	mov    (%eax),%al
  802043:	84 c0                	test   %al,%al
  802045:	75 ea                	jne    802031 <strfind+0xe>
  802047:	eb 01                	jmp    80204a <strfind+0x27>
		if (*s == c)
			break;
  802049:	90                   	nop
	return (char *) s;
  80204a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80204d:	c9                   	leave  
  80204e:	c3                   	ret    

0080204f <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80204f:	55                   	push   %ebp
  802050:	89 e5                	mov    %esp,%ebp
  802052:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  802055:	8b 45 08             	mov    0x8(%ebp),%eax
  802058:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80205b:	8b 45 10             	mov    0x10(%ebp),%eax
  80205e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  802061:	eb 0e                	jmp    802071 <memset+0x22>
		*p++ = c;
  802063:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802066:	8d 50 01             	lea    0x1(%eax),%edx
  802069:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80206c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80206f:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  802071:	ff 4d f8             	decl   -0x8(%ebp)
  802074:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  802078:	79 e9                	jns    802063 <memset+0x14>
		*p++ = c;

	return v;
  80207a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80207d:	c9                   	leave  
  80207e:	c3                   	ret    

0080207f <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80207f:	55                   	push   %ebp
  802080:	89 e5                	mov    %esp,%ebp
  802082:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  802085:	8b 45 0c             	mov    0xc(%ebp),%eax
  802088:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80208b:	8b 45 08             	mov    0x8(%ebp),%eax
  80208e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  802091:	eb 16                	jmp    8020a9 <memcpy+0x2a>
		*d++ = *s++;
  802093:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802096:	8d 50 01             	lea    0x1(%eax),%edx
  802099:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80209c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80209f:	8d 4a 01             	lea    0x1(%edx),%ecx
  8020a2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8020a5:	8a 12                	mov    (%edx),%dl
  8020a7:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8020a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8020ac:	8d 50 ff             	lea    -0x1(%eax),%edx
  8020af:	89 55 10             	mov    %edx,0x10(%ebp)
  8020b2:	85 c0                	test   %eax,%eax
  8020b4:	75 dd                	jne    802093 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8020b6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8020b9:	c9                   	leave  
  8020ba:	c3                   	ret    

008020bb <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8020bb:	55                   	push   %ebp
  8020bc:	89 e5                	mov    %esp,%ebp
  8020be:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8020c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8020c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8020c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ca:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8020cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8020d0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8020d3:	73 50                	jae    802125 <memmove+0x6a>
  8020d5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8020d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8020db:	01 d0                	add    %edx,%eax
  8020dd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8020e0:	76 43                	jbe    802125 <memmove+0x6a>
		s += n;
  8020e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8020e5:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8020e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8020eb:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8020ee:	eb 10                	jmp    802100 <memmove+0x45>
			*--d = *--s;
  8020f0:	ff 4d f8             	decl   -0x8(%ebp)
  8020f3:	ff 4d fc             	decl   -0x4(%ebp)
  8020f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8020f9:	8a 10                	mov    (%eax),%dl
  8020fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8020fe:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  802100:	8b 45 10             	mov    0x10(%ebp),%eax
  802103:	8d 50 ff             	lea    -0x1(%eax),%edx
  802106:	89 55 10             	mov    %edx,0x10(%ebp)
  802109:	85 c0                	test   %eax,%eax
  80210b:	75 e3                	jne    8020f0 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80210d:	eb 23                	jmp    802132 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80210f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802112:	8d 50 01             	lea    0x1(%eax),%edx
  802115:	89 55 f8             	mov    %edx,-0x8(%ebp)
  802118:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80211b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80211e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  802121:	8a 12                	mov    (%edx),%dl
  802123:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  802125:	8b 45 10             	mov    0x10(%ebp),%eax
  802128:	8d 50 ff             	lea    -0x1(%eax),%edx
  80212b:	89 55 10             	mov    %edx,0x10(%ebp)
  80212e:	85 c0                	test   %eax,%eax
  802130:	75 dd                	jne    80210f <memmove+0x54>
			*d++ = *s++;

	return dst;
  802132:	8b 45 08             	mov    0x8(%ebp),%eax
}
  802135:	c9                   	leave  
  802136:	c3                   	ret    

00802137 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  802137:	55                   	push   %ebp
  802138:	89 e5                	mov    %esp,%ebp
  80213a:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80213d:	8b 45 08             	mov    0x8(%ebp),%eax
  802140:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  802143:	8b 45 0c             	mov    0xc(%ebp),%eax
  802146:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  802149:	eb 2a                	jmp    802175 <memcmp+0x3e>
		if (*s1 != *s2)
  80214b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80214e:	8a 10                	mov    (%eax),%dl
  802150:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802153:	8a 00                	mov    (%eax),%al
  802155:	38 c2                	cmp    %al,%dl
  802157:	74 16                	je     80216f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  802159:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80215c:	8a 00                	mov    (%eax),%al
  80215e:	0f b6 d0             	movzbl %al,%edx
  802161:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802164:	8a 00                	mov    (%eax),%al
  802166:	0f b6 c0             	movzbl %al,%eax
  802169:	29 c2                	sub    %eax,%edx
  80216b:	89 d0                	mov    %edx,%eax
  80216d:	eb 18                	jmp    802187 <memcmp+0x50>
		s1++, s2++;
  80216f:	ff 45 fc             	incl   -0x4(%ebp)
  802172:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  802175:	8b 45 10             	mov    0x10(%ebp),%eax
  802178:	8d 50 ff             	lea    -0x1(%eax),%edx
  80217b:	89 55 10             	mov    %edx,0x10(%ebp)
  80217e:	85 c0                	test   %eax,%eax
  802180:	75 c9                	jne    80214b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  802182:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802187:	c9                   	leave  
  802188:	c3                   	ret    

00802189 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  802189:	55                   	push   %ebp
  80218a:	89 e5                	mov    %esp,%ebp
  80218c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80218f:	8b 55 08             	mov    0x8(%ebp),%edx
  802192:	8b 45 10             	mov    0x10(%ebp),%eax
  802195:	01 d0                	add    %edx,%eax
  802197:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80219a:	eb 15                	jmp    8021b1 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80219c:	8b 45 08             	mov    0x8(%ebp),%eax
  80219f:	8a 00                	mov    (%eax),%al
  8021a1:	0f b6 d0             	movzbl %al,%edx
  8021a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8021a7:	0f b6 c0             	movzbl %al,%eax
  8021aa:	39 c2                	cmp    %eax,%edx
  8021ac:	74 0d                	je     8021bb <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8021ae:	ff 45 08             	incl   0x8(%ebp)
  8021b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8021b4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8021b7:	72 e3                	jb     80219c <memfind+0x13>
  8021b9:	eb 01                	jmp    8021bc <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8021bb:	90                   	nop
	return (void *) s;
  8021bc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8021bf:	c9                   	leave  
  8021c0:	c3                   	ret    

008021c1 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8021c1:	55                   	push   %ebp
  8021c2:	89 e5                	mov    %esp,%ebp
  8021c4:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8021c7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8021ce:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8021d5:	eb 03                	jmp    8021da <strtol+0x19>
		s++;
  8021d7:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8021da:	8b 45 08             	mov    0x8(%ebp),%eax
  8021dd:	8a 00                	mov    (%eax),%al
  8021df:	3c 20                	cmp    $0x20,%al
  8021e1:	74 f4                	je     8021d7 <strtol+0x16>
  8021e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8021e6:	8a 00                	mov    (%eax),%al
  8021e8:	3c 09                	cmp    $0x9,%al
  8021ea:	74 eb                	je     8021d7 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8021ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8021ef:	8a 00                	mov    (%eax),%al
  8021f1:	3c 2b                	cmp    $0x2b,%al
  8021f3:	75 05                	jne    8021fa <strtol+0x39>
		s++;
  8021f5:	ff 45 08             	incl   0x8(%ebp)
  8021f8:	eb 13                	jmp    80220d <strtol+0x4c>
	else if (*s == '-')
  8021fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8021fd:	8a 00                	mov    (%eax),%al
  8021ff:	3c 2d                	cmp    $0x2d,%al
  802201:	75 0a                	jne    80220d <strtol+0x4c>
		s++, neg = 1;
  802203:	ff 45 08             	incl   0x8(%ebp)
  802206:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80220d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802211:	74 06                	je     802219 <strtol+0x58>
  802213:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  802217:	75 20                	jne    802239 <strtol+0x78>
  802219:	8b 45 08             	mov    0x8(%ebp),%eax
  80221c:	8a 00                	mov    (%eax),%al
  80221e:	3c 30                	cmp    $0x30,%al
  802220:	75 17                	jne    802239 <strtol+0x78>
  802222:	8b 45 08             	mov    0x8(%ebp),%eax
  802225:	40                   	inc    %eax
  802226:	8a 00                	mov    (%eax),%al
  802228:	3c 78                	cmp    $0x78,%al
  80222a:	75 0d                	jne    802239 <strtol+0x78>
		s += 2, base = 16;
  80222c:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  802230:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  802237:	eb 28                	jmp    802261 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  802239:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80223d:	75 15                	jne    802254 <strtol+0x93>
  80223f:	8b 45 08             	mov    0x8(%ebp),%eax
  802242:	8a 00                	mov    (%eax),%al
  802244:	3c 30                	cmp    $0x30,%al
  802246:	75 0c                	jne    802254 <strtol+0x93>
		s++, base = 8;
  802248:	ff 45 08             	incl   0x8(%ebp)
  80224b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  802252:	eb 0d                	jmp    802261 <strtol+0xa0>
	else if (base == 0)
  802254:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  802258:	75 07                	jne    802261 <strtol+0xa0>
		base = 10;
  80225a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  802261:	8b 45 08             	mov    0x8(%ebp),%eax
  802264:	8a 00                	mov    (%eax),%al
  802266:	3c 2f                	cmp    $0x2f,%al
  802268:	7e 19                	jle    802283 <strtol+0xc2>
  80226a:	8b 45 08             	mov    0x8(%ebp),%eax
  80226d:	8a 00                	mov    (%eax),%al
  80226f:	3c 39                	cmp    $0x39,%al
  802271:	7f 10                	jg     802283 <strtol+0xc2>
			dig = *s - '0';
  802273:	8b 45 08             	mov    0x8(%ebp),%eax
  802276:	8a 00                	mov    (%eax),%al
  802278:	0f be c0             	movsbl %al,%eax
  80227b:	83 e8 30             	sub    $0x30,%eax
  80227e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  802281:	eb 42                	jmp    8022c5 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  802283:	8b 45 08             	mov    0x8(%ebp),%eax
  802286:	8a 00                	mov    (%eax),%al
  802288:	3c 60                	cmp    $0x60,%al
  80228a:	7e 19                	jle    8022a5 <strtol+0xe4>
  80228c:	8b 45 08             	mov    0x8(%ebp),%eax
  80228f:	8a 00                	mov    (%eax),%al
  802291:	3c 7a                	cmp    $0x7a,%al
  802293:	7f 10                	jg     8022a5 <strtol+0xe4>
			dig = *s - 'a' + 10;
  802295:	8b 45 08             	mov    0x8(%ebp),%eax
  802298:	8a 00                	mov    (%eax),%al
  80229a:	0f be c0             	movsbl %al,%eax
  80229d:	83 e8 57             	sub    $0x57,%eax
  8022a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8022a3:	eb 20                	jmp    8022c5 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8022a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8022a8:	8a 00                	mov    (%eax),%al
  8022aa:	3c 40                	cmp    $0x40,%al
  8022ac:	7e 39                	jle    8022e7 <strtol+0x126>
  8022ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8022b1:	8a 00                	mov    (%eax),%al
  8022b3:	3c 5a                	cmp    $0x5a,%al
  8022b5:	7f 30                	jg     8022e7 <strtol+0x126>
			dig = *s - 'A' + 10;
  8022b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ba:	8a 00                	mov    (%eax),%al
  8022bc:	0f be c0             	movsbl %al,%eax
  8022bf:	83 e8 37             	sub    $0x37,%eax
  8022c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8022c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8022c8:	3b 45 10             	cmp    0x10(%ebp),%eax
  8022cb:	7d 19                	jge    8022e6 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8022cd:	ff 45 08             	incl   0x8(%ebp)
  8022d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8022d3:	0f af 45 10          	imul   0x10(%ebp),%eax
  8022d7:	89 c2                	mov    %eax,%edx
  8022d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8022dc:	01 d0                	add    %edx,%eax
  8022de:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8022e1:	e9 7b ff ff ff       	jmp    802261 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8022e6:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8022e7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8022eb:	74 08                	je     8022f5 <strtol+0x134>
		*endptr = (char *) s;
  8022ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8022f0:	8b 55 08             	mov    0x8(%ebp),%edx
  8022f3:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8022f5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8022f9:	74 07                	je     802302 <strtol+0x141>
  8022fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8022fe:	f7 d8                	neg    %eax
  802300:	eb 03                	jmp    802305 <strtol+0x144>
  802302:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  802305:	c9                   	leave  
  802306:	c3                   	ret    

00802307 <ltostr>:

void
ltostr(long value, char *str)
{
  802307:	55                   	push   %ebp
  802308:	89 e5                	mov    %esp,%ebp
  80230a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80230d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  802314:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80231b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80231f:	79 13                	jns    802334 <ltostr+0x2d>
	{
		neg = 1;
  802321:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  802328:	8b 45 0c             	mov    0xc(%ebp),%eax
  80232b:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80232e:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  802331:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  802334:	8b 45 08             	mov    0x8(%ebp),%eax
  802337:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80233c:	99                   	cltd   
  80233d:	f7 f9                	idiv   %ecx
  80233f:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  802342:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802345:	8d 50 01             	lea    0x1(%eax),%edx
  802348:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80234b:	89 c2                	mov    %eax,%edx
  80234d:	8b 45 0c             	mov    0xc(%ebp),%eax
  802350:	01 d0                	add    %edx,%eax
  802352:	8b 55 ec             	mov    -0x14(%ebp),%edx
  802355:	83 c2 30             	add    $0x30,%edx
  802358:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80235a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80235d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  802362:	f7 e9                	imul   %ecx
  802364:	c1 fa 02             	sar    $0x2,%edx
  802367:	89 c8                	mov    %ecx,%eax
  802369:	c1 f8 1f             	sar    $0x1f,%eax
  80236c:	29 c2                	sub    %eax,%edx
  80236e:	89 d0                	mov    %edx,%eax
  802370:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  802373:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802376:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80237b:	f7 e9                	imul   %ecx
  80237d:	c1 fa 02             	sar    $0x2,%edx
  802380:	89 c8                	mov    %ecx,%eax
  802382:	c1 f8 1f             	sar    $0x1f,%eax
  802385:	29 c2                	sub    %eax,%edx
  802387:	89 d0                	mov    %edx,%eax
  802389:	c1 e0 02             	shl    $0x2,%eax
  80238c:	01 d0                	add    %edx,%eax
  80238e:	01 c0                	add    %eax,%eax
  802390:	29 c1                	sub    %eax,%ecx
  802392:	89 ca                	mov    %ecx,%edx
  802394:	85 d2                	test   %edx,%edx
  802396:	75 9c                	jne    802334 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  802398:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80239f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8023a2:	48                   	dec    %eax
  8023a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8023a6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8023aa:	74 3d                	je     8023e9 <ltostr+0xe2>
		start = 1 ;
  8023ac:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8023b3:	eb 34                	jmp    8023e9 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8023b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8023b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023bb:	01 d0                	add    %edx,%eax
  8023bd:	8a 00                	mov    (%eax),%al
  8023bf:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8023c2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8023c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023c8:	01 c2                	add    %eax,%edx
  8023ca:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8023cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023d0:	01 c8                	add    %ecx,%eax
  8023d2:	8a 00                	mov    (%eax),%al
  8023d4:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8023d6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8023d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023dc:	01 c2                	add    %eax,%edx
  8023de:	8a 45 eb             	mov    -0x15(%ebp),%al
  8023e1:	88 02                	mov    %al,(%edx)
		start++ ;
  8023e3:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8023e6:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8023e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8023ec:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8023ef:	7c c4                	jl     8023b5 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8023f1:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8023f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8023f7:	01 d0                	add    %edx,%eax
  8023f9:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8023fc:	90                   	nop
  8023fd:	c9                   	leave  
  8023fe:	c3                   	ret    

008023ff <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8023ff:	55                   	push   %ebp
  802400:	89 e5                	mov    %esp,%ebp
  802402:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  802405:	ff 75 08             	pushl  0x8(%ebp)
  802408:	e8 54 fa ff ff       	call   801e61 <strlen>
  80240d:	83 c4 04             	add    $0x4,%esp
  802410:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  802413:	ff 75 0c             	pushl  0xc(%ebp)
  802416:	e8 46 fa ff ff       	call   801e61 <strlen>
  80241b:	83 c4 04             	add    $0x4,%esp
  80241e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  802421:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  802428:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80242f:	eb 17                	jmp    802448 <strcconcat+0x49>
		final[s] = str1[s] ;
  802431:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802434:	8b 45 10             	mov    0x10(%ebp),%eax
  802437:	01 c2                	add    %eax,%edx
  802439:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80243c:	8b 45 08             	mov    0x8(%ebp),%eax
  80243f:	01 c8                	add    %ecx,%eax
  802441:	8a 00                	mov    (%eax),%al
  802443:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  802445:	ff 45 fc             	incl   -0x4(%ebp)
  802448:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80244b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80244e:	7c e1                	jl     802431 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  802450:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  802457:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80245e:	eb 1f                	jmp    80247f <strcconcat+0x80>
		final[s++] = str2[i] ;
  802460:	8b 45 fc             	mov    -0x4(%ebp),%eax
  802463:	8d 50 01             	lea    0x1(%eax),%edx
  802466:	89 55 fc             	mov    %edx,-0x4(%ebp)
  802469:	89 c2                	mov    %eax,%edx
  80246b:	8b 45 10             	mov    0x10(%ebp),%eax
  80246e:	01 c2                	add    %eax,%edx
  802470:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  802473:	8b 45 0c             	mov    0xc(%ebp),%eax
  802476:	01 c8                	add    %ecx,%eax
  802478:	8a 00                	mov    (%eax),%al
  80247a:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80247c:	ff 45 f8             	incl   -0x8(%ebp)
  80247f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802482:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  802485:	7c d9                	jl     802460 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  802487:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80248a:	8b 45 10             	mov    0x10(%ebp),%eax
  80248d:	01 d0                	add    %edx,%eax
  80248f:	c6 00 00             	movb   $0x0,(%eax)
}
  802492:	90                   	nop
  802493:	c9                   	leave  
  802494:	c3                   	ret    

00802495 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  802495:	55                   	push   %ebp
  802496:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  802498:	8b 45 14             	mov    0x14(%ebp),%eax
  80249b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8024a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8024a4:	8b 00                	mov    (%eax),%eax
  8024a6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8024ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8024b0:	01 d0                	add    %edx,%eax
  8024b2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8024b8:	eb 0c                	jmp    8024c6 <strsplit+0x31>
			*string++ = 0;
  8024ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8024bd:	8d 50 01             	lea    0x1(%eax),%edx
  8024c0:	89 55 08             	mov    %edx,0x8(%ebp)
  8024c3:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8024c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8024c9:	8a 00                	mov    (%eax),%al
  8024cb:	84 c0                	test   %al,%al
  8024cd:	74 18                	je     8024e7 <strsplit+0x52>
  8024cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8024d2:	8a 00                	mov    (%eax),%al
  8024d4:	0f be c0             	movsbl %al,%eax
  8024d7:	50                   	push   %eax
  8024d8:	ff 75 0c             	pushl  0xc(%ebp)
  8024db:	e8 13 fb ff ff       	call   801ff3 <strchr>
  8024e0:	83 c4 08             	add    $0x8,%esp
  8024e3:	85 c0                	test   %eax,%eax
  8024e5:	75 d3                	jne    8024ba <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8024e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8024ea:	8a 00                	mov    (%eax),%al
  8024ec:	84 c0                	test   %al,%al
  8024ee:	74 5a                	je     80254a <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8024f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8024f3:	8b 00                	mov    (%eax),%eax
  8024f5:	83 f8 0f             	cmp    $0xf,%eax
  8024f8:	75 07                	jne    802501 <strsplit+0x6c>
		{
			return 0;
  8024fa:	b8 00 00 00 00       	mov    $0x0,%eax
  8024ff:	eb 66                	jmp    802567 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  802501:	8b 45 14             	mov    0x14(%ebp),%eax
  802504:	8b 00                	mov    (%eax),%eax
  802506:	8d 48 01             	lea    0x1(%eax),%ecx
  802509:	8b 55 14             	mov    0x14(%ebp),%edx
  80250c:	89 0a                	mov    %ecx,(%edx)
  80250e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802515:	8b 45 10             	mov    0x10(%ebp),%eax
  802518:	01 c2                	add    %eax,%edx
  80251a:	8b 45 08             	mov    0x8(%ebp),%eax
  80251d:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80251f:	eb 03                	jmp    802524 <strsplit+0x8f>
			string++;
  802521:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  802524:	8b 45 08             	mov    0x8(%ebp),%eax
  802527:	8a 00                	mov    (%eax),%al
  802529:	84 c0                	test   %al,%al
  80252b:	74 8b                	je     8024b8 <strsplit+0x23>
  80252d:	8b 45 08             	mov    0x8(%ebp),%eax
  802530:	8a 00                	mov    (%eax),%al
  802532:	0f be c0             	movsbl %al,%eax
  802535:	50                   	push   %eax
  802536:	ff 75 0c             	pushl  0xc(%ebp)
  802539:	e8 b5 fa ff ff       	call   801ff3 <strchr>
  80253e:	83 c4 08             	add    $0x8,%esp
  802541:	85 c0                	test   %eax,%eax
  802543:	74 dc                	je     802521 <strsplit+0x8c>
			string++;
	}
  802545:	e9 6e ff ff ff       	jmp    8024b8 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80254a:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80254b:	8b 45 14             	mov    0x14(%ebp),%eax
  80254e:	8b 00                	mov    (%eax),%eax
  802550:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  802557:	8b 45 10             	mov    0x10(%ebp),%eax
  80255a:	01 d0                	add    %edx,%eax
  80255c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  802562:	b8 01 00 00 00       	mov    $0x1,%eax
}
  802567:	c9                   	leave  
  802568:	c3                   	ret    

00802569 <malloc>:
int changes=0;
int sizeofarray=0;
uint32 addresses[100];
int changed[100];
void* malloc(uint32 size)
{
  802569:	55                   	push   %ebp
  80256a:	89 e5                	mov    %esp,%ebp
  80256c:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  80256f:	8b 45 08             	mov    0x8(%ebp),%eax
  802572:	c1 e8 0c             	shr    $0xc,%eax
  802575:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;
		if(size%PAGE_SIZE!=0)
  802578:	8b 45 08             	mov    0x8(%ebp),%eax
  80257b:	25 ff 0f 00 00       	and    $0xfff,%eax
  802580:	85 c0                	test   %eax,%eax
  802582:	74 03                	je     802587 <malloc+0x1e>
			num++;
  802584:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  802587:	a1 04 40 80 00       	mov    0x804004,%eax
  80258c:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  802591:	75 64                	jne    8025f7 <malloc+0x8e>
		{
			sys_allocateMem(USER_HEAP_START,size);
  802593:	83 ec 08             	sub    $0x8,%esp
  802596:	ff 75 08             	pushl  0x8(%ebp)
  802599:	68 00 00 00 80       	push   $0x80000000
  80259e:	e8 3a 04 00 00       	call   8029dd <sys_allocateMem>
  8025a3:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  8025a6:	a1 04 40 80 00       	mov    0x804004,%eax
  8025ab:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  8025ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8025b1:	c1 e0 0c             	shl    $0xc,%eax
  8025b4:	89 c2                	mov    %eax,%edx
  8025b6:	a1 04 40 80 00       	mov    0x804004,%eax
  8025bb:	01 d0                	add    %edx,%eax
  8025bd:	a3 04 40 80 00       	mov    %eax,0x804004
			addresses[sizeofarray]=last_addres;
  8025c2:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8025c7:	8b 15 04 40 80 00    	mov    0x804004,%edx
  8025cd:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
			changed[sizeofarray]=1;
  8025d4:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8025d9:	c7 04 85 c0 42 80 00 	movl   $0x1,0x8042c0(,%eax,4)
  8025e0:	01 00 00 00 
			sizeofarray++;
  8025e4:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8025e9:	40                   	inc    %eax
  8025ea:	a3 2c 40 80 00       	mov    %eax,0x80402c
			return (void*)return_addres;
  8025ef:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8025f2:	e9 26 01 00 00       	jmp    80271d <malloc+0x1b4>
		}
		else
		{
			if(changes==0)
  8025f7:	a1 28 40 80 00       	mov    0x804028,%eax
  8025fc:	85 c0                	test   %eax,%eax
  8025fe:	75 62                	jne    802662 <malloc+0xf9>
			{
				sys_allocateMem(last_addres,size);
  802600:	a1 04 40 80 00       	mov    0x804004,%eax
  802605:	83 ec 08             	sub    $0x8,%esp
  802608:	ff 75 08             	pushl  0x8(%ebp)
  80260b:	50                   	push   %eax
  80260c:	e8 cc 03 00 00       	call   8029dd <sys_allocateMem>
  802611:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  802614:	a1 04 40 80 00       	mov    0x804004,%eax
  802619:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  80261c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80261f:	c1 e0 0c             	shl    $0xc,%eax
  802622:	89 c2                	mov    %eax,%edx
  802624:	a1 04 40 80 00       	mov    0x804004,%eax
  802629:	01 d0                	add    %edx,%eax
  80262b:	a3 04 40 80 00       	mov    %eax,0x804004
				addresses[sizeofarray]=return_addres;
  802630:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802635:	8b 55 d8             	mov    -0x28(%ebp),%edx
  802638:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				changed[sizeofarray]=1;
  80263f:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802644:	c7 04 85 c0 42 80 00 	movl   $0x1,0x8042c0(,%eax,4)
  80264b:	01 00 00 00 
				sizeofarray++;
  80264f:	a1 2c 40 80 00       	mov    0x80402c,%eax
  802654:	40                   	inc    %eax
  802655:	a3 2c 40 80 00       	mov    %eax,0x80402c
				return (void*)return_addres;
  80265a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80265d:	e9 bb 00 00 00       	jmp    80271d <malloc+0x1b4>
			}
			else{
				int count=0;
  802662:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  802669:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  802670:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  802677:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  80267e:	eb 7c                	jmp    8026fc <malloc+0x193>
				{
					uint32 *pg=NULL;
  802680:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  802687:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  80268e:	eb 1a                	jmp    8026aa <malloc+0x141>
					{
						if(addresses[j]==i)
  802690:	8b 45 dc             	mov    -0x24(%ebp),%eax
  802693:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  80269a:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80269d:	75 08                	jne    8026a7 <malloc+0x13e>
						{
							index=j;
  80269f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8026a2:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  8026a5:	eb 0d                	jmp    8026b4 <malloc+0x14b>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  8026a7:	ff 45 dc             	incl   -0x24(%ebp)
  8026aa:	a1 2c 40 80 00       	mov    0x80402c,%eax
  8026af:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  8026b2:	7c dc                	jl     802690 <malloc+0x127>
							index=j;
							break;
						}
					}

					if(index==-1)
  8026b4:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  8026b8:	75 05                	jne    8026bf <malloc+0x156>
					{
						count++;
  8026ba:	ff 45 f0             	incl   -0x10(%ebp)
  8026bd:	eb 36                	jmp    8026f5 <malloc+0x18c>
					}
					else
					{
						if(changed[index]==0)
  8026bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8026c2:	8b 04 85 c0 42 80 00 	mov    0x8042c0(,%eax,4),%eax
  8026c9:	85 c0                	test   %eax,%eax
  8026cb:	75 05                	jne    8026d2 <malloc+0x169>
						{
							count++;
  8026cd:	ff 45 f0             	incl   -0x10(%ebp)
  8026d0:	eb 23                	jmp    8026f5 <malloc+0x18c>
						}
						else
						{
							if(count<min&&count>=num)
  8026d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8026d5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  8026d8:	7d 14                	jge    8026ee <malloc+0x185>
  8026da:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8026dd:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8026e0:	7c 0c                	jl     8026ee <malloc+0x185>
							{
								min=count;
  8026e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8026e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  8026e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8026eb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  8026ee:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8026f5:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  8026fc:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  802703:	0f 86 77 ff ff ff    	jbe    802680 <malloc+0x117>

					}

					}

				sys_allocateMem(min_addresss,size);
  802709:	83 ec 08             	sub    $0x8,%esp
  80270c:	ff 75 08             	pushl  0x8(%ebp)
  80270f:	ff 75 e4             	pushl  -0x1c(%ebp)
  802712:	e8 c6 02 00 00       	call   8029dd <sys_allocateMem>
  802717:	83 c4 10             	add    $0x10,%esp

				return(void*) min_addresss;
  80271a:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  80271d:	c9                   	leave  
  80271e:	c3                   	ret    

0080271f <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  80271f:	55                   	push   %ebp
  802720:	89 e5                	mov    %esp,%ebp
  802722:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  802725:	83 ec 04             	sub    $0x4,%esp
  802728:	68 d0 38 80 00       	push   $0x8038d0
  80272d:	6a 7b                	push   $0x7b
  80272f:	68 f3 38 80 00       	push   $0x8038f3
  802734:	e8 04 ee ff ff       	call   80153d <_panic>

00802739 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  802739:	55                   	push   %ebp
  80273a:	89 e5                	mov    %esp,%ebp
  80273c:	83 ec 18             	sub    $0x18,%esp
  80273f:	8b 45 10             	mov    0x10(%ebp),%eax
  802742:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  802745:	83 ec 04             	sub    $0x4,%esp
  802748:	68 00 39 80 00       	push   $0x803900
  80274d:	68 88 00 00 00       	push   $0x88
  802752:	68 f3 38 80 00       	push   $0x8038f3
  802757:	e8 e1 ed ff ff       	call   80153d <_panic>

0080275c <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  80275c:	55                   	push   %ebp
  80275d:	89 e5                	mov    %esp,%ebp
  80275f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802762:	83 ec 04             	sub    $0x4,%esp
  802765:	68 00 39 80 00       	push   $0x803900
  80276a:	68 8e 00 00 00       	push   $0x8e
  80276f:	68 f3 38 80 00       	push   $0x8038f3
  802774:	e8 c4 ed ff ff       	call   80153d <_panic>

00802779 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  802779:	55                   	push   %ebp
  80277a:	89 e5                	mov    %esp,%ebp
  80277c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80277f:	83 ec 04             	sub    $0x4,%esp
  802782:	68 00 39 80 00       	push   $0x803900
  802787:	68 94 00 00 00       	push   $0x94
  80278c:	68 f3 38 80 00       	push   $0x8038f3
  802791:	e8 a7 ed ff ff       	call   80153d <_panic>

00802796 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  802796:	55                   	push   %ebp
  802797:	89 e5                	mov    %esp,%ebp
  802799:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80279c:	83 ec 04             	sub    $0x4,%esp
  80279f:	68 00 39 80 00       	push   $0x803900
  8027a4:	68 99 00 00 00       	push   $0x99
  8027a9:	68 f3 38 80 00       	push   $0x8038f3
  8027ae:	e8 8a ed ff ff       	call   80153d <_panic>

008027b3 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  8027b3:	55                   	push   %ebp
  8027b4:	89 e5                	mov    %esp,%ebp
  8027b6:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8027b9:	83 ec 04             	sub    $0x4,%esp
  8027bc:	68 00 39 80 00       	push   $0x803900
  8027c1:	68 9f 00 00 00       	push   $0x9f
  8027c6:	68 f3 38 80 00       	push   $0x8038f3
  8027cb:	e8 6d ed ff ff       	call   80153d <_panic>

008027d0 <shrink>:
}
void shrink(uint32 newSize)
{
  8027d0:	55                   	push   %ebp
  8027d1:	89 e5                	mov    %esp,%ebp
  8027d3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8027d6:	83 ec 04             	sub    $0x4,%esp
  8027d9:	68 00 39 80 00       	push   $0x803900
  8027de:	68 a3 00 00 00       	push   $0xa3
  8027e3:	68 f3 38 80 00       	push   $0x8038f3
  8027e8:	e8 50 ed ff ff       	call   80153d <_panic>

008027ed <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8027ed:	55                   	push   %ebp
  8027ee:	89 e5                	mov    %esp,%ebp
  8027f0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8027f3:	83 ec 04             	sub    $0x4,%esp
  8027f6:	68 00 39 80 00       	push   $0x803900
  8027fb:	68 a8 00 00 00       	push   $0xa8
  802800:	68 f3 38 80 00       	push   $0x8038f3
  802805:	e8 33 ed ff ff       	call   80153d <_panic>

0080280a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80280a:	55                   	push   %ebp
  80280b:	89 e5                	mov    %esp,%ebp
  80280d:	57                   	push   %edi
  80280e:	56                   	push   %esi
  80280f:	53                   	push   %ebx
  802810:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802813:	8b 45 08             	mov    0x8(%ebp),%eax
  802816:	8b 55 0c             	mov    0xc(%ebp),%edx
  802819:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80281c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80281f:	8b 7d 18             	mov    0x18(%ebp),%edi
  802822:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802825:	cd 30                	int    $0x30
  802827:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80282a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80282d:	83 c4 10             	add    $0x10,%esp
  802830:	5b                   	pop    %ebx
  802831:	5e                   	pop    %esi
  802832:	5f                   	pop    %edi
  802833:	5d                   	pop    %ebp
  802834:	c3                   	ret    

00802835 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802835:	55                   	push   %ebp
  802836:	89 e5                	mov    %esp,%ebp
  802838:	83 ec 04             	sub    $0x4,%esp
  80283b:	8b 45 10             	mov    0x10(%ebp),%eax
  80283e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802841:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802845:	8b 45 08             	mov    0x8(%ebp),%eax
  802848:	6a 00                	push   $0x0
  80284a:	6a 00                	push   $0x0
  80284c:	52                   	push   %edx
  80284d:	ff 75 0c             	pushl  0xc(%ebp)
  802850:	50                   	push   %eax
  802851:	6a 00                	push   $0x0
  802853:	e8 b2 ff ff ff       	call   80280a <syscall>
  802858:	83 c4 18             	add    $0x18,%esp
}
  80285b:	90                   	nop
  80285c:	c9                   	leave  
  80285d:	c3                   	ret    

0080285e <sys_cgetc>:

int
sys_cgetc(void)
{
  80285e:	55                   	push   %ebp
  80285f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802861:	6a 00                	push   $0x0
  802863:	6a 00                	push   $0x0
  802865:	6a 00                	push   $0x0
  802867:	6a 00                	push   $0x0
  802869:	6a 00                	push   $0x0
  80286b:	6a 01                	push   $0x1
  80286d:	e8 98 ff ff ff       	call   80280a <syscall>
  802872:	83 c4 18             	add    $0x18,%esp
}
  802875:	c9                   	leave  
  802876:	c3                   	ret    

00802877 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802877:	55                   	push   %ebp
  802878:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80287a:	8b 45 08             	mov    0x8(%ebp),%eax
  80287d:	6a 00                	push   $0x0
  80287f:	6a 00                	push   $0x0
  802881:	6a 00                	push   $0x0
  802883:	6a 00                	push   $0x0
  802885:	50                   	push   %eax
  802886:	6a 05                	push   $0x5
  802888:	e8 7d ff ff ff       	call   80280a <syscall>
  80288d:	83 c4 18             	add    $0x18,%esp
}
  802890:	c9                   	leave  
  802891:	c3                   	ret    

00802892 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802892:	55                   	push   %ebp
  802893:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  802895:	6a 00                	push   $0x0
  802897:	6a 00                	push   $0x0
  802899:	6a 00                	push   $0x0
  80289b:	6a 00                	push   $0x0
  80289d:	6a 00                	push   $0x0
  80289f:	6a 02                	push   $0x2
  8028a1:	e8 64 ff ff ff       	call   80280a <syscall>
  8028a6:	83 c4 18             	add    $0x18,%esp
}
  8028a9:	c9                   	leave  
  8028aa:	c3                   	ret    

008028ab <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8028ab:	55                   	push   %ebp
  8028ac:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8028ae:	6a 00                	push   $0x0
  8028b0:	6a 00                	push   $0x0
  8028b2:	6a 00                	push   $0x0
  8028b4:	6a 00                	push   $0x0
  8028b6:	6a 00                	push   $0x0
  8028b8:	6a 03                	push   $0x3
  8028ba:	e8 4b ff ff ff       	call   80280a <syscall>
  8028bf:	83 c4 18             	add    $0x18,%esp
}
  8028c2:	c9                   	leave  
  8028c3:	c3                   	ret    

008028c4 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8028c4:	55                   	push   %ebp
  8028c5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8028c7:	6a 00                	push   $0x0
  8028c9:	6a 00                	push   $0x0
  8028cb:	6a 00                	push   $0x0
  8028cd:	6a 00                	push   $0x0
  8028cf:	6a 00                	push   $0x0
  8028d1:	6a 04                	push   $0x4
  8028d3:	e8 32 ff ff ff       	call   80280a <syscall>
  8028d8:	83 c4 18             	add    $0x18,%esp
}
  8028db:	c9                   	leave  
  8028dc:	c3                   	ret    

008028dd <sys_env_exit>:


void sys_env_exit(void)
{
  8028dd:	55                   	push   %ebp
  8028de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8028e0:	6a 00                	push   $0x0
  8028e2:	6a 00                	push   $0x0
  8028e4:	6a 00                	push   $0x0
  8028e6:	6a 00                	push   $0x0
  8028e8:	6a 00                	push   $0x0
  8028ea:	6a 06                	push   $0x6
  8028ec:	e8 19 ff ff ff       	call   80280a <syscall>
  8028f1:	83 c4 18             	add    $0x18,%esp
}
  8028f4:	90                   	nop
  8028f5:	c9                   	leave  
  8028f6:	c3                   	ret    

008028f7 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8028f7:	55                   	push   %ebp
  8028f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8028fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8028fd:	8b 45 08             	mov    0x8(%ebp),%eax
  802900:	6a 00                	push   $0x0
  802902:	6a 00                	push   $0x0
  802904:	6a 00                	push   $0x0
  802906:	52                   	push   %edx
  802907:	50                   	push   %eax
  802908:	6a 07                	push   $0x7
  80290a:	e8 fb fe ff ff       	call   80280a <syscall>
  80290f:	83 c4 18             	add    $0x18,%esp
}
  802912:	c9                   	leave  
  802913:	c3                   	ret    

00802914 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802914:	55                   	push   %ebp
  802915:	89 e5                	mov    %esp,%ebp
  802917:	56                   	push   %esi
  802918:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  802919:	8b 75 18             	mov    0x18(%ebp),%esi
  80291c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80291f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802922:	8b 55 0c             	mov    0xc(%ebp),%edx
  802925:	8b 45 08             	mov    0x8(%ebp),%eax
  802928:	56                   	push   %esi
  802929:	53                   	push   %ebx
  80292a:	51                   	push   %ecx
  80292b:	52                   	push   %edx
  80292c:	50                   	push   %eax
  80292d:	6a 08                	push   $0x8
  80292f:	e8 d6 fe ff ff       	call   80280a <syscall>
  802934:	83 c4 18             	add    $0x18,%esp
}
  802937:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80293a:	5b                   	pop    %ebx
  80293b:	5e                   	pop    %esi
  80293c:	5d                   	pop    %ebp
  80293d:	c3                   	ret    

0080293e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80293e:	55                   	push   %ebp
  80293f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802941:	8b 55 0c             	mov    0xc(%ebp),%edx
  802944:	8b 45 08             	mov    0x8(%ebp),%eax
  802947:	6a 00                	push   $0x0
  802949:	6a 00                	push   $0x0
  80294b:	6a 00                	push   $0x0
  80294d:	52                   	push   %edx
  80294e:	50                   	push   %eax
  80294f:	6a 09                	push   $0x9
  802951:	e8 b4 fe ff ff       	call   80280a <syscall>
  802956:	83 c4 18             	add    $0x18,%esp
}
  802959:	c9                   	leave  
  80295a:	c3                   	ret    

0080295b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80295b:	55                   	push   %ebp
  80295c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80295e:	6a 00                	push   $0x0
  802960:	6a 00                	push   $0x0
  802962:	6a 00                	push   $0x0
  802964:	ff 75 0c             	pushl  0xc(%ebp)
  802967:	ff 75 08             	pushl  0x8(%ebp)
  80296a:	6a 0a                	push   $0xa
  80296c:	e8 99 fe ff ff       	call   80280a <syscall>
  802971:	83 c4 18             	add    $0x18,%esp
}
  802974:	c9                   	leave  
  802975:	c3                   	ret    

00802976 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802976:	55                   	push   %ebp
  802977:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  802979:	6a 00                	push   $0x0
  80297b:	6a 00                	push   $0x0
  80297d:	6a 00                	push   $0x0
  80297f:	6a 00                	push   $0x0
  802981:	6a 00                	push   $0x0
  802983:	6a 0b                	push   $0xb
  802985:	e8 80 fe ff ff       	call   80280a <syscall>
  80298a:	83 c4 18             	add    $0x18,%esp
}
  80298d:	c9                   	leave  
  80298e:	c3                   	ret    

0080298f <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80298f:	55                   	push   %ebp
  802990:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802992:	6a 00                	push   $0x0
  802994:	6a 00                	push   $0x0
  802996:	6a 00                	push   $0x0
  802998:	6a 00                	push   $0x0
  80299a:	6a 00                	push   $0x0
  80299c:	6a 0c                	push   $0xc
  80299e:	e8 67 fe ff ff       	call   80280a <syscall>
  8029a3:	83 c4 18             	add    $0x18,%esp
}
  8029a6:	c9                   	leave  
  8029a7:	c3                   	ret    

008029a8 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8029a8:	55                   	push   %ebp
  8029a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8029ab:	6a 00                	push   $0x0
  8029ad:	6a 00                	push   $0x0
  8029af:	6a 00                	push   $0x0
  8029b1:	6a 00                	push   $0x0
  8029b3:	6a 00                	push   $0x0
  8029b5:	6a 0d                	push   $0xd
  8029b7:	e8 4e fe ff ff       	call   80280a <syscall>
  8029bc:	83 c4 18             	add    $0x18,%esp
}
  8029bf:	c9                   	leave  
  8029c0:	c3                   	ret    

008029c1 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8029c1:	55                   	push   %ebp
  8029c2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8029c4:	6a 00                	push   $0x0
  8029c6:	6a 00                	push   $0x0
  8029c8:	6a 00                	push   $0x0
  8029ca:	ff 75 0c             	pushl  0xc(%ebp)
  8029cd:	ff 75 08             	pushl  0x8(%ebp)
  8029d0:	6a 11                	push   $0x11
  8029d2:	e8 33 fe ff ff       	call   80280a <syscall>
  8029d7:	83 c4 18             	add    $0x18,%esp
	return;
  8029da:	90                   	nop
}
  8029db:	c9                   	leave  
  8029dc:	c3                   	ret    

008029dd <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8029dd:	55                   	push   %ebp
  8029de:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8029e0:	6a 00                	push   $0x0
  8029e2:	6a 00                	push   $0x0
  8029e4:	6a 00                	push   $0x0
  8029e6:	ff 75 0c             	pushl  0xc(%ebp)
  8029e9:	ff 75 08             	pushl  0x8(%ebp)
  8029ec:	6a 12                	push   $0x12
  8029ee:	e8 17 fe ff ff       	call   80280a <syscall>
  8029f3:	83 c4 18             	add    $0x18,%esp
	return ;
  8029f6:	90                   	nop
}
  8029f7:	c9                   	leave  
  8029f8:	c3                   	ret    

008029f9 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8029f9:	55                   	push   %ebp
  8029fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8029fc:	6a 00                	push   $0x0
  8029fe:	6a 00                	push   $0x0
  802a00:	6a 00                	push   $0x0
  802a02:	6a 00                	push   $0x0
  802a04:	6a 00                	push   $0x0
  802a06:	6a 0e                	push   $0xe
  802a08:	e8 fd fd ff ff       	call   80280a <syscall>
  802a0d:	83 c4 18             	add    $0x18,%esp
}
  802a10:	c9                   	leave  
  802a11:	c3                   	ret    

00802a12 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802a12:	55                   	push   %ebp
  802a13:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802a15:	6a 00                	push   $0x0
  802a17:	6a 00                	push   $0x0
  802a19:	6a 00                	push   $0x0
  802a1b:	6a 00                	push   $0x0
  802a1d:	ff 75 08             	pushl  0x8(%ebp)
  802a20:	6a 0f                	push   $0xf
  802a22:	e8 e3 fd ff ff       	call   80280a <syscall>
  802a27:	83 c4 18             	add    $0x18,%esp
}
  802a2a:	c9                   	leave  
  802a2b:	c3                   	ret    

00802a2c <sys_scarce_memory>:

void sys_scarce_memory()
{
  802a2c:	55                   	push   %ebp
  802a2d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802a2f:	6a 00                	push   $0x0
  802a31:	6a 00                	push   $0x0
  802a33:	6a 00                	push   $0x0
  802a35:	6a 00                	push   $0x0
  802a37:	6a 00                	push   $0x0
  802a39:	6a 10                	push   $0x10
  802a3b:	e8 ca fd ff ff       	call   80280a <syscall>
  802a40:	83 c4 18             	add    $0x18,%esp
}
  802a43:	90                   	nop
  802a44:	c9                   	leave  
  802a45:	c3                   	ret    

00802a46 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802a46:	55                   	push   %ebp
  802a47:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802a49:	6a 00                	push   $0x0
  802a4b:	6a 00                	push   $0x0
  802a4d:	6a 00                	push   $0x0
  802a4f:	6a 00                	push   $0x0
  802a51:	6a 00                	push   $0x0
  802a53:	6a 14                	push   $0x14
  802a55:	e8 b0 fd ff ff       	call   80280a <syscall>
  802a5a:	83 c4 18             	add    $0x18,%esp
}
  802a5d:	90                   	nop
  802a5e:	c9                   	leave  
  802a5f:	c3                   	ret    

00802a60 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802a60:	55                   	push   %ebp
  802a61:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802a63:	6a 00                	push   $0x0
  802a65:	6a 00                	push   $0x0
  802a67:	6a 00                	push   $0x0
  802a69:	6a 00                	push   $0x0
  802a6b:	6a 00                	push   $0x0
  802a6d:	6a 15                	push   $0x15
  802a6f:	e8 96 fd ff ff       	call   80280a <syscall>
  802a74:	83 c4 18             	add    $0x18,%esp
}
  802a77:	90                   	nop
  802a78:	c9                   	leave  
  802a79:	c3                   	ret    

00802a7a <sys_cputc>:


void
sys_cputc(const char c)
{
  802a7a:	55                   	push   %ebp
  802a7b:	89 e5                	mov    %esp,%ebp
  802a7d:	83 ec 04             	sub    $0x4,%esp
  802a80:	8b 45 08             	mov    0x8(%ebp),%eax
  802a83:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802a86:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802a8a:	6a 00                	push   $0x0
  802a8c:	6a 00                	push   $0x0
  802a8e:	6a 00                	push   $0x0
  802a90:	6a 00                	push   $0x0
  802a92:	50                   	push   %eax
  802a93:	6a 16                	push   $0x16
  802a95:	e8 70 fd ff ff       	call   80280a <syscall>
  802a9a:	83 c4 18             	add    $0x18,%esp
}
  802a9d:	90                   	nop
  802a9e:	c9                   	leave  
  802a9f:	c3                   	ret    

00802aa0 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802aa0:	55                   	push   %ebp
  802aa1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802aa3:	6a 00                	push   $0x0
  802aa5:	6a 00                	push   $0x0
  802aa7:	6a 00                	push   $0x0
  802aa9:	6a 00                	push   $0x0
  802aab:	6a 00                	push   $0x0
  802aad:	6a 17                	push   $0x17
  802aaf:	e8 56 fd ff ff       	call   80280a <syscall>
  802ab4:	83 c4 18             	add    $0x18,%esp
}
  802ab7:	90                   	nop
  802ab8:	c9                   	leave  
  802ab9:	c3                   	ret    

00802aba <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  802aba:	55                   	push   %ebp
  802abb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802abd:	8b 45 08             	mov    0x8(%ebp),%eax
  802ac0:	6a 00                	push   $0x0
  802ac2:	6a 00                	push   $0x0
  802ac4:	6a 00                	push   $0x0
  802ac6:	ff 75 0c             	pushl  0xc(%ebp)
  802ac9:	50                   	push   %eax
  802aca:	6a 18                	push   $0x18
  802acc:	e8 39 fd ff ff       	call   80280a <syscall>
  802ad1:	83 c4 18             	add    $0x18,%esp
}
  802ad4:	c9                   	leave  
  802ad5:	c3                   	ret    

00802ad6 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802ad6:	55                   	push   %ebp
  802ad7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802ad9:	8b 55 0c             	mov    0xc(%ebp),%edx
  802adc:	8b 45 08             	mov    0x8(%ebp),%eax
  802adf:	6a 00                	push   $0x0
  802ae1:	6a 00                	push   $0x0
  802ae3:	6a 00                	push   $0x0
  802ae5:	52                   	push   %edx
  802ae6:	50                   	push   %eax
  802ae7:	6a 1b                	push   $0x1b
  802ae9:	e8 1c fd ff ff       	call   80280a <syscall>
  802aee:	83 c4 18             	add    $0x18,%esp
}
  802af1:	c9                   	leave  
  802af2:	c3                   	ret    

00802af3 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802af3:	55                   	push   %ebp
  802af4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802af6:	8b 55 0c             	mov    0xc(%ebp),%edx
  802af9:	8b 45 08             	mov    0x8(%ebp),%eax
  802afc:	6a 00                	push   $0x0
  802afe:	6a 00                	push   $0x0
  802b00:	6a 00                	push   $0x0
  802b02:	52                   	push   %edx
  802b03:	50                   	push   %eax
  802b04:	6a 19                	push   $0x19
  802b06:	e8 ff fc ff ff       	call   80280a <syscall>
  802b0b:	83 c4 18             	add    $0x18,%esp
}
  802b0e:	90                   	nop
  802b0f:	c9                   	leave  
  802b10:	c3                   	ret    

00802b11 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802b11:	55                   	push   %ebp
  802b12:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802b14:	8b 55 0c             	mov    0xc(%ebp),%edx
  802b17:	8b 45 08             	mov    0x8(%ebp),%eax
  802b1a:	6a 00                	push   $0x0
  802b1c:	6a 00                	push   $0x0
  802b1e:	6a 00                	push   $0x0
  802b20:	52                   	push   %edx
  802b21:	50                   	push   %eax
  802b22:	6a 1a                	push   $0x1a
  802b24:	e8 e1 fc ff ff       	call   80280a <syscall>
  802b29:	83 c4 18             	add    $0x18,%esp
}
  802b2c:	90                   	nop
  802b2d:	c9                   	leave  
  802b2e:	c3                   	ret    

00802b2f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802b2f:	55                   	push   %ebp
  802b30:	89 e5                	mov    %esp,%ebp
  802b32:	83 ec 04             	sub    $0x4,%esp
  802b35:	8b 45 10             	mov    0x10(%ebp),%eax
  802b38:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802b3b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802b3e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802b42:	8b 45 08             	mov    0x8(%ebp),%eax
  802b45:	6a 00                	push   $0x0
  802b47:	51                   	push   %ecx
  802b48:	52                   	push   %edx
  802b49:	ff 75 0c             	pushl  0xc(%ebp)
  802b4c:	50                   	push   %eax
  802b4d:	6a 1c                	push   $0x1c
  802b4f:	e8 b6 fc ff ff       	call   80280a <syscall>
  802b54:	83 c4 18             	add    $0x18,%esp
}
  802b57:	c9                   	leave  
  802b58:	c3                   	ret    

00802b59 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802b59:	55                   	push   %ebp
  802b5a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802b5c:	8b 55 0c             	mov    0xc(%ebp),%edx
  802b5f:	8b 45 08             	mov    0x8(%ebp),%eax
  802b62:	6a 00                	push   $0x0
  802b64:	6a 00                	push   $0x0
  802b66:	6a 00                	push   $0x0
  802b68:	52                   	push   %edx
  802b69:	50                   	push   %eax
  802b6a:	6a 1d                	push   $0x1d
  802b6c:	e8 99 fc ff ff       	call   80280a <syscall>
  802b71:	83 c4 18             	add    $0x18,%esp
}
  802b74:	c9                   	leave  
  802b75:	c3                   	ret    

00802b76 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802b76:	55                   	push   %ebp
  802b77:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802b79:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802b7c:	8b 55 0c             	mov    0xc(%ebp),%edx
  802b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  802b82:	6a 00                	push   $0x0
  802b84:	6a 00                	push   $0x0
  802b86:	51                   	push   %ecx
  802b87:	52                   	push   %edx
  802b88:	50                   	push   %eax
  802b89:	6a 1e                	push   $0x1e
  802b8b:	e8 7a fc ff ff       	call   80280a <syscall>
  802b90:	83 c4 18             	add    $0x18,%esp
}
  802b93:	c9                   	leave  
  802b94:	c3                   	ret    

00802b95 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802b95:	55                   	push   %ebp
  802b96:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802b98:	8b 55 0c             	mov    0xc(%ebp),%edx
  802b9b:	8b 45 08             	mov    0x8(%ebp),%eax
  802b9e:	6a 00                	push   $0x0
  802ba0:	6a 00                	push   $0x0
  802ba2:	6a 00                	push   $0x0
  802ba4:	52                   	push   %edx
  802ba5:	50                   	push   %eax
  802ba6:	6a 1f                	push   $0x1f
  802ba8:	e8 5d fc ff ff       	call   80280a <syscall>
  802bad:	83 c4 18             	add    $0x18,%esp
}
  802bb0:	c9                   	leave  
  802bb1:	c3                   	ret    

00802bb2 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802bb2:	55                   	push   %ebp
  802bb3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802bb5:	6a 00                	push   $0x0
  802bb7:	6a 00                	push   $0x0
  802bb9:	6a 00                	push   $0x0
  802bbb:	6a 00                	push   $0x0
  802bbd:	6a 00                	push   $0x0
  802bbf:	6a 20                	push   $0x20
  802bc1:	e8 44 fc ff ff       	call   80280a <syscall>
  802bc6:	83 c4 18             	add    $0x18,%esp
}
  802bc9:	c9                   	leave  
  802bca:	c3                   	ret    

00802bcb <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802bcb:	55                   	push   %ebp
  802bcc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802bce:	8b 45 08             	mov    0x8(%ebp),%eax
  802bd1:	6a 00                	push   $0x0
  802bd3:	ff 75 14             	pushl  0x14(%ebp)
  802bd6:	ff 75 10             	pushl  0x10(%ebp)
  802bd9:	ff 75 0c             	pushl  0xc(%ebp)
  802bdc:	50                   	push   %eax
  802bdd:	6a 21                	push   $0x21
  802bdf:	e8 26 fc ff ff       	call   80280a <syscall>
  802be4:	83 c4 18             	add    $0x18,%esp
}
  802be7:	c9                   	leave  
  802be8:	c3                   	ret    

00802be9 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802be9:	55                   	push   %ebp
  802bea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802bec:	8b 45 08             	mov    0x8(%ebp),%eax
  802bef:	6a 00                	push   $0x0
  802bf1:	6a 00                	push   $0x0
  802bf3:	6a 00                	push   $0x0
  802bf5:	6a 00                	push   $0x0
  802bf7:	50                   	push   %eax
  802bf8:	6a 22                	push   $0x22
  802bfa:	e8 0b fc ff ff       	call   80280a <syscall>
  802bff:	83 c4 18             	add    $0x18,%esp
}
  802c02:	90                   	nop
  802c03:	c9                   	leave  
  802c04:	c3                   	ret    

00802c05 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802c05:	55                   	push   %ebp
  802c06:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802c08:	8b 45 08             	mov    0x8(%ebp),%eax
  802c0b:	6a 00                	push   $0x0
  802c0d:	6a 00                	push   $0x0
  802c0f:	6a 00                	push   $0x0
  802c11:	6a 00                	push   $0x0
  802c13:	50                   	push   %eax
  802c14:	6a 23                	push   $0x23
  802c16:	e8 ef fb ff ff       	call   80280a <syscall>
  802c1b:	83 c4 18             	add    $0x18,%esp
}
  802c1e:	90                   	nop
  802c1f:	c9                   	leave  
  802c20:	c3                   	ret    

00802c21 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802c21:	55                   	push   %ebp
  802c22:	89 e5                	mov    %esp,%ebp
  802c24:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802c27:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802c2a:	8d 50 04             	lea    0x4(%eax),%edx
  802c2d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802c30:	6a 00                	push   $0x0
  802c32:	6a 00                	push   $0x0
  802c34:	6a 00                	push   $0x0
  802c36:	52                   	push   %edx
  802c37:	50                   	push   %eax
  802c38:	6a 24                	push   $0x24
  802c3a:	e8 cb fb ff ff       	call   80280a <syscall>
  802c3f:	83 c4 18             	add    $0x18,%esp
	return result;
  802c42:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802c45:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802c48:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802c4b:	89 01                	mov    %eax,(%ecx)
  802c4d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802c50:	8b 45 08             	mov    0x8(%ebp),%eax
  802c53:	c9                   	leave  
  802c54:	c2 04 00             	ret    $0x4

00802c57 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802c57:	55                   	push   %ebp
  802c58:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802c5a:	6a 00                	push   $0x0
  802c5c:	6a 00                	push   $0x0
  802c5e:	ff 75 10             	pushl  0x10(%ebp)
  802c61:	ff 75 0c             	pushl  0xc(%ebp)
  802c64:	ff 75 08             	pushl  0x8(%ebp)
  802c67:	6a 13                	push   $0x13
  802c69:	e8 9c fb ff ff       	call   80280a <syscall>
  802c6e:	83 c4 18             	add    $0x18,%esp
	return ;
  802c71:	90                   	nop
}
  802c72:	c9                   	leave  
  802c73:	c3                   	ret    

00802c74 <sys_rcr2>:
uint32 sys_rcr2()
{
  802c74:	55                   	push   %ebp
  802c75:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802c77:	6a 00                	push   $0x0
  802c79:	6a 00                	push   $0x0
  802c7b:	6a 00                	push   $0x0
  802c7d:	6a 00                	push   $0x0
  802c7f:	6a 00                	push   $0x0
  802c81:	6a 25                	push   $0x25
  802c83:	e8 82 fb ff ff       	call   80280a <syscall>
  802c88:	83 c4 18             	add    $0x18,%esp
}
  802c8b:	c9                   	leave  
  802c8c:	c3                   	ret    

00802c8d <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802c8d:	55                   	push   %ebp
  802c8e:	89 e5                	mov    %esp,%ebp
  802c90:	83 ec 04             	sub    $0x4,%esp
  802c93:	8b 45 08             	mov    0x8(%ebp),%eax
  802c96:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802c99:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802c9d:	6a 00                	push   $0x0
  802c9f:	6a 00                	push   $0x0
  802ca1:	6a 00                	push   $0x0
  802ca3:	6a 00                	push   $0x0
  802ca5:	50                   	push   %eax
  802ca6:	6a 26                	push   $0x26
  802ca8:	e8 5d fb ff ff       	call   80280a <syscall>
  802cad:	83 c4 18             	add    $0x18,%esp
	return ;
  802cb0:	90                   	nop
}
  802cb1:	c9                   	leave  
  802cb2:	c3                   	ret    

00802cb3 <rsttst>:
void rsttst()
{
  802cb3:	55                   	push   %ebp
  802cb4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802cb6:	6a 00                	push   $0x0
  802cb8:	6a 00                	push   $0x0
  802cba:	6a 00                	push   $0x0
  802cbc:	6a 00                	push   $0x0
  802cbe:	6a 00                	push   $0x0
  802cc0:	6a 28                	push   $0x28
  802cc2:	e8 43 fb ff ff       	call   80280a <syscall>
  802cc7:	83 c4 18             	add    $0x18,%esp
	return ;
  802cca:	90                   	nop
}
  802ccb:	c9                   	leave  
  802ccc:	c3                   	ret    

00802ccd <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802ccd:	55                   	push   %ebp
  802cce:	89 e5                	mov    %esp,%ebp
  802cd0:	83 ec 04             	sub    $0x4,%esp
  802cd3:	8b 45 14             	mov    0x14(%ebp),%eax
  802cd6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802cd9:	8b 55 18             	mov    0x18(%ebp),%edx
  802cdc:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802ce0:	52                   	push   %edx
  802ce1:	50                   	push   %eax
  802ce2:	ff 75 10             	pushl  0x10(%ebp)
  802ce5:	ff 75 0c             	pushl  0xc(%ebp)
  802ce8:	ff 75 08             	pushl  0x8(%ebp)
  802ceb:	6a 27                	push   $0x27
  802ced:	e8 18 fb ff ff       	call   80280a <syscall>
  802cf2:	83 c4 18             	add    $0x18,%esp
	return ;
  802cf5:	90                   	nop
}
  802cf6:	c9                   	leave  
  802cf7:	c3                   	ret    

00802cf8 <chktst>:
void chktst(uint32 n)
{
  802cf8:	55                   	push   %ebp
  802cf9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802cfb:	6a 00                	push   $0x0
  802cfd:	6a 00                	push   $0x0
  802cff:	6a 00                	push   $0x0
  802d01:	6a 00                	push   $0x0
  802d03:	ff 75 08             	pushl  0x8(%ebp)
  802d06:	6a 29                	push   $0x29
  802d08:	e8 fd fa ff ff       	call   80280a <syscall>
  802d0d:	83 c4 18             	add    $0x18,%esp
	return ;
  802d10:	90                   	nop
}
  802d11:	c9                   	leave  
  802d12:	c3                   	ret    

00802d13 <inctst>:

void inctst()
{
  802d13:	55                   	push   %ebp
  802d14:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802d16:	6a 00                	push   $0x0
  802d18:	6a 00                	push   $0x0
  802d1a:	6a 00                	push   $0x0
  802d1c:	6a 00                	push   $0x0
  802d1e:	6a 00                	push   $0x0
  802d20:	6a 2a                	push   $0x2a
  802d22:	e8 e3 fa ff ff       	call   80280a <syscall>
  802d27:	83 c4 18             	add    $0x18,%esp
	return ;
  802d2a:	90                   	nop
}
  802d2b:	c9                   	leave  
  802d2c:	c3                   	ret    

00802d2d <gettst>:
uint32 gettst()
{
  802d2d:	55                   	push   %ebp
  802d2e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802d30:	6a 00                	push   $0x0
  802d32:	6a 00                	push   $0x0
  802d34:	6a 00                	push   $0x0
  802d36:	6a 00                	push   $0x0
  802d38:	6a 00                	push   $0x0
  802d3a:	6a 2b                	push   $0x2b
  802d3c:	e8 c9 fa ff ff       	call   80280a <syscall>
  802d41:	83 c4 18             	add    $0x18,%esp
}
  802d44:	c9                   	leave  
  802d45:	c3                   	ret    

00802d46 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802d46:	55                   	push   %ebp
  802d47:	89 e5                	mov    %esp,%ebp
  802d49:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802d4c:	6a 00                	push   $0x0
  802d4e:	6a 00                	push   $0x0
  802d50:	6a 00                	push   $0x0
  802d52:	6a 00                	push   $0x0
  802d54:	6a 00                	push   $0x0
  802d56:	6a 2c                	push   $0x2c
  802d58:	e8 ad fa ff ff       	call   80280a <syscall>
  802d5d:	83 c4 18             	add    $0x18,%esp
  802d60:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802d63:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802d67:	75 07                	jne    802d70 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802d69:	b8 01 00 00 00       	mov    $0x1,%eax
  802d6e:	eb 05                	jmp    802d75 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802d70:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802d75:	c9                   	leave  
  802d76:	c3                   	ret    

00802d77 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802d77:	55                   	push   %ebp
  802d78:	89 e5                	mov    %esp,%ebp
  802d7a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802d7d:	6a 00                	push   $0x0
  802d7f:	6a 00                	push   $0x0
  802d81:	6a 00                	push   $0x0
  802d83:	6a 00                	push   $0x0
  802d85:	6a 00                	push   $0x0
  802d87:	6a 2c                	push   $0x2c
  802d89:	e8 7c fa ff ff       	call   80280a <syscall>
  802d8e:	83 c4 18             	add    $0x18,%esp
  802d91:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802d94:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802d98:	75 07                	jne    802da1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802d9a:	b8 01 00 00 00       	mov    $0x1,%eax
  802d9f:	eb 05                	jmp    802da6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802da1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802da6:	c9                   	leave  
  802da7:	c3                   	ret    

00802da8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802da8:	55                   	push   %ebp
  802da9:	89 e5                	mov    %esp,%ebp
  802dab:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802dae:	6a 00                	push   $0x0
  802db0:	6a 00                	push   $0x0
  802db2:	6a 00                	push   $0x0
  802db4:	6a 00                	push   $0x0
  802db6:	6a 00                	push   $0x0
  802db8:	6a 2c                	push   $0x2c
  802dba:	e8 4b fa ff ff       	call   80280a <syscall>
  802dbf:	83 c4 18             	add    $0x18,%esp
  802dc2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802dc5:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802dc9:	75 07                	jne    802dd2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802dcb:	b8 01 00 00 00       	mov    $0x1,%eax
  802dd0:	eb 05                	jmp    802dd7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802dd2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802dd7:	c9                   	leave  
  802dd8:	c3                   	ret    

00802dd9 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802dd9:	55                   	push   %ebp
  802dda:	89 e5                	mov    %esp,%ebp
  802ddc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802ddf:	6a 00                	push   $0x0
  802de1:	6a 00                	push   $0x0
  802de3:	6a 00                	push   $0x0
  802de5:	6a 00                	push   $0x0
  802de7:	6a 00                	push   $0x0
  802de9:	6a 2c                	push   $0x2c
  802deb:	e8 1a fa ff ff       	call   80280a <syscall>
  802df0:	83 c4 18             	add    $0x18,%esp
  802df3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802df6:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802dfa:	75 07                	jne    802e03 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802dfc:	b8 01 00 00 00       	mov    $0x1,%eax
  802e01:	eb 05                	jmp    802e08 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802e03:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802e08:	c9                   	leave  
  802e09:	c3                   	ret    

00802e0a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802e0a:	55                   	push   %ebp
  802e0b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802e0d:	6a 00                	push   $0x0
  802e0f:	6a 00                	push   $0x0
  802e11:	6a 00                	push   $0x0
  802e13:	6a 00                	push   $0x0
  802e15:	ff 75 08             	pushl  0x8(%ebp)
  802e18:	6a 2d                	push   $0x2d
  802e1a:	e8 eb f9 ff ff       	call   80280a <syscall>
  802e1f:	83 c4 18             	add    $0x18,%esp
	return ;
  802e22:	90                   	nop
}
  802e23:	c9                   	leave  
  802e24:	c3                   	ret    

00802e25 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802e25:	55                   	push   %ebp
  802e26:	89 e5                	mov    %esp,%ebp
  802e28:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802e29:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802e2c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802e2f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e32:	8b 45 08             	mov    0x8(%ebp),%eax
  802e35:	6a 00                	push   $0x0
  802e37:	53                   	push   %ebx
  802e38:	51                   	push   %ecx
  802e39:	52                   	push   %edx
  802e3a:	50                   	push   %eax
  802e3b:	6a 2e                	push   $0x2e
  802e3d:	e8 c8 f9 ff ff       	call   80280a <syscall>
  802e42:	83 c4 18             	add    $0x18,%esp
}
  802e45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802e48:	c9                   	leave  
  802e49:	c3                   	ret    

00802e4a <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802e4a:	55                   	push   %ebp
  802e4b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802e4d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802e50:	8b 45 08             	mov    0x8(%ebp),%eax
  802e53:	6a 00                	push   $0x0
  802e55:	6a 00                	push   $0x0
  802e57:	6a 00                	push   $0x0
  802e59:	52                   	push   %edx
  802e5a:	50                   	push   %eax
  802e5b:	6a 2f                	push   $0x2f
  802e5d:	e8 a8 f9 ff ff       	call   80280a <syscall>
  802e62:	83 c4 18             	add    $0x18,%esp
}
  802e65:	c9                   	leave  
  802e66:	c3                   	ret    
  802e67:	90                   	nop

00802e68 <__udivdi3>:
  802e68:	55                   	push   %ebp
  802e69:	57                   	push   %edi
  802e6a:	56                   	push   %esi
  802e6b:	53                   	push   %ebx
  802e6c:	83 ec 1c             	sub    $0x1c,%esp
  802e6f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802e73:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802e77:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802e7b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802e7f:	89 ca                	mov    %ecx,%edx
  802e81:	89 f8                	mov    %edi,%eax
  802e83:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802e87:	85 f6                	test   %esi,%esi
  802e89:	75 2d                	jne    802eb8 <__udivdi3+0x50>
  802e8b:	39 cf                	cmp    %ecx,%edi
  802e8d:	77 65                	ja     802ef4 <__udivdi3+0x8c>
  802e8f:	89 fd                	mov    %edi,%ebp
  802e91:	85 ff                	test   %edi,%edi
  802e93:	75 0b                	jne    802ea0 <__udivdi3+0x38>
  802e95:	b8 01 00 00 00       	mov    $0x1,%eax
  802e9a:	31 d2                	xor    %edx,%edx
  802e9c:	f7 f7                	div    %edi
  802e9e:	89 c5                	mov    %eax,%ebp
  802ea0:	31 d2                	xor    %edx,%edx
  802ea2:	89 c8                	mov    %ecx,%eax
  802ea4:	f7 f5                	div    %ebp
  802ea6:	89 c1                	mov    %eax,%ecx
  802ea8:	89 d8                	mov    %ebx,%eax
  802eaa:	f7 f5                	div    %ebp
  802eac:	89 cf                	mov    %ecx,%edi
  802eae:	89 fa                	mov    %edi,%edx
  802eb0:	83 c4 1c             	add    $0x1c,%esp
  802eb3:	5b                   	pop    %ebx
  802eb4:	5e                   	pop    %esi
  802eb5:	5f                   	pop    %edi
  802eb6:	5d                   	pop    %ebp
  802eb7:	c3                   	ret    
  802eb8:	39 ce                	cmp    %ecx,%esi
  802eba:	77 28                	ja     802ee4 <__udivdi3+0x7c>
  802ebc:	0f bd fe             	bsr    %esi,%edi
  802ebf:	83 f7 1f             	xor    $0x1f,%edi
  802ec2:	75 40                	jne    802f04 <__udivdi3+0x9c>
  802ec4:	39 ce                	cmp    %ecx,%esi
  802ec6:	72 0a                	jb     802ed2 <__udivdi3+0x6a>
  802ec8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802ecc:	0f 87 9e 00 00 00    	ja     802f70 <__udivdi3+0x108>
  802ed2:	b8 01 00 00 00       	mov    $0x1,%eax
  802ed7:	89 fa                	mov    %edi,%edx
  802ed9:	83 c4 1c             	add    $0x1c,%esp
  802edc:	5b                   	pop    %ebx
  802edd:	5e                   	pop    %esi
  802ede:	5f                   	pop    %edi
  802edf:	5d                   	pop    %ebp
  802ee0:	c3                   	ret    
  802ee1:	8d 76 00             	lea    0x0(%esi),%esi
  802ee4:	31 ff                	xor    %edi,%edi
  802ee6:	31 c0                	xor    %eax,%eax
  802ee8:	89 fa                	mov    %edi,%edx
  802eea:	83 c4 1c             	add    $0x1c,%esp
  802eed:	5b                   	pop    %ebx
  802eee:	5e                   	pop    %esi
  802eef:	5f                   	pop    %edi
  802ef0:	5d                   	pop    %ebp
  802ef1:	c3                   	ret    
  802ef2:	66 90                	xchg   %ax,%ax
  802ef4:	89 d8                	mov    %ebx,%eax
  802ef6:	f7 f7                	div    %edi
  802ef8:	31 ff                	xor    %edi,%edi
  802efa:	89 fa                	mov    %edi,%edx
  802efc:	83 c4 1c             	add    $0x1c,%esp
  802eff:	5b                   	pop    %ebx
  802f00:	5e                   	pop    %esi
  802f01:	5f                   	pop    %edi
  802f02:	5d                   	pop    %ebp
  802f03:	c3                   	ret    
  802f04:	bd 20 00 00 00       	mov    $0x20,%ebp
  802f09:	89 eb                	mov    %ebp,%ebx
  802f0b:	29 fb                	sub    %edi,%ebx
  802f0d:	89 f9                	mov    %edi,%ecx
  802f0f:	d3 e6                	shl    %cl,%esi
  802f11:	89 c5                	mov    %eax,%ebp
  802f13:	88 d9                	mov    %bl,%cl
  802f15:	d3 ed                	shr    %cl,%ebp
  802f17:	89 e9                	mov    %ebp,%ecx
  802f19:	09 f1                	or     %esi,%ecx
  802f1b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802f1f:	89 f9                	mov    %edi,%ecx
  802f21:	d3 e0                	shl    %cl,%eax
  802f23:	89 c5                	mov    %eax,%ebp
  802f25:	89 d6                	mov    %edx,%esi
  802f27:	88 d9                	mov    %bl,%cl
  802f29:	d3 ee                	shr    %cl,%esi
  802f2b:	89 f9                	mov    %edi,%ecx
  802f2d:	d3 e2                	shl    %cl,%edx
  802f2f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802f33:	88 d9                	mov    %bl,%cl
  802f35:	d3 e8                	shr    %cl,%eax
  802f37:	09 c2                	or     %eax,%edx
  802f39:	89 d0                	mov    %edx,%eax
  802f3b:	89 f2                	mov    %esi,%edx
  802f3d:	f7 74 24 0c          	divl   0xc(%esp)
  802f41:	89 d6                	mov    %edx,%esi
  802f43:	89 c3                	mov    %eax,%ebx
  802f45:	f7 e5                	mul    %ebp
  802f47:	39 d6                	cmp    %edx,%esi
  802f49:	72 19                	jb     802f64 <__udivdi3+0xfc>
  802f4b:	74 0b                	je     802f58 <__udivdi3+0xf0>
  802f4d:	89 d8                	mov    %ebx,%eax
  802f4f:	31 ff                	xor    %edi,%edi
  802f51:	e9 58 ff ff ff       	jmp    802eae <__udivdi3+0x46>
  802f56:	66 90                	xchg   %ax,%ax
  802f58:	8b 54 24 08          	mov    0x8(%esp),%edx
  802f5c:	89 f9                	mov    %edi,%ecx
  802f5e:	d3 e2                	shl    %cl,%edx
  802f60:	39 c2                	cmp    %eax,%edx
  802f62:	73 e9                	jae    802f4d <__udivdi3+0xe5>
  802f64:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802f67:	31 ff                	xor    %edi,%edi
  802f69:	e9 40 ff ff ff       	jmp    802eae <__udivdi3+0x46>
  802f6e:	66 90                	xchg   %ax,%ax
  802f70:	31 c0                	xor    %eax,%eax
  802f72:	e9 37 ff ff ff       	jmp    802eae <__udivdi3+0x46>
  802f77:	90                   	nop

00802f78 <__umoddi3>:
  802f78:	55                   	push   %ebp
  802f79:	57                   	push   %edi
  802f7a:	56                   	push   %esi
  802f7b:	53                   	push   %ebx
  802f7c:	83 ec 1c             	sub    $0x1c,%esp
  802f7f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802f83:	8b 74 24 34          	mov    0x34(%esp),%esi
  802f87:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802f8b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802f8f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802f93:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802f97:	89 f3                	mov    %esi,%ebx
  802f99:	89 fa                	mov    %edi,%edx
  802f9b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802f9f:	89 34 24             	mov    %esi,(%esp)
  802fa2:	85 c0                	test   %eax,%eax
  802fa4:	75 1a                	jne    802fc0 <__umoddi3+0x48>
  802fa6:	39 f7                	cmp    %esi,%edi
  802fa8:	0f 86 a2 00 00 00    	jbe    803050 <__umoddi3+0xd8>
  802fae:	89 c8                	mov    %ecx,%eax
  802fb0:	89 f2                	mov    %esi,%edx
  802fb2:	f7 f7                	div    %edi
  802fb4:	89 d0                	mov    %edx,%eax
  802fb6:	31 d2                	xor    %edx,%edx
  802fb8:	83 c4 1c             	add    $0x1c,%esp
  802fbb:	5b                   	pop    %ebx
  802fbc:	5e                   	pop    %esi
  802fbd:	5f                   	pop    %edi
  802fbe:	5d                   	pop    %ebp
  802fbf:	c3                   	ret    
  802fc0:	39 f0                	cmp    %esi,%eax
  802fc2:	0f 87 ac 00 00 00    	ja     803074 <__umoddi3+0xfc>
  802fc8:	0f bd e8             	bsr    %eax,%ebp
  802fcb:	83 f5 1f             	xor    $0x1f,%ebp
  802fce:	0f 84 ac 00 00 00    	je     803080 <__umoddi3+0x108>
  802fd4:	bf 20 00 00 00       	mov    $0x20,%edi
  802fd9:	29 ef                	sub    %ebp,%edi
  802fdb:	89 fe                	mov    %edi,%esi
  802fdd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802fe1:	89 e9                	mov    %ebp,%ecx
  802fe3:	d3 e0                	shl    %cl,%eax
  802fe5:	89 d7                	mov    %edx,%edi
  802fe7:	89 f1                	mov    %esi,%ecx
  802fe9:	d3 ef                	shr    %cl,%edi
  802feb:	09 c7                	or     %eax,%edi
  802fed:	89 e9                	mov    %ebp,%ecx
  802fef:	d3 e2                	shl    %cl,%edx
  802ff1:	89 14 24             	mov    %edx,(%esp)
  802ff4:	89 d8                	mov    %ebx,%eax
  802ff6:	d3 e0                	shl    %cl,%eax
  802ff8:	89 c2                	mov    %eax,%edx
  802ffa:	8b 44 24 08          	mov    0x8(%esp),%eax
  802ffe:	d3 e0                	shl    %cl,%eax
  803000:	89 44 24 04          	mov    %eax,0x4(%esp)
  803004:	8b 44 24 08          	mov    0x8(%esp),%eax
  803008:	89 f1                	mov    %esi,%ecx
  80300a:	d3 e8                	shr    %cl,%eax
  80300c:	09 d0                	or     %edx,%eax
  80300e:	d3 eb                	shr    %cl,%ebx
  803010:	89 da                	mov    %ebx,%edx
  803012:	f7 f7                	div    %edi
  803014:	89 d3                	mov    %edx,%ebx
  803016:	f7 24 24             	mull   (%esp)
  803019:	89 c6                	mov    %eax,%esi
  80301b:	89 d1                	mov    %edx,%ecx
  80301d:	39 d3                	cmp    %edx,%ebx
  80301f:	0f 82 87 00 00 00    	jb     8030ac <__umoddi3+0x134>
  803025:	0f 84 91 00 00 00    	je     8030bc <__umoddi3+0x144>
  80302b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80302f:	29 f2                	sub    %esi,%edx
  803031:	19 cb                	sbb    %ecx,%ebx
  803033:	89 d8                	mov    %ebx,%eax
  803035:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  803039:	d3 e0                	shl    %cl,%eax
  80303b:	89 e9                	mov    %ebp,%ecx
  80303d:	d3 ea                	shr    %cl,%edx
  80303f:	09 d0                	or     %edx,%eax
  803041:	89 e9                	mov    %ebp,%ecx
  803043:	d3 eb                	shr    %cl,%ebx
  803045:	89 da                	mov    %ebx,%edx
  803047:	83 c4 1c             	add    $0x1c,%esp
  80304a:	5b                   	pop    %ebx
  80304b:	5e                   	pop    %esi
  80304c:	5f                   	pop    %edi
  80304d:	5d                   	pop    %ebp
  80304e:	c3                   	ret    
  80304f:	90                   	nop
  803050:	89 fd                	mov    %edi,%ebp
  803052:	85 ff                	test   %edi,%edi
  803054:	75 0b                	jne    803061 <__umoddi3+0xe9>
  803056:	b8 01 00 00 00       	mov    $0x1,%eax
  80305b:	31 d2                	xor    %edx,%edx
  80305d:	f7 f7                	div    %edi
  80305f:	89 c5                	mov    %eax,%ebp
  803061:	89 f0                	mov    %esi,%eax
  803063:	31 d2                	xor    %edx,%edx
  803065:	f7 f5                	div    %ebp
  803067:	89 c8                	mov    %ecx,%eax
  803069:	f7 f5                	div    %ebp
  80306b:	89 d0                	mov    %edx,%eax
  80306d:	e9 44 ff ff ff       	jmp    802fb6 <__umoddi3+0x3e>
  803072:	66 90                	xchg   %ax,%ax
  803074:	89 c8                	mov    %ecx,%eax
  803076:	89 f2                	mov    %esi,%edx
  803078:	83 c4 1c             	add    $0x1c,%esp
  80307b:	5b                   	pop    %ebx
  80307c:	5e                   	pop    %esi
  80307d:	5f                   	pop    %edi
  80307e:	5d                   	pop    %ebp
  80307f:	c3                   	ret    
  803080:	3b 04 24             	cmp    (%esp),%eax
  803083:	72 06                	jb     80308b <__umoddi3+0x113>
  803085:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  803089:	77 0f                	ja     80309a <__umoddi3+0x122>
  80308b:	89 f2                	mov    %esi,%edx
  80308d:	29 f9                	sub    %edi,%ecx
  80308f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  803093:	89 14 24             	mov    %edx,(%esp)
  803096:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80309a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80309e:	8b 14 24             	mov    (%esp),%edx
  8030a1:	83 c4 1c             	add    $0x1c,%esp
  8030a4:	5b                   	pop    %ebx
  8030a5:	5e                   	pop    %esi
  8030a6:	5f                   	pop    %edi
  8030a7:	5d                   	pop    %ebp
  8030a8:	c3                   	ret    
  8030a9:	8d 76 00             	lea    0x0(%esi),%esi
  8030ac:	2b 04 24             	sub    (%esp),%eax
  8030af:	19 fa                	sbb    %edi,%edx
  8030b1:	89 d1                	mov    %edx,%ecx
  8030b3:	89 c6                	mov    %eax,%esi
  8030b5:	e9 71 ff ff ff       	jmp    80302b <__umoddi3+0xb3>
  8030ba:	66 90                	xchg   %ax,%ax
  8030bc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8030c0:	72 ea                	jb     8030ac <__umoddi3+0x134>
  8030c2:	89 d9                	mov    %ebx,%ecx
  8030c4:	e9 62 ff ff ff       	jmp    80302b <__umoddi3+0xb3>
