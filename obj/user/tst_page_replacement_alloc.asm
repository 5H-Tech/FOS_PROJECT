
obj/user/tst_page_replacement_alloc:     file format elf32-i386


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
  800031:	e8 49 03 00 00       	call   80037f <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
char arr[PAGE_SIZE*12];
char* ptr = (char* )0x0801000 ;
char* ptr2 = (char* )0x0804000 ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	83 ec 44             	sub    $0x44,%esp

//	cprintf("envID = %d\n",envID);

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80003f:	a1 20 30 80 00       	mov    0x803020,%eax
  800044:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80004a:	8b 00                	mov    (%eax),%eax
  80004c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80004f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800052:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800057:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005c:	74 14                	je     800072 <_main+0x3a>
  80005e:	83 ec 04             	sub    $0x4,%esp
  800061:	68 c0 1d 80 00       	push   $0x801dc0
  800066:	6a 12                	push   $0x12
  800068:	68 04 1e 80 00       	push   $0x801e04
  80006d:	e8 52 04 00 00       	call   8004c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800072:	a1 20 30 80 00       	mov    0x803020,%eax
  800077:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80007d:	83 c0 10             	add    $0x10,%eax
  800080:	8b 00                	mov    (%eax),%eax
  800082:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800085:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800088:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008d:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800092:	74 14                	je     8000a8 <_main+0x70>
  800094:	83 ec 04             	sub    $0x4,%esp
  800097:	68 c0 1d 80 00       	push   $0x801dc0
  80009c:	6a 13                	push   $0x13
  80009e:	68 04 1e 80 00       	push   $0x801e04
  8000a3:	e8 1c 04 00 00       	call   8004c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ad:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000b3:	83 c0 20             	add    $0x20,%eax
  8000b6:	8b 00                	mov    (%eax),%eax
  8000b8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8000bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000be:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c3:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c8:	74 14                	je     8000de <_main+0xa6>
  8000ca:	83 ec 04             	sub    $0x4,%esp
  8000cd:	68 c0 1d 80 00       	push   $0x801dc0
  8000d2:	6a 14                	push   $0x14
  8000d4:	68 04 1e 80 00       	push   $0x801e04
  8000d9:	e8 e6 03 00 00       	call   8004c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000de:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000e9:	83 c0 30             	add    $0x30,%eax
  8000ec:	8b 00                	mov    (%eax),%eax
  8000ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8000f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f9:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fe:	74 14                	je     800114 <_main+0xdc>
  800100:	83 ec 04             	sub    $0x4,%esp
  800103:	68 c0 1d 80 00       	push   $0x801dc0
  800108:	6a 15                	push   $0x15
  80010a:	68 04 1e 80 00       	push   $0x801e04
  80010f:	e8 b0 03 00 00       	call   8004c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800114:	a1 20 30 80 00       	mov    0x803020,%eax
  800119:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80011f:	83 c0 40             	add    $0x40,%eax
  800122:	8b 00                	mov    (%eax),%eax
  800124:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800127:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80012a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012f:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800134:	74 14                	je     80014a <_main+0x112>
  800136:	83 ec 04             	sub    $0x4,%esp
  800139:	68 c0 1d 80 00       	push   $0x801dc0
  80013e:	6a 16                	push   $0x16
  800140:	68 04 1e 80 00       	push   $0x801e04
  800145:	e8 7a 03 00 00       	call   8004c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80014a:	a1 20 30 80 00       	mov    0x803020,%eax
  80014f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800155:	83 c0 50             	add    $0x50,%eax
  800158:	8b 00                	mov    (%eax),%eax
  80015a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80015d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800160:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800165:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80016a:	74 14                	je     800180 <_main+0x148>
  80016c:	83 ec 04             	sub    $0x4,%esp
  80016f:	68 c0 1d 80 00       	push   $0x801dc0
  800174:	6a 17                	push   $0x17
  800176:	68 04 1e 80 00       	push   $0x801e04
  80017b:	e8 44 03 00 00       	call   8004c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800180:	a1 20 30 80 00       	mov    0x803020,%eax
  800185:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80018b:	83 c0 60             	add    $0x60,%eax
  80018e:	8b 00                	mov    (%eax),%eax
  800190:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800193:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800196:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019b:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001a0:	74 14                	je     8001b6 <_main+0x17e>
  8001a2:	83 ec 04             	sub    $0x4,%esp
  8001a5:	68 c0 1d 80 00       	push   $0x801dc0
  8001aa:	6a 18                	push   $0x18
  8001ac:	68 04 1e 80 00       	push   $0x801e04
  8001b1:	e8 0e 03 00 00       	call   8004c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001b6:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bb:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001c1:	83 c0 70             	add    $0x70,%eax
  8001c4:	8b 00                	mov    (%eax),%eax
  8001c6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8001c9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8001cc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d1:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d6:	74 14                	je     8001ec <_main+0x1b4>
  8001d8:	83 ec 04             	sub    $0x4,%esp
  8001db:	68 c0 1d 80 00       	push   $0x801dc0
  8001e0:	6a 19                	push   $0x19
  8001e2:	68 04 1e 80 00       	push   $0x801e04
  8001e7:	e8 d8 02 00 00       	call   8004c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001ec:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f1:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001f7:	83 e8 80             	sub    $0xffffff80,%eax
  8001fa:	8b 00                	mov    (%eax),%eax
  8001fc:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8001ff:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800202:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800207:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80020c:	74 14                	je     800222 <_main+0x1ea>
  80020e:	83 ec 04             	sub    $0x4,%esp
  800211:	68 c0 1d 80 00       	push   $0x801dc0
  800216:	6a 1a                	push   $0x1a
  800218:	68 04 1e 80 00       	push   $0x801e04
  80021d:	e8 a2 02 00 00       	call   8004c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800222:	a1 20 30 80 00       	mov    0x803020,%eax
  800227:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80022d:	05 90 00 00 00       	add    $0x90,%eax
  800232:	8b 00                	mov    (%eax),%eax
  800234:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800237:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80023a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80023f:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800244:	74 14                	je     80025a <_main+0x222>
  800246:	83 ec 04             	sub    $0x4,%esp
  800249:	68 c0 1d 80 00       	push   $0x801dc0
  80024e:	6a 1b                	push   $0x1b
  800250:	68 04 1e 80 00       	push   $0x801e04
  800255:	e8 6a 02 00 00       	call   8004c4 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80025a:	a1 20 30 80 00       	mov    0x803020,%eax
  80025f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800265:	05 a0 00 00 00       	add    $0xa0,%eax
  80026a:	8b 00                	mov    (%eax),%eax
  80026c:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80026f:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800272:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800277:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80027c:	74 14                	je     800292 <_main+0x25a>
  80027e:	83 ec 04             	sub    $0x4,%esp
  800281:	68 c0 1d 80 00       	push   $0x801dc0
  800286:	6a 1c                	push   $0x1c
  800288:	68 04 1e 80 00       	push   $0x801e04
  80028d:	e8 32 02 00 00       	call   8004c4 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  800292:	a1 20 30 80 00       	mov    0x803020,%eax
  800297:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  80029d:	85 c0                	test   %eax,%eax
  80029f:	74 14                	je     8002b5 <_main+0x27d>
  8002a1:	83 ec 04             	sub    $0x4,%esp
  8002a4:	68 28 1e 80 00       	push   $0x801e28
  8002a9:	6a 1d                	push   $0x1d
  8002ab:	68 04 1e 80 00       	push   $0x801e04
  8002b0:	e8 0f 02 00 00       	call   8004c4 <_panic>
	}

	int freePages = sys_calculate_free_frames();
  8002b5:	e8 a2 13 00 00       	call   80165c <sys_calculate_free_frames>
  8002ba:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  8002bd:	e8 1d 14 00 00       	call   8016df <sys_pf_calculate_allocated_pages>
  8002c2:	89 45 c0             	mov    %eax,-0x40(%ebp)

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1] ;
  8002c5:	a0 3f e0 80 00       	mov    0x80e03f,%al
  8002ca:	88 45 bf             	mov    %al,-0x41(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1] ;
  8002cd:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8002d2:	88 45 be             	mov    %al,-0x42(%ebp)

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8002dc:	eb 37                	jmp    800315 <_main+0x2dd>
	{
		arr[i] = -1 ;
  8002de:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002e1:	05 40 30 80 00       	add    $0x803040,%eax
  8002e6:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		*ptr2 = *ptr ;
  8002e9:	a1 04 30 80 00       	mov    0x803004,%eax
  8002ee:	8b 15 00 30 80 00    	mov    0x803000,%edx
  8002f4:	8a 12                	mov    (%edx),%dl
  8002f6:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  8002f8:	a1 00 30 80 00       	mov    0x803000,%eax
  8002fd:	40                   	inc    %eax
  8002fe:	a3 00 30 80 00       	mov    %eax,0x803000
  800303:	a1 04 30 80 00       	mov    0x803004,%eax
  800308:	40                   	inc    %eax
  800309:	a3 04 30 80 00       	mov    %eax,0x803004
	char garbage1 = arr[PAGE_SIZE*11-1] ;
	char garbage2 = arr[PAGE_SIZE*12-1] ;

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  80030e:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  800315:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  80031c:	7e c0                	jle    8002de <_main+0x2a6>

	//===================

	//cprintf("Checking Allocation in Mem & Page File... \n");
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  80031e:	e8 bc 13 00 00       	call   8016df <sys_pf_calculate_allocated_pages>
  800323:	3b 45 c0             	cmp    -0x40(%ebp),%eax
  800326:	74 14                	je     80033c <_main+0x304>
  800328:	83 ec 04             	sub    $0x4,%esp
  80032b:	68 70 1e 80 00       	push   $0x801e70
  800330:	6a 38                	push   $0x38
  800332:	68 04 1e 80 00       	push   $0x801e04
  800337:	e8 88 01 00 00       	call   8004c4 <_panic>

		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  80033c:	e8 1b 13 00 00       	call   80165c <sys_calculate_free_frames>
  800341:	89 c3                	mov    %eax,%ebx
  800343:	e8 2d 13 00 00       	call   801675 <sys_calculate_modified_frames>
  800348:	01 d8                	add    %ebx,%eax
  80034a:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if( (freePages - freePagesAfter) != 0 )
  80034d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800350:	3b 45 b8             	cmp    -0x48(%ebp),%eax
  800353:	74 14                	je     800369 <_main+0x331>
			panic("Extra memory are wrongly allocated... It's REplacement: expected that no extra frames are allocated");
  800355:	83 ec 04             	sub    $0x4,%esp
  800358:	68 dc 1e 80 00       	push   $0x801edc
  80035d:	6a 3c                	push   $0x3c
  80035f:	68 04 1e 80 00       	push   $0x801e04
  800364:	e8 5b 01 00 00       	call   8004c4 <_panic>

	}

	cprintf("Congratulations!! test PAGE replacement [ALLOCATION] by REMOVING ONLY ONE PAGE is completed successfully.\n");
  800369:	83 ec 0c             	sub    $0xc,%esp
  80036c:	68 40 1f 80 00       	push   $0x801f40
  800371:	e8 f0 03 00 00       	call   800766 <cprintf>
  800376:	83 c4 10             	add    $0x10,%esp
	return;
  800379:	90                   	nop
}
  80037a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80037d:	c9                   	leave  
  80037e:	c3                   	ret    

0080037f <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80037f:	55                   	push   %ebp
  800380:	89 e5                	mov    %esp,%ebp
  800382:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800385:	e8 07 12 00 00       	call   801591 <sys_getenvindex>
  80038a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80038d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800390:	89 d0                	mov    %edx,%eax
  800392:	c1 e0 03             	shl    $0x3,%eax
  800395:	01 d0                	add    %edx,%eax
  800397:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80039e:	01 c8                	add    %ecx,%eax
  8003a0:	01 c0                	add    %eax,%eax
  8003a2:	01 d0                	add    %edx,%eax
  8003a4:	01 c0                	add    %eax,%eax
  8003a6:	01 d0                	add    %edx,%eax
  8003a8:	89 c2                	mov    %eax,%edx
  8003aa:	c1 e2 05             	shl    $0x5,%edx
  8003ad:	29 c2                	sub    %eax,%edx
  8003af:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8003b6:	89 c2                	mov    %eax,%edx
  8003b8:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8003be:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8003c3:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c8:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8003ce:	84 c0                	test   %al,%al
  8003d0:	74 0f                	je     8003e1 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8003d2:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d7:	05 40 3c 01 00       	add    $0x13c40,%eax
  8003dc:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8003e1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8003e5:	7e 0a                	jle    8003f1 <libmain+0x72>
		binaryname = argv[0];
  8003e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ea:	8b 00                	mov    (%eax),%eax
  8003ec:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  8003f1:	83 ec 08             	sub    $0x8,%esp
  8003f4:	ff 75 0c             	pushl  0xc(%ebp)
  8003f7:	ff 75 08             	pushl  0x8(%ebp)
  8003fa:	e8 39 fc ff ff       	call   800038 <_main>
  8003ff:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800402:	e8 25 13 00 00       	call   80172c <sys_disable_interrupt>
	cprintf("**************************************\n");
  800407:	83 ec 0c             	sub    $0xc,%esp
  80040a:	68 c4 1f 80 00       	push   $0x801fc4
  80040f:	e8 52 03 00 00       	call   800766 <cprintf>
  800414:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800417:	a1 20 30 80 00       	mov    0x803020,%eax
  80041c:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800422:	a1 20 30 80 00       	mov    0x803020,%eax
  800427:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80042d:	83 ec 04             	sub    $0x4,%esp
  800430:	52                   	push   %edx
  800431:	50                   	push   %eax
  800432:	68 ec 1f 80 00       	push   $0x801fec
  800437:	e8 2a 03 00 00       	call   800766 <cprintf>
  80043c:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80043f:	a1 20 30 80 00       	mov    0x803020,%eax
  800444:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80044a:	a1 20 30 80 00       	mov    0x803020,%eax
  80044f:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800455:	83 ec 04             	sub    $0x4,%esp
  800458:	52                   	push   %edx
  800459:	50                   	push   %eax
  80045a:	68 14 20 80 00       	push   $0x802014
  80045f:	e8 02 03 00 00       	call   800766 <cprintf>
  800464:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800467:	a1 20 30 80 00       	mov    0x803020,%eax
  80046c:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800472:	83 ec 08             	sub    $0x8,%esp
  800475:	50                   	push   %eax
  800476:	68 55 20 80 00       	push   $0x802055
  80047b:	e8 e6 02 00 00       	call   800766 <cprintf>
  800480:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800483:	83 ec 0c             	sub    $0xc,%esp
  800486:	68 c4 1f 80 00       	push   $0x801fc4
  80048b:	e8 d6 02 00 00       	call   800766 <cprintf>
  800490:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800493:	e8 ae 12 00 00       	call   801746 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800498:	e8 19 00 00 00       	call   8004b6 <exit>
}
  80049d:	90                   	nop
  80049e:	c9                   	leave  
  80049f:	c3                   	ret    

008004a0 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8004a0:	55                   	push   %ebp
  8004a1:	89 e5                	mov    %esp,%ebp
  8004a3:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8004a6:	83 ec 0c             	sub    $0xc,%esp
  8004a9:	6a 00                	push   $0x0
  8004ab:	e8 ad 10 00 00       	call   80155d <sys_env_destroy>
  8004b0:	83 c4 10             	add    $0x10,%esp
}
  8004b3:	90                   	nop
  8004b4:	c9                   	leave  
  8004b5:	c3                   	ret    

008004b6 <exit>:

void
exit(void)
{
  8004b6:	55                   	push   %ebp
  8004b7:	89 e5                	mov    %esp,%ebp
  8004b9:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8004bc:	e8 02 11 00 00       	call   8015c3 <sys_env_exit>
}
  8004c1:	90                   	nop
  8004c2:	c9                   	leave  
  8004c3:	c3                   	ret    

008004c4 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8004c4:	55                   	push   %ebp
  8004c5:	89 e5                	mov    %esp,%ebp
  8004c7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8004ca:	8d 45 10             	lea    0x10(%ebp),%eax
  8004cd:	83 c0 04             	add    $0x4,%eax
  8004d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8004d3:	a1 18 f1 80 00       	mov    0x80f118,%eax
  8004d8:	85 c0                	test   %eax,%eax
  8004da:	74 16                	je     8004f2 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8004dc:	a1 18 f1 80 00       	mov    0x80f118,%eax
  8004e1:	83 ec 08             	sub    $0x8,%esp
  8004e4:	50                   	push   %eax
  8004e5:	68 6c 20 80 00       	push   $0x80206c
  8004ea:	e8 77 02 00 00       	call   800766 <cprintf>
  8004ef:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8004f2:	a1 08 30 80 00       	mov    0x803008,%eax
  8004f7:	ff 75 0c             	pushl  0xc(%ebp)
  8004fa:	ff 75 08             	pushl  0x8(%ebp)
  8004fd:	50                   	push   %eax
  8004fe:	68 71 20 80 00       	push   $0x802071
  800503:	e8 5e 02 00 00       	call   800766 <cprintf>
  800508:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80050b:	8b 45 10             	mov    0x10(%ebp),%eax
  80050e:	83 ec 08             	sub    $0x8,%esp
  800511:	ff 75 f4             	pushl  -0xc(%ebp)
  800514:	50                   	push   %eax
  800515:	e8 e1 01 00 00       	call   8006fb <vcprintf>
  80051a:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80051d:	83 ec 08             	sub    $0x8,%esp
  800520:	6a 00                	push   $0x0
  800522:	68 8d 20 80 00       	push   $0x80208d
  800527:	e8 cf 01 00 00       	call   8006fb <vcprintf>
  80052c:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80052f:	e8 82 ff ff ff       	call   8004b6 <exit>

	// should not return here
	while (1) ;
  800534:	eb fe                	jmp    800534 <_panic+0x70>

00800536 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800536:	55                   	push   %ebp
  800537:	89 e5                	mov    %esp,%ebp
  800539:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80053c:	a1 20 30 80 00       	mov    0x803020,%eax
  800541:	8b 50 74             	mov    0x74(%eax),%edx
  800544:	8b 45 0c             	mov    0xc(%ebp),%eax
  800547:	39 c2                	cmp    %eax,%edx
  800549:	74 14                	je     80055f <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80054b:	83 ec 04             	sub    $0x4,%esp
  80054e:	68 90 20 80 00       	push   $0x802090
  800553:	6a 26                	push   $0x26
  800555:	68 dc 20 80 00       	push   $0x8020dc
  80055a:	e8 65 ff ff ff       	call   8004c4 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80055f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800566:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80056d:	e9 b6 00 00 00       	jmp    800628 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800572:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800575:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80057c:	8b 45 08             	mov    0x8(%ebp),%eax
  80057f:	01 d0                	add    %edx,%eax
  800581:	8b 00                	mov    (%eax),%eax
  800583:	85 c0                	test   %eax,%eax
  800585:	75 08                	jne    80058f <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800587:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80058a:	e9 96 00 00 00       	jmp    800625 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80058f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800596:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80059d:	eb 5d                	jmp    8005fc <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80059f:	a1 20 30 80 00       	mov    0x803020,%eax
  8005a4:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8005aa:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005ad:	c1 e2 04             	shl    $0x4,%edx
  8005b0:	01 d0                	add    %edx,%eax
  8005b2:	8a 40 04             	mov    0x4(%eax),%al
  8005b5:	84 c0                	test   %al,%al
  8005b7:	75 40                	jne    8005f9 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005b9:	a1 20 30 80 00       	mov    0x803020,%eax
  8005be:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8005c4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005c7:	c1 e2 04             	shl    $0x4,%edx
  8005ca:	01 d0                	add    %edx,%eax
  8005cc:	8b 00                	mov    (%eax),%eax
  8005ce:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8005d1:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005d4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005d9:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8005db:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005de:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e8:	01 c8                	add    %ecx,%eax
  8005ea:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005ec:	39 c2                	cmp    %eax,%edx
  8005ee:	75 09                	jne    8005f9 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8005f0:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8005f7:	eb 12                	jmp    80060b <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005f9:	ff 45 e8             	incl   -0x18(%ebp)
  8005fc:	a1 20 30 80 00       	mov    0x803020,%eax
  800601:	8b 50 74             	mov    0x74(%eax),%edx
  800604:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800607:	39 c2                	cmp    %eax,%edx
  800609:	77 94                	ja     80059f <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80060b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80060f:	75 14                	jne    800625 <CheckWSWithoutLastIndex+0xef>
			panic(
  800611:	83 ec 04             	sub    $0x4,%esp
  800614:	68 e8 20 80 00       	push   $0x8020e8
  800619:	6a 3a                	push   $0x3a
  80061b:	68 dc 20 80 00       	push   $0x8020dc
  800620:	e8 9f fe ff ff       	call   8004c4 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800625:	ff 45 f0             	incl   -0x10(%ebp)
  800628:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80062b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80062e:	0f 8c 3e ff ff ff    	jl     800572 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800634:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80063b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800642:	eb 20                	jmp    800664 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800644:	a1 20 30 80 00       	mov    0x803020,%eax
  800649:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80064f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800652:	c1 e2 04             	shl    $0x4,%edx
  800655:	01 d0                	add    %edx,%eax
  800657:	8a 40 04             	mov    0x4(%eax),%al
  80065a:	3c 01                	cmp    $0x1,%al
  80065c:	75 03                	jne    800661 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  80065e:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800661:	ff 45 e0             	incl   -0x20(%ebp)
  800664:	a1 20 30 80 00       	mov    0x803020,%eax
  800669:	8b 50 74             	mov    0x74(%eax),%edx
  80066c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80066f:	39 c2                	cmp    %eax,%edx
  800671:	77 d1                	ja     800644 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800673:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800676:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800679:	74 14                	je     80068f <CheckWSWithoutLastIndex+0x159>
		panic(
  80067b:	83 ec 04             	sub    $0x4,%esp
  80067e:	68 3c 21 80 00       	push   $0x80213c
  800683:	6a 44                	push   $0x44
  800685:	68 dc 20 80 00       	push   $0x8020dc
  80068a:	e8 35 fe ff ff       	call   8004c4 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80068f:	90                   	nop
  800690:	c9                   	leave  
  800691:	c3                   	ret    

00800692 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800692:	55                   	push   %ebp
  800693:	89 e5                	mov    %esp,%ebp
  800695:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800698:	8b 45 0c             	mov    0xc(%ebp),%eax
  80069b:	8b 00                	mov    (%eax),%eax
  80069d:	8d 48 01             	lea    0x1(%eax),%ecx
  8006a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006a3:	89 0a                	mov    %ecx,(%edx)
  8006a5:	8b 55 08             	mov    0x8(%ebp),%edx
  8006a8:	88 d1                	mov    %dl,%cl
  8006aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006ad:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8006b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006b4:	8b 00                	mov    (%eax),%eax
  8006b6:	3d ff 00 00 00       	cmp    $0xff,%eax
  8006bb:	75 2c                	jne    8006e9 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8006bd:	a0 24 30 80 00       	mov    0x803024,%al
  8006c2:	0f b6 c0             	movzbl %al,%eax
  8006c5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006c8:	8b 12                	mov    (%edx),%edx
  8006ca:	89 d1                	mov    %edx,%ecx
  8006cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006cf:	83 c2 08             	add    $0x8,%edx
  8006d2:	83 ec 04             	sub    $0x4,%esp
  8006d5:	50                   	push   %eax
  8006d6:	51                   	push   %ecx
  8006d7:	52                   	push   %edx
  8006d8:	e8 3e 0e 00 00       	call   80151b <sys_cputs>
  8006dd:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8006e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006e3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8006e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006ec:	8b 40 04             	mov    0x4(%eax),%eax
  8006ef:	8d 50 01             	lea    0x1(%eax),%edx
  8006f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006f5:	89 50 04             	mov    %edx,0x4(%eax)
}
  8006f8:	90                   	nop
  8006f9:	c9                   	leave  
  8006fa:	c3                   	ret    

008006fb <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8006fb:	55                   	push   %ebp
  8006fc:	89 e5                	mov    %esp,%ebp
  8006fe:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800704:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80070b:	00 00 00 
	b.cnt = 0;
  80070e:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800715:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800718:	ff 75 0c             	pushl  0xc(%ebp)
  80071b:	ff 75 08             	pushl  0x8(%ebp)
  80071e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800724:	50                   	push   %eax
  800725:	68 92 06 80 00       	push   $0x800692
  80072a:	e8 11 02 00 00       	call   800940 <vprintfmt>
  80072f:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800732:	a0 24 30 80 00       	mov    0x803024,%al
  800737:	0f b6 c0             	movzbl %al,%eax
  80073a:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800740:	83 ec 04             	sub    $0x4,%esp
  800743:	50                   	push   %eax
  800744:	52                   	push   %edx
  800745:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80074b:	83 c0 08             	add    $0x8,%eax
  80074e:	50                   	push   %eax
  80074f:	e8 c7 0d 00 00       	call   80151b <sys_cputs>
  800754:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800757:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80075e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800764:	c9                   	leave  
  800765:	c3                   	ret    

00800766 <cprintf>:

int cprintf(const char *fmt, ...) {
  800766:	55                   	push   %ebp
  800767:	89 e5                	mov    %esp,%ebp
  800769:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80076c:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800773:	8d 45 0c             	lea    0xc(%ebp),%eax
  800776:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800779:	8b 45 08             	mov    0x8(%ebp),%eax
  80077c:	83 ec 08             	sub    $0x8,%esp
  80077f:	ff 75 f4             	pushl  -0xc(%ebp)
  800782:	50                   	push   %eax
  800783:	e8 73 ff ff ff       	call   8006fb <vcprintf>
  800788:	83 c4 10             	add    $0x10,%esp
  80078b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80078e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800791:	c9                   	leave  
  800792:	c3                   	ret    

00800793 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800793:	55                   	push   %ebp
  800794:	89 e5                	mov    %esp,%ebp
  800796:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800799:	e8 8e 0f 00 00       	call   80172c <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80079e:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a7:	83 ec 08             	sub    $0x8,%esp
  8007aa:	ff 75 f4             	pushl  -0xc(%ebp)
  8007ad:	50                   	push   %eax
  8007ae:	e8 48 ff ff ff       	call   8006fb <vcprintf>
  8007b3:	83 c4 10             	add    $0x10,%esp
  8007b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8007b9:	e8 88 0f 00 00       	call   801746 <sys_enable_interrupt>
	return cnt;
  8007be:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007c1:	c9                   	leave  
  8007c2:	c3                   	ret    

008007c3 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8007c3:	55                   	push   %ebp
  8007c4:	89 e5                	mov    %esp,%ebp
  8007c6:	53                   	push   %ebx
  8007c7:	83 ec 14             	sub    $0x14,%esp
  8007ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8007cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8007d6:	8b 45 18             	mov    0x18(%ebp),%eax
  8007d9:	ba 00 00 00 00       	mov    $0x0,%edx
  8007de:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007e1:	77 55                	ja     800838 <printnum+0x75>
  8007e3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007e6:	72 05                	jb     8007ed <printnum+0x2a>
  8007e8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8007eb:	77 4b                	ja     800838 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8007ed:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8007f0:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8007f3:	8b 45 18             	mov    0x18(%ebp),%eax
  8007f6:	ba 00 00 00 00       	mov    $0x0,%edx
  8007fb:	52                   	push   %edx
  8007fc:	50                   	push   %eax
  8007fd:	ff 75 f4             	pushl  -0xc(%ebp)
  800800:	ff 75 f0             	pushl  -0x10(%ebp)
  800803:	e8 48 13 00 00       	call   801b50 <__udivdi3>
  800808:	83 c4 10             	add    $0x10,%esp
  80080b:	83 ec 04             	sub    $0x4,%esp
  80080e:	ff 75 20             	pushl  0x20(%ebp)
  800811:	53                   	push   %ebx
  800812:	ff 75 18             	pushl  0x18(%ebp)
  800815:	52                   	push   %edx
  800816:	50                   	push   %eax
  800817:	ff 75 0c             	pushl  0xc(%ebp)
  80081a:	ff 75 08             	pushl  0x8(%ebp)
  80081d:	e8 a1 ff ff ff       	call   8007c3 <printnum>
  800822:	83 c4 20             	add    $0x20,%esp
  800825:	eb 1a                	jmp    800841 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800827:	83 ec 08             	sub    $0x8,%esp
  80082a:	ff 75 0c             	pushl  0xc(%ebp)
  80082d:	ff 75 20             	pushl  0x20(%ebp)
  800830:	8b 45 08             	mov    0x8(%ebp),%eax
  800833:	ff d0                	call   *%eax
  800835:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800838:	ff 4d 1c             	decl   0x1c(%ebp)
  80083b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80083f:	7f e6                	jg     800827 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800841:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800844:	bb 00 00 00 00       	mov    $0x0,%ebx
  800849:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80084c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80084f:	53                   	push   %ebx
  800850:	51                   	push   %ecx
  800851:	52                   	push   %edx
  800852:	50                   	push   %eax
  800853:	e8 08 14 00 00       	call   801c60 <__umoddi3>
  800858:	83 c4 10             	add    $0x10,%esp
  80085b:	05 b4 23 80 00       	add    $0x8023b4,%eax
  800860:	8a 00                	mov    (%eax),%al
  800862:	0f be c0             	movsbl %al,%eax
  800865:	83 ec 08             	sub    $0x8,%esp
  800868:	ff 75 0c             	pushl  0xc(%ebp)
  80086b:	50                   	push   %eax
  80086c:	8b 45 08             	mov    0x8(%ebp),%eax
  80086f:	ff d0                	call   *%eax
  800871:	83 c4 10             	add    $0x10,%esp
}
  800874:	90                   	nop
  800875:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800878:	c9                   	leave  
  800879:	c3                   	ret    

0080087a <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80087a:	55                   	push   %ebp
  80087b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80087d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800881:	7e 1c                	jle    80089f <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800883:	8b 45 08             	mov    0x8(%ebp),%eax
  800886:	8b 00                	mov    (%eax),%eax
  800888:	8d 50 08             	lea    0x8(%eax),%edx
  80088b:	8b 45 08             	mov    0x8(%ebp),%eax
  80088e:	89 10                	mov    %edx,(%eax)
  800890:	8b 45 08             	mov    0x8(%ebp),%eax
  800893:	8b 00                	mov    (%eax),%eax
  800895:	83 e8 08             	sub    $0x8,%eax
  800898:	8b 50 04             	mov    0x4(%eax),%edx
  80089b:	8b 00                	mov    (%eax),%eax
  80089d:	eb 40                	jmp    8008df <getuint+0x65>
	else if (lflag)
  80089f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008a3:	74 1e                	je     8008c3 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8008a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a8:	8b 00                	mov    (%eax),%eax
  8008aa:	8d 50 04             	lea    0x4(%eax),%edx
  8008ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b0:	89 10                	mov    %edx,(%eax)
  8008b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b5:	8b 00                	mov    (%eax),%eax
  8008b7:	83 e8 04             	sub    $0x4,%eax
  8008ba:	8b 00                	mov    (%eax),%eax
  8008bc:	ba 00 00 00 00       	mov    $0x0,%edx
  8008c1:	eb 1c                	jmp    8008df <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8008c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c6:	8b 00                	mov    (%eax),%eax
  8008c8:	8d 50 04             	lea    0x4(%eax),%edx
  8008cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ce:	89 10                	mov    %edx,(%eax)
  8008d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d3:	8b 00                	mov    (%eax),%eax
  8008d5:	83 e8 04             	sub    $0x4,%eax
  8008d8:	8b 00                	mov    (%eax),%eax
  8008da:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8008df:	5d                   	pop    %ebp
  8008e0:	c3                   	ret    

008008e1 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8008e1:	55                   	push   %ebp
  8008e2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008e4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008e8:	7e 1c                	jle    800906 <getint+0x25>
		return va_arg(*ap, long long);
  8008ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ed:	8b 00                	mov    (%eax),%eax
  8008ef:	8d 50 08             	lea    0x8(%eax),%edx
  8008f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f5:	89 10                	mov    %edx,(%eax)
  8008f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fa:	8b 00                	mov    (%eax),%eax
  8008fc:	83 e8 08             	sub    $0x8,%eax
  8008ff:	8b 50 04             	mov    0x4(%eax),%edx
  800902:	8b 00                	mov    (%eax),%eax
  800904:	eb 38                	jmp    80093e <getint+0x5d>
	else if (lflag)
  800906:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80090a:	74 1a                	je     800926 <getint+0x45>
		return va_arg(*ap, long);
  80090c:	8b 45 08             	mov    0x8(%ebp),%eax
  80090f:	8b 00                	mov    (%eax),%eax
  800911:	8d 50 04             	lea    0x4(%eax),%edx
  800914:	8b 45 08             	mov    0x8(%ebp),%eax
  800917:	89 10                	mov    %edx,(%eax)
  800919:	8b 45 08             	mov    0x8(%ebp),%eax
  80091c:	8b 00                	mov    (%eax),%eax
  80091e:	83 e8 04             	sub    $0x4,%eax
  800921:	8b 00                	mov    (%eax),%eax
  800923:	99                   	cltd   
  800924:	eb 18                	jmp    80093e <getint+0x5d>
	else
		return va_arg(*ap, int);
  800926:	8b 45 08             	mov    0x8(%ebp),%eax
  800929:	8b 00                	mov    (%eax),%eax
  80092b:	8d 50 04             	lea    0x4(%eax),%edx
  80092e:	8b 45 08             	mov    0x8(%ebp),%eax
  800931:	89 10                	mov    %edx,(%eax)
  800933:	8b 45 08             	mov    0x8(%ebp),%eax
  800936:	8b 00                	mov    (%eax),%eax
  800938:	83 e8 04             	sub    $0x4,%eax
  80093b:	8b 00                	mov    (%eax),%eax
  80093d:	99                   	cltd   
}
  80093e:	5d                   	pop    %ebp
  80093f:	c3                   	ret    

00800940 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800940:	55                   	push   %ebp
  800941:	89 e5                	mov    %esp,%ebp
  800943:	56                   	push   %esi
  800944:	53                   	push   %ebx
  800945:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800948:	eb 17                	jmp    800961 <vprintfmt+0x21>
			if (ch == '\0')
  80094a:	85 db                	test   %ebx,%ebx
  80094c:	0f 84 af 03 00 00    	je     800d01 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800952:	83 ec 08             	sub    $0x8,%esp
  800955:	ff 75 0c             	pushl  0xc(%ebp)
  800958:	53                   	push   %ebx
  800959:	8b 45 08             	mov    0x8(%ebp),%eax
  80095c:	ff d0                	call   *%eax
  80095e:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800961:	8b 45 10             	mov    0x10(%ebp),%eax
  800964:	8d 50 01             	lea    0x1(%eax),%edx
  800967:	89 55 10             	mov    %edx,0x10(%ebp)
  80096a:	8a 00                	mov    (%eax),%al
  80096c:	0f b6 d8             	movzbl %al,%ebx
  80096f:	83 fb 25             	cmp    $0x25,%ebx
  800972:	75 d6                	jne    80094a <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800974:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800978:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80097f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800986:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80098d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800994:	8b 45 10             	mov    0x10(%ebp),%eax
  800997:	8d 50 01             	lea    0x1(%eax),%edx
  80099a:	89 55 10             	mov    %edx,0x10(%ebp)
  80099d:	8a 00                	mov    (%eax),%al
  80099f:	0f b6 d8             	movzbl %al,%ebx
  8009a2:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8009a5:	83 f8 55             	cmp    $0x55,%eax
  8009a8:	0f 87 2b 03 00 00    	ja     800cd9 <vprintfmt+0x399>
  8009ae:	8b 04 85 d8 23 80 00 	mov    0x8023d8(,%eax,4),%eax
  8009b5:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8009b7:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8009bb:	eb d7                	jmp    800994 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8009bd:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8009c1:	eb d1                	jmp    800994 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009c3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8009ca:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009cd:	89 d0                	mov    %edx,%eax
  8009cf:	c1 e0 02             	shl    $0x2,%eax
  8009d2:	01 d0                	add    %edx,%eax
  8009d4:	01 c0                	add    %eax,%eax
  8009d6:	01 d8                	add    %ebx,%eax
  8009d8:	83 e8 30             	sub    $0x30,%eax
  8009db:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8009de:	8b 45 10             	mov    0x10(%ebp),%eax
  8009e1:	8a 00                	mov    (%eax),%al
  8009e3:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8009e6:	83 fb 2f             	cmp    $0x2f,%ebx
  8009e9:	7e 3e                	jle    800a29 <vprintfmt+0xe9>
  8009eb:	83 fb 39             	cmp    $0x39,%ebx
  8009ee:	7f 39                	jg     800a29 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009f0:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8009f3:	eb d5                	jmp    8009ca <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8009f5:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f8:	83 c0 04             	add    $0x4,%eax
  8009fb:	89 45 14             	mov    %eax,0x14(%ebp)
  8009fe:	8b 45 14             	mov    0x14(%ebp),%eax
  800a01:	83 e8 04             	sub    $0x4,%eax
  800a04:	8b 00                	mov    (%eax),%eax
  800a06:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800a09:	eb 1f                	jmp    800a2a <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800a0b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a0f:	79 83                	jns    800994 <vprintfmt+0x54>
				width = 0;
  800a11:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800a18:	e9 77 ff ff ff       	jmp    800994 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800a1d:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800a24:	e9 6b ff ff ff       	jmp    800994 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800a29:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800a2a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a2e:	0f 89 60 ff ff ff    	jns    800994 <vprintfmt+0x54>
				width = precision, precision = -1;
  800a34:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a37:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800a3a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800a41:	e9 4e ff ff ff       	jmp    800994 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800a46:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800a49:	e9 46 ff ff ff       	jmp    800994 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800a4e:	8b 45 14             	mov    0x14(%ebp),%eax
  800a51:	83 c0 04             	add    $0x4,%eax
  800a54:	89 45 14             	mov    %eax,0x14(%ebp)
  800a57:	8b 45 14             	mov    0x14(%ebp),%eax
  800a5a:	83 e8 04             	sub    $0x4,%eax
  800a5d:	8b 00                	mov    (%eax),%eax
  800a5f:	83 ec 08             	sub    $0x8,%esp
  800a62:	ff 75 0c             	pushl  0xc(%ebp)
  800a65:	50                   	push   %eax
  800a66:	8b 45 08             	mov    0x8(%ebp),%eax
  800a69:	ff d0                	call   *%eax
  800a6b:	83 c4 10             	add    $0x10,%esp
			break;
  800a6e:	e9 89 02 00 00       	jmp    800cfc <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a73:	8b 45 14             	mov    0x14(%ebp),%eax
  800a76:	83 c0 04             	add    $0x4,%eax
  800a79:	89 45 14             	mov    %eax,0x14(%ebp)
  800a7c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a7f:	83 e8 04             	sub    $0x4,%eax
  800a82:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a84:	85 db                	test   %ebx,%ebx
  800a86:	79 02                	jns    800a8a <vprintfmt+0x14a>
				err = -err;
  800a88:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a8a:	83 fb 64             	cmp    $0x64,%ebx
  800a8d:	7f 0b                	jg     800a9a <vprintfmt+0x15a>
  800a8f:	8b 34 9d 20 22 80 00 	mov    0x802220(,%ebx,4),%esi
  800a96:	85 f6                	test   %esi,%esi
  800a98:	75 19                	jne    800ab3 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a9a:	53                   	push   %ebx
  800a9b:	68 c5 23 80 00       	push   $0x8023c5
  800aa0:	ff 75 0c             	pushl  0xc(%ebp)
  800aa3:	ff 75 08             	pushl  0x8(%ebp)
  800aa6:	e8 5e 02 00 00       	call   800d09 <printfmt>
  800aab:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800aae:	e9 49 02 00 00       	jmp    800cfc <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ab3:	56                   	push   %esi
  800ab4:	68 ce 23 80 00       	push   $0x8023ce
  800ab9:	ff 75 0c             	pushl  0xc(%ebp)
  800abc:	ff 75 08             	pushl  0x8(%ebp)
  800abf:	e8 45 02 00 00       	call   800d09 <printfmt>
  800ac4:	83 c4 10             	add    $0x10,%esp
			break;
  800ac7:	e9 30 02 00 00       	jmp    800cfc <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800acc:	8b 45 14             	mov    0x14(%ebp),%eax
  800acf:	83 c0 04             	add    $0x4,%eax
  800ad2:	89 45 14             	mov    %eax,0x14(%ebp)
  800ad5:	8b 45 14             	mov    0x14(%ebp),%eax
  800ad8:	83 e8 04             	sub    $0x4,%eax
  800adb:	8b 30                	mov    (%eax),%esi
  800add:	85 f6                	test   %esi,%esi
  800adf:	75 05                	jne    800ae6 <vprintfmt+0x1a6>
				p = "(null)";
  800ae1:	be d1 23 80 00       	mov    $0x8023d1,%esi
			if (width > 0 && padc != '-')
  800ae6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800aea:	7e 6d                	jle    800b59 <vprintfmt+0x219>
  800aec:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800af0:	74 67                	je     800b59 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800af2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800af5:	83 ec 08             	sub    $0x8,%esp
  800af8:	50                   	push   %eax
  800af9:	56                   	push   %esi
  800afa:	e8 0c 03 00 00       	call   800e0b <strnlen>
  800aff:	83 c4 10             	add    $0x10,%esp
  800b02:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800b05:	eb 16                	jmp    800b1d <vprintfmt+0x1dd>
					putch(padc, putdat);
  800b07:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b0b:	83 ec 08             	sub    $0x8,%esp
  800b0e:	ff 75 0c             	pushl  0xc(%ebp)
  800b11:	50                   	push   %eax
  800b12:	8b 45 08             	mov    0x8(%ebp),%eax
  800b15:	ff d0                	call   *%eax
  800b17:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800b1a:	ff 4d e4             	decl   -0x1c(%ebp)
  800b1d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b21:	7f e4                	jg     800b07 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b23:	eb 34                	jmp    800b59 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800b25:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800b29:	74 1c                	je     800b47 <vprintfmt+0x207>
  800b2b:	83 fb 1f             	cmp    $0x1f,%ebx
  800b2e:	7e 05                	jle    800b35 <vprintfmt+0x1f5>
  800b30:	83 fb 7e             	cmp    $0x7e,%ebx
  800b33:	7e 12                	jle    800b47 <vprintfmt+0x207>
					putch('?', putdat);
  800b35:	83 ec 08             	sub    $0x8,%esp
  800b38:	ff 75 0c             	pushl  0xc(%ebp)
  800b3b:	6a 3f                	push   $0x3f
  800b3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b40:	ff d0                	call   *%eax
  800b42:	83 c4 10             	add    $0x10,%esp
  800b45:	eb 0f                	jmp    800b56 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800b47:	83 ec 08             	sub    $0x8,%esp
  800b4a:	ff 75 0c             	pushl  0xc(%ebp)
  800b4d:	53                   	push   %ebx
  800b4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b51:	ff d0                	call   *%eax
  800b53:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b56:	ff 4d e4             	decl   -0x1c(%ebp)
  800b59:	89 f0                	mov    %esi,%eax
  800b5b:	8d 70 01             	lea    0x1(%eax),%esi
  800b5e:	8a 00                	mov    (%eax),%al
  800b60:	0f be d8             	movsbl %al,%ebx
  800b63:	85 db                	test   %ebx,%ebx
  800b65:	74 24                	je     800b8b <vprintfmt+0x24b>
  800b67:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b6b:	78 b8                	js     800b25 <vprintfmt+0x1e5>
  800b6d:	ff 4d e0             	decl   -0x20(%ebp)
  800b70:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b74:	79 af                	jns    800b25 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b76:	eb 13                	jmp    800b8b <vprintfmt+0x24b>
				putch(' ', putdat);
  800b78:	83 ec 08             	sub    $0x8,%esp
  800b7b:	ff 75 0c             	pushl  0xc(%ebp)
  800b7e:	6a 20                	push   $0x20
  800b80:	8b 45 08             	mov    0x8(%ebp),%eax
  800b83:	ff d0                	call   *%eax
  800b85:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b88:	ff 4d e4             	decl   -0x1c(%ebp)
  800b8b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b8f:	7f e7                	jg     800b78 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b91:	e9 66 01 00 00       	jmp    800cfc <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b96:	83 ec 08             	sub    $0x8,%esp
  800b99:	ff 75 e8             	pushl  -0x18(%ebp)
  800b9c:	8d 45 14             	lea    0x14(%ebp),%eax
  800b9f:	50                   	push   %eax
  800ba0:	e8 3c fd ff ff       	call   8008e1 <getint>
  800ba5:	83 c4 10             	add    $0x10,%esp
  800ba8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bab:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800bae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bb1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bb4:	85 d2                	test   %edx,%edx
  800bb6:	79 23                	jns    800bdb <vprintfmt+0x29b>
				putch('-', putdat);
  800bb8:	83 ec 08             	sub    $0x8,%esp
  800bbb:	ff 75 0c             	pushl  0xc(%ebp)
  800bbe:	6a 2d                	push   $0x2d
  800bc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc3:	ff d0                	call   *%eax
  800bc5:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800bc8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bcb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bce:	f7 d8                	neg    %eax
  800bd0:	83 d2 00             	adc    $0x0,%edx
  800bd3:	f7 da                	neg    %edx
  800bd5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bd8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800bdb:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800be2:	e9 bc 00 00 00       	jmp    800ca3 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800be7:	83 ec 08             	sub    $0x8,%esp
  800bea:	ff 75 e8             	pushl  -0x18(%ebp)
  800bed:	8d 45 14             	lea    0x14(%ebp),%eax
  800bf0:	50                   	push   %eax
  800bf1:	e8 84 fc ff ff       	call   80087a <getuint>
  800bf6:	83 c4 10             	add    $0x10,%esp
  800bf9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bfc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800bff:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c06:	e9 98 00 00 00       	jmp    800ca3 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800c0b:	83 ec 08             	sub    $0x8,%esp
  800c0e:	ff 75 0c             	pushl  0xc(%ebp)
  800c11:	6a 58                	push   $0x58
  800c13:	8b 45 08             	mov    0x8(%ebp),%eax
  800c16:	ff d0                	call   *%eax
  800c18:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c1b:	83 ec 08             	sub    $0x8,%esp
  800c1e:	ff 75 0c             	pushl  0xc(%ebp)
  800c21:	6a 58                	push   $0x58
  800c23:	8b 45 08             	mov    0x8(%ebp),%eax
  800c26:	ff d0                	call   *%eax
  800c28:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c2b:	83 ec 08             	sub    $0x8,%esp
  800c2e:	ff 75 0c             	pushl  0xc(%ebp)
  800c31:	6a 58                	push   $0x58
  800c33:	8b 45 08             	mov    0x8(%ebp),%eax
  800c36:	ff d0                	call   *%eax
  800c38:	83 c4 10             	add    $0x10,%esp
			break;
  800c3b:	e9 bc 00 00 00       	jmp    800cfc <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800c40:	83 ec 08             	sub    $0x8,%esp
  800c43:	ff 75 0c             	pushl  0xc(%ebp)
  800c46:	6a 30                	push   $0x30
  800c48:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4b:	ff d0                	call   *%eax
  800c4d:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800c50:	83 ec 08             	sub    $0x8,%esp
  800c53:	ff 75 0c             	pushl  0xc(%ebp)
  800c56:	6a 78                	push   $0x78
  800c58:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5b:	ff d0                	call   *%eax
  800c5d:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c60:	8b 45 14             	mov    0x14(%ebp),%eax
  800c63:	83 c0 04             	add    $0x4,%eax
  800c66:	89 45 14             	mov    %eax,0x14(%ebp)
  800c69:	8b 45 14             	mov    0x14(%ebp),%eax
  800c6c:	83 e8 04             	sub    $0x4,%eax
  800c6f:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c71:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c74:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c7b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c82:	eb 1f                	jmp    800ca3 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c84:	83 ec 08             	sub    $0x8,%esp
  800c87:	ff 75 e8             	pushl  -0x18(%ebp)
  800c8a:	8d 45 14             	lea    0x14(%ebp),%eax
  800c8d:	50                   	push   %eax
  800c8e:	e8 e7 fb ff ff       	call   80087a <getuint>
  800c93:	83 c4 10             	add    $0x10,%esp
  800c96:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c99:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c9c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ca3:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ca7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800caa:	83 ec 04             	sub    $0x4,%esp
  800cad:	52                   	push   %edx
  800cae:	ff 75 e4             	pushl  -0x1c(%ebp)
  800cb1:	50                   	push   %eax
  800cb2:	ff 75 f4             	pushl  -0xc(%ebp)
  800cb5:	ff 75 f0             	pushl  -0x10(%ebp)
  800cb8:	ff 75 0c             	pushl  0xc(%ebp)
  800cbb:	ff 75 08             	pushl  0x8(%ebp)
  800cbe:	e8 00 fb ff ff       	call   8007c3 <printnum>
  800cc3:	83 c4 20             	add    $0x20,%esp
			break;
  800cc6:	eb 34                	jmp    800cfc <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800cc8:	83 ec 08             	sub    $0x8,%esp
  800ccb:	ff 75 0c             	pushl  0xc(%ebp)
  800cce:	53                   	push   %ebx
  800ccf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd2:	ff d0                	call   *%eax
  800cd4:	83 c4 10             	add    $0x10,%esp
			break;
  800cd7:	eb 23                	jmp    800cfc <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800cd9:	83 ec 08             	sub    $0x8,%esp
  800cdc:	ff 75 0c             	pushl  0xc(%ebp)
  800cdf:	6a 25                	push   $0x25
  800ce1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce4:	ff d0                	call   *%eax
  800ce6:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ce9:	ff 4d 10             	decl   0x10(%ebp)
  800cec:	eb 03                	jmp    800cf1 <vprintfmt+0x3b1>
  800cee:	ff 4d 10             	decl   0x10(%ebp)
  800cf1:	8b 45 10             	mov    0x10(%ebp),%eax
  800cf4:	48                   	dec    %eax
  800cf5:	8a 00                	mov    (%eax),%al
  800cf7:	3c 25                	cmp    $0x25,%al
  800cf9:	75 f3                	jne    800cee <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800cfb:	90                   	nop
		}
	}
  800cfc:	e9 47 fc ff ff       	jmp    800948 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800d01:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800d02:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800d05:	5b                   	pop    %ebx
  800d06:	5e                   	pop    %esi
  800d07:	5d                   	pop    %ebp
  800d08:	c3                   	ret    

00800d09 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800d09:	55                   	push   %ebp
  800d0a:	89 e5                	mov    %esp,%ebp
  800d0c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800d0f:	8d 45 10             	lea    0x10(%ebp),%eax
  800d12:	83 c0 04             	add    $0x4,%eax
  800d15:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800d18:	8b 45 10             	mov    0x10(%ebp),%eax
  800d1b:	ff 75 f4             	pushl  -0xc(%ebp)
  800d1e:	50                   	push   %eax
  800d1f:	ff 75 0c             	pushl  0xc(%ebp)
  800d22:	ff 75 08             	pushl  0x8(%ebp)
  800d25:	e8 16 fc ff ff       	call   800940 <vprintfmt>
  800d2a:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800d2d:	90                   	nop
  800d2e:	c9                   	leave  
  800d2f:	c3                   	ret    

00800d30 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800d30:	55                   	push   %ebp
  800d31:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800d33:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d36:	8b 40 08             	mov    0x8(%eax),%eax
  800d39:	8d 50 01             	lea    0x1(%eax),%edx
  800d3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d3f:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800d42:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d45:	8b 10                	mov    (%eax),%edx
  800d47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4a:	8b 40 04             	mov    0x4(%eax),%eax
  800d4d:	39 c2                	cmp    %eax,%edx
  800d4f:	73 12                	jae    800d63 <sprintputch+0x33>
		*b->buf++ = ch;
  800d51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d54:	8b 00                	mov    (%eax),%eax
  800d56:	8d 48 01             	lea    0x1(%eax),%ecx
  800d59:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d5c:	89 0a                	mov    %ecx,(%edx)
  800d5e:	8b 55 08             	mov    0x8(%ebp),%edx
  800d61:	88 10                	mov    %dl,(%eax)
}
  800d63:	90                   	nop
  800d64:	5d                   	pop    %ebp
  800d65:	c3                   	ret    

00800d66 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d66:	55                   	push   %ebp
  800d67:	89 e5                	mov    %esp,%ebp
  800d69:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d72:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d75:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d78:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7b:	01 d0                	add    %edx,%eax
  800d7d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d80:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d87:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d8b:	74 06                	je     800d93 <vsnprintf+0x2d>
  800d8d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d91:	7f 07                	jg     800d9a <vsnprintf+0x34>
		return -E_INVAL;
  800d93:	b8 03 00 00 00       	mov    $0x3,%eax
  800d98:	eb 20                	jmp    800dba <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d9a:	ff 75 14             	pushl  0x14(%ebp)
  800d9d:	ff 75 10             	pushl  0x10(%ebp)
  800da0:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800da3:	50                   	push   %eax
  800da4:	68 30 0d 80 00       	push   $0x800d30
  800da9:	e8 92 fb ff ff       	call   800940 <vprintfmt>
  800dae:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800db1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800db4:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800db7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800dba:	c9                   	leave  
  800dbb:	c3                   	ret    

00800dbc <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800dbc:	55                   	push   %ebp
  800dbd:	89 e5                	mov    %esp,%ebp
  800dbf:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800dc2:	8d 45 10             	lea    0x10(%ebp),%eax
  800dc5:	83 c0 04             	add    $0x4,%eax
  800dc8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800dcb:	8b 45 10             	mov    0x10(%ebp),%eax
  800dce:	ff 75 f4             	pushl  -0xc(%ebp)
  800dd1:	50                   	push   %eax
  800dd2:	ff 75 0c             	pushl  0xc(%ebp)
  800dd5:	ff 75 08             	pushl  0x8(%ebp)
  800dd8:	e8 89 ff ff ff       	call   800d66 <vsnprintf>
  800ddd:	83 c4 10             	add    $0x10,%esp
  800de0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800de3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800de6:	c9                   	leave  
  800de7:	c3                   	ret    

00800de8 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800de8:	55                   	push   %ebp
  800de9:	89 e5                	mov    %esp,%ebp
  800deb:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800dee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800df5:	eb 06                	jmp    800dfd <strlen+0x15>
		n++;
  800df7:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800dfa:	ff 45 08             	incl   0x8(%ebp)
  800dfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800e00:	8a 00                	mov    (%eax),%al
  800e02:	84 c0                	test   %al,%al
  800e04:	75 f1                	jne    800df7 <strlen+0xf>
		n++;
	return n;
  800e06:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e09:	c9                   	leave  
  800e0a:	c3                   	ret    

00800e0b <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800e0b:	55                   	push   %ebp
  800e0c:	89 e5                	mov    %esp,%ebp
  800e0e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e11:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e18:	eb 09                	jmp    800e23 <strnlen+0x18>
		n++;
  800e1a:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e1d:	ff 45 08             	incl   0x8(%ebp)
  800e20:	ff 4d 0c             	decl   0xc(%ebp)
  800e23:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e27:	74 09                	je     800e32 <strnlen+0x27>
  800e29:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2c:	8a 00                	mov    (%eax),%al
  800e2e:	84 c0                	test   %al,%al
  800e30:	75 e8                	jne    800e1a <strnlen+0xf>
		n++;
	return n;
  800e32:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e35:	c9                   	leave  
  800e36:	c3                   	ret    

00800e37 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e37:	55                   	push   %ebp
  800e38:	89 e5                	mov    %esp,%ebp
  800e3a:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e40:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e43:	90                   	nop
  800e44:	8b 45 08             	mov    0x8(%ebp),%eax
  800e47:	8d 50 01             	lea    0x1(%eax),%edx
  800e4a:	89 55 08             	mov    %edx,0x8(%ebp)
  800e4d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e50:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e53:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e56:	8a 12                	mov    (%edx),%dl
  800e58:	88 10                	mov    %dl,(%eax)
  800e5a:	8a 00                	mov    (%eax),%al
  800e5c:	84 c0                	test   %al,%al
  800e5e:	75 e4                	jne    800e44 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e60:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e63:	c9                   	leave  
  800e64:	c3                   	ret    

00800e65 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e65:	55                   	push   %ebp
  800e66:	89 e5                	mov    %esp,%ebp
  800e68:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e71:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e78:	eb 1f                	jmp    800e99 <strncpy+0x34>
		*dst++ = *src;
  800e7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7d:	8d 50 01             	lea    0x1(%eax),%edx
  800e80:	89 55 08             	mov    %edx,0x8(%ebp)
  800e83:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e86:	8a 12                	mov    (%edx),%dl
  800e88:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8d:	8a 00                	mov    (%eax),%al
  800e8f:	84 c0                	test   %al,%al
  800e91:	74 03                	je     800e96 <strncpy+0x31>
			src++;
  800e93:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e96:	ff 45 fc             	incl   -0x4(%ebp)
  800e99:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e9c:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e9f:	72 d9                	jb     800e7a <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800ea1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ea4:	c9                   	leave  
  800ea5:	c3                   	ret    

00800ea6 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800ea6:	55                   	push   %ebp
  800ea7:	89 e5                	mov    %esp,%ebp
  800ea9:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800eac:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800eb2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eb6:	74 30                	je     800ee8 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800eb8:	eb 16                	jmp    800ed0 <strlcpy+0x2a>
			*dst++ = *src++;
  800eba:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebd:	8d 50 01             	lea    0x1(%eax),%edx
  800ec0:	89 55 08             	mov    %edx,0x8(%ebp)
  800ec3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ec6:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ec9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ecc:	8a 12                	mov    (%edx),%dl
  800ece:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800ed0:	ff 4d 10             	decl   0x10(%ebp)
  800ed3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ed7:	74 09                	je     800ee2 <strlcpy+0x3c>
  800ed9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800edc:	8a 00                	mov    (%eax),%al
  800ede:	84 c0                	test   %al,%al
  800ee0:	75 d8                	jne    800eba <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee5:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800ee8:	8b 55 08             	mov    0x8(%ebp),%edx
  800eeb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eee:	29 c2                	sub    %eax,%edx
  800ef0:	89 d0                	mov    %edx,%eax
}
  800ef2:	c9                   	leave  
  800ef3:	c3                   	ret    

00800ef4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ef4:	55                   	push   %ebp
  800ef5:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ef7:	eb 06                	jmp    800eff <strcmp+0xb>
		p++, q++;
  800ef9:	ff 45 08             	incl   0x8(%ebp)
  800efc:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800eff:	8b 45 08             	mov    0x8(%ebp),%eax
  800f02:	8a 00                	mov    (%eax),%al
  800f04:	84 c0                	test   %al,%al
  800f06:	74 0e                	je     800f16 <strcmp+0x22>
  800f08:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0b:	8a 10                	mov    (%eax),%dl
  800f0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f10:	8a 00                	mov    (%eax),%al
  800f12:	38 c2                	cmp    %al,%dl
  800f14:	74 e3                	je     800ef9 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f16:	8b 45 08             	mov    0x8(%ebp),%eax
  800f19:	8a 00                	mov    (%eax),%al
  800f1b:	0f b6 d0             	movzbl %al,%edx
  800f1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f21:	8a 00                	mov    (%eax),%al
  800f23:	0f b6 c0             	movzbl %al,%eax
  800f26:	29 c2                	sub    %eax,%edx
  800f28:	89 d0                	mov    %edx,%eax
}
  800f2a:	5d                   	pop    %ebp
  800f2b:	c3                   	ret    

00800f2c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f2c:	55                   	push   %ebp
  800f2d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f2f:	eb 09                	jmp    800f3a <strncmp+0xe>
		n--, p++, q++;
  800f31:	ff 4d 10             	decl   0x10(%ebp)
  800f34:	ff 45 08             	incl   0x8(%ebp)
  800f37:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f3a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f3e:	74 17                	je     800f57 <strncmp+0x2b>
  800f40:	8b 45 08             	mov    0x8(%ebp),%eax
  800f43:	8a 00                	mov    (%eax),%al
  800f45:	84 c0                	test   %al,%al
  800f47:	74 0e                	je     800f57 <strncmp+0x2b>
  800f49:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4c:	8a 10                	mov    (%eax),%dl
  800f4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f51:	8a 00                	mov    (%eax),%al
  800f53:	38 c2                	cmp    %al,%dl
  800f55:	74 da                	je     800f31 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f57:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f5b:	75 07                	jne    800f64 <strncmp+0x38>
		return 0;
  800f5d:	b8 00 00 00 00       	mov    $0x0,%eax
  800f62:	eb 14                	jmp    800f78 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f64:	8b 45 08             	mov    0x8(%ebp),%eax
  800f67:	8a 00                	mov    (%eax),%al
  800f69:	0f b6 d0             	movzbl %al,%edx
  800f6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6f:	8a 00                	mov    (%eax),%al
  800f71:	0f b6 c0             	movzbl %al,%eax
  800f74:	29 c2                	sub    %eax,%edx
  800f76:	89 d0                	mov    %edx,%eax
}
  800f78:	5d                   	pop    %ebp
  800f79:	c3                   	ret    

00800f7a <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f7a:	55                   	push   %ebp
  800f7b:	89 e5                	mov    %esp,%ebp
  800f7d:	83 ec 04             	sub    $0x4,%esp
  800f80:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f83:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f86:	eb 12                	jmp    800f9a <strchr+0x20>
		if (*s == c)
  800f88:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8b:	8a 00                	mov    (%eax),%al
  800f8d:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f90:	75 05                	jne    800f97 <strchr+0x1d>
			return (char *) s;
  800f92:	8b 45 08             	mov    0x8(%ebp),%eax
  800f95:	eb 11                	jmp    800fa8 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f97:	ff 45 08             	incl   0x8(%ebp)
  800f9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9d:	8a 00                	mov    (%eax),%al
  800f9f:	84 c0                	test   %al,%al
  800fa1:	75 e5                	jne    800f88 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800fa3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800fa8:	c9                   	leave  
  800fa9:	c3                   	ret    

00800faa <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800faa:	55                   	push   %ebp
  800fab:	89 e5                	mov    %esp,%ebp
  800fad:	83 ec 04             	sub    $0x4,%esp
  800fb0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fb6:	eb 0d                	jmp    800fc5 <strfind+0x1b>
		if (*s == c)
  800fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbb:	8a 00                	mov    (%eax),%al
  800fbd:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800fc0:	74 0e                	je     800fd0 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800fc2:	ff 45 08             	incl   0x8(%ebp)
  800fc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc8:	8a 00                	mov    (%eax),%al
  800fca:	84 c0                	test   %al,%al
  800fcc:	75 ea                	jne    800fb8 <strfind+0xe>
  800fce:	eb 01                	jmp    800fd1 <strfind+0x27>
		if (*s == c)
			break;
  800fd0:	90                   	nop
	return (char *) s;
  800fd1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fd4:	c9                   	leave  
  800fd5:	c3                   	ret    

00800fd6 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800fd6:	55                   	push   %ebp
  800fd7:	89 e5                	mov    %esp,%ebp
  800fd9:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800fdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800fe2:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe5:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800fe8:	eb 0e                	jmp    800ff8 <memset+0x22>
		*p++ = c;
  800fea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fed:	8d 50 01             	lea    0x1(%eax),%edx
  800ff0:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ff3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ff6:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800ff8:	ff 4d f8             	decl   -0x8(%ebp)
  800ffb:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800fff:	79 e9                	jns    800fea <memset+0x14>
		*p++ = c;

	return v;
  801001:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801004:	c9                   	leave  
  801005:	c3                   	ret    

00801006 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801006:	55                   	push   %ebp
  801007:	89 e5                	mov    %esp,%ebp
  801009:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80100c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80100f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801012:	8b 45 08             	mov    0x8(%ebp),%eax
  801015:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801018:	eb 16                	jmp    801030 <memcpy+0x2a>
		*d++ = *s++;
  80101a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80101d:	8d 50 01             	lea    0x1(%eax),%edx
  801020:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801023:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801026:	8d 4a 01             	lea    0x1(%edx),%ecx
  801029:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80102c:	8a 12                	mov    (%edx),%dl
  80102e:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801030:	8b 45 10             	mov    0x10(%ebp),%eax
  801033:	8d 50 ff             	lea    -0x1(%eax),%edx
  801036:	89 55 10             	mov    %edx,0x10(%ebp)
  801039:	85 c0                	test   %eax,%eax
  80103b:	75 dd                	jne    80101a <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80103d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801040:	c9                   	leave  
  801041:	c3                   	ret    

00801042 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801042:	55                   	push   %ebp
  801043:	89 e5                	mov    %esp,%ebp
  801045:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801048:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80104e:	8b 45 08             	mov    0x8(%ebp),%eax
  801051:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801054:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801057:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80105a:	73 50                	jae    8010ac <memmove+0x6a>
  80105c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80105f:	8b 45 10             	mov    0x10(%ebp),%eax
  801062:	01 d0                	add    %edx,%eax
  801064:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801067:	76 43                	jbe    8010ac <memmove+0x6a>
		s += n;
  801069:	8b 45 10             	mov    0x10(%ebp),%eax
  80106c:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80106f:	8b 45 10             	mov    0x10(%ebp),%eax
  801072:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801075:	eb 10                	jmp    801087 <memmove+0x45>
			*--d = *--s;
  801077:	ff 4d f8             	decl   -0x8(%ebp)
  80107a:	ff 4d fc             	decl   -0x4(%ebp)
  80107d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801080:	8a 10                	mov    (%eax),%dl
  801082:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801085:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801087:	8b 45 10             	mov    0x10(%ebp),%eax
  80108a:	8d 50 ff             	lea    -0x1(%eax),%edx
  80108d:	89 55 10             	mov    %edx,0x10(%ebp)
  801090:	85 c0                	test   %eax,%eax
  801092:	75 e3                	jne    801077 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801094:	eb 23                	jmp    8010b9 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801096:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801099:	8d 50 01             	lea    0x1(%eax),%edx
  80109c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80109f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010a2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010a5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010a8:	8a 12                	mov    (%edx),%dl
  8010aa:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8010ac:	8b 45 10             	mov    0x10(%ebp),%eax
  8010af:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010b2:	89 55 10             	mov    %edx,0x10(%ebp)
  8010b5:	85 c0                	test   %eax,%eax
  8010b7:	75 dd                	jne    801096 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8010b9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010bc:	c9                   	leave  
  8010bd:	c3                   	ret    

008010be <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8010be:	55                   	push   %ebp
  8010bf:	89 e5                	mov    %esp,%ebp
  8010c1:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8010c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8010ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010cd:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8010d0:	eb 2a                	jmp    8010fc <memcmp+0x3e>
		if (*s1 != *s2)
  8010d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010d5:	8a 10                	mov    (%eax),%dl
  8010d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010da:	8a 00                	mov    (%eax),%al
  8010dc:	38 c2                	cmp    %al,%dl
  8010de:	74 16                	je     8010f6 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8010e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010e3:	8a 00                	mov    (%eax),%al
  8010e5:	0f b6 d0             	movzbl %al,%edx
  8010e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010eb:	8a 00                	mov    (%eax),%al
  8010ed:	0f b6 c0             	movzbl %al,%eax
  8010f0:	29 c2                	sub    %eax,%edx
  8010f2:	89 d0                	mov    %edx,%eax
  8010f4:	eb 18                	jmp    80110e <memcmp+0x50>
		s1++, s2++;
  8010f6:	ff 45 fc             	incl   -0x4(%ebp)
  8010f9:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8010fc:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ff:	8d 50 ff             	lea    -0x1(%eax),%edx
  801102:	89 55 10             	mov    %edx,0x10(%ebp)
  801105:	85 c0                	test   %eax,%eax
  801107:	75 c9                	jne    8010d2 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801109:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80110e:	c9                   	leave  
  80110f:	c3                   	ret    

00801110 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801110:	55                   	push   %ebp
  801111:	89 e5                	mov    %esp,%ebp
  801113:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801116:	8b 55 08             	mov    0x8(%ebp),%edx
  801119:	8b 45 10             	mov    0x10(%ebp),%eax
  80111c:	01 d0                	add    %edx,%eax
  80111e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801121:	eb 15                	jmp    801138 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801123:	8b 45 08             	mov    0x8(%ebp),%eax
  801126:	8a 00                	mov    (%eax),%al
  801128:	0f b6 d0             	movzbl %al,%edx
  80112b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112e:	0f b6 c0             	movzbl %al,%eax
  801131:	39 c2                	cmp    %eax,%edx
  801133:	74 0d                	je     801142 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801135:	ff 45 08             	incl   0x8(%ebp)
  801138:	8b 45 08             	mov    0x8(%ebp),%eax
  80113b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80113e:	72 e3                	jb     801123 <memfind+0x13>
  801140:	eb 01                	jmp    801143 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801142:	90                   	nop
	return (void *) s;
  801143:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801146:	c9                   	leave  
  801147:	c3                   	ret    

00801148 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801148:	55                   	push   %ebp
  801149:	89 e5                	mov    %esp,%ebp
  80114b:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80114e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801155:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80115c:	eb 03                	jmp    801161 <strtol+0x19>
		s++;
  80115e:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801161:	8b 45 08             	mov    0x8(%ebp),%eax
  801164:	8a 00                	mov    (%eax),%al
  801166:	3c 20                	cmp    $0x20,%al
  801168:	74 f4                	je     80115e <strtol+0x16>
  80116a:	8b 45 08             	mov    0x8(%ebp),%eax
  80116d:	8a 00                	mov    (%eax),%al
  80116f:	3c 09                	cmp    $0x9,%al
  801171:	74 eb                	je     80115e <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801173:	8b 45 08             	mov    0x8(%ebp),%eax
  801176:	8a 00                	mov    (%eax),%al
  801178:	3c 2b                	cmp    $0x2b,%al
  80117a:	75 05                	jne    801181 <strtol+0x39>
		s++;
  80117c:	ff 45 08             	incl   0x8(%ebp)
  80117f:	eb 13                	jmp    801194 <strtol+0x4c>
	else if (*s == '-')
  801181:	8b 45 08             	mov    0x8(%ebp),%eax
  801184:	8a 00                	mov    (%eax),%al
  801186:	3c 2d                	cmp    $0x2d,%al
  801188:	75 0a                	jne    801194 <strtol+0x4c>
		s++, neg = 1;
  80118a:	ff 45 08             	incl   0x8(%ebp)
  80118d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801194:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801198:	74 06                	je     8011a0 <strtol+0x58>
  80119a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80119e:	75 20                	jne    8011c0 <strtol+0x78>
  8011a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a3:	8a 00                	mov    (%eax),%al
  8011a5:	3c 30                	cmp    $0x30,%al
  8011a7:	75 17                	jne    8011c0 <strtol+0x78>
  8011a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ac:	40                   	inc    %eax
  8011ad:	8a 00                	mov    (%eax),%al
  8011af:	3c 78                	cmp    $0x78,%al
  8011b1:	75 0d                	jne    8011c0 <strtol+0x78>
		s += 2, base = 16;
  8011b3:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8011b7:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8011be:	eb 28                	jmp    8011e8 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8011c0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011c4:	75 15                	jne    8011db <strtol+0x93>
  8011c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c9:	8a 00                	mov    (%eax),%al
  8011cb:	3c 30                	cmp    $0x30,%al
  8011cd:	75 0c                	jne    8011db <strtol+0x93>
		s++, base = 8;
  8011cf:	ff 45 08             	incl   0x8(%ebp)
  8011d2:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8011d9:	eb 0d                	jmp    8011e8 <strtol+0xa0>
	else if (base == 0)
  8011db:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011df:	75 07                	jne    8011e8 <strtol+0xa0>
		base = 10;
  8011e1:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8011e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011eb:	8a 00                	mov    (%eax),%al
  8011ed:	3c 2f                	cmp    $0x2f,%al
  8011ef:	7e 19                	jle    80120a <strtol+0xc2>
  8011f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f4:	8a 00                	mov    (%eax),%al
  8011f6:	3c 39                	cmp    $0x39,%al
  8011f8:	7f 10                	jg     80120a <strtol+0xc2>
			dig = *s - '0';
  8011fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fd:	8a 00                	mov    (%eax),%al
  8011ff:	0f be c0             	movsbl %al,%eax
  801202:	83 e8 30             	sub    $0x30,%eax
  801205:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801208:	eb 42                	jmp    80124c <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80120a:	8b 45 08             	mov    0x8(%ebp),%eax
  80120d:	8a 00                	mov    (%eax),%al
  80120f:	3c 60                	cmp    $0x60,%al
  801211:	7e 19                	jle    80122c <strtol+0xe4>
  801213:	8b 45 08             	mov    0x8(%ebp),%eax
  801216:	8a 00                	mov    (%eax),%al
  801218:	3c 7a                	cmp    $0x7a,%al
  80121a:	7f 10                	jg     80122c <strtol+0xe4>
			dig = *s - 'a' + 10;
  80121c:	8b 45 08             	mov    0x8(%ebp),%eax
  80121f:	8a 00                	mov    (%eax),%al
  801221:	0f be c0             	movsbl %al,%eax
  801224:	83 e8 57             	sub    $0x57,%eax
  801227:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80122a:	eb 20                	jmp    80124c <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80122c:	8b 45 08             	mov    0x8(%ebp),%eax
  80122f:	8a 00                	mov    (%eax),%al
  801231:	3c 40                	cmp    $0x40,%al
  801233:	7e 39                	jle    80126e <strtol+0x126>
  801235:	8b 45 08             	mov    0x8(%ebp),%eax
  801238:	8a 00                	mov    (%eax),%al
  80123a:	3c 5a                	cmp    $0x5a,%al
  80123c:	7f 30                	jg     80126e <strtol+0x126>
			dig = *s - 'A' + 10;
  80123e:	8b 45 08             	mov    0x8(%ebp),%eax
  801241:	8a 00                	mov    (%eax),%al
  801243:	0f be c0             	movsbl %al,%eax
  801246:	83 e8 37             	sub    $0x37,%eax
  801249:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80124c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80124f:	3b 45 10             	cmp    0x10(%ebp),%eax
  801252:	7d 19                	jge    80126d <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801254:	ff 45 08             	incl   0x8(%ebp)
  801257:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80125a:	0f af 45 10          	imul   0x10(%ebp),%eax
  80125e:	89 c2                	mov    %eax,%edx
  801260:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801263:	01 d0                	add    %edx,%eax
  801265:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801268:	e9 7b ff ff ff       	jmp    8011e8 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80126d:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80126e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801272:	74 08                	je     80127c <strtol+0x134>
		*endptr = (char *) s;
  801274:	8b 45 0c             	mov    0xc(%ebp),%eax
  801277:	8b 55 08             	mov    0x8(%ebp),%edx
  80127a:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80127c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801280:	74 07                	je     801289 <strtol+0x141>
  801282:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801285:	f7 d8                	neg    %eax
  801287:	eb 03                	jmp    80128c <strtol+0x144>
  801289:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80128c:	c9                   	leave  
  80128d:	c3                   	ret    

0080128e <ltostr>:

void
ltostr(long value, char *str)
{
  80128e:	55                   	push   %ebp
  80128f:	89 e5                	mov    %esp,%ebp
  801291:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801294:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80129b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8012a2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012a6:	79 13                	jns    8012bb <ltostr+0x2d>
	{
		neg = 1;
  8012a8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8012af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b2:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8012b5:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8012b8:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8012bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012be:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8012c3:	99                   	cltd   
  8012c4:	f7 f9                	idiv   %ecx
  8012c6:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8012c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012cc:	8d 50 01             	lea    0x1(%eax),%edx
  8012cf:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012d2:	89 c2                	mov    %eax,%edx
  8012d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012d7:	01 d0                	add    %edx,%eax
  8012d9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012dc:	83 c2 30             	add    $0x30,%edx
  8012df:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8012e1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012e4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012e9:	f7 e9                	imul   %ecx
  8012eb:	c1 fa 02             	sar    $0x2,%edx
  8012ee:	89 c8                	mov    %ecx,%eax
  8012f0:	c1 f8 1f             	sar    $0x1f,%eax
  8012f3:	29 c2                	sub    %eax,%edx
  8012f5:	89 d0                	mov    %edx,%eax
  8012f7:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8012fa:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012fd:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801302:	f7 e9                	imul   %ecx
  801304:	c1 fa 02             	sar    $0x2,%edx
  801307:	89 c8                	mov    %ecx,%eax
  801309:	c1 f8 1f             	sar    $0x1f,%eax
  80130c:	29 c2                	sub    %eax,%edx
  80130e:	89 d0                	mov    %edx,%eax
  801310:	c1 e0 02             	shl    $0x2,%eax
  801313:	01 d0                	add    %edx,%eax
  801315:	01 c0                	add    %eax,%eax
  801317:	29 c1                	sub    %eax,%ecx
  801319:	89 ca                	mov    %ecx,%edx
  80131b:	85 d2                	test   %edx,%edx
  80131d:	75 9c                	jne    8012bb <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80131f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801326:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801329:	48                   	dec    %eax
  80132a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80132d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801331:	74 3d                	je     801370 <ltostr+0xe2>
		start = 1 ;
  801333:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80133a:	eb 34                	jmp    801370 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80133c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80133f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801342:	01 d0                	add    %edx,%eax
  801344:	8a 00                	mov    (%eax),%al
  801346:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801349:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80134c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80134f:	01 c2                	add    %eax,%edx
  801351:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801354:	8b 45 0c             	mov    0xc(%ebp),%eax
  801357:	01 c8                	add    %ecx,%eax
  801359:	8a 00                	mov    (%eax),%al
  80135b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80135d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801360:	8b 45 0c             	mov    0xc(%ebp),%eax
  801363:	01 c2                	add    %eax,%edx
  801365:	8a 45 eb             	mov    -0x15(%ebp),%al
  801368:	88 02                	mov    %al,(%edx)
		start++ ;
  80136a:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80136d:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801370:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801373:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801376:	7c c4                	jl     80133c <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801378:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80137b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137e:	01 d0                	add    %edx,%eax
  801380:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801383:	90                   	nop
  801384:	c9                   	leave  
  801385:	c3                   	ret    

00801386 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801386:	55                   	push   %ebp
  801387:	89 e5                	mov    %esp,%ebp
  801389:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80138c:	ff 75 08             	pushl  0x8(%ebp)
  80138f:	e8 54 fa ff ff       	call   800de8 <strlen>
  801394:	83 c4 04             	add    $0x4,%esp
  801397:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80139a:	ff 75 0c             	pushl  0xc(%ebp)
  80139d:	e8 46 fa ff ff       	call   800de8 <strlen>
  8013a2:	83 c4 04             	add    $0x4,%esp
  8013a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8013a8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8013af:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013b6:	eb 17                	jmp    8013cf <strcconcat+0x49>
		final[s] = str1[s] ;
  8013b8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8013be:	01 c2                	add    %eax,%edx
  8013c0:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8013c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c6:	01 c8                	add    %ecx,%eax
  8013c8:	8a 00                	mov    (%eax),%al
  8013ca:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8013cc:	ff 45 fc             	incl   -0x4(%ebp)
  8013cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013d2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013d5:	7c e1                	jl     8013b8 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8013d7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8013de:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8013e5:	eb 1f                	jmp    801406 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8013e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013ea:	8d 50 01             	lea    0x1(%eax),%edx
  8013ed:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8013f0:	89 c2                	mov    %eax,%edx
  8013f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8013f5:	01 c2                	add    %eax,%edx
  8013f7:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8013fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013fd:	01 c8                	add    %ecx,%eax
  8013ff:	8a 00                	mov    (%eax),%al
  801401:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801403:	ff 45 f8             	incl   -0x8(%ebp)
  801406:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801409:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80140c:	7c d9                	jl     8013e7 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80140e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801411:	8b 45 10             	mov    0x10(%ebp),%eax
  801414:	01 d0                	add    %edx,%eax
  801416:	c6 00 00             	movb   $0x0,(%eax)
}
  801419:	90                   	nop
  80141a:	c9                   	leave  
  80141b:	c3                   	ret    

0080141c <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80141c:	55                   	push   %ebp
  80141d:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80141f:	8b 45 14             	mov    0x14(%ebp),%eax
  801422:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801428:	8b 45 14             	mov    0x14(%ebp),%eax
  80142b:	8b 00                	mov    (%eax),%eax
  80142d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801434:	8b 45 10             	mov    0x10(%ebp),%eax
  801437:	01 d0                	add    %edx,%eax
  801439:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80143f:	eb 0c                	jmp    80144d <strsplit+0x31>
			*string++ = 0;
  801441:	8b 45 08             	mov    0x8(%ebp),%eax
  801444:	8d 50 01             	lea    0x1(%eax),%edx
  801447:	89 55 08             	mov    %edx,0x8(%ebp)
  80144a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80144d:	8b 45 08             	mov    0x8(%ebp),%eax
  801450:	8a 00                	mov    (%eax),%al
  801452:	84 c0                	test   %al,%al
  801454:	74 18                	je     80146e <strsplit+0x52>
  801456:	8b 45 08             	mov    0x8(%ebp),%eax
  801459:	8a 00                	mov    (%eax),%al
  80145b:	0f be c0             	movsbl %al,%eax
  80145e:	50                   	push   %eax
  80145f:	ff 75 0c             	pushl  0xc(%ebp)
  801462:	e8 13 fb ff ff       	call   800f7a <strchr>
  801467:	83 c4 08             	add    $0x8,%esp
  80146a:	85 c0                	test   %eax,%eax
  80146c:	75 d3                	jne    801441 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80146e:	8b 45 08             	mov    0x8(%ebp),%eax
  801471:	8a 00                	mov    (%eax),%al
  801473:	84 c0                	test   %al,%al
  801475:	74 5a                	je     8014d1 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801477:	8b 45 14             	mov    0x14(%ebp),%eax
  80147a:	8b 00                	mov    (%eax),%eax
  80147c:	83 f8 0f             	cmp    $0xf,%eax
  80147f:	75 07                	jne    801488 <strsplit+0x6c>
		{
			return 0;
  801481:	b8 00 00 00 00       	mov    $0x0,%eax
  801486:	eb 66                	jmp    8014ee <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801488:	8b 45 14             	mov    0x14(%ebp),%eax
  80148b:	8b 00                	mov    (%eax),%eax
  80148d:	8d 48 01             	lea    0x1(%eax),%ecx
  801490:	8b 55 14             	mov    0x14(%ebp),%edx
  801493:	89 0a                	mov    %ecx,(%edx)
  801495:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80149c:	8b 45 10             	mov    0x10(%ebp),%eax
  80149f:	01 c2                	add    %eax,%edx
  8014a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a4:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014a6:	eb 03                	jmp    8014ab <strsplit+0x8f>
			string++;
  8014a8:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ae:	8a 00                	mov    (%eax),%al
  8014b0:	84 c0                	test   %al,%al
  8014b2:	74 8b                	je     80143f <strsplit+0x23>
  8014b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b7:	8a 00                	mov    (%eax),%al
  8014b9:	0f be c0             	movsbl %al,%eax
  8014bc:	50                   	push   %eax
  8014bd:	ff 75 0c             	pushl  0xc(%ebp)
  8014c0:	e8 b5 fa ff ff       	call   800f7a <strchr>
  8014c5:	83 c4 08             	add    $0x8,%esp
  8014c8:	85 c0                	test   %eax,%eax
  8014ca:	74 dc                	je     8014a8 <strsplit+0x8c>
			string++;
	}
  8014cc:	e9 6e ff ff ff       	jmp    80143f <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8014d1:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8014d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8014d5:	8b 00                	mov    (%eax),%eax
  8014d7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014de:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e1:	01 d0                	add    %edx,%eax
  8014e3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8014e9:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8014ee:	c9                   	leave  
  8014ef:	c3                   	ret    

008014f0 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8014f0:	55                   	push   %ebp
  8014f1:	89 e5                	mov    %esp,%ebp
  8014f3:	57                   	push   %edi
  8014f4:	56                   	push   %esi
  8014f5:	53                   	push   %ebx
  8014f6:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8014f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014ff:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801502:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801505:	8b 7d 18             	mov    0x18(%ebp),%edi
  801508:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80150b:	cd 30                	int    $0x30
  80150d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801510:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801513:	83 c4 10             	add    $0x10,%esp
  801516:	5b                   	pop    %ebx
  801517:	5e                   	pop    %esi
  801518:	5f                   	pop    %edi
  801519:	5d                   	pop    %ebp
  80151a:	c3                   	ret    

0080151b <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80151b:	55                   	push   %ebp
  80151c:	89 e5                	mov    %esp,%ebp
  80151e:	83 ec 04             	sub    $0x4,%esp
  801521:	8b 45 10             	mov    0x10(%ebp),%eax
  801524:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801527:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80152b:	8b 45 08             	mov    0x8(%ebp),%eax
  80152e:	6a 00                	push   $0x0
  801530:	6a 00                	push   $0x0
  801532:	52                   	push   %edx
  801533:	ff 75 0c             	pushl  0xc(%ebp)
  801536:	50                   	push   %eax
  801537:	6a 00                	push   $0x0
  801539:	e8 b2 ff ff ff       	call   8014f0 <syscall>
  80153e:	83 c4 18             	add    $0x18,%esp
}
  801541:	90                   	nop
  801542:	c9                   	leave  
  801543:	c3                   	ret    

00801544 <sys_cgetc>:

int
sys_cgetc(void)
{
  801544:	55                   	push   %ebp
  801545:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801547:	6a 00                	push   $0x0
  801549:	6a 00                	push   $0x0
  80154b:	6a 00                	push   $0x0
  80154d:	6a 00                	push   $0x0
  80154f:	6a 00                	push   $0x0
  801551:	6a 01                	push   $0x1
  801553:	e8 98 ff ff ff       	call   8014f0 <syscall>
  801558:	83 c4 18             	add    $0x18,%esp
}
  80155b:	c9                   	leave  
  80155c:	c3                   	ret    

0080155d <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80155d:	55                   	push   %ebp
  80155e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801560:	8b 45 08             	mov    0x8(%ebp),%eax
  801563:	6a 00                	push   $0x0
  801565:	6a 00                	push   $0x0
  801567:	6a 00                	push   $0x0
  801569:	6a 00                	push   $0x0
  80156b:	50                   	push   %eax
  80156c:	6a 05                	push   $0x5
  80156e:	e8 7d ff ff ff       	call   8014f0 <syscall>
  801573:	83 c4 18             	add    $0x18,%esp
}
  801576:	c9                   	leave  
  801577:	c3                   	ret    

00801578 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801578:	55                   	push   %ebp
  801579:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80157b:	6a 00                	push   $0x0
  80157d:	6a 00                	push   $0x0
  80157f:	6a 00                	push   $0x0
  801581:	6a 00                	push   $0x0
  801583:	6a 00                	push   $0x0
  801585:	6a 02                	push   $0x2
  801587:	e8 64 ff ff ff       	call   8014f0 <syscall>
  80158c:	83 c4 18             	add    $0x18,%esp
}
  80158f:	c9                   	leave  
  801590:	c3                   	ret    

00801591 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801591:	55                   	push   %ebp
  801592:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	6a 00                	push   $0x0
  80159a:	6a 00                	push   $0x0
  80159c:	6a 00                	push   $0x0
  80159e:	6a 03                	push   $0x3
  8015a0:	e8 4b ff ff ff       	call   8014f0 <syscall>
  8015a5:	83 c4 18             	add    $0x18,%esp
}
  8015a8:	c9                   	leave  
  8015a9:	c3                   	ret    

008015aa <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8015aa:	55                   	push   %ebp
  8015ab:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8015ad:	6a 00                	push   $0x0
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 00                	push   $0x0
  8015b3:	6a 00                	push   $0x0
  8015b5:	6a 00                	push   $0x0
  8015b7:	6a 04                	push   $0x4
  8015b9:	e8 32 ff ff ff       	call   8014f0 <syscall>
  8015be:	83 c4 18             	add    $0x18,%esp
}
  8015c1:	c9                   	leave  
  8015c2:	c3                   	ret    

008015c3 <sys_env_exit>:


void sys_env_exit(void)
{
  8015c3:	55                   	push   %ebp
  8015c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 00                	push   $0x0
  8015cc:	6a 00                	push   $0x0
  8015ce:	6a 00                	push   $0x0
  8015d0:	6a 06                	push   $0x6
  8015d2:	e8 19 ff ff ff       	call   8014f0 <syscall>
  8015d7:	83 c4 18             	add    $0x18,%esp
}
  8015da:	90                   	nop
  8015db:	c9                   	leave  
  8015dc:	c3                   	ret    

008015dd <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8015dd:	55                   	push   %ebp
  8015de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8015e0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e6:	6a 00                	push   $0x0
  8015e8:	6a 00                	push   $0x0
  8015ea:	6a 00                	push   $0x0
  8015ec:	52                   	push   %edx
  8015ed:	50                   	push   %eax
  8015ee:	6a 07                	push   $0x7
  8015f0:	e8 fb fe ff ff       	call   8014f0 <syscall>
  8015f5:	83 c4 18             	add    $0x18,%esp
}
  8015f8:	c9                   	leave  
  8015f9:	c3                   	ret    

008015fa <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8015fa:	55                   	push   %ebp
  8015fb:	89 e5                	mov    %esp,%ebp
  8015fd:	56                   	push   %esi
  8015fe:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8015ff:	8b 75 18             	mov    0x18(%ebp),%esi
  801602:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801605:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801608:	8b 55 0c             	mov    0xc(%ebp),%edx
  80160b:	8b 45 08             	mov    0x8(%ebp),%eax
  80160e:	56                   	push   %esi
  80160f:	53                   	push   %ebx
  801610:	51                   	push   %ecx
  801611:	52                   	push   %edx
  801612:	50                   	push   %eax
  801613:	6a 08                	push   $0x8
  801615:	e8 d6 fe ff ff       	call   8014f0 <syscall>
  80161a:	83 c4 18             	add    $0x18,%esp
}
  80161d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801620:	5b                   	pop    %ebx
  801621:	5e                   	pop    %esi
  801622:	5d                   	pop    %ebp
  801623:	c3                   	ret    

00801624 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801624:	55                   	push   %ebp
  801625:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801627:	8b 55 0c             	mov    0xc(%ebp),%edx
  80162a:	8b 45 08             	mov    0x8(%ebp),%eax
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	6a 00                	push   $0x0
  801633:	52                   	push   %edx
  801634:	50                   	push   %eax
  801635:	6a 09                	push   $0x9
  801637:	e8 b4 fe ff ff       	call   8014f0 <syscall>
  80163c:	83 c4 18             	add    $0x18,%esp
}
  80163f:	c9                   	leave  
  801640:	c3                   	ret    

00801641 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801641:	55                   	push   %ebp
  801642:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	ff 75 0c             	pushl  0xc(%ebp)
  80164d:	ff 75 08             	pushl  0x8(%ebp)
  801650:	6a 0a                	push   $0xa
  801652:	e8 99 fe ff ff       	call   8014f0 <syscall>
  801657:	83 c4 18             	add    $0x18,%esp
}
  80165a:	c9                   	leave  
  80165b:	c3                   	ret    

0080165c <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80165c:	55                   	push   %ebp
  80165d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80165f:	6a 00                	push   $0x0
  801661:	6a 00                	push   $0x0
  801663:	6a 00                	push   $0x0
  801665:	6a 00                	push   $0x0
  801667:	6a 00                	push   $0x0
  801669:	6a 0b                	push   $0xb
  80166b:	e8 80 fe ff ff       	call   8014f0 <syscall>
  801670:	83 c4 18             	add    $0x18,%esp
}
  801673:	c9                   	leave  
  801674:	c3                   	ret    

00801675 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801675:	55                   	push   %ebp
  801676:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801678:	6a 00                	push   $0x0
  80167a:	6a 00                	push   $0x0
  80167c:	6a 00                	push   $0x0
  80167e:	6a 00                	push   $0x0
  801680:	6a 00                	push   $0x0
  801682:	6a 0c                	push   $0xc
  801684:	e8 67 fe ff ff       	call   8014f0 <syscall>
  801689:	83 c4 18             	add    $0x18,%esp
}
  80168c:	c9                   	leave  
  80168d:	c3                   	ret    

0080168e <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80168e:	55                   	push   %ebp
  80168f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801691:	6a 00                	push   $0x0
  801693:	6a 00                	push   $0x0
  801695:	6a 00                	push   $0x0
  801697:	6a 00                	push   $0x0
  801699:	6a 00                	push   $0x0
  80169b:	6a 0d                	push   $0xd
  80169d:	e8 4e fe ff ff       	call   8014f0 <syscall>
  8016a2:	83 c4 18             	add    $0x18,%esp
}
  8016a5:	c9                   	leave  
  8016a6:	c3                   	ret    

008016a7 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8016a7:	55                   	push   %ebp
  8016a8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8016aa:	6a 00                	push   $0x0
  8016ac:	6a 00                	push   $0x0
  8016ae:	6a 00                	push   $0x0
  8016b0:	ff 75 0c             	pushl  0xc(%ebp)
  8016b3:	ff 75 08             	pushl  0x8(%ebp)
  8016b6:	6a 11                	push   $0x11
  8016b8:	e8 33 fe ff ff       	call   8014f0 <syscall>
  8016bd:	83 c4 18             	add    $0x18,%esp
	return;
  8016c0:	90                   	nop
}
  8016c1:	c9                   	leave  
  8016c2:	c3                   	ret    

008016c3 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8016c3:	55                   	push   %ebp
  8016c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8016c6:	6a 00                	push   $0x0
  8016c8:	6a 00                	push   $0x0
  8016ca:	6a 00                	push   $0x0
  8016cc:	ff 75 0c             	pushl  0xc(%ebp)
  8016cf:	ff 75 08             	pushl  0x8(%ebp)
  8016d2:	6a 12                	push   $0x12
  8016d4:	e8 17 fe ff ff       	call   8014f0 <syscall>
  8016d9:	83 c4 18             	add    $0x18,%esp
	return ;
  8016dc:	90                   	nop
}
  8016dd:	c9                   	leave  
  8016de:	c3                   	ret    

008016df <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8016df:	55                   	push   %ebp
  8016e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8016e2:	6a 00                	push   $0x0
  8016e4:	6a 00                	push   $0x0
  8016e6:	6a 00                	push   $0x0
  8016e8:	6a 00                	push   $0x0
  8016ea:	6a 00                	push   $0x0
  8016ec:	6a 0e                	push   $0xe
  8016ee:	e8 fd fd ff ff       	call   8014f0 <syscall>
  8016f3:	83 c4 18             	add    $0x18,%esp
}
  8016f6:	c9                   	leave  
  8016f7:	c3                   	ret    

008016f8 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8016f8:	55                   	push   %ebp
  8016f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8016fb:	6a 00                	push   $0x0
  8016fd:	6a 00                	push   $0x0
  8016ff:	6a 00                	push   $0x0
  801701:	6a 00                	push   $0x0
  801703:	ff 75 08             	pushl  0x8(%ebp)
  801706:	6a 0f                	push   $0xf
  801708:	e8 e3 fd ff ff       	call   8014f0 <syscall>
  80170d:	83 c4 18             	add    $0x18,%esp
}
  801710:	c9                   	leave  
  801711:	c3                   	ret    

00801712 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801712:	55                   	push   %ebp
  801713:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801715:	6a 00                	push   $0x0
  801717:	6a 00                	push   $0x0
  801719:	6a 00                	push   $0x0
  80171b:	6a 00                	push   $0x0
  80171d:	6a 00                	push   $0x0
  80171f:	6a 10                	push   $0x10
  801721:	e8 ca fd ff ff       	call   8014f0 <syscall>
  801726:	83 c4 18             	add    $0x18,%esp
}
  801729:	90                   	nop
  80172a:	c9                   	leave  
  80172b:	c3                   	ret    

0080172c <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80172c:	55                   	push   %ebp
  80172d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80172f:	6a 00                	push   $0x0
  801731:	6a 00                	push   $0x0
  801733:	6a 00                	push   $0x0
  801735:	6a 00                	push   $0x0
  801737:	6a 00                	push   $0x0
  801739:	6a 14                	push   $0x14
  80173b:	e8 b0 fd ff ff       	call   8014f0 <syscall>
  801740:	83 c4 18             	add    $0x18,%esp
}
  801743:	90                   	nop
  801744:	c9                   	leave  
  801745:	c3                   	ret    

00801746 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801746:	55                   	push   %ebp
  801747:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801749:	6a 00                	push   $0x0
  80174b:	6a 00                	push   $0x0
  80174d:	6a 00                	push   $0x0
  80174f:	6a 00                	push   $0x0
  801751:	6a 00                	push   $0x0
  801753:	6a 15                	push   $0x15
  801755:	e8 96 fd ff ff       	call   8014f0 <syscall>
  80175a:	83 c4 18             	add    $0x18,%esp
}
  80175d:	90                   	nop
  80175e:	c9                   	leave  
  80175f:	c3                   	ret    

00801760 <sys_cputc>:


void
sys_cputc(const char c)
{
  801760:	55                   	push   %ebp
  801761:	89 e5                	mov    %esp,%ebp
  801763:	83 ec 04             	sub    $0x4,%esp
  801766:	8b 45 08             	mov    0x8(%ebp),%eax
  801769:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80176c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801770:	6a 00                	push   $0x0
  801772:	6a 00                	push   $0x0
  801774:	6a 00                	push   $0x0
  801776:	6a 00                	push   $0x0
  801778:	50                   	push   %eax
  801779:	6a 16                	push   $0x16
  80177b:	e8 70 fd ff ff       	call   8014f0 <syscall>
  801780:	83 c4 18             	add    $0x18,%esp
}
  801783:	90                   	nop
  801784:	c9                   	leave  
  801785:	c3                   	ret    

00801786 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801786:	55                   	push   %ebp
  801787:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801789:	6a 00                	push   $0x0
  80178b:	6a 00                	push   $0x0
  80178d:	6a 00                	push   $0x0
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 17                	push   $0x17
  801795:	e8 56 fd ff ff       	call   8014f0 <syscall>
  80179a:	83 c4 18             	add    $0x18,%esp
}
  80179d:	90                   	nop
  80179e:	c9                   	leave  
  80179f:	c3                   	ret    

008017a0 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8017a0:	55                   	push   %ebp
  8017a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8017a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 00                	push   $0x0
  8017ac:	ff 75 0c             	pushl  0xc(%ebp)
  8017af:	50                   	push   %eax
  8017b0:	6a 18                	push   $0x18
  8017b2:	e8 39 fd ff ff       	call   8014f0 <syscall>
  8017b7:	83 c4 18             	add    $0x18,%esp
}
  8017ba:	c9                   	leave  
  8017bb:	c3                   	ret    

008017bc <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8017bc:	55                   	push   %ebp
  8017bd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	52                   	push   %edx
  8017cc:	50                   	push   %eax
  8017cd:	6a 1b                	push   $0x1b
  8017cf:	e8 1c fd ff ff       	call   8014f0 <syscall>
  8017d4:	83 c4 18             	add    $0x18,%esp
}
  8017d7:	c9                   	leave  
  8017d8:	c3                   	ret    

008017d9 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017d9:	55                   	push   %ebp
  8017da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017dc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017df:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 00                	push   $0x0
  8017e8:	52                   	push   %edx
  8017e9:	50                   	push   %eax
  8017ea:	6a 19                	push   $0x19
  8017ec:	e8 ff fc ff ff       	call   8014f0 <syscall>
  8017f1:	83 c4 18             	add    $0x18,%esp
}
  8017f4:	90                   	nop
  8017f5:	c9                   	leave  
  8017f6:	c3                   	ret    

008017f7 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017f7:	55                   	push   %ebp
  8017f8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801800:	6a 00                	push   $0x0
  801802:	6a 00                	push   $0x0
  801804:	6a 00                	push   $0x0
  801806:	52                   	push   %edx
  801807:	50                   	push   %eax
  801808:	6a 1a                	push   $0x1a
  80180a:	e8 e1 fc ff ff       	call   8014f0 <syscall>
  80180f:	83 c4 18             	add    $0x18,%esp
}
  801812:	90                   	nop
  801813:	c9                   	leave  
  801814:	c3                   	ret    

00801815 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801815:	55                   	push   %ebp
  801816:	89 e5                	mov    %esp,%ebp
  801818:	83 ec 04             	sub    $0x4,%esp
  80181b:	8b 45 10             	mov    0x10(%ebp),%eax
  80181e:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801821:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801824:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801828:	8b 45 08             	mov    0x8(%ebp),%eax
  80182b:	6a 00                	push   $0x0
  80182d:	51                   	push   %ecx
  80182e:	52                   	push   %edx
  80182f:	ff 75 0c             	pushl  0xc(%ebp)
  801832:	50                   	push   %eax
  801833:	6a 1c                	push   $0x1c
  801835:	e8 b6 fc ff ff       	call   8014f0 <syscall>
  80183a:	83 c4 18             	add    $0x18,%esp
}
  80183d:	c9                   	leave  
  80183e:	c3                   	ret    

0080183f <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80183f:	55                   	push   %ebp
  801840:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801842:	8b 55 0c             	mov    0xc(%ebp),%edx
  801845:	8b 45 08             	mov    0x8(%ebp),%eax
  801848:	6a 00                	push   $0x0
  80184a:	6a 00                	push   $0x0
  80184c:	6a 00                	push   $0x0
  80184e:	52                   	push   %edx
  80184f:	50                   	push   %eax
  801850:	6a 1d                	push   $0x1d
  801852:	e8 99 fc ff ff       	call   8014f0 <syscall>
  801857:	83 c4 18             	add    $0x18,%esp
}
  80185a:	c9                   	leave  
  80185b:	c3                   	ret    

0080185c <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80185c:	55                   	push   %ebp
  80185d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80185f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801862:	8b 55 0c             	mov    0xc(%ebp),%edx
  801865:	8b 45 08             	mov    0x8(%ebp),%eax
  801868:	6a 00                	push   $0x0
  80186a:	6a 00                	push   $0x0
  80186c:	51                   	push   %ecx
  80186d:	52                   	push   %edx
  80186e:	50                   	push   %eax
  80186f:	6a 1e                	push   $0x1e
  801871:	e8 7a fc ff ff       	call   8014f0 <syscall>
  801876:	83 c4 18             	add    $0x18,%esp
}
  801879:	c9                   	leave  
  80187a:	c3                   	ret    

0080187b <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80187b:	55                   	push   %ebp
  80187c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80187e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801881:	8b 45 08             	mov    0x8(%ebp),%eax
  801884:	6a 00                	push   $0x0
  801886:	6a 00                	push   $0x0
  801888:	6a 00                	push   $0x0
  80188a:	52                   	push   %edx
  80188b:	50                   	push   %eax
  80188c:	6a 1f                	push   $0x1f
  80188e:	e8 5d fc ff ff       	call   8014f0 <syscall>
  801893:	83 c4 18             	add    $0x18,%esp
}
  801896:	c9                   	leave  
  801897:	c3                   	ret    

00801898 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801898:	55                   	push   %ebp
  801899:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80189b:	6a 00                	push   $0x0
  80189d:	6a 00                	push   $0x0
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 00                	push   $0x0
  8018a5:	6a 20                	push   $0x20
  8018a7:	e8 44 fc ff ff       	call   8014f0 <syscall>
  8018ac:	83 c4 18             	add    $0x18,%esp
}
  8018af:	c9                   	leave  
  8018b0:	c3                   	ret    

008018b1 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8018b1:	55                   	push   %ebp
  8018b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8018b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b7:	6a 00                	push   $0x0
  8018b9:	ff 75 14             	pushl  0x14(%ebp)
  8018bc:	ff 75 10             	pushl  0x10(%ebp)
  8018bf:	ff 75 0c             	pushl  0xc(%ebp)
  8018c2:	50                   	push   %eax
  8018c3:	6a 21                	push   $0x21
  8018c5:	e8 26 fc ff ff       	call   8014f0 <syscall>
  8018ca:	83 c4 18             	add    $0x18,%esp
}
  8018cd:	c9                   	leave  
  8018ce:	c3                   	ret    

008018cf <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8018cf:	55                   	push   %ebp
  8018d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8018d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 00                	push   $0x0
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 00                	push   $0x0
  8018dd:	50                   	push   %eax
  8018de:	6a 22                	push   $0x22
  8018e0:	e8 0b fc ff ff       	call   8014f0 <syscall>
  8018e5:	83 c4 18             	add    $0x18,%esp
}
  8018e8:	90                   	nop
  8018e9:	c9                   	leave  
  8018ea:	c3                   	ret    

008018eb <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8018eb:	55                   	push   %ebp
  8018ec:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8018ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f1:	6a 00                	push   $0x0
  8018f3:	6a 00                	push   $0x0
  8018f5:	6a 00                	push   $0x0
  8018f7:	6a 00                	push   $0x0
  8018f9:	50                   	push   %eax
  8018fa:	6a 23                	push   $0x23
  8018fc:	e8 ef fb ff ff       	call   8014f0 <syscall>
  801901:	83 c4 18             	add    $0x18,%esp
}
  801904:	90                   	nop
  801905:	c9                   	leave  
  801906:	c3                   	ret    

00801907 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801907:	55                   	push   %ebp
  801908:	89 e5                	mov    %esp,%ebp
  80190a:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80190d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801910:	8d 50 04             	lea    0x4(%eax),%edx
  801913:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801916:	6a 00                	push   $0x0
  801918:	6a 00                	push   $0x0
  80191a:	6a 00                	push   $0x0
  80191c:	52                   	push   %edx
  80191d:	50                   	push   %eax
  80191e:	6a 24                	push   $0x24
  801920:	e8 cb fb ff ff       	call   8014f0 <syscall>
  801925:	83 c4 18             	add    $0x18,%esp
	return result;
  801928:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80192b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80192e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801931:	89 01                	mov    %eax,(%ecx)
  801933:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801936:	8b 45 08             	mov    0x8(%ebp),%eax
  801939:	c9                   	leave  
  80193a:	c2 04 00             	ret    $0x4

0080193d <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80193d:	55                   	push   %ebp
  80193e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801940:	6a 00                	push   $0x0
  801942:	6a 00                	push   $0x0
  801944:	ff 75 10             	pushl  0x10(%ebp)
  801947:	ff 75 0c             	pushl  0xc(%ebp)
  80194a:	ff 75 08             	pushl  0x8(%ebp)
  80194d:	6a 13                	push   $0x13
  80194f:	e8 9c fb ff ff       	call   8014f0 <syscall>
  801954:	83 c4 18             	add    $0x18,%esp
	return ;
  801957:	90                   	nop
}
  801958:	c9                   	leave  
  801959:	c3                   	ret    

0080195a <sys_rcr2>:
uint32 sys_rcr2()
{
  80195a:	55                   	push   %ebp
  80195b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80195d:	6a 00                	push   $0x0
  80195f:	6a 00                	push   $0x0
  801961:	6a 00                	push   $0x0
  801963:	6a 00                	push   $0x0
  801965:	6a 00                	push   $0x0
  801967:	6a 25                	push   $0x25
  801969:	e8 82 fb ff ff       	call   8014f0 <syscall>
  80196e:	83 c4 18             	add    $0x18,%esp
}
  801971:	c9                   	leave  
  801972:	c3                   	ret    

00801973 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801973:	55                   	push   %ebp
  801974:	89 e5                	mov    %esp,%ebp
  801976:	83 ec 04             	sub    $0x4,%esp
  801979:	8b 45 08             	mov    0x8(%ebp),%eax
  80197c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80197f:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801983:	6a 00                	push   $0x0
  801985:	6a 00                	push   $0x0
  801987:	6a 00                	push   $0x0
  801989:	6a 00                	push   $0x0
  80198b:	50                   	push   %eax
  80198c:	6a 26                	push   $0x26
  80198e:	e8 5d fb ff ff       	call   8014f0 <syscall>
  801993:	83 c4 18             	add    $0x18,%esp
	return ;
  801996:	90                   	nop
}
  801997:	c9                   	leave  
  801998:	c3                   	ret    

00801999 <rsttst>:
void rsttst()
{
  801999:	55                   	push   %ebp
  80199a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80199c:	6a 00                	push   $0x0
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 00                	push   $0x0
  8019a2:	6a 00                	push   $0x0
  8019a4:	6a 00                	push   $0x0
  8019a6:	6a 28                	push   $0x28
  8019a8:	e8 43 fb ff ff       	call   8014f0 <syscall>
  8019ad:	83 c4 18             	add    $0x18,%esp
	return ;
  8019b0:	90                   	nop
}
  8019b1:	c9                   	leave  
  8019b2:	c3                   	ret    

008019b3 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8019b3:	55                   	push   %ebp
  8019b4:	89 e5                	mov    %esp,%ebp
  8019b6:	83 ec 04             	sub    $0x4,%esp
  8019b9:	8b 45 14             	mov    0x14(%ebp),%eax
  8019bc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8019bf:	8b 55 18             	mov    0x18(%ebp),%edx
  8019c2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019c6:	52                   	push   %edx
  8019c7:	50                   	push   %eax
  8019c8:	ff 75 10             	pushl  0x10(%ebp)
  8019cb:	ff 75 0c             	pushl  0xc(%ebp)
  8019ce:	ff 75 08             	pushl  0x8(%ebp)
  8019d1:	6a 27                	push   $0x27
  8019d3:	e8 18 fb ff ff       	call   8014f0 <syscall>
  8019d8:	83 c4 18             	add    $0x18,%esp
	return ;
  8019db:	90                   	nop
}
  8019dc:	c9                   	leave  
  8019dd:	c3                   	ret    

008019de <chktst>:
void chktst(uint32 n)
{
  8019de:	55                   	push   %ebp
  8019df:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 00                	push   $0x0
  8019e7:	6a 00                	push   $0x0
  8019e9:	ff 75 08             	pushl  0x8(%ebp)
  8019ec:	6a 29                	push   $0x29
  8019ee:	e8 fd fa ff ff       	call   8014f0 <syscall>
  8019f3:	83 c4 18             	add    $0x18,%esp
	return ;
  8019f6:	90                   	nop
}
  8019f7:	c9                   	leave  
  8019f8:	c3                   	ret    

008019f9 <inctst>:

void inctst()
{
  8019f9:	55                   	push   %ebp
  8019fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8019fc:	6a 00                	push   $0x0
  8019fe:	6a 00                	push   $0x0
  801a00:	6a 00                	push   $0x0
  801a02:	6a 00                	push   $0x0
  801a04:	6a 00                	push   $0x0
  801a06:	6a 2a                	push   $0x2a
  801a08:	e8 e3 fa ff ff       	call   8014f0 <syscall>
  801a0d:	83 c4 18             	add    $0x18,%esp
	return ;
  801a10:	90                   	nop
}
  801a11:	c9                   	leave  
  801a12:	c3                   	ret    

00801a13 <gettst>:
uint32 gettst()
{
  801a13:	55                   	push   %ebp
  801a14:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801a16:	6a 00                	push   $0x0
  801a18:	6a 00                	push   $0x0
  801a1a:	6a 00                	push   $0x0
  801a1c:	6a 00                	push   $0x0
  801a1e:	6a 00                	push   $0x0
  801a20:	6a 2b                	push   $0x2b
  801a22:	e8 c9 fa ff ff       	call   8014f0 <syscall>
  801a27:	83 c4 18             	add    $0x18,%esp
}
  801a2a:	c9                   	leave  
  801a2b:	c3                   	ret    

00801a2c <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801a2c:	55                   	push   %ebp
  801a2d:	89 e5                	mov    %esp,%ebp
  801a2f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a32:	6a 00                	push   $0x0
  801a34:	6a 00                	push   $0x0
  801a36:	6a 00                	push   $0x0
  801a38:	6a 00                	push   $0x0
  801a3a:	6a 00                	push   $0x0
  801a3c:	6a 2c                	push   $0x2c
  801a3e:	e8 ad fa ff ff       	call   8014f0 <syscall>
  801a43:	83 c4 18             	add    $0x18,%esp
  801a46:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801a49:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801a4d:	75 07                	jne    801a56 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801a4f:	b8 01 00 00 00       	mov    $0x1,%eax
  801a54:	eb 05                	jmp    801a5b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801a56:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a5b:	c9                   	leave  
  801a5c:	c3                   	ret    

00801a5d <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801a5d:	55                   	push   %ebp
  801a5e:	89 e5                	mov    %esp,%ebp
  801a60:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	6a 00                	push   $0x0
  801a69:	6a 00                	push   $0x0
  801a6b:	6a 00                	push   $0x0
  801a6d:	6a 2c                	push   $0x2c
  801a6f:	e8 7c fa ff ff       	call   8014f0 <syscall>
  801a74:	83 c4 18             	add    $0x18,%esp
  801a77:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801a7a:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801a7e:	75 07                	jne    801a87 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801a80:	b8 01 00 00 00       	mov    $0x1,%eax
  801a85:	eb 05                	jmp    801a8c <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801a87:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a8c:	c9                   	leave  
  801a8d:	c3                   	ret    

00801a8e <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801a8e:	55                   	push   %ebp
  801a8f:	89 e5                	mov    %esp,%ebp
  801a91:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a94:	6a 00                	push   $0x0
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	6a 00                	push   $0x0
  801a9c:	6a 00                	push   $0x0
  801a9e:	6a 2c                	push   $0x2c
  801aa0:	e8 4b fa ff ff       	call   8014f0 <syscall>
  801aa5:	83 c4 18             	add    $0x18,%esp
  801aa8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801aab:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801aaf:	75 07                	jne    801ab8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801ab1:	b8 01 00 00 00       	mov    $0x1,%eax
  801ab6:	eb 05                	jmp    801abd <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801ab8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801abd:	c9                   	leave  
  801abe:	c3                   	ret    

00801abf <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801abf:	55                   	push   %ebp
  801ac0:	89 e5                	mov    %esp,%ebp
  801ac2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ac5:	6a 00                	push   $0x0
  801ac7:	6a 00                	push   $0x0
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 00                	push   $0x0
  801acd:	6a 00                	push   $0x0
  801acf:	6a 2c                	push   $0x2c
  801ad1:	e8 1a fa ff ff       	call   8014f0 <syscall>
  801ad6:	83 c4 18             	add    $0x18,%esp
  801ad9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801adc:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801ae0:	75 07                	jne    801ae9 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801ae2:	b8 01 00 00 00       	mov    $0x1,%eax
  801ae7:	eb 05                	jmp    801aee <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801ae9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801aee:	c9                   	leave  
  801aef:	c3                   	ret    

00801af0 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801af0:	55                   	push   %ebp
  801af1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801af3:	6a 00                	push   $0x0
  801af5:	6a 00                	push   $0x0
  801af7:	6a 00                	push   $0x0
  801af9:	6a 00                	push   $0x0
  801afb:	ff 75 08             	pushl  0x8(%ebp)
  801afe:	6a 2d                	push   $0x2d
  801b00:	e8 eb f9 ff ff       	call   8014f0 <syscall>
  801b05:	83 c4 18             	add    $0x18,%esp
	return ;
  801b08:	90                   	nop
}
  801b09:	c9                   	leave  
  801b0a:	c3                   	ret    

00801b0b <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b0b:	55                   	push   %ebp
  801b0c:	89 e5                	mov    %esp,%ebp
  801b0e:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b0f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b12:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b15:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b18:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1b:	6a 00                	push   $0x0
  801b1d:	53                   	push   %ebx
  801b1e:	51                   	push   %ecx
  801b1f:	52                   	push   %edx
  801b20:	50                   	push   %eax
  801b21:	6a 2e                	push   $0x2e
  801b23:	e8 c8 f9 ff ff       	call   8014f0 <syscall>
  801b28:	83 c4 18             	add    $0x18,%esp
}
  801b2b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b2e:	c9                   	leave  
  801b2f:	c3                   	ret    

00801b30 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b30:	55                   	push   %ebp
  801b31:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b33:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b36:	8b 45 08             	mov    0x8(%ebp),%eax
  801b39:	6a 00                	push   $0x0
  801b3b:	6a 00                	push   $0x0
  801b3d:	6a 00                	push   $0x0
  801b3f:	52                   	push   %edx
  801b40:	50                   	push   %eax
  801b41:	6a 2f                	push   $0x2f
  801b43:	e8 a8 f9 ff ff       	call   8014f0 <syscall>
  801b48:	83 c4 18             	add    $0x18,%esp
}
  801b4b:	c9                   	leave  
  801b4c:	c3                   	ret    
  801b4d:	66 90                	xchg   %ax,%ax
  801b4f:	90                   	nop

00801b50 <__udivdi3>:
  801b50:	55                   	push   %ebp
  801b51:	57                   	push   %edi
  801b52:	56                   	push   %esi
  801b53:	53                   	push   %ebx
  801b54:	83 ec 1c             	sub    $0x1c,%esp
  801b57:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801b5b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801b5f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b63:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801b67:	89 ca                	mov    %ecx,%edx
  801b69:	89 f8                	mov    %edi,%eax
  801b6b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801b6f:	85 f6                	test   %esi,%esi
  801b71:	75 2d                	jne    801ba0 <__udivdi3+0x50>
  801b73:	39 cf                	cmp    %ecx,%edi
  801b75:	77 65                	ja     801bdc <__udivdi3+0x8c>
  801b77:	89 fd                	mov    %edi,%ebp
  801b79:	85 ff                	test   %edi,%edi
  801b7b:	75 0b                	jne    801b88 <__udivdi3+0x38>
  801b7d:	b8 01 00 00 00       	mov    $0x1,%eax
  801b82:	31 d2                	xor    %edx,%edx
  801b84:	f7 f7                	div    %edi
  801b86:	89 c5                	mov    %eax,%ebp
  801b88:	31 d2                	xor    %edx,%edx
  801b8a:	89 c8                	mov    %ecx,%eax
  801b8c:	f7 f5                	div    %ebp
  801b8e:	89 c1                	mov    %eax,%ecx
  801b90:	89 d8                	mov    %ebx,%eax
  801b92:	f7 f5                	div    %ebp
  801b94:	89 cf                	mov    %ecx,%edi
  801b96:	89 fa                	mov    %edi,%edx
  801b98:	83 c4 1c             	add    $0x1c,%esp
  801b9b:	5b                   	pop    %ebx
  801b9c:	5e                   	pop    %esi
  801b9d:	5f                   	pop    %edi
  801b9e:	5d                   	pop    %ebp
  801b9f:	c3                   	ret    
  801ba0:	39 ce                	cmp    %ecx,%esi
  801ba2:	77 28                	ja     801bcc <__udivdi3+0x7c>
  801ba4:	0f bd fe             	bsr    %esi,%edi
  801ba7:	83 f7 1f             	xor    $0x1f,%edi
  801baa:	75 40                	jne    801bec <__udivdi3+0x9c>
  801bac:	39 ce                	cmp    %ecx,%esi
  801bae:	72 0a                	jb     801bba <__udivdi3+0x6a>
  801bb0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801bb4:	0f 87 9e 00 00 00    	ja     801c58 <__udivdi3+0x108>
  801bba:	b8 01 00 00 00       	mov    $0x1,%eax
  801bbf:	89 fa                	mov    %edi,%edx
  801bc1:	83 c4 1c             	add    $0x1c,%esp
  801bc4:	5b                   	pop    %ebx
  801bc5:	5e                   	pop    %esi
  801bc6:	5f                   	pop    %edi
  801bc7:	5d                   	pop    %ebp
  801bc8:	c3                   	ret    
  801bc9:	8d 76 00             	lea    0x0(%esi),%esi
  801bcc:	31 ff                	xor    %edi,%edi
  801bce:	31 c0                	xor    %eax,%eax
  801bd0:	89 fa                	mov    %edi,%edx
  801bd2:	83 c4 1c             	add    $0x1c,%esp
  801bd5:	5b                   	pop    %ebx
  801bd6:	5e                   	pop    %esi
  801bd7:	5f                   	pop    %edi
  801bd8:	5d                   	pop    %ebp
  801bd9:	c3                   	ret    
  801bda:	66 90                	xchg   %ax,%ax
  801bdc:	89 d8                	mov    %ebx,%eax
  801bde:	f7 f7                	div    %edi
  801be0:	31 ff                	xor    %edi,%edi
  801be2:	89 fa                	mov    %edi,%edx
  801be4:	83 c4 1c             	add    $0x1c,%esp
  801be7:	5b                   	pop    %ebx
  801be8:	5e                   	pop    %esi
  801be9:	5f                   	pop    %edi
  801bea:	5d                   	pop    %ebp
  801beb:	c3                   	ret    
  801bec:	bd 20 00 00 00       	mov    $0x20,%ebp
  801bf1:	89 eb                	mov    %ebp,%ebx
  801bf3:	29 fb                	sub    %edi,%ebx
  801bf5:	89 f9                	mov    %edi,%ecx
  801bf7:	d3 e6                	shl    %cl,%esi
  801bf9:	89 c5                	mov    %eax,%ebp
  801bfb:	88 d9                	mov    %bl,%cl
  801bfd:	d3 ed                	shr    %cl,%ebp
  801bff:	89 e9                	mov    %ebp,%ecx
  801c01:	09 f1                	or     %esi,%ecx
  801c03:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801c07:	89 f9                	mov    %edi,%ecx
  801c09:	d3 e0                	shl    %cl,%eax
  801c0b:	89 c5                	mov    %eax,%ebp
  801c0d:	89 d6                	mov    %edx,%esi
  801c0f:	88 d9                	mov    %bl,%cl
  801c11:	d3 ee                	shr    %cl,%esi
  801c13:	89 f9                	mov    %edi,%ecx
  801c15:	d3 e2                	shl    %cl,%edx
  801c17:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c1b:	88 d9                	mov    %bl,%cl
  801c1d:	d3 e8                	shr    %cl,%eax
  801c1f:	09 c2                	or     %eax,%edx
  801c21:	89 d0                	mov    %edx,%eax
  801c23:	89 f2                	mov    %esi,%edx
  801c25:	f7 74 24 0c          	divl   0xc(%esp)
  801c29:	89 d6                	mov    %edx,%esi
  801c2b:	89 c3                	mov    %eax,%ebx
  801c2d:	f7 e5                	mul    %ebp
  801c2f:	39 d6                	cmp    %edx,%esi
  801c31:	72 19                	jb     801c4c <__udivdi3+0xfc>
  801c33:	74 0b                	je     801c40 <__udivdi3+0xf0>
  801c35:	89 d8                	mov    %ebx,%eax
  801c37:	31 ff                	xor    %edi,%edi
  801c39:	e9 58 ff ff ff       	jmp    801b96 <__udivdi3+0x46>
  801c3e:	66 90                	xchg   %ax,%ax
  801c40:	8b 54 24 08          	mov    0x8(%esp),%edx
  801c44:	89 f9                	mov    %edi,%ecx
  801c46:	d3 e2                	shl    %cl,%edx
  801c48:	39 c2                	cmp    %eax,%edx
  801c4a:	73 e9                	jae    801c35 <__udivdi3+0xe5>
  801c4c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801c4f:	31 ff                	xor    %edi,%edi
  801c51:	e9 40 ff ff ff       	jmp    801b96 <__udivdi3+0x46>
  801c56:	66 90                	xchg   %ax,%ax
  801c58:	31 c0                	xor    %eax,%eax
  801c5a:	e9 37 ff ff ff       	jmp    801b96 <__udivdi3+0x46>
  801c5f:	90                   	nop

00801c60 <__umoddi3>:
  801c60:	55                   	push   %ebp
  801c61:	57                   	push   %edi
  801c62:	56                   	push   %esi
  801c63:	53                   	push   %ebx
  801c64:	83 ec 1c             	sub    $0x1c,%esp
  801c67:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801c6b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801c6f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c73:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801c77:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801c7b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801c7f:	89 f3                	mov    %esi,%ebx
  801c81:	89 fa                	mov    %edi,%edx
  801c83:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c87:	89 34 24             	mov    %esi,(%esp)
  801c8a:	85 c0                	test   %eax,%eax
  801c8c:	75 1a                	jne    801ca8 <__umoddi3+0x48>
  801c8e:	39 f7                	cmp    %esi,%edi
  801c90:	0f 86 a2 00 00 00    	jbe    801d38 <__umoddi3+0xd8>
  801c96:	89 c8                	mov    %ecx,%eax
  801c98:	89 f2                	mov    %esi,%edx
  801c9a:	f7 f7                	div    %edi
  801c9c:	89 d0                	mov    %edx,%eax
  801c9e:	31 d2                	xor    %edx,%edx
  801ca0:	83 c4 1c             	add    $0x1c,%esp
  801ca3:	5b                   	pop    %ebx
  801ca4:	5e                   	pop    %esi
  801ca5:	5f                   	pop    %edi
  801ca6:	5d                   	pop    %ebp
  801ca7:	c3                   	ret    
  801ca8:	39 f0                	cmp    %esi,%eax
  801caa:	0f 87 ac 00 00 00    	ja     801d5c <__umoddi3+0xfc>
  801cb0:	0f bd e8             	bsr    %eax,%ebp
  801cb3:	83 f5 1f             	xor    $0x1f,%ebp
  801cb6:	0f 84 ac 00 00 00    	je     801d68 <__umoddi3+0x108>
  801cbc:	bf 20 00 00 00       	mov    $0x20,%edi
  801cc1:	29 ef                	sub    %ebp,%edi
  801cc3:	89 fe                	mov    %edi,%esi
  801cc5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801cc9:	89 e9                	mov    %ebp,%ecx
  801ccb:	d3 e0                	shl    %cl,%eax
  801ccd:	89 d7                	mov    %edx,%edi
  801ccf:	89 f1                	mov    %esi,%ecx
  801cd1:	d3 ef                	shr    %cl,%edi
  801cd3:	09 c7                	or     %eax,%edi
  801cd5:	89 e9                	mov    %ebp,%ecx
  801cd7:	d3 e2                	shl    %cl,%edx
  801cd9:	89 14 24             	mov    %edx,(%esp)
  801cdc:	89 d8                	mov    %ebx,%eax
  801cde:	d3 e0                	shl    %cl,%eax
  801ce0:	89 c2                	mov    %eax,%edx
  801ce2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ce6:	d3 e0                	shl    %cl,%eax
  801ce8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801cec:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cf0:	89 f1                	mov    %esi,%ecx
  801cf2:	d3 e8                	shr    %cl,%eax
  801cf4:	09 d0                	or     %edx,%eax
  801cf6:	d3 eb                	shr    %cl,%ebx
  801cf8:	89 da                	mov    %ebx,%edx
  801cfa:	f7 f7                	div    %edi
  801cfc:	89 d3                	mov    %edx,%ebx
  801cfe:	f7 24 24             	mull   (%esp)
  801d01:	89 c6                	mov    %eax,%esi
  801d03:	89 d1                	mov    %edx,%ecx
  801d05:	39 d3                	cmp    %edx,%ebx
  801d07:	0f 82 87 00 00 00    	jb     801d94 <__umoddi3+0x134>
  801d0d:	0f 84 91 00 00 00    	je     801da4 <__umoddi3+0x144>
  801d13:	8b 54 24 04          	mov    0x4(%esp),%edx
  801d17:	29 f2                	sub    %esi,%edx
  801d19:	19 cb                	sbb    %ecx,%ebx
  801d1b:	89 d8                	mov    %ebx,%eax
  801d1d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801d21:	d3 e0                	shl    %cl,%eax
  801d23:	89 e9                	mov    %ebp,%ecx
  801d25:	d3 ea                	shr    %cl,%edx
  801d27:	09 d0                	or     %edx,%eax
  801d29:	89 e9                	mov    %ebp,%ecx
  801d2b:	d3 eb                	shr    %cl,%ebx
  801d2d:	89 da                	mov    %ebx,%edx
  801d2f:	83 c4 1c             	add    $0x1c,%esp
  801d32:	5b                   	pop    %ebx
  801d33:	5e                   	pop    %esi
  801d34:	5f                   	pop    %edi
  801d35:	5d                   	pop    %ebp
  801d36:	c3                   	ret    
  801d37:	90                   	nop
  801d38:	89 fd                	mov    %edi,%ebp
  801d3a:	85 ff                	test   %edi,%edi
  801d3c:	75 0b                	jne    801d49 <__umoddi3+0xe9>
  801d3e:	b8 01 00 00 00       	mov    $0x1,%eax
  801d43:	31 d2                	xor    %edx,%edx
  801d45:	f7 f7                	div    %edi
  801d47:	89 c5                	mov    %eax,%ebp
  801d49:	89 f0                	mov    %esi,%eax
  801d4b:	31 d2                	xor    %edx,%edx
  801d4d:	f7 f5                	div    %ebp
  801d4f:	89 c8                	mov    %ecx,%eax
  801d51:	f7 f5                	div    %ebp
  801d53:	89 d0                	mov    %edx,%eax
  801d55:	e9 44 ff ff ff       	jmp    801c9e <__umoddi3+0x3e>
  801d5a:	66 90                	xchg   %ax,%ax
  801d5c:	89 c8                	mov    %ecx,%eax
  801d5e:	89 f2                	mov    %esi,%edx
  801d60:	83 c4 1c             	add    $0x1c,%esp
  801d63:	5b                   	pop    %ebx
  801d64:	5e                   	pop    %esi
  801d65:	5f                   	pop    %edi
  801d66:	5d                   	pop    %ebp
  801d67:	c3                   	ret    
  801d68:	3b 04 24             	cmp    (%esp),%eax
  801d6b:	72 06                	jb     801d73 <__umoddi3+0x113>
  801d6d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801d71:	77 0f                	ja     801d82 <__umoddi3+0x122>
  801d73:	89 f2                	mov    %esi,%edx
  801d75:	29 f9                	sub    %edi,%ecx
  801d77:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801d7b:	89 14 24             	mov    %edx,(%esp)
  801d7e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d82:	8b 44 24 04          	mov    0x4(%esp),%eax
  801d86:	8b 14 24             	mov    (%esp),%edx
  801d89:	83 c4 1c             	add    $0x1c,%esp
  801d8c:	5b                   	pop    %ebx
  801d8d:	5e                   	pop    %esi
  801d8e:	5f                   	pop    %edi
  801d8f:	5d                   	pop    %ebp
  801d90:	c3                   	ret    
  801d91:	8d 76 00             	lea    0x0(%esi),%esi
  801d94:	2b 04 24             	sub    (%esp),%eax
  801d97:	19 fa                	sbb    %edi,%edx
  801d99:	89 d1                	mov    %edx,%ecx
  801d9b:	89 c6                	mov    %eax,%esi
  801d9d:	e9 71 ff ff ff       	jmp    801d13 <__umoddi3+0xb3>
  801da2:	66 90                	xchg   %ax,%ax
  801da4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801da8:	72 ea                	jb     801d94 <__umoddi3+0x134>
  801daa:	89 d9                	mov    %ebx,%ecx
  801dac:	e9 62 ff ff ff       	jmp    801d13 <__umoddi3+0xb3>
