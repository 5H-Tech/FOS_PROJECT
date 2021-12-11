
obj/user/tst_table_replacement_basics:     file format elf32-i386


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
  800031:	e8 a5 02 00 00       	call   8002db <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:


uint8* ptr = (uint8* )0x0800000 ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 24 00 00 02    	sub    $0x2000024,%esp
	
	

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if ( ROUNDDOWN(myEnv->__ptr_tws[0].virtual_address,1024*PAGE_SIZE) !=  0x00000000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800042:	a1 20 30 80 00       	mov    0x803020,%eax
  800047:	8b 80 f8 38 01 00    	mov    0x138f8(%eax),%eax
  80004d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800050:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800053:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800058:	85 c0                	test   %eax,%eax
  80005a:	74 14                	je     800070 <_main+0x38>
  80005c:	83 ec 04             	sub    $0x4,%esp
  80005f:	68 20 1d 80 00       	push   $0x801d20
  800064:	6a 17                	push   $0x17
  800066:	68 68 1d 80 00       	push   $0x801d68
  80006b:	e8 b0 03 00 00       	call   800420 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[1].virtual_address,1024*PAGE_SIZE) !=  0x00800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  800070:	a1 20 30 80 00       	mov    0x803020,%eax
  800075:	8b 80 08 39 01 00    	mov    0x13908(%eax),%eax
  80007b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80007e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800081:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  800086:	3d 00 00 80 00       	cmp    $0x800000,%eax
  80008b:	74 14                	je     8000a1 <_main+0x69>
  80008d:	83 ec 04             	sub    $0x4,%esp
  800090:	68 20 1d 80 00       	push   $0x801d20
  800095:	6a 18                	push   $0x18
  800097:	68 68 1d 80 00       	push   $0x801d68
  80009c:	e8 7f 03 00 00       	call   800420 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[2].virtual_address,1024*PAGE_SIZE) !=  0xee800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000a1:	a1 20 30 80 00       	mov    0x803020,%eax
  8000a6:	8b 80 18 39 01 00    	mov    0x13918(%eax),%eax
  8000ac:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8000af:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000b2:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8000b7:	3d 00 00 80 ee       	cmp    $0xee800000,%eax
  8000bc:	74 14                	je     8000d2 <_main+0x9a>
  8000be:	83 ec 04             	sub    $0x4,%esp
  8000c1:	68 20 1d 80 00       	push   $0x801d20
  8000c6:	6a 19                	push   $0x19
  8000c8:	68 68 1d 80 00       	push   $0x801d68
  8000cd:	e8 4e 03 00 00       	call   800420 <_panic>
		if( ROUNDDOWN(myEnv->__ptr_tws[3].virtual_address,1024*PAGE_SIZE) !=  0xec800000)  panic("INITIAL PAGE WS entry checking failed! Review sizes of the two WS's..!!");
  8000d2:	a1 20 30 80 00       	mov    0x803020,%eax
  8000d7:	8b 80 28 39 01 00    	mov    0x13928(%eax),%eax
  8000dd:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8000e0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000e3:	25 00 00 c0 ff       	and    $0xffc00000,%eax
  8000e8:	3d 00 00 80 ec       	cmp    $0xec800000,%eax
  8000ed:	74 14                	je     800103 <_main+0xcb>
  8000ef:	83 ec 04             	sub    $0x4,%esp
  8000f2:	68 20 1d 80 00       	push   $0x801d20
  8000f7:	6a 1a                	push   $0x1a
  8000f9:	68 68 1d 80 00       	push   $0x801d68
  8000fe:	e8 1d 03 00 00       	call   800420 <_panic>
		if( myEnv->table_last_WS_index !=  0)  											panic("INITIAL TABLE last index checking failed! Review sizes of the two WS's..!!");
  800103:	a1 20 30 80 00       	mov    0x803020,%eax
  800108:	8b 80 1c 3c 01 00    	mov    0x13c1c(%eax),%eax
  80010e:	85 c0                	test   %eax,%eax
  800110:	74 14                	je     800126 <_main+0xee>
  800112:	83 ec 04             	sub    $0x4,%esp
  800115:	68 8c 1d 80 00       	push   $0x801d8c
  80011a:	6a 1b                	push   $0x1b
  80011c:	68 68 1d 80 00       	push   $0x801d68
  800121:	e8 fa 02 00 00       	call   800420 <_panic>

	}
	int freeFrames = sys_calculate_free_frames() ;
  800126:	e8 8d 14 00 00       	call   8015b8 <sys_calculate_free_frames>
  80012b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  80012e:	e8 08 15 00 00       	call   80163b <sys_pf_calculate_allocated_pages>
  800133:	89 45 e0             	mov    %eax,-0x20(%ebp)

	{
		arr[0] = -1;
  800136:	c6 85 e0 ff ff fd ff 	movb   $0xff,-0x2000020(%ebp)
		arr[PAGE_SIZE*1024-1] = -1;
  80013d:	c6 85 df ff 3f fe ff 	movb   $0xff,-0x1c00021(%ebp)
		arr[PAGE_SIZE*1024*2-1] = -1;
  800144:	c6 85 df ff 7f fe ff 	movb   $0xff,-0x1800021(%ebp)
		arr[PAGE_SIZE*1024*3-1] = -1;
  80014b:	c6 85 df ff bf fe ff 	movb   $0xff,-0x1400021(%ebp)
		arr[PAGE_SIZE*1024*4-1] = -1;
  800152:	c6 85 df ff ff fe ff 	movb   $0xff,-0x1000021(%ebp)

		arr[PAGE_SIZE*1024*5-1] = -1;
  800159:	c6 85 df ff 3f ff ff 	movb   $0xff,-0xc00021(%ebp)
		arr[PAGE_SIZE*1024*6-1] = -1;
  800160:	c6 85 df ff 7f ff ff 	movb   $0xff,-0x800021(%ebp)



		if((freeFrames - sys_calculate_free_frames()) != 6 + 6 + 1)	//1 for disk directory + 6 placement STACK pages + 6 page tables for writing these 6 new stack pages on PF
  800167:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  80016a:	e8 49 14 00 00       	call   8015b8 <sys_calculate_free_frames>
  80016f:	29 c3                	sub    %eax,%ebx
  800171:	89 d8                	mov    %ebx,%eax
  800173:	83 f8 0d             	cmp    $0xd,%eax
  800176:	74 14                	je     80018c <_main+0x154>
			panic("Extra/Less memory are wrongly allocated... Table RE-placement shouldn't allocate extra frames") ;
  800178:	83 ec 04             	sub    $0x4,%esp
  80017b:	68 d8 1d 80 00       	push   $0x801dd8
  800180:	6a 2e                	push   $0x2e
  800182:	68 68 1d 80 00       	push   $0x801d68
  800187:	e8 94 02 00 00       	call   800420 <_panic>

		cprintf("STEP A passed: Dealing with memory works!\n\n\n");
  80018c:	83 ec 0c             	sub    $0xc,%esp
  80018f:	68 38 1e 80 00       	push   $0x801e38
  800194:	e8 29 05 00 00       	call   8006c2 <cprintf>
  800199:	83 c4 10             	add    $0x10,%esp

	}
	//cprintf("STEP B: checking the operations with page file... \n");
	{

		if((sys_pf_calculate_allocated_pages() - usedDiskPages) != 6)		//6 victim page tables should written back into PF
  80019c:	e8 9a 14 00 00       	call   80163b <sys_pf_calculate_allocated_pages>
  8001a1:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001a4:	83 f8 06             	cmp    $0x6,%eax
  8001a7:	74 14                	je     8001bd <_main+0x185>
			panic("Victim table is not written back into page file") ;
  8001a9:	83 ec 04             	sub    $0x4,%esp
  8001ac:	68 68 1e 80 00       	push   $0x801e68
  8001b1:	6a 37                	push   $0x37
  8001b3:	68 68 1d 80 00       	push   $0x801d68
  8001b8:	e8 63 02 00 00       	call   800420 <_panic>

		usedDiskPages = sys_pf_calculate_allocated_pages();
  8001bd:	e8 79 14 00 00       	call   80163b <sys_pf_calculate_allocated_pages>
  8001c2:	89 45 e0             	mov    %eax,-0x20(%ebp)

		if(arr[0] != -1) panic("make sure that you get the existing tables from page file") ;
  8001c5:	8a 85 e0 ff ff fd    	mov    -0x2000020(%ebp),%al
  8001cb:	3c ff                	cmp    $0xff,%al
  8001cd:	74 14                	je     8001e3 <_main+0x1ab>
  8001cf:	83 ec 04             	sub    $0x4,%esp
  8001d2:	68 98 1e 80 00       	push   $0x801e98
  8001d7:	6a 3b                	push   $0x3b
  8001d9:	68 68 1d 80 00       	push   $0x801d68
  8001de:	e8 3d 02 00 00       	call   800420 <_panic>
		if(arr[PAGE_SIZE*1024-1] != -1) panic("make sure that you get the existing tables from page file") ;
  8001e3:	8a 85 df ff 3f fe    	mov    -0x1c00021(%ebp),%al
  8001e9:	3c ff                	cmp    $0xff,%al
  8001eb:	74 14                	je     800201 <_main+0x1c9>
  8001ed:	83 ec 04             	sub    $0x4,%esp
  8001f0:	68 98 1e 80 00       	push   $0x801e98
  8001f5:	6a 3c                	push   $0x3c
  8001f7:	68 68 1d 80 00       	push   $0x801d68
  8001fc:	e8 1f 02 00 00       	call   800420 <_panic>
		if(arr[PAGE_SIZE*1024*2-1] != -1) panic("make sure that you get the existing tables from page file") ;
  800201:	8a 85 df ff 7f fe    	mov    -0x1800021(%ebp),%al
  800207:	3c ff                	cmp    $0xff,%al
  800209:	74 14                	je     80021f <_main+0x1e7>
  80020b:	83 ec 04             	sub    $0x4,%esp
  80020e:	68 98 1e 80 00       	push   $0x801e98
  800213:	6a 3d                	push   $0x3d
  800215:	68 68 1d 80 00       	push   $0x801d68
  80021a:	e8 01 02 00 00       	call   800420 <_panic>
		if(arr[PAGE_SIZE*1024*3-1] != -1) panic("make sure that you get the existing tables from page file") ;
  80021f:	8a 85 df ff bf fe    	mov    -0x1400021(%ebp),%al
  800225:	3c ff                	cmp    $0xff,%al
  800227:	74 14                	je     80023d <_main+0x205>
  800229:	83 ec 04             	sub    $0x4,%esp
  80022c:	68 98 1e 80 00       	push   $0x801e98
  800231:	6a 3e                	push   $0x3e
  800233:	68 68 1d 80 00       	push   $0x801d68
  800238:	e8 e3 01 00 00       	call   800420 <_panic>
		if(arr[PAGE_SIZE*1024*4-1] != -1) panic("make sure that you get the existing tables from page file") ;
  80023d:	8a 85 df ff ff fe    	mov    -0x1000021(%ebp),%al
  800243:	3c ff                	cmp    $0xff,%al
  800245:	74 14                	je     80025b <_main+0x223>
  800247:	83 ec 04             	sub    $0x4,%esp
  80024a:	68 98 1e 80 00       	push   $0x801e98
  80024f:	6a 3f                	push   $0x3f
  800251:	68 68 1d 80 00       	push   $0x801d68
  800256:	e8 c5 01 00 00       	call   800420 <_panic>

		if(arr[PAGE_SIZE*1024*5-1] != -1) panic("make sure that you get the existing tables from page file") ;
  80025b:	8a 85 df ff 3f ff    	mov    -0xc00021(%ebp),%al
  800261:	3c ff                	cmp    $0xff,%al
  800263:	74 14                	je     800279 <_main+0x241>
  800265:	83 ec 04             	sub    $0x4,%esp
  800268:	68 98 1e 80 00       	push   $0x801e98
  80026d:	6a 41                	push   $0x41
  80026f:	68 68 1d 80 00       	push   $0x801d68
  800274:	e8 a7 01 00 00       	call   800420 <_panic>
		if(arr[PAGE_SIZE*1024*6-1] != -1) panic("make sure that you get the existing tables from page file") ;
  800279:	8a 85 df ff 7f ff    	mov    -0x800021(%ebp),%al
  80027f:	3c ff                	cmp    $0xff,%al
  800281:	74 14                	je     800297 <_main+0x25f>
  800283:	83 ec 04             	sub    $0x4,%esp
  800286:	68 98 1e 80 00       	push   $0x801e98
  80028b:	6a 42                	push   $0x42
  80028d:	68 68 1d 80 00       	push   $0x801d68
  800292:	e8 89 01 00 00       	call   800420 <_panic>

		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("tables not removed from page file correctly.. make sure you delete table from page file after reading it into memory");
  800297:	e8 9f 13 00 00       	call   80163b <sys_pf_calculate_allocated_pages>
  80029c:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80029f:	74 14                	je     8002b5 <_main+0x27d>
  8002a1:	83 ec 04             	sub    $0x4,%esp
  8002a4:	68 d4 1e 80 00       	push   $0x801ed4
  8002a9:	6a 44                	push   $0x44
  8002ab:	68 68 1d 80 00       	push   $0x801d68
  8002b0:	e8 6b 01 00 00       	call   800420 <_panic>

		cprintf("STEP B passed: Dealing with page file works!\n\n\n");
  8002b5:	83 ec 0c             	sub    $0xc,%esp
  8002b8:	68 4c 1f 80 00       	push   $0x801f4c
  8002bd:	e8 00 04 00 00       	call   8006c2 <cprintf>
  8002c2:	83 c4 10             	add    $0x10,%esp

	}
	cprintf("Congratulations!! test table replacement (BASIC Operations) completed successfully.\n");
  8002c5:	83 ec 0c             	sub    $0xc,%esp
  8002c8:	68 7c 1f 80 00       	push   $0x801f7c
  8002cd:	e8 f0 03 00 00       	call   8006c2 <cprintf>
  8002d2:	83 c4 10             	add    $0x10,%esp
	return;
  8002d5:	90                   	nop
}
  8002d6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8002d9:	c9                   	leave  
  8002da:	c3                   	ret    

008002db <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8002db:	55                   	push   %ebp
  8002dc:	89 e5                	mov    %esp,%ebp
  8002de:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8002e1:	e8 07 12 00 00       	call   8014ed <sys_getenvindex>
  8002e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8002e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8002ec:	89 d0                	mov    %edx,%eax
  8002ee:	c1 e0 03             	shl    $0x3,%eax
  8002f1:	01 d0                	add    %edx,%eax
  8002f3:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8002fa:	01 c8                	add    %ecx,%eax
  8002fc:	01 c0                	add    %eax,%eax
  8002fe:	01 d0                	add    %edx,%eax
  800300:	01 c0                	add    %eax,%eax
  800302:	01 d0                	add    %edx,%eax
  800304:	89 c2                	mov    %eax,%edx
  800306:	c1 e2 05             	shl    $0x5,%edx
  800309:	29 c2                	sub    %eax,%edx
  80030b:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800312:	89 c2                	mov    %eax,%edx
  800314:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80031a:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80031f:	a1 20 30 80 00       	mov    0x803020,%eax
  800324:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80032a:	84 c0                	test   %al,%al
  80032c:	74 0f                	je     80033d <libmain+0x62>
		binaryname = myEnv->prog_name;
  80032e:	a1 20 30 80 00       	mov    0x803020,%eax
  800333:	05 40 3c 01 00       	add    $0x13c40,%eax
  800338:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80033d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800341:	7e 0a                	jle    80034d <libmain+0x72>
		binaryname = argv[0];
  800343:	8b 45 0c             	mov    0xc(%ebp),%eax
  800346:	8b 00                	mov    (%eax),%eax
  800348:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  80034d:	83 ec 08             	sub    $0x8,%esp
  800350:	ff 75 0c             	pushl  0xc(%ebp)
  800353:	ff 75 08             	pushl  0x8(%ebp)
  800356:	e8 dd fc ff ff       	call   800038 <_main>
  80035b:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80035e:	e8 25 13 00 00       	call   801688 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800363:	83 ec 0c             	sub    $0xc,%esp
  800366:	68 ec 1f 80 00       	push   $0x801fec
  80036b:	e8 52 03 00 00       	call   8006c2 <cprintf>
  800370:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800373:	a1 20 30 80 00       	mov    0x803020,%eax
  800378:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80037e:	a1 20 30 80 00       	mov    0x803020,%eax
  800383:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800389:	83 ec 04             	sub    $0x4,%esp
  80038c:	52                   	push   %edx
  80038d:	50                   	push   %eax
  80038e:	68 14 20 80 00       	push   $0x802014
  800393:	e8 2a 03 00 00       	call   8006c2 <cprintf>
  800398:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80039b:	a1 20 30 80 00       	mov    0x803020,%eax
  8003a0:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8003a6:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ab:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8003b1:	83 ec 04             	sub    $0x4,%esp
  8003b4:	52                   	push   %edx
  8003b5:	50                   	push   %eax
  8003b6:	68 3c 20 80 00       	push   $0x80203c
  8003bb:	e8 02 03 00 00       	call   8006c2 <cprintf>
  8003c0:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8003c3:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c8:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8003ce:	83 ec 08             	sub    $0x8,%esp
  8003d1:	50                   	push   %eax
  8003d2:	68 7d 20 80 00       	push   $0x80207d
  8003d7:	e8 e6 02 00 00       	call   8006c2 <cprintf>
  8003dc:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8003df:	83 ec 0c             	sub    $0xc,%esp
  8003e2:	68 ec 1f 80 00       	push   $0x801fec
  8003e7:	e8 d6 02 00 00       	call   8006c2 <cprintf>
  8003ec:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8003ef:	e8 ae 12 00 00       	call   8016a2 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8003f4:	e8 19 00 00 00       	call   800412 <exit>
}
  8003f9:	90                   	nop
  8003fa:	c9                   	leave  
  8003fb:	c3                   	ret    

008003fc <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8003fc:	55                   	push   %ebp
  8003fd:	89 e5                	mov    %esp,%ebp
  8003ff:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800402:	83 ec 0c             	sub    $0xc,%esp
  800405:	6a 00                	push   $0x0
  800407:	e8 ad 10 00 00       	call   8014b9 <sys_env_destroy>
  80040c:	83 c4 10             	add    $0x10,%esp
}
  80040f:	90                   	nop
  800410:	c9                   	leave  
  800411:	c3                   	ret    

00800412 <exit>:

void
exit(void)
{
  800412:	55                   	push   %ebp
  800413:	89 e5                	mov    %esp,%ebp
  800415:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800418:	e8 02 11 00 00       	call   80151f <sys_env_exit>
}
  80041d:	90                   	nop
  80041e:	c9                   	leave  
  80041f:	c3                   	ret    

00800420 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800420:	55                   	push   %ebp
  800421:	89 e5                	mov    %esp,%ebp
  800423:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800426:	8d 45 10             	lea    0x10(%ebp),%eax
  800429:	83 c0 04             	add    $0x4,%eax
  80042c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80042f:	a1 18 31 80 00       	mov    0x803118,%eax
  800434:	85 c0                	test   %eax,%eax
  800436:	74 16                	je     80044e <_panic+0x2e>
		cprintf("%s: ", argv0);
  800438:	a1 18 31 80 00       	mov    0x803118,%eax
  80043d:	83 ec 08             	sub    $0x8,%esp
  800440:	50                   	push   %eax
  800441:	68 94 20 80 00       	push   $0x802094
  800446:	e8 77 02 00 00       	call   8006c2 <cprintf>
  80044b:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80044e:	a1 04 30 80 00       	mov    0x803004,%eax
  800453:	ff 75 0c             	pushl  0xc(%ebp)
  800456:	ff 75 08             	pushl  0x8(%ebp)
  800459:	50                   	push   %eax
  80045a:	68 99 20 80 00       	push   $0x802099
  80045f:	e8 5e 02 00 00       	call   8006c2 <cprintf>
  800464:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800467:	8b 45 10             	mov    0x10(%ebp),%eax
  80046a:	83 ec 08             	sub    $0x8,%esp
  80046d:	ff 75 f4             	pushl  -0xc(%ebp)
  800470:	50                   	push   %eax
  800471:	e8 e1 01 00 00       	call   800657 <vcprintf>
  800476:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800479:	83 ec 08             	sub    $0x8,%esp
  80047c:	6a 00                	push   $0x0
  80047e:	68 b5 20 80 00       	push   $0x8020b5
  800483:	e8 cf 01 00 00       	call   800657 <vcprintf>
  800488:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80048b:	e8 82 ff ff ff       	call   800412 <exit>

	// should not return here
	while (1) ;
  800490:	eb fe                	jmp    800490 <_panic+0x70>

00800492 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800492:	55                   	push   %ebp
  800493:	89 e5                	mov    %esp,%ebp
  800495:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800498:	a1 20 30 80 00       	mov    0x803020,%eax
  80049d:	8b 50 74             	mov    0x74(%eax),%edx
  8004a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004a3:	39 c2                	cmp    %eax,%edx
  8004a5:	74 14                	je     8004bb <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8004a7:	83 ec 04             	sub    $0x4,%esp
  8004aa:	68 b8 20 80 00       	push   $0x8020b8
  8004af:	6a 26                	push   $0x26
  8004b1:	68 04 21 80 00       	push   $0x802104
  8004b6:	e8 65 ff ff ff       	call   800420 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8004bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8004c2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8004c9:	e9 b6 00 00 00       	jmp    800584 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8004ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8004db:	01 d0                	add    %edx,%eax
  8004dd:	8b 00                	mov    (%eax),%eax
  8004df:	85 c0                	test   %eax,%eax
  8004e1:	75 08                	jne    8004eb <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8004e3:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8004e6:	e9 96 00 00 00       	jmp    800581 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8004eb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004f2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8004f9:	eb 5d                	jmp    800558 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8004fb:	a1 20 30 80 00       	mov    0x803020,%eax
  800500:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800506:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800509:	c1 e2 04             	shl    $0x4,%edx
  80050c:	01 d0                	add    %edx,%eax
  80050e:	8a 40 04             	mov    0x4(%eax),%al
  800511:	84 c0                	test   %al,%al
  800513:	75 40                	jne    800555 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800515:	a1 20 30 80 00       	mov    0x803020,%eax
  80051a:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800520:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800523:	c1 e2 04             	shl    $0x4,%edx
  800526:	01 d0                	add    %edx,%eax
  800528:	8b 00                	mov    (%eax),%eax
  80052a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80052d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800530:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800535:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800537:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80053a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800541:	8b 45 08             	mov    0x8(%ebp),%eax
  800544:	01 c8                	add    %ecx,%eax
  800546:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800548:	39 c2                	cmp    %eax,%edx
  80054a:	75 09                	jne    800555 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80054c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800553:	eb 12                	jmp    800567 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800555:	ff 45 e8             	incl   -0x18(%ebp)
  800558:	a1 20 30 80 00       	mov    0x803020,%eax
  80055d:	8b 50 74             	mov    0x74(%eax),%edx
  800560:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800563:	39 c2                	cmp    %eax,%edx
  800565:	77 94                	ja     8004fb <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800567:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80056b:	75 14                	jne    800581 <CheckWSWithoutLastIndex+0xef>
			panic(
  80056d:	83 ec 04             	sub    $0x4,%esp
  800570:	68 10 21 80 00       	push   $0x802110
  800575:	6a 3a                	push   $0x3a
  800577:	68 04 21 80 00       	push   $0x802104
  80057c:	e8 9f fe ff ff       	call   800420 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800581:	ff 45 f0             	incl   -0x10(%ebp)
  800584:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800587:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80058a:	0f 8c 3e ff ff ff    	jl     8004ce <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800590:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800597:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80059e:	eb 20                	jmp    8005c0 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8005a0:	a1 20 30 80 00       	mov    0x803020,%eax
  8005a5:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8005ab:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005ae:	c1 e2 04             	shl    $0x4,%edx
  8005b1:	01 d0                	add    %edx,%eax
  8005b3:	8a 40 04             	mov    0x4(%eax),%al
  8005b6:	3c 01                	cmp    $0x1,%al
  8005b8:	75 03                	jne    8005bd <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8005ba:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005bd:	ff 45 e0             	incl   -0x20(%ebp)
  8005c0:	a1 20 30 80 00       	mov    0x803020,%eax
  8005c5:	8b 50 74             	mov    0x74(%eax),%edx
  8005c8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005cb:	39 c2                	cmp    %eax,%edx
  8005cd:	77 d1                	ja     8005a0 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8005cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005d2:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8005d5:	74 14                	je     8005eb <CheckWSWithoutLastIndex+0x159>
		panic(
  8005d7:	83 ec 04             	sub    $0x4,%esp
  8005da:	68 64 21 80 00       	push   $0x802164
  8005df:	6a 44                	push   $0x44
  8005e1:	68 04 21 80 00       	push   $0x802104
  8005e6:	e8 35 fe ff ff       	call   800420 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8005eb:	90                   	nop
  8005ec:	c9                   	leave  
  8005ed:	c3                   	ret    

008005ee <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8005ee:	55                   	push   %ebp
  8005ef:	89 e5                	mov    %esp,%ebp
  8005f1:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8005f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005f7:	8b 00                	mov    (%eax),%eax
  8005f9:	8d 48 01             	lea    0x1(%eax),%ecx
  8005fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8005ff:	89 0a                	mov    %ecx,(%edx)
  800601:	8b 55 08             	mov    0x8(%ebp),%edx
  800604:	88 d1                	mov    %dl,%cl
  800606:	8b 55 0c             	mov    0xc(%ebp),%edx
  800609:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80060d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800610:	8b 00                	mov    (%eax),%eax
  800612:	3d ff 00 00 00       	cmp    $0xff,%eax
  800617:	75 2c                	jne    800645 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800619:	a0 24 30 80 00       	mov    0x803024,%al
  80061e:	0f b6 c0             	movzbl %al,%eax
  800621:	8b 55 0c             	mov    0xc(%ebp),%edx
  800624:	8b 12                	mov    (%edx),%edx
  800626:	89 d1                	mov    %edx,%ecx
  800628:	8b 55 0c             	mov    0xc(%ebp),%edx
  80062b:	83 c2 08             	add    $0x8,%edx
  80062e:	83 ec 04             	sub    $0x4,%esp
  800631:	50                   	push   %eax
  800632:	51                   	push   %ecx
  800633:	52                   	push   %edx
  800634:	e8 3e 0e 00 00       	call   801477 <sys_cputs>
  800639:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80063c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80063f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800645:	8b 45 0c             	mov    0xc(%ebp),%eax
  800648:	8b 40 04             	mov    0x4(%eax),%eax
  80064b:	8d 50 01             	lea    0x1(%eax),%edx
  80064e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800651:	89 50 04             	mov    %edx,0x4(%eax)
}
  800654:	90                   	nop
  800655:	c9                   	leave  
  800656:	c3                   	ret    

00800657 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800657:	55                   	push   %ebp
  800658:	89 e5                	mov    %esp,%ebp
  80065a:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800660:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800667:	00 00 00 
	b.cnt = 0;
  80066a:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800671:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800674:	ff 75 0c             	pushl  0xc(%ebp)
  800677:	ff 75 08             	pushl  0x8(%ebp)
  80067a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800680:	50                   	push   %eax
  800681:	68 ee 05 80 00       	push   $0x8005ee
  800686:	e8 11 02 00 00       	call   80089c <vprintfmt>
  80068b:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80068e:	a0 24 30 80 00       	mov    0x803024,%al
  800693:	0f b6 c0             	movzbl %al,%eax
  800696:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80069c:	83 ec 04             	sub    $0x4,%esp
  80069f:	50                   	push   %eax
  8006a0:	52                   	push   %edx
  8006a1:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006a7:	83 c0 08             	add    $0x8,%eax
  8006aa:	50                   	push   %eax
  8006ab:	e8 c7 0d 00 00       	call   801477 <sys_cputs>
  8006b0:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8006b3:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8006ba:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8006c0:	c9                   	leave  
  8006c1:	c3                   	ret    

008006c2 <cprintf>:

int cprintf(const char *fmt, ...) {
  8006c2:	55                   	push   %ebp
  8006c3:	89 e5                	mov    %esp,%ebp
  8006c5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8006c8:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8006cf:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8006d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d8:	83 ec 08             	sub    $0x8,%esp
  8006db:	ff 75 f4             	pushl  -0xc(%ebp)
  8006de:	50                   	push   %eax
  8006df:	e8 73 ff ff ff       	call   800657 <vcprintf>
  8006e4:	83 c4 10             	add    $0x10,%esp
  8006e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8006ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8006ed:	c9                   	leave  
  8006ee:	c3                   	ret    

008006ef <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8006ef:	55                   	push   %ebp
  8006f0:	89 e5                	mov    %esp,%ebp
  8006f2:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8006f5:	e8 8e 0f 00 00       	call   801688 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8006fa:	8d 45 0c             	lea    0xc(%ebp),%eax
  8006fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800700:	8b 45 08             	mov    0x8(%ebp),%eax
  800703:	83 ec 08             	sub    $0x8,%esp
  800706:	ff 75 f4             	pushl  -0xc(%ebp)
  800709:	50                   	push   %eax
  80070a:	e8 48 ff ff ff       	call   800657 <vcprintf>
  80070f:	83 c4 10             	add    $0x10,%esp
  800712:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800715:	e8 88 0f 00 00       	call   8016a2 <sys_enable_interrupt>
	return cnt;
  80071a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80071d:	c9                   	leave  
  80071e:	c3                   	ret    

0080071f <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80071f:	55                   	push   %ebp
  800720:	89 e5                	mov    %esp,%ebp
  800722:	53                   	push   %ebx
  800723:	83 ec 14             	sub    $0x14,%esp
  800726:	8b 45 10             	mov    0x10(%ebp),%eax
  800729:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80072c:	8b 45 14             	mov    0x14(%ebp),%eax
  80072f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800732:	8b 45 18             	mov    0x18(%ebp),%eax
  800735:	ba 00 00 00 00       	mov    $0x0,%edx
  80073a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80073d:	77 55                	ja     800794 <printnum+0x75>
  80073f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800742:	72 05                	jb     800749 <printnum+0x2a>
  800744:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800747:	77 4b                	ja     800794 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800749:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80074c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80074f:	8b 45 18             	mov    0x18(%ebp),%eax
  800752:	ba 00 00 00 00       	mov    $0x0,%edx
  800757:	52                   	push   %edx
  800758:	50                   	push   %eax
  800759:	ff 75 f4             	pushl  -0xc(%ebp)
  80075c:	ff 75 f0             	pushl  -0x10(%ebp)
  80075f:	e8 48 13 00 00       	call   801aac <__udivdi3>
  800764:	83 c4 10             	add    $0x10,%esp
  800767:	83 ec 04             	sub    $0x4,%esp
  80076a:	ff 75 20             	pushl  0x20(%ebp)
  80076d:	53                   	push   %ebx
  80076e:	ff 75 18             	pushl  0x18(%ebp)
  800771:	52                   	push   %edx
  800772:	50                   	push   %eax
  800773:	ff 75 0c             	pushl  0xc(%ebp)
  800776:	ff 75 08             	pushl  0x8(%ebp)
  800779:	e8 a1 ff ff ff       	call   80071f <printnum>
  80077e:	83 c4 20             	add    $0x20,%esp
  800781:	eb 1a                	jmp    80079d <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800783:	83 ec 08             	sub    $0x8,%esp
  800786:	ff 75 0c             	pushl  0xc(%ebp)
  800789:	ff 75 20             	pushl  0x20(%ebp)
  80078c:	8b 45 08             	mov    0x8(%ebp),%eax
  80078f:	ff d0                	call   *%eax
  800791:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800794:	ff 4d 1c             	decl   0x1c(%ebp)
  800797:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80079b:	7f e6                	jg     800783 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80079d:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8007a0:	bb 00 00 00 00       	mov    $0x0,%ebx
  8007a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007a8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007ab:	53                   	push   %ebx
  8007ac:	51                   	push   %ecx
  8007ad:	52                   	push   %edx
  8007ae:	50                   	push   %eax
  8007af:	e8 08 14 00 00       	call   801bbc <__umoddi3>
  8007b4:	83 c4 10             	add    $0x10,%esp
  8007b7:	05 d4 23 80 00       	add    $0x8023d4,%eax
  8007bc:	8a 00                	mov    (%eax),%al
  8007be:	0f be c0             	movsbl %al,%eax
  8007c1:	83 ec 08             	sub    $0x8,%esp
  8007c4:	ff 75 0c             	pushl  0xc(%ebp)
  8007c7:	50                   	push   %eax
  8007c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cb:	ff d0                	call   *%eax
  8007cd:	83 c4 10             	add    $0x10,%esp
}
  8007d0:	90                   	nop
  8007d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8007d4:	c9                   	leave  
  8007d5:	c3                   	ret    

008007d6 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8007d6:	55                   	push   %ebp
  8007d7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8007d9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8007dd:	7e 1c                	jle    8007fb <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8007df:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e2:	8b 00                	mov    (%eax),%eax
  8007e4:	8d 50 08             	lea    0x8(%eax),%edx
  8007e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ea:	89 10                	mov    %edx,(%eax)
  8007ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ef:	8b 00                	mov    (%eax),%eax
  8007f1:	83 e8 08             	sub    $0x8,%eax
  8007f4:	8b 50 04             	mov    0x4(%eax),%edx
  8007f7:	8b 00                	mov    (%eax),%eax
  8007f9:	eb 40                	jmp    80083b <getuint+0x65>
	else if (lflag)
  8007fb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8007ff:	74 1e                	je     80081f <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800801:	8b 45 08             	mov    0x8(%ebp),%eax
  800804:	8b 00                	mov    (%eax),%eax
  800806:	8d 50 04             	lea    0x4(%eax),%edx
  800809:	8b 45 08             	mov    0x8(%ebp),%eax
  80080c:	89 10                	mov    %edx,(%eax)
  80080e:	8b 45 08             	mov    0x8(%ebp),%eax
  800811:	8b 00                	mov    (%eax),%eax
  800813:	83 e8 04             	sub    $0x4,%eax
  800816:	8b 00                	mov    (%eax),%eax
  800818:	ba 00 00 00 00       	mov    $0x0,%edx
  80081d:	eb 1c                	jmp    80083b <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80081f:	8b 45 08             	mov    0x8(%ebp),%eax
  800822:	8b 00                	mov    (%eax),%eax
  800824:	8d 50 04             	lea    0x4(%eax),%edx
  800827:	8b 45 08             	mov    0x8(%ebp),%eax
  80082a:	89 10                	mov    %edx,(%eax)
  80082c:	8b 45 08             	mov    0x8(%ebp),%eax
  80082f:	8b 00                	mov    (%eax),%eax
  800831:	83 e8 04             	sub    $0x4,%eax
  800834:	8b 00                	mov    (%eax),%eax
  800836:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80083b:	5d                   	pop    %ebp
  80083c:	c3                   	ret    

0080083d <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80083d:	55                   	push   %ebp
  80083e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800840:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800844:	7e 1c                	jle    800862 <getint+0x25>
		return va_arg(*ap, long long);
  800846:	8b 45 08             	mov    0x8(%ebp),%eax
  800849:	8b 00                	mov    (%eax),%eax
  80084b:	8d 50 08             	lea    0x8(%eax),%edx
  80084e:	8b 45 08             	mov    0x8(%ebp),%eax
  800851:	89 10                	mov    %edx,(%eax)
  800853:	8b 45 08             	mov    0x8(%ebp),%eax
  800856:	8b 00                	mov    (%eax),%eax
  800858:	83 e8 08             	sub    $0x8,%eax
  80085b:	8b 50 04             	mov    0x4(%eax),%edx
  80085e:	8b 00                	mov    (%eax),%eax
  800860:	eb 38                	jmp    80089a <getint+0x5d>
	else if (lflag)
  800862:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800866:	74 1a                	je     800882 <getint+0x45>
		return va_arg(*ap, long);
  800868:	8b 45 08             	mov    0x8(%ebp),%eax
  80086b:	8b 00                	mov    (%eax),%eax
  80086d:	8d 50 04             	lea    0x4(%eax),%edx
  800870:	8b 45 08             	mov    0x8(%ebp),%eax
  800873:	89 10                	mov    %edx,(%eax)
  800875:	8b 45 08             	mov    0x8(%ebp),%eax
  800878:	8b 00                	mov    (%eax),%eax
  80087a:	83 e8 04             	sub    $0x4,%eax
  80087d:	8b 00                	mov    (%eax),%eax
  80087f:	99                   	cltd   
  800880:	eb 18                	jmp    80089a <getint+0x5d>
	else
		return va_arg(*ap, int);
  800882:	8b 45 08             	mov    0x8(%ebp),%eax
  800885:	8b 00                	mov    (%eax),%eax
  800887:	8d 50 04             	lea    0x4(%eax),%edx
  80088a:	8b 45 08             	mov    0x8(%ebp),%eax
  80088d:	89 10                	mov    %edx,(%eax)
  80088f:	8b 45 08             	mov    0x8(%ebp),%eax
  800892:	8b 00                	mov    (%eax),%eax
  800894:	83 e8 04             	sub    $0x4,%eax
  800897:	8b 00                	mov    (%eax),%eax
  800899:	99                   	cltd   
}
  80089a:	5d                   	pop    %ebp
  80089b:	c3                   	ret    

0080089c <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80089c:	55                   	push   %ebp
  80089d:	89 e5                	mov    %esp,%ebp
  80089f:	56                   	push   %esi
  8008a0:	53                   	push   %ebx
  8008a1:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008a4:	eb 17                	jmp    8008bd <vprintfmt+0x21>
			if (ch == '\0')
  8008a6:	85 db                	test   %ebx,%ebx
  8008a8:	0f 84 af 03 00 00    	je     800c5d <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8008ae:	83 ec 08             	sub    $0x8,%esp
  8008b1:	ff 75 0c             	pushl  0xc(%ebp)
  8008b4:	53                   	push   %ebx
  8008b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b8:	ff d0                	call   *%eax
  8008ba:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8008c0:	8d 50 01             	lea    0x1(%eax),%edx
  8008c3:	89 55 10             	mov    %edx,0x10(%ebp)
  8008c6:	8a 00                	mov    (%eax),%al
  8008c8:	0f b6 d8             	movzbl %al,%ebx
  8008cb:	83 fb 25             	cmp    $0x25,%ebx
  8008ce:	75 d6                	jne    8008a6 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8008d0:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8008d4:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8008db:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8008e2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8008e9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8008f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8008f3:	8d 50 01             	lea    0x1(%eax),%edx
  8008f6:	89 55 10             	mov    %edx,0x10(%ebp)
  8008f9:	8a 00                	mov    (%eax),%al
  8008fb:	0f b6 d8             	movzbl %al,%ebx
  8008fe:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800901:	83 f8 55             	cmp    $0x55,%eax
  800904:	0f 87 2b 03 00 00    	ja     800c35 <vprintfmt+0x399>
  80090a:	8b 04 85 f8 23 80 00 	mov    0x8023f8(,%eax,4),%eax
  800911:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800913:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800917:	eb d7                	jmp    8008f0 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800919:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80091d:	eb d1                	jmp    8008f0 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80091f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800926:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800929:	89 d0                	mov    %edx,%eax
  80092b:	c1 e0 02             	shl    $0x2,%eax
  80092e:	01 d0                	add    %edx,%eax
  800930:	01 c0                	add    %eax,%eax
  800932:	01 d8                	add    %ebx,%eax
  800934:	83 e8 30             	sub    $0x30,%eax
  800937:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80093a:	8b 45 10             	mov    0x10(%ebp),%eax
  80093d:	8a 00                	mov    (%eax),%al
  80093f:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800942:	83 fb 2f             	cmp    $0x2f,%ebx
  800945:	7e 3e                	jle    800985 <vprintfmt+0xe9>
  800947:	83 fb 39             	cmp    $0x39,%ebx
  80094a:	7f 39                	jg     800985 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80094c:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80094f:	eb d5                	jmp    800926 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800951:	8b 45 14             	mov    0x14(%ebp),%eax
  800954:	83 c0 04             	add    $0x4,%eax
  800957:	89 45 14             	mov    %eax,0x14(%ebp)
  80095a:	8b 45 14             	mov    0x14(%ebp),%eax
  80095d:	83 e8 04             	sub    $0x4,%eax
  800960:	8b 00                	mov    (%eax),%eax
  800962:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800965:	eb 1f                	jmp    800986 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800967:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80096b:	79 83                	jns    8008f0 <vprintfmt+0x54>
				width = 0;
  80096d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800974:	e9 77 ff ff ff       	jmp    8008f0 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800979:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800980:	e9 6b ff ff ff       	jmp    8008f0 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800985:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800986:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80098a:	0f 89 60 ff ff ff    	jns    8008f0 <vprintfmt+0x54>
				width = precision, precision = -1;
  800990:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800993:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800996:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80099d:	e9 4e ff ff ff       	jmp    8008f0 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8009a2:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8009a5:	e9 46 ff ff ff       	jmp    8008f0 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8009aa:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ad:	83 c0 04             	add    $0x4,%eax
  8009b0:	89 45 14             	mov    %eax,0x14(%ebp)
  8009b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8009b6:	83 e8 04             	sub    $0x4,%eax
  8009b9:	8b 00                	mov    (%eax),%eax
  8009bb:	83 ec 08             	sub    $0x8,%esp
  8009be:	ff 75 0c             	pushl  0xc(%ebp)
  8009c1:	50                   	push   %eax
  8009c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c5:	ff d0                	call   *%eax
  8009c7:	83 c4 10             	add    $0x10,%esp
			break;
  8009ca:	e9 89 02 00 00       	jmp    800c58 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8009cf:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d2:	83 c0 04             	add    $0x4,%eax
  8009d5:	89 45 14             	mov    %eax,0x14(%ebp)
  8009d8:	8b 45 14             	mov    0x14(%ebp),%eax
  8009db:	83 e8 04             	sub    $0x4,%eax
  8009de:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8009e0:	85 db                	test   %ebx,%ebx
  8009e2:	79 02                	jns    8009e6 <vprintfmt+0x14a>
				err = -err;
  8009e4:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8009e6:	83 fb 64             	cmp    $0x64,%ebx
  8009e9:	7f 0b                	jg     8009f6 <vprintfmt+0x15a>
  8009eb:	8b 34 9d 40 22 80 00 	mov    0x802240(,%ebx,4),%esi
  8009f2:	85 f6                	test   %esi,%esi
  8009f4:	75 19                	jne    800a0f <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8009f6:	53                   	push   %ebx
  8009f7:	68 e5 23 80 00       	push   $0x8023e5
  8009fc:	ff 75 0c             	pushl  0xc(%ebp)
  8009ff:	ff 75 08             	pushl  0x8(%ebp)
  800a02:	e8 5e 02 00 00       	call   800c65 <printfmt>
  800a07:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a0a:	e9 49 02 00 00       	jmp    800c58 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800a0f:	56                   	push   %esi
  800a10:	68 ee 23 80 00       	push   $0x8023ee
  800a15:	ff 75 0c             	pushl  0xc(%ebp)
  800a18:	ff 75 08             	pushl  0x8(%ebp)
  800a1b:	e8 45 02 00 00       	call   800c65 <printfmt>
  800a20:	83 c4 10             	add    $0x10,%esp
			break;
  800a23:	e9 30 02 00 00       	jmp    800c58 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a28:	8b 45 14             	mov    0x14(%ebp),%eax
  800a2b:	83 c0 04             	add    $0x4,%eax
  800a2e:	89 45 14             	mov    %eax,0x14(%ebp)
  800a31:	8b 45 14             	mov    0x14(%ebp),%eax
  800a34:	83 e8 04             	sub    $0x4,%eax
  800a37:	8b 30                	mov    (%eax),%esi
  800a39:	85 f6                	test   %esi,%esi
  800a3b:	75 05                	jne    800a42 <vprintfmt+0x1a6>
				p = "(null)";
  800a3d:	be f1 23 80 00       	mov    $0x8023f1,%esi
			if (width > 0 && padc != '-')
  800a42:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a46:	7e 6d                	jle    800ab5 <vprintfmt+0x219>
  800a48:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a4c:	74 67                	je     800ab5 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a4e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a51:	83 ec 08             	sub    $0x8,%esp
  800a54:	50                   	push   %eax
  800a55:	56                   	push   %esi
  800a56:	e8 0c 03 00 00       	call   800d67 <strnlen>
  800a5b:	83 c4 10             	add    $0x10,%esp
  800a5e:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800a61:	eb 16                	jmp    800a79 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800a63:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800a67:	83 ec 08             	sub    $0x8,%esp
  800a6a:	ff 75 0c             	pushl  0xc(%ebp)
  800a6d:	50                   	push   %eax
  800a6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a71:	ff d0                	call   *%eax
  800a73:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800a76:	ff 4d e4             	decl   -0x1c(%ebp)
  800a79:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a7d:	7f e4                	jg     800a63 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800a7f:	eb 34                	jmp    800ab5 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800a81:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800a85:	74 1c                	je     800aa3 <vprintfmt+0x207>
  800a87:	83 fb 1f             	cmp    $0x1f,%ebx
  800a8a:	7e 05                	jle    800a91 <vprintfmt+0x1f5>
  800a8c:	83 fb 7e             	cmp    $0x7e,%ebx
  800a8f:	7e 12                	jle    800aa3 <vprintfmt+0x207>
					putch('?', putdat);
  800a91:	83 ec 08             	sub    $0x8,%esp
  800a94:	ff 75 0c             	pushl  0xc(%ebp)
  800a97:	6a 3f                	push   $0x3f
  800a99:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9c:	ff d0                	call   *%eax
  800a9e:	83 c4 10             	add    $0x10,%esp
  800aa1:	eb 0f                	jmp    800ab2 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800aa3:	83 ec 08             	sub    $0x8,%esp
  800aa6:	ff 75 0c             	pushl  0xc(%ebp)
  800aa9:	53                   	push   %ebx
  800aaa:	8b 45 08             	mov    0x8(%ebp),%eax
  800aad:	ff d0                	call   *%eax
  800aaf:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800ab2:	ff 4d e4             	decl   -0x1c(%ebp)
  800ab5:	89 f0                	mov    %esi,%eax
  800ab7:	8d 70 01             	lea    0x1(%eax),%esi
  800aba:	8a 00                	mov    (%eax),%al
  800abc:	0f be d8             	movsbl %al,%ebx
  800abf:	85 db                	test   %ebx,%ebx
  800ac1:	74 24                	je     800ae7 <vprintfmt+0x24b>
  800ac3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ac7:	78 b8                	js     800a81 <vprintfmt+0x1e5>
  800ac9:	ff 4d e0             	decl   -0x20(%ebp)
  800acc:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ad0:	79 af                	jns    800a81 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ad2:	eb 13                	jmp    800ae7 <vprintfmt+0x24b>
				putch(' ', putdat);
  800ad4:	83 ec 08             	sub    $0x8,%esp
  800ad7:	ff 75 0c             	pushl  0xc(%ebp)
  800ada:	6a 20                	push   $0x20
  800adc:	8b 45 08             	mov    0x8(%ebp),%eax
  800adf:	ff d0                	call   *%eax
  800ae1:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ae4:	ff 4d e4             	decl   -0x1c(%ebp)
  800ae7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800aeb:	7f e7                	jg     800ad4 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800aed:	e9 66 01 00 00       	jmp    800c58 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800af2:	83 ec 08             	sub    $0x8,%esp
  800af5:	ff 75 e8             	pushl  -0x18(%ebp)
  800af8:	8d 45 14             	lea    0x14(%ebp),%eax
  800afb:	50                   	push   %eax
  800afc:	e8 3c fd ff ff       	call   80083d <getint>
  800b01:	83 c4 10             	add    $0x10,%esp
  800b04:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b07:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b0d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b10:	85 d2                	test   %edx,%edx
  800b12:	79 23                	jns    800b37 <vprintfmt+0x29b>
				putch('-', putdat);
  800b14:	83 ec 08             	sub    $0x8,%esp
  800b17:	ff 75 0c             	pushl  0xc(%ebp)
  800b1a:	6a 2d                	push   $0x2d
  800b1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1f:	ff d0                	call   *%eax
  800b21:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b24:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b27:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b2a:	f7 d8                	neg    %eax
  800b2c:	83 d2 00             	adc    $0x0,%edx
  800b2f:	f7 da                	neg    %edx
  800b31:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b34:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b37:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b3e:	e9 bc 00 00 00       	jmp    800bff <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b43:	83 ec 08             	sub    $0x8,%esp
  800b46:	ff 75 e8             	pushl  -0x18(%ebp)
  800b49:	8d 45 14             	lea    0x14(%ebp),%eax
  800b4c:	50                   	push   %eax
  800b4d:	e8 84 fc ff ff       	call   8007d6 <getuint>
  800b52:	83 c4 10             	add    $0x10,%esp
  800b55:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b58:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b5b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b62:	e9 98 00 00 00       	jmp    800bff <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800b67:	83 ec 08             	sub    $0x8,%esp
  800b6a:	ff 75 0c             	pushl  0xc(%ebp)
  800b6d:	6a 58                	push   $0x58
  800b6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b72:	ff d0                	call   *%eax
  800b74:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b77:	83 ec 08             	sub    $0x8,%esp
  800b7a:	ff 75 0c             	pushl  0xc(%ebp)
  800b7d:	6a 58                	push   $0x58
  800b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b82:	ff d0                	call   *%eax
  800b84:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800b87:	83 ec 08             	sub    $0x8,%esp
  800b8a:	ff 75 0c             	pushl  0xc(%ebp)
  800b8d:	6a 58                	push   $0x58
  800b8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b92:	ff d0                	call   *%eax
  800b94:	83 c4 10             	add    $0x10,%esp
			break;
  800b97:	e9 bc 00 00 00       	jmp    800c58 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800b9c:	83 ec 08             	sub    $0x8,%esp
  800b9f:	ff 75 0c             	pushl  0xc(%ebp)
  800ba2:	6a 30                	push   $0x30
  800ba4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba7:	ff d0                	call   *%eax
  800ba9:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800bac:	83 ec 08             	sub    $0x8,%esp
  800baf:	ff 75 0c             	pushl  0xc(%ebp)
  800bb2:	6a 78                	push   $0x78
  800bb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb7:	ff d0                	call   *%eax
  800bb9:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800bbc:	8b 45 14             	mov    0x14(%ebp),%eax
  800bbf:	83 c0 04             	add    $0x4,%eax
  800bc2:	89 45 14             	mov    %eax,0x14(%ebp)
  800bc5:	8b 45 14             	mov    0x14(%ebp),%eax
  800bc8:	83 e8 04             	sub    $0x4,%eax
  800bcb:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800bcd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bd0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800bd7:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800bde:	eb 1f                	jmp    800bff <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800be0:	83 ec 08             	sub    $0x8,%esp
  800be3:	ff 75 e8             	pushl  -0x18(%ebp)
  800be6:	8d 45 14             	lea    0x14(%ebp),%eax
  800be9:	50                   	push   %eax
  800bea:	e8 e7 fb ff ff       	call   8007d6 <getuint>
  800bef:	83 c4 10             	add    $0x10,%esp
  800bf2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bf5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800bf8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800bff:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c03:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c06:	83 ec 04             	sub    $0x4,%esp
  800c09:	52                   	push   %edx
  800c0a:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c0d:	50                   	push   %eax
  800c0e:	ff 75 f4             	pushl  -0xc(%ebp)
  800c11:	ff 75 f0             	pushl  -0x10(%ebp)
  800c14:	ff 75 0c             	pushl  0xc(%ebp)
  800c17:	ff 75 08             	pushl  0x8(%ebp)
  800c1a:	e8 00 fb ff ff       	call   80071f <printnum>
  800c1f:	83 c4 20             	add    $0x20,%esp
			break;
  800c22:	eb 34                	jmp    800c58 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c24:	83 ec 08             	sub    $0x8,%esp
  800c27:	ff 75 0c             	pushl  0xc(%ebp)
  800c2a:	53                   	push   %ebx
  800c2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2e:	ff d0                	call   *%eax
  800c30:	83 c4 10             	add    $0x10,%esp
			break;
  800c33:	eb 23                	jmp    800c58 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c35:	83 ec 08             	sub    $0x8,%esp
  800c38:	ff 75 0c             	pushl  0xc(%ebp)
  800c3b:	6a 25                	push   $0x25
  800c3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c40:	ff d0                	call   *%eax
  800c42:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c45:	ff 4d 10             	decl   0x10(%ebp)
  800c48:	eb 03                	jmp    800c4d <vprintfmt+0x3b1>
  800c4a:	ff 4d 10             	decl   0x10(%ebp)
  800c4d:	8b 45 10             	mov    0x10(%ebp),%eax
  800c50:	48                   	dec    %eax
  800c51:	8a 00                	mov    (%eax),%al
  800c53:	3c 25                	cmp    $0x25,%al
  800c55:	75 f3                	jne    800c4a <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800c57:	90                   	nop
		}
	}
  800c58:	e9 47 fc ff ff       	jmp    8008a4 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c5d:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c5e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800c61:	5b                   	pop    %ebx
  800c62:	5e                   	pop    %esi
  800c63:	5d                   	pop    %ebp
  800c64:	c3                   	ret    

00800c65 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800c65:	55                   	push   %ebp
  800c66:	89 e5                	mov    %esp,%ebp
  800c68:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800c6b:	8d 45 10             	lea    0x10(%ebp),%eax
  800c6e:	83 c0 04             	add    $0x4,%eax
  800c71:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800c74:	8b 45 10             	mov    0x10(%ebp),%eax
  800c77:	ff 75 f4             	pushl  -0xc(%ebp)
  800c7a:	50                   	push   %eax
  800c7b:	ff 75 0c             	pushl  0xc(%ebp)
  800c7e:	ff 75 08             	pushl  0x8(%ebp)
  800c81:	e8 16 fc ff ff       	call   80089c <vprintfmt>
  800c86:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800c89:	90                   	nop
  800c8a:	c9                   	leave  
  800c8b:	c3                   	ret    

00800c8c <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800c8c:	55                   	push   %ebp
  800c8d:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800c8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c92:	8b 40 08             	mov    0x8(%eax),%eax
  800c95:	8d 50 01             	lea    0x1(%eax),%edx
  800c98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c9b:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800c9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca1:	8b 10                	mov    (%eax),%edx
  800ca3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca6:	8b 40 04             	mov    0x4(%eax),%eax
  800ca9:	39 c2                	cmp    %eax,%edx
  800cab:	73 12                	jae    800cbf <sprintputch+0x33>
		*b->buf++ = ch;
  800cad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cb0:	8b 00                	mov    (%eax),%eax
  800cb2:	8d 48 01             	lea    0x1(%eax),%ecx
  800cb5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cb8:	89 0a                	mov    %ecx,(%edx)
  800cba:	8b 55 08             	mov    0x8(%ebp),%edx
  800cbd:	88 10                	mov    %dl,(%eax)
}
  800cbf:	90                   	nop
  800cc0:	5d                   	pop    %ebp
  800cc1:	c3                   	ret    

00800cc2 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800cc2:	55                   	push   %ebp
  800cc3:	89 e5                	mov    %esp,%ebp
  800cc5:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800cce:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd7:	01 d0                	add    %edx,%eax
  800cd9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cdc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800ce3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ce7:	74 06                	je     800cef <vsnprintf+0x2d>
  800ce9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ced:	7f 07                	jg     800cf6 <vsnprintf+0x34>
		return -E_INVAL;
  800cef:	b8 03 00 00 00       	mov    $0x3,%eax
  800cf4:	eb 20                	jmp    800d16 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800cf6:	ff 75 14             	pushl  0x14(%ebp)
  800cf9:	ff 75 10             	pushl  0x10(%ebp)
  800cfc:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800cff:	50                   	push   %eax
  800d00:	68 8c 0c 80 00       	push   $0x800c8c
  800d05:	e8 92 fb ff ff       	call   80089c <vprintfmt>
  800d0a:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d0d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d10:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d13:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d16:	c9                   	leave  
  800d17:	c3                   	ret    

00800d18 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d18:	55                   	push   %ebp
  800d19:	89 e5                	mov    %esp,%ebp
  800d1b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d1e:	8d 45 10             	lea    0x10(%ebp),%eax
  800d21:	83 c0 04             	add    $0x4,%eax
  800d24:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d27:	8b 45 10             	mov    0x10(%ebp),%eax
  800d2a:	ff 75 f4             	pushl  -0xc(%ebp)
  800d2d:	50                   	push   %eax
  800d2e:	ff 75 0c             	pushl  0xc(%ebp)
  800d31:	ff 75 08             	pushl  0x8(%ebp)
  800d34:	e8 89 ff ff ff       	call   800cc2 <vsnprintf>
  800d39:	83 c4 10             	add    $0x10,%esp
  800d3c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d42:	c9                   	leave  
  800d43:	c3                   	ret    

00800d44 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d44:	55                   	push   %ebp
  800d45:	89 e5                	mov    %esp,%ebp
  800d47:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d4a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d51:	eb 06                	jmp    800d59 <strlen+0x15>
		n++;
  800d53:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d56:	ff 45 08             	incl   0x8(%ebp)
  800d59:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5c:	8a 00                	mov    (%eax),%al
  800d5e:	84 c0                	test   %al,%al
  800d60:	75 f1                	jne    800d53 <strlen+0xf>
		n++;
	return n;
  800d62:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d65:	c9                   	leave  
  800d66:	c3                   	ret    

00800d67 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800d67:	55                   	push   %ebp
  800d68:	89 e5                	mov    %esp,%ebp
  800d6a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d6d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d74:	eb 09                	jmp    800d7f <strnlen+0x18>
		n++;
  800d76:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800d79:	ff 45 08             	incl   0x8(%ebp)
  800d7c:	ff 4d 0c             	decl   0xc(%ebp)
  800d7f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d83:	74 09                	je     800d8e <strnlen+0x27>
  800d85:	8b 45 08             	mov    0x8(%ebp),%eax
  800d88:	8a 00                	mov    (%eax),%al
  800d8a:	84 c0                	test   %al,%al
  800d8c:	75 e8                	jne    800d76 <strnlen+0xf>
		n++;
	return n;
  800d8e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800d91:	c9                   	leave  
  800d92:	c3                   	ret    

00800d93 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800d93:	55                   	push   %ebp
  800d94:	89 e5                	mov    %esp,%ebp
  800d96:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800d99:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800d9f:	90                   	nop
  800da0:	8b 45 08             	mov    0x8(%ebp),%eax
  800da3:	8d 50 01             	lea    0x1(%eax),%edx
  800da6:	89 55 08             	mov    %edx,0x8(%ebp)
  800da9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dac:	8d 4a 01             	lea    0x1(%edx),%ecx
  800daf:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800db2:	8a 12                	mov    (%edx),%dl
  800db4:	88 10                	mov    %dl,(%eax)
  800db6:	8a 00                	mov    (%eax),%al
  800db8:	84 c0                	test   %al,%al
  800dba:	75 e4                	jne    800da0 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800dbc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800dbf:	c9                   	leave  
  800dc0:	c3                   	ret    

00800dc1 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800dc1:	55                   	push   %ebp
  800dc2:	89 e5                	mov    %esp,%ebp
  800dc4:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800dc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dca:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800dcd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800dd4:	eb 1f                	jmp    800df5 <strncpy+0x34>
		*dst++ = *src;
  800dd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd9:	8d 50 01             	lea    0x1(%eax),%edx
  800ddc:	89 55 08             	mov    %edx,0x8(%ebp)
  800ddf:	8b 55 0c             	mov    0xc(%ebp),%edx
  800de2:	8a 12                	mov    (%edx),%dl
  800de4:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800de6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de9:	8a 00                	mov    (%eax),%al
  800deb:	84 c0                	test   %al,%al
  800ded:	74 03                	je     800df2 <strncpy+0x31>
			src++;
  800def:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800df2:	ff 45 fc             	incl   -0x4(%ebp)
  800df5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800df8:	3b 45 10             	cmp    0x10(%ebp),%eax
  800dfb:	72 d9                	jb     800dd6 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800dfd:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e00:	c9                   	leave  
  800e01:	c3                   	ret    

00800e02 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e02:	55                   	push   %ebp
  800e03:	89 e5                	mov    %esp,%ebp
  800e05:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e0e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e12:	74 30                	je     800e44 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e14:	eb 16                	jmp    800e2c <strlcpy+0x2a>
			*dst++ = *src++;
  800e16:	8b 45 08             	mov    0x8(%ebp),%eax
  800e19:	8d 50 01             	lea    0x1(%eax),%edx
  800e1c:	89 55 08             	mov    %edx,0x8(%ebp)
  800e1f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e22:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e25:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e28:	8a 12                	mov    (%edx),%dl
  800e2a:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e2c:	ff 4d 10             	decl   0x10(%ebp)
  800e2f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e33:	74 09                	je     800e3e <strlcpy+0x3c>
  800e35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e38:	8a 00                	mov    (%eax),%al
  800e3a:	84 c0                	test   %al,%al
  800e3c:	75 d8                	jne    800e16 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e41:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e44:	8b 55 08             	mov    0x8(%ebp),%edx
  800e47:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e4a:	29 c2                	sub    %eax,%edx
  800e4c:	89 d0                	mov    %edx,%eax
}
  800e4e:	c9                   	leave  
  800e4f:	c3                   	ret    

00800e50 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e50:	55                   	push   %ebp
  800e51:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e53:	eb 06                	jmp    800e5b <strcmp+0xb>
		p++, q++;
  800e55:	ff 45 08             	incl   0x8(%ebp)
  800e58:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5e:	8a 00                	mov    (%eax),%al
  800e60:	84 c0                	test   %al,%al
  800e62:	74 0e                	je     800e72 <strcmp+0x22>
  800e64:	8b 45 08             	mov    0x8(%ebp),%eax
  800e67:	8a 10                	mov    (%eax),%dl
  800e69:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6c:	8a 00                	mov    (%eax),%al
  800e6e:	38 c2                	cmp    %al,%dl
  800e70:	74 e3                	je     800e55 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800e72:	8b 45 08             	mov    0x8(%ebp),%eax
  800e75:	8a 00                	mov    (%eax),%al
  800e77:	0f b6 d0             	movzbl %al,%edx
  800e7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7d:	8a 00                	mov    (%eax),%al
  800e7f:	0f b6 c0             	movzbl %al,%eax
  800e82:	29 c2                	sub    %eax,%edx
  800e84:	89 d0                	mov    %edx,%eax
}
  800e86:	5d                   	pop    %ebp
  800e87:	c3                   	ret    

00800e88 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800e88:	55                   	push   %ebp
  800e89:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800e8b:	eb 09                	jmp    800e96 <strncmp+0xe>
		n--, p++, q++;
  800e8d:	ff 4d 10             	decl   0x10(%ebp)
  800e90:	ff 45 08             	incl   0x8(%ebp)
  800e93:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800e96:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e9a:	74 17                	je     800eb3 <strncmp+0x2b>
  800e9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9f:	8a 00                	mov    (%eax),%al
  800ea1:	84 c0                	test   %al,%al
  800ea3:	74 0e                	je     800eb3 <strncmp+0x2b>
  800ea5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea8:	8a 10                	mov    (%eax),%dl
  800eaa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ead:	8a 00                	mov    (%eax),%al
  800eaf:	38 c2                	cmp    %al,%dl
  800eb1:	74 da                	je     800e8d <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800eb3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eb7:	75 07                	jne    800ec0 <strncmp+0x38>
		return 0;
  800eb9:	b8 00 00 00 00       	mov    $0x0,%eax
  800ebe:	eb 14                	jmp    800ed4 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ec0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec3:	8a 00                	mov    (%eax),%al
  800ec5:	0f b6 d0             	movzbl %al,%edx
  800ec8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ecb:	8a 00                	mov    (%eax),%al
  800ecd:	0f b6 c0             	movzbl %al,%eax
  800ed0:	29 c2                	sub    %eax,%edx
  800ed2:	89 d0                	mov    %edx,%eax
}
  800ed4:	5d                   	pop    %ebp
  800ed5:	c3                   	ret    

00800ed6 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ed6:	55                   	push   %ebp
  800ed7:	89 e5                	mov    %esp,%ebp
  800ed9:	83 ec 04             	sub    $0x4,%esp
  800edc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800edf:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ee2:	eb 12                	jmp    800ef6 <strchr+0x20>
		if (*s == c)
  800ee4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee7:	8a 00                	mov    (%eax),%al
  800ee9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800eec:	75 05                	jne    800ef3 <strchr+0x1d>
			return (char *) s;
  800eee:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef1:	eb 11                	jmp    800f04 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ef3:	ff 45 08             	incl   0x8(%ebp)
  800ef6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef9:	8a 00                	mov    (%eax),%al
  800efb:	84 c0                	test   %al,%al
  800efd:	75 e5                	jne    800ee4 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800eff:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f04:	c9                   	leave  
  800f05:	c3                   	ret    

00800f06 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f06:	55                   	push   %ebp
  800f07:	89 e5                	mov    %esp,%ebp
  800f09:	83 ec 04             	sub    $0x4,%esp
  800f0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f0f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f12:	eb 0d                	jmp    800f21 <strfind+0x1b>
		if (*s == c)
  800f14:	8b 45 08             	mov    0x8(%ebp),%eax
  800f17:	8a 00                	mov    (%eax),%al
  800f19:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f1c:	74 0e                	je     800f2c <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f1e:	ff 45 08             	incl   0x8(%ebp)
  800f21:	8b 45 08             	mov    0x8(%ebp),%eax
  800f24:	8a 00                	mov    (%eax),%al
  800f26:	84 c0                	test   %al,%al
  800f28:	75 ea                	jne    800f14 <strfind+0xe>
  800f2a:	eb 01                	jmp    800f2d <strfind+0x27>
		if (*s == c)
			break;
  800f2c:	90                   	nop
	return (char *) s;
  800f2d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f30:	c9                   	leave  
  800f31:	c3                   	ret    

00800f32 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800f32:	55                   	push   %ebp
  800f33:	89 e5                	mov    %esp,%ebp
  800f35:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800f38:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800f3e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f41:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800f44:	eb 0e                	jmp    800f54 <memset+0x22>
		*p++ = c;
  800f46:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f49:	8d 50 01             	lea    0x1(%eax),%edx
  800f4c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f4f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f52:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800f54:	ff 4d f8             	decl   -0x8(%ebp)
  800f57:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800f5b:	79 e9                	jns    800f46 <memset+0x14>
		*p++ = c;

	return v;
  800f5d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f60:	c9                   	leave  
  800f61:	c3                   	ret    

00800f62 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800f62:	55                   	push   %ebp
  800f63:	89 e5                	mov    %esp,%ebp
  800f65:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800f68:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800f6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f71:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800f74:	eb 16                	jmp    800f8c <memcpy+0x2a>
		*d++ = *s++;
  800f76:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f79:	8d 50 01             	lea    0x1(%eax),%edx
  800f7c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f7f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f82:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f85:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f88:	8a 12                	mov    (%edx),%dl
  800f8a:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800f8c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f8f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f92:	89 55 10             	mov    %edx,0x10(%ebp)
  800f95:	85 c0                	test   %eax,%eax
  800f97:	75 dd                	jne    800f76 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800f99:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f9c:	c9                   	leave  
  800f9d:	c3                   	ret    

00800f9e <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800f9e:	55                   	push   %ebp
  800f9f:	89 e5                	mov    %esp,%ebp
  800fa1:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800fa4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800faa:	8b 45 08             	mov    0x8(%ebp),%eax
  800fad:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800fb0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fb3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fb6:	73 50                	jae    801008 <memmove+0x6a>
  800fb8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fbb:	8b 45 10             	mov    0x10(%ebp),%eax
  800fbe:	01 d0                	add    %edx,%eax
  800fc0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800fc3:	76 43                	jbe    801008 <memmove+0x6a>
		s += n;
  800fc5:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc8:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800fcb:	8b 45 10             	mov    0x10(%ebp),%eax
  800fce:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800fd1:	eb 10                	jmp    800fe3 <memmove+0x45>
			*--d = *--s;
  800fd3:	ff 4d f8             	decl   -0x8(%ebp)
  800fd6:	ff 4d fc             	decl   -0x4(%ebp)
  800fd9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fdc:	8a 10                	mov    (%eax),%dl
  800fde:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe1:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800fe3:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fe9:	89 55 10             	mov    %edx,0x10(%ebp)
  800fec:	85 c0                	test   %eax,%eax
  800fee:	75 e3                	jne    800fd3 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800ff0:	eb 23                	jmp    801015 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800ff2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ff5:	8d 50 01             	lea    0x1(%eax),%edx
  800ff8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ffb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ffe:	8d 4a 01             	lea    0x1(%edx),%ecx
  801001:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801004:	8a 12                	mov    (%edx),%dl
  801006:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801008:	8b 45 10             	mov    0x10(%ebp),%eax
  80100b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80100e:	89 55 10             	mov    %edx,0x10(%ebp)
  801011:	85 c0                	test   %eax,%eax
  801013:	75 dd                	jne    800ff2 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801015:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801018:	c9                   	leave  
  801019:	c3                   	ret    

0080101a <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80101a:	55                   	push   %ebp
  80101b:	89 e5                	mov    %esp,%ebp
  80101d:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801020:	8b 45 08             	mov    0x8(%ebp),%eax
  801023:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801026:	8b 45 0c             	mov    0xc(%ebp),%eax
  801029:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80102c:	eb 2a                	jmp    801058 <memcmp+0x3e>
		if (*s1 != *s2)
  80102e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801031:	8a 10                	mov    (%eax),%dl
  801033:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801036:	8a 00                	mov    (%eax),%al
  801038:	38 c2                	cmp    %al,%dl
  80103a:	74 16                	je     801052 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80103c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80103f:	8a 00                	mov    (%eax),%al
  801041:	0f b6 d0             	movzbl %al,%edx
  801044:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801047:	8a 00                	mov    (%eax),%al
  801049:	0f b6 c0             	movzbl %al,%eax
  80104c:	29 c2                	sub    %eax,%edx
  80104e:	89 d0                	mov    %edx,%eax
  801050:	eb 18                	jmp    80106a <memcmp+0x50>
		s1++, s2++;
  801052:	ff 45 fc             	incl   -0x4(%ebp)
  801055:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801058:	8b 45 10             	mov    0x10(%ebp),%eax
  80105b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80105e:	89 55 10             	mov    %edx,0x10(%ebp)
  801061:	85 c0                	test   %eax,%eax
  801063:	75 c9                	jne    80102e <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801065:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80106a:	c9                   	leave  
  80106b:	c3                   	ret    

0080106c <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80106c:	55                   	push   %ebp
  80106d:	89 e5                	mov    %esp,%ebp
  80106f:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801072:	8b 55 08             	mov    0x8(%ebp),%edx
  801075:	8b 45 10             	mov    0x10(%ebp),%eax
  801078:	01 d0                	add    %edx,%eax
  80107a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80107d:	eb 15                	jmp    801094 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80107f:	8b 45 08             	mov    0x8(%ebp),%eax
  801082:	8a 00                	mov    (%eax),%al
  801084:	0f b6 d0             	movzbl %al,%edx
  801087:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108a:	0f b6 c0             	movzbl %al,%eax
  80108d:	39 c2                	cmp    %eax,%edx
  80108f:	74 0d                	je     80109e <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801091:	ff 45 08             	incl   0x8(%ebp)
  801094:	8b 45 08             	mov    0x8(%ebp),%eax
  801097:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80109a:	72 e3                	jb     80107f <memfind+0x13>
  80109c:	eb 01                	jmp    80109f <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80109e:	90                   	nop
	return (void *) s;
  80109f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010a2:	c9                   	leave  
  8010a3:	c3                   	ret    

008010a4 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8010a4:	55                   	push   %ebp
  8010a5:	89 e5                	mov    %esp,%ebp
  8010a7:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8010aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8010b1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010b8:	eb 03                	jmp    8010bd <strtol+0x19>
		s++;
  8010ba:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c0:	8a 00                	mov    (%eax),%al
  8010c2:	3c 20                	cmp    $0x20,%al
  8010c4:	74 f4                	je     8010ba <strtol+0x16>
  8010c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c9:	8a 00                	mov    (%eax),%al
  8010cb:	3c 09                	cmp    $0x9,%al
  8010cd:	74 eb                	je     8010ba <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8010cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d2:	8a 00                	mov    (%eax),%al
  8010d4:	3c 2b                	cmp    $0x2b,%al
  8010d6:	75 05                	jne    8010dd <strtol+0x39>
		s++;
  8010d8:	ff 45 08             	incl   0x8(%ebp)
  8010db:	eb 13                	jmp    8010f0 <strtol+0x4c>
	else if (*s == '-')
  8010dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e0:	8a 00                	mov    (%eax),%al
  8010e2:	3c 2d                	cmp    $0x2d,%al
  8010e4:	75 0a                	jne    8010f0 <strtol+0x4c>
		s++, neg = 1;
  8010e6:	ff 45 08             	incl   0x8(%ebp)
  8010e9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8010f0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010f4:	74 06                	je     8010fc <strtol+0x58>
  8010f6:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8010fa:	75 20                	jne    80111c <strtol+0x78>
  8010fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ff:	8a 00                	mov    (%eax),%al
  801101:	3c 30                	cmp    $0x30,%al
  801103:	75 17                	jne    80111c <strtol+0x78>
  801105:	8b 45 08             	mov    0x8(%ebp),%eax
  801108:	40                   	inc    %eax
  801109:	8a 00                	mov    (%eax),%al
  80110b:	3c 78                	cmp    $0x78,%al
  80110d:	75 0d                	jne    80111c <strtol+0x78>
		s += 2, base = 16;
  80110f:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801113:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80111a:	eb 28                	jmp    801144 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80111c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801120:	75 15                	jne    801137 <strtol+0x93>
  801122:	8b 45 08             	mov    0x8(%ebp),%eax
  801125:	8a 00                	mov    (%eax),%al
  801127:	3c 30                	cmp    $0x30,%al
  801129:	75 0c                	jne    801137 <strtol+0x93>
		s++, base = 8;
  80112b:	ff 45 08             	incl   0x8(%ebp)
  80112e:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801135:	eb 0d                	jmp    801144 <strtol+0xa0>
	else if (base == 0)
  801137:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80113b:	75 07                	jne    801144 <strtol+0xa0>
		base = 10;
  80113d:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801144:	8b 45 08             	mov    0x8(%ebp),%eax
  801147:	8a 00                	mov    (%eax),%al
  801149:	3c 2f                	cmp    $0x2f,%al
  80114b:	7e 19                	jle    801166 <strtol+0xc2>
  80114d:	8b 45 08             	mov    0x8(%ebp),%eax
  801150:	8a 00                	mov    (%eax),%al
  801152:	3c 39                	cmp    $0x39,%al
  801154:	7f 10                	jg     801166 <strtol+0xc2>
			dig = *s - '0';
  801156:	8b 45 08             	mov    0x8(%ebp),%eax
  801159:	8a 00                	mov    (%eax),%al
  80115b:	0f be c0             	movsbl %al,%eax
  80115e:	83 e8 30             	sub    $0x30,%eax
  801161:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801164:	eb 42                	jmp    8011a8 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801166:	8b 45 08             	mov    0x8(%ebp),%eax
  801169:	8a 00                	mov    (%eax),%al
  80116b:	3c 60                	cmp    $0x60,%al
  80116d:	7e 19                	jle    801188 <strtol+0xe4>
  80116f:	8b 45 08             	mov    0x8(%ebp),%eax
  801172:	8a 00                	mov    (%eax),%al
  801174:	3c 7a                	cmp    $0x7a,%al
  801176:	7f 10                	jg     801188 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801178:	8b 45 08             	mov    0x8(%ebp),%eax
  80117b:	8a 00                	mov    (%eax),%al
  80117d:	0f be c0             	movsbl %al,%eax
  801180:	83 e8 57             	sub    $0x57,%eax
  801183:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801186:	eb 20                	jmp    8011a8 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801188:	8b 45 08             	mov    0x8(%ebp),%eax
  80118b:	8a 00                	mov    (%eax),%al
  80118d:	3c 40                	cmp    $0x40,%al
  80118f:	7e 39                	jle    8011ca <strtol+0x126>
  801191:	8b 45 08             	mov    0x8(%ebp),%eax
  801194:	8a 00                	mov    (%eax),%al
  801196:	3c 5a                	cmp    $0x5a,%al
  801198:	7f 30                	jg     8011ca <strtol+0x126>
			dig = *s - 'A' + 10;
  80119a:	8b 45 08             	mov    0x8(%ebp),%eax
  80119d:	8a 00                	mov    (%eax),%al
  80119f:	0f be c0             	movsbl %al,%eax
  8011a2:	83 e8 37             	sub    $0x37,%eax
  8011a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8011a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011ab:	3b 45 10             	cmp    0x10(%ebp),%eax
  8011ae:	7d 19                	jge    8011c9 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8011b0:	ff 45 08             	incl   0x8(%ebp)
  8011b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011b6:	0f af 45 10          	imul   0x10(%ebp),%eax
  8011ba:	89 c2                	mov    %eax,%edx
  8011bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011bf:	01 d0                	add    %edx,%eax
  8011c1:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8011c4:	e9 7b ff ff ff       	jmp    801144 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8011c9:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8011ca:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011ce:	74 08                	je     8011d8 <strtol+0x134>
		*endptr = (char *) s;
  8011d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d3:	8b 55 08             	mov    0x8(%ebp),%edx
  8011d6:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8011d8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011dc:	74 07                	je     8011e5 <strtol+0x141>
  8011de:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011e1:	f7 d8                	neg    %eax
  8011e3:	eb 03                	jmp    8011e8 <strtol+0x144>
  8011e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8011e8:	c9                   	leave  
  8011e9:	c3                   	ret    

008011ea <ltostr>:

void
ltostr(long value, char *str)
{
  8011ea:	55                   	push   %ebp
  8011eb:	89 e5                	mov    %esp,%ebp
  8011ed:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8011f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8011f7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8011fe:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801202:	79 13                	jns    801217 <ltostr+0x2d>
	{
		neg = 1;
  801204:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80120b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80120e:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801211:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801214:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801217:	8b 45 08             	mov    0x8(%ebp),%eax
  80121a:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80121f:	99                   	cltd   
  801220:	f7 f9                	idiv   %ecx
  801222:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801225:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801228:	8d 50 01             	lea    0x1(%eax),%edx
  80122b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80122e:	89 c2                	mov    %eax,%edx
  801230:	8b 45 0c             	mov    0xc(%ebp),%eax
  801233:	01 d0                	add    %edx,%eax
  801235:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801238:	83 c2 30             	add    $0x30,%edx
  80123b:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80123d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801240:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801245:	f7 e9                	imul   %ecx
  801247:	c1 fa 02             	sar    $0x2,%edx
  80124a:	89 c8                	mov    %ecx,%eax
  80124c:	c1 f8 1f             	sar    $0x1f,%eax
  80124f:	29 c2                	sub    %eax,%edx
  801251:	89 d0                	mov    %edx,%eax
  801253:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801256:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801259:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80125e:	f7 e9                	imul   %ecx
  801260:	c1 fa 02             	sar    $0x2,%edx
  801263:	89 c8                	mov    %ecx,%eax
  801265:	c1 f8 1f             	sar    $0x1f,%eax
  801268:	29 c2                	sub    %eax,%edx
  80126a:	89 d0                	mov    %edx,%eax
  80126c:	c1 e0 02             	shl    $0x2,%eax
  80126f:	01 d0                	add    %edx,%eax
  801271:	01 c0                	add    %eax,%eax
  801273:	29 c1                	sub    %eax,%ecx
  801275:	89 ca                	mov    %ecx,%edx
  801277:	85 d2                	test   %edx,%edx
  801279:	75 9c                	jne    801217 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80127b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801282:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801285:	48                   	dec    %eax
  801286:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801289:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80128d:	74 3d                	je     8012cc <ltostr+0xe2>
		start = 1 ;
  80128f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801296:	eb 34                	jmp    8012cc <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801298:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80129b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129e:	01 d0                	add    %edx,%eax
  8012a0:	8a 00                	mov    (%eax),%al
  8012a2:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8012a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ab:	01 c2                	add    %eax,%edx
  8012ad:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8012b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b3:	01 c8                	add    %ecx,%eax
  8012b5:	8a 00                	mov    (%eax),%al
  8012b7:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8012b9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8012bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012bf:	01 c2                	add    %eax,%edx
  8012c1:	8a 45 eb             	mov    -0x15(%ebp),%al
  8012c4:	88 02                	mov    %al,(%edx)
		start++ ;
  8012c6:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8012c9:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8012cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012cf:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8012d2:	7c c4                	jl     801298 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8012d4:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8012d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012da:	01 d0                	add    %edx,%eax
  8012dc:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8012df:	90                   	nop
  8012e0:	c9                   	leave  
  8012e1:	c3                   	ret    

008012e2 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8012e2:	55                   	push   %ebp
  8012e3:	89 e5                	mov    %esp,%ebp
  8012e5:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8012e8:	ff 75 08             	pushl  0x8(%ebp)
  8012eb:	e8 54 fa ff ff       	call   800d44 <strlen>
  8012f0:	83 c4 04             	add    $0x4,%esp
  8012f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8012f6:	ff 75 0c             	pushl  0xc(%ebp)
  8012f9:	e8 46 fa ff ff       	call   800d44 <strlen>
  8012fe:	83 c4 04             	add    $0x4,%esp
  801301:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801304:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80130b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801312:	eb 17                	jmp    80132b <strcconcat+0x49>
		final[s] = str1[s] ;
  801314:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801317:	8b 45 10             	mov    0x10(%ebp),%eax
  80131a:	01 c2                	add    %eax,%edx
  80131c:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80131f:	8b 45 08             	mov    0x8(%ebp),%eax
  801322:	01 c8                	add    %ecx,%eax
  801324:	8a 00                	mov    (%eax),%al
  801326:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801328:	ff 45 fc             	incl   -0x4(%ebp)
  80132b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80132e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801331:	7c e1                	jl     801314 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801333:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80133a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801341:	eb 1f                	jmp    801362 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801343:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801346:	8d 50 01             	lea    0x1(%eax),%edx
  801349:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80134c:	89 c2                	mov    %eax,%edx
  80134e:	8b 45 10             	mov    0x10(%ebp),%eax
  801351:	01 c2                	add    %eax,%edx
  801353:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801356:	8b 45 0c             	mov    0xc(%ebp),%eax
  801359:	01 c8                	add    %ecx,%eax
  80135b:	8a 00                	mov    (%eax),%al
  80135d:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80135f:	ff 45 f8             	incl   -0x8(%ebp)
  801362:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801365:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801368:	7c d9                	jl     801343 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80136a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80136d:	8b 45 10             	mov    0x10(%ebp),%eax
  801370:	01 d0                	add    %edx,%eax
  801372:	c6 00 00             	movb   $0x0,(%eax)
}
  801375:	90                   	nop
  801376:	c9                   	leave  
  801377:	c3                   	ret    

00801378 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801378:	55                   	push   %ebp
  801379:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80137b:	8b 45 14             	mov    0x14(%ebp),%eax
  80137e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801384:	8b 45 14             	mov    0x14(%ebp),%eax
  801387:	8b 00                	mov    (%eax),%eax
  801389:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801390:	8b 45 10             	mov    0x10(%ebp),%eax
  801393:	01 d0                	add    %edx,%eax
  801395:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80139b:	eb 0c                	jmp    8013a9 <strsplit+0x31>
			*string++ = 0;
  80139d:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a0:	8d 50 01             	lea    0x1(%eax),%edx
  8013a3:	89 55 08             	mov    %edx,0x8(%ebp)
  8013a6:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ac:	8a 00                	mov    (%eax),%al
  8013ae:	84 c0                	test   %al,%al
  8013b0:	74 18                	je     8013ca <strsplit+0x52>
  8013b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b5:	8a 00                	mov    (%eax),%al
  8013b7:	0f be c0             	movsbl %al,%eax
  8013ba:	50                   	push   %eax
  8013bb:	ff 75 0c             	pushl  0xc(%ebp)
  8013be:	e8 13 fb ff ff       	call   800ed6 <strchr>
  8013c3:	83 c4 08             	add    $0x8,%esp
  8013c6:	85 c0                	test   %eax,%eax
  8013c8:	75 d3                	jne    80139d <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8013ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cd:	8a 00                	mov    (%eax),%al
  8013cf:	84 c0                	test   %al,%al
  8013d1:	74 5a                	je     80142d <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8013d3:	8b 45 14             	mov    0x14(%ebp),%eax
  8013d6:	8b 00                	mov    (%eax),%eax
  8013d8:	83 f8 0f             	cmp    $0xf,%eax
  8013db:	75 07                	jne    8013e4 <strsplit+0x6c>
		{
			return 0;
  8013dd:	b8 00 00 00 00       	mov    $0x0,%eax
  8013e2:	eb 66                	jmp    80144a <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8013e4:	8b 45 14             	mov    0x14(%ebp),%eax
  8013e7:	8b 00                	mov    (%eax),%eax
  8013e9:	8d 48 01             	lea    0x1(%eax),%ecx
  8013ec:	8b 55 14             	mov    0x14(%ebp),%edx
  8013ef:	89 0a                	mov    %ecx,(%edx)
  8013f1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8013fb:	01 c2                	add    %eax,%edx
  8013fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801400:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801402:	eb 03                	jmp    801407 <strsplit+0x8f>
			string++;
  801404:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801407:	8b 45 08             	mov    0x8(%ebp),%eax
  80140a:	8a 00                	mov    (%eax),%al
  80140c:	84 c0                	test   %al,%al
  80140e:	74 8b                	je     80139b <strsplit+0x23>
  801410:	8b 45 08             	mov    0x8(%ebp),%eax
  801413:	8a 00                	mov    (%eax),%al
  801415:	0f be c0             	movsbl %al,%eax
  801418:	50                   	push   %eax
  801419:	ff 75 0c             	pushl  0xc(%ebp)
  80141c:	e8 b5 fa ff ff       	call   800ed6 <strchr>
  801421:	83 c4 08             	add    $0x8,%esp
  801424:	85 c0                	test   %eax,%eax
  801426:	74 dc                	je     801404 <strsplit+0x8c>
			string++;
	}
  801428:	e9 6e ff ff ff       	jmp    80139b <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80142d:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80142e:	8b 45 14             	mov    0x14(%ebp),%eax
  801431:	8b 00                	mov    (%eax),%eax
  801433:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80143a:	8b 45 10             	mov    0x10(%ebp),%eax
  80143d:	01 d0                	add    %edx,%eax
  80143f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801445:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80144a:	c9                   	leave  
  80144b:	c3                   	ret    

0080144c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80144c:	55                   	push   %ebp
  80144d:	89 e5                	mov    %esp,%ebp
  80144f:	57                   	push   %edi
  801450:	56                   	push   %esi
  801451:	53                   	push   %ebx
  801452:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801455:	8b 45 08             	mov    0x8(%ebp),%eax
  801458:	8b 55 0c             	mov    0xc(%ebp),%edx
  80145b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80145e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801461:	8b 7d 18             	mov    0x18(%ebp),%edi
  801464:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801467:	cd 30                	int    $0x30
  801469:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80146c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80146f:	83 c4 10             	add    $0x10,%esp
  801472:	5b                   	pop    %ebx
  801473:	5e                   	pop    %esi
  801474:	5f                   	pop    %edi
  801475:	5d                   	pop    %ebp
  801476:	c3                   	ret    

00801477 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801477:	55                   	push   %ebp
  801478:	89 e5                	mov    %esp,%ebp
  80147a:	83 ec 04             	sub    $0x4,%esp
  80147d:	8b 45 10             	mov    0x10(%ebp),%eax
  801480:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801483:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801487:	8b 45 08             	mov    0x8(%ebp),%eax
  80148a:	6a 00                	push   $0x0
  80148c:	6a 00                	push   $0x0
  80148e:	52                   	push   %edx
  80148f:	ff 75 0c             	pushl  0xc(%ebp)
  801492:	50                   	push   %eax
  801493:	6a 00                	push   $0x0
  801495:	e8 b2 ff ff ff       	call   80144c <syscall>
  80149a:	83 c4 18             	add    $0x18,%esp
}
  80149d:	90                   	nop
  80149e:	c9                   	leave  
  80149f:	c3                   	ret    

008014a0 <sys_cgetc>:

int
sys_cgetc(void)
{
  8014a0:	55                   	push   %ebp
  8014a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8014a3:	6a 00                	push   $0x0
  8014a5:	6a 00                	push   $0x0
  8014a7:	6a 00                	push   $0x0
  8014a9:	6a 00                	push   $0x0
  8014ab:	6a 00                	push   $0x0
  8014ad:	6a 01                	push   $0x1
  8014af:	e8 98 ff ff ff       	call   80144c <syscall>
  8014b4:	83 c4 18             	add    $0x18,%esp
}
  8014b7:	c9                   	leave  
  8014b8:	c3                   	ret    

008014b9 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8014b9:	55                   	push   %ebp
  8014ba:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8014bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 00                	push   $0x0
  8014c3:	6a 00                	push   $0x0
  8014c5:	6a 00                	push   $0x0
  8014c7:	50                   	push   %eax
  8014c8:	6a 05                	push   $0x5
  8014ca:	e8 7d ff ff ff       	call   80144c <syscall>
  8014cf:	83 c4 18             	add    $0x18,%esp
}
  8014d2:	c9                   	leave  
  8014d3:	c3                   	ret    

008014d4 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8014d4:	55                   	push   %ebp
  8014d5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8014d7:	6a 00                	push   $0x0
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 02                	push   $0x2
  8014e3:	e8 64 ff ff ff       	call   80144c <syscall>
  8014e8:	83 c4 18             	add    $0x18,%esp
}
  8014eb:	c9                   	leave  
  8014ec:	c3                   	ret    

008014ed <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8014ed:	55                   	push   %ebp
  8014ee:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8014f0:	6a 00                	push   $0x0
  8014f2:	6a 00                	push   $0x0
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 00                	push   $0x0
  8014fa:	6a 03                	push   $0x3
  8014fc:	e8 4b ff ff ff       	call   80144c <syscall>
  801501:	83 c4 18             	add    $0x18,%esp
}
  801504:	c9                   	leave  
  801505:	c3                   	ret    

00801506 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801506:	55                   	push   %ebp
  801507:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801509:	6a 00                	push   $0x0
  80150b:	6a 00                	push   $0x0
  80150d:	6a 00                	push   $0x0
  80150f:	6a 00                	push   $0x0
  801511:	6a 00                	push   $0x0
  801513:	6a 04                	push   $0x4
  801515:	e8 32 ff ff ff       	call   80144c <syscall>
  80151a:	83 c4 18             	add    $0x18,%esp
}
  80151d:	c9                   	leave  
  80151e:	c3                   	ret    

0080151f <sys_env_exit>:


void sys_env_exit(void)
{
  80151f:	55                   	push   %ebp
  801520:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801522:	6a 00                	push   $0x0
  801524:	6a 00                	push   $0x0
  801526:	6a 00                	push   $0x0
  801528:	6a 00                	push   $0x0
  80152a:	6a 00                	push   $0x0
  80152c:	6a 06                	push   $0x6
  80152e:	e8 19 ff ff ff       	call   80144c <syscall>
  801533:	83 c4 18             	add    $0x18,%esp
}
  801536:	90                   	nop
  801537:	c9                   	leave  
  801538:	c3                   	ret    

00801539 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801539:	55                   	push   %ebp
  80153a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80153c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80153f:	8b 45 08             	mov    0x8(%ebp),%eax
  801542:	6a 00                	push   $0x0
  801544:	6a 00                	push   $0x0
  801546:	6a 00                	push   $0x0
  801548:	52                   	push   %edx
  801549:	50                   	push   %eax
  80154a:	6a 07                	push   $0x7
  80154c:	e8 fb fe ff ff       	call   80144c <syscall>
  801551:	83 c4 18             	add    $0x18,%esp
}
  801554:	c9                   	leave  
  801555:	c3                   	ret    

00801556 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801556:	55                   	push   %ebp
  801557:	89 e5                	mov    %esp,%ebp
  801559:	56                   	push   %esi
  80155a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80155b:	8b 75 18             	mov    0x18(%ebp),%esi
  80155e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801561:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801564:	8b 55 0c             	mov    0xc(%ebp),%edx
  801567:	8b 45 08             	mov    0x8(%ebp),%eax
  80156a:	56                   	push   %esi
  80156b:	53                   	push   %ebx
  80156c:	51                   	push   %ecx
  80156d:	52                   	push   %edx
  80156e:	50                   	push   %eax
  80156f:	6a 08                	push   $0x8
  801571:	e8 d6 fe ff ff       	call   80144c <syscall>
  801576:	83 c4 18             	add    $0x18,%esp
}
  801579:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80157c:	5b                   	pop    %ebx
  80157d:	5e                   	pop    %esi
  80157e:	5d                   	pop    %ebp
  80157f:	c3                   	ret    

00801580 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801580:	55                   	push   %ebp
  801581:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801583:	8b 55 0c             	mov    0xc(%ebp),%edx
  801586:	8b 45 08             	mov    0x8(%ebp),%eax
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 00                	push   $0x0
  80158f:	52                   	push   %edx
  801590:	50                   	push   %eax
  801591:	6a 09                	push   $0x9
  801593:	e8 b4 fe ff ff       	call   80144c <syscall>
  801598:	83 c4 18             	add    $0x18,%esp
}
  80159b:	c9                   	leave  
  80159c:	c3                   	ret    

0080159d <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80159d:	55                   	push   %ebp
  80159e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	ff 75 0c             	pushl  0xc(%ebp)
  8015a9:	ff 75 08             	pushl  0x8(%ebp)
  8015ac:	6a 0a                	push   $0xa
  8015ae:	e8 99 fe ff ff       	call   80144c <syscall>
  8015b3:	83 c4 18             	add    $0x18,%esp
}
  8015b6:	c9                   	leave  
  8015b7:	c3                   	ret    

008015b8 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8015b8:	55                   	push   %ebp
  8015b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8015bb:	6a 00                	push   $0x0
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 00                	push   $0x0
  8015c1:	6a 00                	push   $0x0
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 0b                	push   $0xb
  8015c7:	e8 80 fe ff ff       	call   80144c <syscall>
  8015cc:	83 c4 18             	add    $0x18,%esp
}
  8015cf:	c9                   	leave  
  8015d0:	c3                   	ret    

008015d1 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8015d1:	55                   	push   %ebp
  8015d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8015d4:	6a 00                	push   $0x0
  8015d6:	6a 00                	push   $0x0
  8015d8:	6a 00                	push   $0x0
  8015da:	6a 00                	push   $0x0
  8015dc:	6a 00                	push   $0x0
  8015de:	6a 0c                	push   $0xc
  8015e0:	e8 67 fe ff ff       	call   80144c <syscall>
  8015e5:	83 c4 18             	add    $0x18,%esp
}
  8015e8:	c9                   	leave  
  8015e9:	c3                   	ret    

008015ea <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8015ea:	55                   	push   %ebp
  8015eb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8015ed:	6a 00                	push   $0x0
  8015ef:	6a 00                	push   $0x0
  8015f1:	6a 00                	push   $0x0
  8015f3:	6a 00                	push   $0x0
  8015f5:	6a 00                	push   $0x0
  8015f7:	6a 0d                	push   $0xd
  8015f9:	e8 4e fe ff ff       	call   80144c <syscall>
  8015fe:	83 c4 18             	add    $0x18,%esp
}
  801601:	c9                   	leave  
  801602:	c3                   	ret    

00801603 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801603:	55                   	push   %ebp
  801604:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801606:	6a 00                	push   $0x0
  801608:	6a 00                	push   $0x0
  80160a:	6a 00                	push   $0x0
  80160c:	ff 75 0c             	pushl  0xc(%ebp)
  80160f:	ff 75 08             	pushl  0x8(%ebp)
  801612:	6a 11                	push   $0x11
  801614:	e8 33 fe ff ff       	call   80144c <syscall>
  801619:	83 c4 18             	add    $0x18,%esp
	return;
  80161c:	90                   	nop
}
  80161d:	c9                   	leave  
  80161e:	c3                   	ret    

0080161f <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80161f:	55                   	push   %ebp
  801620:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801622:	6a 00                	push   $0x0
  801624:	6a 00                	push   $0x0
  801626:	6a 00                	push   $0x0
  801628:	ff 75 0c             	pushl  0xc(%ebp)
  80162b:	ff 75 08             	pushl  0x8(%ebp)
  80162e:	6a 12                	push   $0x12
  801630:	e8 17 fe ff ff       	call   80144c <syscall>
  801635:	83 c4 18             	add    $0x18,%esp
	return ;
  801638:	90                   	nop
}
  801639:	c9                   	leave  
  80163a:	c3                   	ret    

0080163b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80163b:	55                   	push   %ebp
  80163c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80163e:	6a 00                	push   $0x0
  801640:	6a 00                	push   $0x0
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	6a 0e                	push   $0xe
  80164a:	e8 fd fd ff ff       	call   80144c <syscall>
  80164f:	83 c4 18             	add    $0x18,%esp
}
  801652:	c9                   	leave  
  801653:	c3                   	ret    

00801654 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801654:	55                   	push   %ebp
  801655:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801657:	6a 00                	push   $0x0
  801659:	6a 00                	push   $0x0
  80165b:	6a 00                	push   $0x0
  80165d:	6a 00                	push   $0x0
  80165f:	ff 75 08             	pushl  0x8(%ebp)
  801662:	6a 0f                	push   $0xf
  801664:	e8 e3 fd ff ff       	call   80144c <syscall>
  801669:	83 c4 18             	add    $0x18,%esp
}
  80166c:	c9                   	leave  
  80166d:	c3                   	ret    

0080166e <sys_scarce_memory>:

void sys_scarce_memory()
{
  80166e:	55                   	push   %ebp
  80166f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801671:	6a 00                	push   $0x0
  801673:	6a 00                	push   $0x0
  801675:	6a 00                	push   $0x0
  801677:	6a 00                	push   $0x0
  801679:	6a 00                	push   $0x0
  80167b:	6a 10                	push   $0x10
  80167d:	e8 ca fd ff ff       	call   80144c <syscall>
  801682:	83 c4 18             	add    $0x18,%esp
}
  801685:	90                   	nop
  801686:	c9                   	leave  
  801687:	c3                   	ret    

00801688 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801688:	55                   	push   %ebp
  801689:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80168b:	6a 00                	push   $0x0
  80168d:	6a 00                	push   $0x0
  80168f:	6a 00                	push   $0x0
  801691:	6a 00                	push   $0x0
  801693:	6a 00                	push   $0x0
  801695:	6a 14                	push   $0x14
  801697:	e8 b0 fd ff ff       	call   80144c <syscall>
  80169c:	83 c4 18             	add    $0x18,%esp
}
  80169f:	90                   	nop
  8016a0:	c9                   	leave  
  8016a1:	c3                   	ret    

008016a2 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8016a2:	55                   	push   %ebp
  8016a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 00                	push   $0x0
  8016a9:	6a 00                	push   $0x0
  8016ab:	6a 00                	push   $0x0
  8016ad:	6a 00                	push   $0x0
  8016af:	6a 15                	push   $0x15
  8016b1:	e8 96 fd ff ff       	call   80144c <syscall>
  8016b6:	83 c4 18             	add    $0x18,%esp
}
  8016b9:	90                   	nop
  8016ba:	c9                   	leave  
  8016bb:	c3                   	ret    

008016bc <sys_cputc>:


void
sys_cputc(const char c)
{
  8016bc:	55                   	push   %ebp
  8016bd:	89 e5                	mov    %esp,%ebp
  8016bf:	83 ec 04             	sub    $0x4,%esp
  8016c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8016c8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016cc:	6a 00                	push   $0x0
  8016ce:	6a 00                	push   $0x0
  8016d0:	6a 00                	push   $0x0
  8016d2:	6a 00                	push   $0x0
  8016d4:	50                   	push   %eax
  8016d5:	6a 16                	push   $0x16
  8016d7:	e8 70 fd ff ff       	call   80144c <syscall>
  8016dc:	83 c4 18             	add    $0x18,%esp
}
  8016df:	90                   	nop
  8016e0:	c9                   	leave  
  8016e1:	c3                   	ret    

008016e2 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8016e2:	55                   	push   %ebp
  8016e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8016e5:	6a 00                	push   $0x0
  8016e7:	6a 00                	push   $0x0
  8016e9:	6a 00                	push   $0x0
  8016eb:	6a 00                	push   $0x0
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 17                	push   $0x17
  8016f1:	e8 56 fd ff ff       	call   80144c <syscall>
  8016f6:	83 c4 18             	add    $0x18,%esp
}
  8016f9:	90                   	nop
  8016fa:	c9                   	leave  
  8016fb:	c3                   	ret    

008016fc <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8016fc:	55                   	push   %ebp
  8016fd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8016ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801702:	6a 00                	push   $0x0
  801704:	6a 00                	push   $0x0
  801706:	6a 00                	push   $0x0
  801708:	ff 75 0c             	pushl  0xc(%ebp)
  80170b:	50                   	push   %eax
  80170c:	6a 18                	push   $0x18
  80170e:	e8 39 fd ff ff       	call   80144c <syscall>
  801713:	83 c4 18             	add    $0x18,%esp
}
  801716:	c9                   	leave  
  801717:	c3                   	ret    

00801718 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801718:	55                   	push   %ebp
  801719:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80171b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80171e:	8b 45 08             	mov    0x8(%ebp),%eax
  801721:	6a 00                	push   $0x0
  801723:	6a 00                	push   $0x0
  801725:	6a 00                	push   $0x0
  801727:	52                   	push   %edx
  801728:	50                   	push   %eax
  801729:	6a 1b                	push   $0x1b
  80172b:	e8 1c fd ff ff       	call   80144c <syscall>
  801730:	83 c4 18             	add    $0x18,%esp
}
  801733:	c9                   	leave  
  801734:	c3                   	ret    

00801735 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801735:	55                   	push   %ebp
  801736:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801738:	8b 55 0c             	mov    0xc(%ebp),%edx
  80173b:	8b 45 08             	mov    0x8(%ebp),%eax
  80173e:	6a 00                	push   $0x0
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	52                   	push   %edx
  801745:	50                   	push   %eax
  801746:	6a 19                	push   $0x19
  801748:	e8 ff fc ff ff       	call   80144c <syscall>
  80174d:	83 c4 18             	add    $0x18,%esp
}
  801750:	90                   	nop
  801751:	c9                   	leave  
  801752:	c3                   	ret    

00801753 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801753:	55                   	push   %ebp
  801754:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801756:	8b 55 0c             	mov    0xc(%ebp),%edx
  801759:	8b 45 08             	mov    0x8(%ebp),%eax
  80175c:	6a 00                	push   $0x0
  80175e:	6a 00                	push   $0x0
  801760:	6a 00                	push   $0x0
  801762:	52                   	push   %edx
  801763:	50                   	push   %eax
  801764:	6a 1a                	push   $0x1a
  801766:	e8 e1 fc ff ff       	call   80144c <syscall>
  80176b:	83 c4 18             	add    $0x18,%esp
}
  80176e:	90                   	nop
  80176f:	c9                   	leave  
  801770:	c3                   	ret    

00801771 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801771:	55                   	push   %ebp
  801772:	89 e5                	mov    %esp,%ebp
  801774:	83 ec 04             	sub    $0x4,%esp
  801777:	8b 45 10             	mov    0x10(%ebp),%eax
  80177a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80177d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801780:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801784:	8b 45 08             	mov    0x8(%ebp),%eax
  801787:	6a 00                	push   $0x0
  801789:	51                   	push   %ecx
  80178a:	52                   	push   %edx
  80178b:	ff 75 0c             	pushl  0xc(%ebp)
  80178e:	50                   	push   %eax
  80178f:	6a 1c                	push   $0x1c
  801791:	e8 b6 fc ff ff       	call   80144c <syscall>
  801796:	83 c4 18             	add    $0x18,%esp
}
  801799:	c9                   	leave  
  80179a:	c3                   	ret    

0080179b <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80179b:	55                   	push   %ebp
  80179c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80179e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a4:	6a 00                	push   $0x0
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 00                	push   $0x0
  8017aa:	52                   	push   %edx
  8017ab:	50                   	push   %eax
  8017ac:	6a 1d                	push   $0x1d
  8017ae:	e8 99 fc ff ff       	call   80144c <syscall>
  8017b3:	83 c4 18             	add    $0x18,%esp
}
  8017b6:	c9                   	leave  
  8017b7:	c3                   	ret    

008017b8 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8017b8:	55                   	push   %ebp
  8017b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8017bb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c4:	6a 00                	push   $0x0
  8017c6:	6a 00                	push   $0x0
  8017c8:	51                   	push   %ecx
  8017c9:	52                   	push   %edx
  8017ca:	50                   	push   %eax
  8017cb:	6a 1e                	push   $0x1e
  8017cd:	e8 7a fc ff ff       	call   80144c <syscall>
  8017d2:	83 c4 18             	add    $0x18,%esp
}
  8017d5:	c9                   	leave  
  8017d6:	c3                   	ret    

008017d7 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8017d7:	55                   	push   %ebp
  8017d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8017da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 00                	push   $0x0
  8017e6:	52                   	push   %edx
  8017e7:	50                   	push   %eax
  8017e8:	6a 1f                	push   $0x1f
  8017ea:	e8 5d fc ff ff       	call   80144c <syscall>
  8017ef:	83 c4 18             	add    $0x18,%esp
}
  8017f2:	c9                   	leave  
  8017f3:	c3                   	ret    

008017f4 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8017f4:	55                   	push   %ebp
  8017f5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 20                	push   $0x20
  801803:	e8 44 fc ff ff       	call   80144c <syscall>
  801808:	83 c4 18             	add    $0x18,%esp
}
  80180b:	c9                   	leave  
  80180c:	c3                   	ret    

0080180d <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80180d:	55                   	push   %ebp
  80180e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801810:	8b 45 08             	mov    0x8(%ebp),%eax
  801813:	6a 00                	push   $0x0
  801815:	ff 75 14             	pushl  0x14(%ebp)
  801818:	ff 75 10             	pushl  0x10(%ebp)
  80181b:	ff 75 0c             	pushl  0xc(%ebp)
  80181e:	50                   	push   %eax
  80181f:	6a 21                	push   $0x21
  801821:	e8 26 fc ff ff       	call   80144c <syscall>
  801826:	83 c4 18             	add    $0x18,%esp
}
  801829:	c9                   	leave  
  80182a:	c3                   	ret    

0080182b <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80182b:	55                   	push   %ebp
  80182c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80182e:	8b 45 08             	mov    0x8(%ebp),%eax
  801831:	6a 00                	push   $0x0
  801833:	6a 00                	push   $0x0
  801835:	6a 00                	push   $0x0
  801837:	6a 00                	push   $0x0
  801839:	50                   	push   %eax
  80183a:	6a 22                	push   $0x22
  80183c:	e8 0b fc ff ff       	call   80144c <syscall>
  801841:	83 c4 18             	add    $0x18,%esp
}
  801844:	90                   	nop
  801845:	c9                   	leave  
  801846:	c3                   	ret    

00801847 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801847:	55                   	push   %ebp
  801848:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80184a:	8b 45 08             	mov    0x8(%ebp),%eax
  80184d:	6a 00                	push   $0x0
  80184f:	6a 00                	push   $0x0
  801851:	6a 00                	push   $0x0
  801853:	6a 00                	push   $0x0
  801855:	50                   	push   %eax
  801856:	6a 23                	push   $0x23
  801858:	e8 ef fb ff ff       	call   80144c <syscall>
  80185d:	83 c4 18             	add    $0x18,%esp
}
  801860:	90                   	nop
  801861:	c9                   	leave  
  801862:	c3                   	ret    

00801863 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801863:	55                   	push   %ebp
  801864:	89 e5                	mov    %esp,%ebp
  801866:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801869:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80186c:	8d 50 04             	lea    0x4(%eax),%edx
  80186f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801872:	6a 00                	push   $0x0
  801874:	6a 00                	push   $0x0
  801876:	6a 00                	push   $0x0
  801878:	52                   	push   %edx
  801879:	50                   	push   %eax
  80187a:	6a 24                	push   $0x24
  80187c:	e8 cb fb ff ff       	call   80144c <syscall>
  801881:	83 c4 18             	add    $0x18,%esp
	return result;
  801884:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801887:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80188a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80188d:	89 01                	mov    %eax,(%ecx)
  80188f:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801892:	8b 45 08             	mov    0x8(%ebp),%eax
  801895:	c9                   	leave  
  801896:	c2 04 00             	ret    $0x4

00801899 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801899:	55                   	push   %ebp
  80189a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	ff 75 10             	pushl  0x10(%ebp)
  8018a3:	ff 75 0c             	pushl  0xc(%ebp)
  8018a6:	ff 75 08             	pushl  0x8(%ebp)
  8018a9:	6a 13                	push   $0x13
  8018ab:	e8 9c fb ff ff       	call   80144c <syscall>
  8018b0:	83 c4 18             	add    $0x18,%esp
	return ;
  8018b3:	90                   	nop
}
  8018b4:	c9                   	leave  
  8018b5:	c3                   	ret    

008018b6 <sys_rcr2>:
uint32 sys_rcr2()
{
  8018b6:	55                   	push   %ebp
  8018b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8018b9:	6a 00                	push   $0x0
  8018bb:	6a 00                	push   $0x0
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 25                	push   $0x25
  8018c5:	e8 82 fb ff ff       	call   80144c <syscall>
  8018ca:	83 c4 18             	add    $0x18,%esp
}
  8018cd:	c9                   	leave  
  8018ce:	c3                   	ret    

008018cf <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8018cf:	55                   	push   %ebp
  8018d0:	89 e5                	mov    %esp,%ebp
  8018d2:	83 ec 04             	sub    $0x4,%esp
  8018d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8018db:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	6a 00                	push   $0x0
  8018e5:	6a 00                	push   $0x0
  8018e7:	50                   	push   %eax
  8018e8:	6a 26                	push   $0x26
  8018ea:	e8 5d fb ff ff       	call   80144c <syscall>
  8018ef:	83 c4 18             	add    $0x18,%esp
	return ;
  8018f2:	90                   	nop
}
  8018f3:	c9                   	leave  
  8018f4:	c3                   	ret    

008018f5 <rsttst>:
void rsttst()
{
  8018f5:	55                   	push   %ebp
  8018f6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8018f8:	6a 00                	push   $0x0
  8018fa:	6a 00                	push   $0x0
  8018fc:	6a 00                	push   $0x0
  8018fe:	6a 00                	push   $0x0
  801900:	6a 00                	push   $0x0
  801902:	6a 28                	push   $0x28
  801904:	e8 43 fb ff ff       	call   80144c <syscall>
  801909:	83 c4 18             	add    $0x18,%esp
	return ;
  80190c:	90                   	nop
}
  80190d:	c9                   	leave  
  80190e:	c3                   	ret    

0080190f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80190f:	55                   	push   %ebp
  801910:	89 e5                	mov    %esp,%ebp
  801912:	83 ec 04             	sub    $0x4,%esp
  801915:	8b 45 14             	mov    0x14(%ebp),%eax
  801918:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80191b:	8b 55 18             	mov    0x18(%ebp),%edx
  80191e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801922:	52                   	push   %edx
  801923:	50                   	push   %eax
  801924:	ff 75 10             	pushl  0x10(%ebp)
  801927:	ff 75 0c             	pushl  0xc(%ebp)
  80192a:	ff 75 08             	pushl  0x8(%ebp)
  80192d:	6a 27                	push   $0x27
  80192f:	e8 18 fb ff ff       	call   80144c <syscall>
  801934:	83 c4 18             	add    $0x18,%esp
	return ;
  801937:	90                   	nop
}
  801938:	c9                   	leave  
  801939:	c3                   	ret    

0080193a <chktst>:
void chktst(uint32 n)
{
  80193a:	55                   	push   %ebp
  80193b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80193d:	6a 00                	push   $0x0
  80193f:	6a 00                	push   $0x0
  801941:	6a 00                	push   $0x0
  801943:	6a 00                	push   $0x0
  801945:	ff 75 08             	pushl  0x8(%ebp)
  801948:	6a 29                	push   $0x29
  80194a:	e8 fd fa ff ff       	call   80144c <syscall>
  80194f:	83 c4 18             	add    $0x18,%esp
	return ;
  801952:	90                   	nop
}
  801953:	c9                   	leave  
  801954:	c3                   	ret    

00801955 <inctst>:

void inctst()
{
  801955:	55                   	push   %ebp
  801956:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801958:	6a 00                	push   $0x0
  80195a:	6a 00                	push   $0x0
  80195c:	6a 00                	push   $0x0
  80195e:	6a 00                	push   $0x0
  801960:	6a 00                	push   $0x0
  801962:	6a 2a                	push   $0x2a
  801964:	e8 e3 fa ff ff       	call   80144c <syscall>
  801969:	83 c4 18             	add    $0x18,%esp
	return ;
  80196c:	90                   	nop
}
  80196d:	c9                   	leave  
  80196e:	c3                   	ret    

0080196f <gettst>:
uint32 gettst()
{
  80196f:	55                   	push   %ebp
  801970:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801972:	6a 00                	push   $0x0
  801974:	6a 00                	push   $0x0
  801976:	6a 00                	push   $0x0
  801978:	6a 00                	push   $0x0
  80197a:	6a 00                	push   $0x0
  80197c:	6a 2b                	push   $0x2b
  80197e:	e8 c9 fa ff ff       	call   80144c <syscall>
  801983:	83 c4 18             	add    $0x18,%esp
}
  801986:	c9                   	leave  
  801987:	c3                   	ret    

00801988 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801988:	55                   	push   %ebp
  801989:	89 e5                	mov    %esp,%ebp
  80198b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80198e:	6a 00                	push   $0x0
  801990:	6a 00                	push   $0x0
  801992:	6a 00                	push   $0x0
  801994:	6a 00                	push   $0x0
  801996:	6a 00                	push   $0x0
  801998:	6a 2c                	push   $0x2c
  80199a:	e8 ad fa ff ff       	call   80144c <syscall>
  80199f:	83 c4 18             	add    $0x18,%esp
  8019a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8019a5:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8019a9:	75 07                	jne    8019b2 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8019ab:	b8 01 00 00 00       	mov    $0x1,%eax
  8019b0:	eb 05                	jmp    8019b7 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8019b2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019b7:	c9                   	leave  
  8019b8:	c3                   	ret    

008019b9 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8019b9:	55                   	push   %ebp
  8019ba:	89 e5                	mov    %esp,%ebp
  8019bc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019bf:	6a 00                	push   $0x0
  8019c1:	6a 00                	push   $0x0
  8019c3:	6a 00                	push   $0x0
  8019c5:	6a 00                	push   $0x0
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 2c                	push   $0x2c
  8019cb:	e8 7c fa ff ff       	call   80144c <syscall>
  8019d0:	83 c4 18             	add    $0x18,%esp
  8019d3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8019d6:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8019da:	75 07                	jne    8019e3 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8019dc:	b8 01 00 00 00       	mov    $0x1,%eax
  8019e1:	eb 05                	jmp    8019e8 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8019e3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019e8:	c9                   	leave  
  8019e9:	c3                   	ret    

008019ea <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8019ea:	55                   	push   %ebp
  8019eb:	89 e5                	mov    %esp,%ebp
  8019ed:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019f0:	6a 00                	push   $0x0
  8019f2:	6a 00                	push   $0x0
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 00                	push   $0x0
  8019f8:	6a 00                	push   $0x0
  8019fa:	6a 2c                	push   $0x2c
  8019fc:	e8 4b fa ff ff       	call   80144c <syscall>
  801a01:	83 c4 18             	add    $0x18,%esp
  801a04:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801a07:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801a0b:	75 07                	jne    801a14 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801a0d:	b8 01 00 00 00       	mov    $0x1,%eax
  801a12:	eb 05                	jmp    801a19 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801a14:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a19:	c9                   	leave  
  801a1a:	c3                   	ret    

00801a1b <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801a1b:	55                   	push   %ebp
  801a1c:	89 e5                	mov    %esp,%ebp
  801a1e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a21:	6a 00                	push   $0x0
  801a23:	6a 00                	push   $0x0
  801a25:	6a 00                	push   $0x0
  801a27:	6a 00                	push   $0x0
  801a29:	6a 00                	push   $0x0
  801a2b:	6a 2c                	push   $0x2c
  801a2d:	e8 1a fa ff ff       	call   80144c <syscall>
  801a32:	83 c4 18             	add    $0x18,%esp
  801a35:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801a38:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801a3c:	75 07                	jne    801a45 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801a3e:	b8 01 00 00 00       	mov    $0x1,%eax
  801a43:	eb 05                	jmp    801a4a <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801a45:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a4a:	c9                   	leave  
  801a4b:	c3                   	ret    

00801a4c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801a4c:	55                   	push   %ebp
  801a4d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801a4f:	6a 00                	push   $0x0
  801a51:	6a 00                	push   $0x0
  801a53:	6a 00                	push   $0x0
  801a55:	6a 00                	push   $0x0
  801a57:	ff 75 08             	pushl  0x8(%ebp)
  801a5a:	6a 2d                	push   $0x2d
  801a5c:	e8 eb f9 ff ff       	call   80144c <syscall>
  801a61:	83 c4 18             	add    $0x18,%esp
	return ;
  801a64:	90                   	nop
}
  801a65:	c9                   	leave  
  801a66:	c3                   	ret    

00801a67 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801a67:	55                   	push   %ebp
  801a68:	89 e5                	mov    %esp,%ebp
  801a6a:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801a6b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a6e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a71:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a74:	8b 45 08             	mov    0x8(%ebp),%eax
  801a77:	6a 00                	push   $0x0
  801a79:	53                   	push   %ebx
  801a7a:	51                   	push   %ecx
  801a7b:	52                   	push   %edx
  801a7c:	50                   	push   %eax
  801a7d:	6a 2e                	push   $0x2e
  801a7f:	e8 c8 f9 ff ff       	call   80144c <syscall>
  801a84:	83 c4 18             	add    $0x18,%esp
}
  801a87:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801a8a:	c9                   	leave  
  801a8b:	c3                   	ret    

00801a8c <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801a8c:	55                   	push   %ebp
  801a8d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801a8f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a92:	8b 45 08             	mov    0x8(%ebp),%eax
  801a95:	6a 00                	push   $0x0
  801a97:	6a 00                	push   $0x0
  801a99:	6a 00                	push   $0x0
  801a9b:	52                   	push   %edx
  801a9c:	50                   	push   %eax
  801a9d:	6a 2f                	push   $0x2f
  801a9f:	e8 a8 f9 ff ff       	call   80144c <syscall>
  801aa4:	83 c4 18             	add    $0x18,%esp
}
  801aa7:	c9                   	leave  
  801aa8:	c3                   	ret    
  801aa9:	66 90                	xchg   %ax,%ax
  801aab:	90                   	nop

00801aac <__udivdi3>:
  801aac:	55                   	push   %ebp
  801aad:	57                   	push   %edi
  801aae:	56                   	push   %esi
  801aaf:	53                   	push   %ebx
  801ab0:	83 ec 1c             	sub    $0x1c,%esp
  801ab3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801ab7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801abb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801abf:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801ac3:	89 ca                	mov    %ecx,%edx
  801ac5:	89 f8                	mov    %edi,%eax
  801ac7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801acb:	85 f6                	test   %esi,%esi
  801acd:	75 2d                	jne    801afc <__udivdi3+0x50>
  801acf:	39 cf                	cmp    %ecx,%edi
  801ad1:	77 65                	ja     801b38 <__udivdi3+0x8c>
  801ad3:	89 fd                	mov    %edi,%ebp
  801ad5:	85 ff                	test   %edi,%edi
  801ad7:	75 0b                	jne    801ae4 <__udivdi3+0x38>
  801ad9:	b8 01 00 00 00       	mov    $0x1,%eax
  801ade:	31 d2                	xor    %edx,%edx
  801ae0:	f7 f7                	div    %edi
  801ae2:	89 c5                	mov    %eax,%ebp
  801ae4:	31 d2                	xor    %edx,%edx
  801ae6:	89 c8                	mov    %ecx,%eax
  801ae8:	f7 f5                	div    %ebp
  801aea:	89 c1                	mov    %eax,%ecx
  801aec:	89 d8                	mov    %ebx,%eax
  801aee:	f7 f5                	div    %ebp
  801af0:	89 cf                	mov    %ecx,%edi
  801af2:	89 fa                	mov    %edi,%edx
  801af4:	83 c4 1c             	add    $0x1c,%esp
  801af7:	5b                   	pop    %ebx
  801af8:	5e                   	pop    %esi
  801af9:	5f                   	pop    %edi
  801afa:	5d                   	pop    %ebp
  801afb:	c3                   	ret    
  801afc:	39 ce                	cmp    %ecx,%esi
  801afe:	77 28                	ja     801b28 <__udivdi3+0x7c>
  801b00:	0f bd fe             	bsr    %esi,%edi
  801b03:	83 f7 1f             	xor    $0x1f,%edi
  801b06:	75 40                	jne    801b48 <__udivdi3+0x9c>
  801b08:	39 ce                	cmp    %ecx,%esi
  801b0a:	72 0a                	jb     801b16 <__udivdi3+0x6a>
  801b0c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801b10:	0f 87 9e 00 00 00    	ja     801bb4 <__udivdi3+0x108>
  801b16:	b8 01 00 00 00       	mov    $0x1,%eax
  801b1b:	89 fa                	mov    %edi,%edx
  801b1d:	83 c4 1c             	add    $0x1c,%esp
  801b20:	5b                   	pop    %ebx
  801b21:	5e                   	pop    %esi
  801b22:	5f                   	pop    %edi
  801b23:	5d                   	pop    %ebp
  801b24:	c3                   	ret    
  801b25:	8d 76 00             	lea    0x0(%esi),%esi
  801b28:	31 ff                	xor    %edi,%edi
  801b2a:	31 c0                	xor    %eax,%eax
  801b2c:	89 fa                	mov    %edi,%edx
  801b2e:	83 c4 1c             	add    $0x1c,%esp
  801b31:	5b                   	pop    %ebx
  801b32:	5e                   	pop    %esi
  801b33:	5f                   	pop    %edi
  801b34:	5d                   	pop    %ebp
  801b35:	c3                   	ret    
  801b36:	66 90                	xchg   %ax,%ax
  801b38:	89 d8                	mov    %ebx,%eax
  801b3a:	f7 f7                	div    %edi
  801b3c:	31 ff                	xor    %edi,%edi
  801b3e:	89 fa                	mov    %edi,%edx
  801b40:	83 c4 1c             	add    $0x1c,%esp
  801b43:	5b                   	pop    %ebx
  801b44:	5e                   	pop    %esi
  801b45:	5f                   	pop    %edi
  801b46:	5d                   	pop    %ebp
  801b47:	c3                   	ret    
  801b48:	bd 20 00 00 00       	mov    $0x20,%ebp
  801b4d:	89 eb                	mov    %ebp,%ebx
  801b4f:	29 fb                	sub    %edi,%ebx
  801b51:	89 f9                	mov    %edi,%ecx
  801b53:	d3 e6                	shl    %cl,%esi
  801b55:	89 c5                	mov    %eax,%ebp
  801b57:	88 d9                	mov    %bl,%cl
  801b59:	d3 ed                	shr    %cl,%ebp
  801b5b:	89 e9                	mov    %ebp,%ecx
  801b5d:	09 f1                	or     %esi,%ecx
  801b5f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801b63:	89 f9                	mov    %edi,%ecx
  801b65:	d3 e0                	shl    %cl,%eax
  801b67:	89 c5                	mov    %eax,%ebp
  801b69:	89 d6                	mov    %edx,%esi
  801b6b:	88 d9                	mov    %bl,%cl
  801b6d:	d3 ee                	shr    %cl,%esi
  801b6f:	89 f9                	mov    %edi,%ecx
  801b71:	d3 e2                	shl    %cl,%edx
  801b73:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b77:	88 d9                	mov    %bl,%cl
  801b79:	d3 e8                	shr    %cl,%eax
  801b7b:	09 c2                	or     %eax,%edx
  801b7d:	89 d0                	mov    %edx,%eax
  801b7f:	89 f2                	mov    %esi,%edx
  801b81:	f7 74 24 0c          	divl   0xc(%esp)
  801b85:	89 d6                	mov    %edx,%esi
  801b87:	89 c3                	mov    %eax,%ebx
  801b89:	f7 e5                	mul    %ebp
  801b8b:	39 d6                	cmp    %edx,%esi
  801b8d:	72 19                	jb     801ba8 <__udivdi3+0xfc>
  801b8f:	74 0b                	je     801b9c <__udivdi3+0xf0>
  801b91:	89 d8                	mov    %ebx,%eax
  801b93:	31 ff                	xor    %edi,%edi
  801b95:	e9 58 ff ff ff       	jmp    801af2 <__udivdi3+0x46>
  801b9a:	66 90                	xchg   %ax,%ax
  801b9c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801ba0:	89 f9                	mov    %edi,%ecx
  801ba2:	d3 e2                	shl    %cl,%edx
  801ba4:	39 c2                	cmp    %eax,%edx
  801ba6:	73 e9                	jae    801b91 <__udivdi3+0xe5>
  801ba8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801bab:	31 ff                	xor    %edi,%edi
  801bad:	e9 40 ff ff ff       	jmp    801af2 <__udivdi3+0x46>
  801bb2:	66 90                	xchg   %ax,%ax
  801bb4:	31 c0                	xor    %eax,%eax
  801bb6:	e9 37 ff ff ff       	jmp    801af2 <__udivdi3+0x46>
  801bbb:	90                   	nop

00801bbc <__umoddi3>:
  801bbc:	55                   	push   %ebp
  801bbd:	57                   	push   %edi
  801bbe:	56                   	push   %esi
  801bbf:	53                   	push   %ebx
  801bc0:	83 ec 1c             	sub    $0x1c,%esp
  801bc3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801bc7:	8b 74 24 34          	mov    0x34(%esp),%esi
  801bcb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801bcf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801bd3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801bd7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801bdb:	89 f3                	mov    %esi,%ebx
  801bdd:	89 fa                	mov    %edi,%edx
  801bdf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801be3:	89 34 24             	mov    %esi,(%esp)
  801be6:	85 c0                	test   %eax,%eax
  801be8:	75 1a                	jne    801c04 <__umoddi3+0x48>
  801bea:	39 f7                	cmp    %esi,%edi
  801bec:	0f 86 a2 00 00 00    	jbe    801c94 <__umoddi3+0xd8>
  801bf2:	89 c8                	mov    %ecx,%eax
  801bf4:	89 f2                	mov    %esi,%edx
  801bf6:	f7 f7                	div    %edi
  801bf8:	89 d0                	mov    %edx,%eax
  801bfa:	31 d2                	xor    %edx,%edx
  801bfc:	83 c4 1c             	add    $0x1c,%esp
  801bff:	5b                   	pop    %ebx
  801c00:	5e                   	pop    %esi
  801c01:	5f                   	pop    %edi
  801c02:	5d                   	pop    %ebp
  801c03:	c3                   	ret    
  801c04:	39 f0                	cmp    %esi,%eax
  801c06:	0f 87 ac 00 00 00    	ja     801cb8 <__umoddi3+0xfc>
  801c0c:	0f bd e8             	bsr    %eax,%ebp
  801c0f:	83 f5 1f             	xor    $0x1f,%ebp
  801c12:	0f 84 ac 00 00 00    	je     801cc4 <__umoddi3+0x108>
  801c18:	bf 20 00 00 00       	mov    $0x20,%edi
  801c1d:	29 ef                	sub    %ebp,%edi
  801c1f:	89 fe                	mov    %edi,%esi
  801c21:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c25:	89 e9                	mov    %ebp,%ecx
  801c27:	d3 e0                	shl    %cl,%eax
  801c29:	89 d7                	mov    %edx,%edi
  801c2b:	89 f1                	mov    %esi,%ecx
  801c2d:	d3 ef                	shr    %cl,%edi
  801c2f:	09 c7                	or     %eax,%edi
  801c31:	89 e9                	mov    %ebp,%ecx
  801c33:	d3 e2                	shl    %cl,%edx
  801c35:	89 14 24             	mov    %edx,(%esp)
  801c38:	89 d8                	mov    %ebx,%eax
  801c3a:	d3 e0                	shl    %cl,%eax
  801c3c:	89 c2                	mov    %eax,%edx
  801c3e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c42:	d3 e0                	shl    %cl,%eax
  801c44:	89 44 24 04          	mov    %eax,0x4(%esp)
  801c48:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c4c:	89 f1                	mov    %esi,%ecx
  801c4e:	d3 e8                	shr    %cl,%eax
  801c50:	09 d0                	or     %edx,%eax
  801c52:	d3 eb                	shr    %cl,%ebx
  801c54:	89 da                	mov    %ebx,%edx
  801c56:	f7 f7                	div    %edi
  801c58:	89 d3                	mov    %edx,%ebx
  801c5a:	f7 24 24             	mull   (%esp)
  801c5d:	89 c6                	mov    %eax,%esi
  801c5f:	89 d1                	mov    %edx,%ecx
  801c61:	39 d3                	cmp    %edx,%ebx
  801c63:	0f 82 87 00 00 00    	jb     801cf0 <__umoddi3+0x134>
  801c69:	0f 84 91 00 00 00    	je     801d00 <__umoddi3+0x144>
  801c6f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801c73:	29 f2                	sub    %esi,%edx
  801c75:	19 cb                	sbb    %ecx,%ebx
  801c77:	89 d8                	mov    %ebx,%eax
  801c79:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801c7d:	d3 e0                	shl    %cl,%eax
  801c7f:	89 e9                	mov    %ebp,%ecx
  801c81:	d3 ea                	shr    %cl,%edx
  801c83:	09 d0                	or     %edx,%eax
  801c85:	89 e9                	mov    %ebp,%ecx
  801c87:	d3 eb                	shr    %cl,%ebx
  801c89:	89 da                	mov    %ebx,%edx
  801c8b:	83 c4 1c             	add    $0x1c,%esp
  801c8e:	5b                   	pop    %ebx
  801c8f:	5e                   	pop    %esi
  801c90:	5f                   	pop    %edi
  801c91:	5d                   	pop    %ebp
  801c92:	c3                   	ret    
  801c93:	90                   	nop
  801c94:	89 fd                	mov    %edi,%ebp
  801c96:	85 ff                	test   %edi,%edi
  801c98:	75 0b                	jne    801ca5 <__umoddi3+0xe9>
  801c9a:	b8 01 00 00 00       	mov    $0x1,%eax
  801c9f:	31 d2                	xor    %edx,%edx
  801ca1:	f7 f7                	div    %edi
  801ca3:	89 c5                	mov    %eax,%ebp
  801ca5:	89 f0                	mov    %esi,%eax
  801ca7:	31 d2                	xor    %edx,%edx
  801ca9:	f7 f5                	div    %ebp
  801cab:	89 c8                	mov    %ecx,%eax
  801cad:	f7 f5                	div    %ebp
  801caf:	89 d0                	mov    %edx,%eax
  801cb1:	e9 44 ff ff ff       	jmp    801bfa <__umoddi3+0x3e>
  801cb6:	66 90                	xchg   %ax,%ax
  801cb8:	89 c8                	mov    %ecx,%eax
  801cba:	89 f2                	mov    %esi,%edx
  801cbc:	83 c4 1c             	add    $0x1c,%esp
  801cbf:	5b                   	pop    %ebx
  801cc0:	5e                   	pop    %esi
  801cc1:	5f                   	pop    %edi
  801cc2:	5d                   	pop    %ebp
  801cc3:	c3                   	ret    
  801cc4:	3b 04 24             	cmp    (%esp),%eax
  801cc7:	72 06                	jb     801ccf <__umoddi3+0x113>
  801cc9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801ccd:	77 0f                	ja     801cde <__umoddi3+0x122>
  801ccf:	89 f2                	mov    %esi,%edx
  801cd1:	29 f9                	sub    %edi,%ecx
  801cd3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801cd7:	89 14 24             	mov    %edx,(%esp)
  801cda:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801cde:	8b 44 24 04          	mov    0x4(%esp),%eax
  801ce2:	8b 14 24             	mov    (%esp),%edx
  801ce5:	83 c4 1c             	add    $0x1c,%esp
  801ce8:	5b                   	pop    %ebx
  801ce9:	5e                   	pop    %esi
  801cea:	5f                   	pop    %edi
  801ceb:	5d                   	pop    %ebp
  801cec:	c3                   	ret    
  801ced:	8d 76 00             	lea    0x0(%esi),%esi
  801cf0:	2b 04 24             	sub    (%esp),%eax
  801cf3:	19 fa                	sbb    %edi,%edx
  801cf5:	89 d1                	mov    %edx,%ecx
  801cf7:	89 c6                	mov    %eax,%esi
  801cf9:	e9 71 ff ff ff       	jmp    801c6f <__umoddi3+0xb3>
  801cfe:	66 90                	xchg   %ax,%ax
  801d00:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801d04:	72 ea                	jb     801cf0 <__umoddi3+0x134>
  801d06:	89 d9                	mov    %ebx,%ecx
  801d08:	e9 62 ff ff ff       	jmp    801c6f <__umoddi3+0xb3>
