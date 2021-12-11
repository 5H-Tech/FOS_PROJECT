
obj/user/tst_page_replacement_free_rapid_proc_2:     file format elf32-i386


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
  800031:	e8 47 05 00 00       	call   80057d <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
char* ptr = (char* )0x0801000 ;
char* ptr2 = (char* )0x0804000 ;
char* ptr3 = (char*) 0xeebfe000 - (PAGE_SIZE) -1;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec bc 00 00 00    	sub    $0xbc,%esp

//	cprintf("envID = %d\n",envID);
	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800044:	a1 20 30 80 00       	mov    0x803020,%eax
  800049:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80004f:	8b 00                	mov    (%eax),%eax
  800051:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800054:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800057:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80005c:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800061:	74 14                	je     800077 <_main+0x3f>
  800063:	83 ec 04             	sub    $0x4,%esp
  800066:	68 c0 1f 80 00       	push   $0x801fc0
  80006b:	6a 12                	push   $0x12
  80006d:	68 04 20 80 00       	push   $0x802004
  800072:	e8 4b 06 00 00       	call   8006c2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800077:	a1 20 30 80 00       	mov    0x803020,%eax
  80007c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800082:	83 c0 10             	add    $0x10,%eax
  800085:	8b 00                	mov    (%eax),%eax
  800087:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80008a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80008d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800092:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800097:	74 14                	je     8000ad <_main+0x75>
  800099:	83 ec 04             	sub    $0x4,%esp
  80009c:	68 c0 1f 80 00       	push   $0x801fc0
  8000a1:	6a 13                	push   $0x13
  8000a3:	68 04 20 80 00       	push   $0x802004
  8000a8:	e8 15 06 00 00       	call   8006c2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000ad:	a1 20 30 80 00       	mov    0x803020,%eax
  8000b2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000b8:	83 c0 20             	add    $0x20,%eax
  8000bb:	8b 00                	mov    (%eax),%eax
  8000bd:	89 45 d8             	mov    %eax,-0x28(%ebp)
  8000c0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000c3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c8:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000cd:	74 14                	je     8000e3 <_main+0xab>
  8000cf:	83 ec 04             	sub    $0x4,%esp
  8000d2:	68 c0 1f 80 00       	push   $0x801fc0
  8000d7:	6a 14                	push   $0x14
  8000d9:	68 04 20 80 00       	push   $0x802004
  8000de:	e8 df 05 00 00       	call   8006c2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000e3:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e8:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000ee:	83 c0 30             	add    $0x30,%eax
  8000f1:	8b 00                	mov    (%eax),%eax
  8000f3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8000f6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000f9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000fe:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800103:	74 14                	je     800119 <_main+0xe1>
  800105:	83 ec 04             	sub    $0x4,%esp
  800108:	68 c0 1f 80 00       	push   $0x801fc0
  80010d:	6a 15                	push   $0x15
  80010f:	68 04 20 80 00       	push   $0x802004
  800114:	e8 a9 05 00 00       	call   8006c2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800119:	a1 20 30 80 00       	mov    0x803020,%eax
  80011e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800124:	83 c0 40             	add    $0x40,%eax
  800127:	8b 00                	mov    (%eax),%eax
  800129:	89 45 d0             	mov    %eax,-0x30(%ebp)
  80012c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80012f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800134:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800139:	74 14                	je     80014f <_main+0x117>
  80013b:	83 ec 04             	sub    $0x4,%esp
  80013e:	68 c0 1f 80 00       	push   $0x801fc0
  800143:	6a 16                	push   $0x16
  800145:	68 04 20 80 00       	push   $0x802004
  80014a:	e8 73 05 00 00       	call   8006c2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80014f:	a1 20 30 80 00       	mov    0x803020,%eax
  800154:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80015a:	83 c0 50             	add    $0x50,%eax
  80015d:	8b 00                	mov    (%eax),%eax
  80015f:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800162:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800165:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80016a:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80016f:	74 14                	je     800185 <_main+0x14d>
  800171:	83 ec 04             	sub    $0x4,%esp
  800174:	68 c0 1f 80 00       	push   $0x801fc0
  800179:	6a 17                	push   $0x17
  80017b:	68 04 20 80 00       	push   $0x802004
  800180:	e8 3d 05 00 00       	call   8006c2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800185:	a1 20 30 80 00       	mov    0x803020,%eax
  80018a:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800190:	83 c0 60             	add    $0x60,%eax
  800193:	8b 00                	mov    (%eax),%eax
  800195:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800198:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80019b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001a0:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001a5:	74 14                	je     8001bb <_main+0x183>
  8001a7:	83 ec 04             	sub    $0x4,%esp
  8001aa:	68 c0 1f 80 00       	push   $0x801fc0
  8001af:	6a 18                	push   $0x18
  8001b1:	68 04 20 80 00       	push   $0x802004
  8001b6:	e8 07 05 00 00       	call   8006c2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001bb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001c6:	83 c0 70             	add    $0x70,%eax
  8001c9:	8b 00                	mov    (%eax),%eax
  8001cb:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  8001ce:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001d1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d6:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001db:	74 14                	je     8001f1 <_main+0x1b9>
  8001dd:	83 ec 04             	sub    $0x4,%esp
  8001e0:	68 c0 1f 80 00       	push   $0x801fc0
  8001e5:	6a 19                	push   $0x19
  8001e7:	68 04 20 80 00       	push   $0x802004
  8001ec:	e8 d1 04 00 00       	call   8006c2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001f1:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f6:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001fc:	83 e8 80             	sub    $0xffffff80,%eax
  8001ff:	8b 00                	mov    (%eax),%eax
  800201:	89 45 c0             	mov    %eax,-0x40(%ebp)
  800204:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800207:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80020c:	3d 00 20 80 00       	cmp    $0x802000,%eax
  800211:	74 14                	je     800227 <_main+0x1ef>
  800213:	83 ec 04             	sub    $0x4,%esp
  800216:	68 c0 1f 80 00       	push   $0x801fc0
  80021b:	6a 1a                	push   $0x1a
  80021d:	68 04 20 80 00       	push   $0x802004
  800222:	e8 9b 04 00 00       	call   8006c2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800227:	a1 20 30 80 00       	mov    0x803020,%eax
  80022c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800232:	05 90 00 00 00       	add    $0x90,%eax
  800237:	8b 00                	mov    (%eax),%eax
  800239:	89 45 bc             	mov    %eax,-0x44(%ebp)
  80023c:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80023f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800244:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800249:	74 14                	je     80025f <_main+0x227>
  80024b:	83 ec 04             	sub    $0x4,%esp
  80024e:	68 c0 1f 80 00       	push   $0x801fc0
  800253:	6a 1b                	push   $0x1b
  800255:	68 04 20 80 00       	push   $0x802004
  80025a:	e8 63 04 00 00       	call   8006c2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0x804000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80025f:	a1 20 30 80 00       	mov    0x803020,%eax
  800264:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80026a:	05 a0 00 00 00       	add    $0xa0,%eax
  80026f:	8b 00                	mov    (%eax),%eax
  800271:	89 45 b8             	mov    %eax,-0x48(%ebp)
  800274:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800277:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80027c:	3d 00 40 80 00       	cmp    $0x804000,%eax
  800281:	74 14                	je     800297 <_main+0x25f>
  800283:	83 ec 04             	sub    $0x4,%esp
  800286:	68 c0 1f 80 00       	push   $0x801fc0
  80028b:	6a 1c                	push   $0x1c
  80028d:	68 04 20 80 00       	push   $0x802004
  800292:	e8 2b 04 00 00       	call   8006c2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[11].virtual_address,PAGE_SIZE) !=   0x805000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800297:	a1 20 30 80 00       	mov    0x803020,%eax
  80029c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002a2:	05 b0 00 00 00       	add    $0xb0,%eax
  8002a7:	8b 00                	mov    (%eax),%eax
  8002a9:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  8002ac:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  8002af:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002b4:	3d 00 50 80 00       	cmp    $0x805000,%eax
  8002b9:	74 14                	je     8002cf <_main+0x297>
  8002bb:	83 ec 04             	sub    $0x4,%esp
  8002be:	68 c0 1f 80 00       	push   $0x801fc0
  8002c3:	6a 1d                	push   $0x1d
  8002c5:	68 04 20 80 00       	push   $0x802004
  8002ca:	e8 f3 03 00 00       	call   8006c2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[12].virtual_address,PAGE_SIZE) !=   0x806000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8002cf:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d4:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002da:	05 c0 00 00 00       	add    $0xc0,%eax
  8002df:	8b 00                	mov    (%eax),%eax
  8002e1:	89 45 b0             	mov    %eax,-0x50(%ebp)
  8002e4:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8002e7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002ec:	3d 00 60 80 00       	cmp    $0x806000,%eax
  8002f1:	74 14                	je     800307 <_main+0x2cf>
  8002f3:	83 ec 04             	sub    $0x4,%esp
  8002f6:	68 c0 1f 80 00       	push   $0x801fc0
  8002fb:	6a 1e                	push   $0x1e
  8002fd:	68 04 20 80 00       	push   $0x802004
  800302:	e8 bb 03 00 00       	call   8006c2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[13].virtual_address,PAGE_SIZE) !=   0x807000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800307:	a1 20 30 80 00       	mov    0x803020,%eax
  80030c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800312:	05 d0 00 00 00       	add    $0xd0,%eax
  800317:	8b 00                	mov    (%eax),%eax
  800319:	89 45 ac             	mov    %eax,-0x54(%ebp)
  80031c:	8b 45 ac             	mov    -0x54(%ebp),%eax
  80031f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800324:	3d 00 70 80 00       	cmp    $0x807000,%eax
  800329:	74 14                	je     80033f <_main+0x307>
  80032b:	83 ec 04             	sub    $0x4,%esp
  80032e:	68 c0 1f 80 00       	push   $0x801fc0
  800333:	6a 1f                	push   $0x1f
  800335:	68 04 20 80 00       	push   $0x802004
  80033a:	e8 83 03 00 00       	call   8006c2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[14].virtual_address,PAGE_SIZE) !=   0x808000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80033f:	a1 20 30 80 00       	mov    0x803020,%eax
  800344:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80034a:	05 e0 00 00 00       	add    $0xe0,%eax
  80034f:	8b 00                	mov    (%eax),%eax
  800351:	89 45 a8             	mov    %eax,-0x58(%ebp)
  800354:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800357:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80035c:	3d 00 80 80 00       	cmp    $0x808000,%eax
  800361:	74 14                	je     800377 <_main+0x33f>
  800363:	83 ec 04             	sub    $0x4,%esp
  800366:	68 c0 1f 80 00       	push   $0x801fc0
  80036b:	6a 20                	push   $0x20
  80036d:	68 04 20 80 00       	push   $0x802004
  800372:	e8 4b 03 00 00       	call   8006c2 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[15].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800377:	a1 20 30 80 00       	mov    0x803020,%eax
  80037c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800382:	05 f0 00 00 00       	add    $0xf0,%eax
  800387:	8b 00                	mov    (%eax),%eax
  800389:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  80038c:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  80038f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800394:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800399:	74 14                	je     8003af <_main+0x377>
  80039b:	83 ec 04             	sub    $0x4,%esp
  80039e:	68 c0 1f 80 00       	push   $0x801fc0
  8003a3:	6a 21                	push   $0x21
  8003a5:	68 04 20 80 00       	push   $0x802004
  8003aa:	e8 13 03 00 00       	call   8006c2 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  8003af:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b4:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  8003ba:	85 c0                	test   %eax,%eax
  8003bc:	74 14                	je     8003d2 <_main+0x39a>
  8003be:	83 ec 04             	sub    $0x4,%esp
  8003c1:	68 34 20 80 00       	push   $0x802034
  8003c6:	6a 22                	push   $0x22
  8003c8:	68 04 20 80 00       	push   $0x802004
  8003cd:	e8 f0 02 00 00       	call   8006c2 <_panic>
	}

	// Create & run the slave environments
	int IDs[4];
	IDs[0] = sys_create_env("fos_helloWorld", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  8003d2:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d7:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  8003dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e2:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  8003e8:	89 c1                	mov    %eax,%ecx
  8003ea:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ef:	8b 40 74             	mov    0x74(%eax),%eax
  8003f2:	52                   	push   %edx
  8003f3:	51                   	push   %ecx
  8003f4:	50                   	push   %eax
  8003f5:	68 7a 20 80 00       	push   $0x80207a
  8003fa:	e8 b0 16 00 00       	call   801aaf <sys_create_env>
  8003ff:	83 c4 10             	add    $0x10,%esp
  800402:	89 45 80             	mov    %eax,-0x80(%ebp)
	sys_run_env(IDs[0]);
  800405:	8b 45 80             	mov    -0x80(%ebp),%eax
  800408:	83 ec 0c             	sub    $0xc,%esp
  80040b:	50                   	push   %eax
  80040c:	e8 bc 16 00 00       	call   801acd <sys_run_env>
  800411:	83 c4 10             	add    $0x10,%esp
	for(int i = 1; i < 4; ++i)
  800414:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  80041b:	eb 4f                	jmp    80046c <_main+0x434>
	{
		IDs[i] = sys_create_env("dummy_process", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  80041d:	a1 20 30 80 00       	mov    0x803020,%eax
  800422:	8b 90 84 3c 01 00    	mov    0x13c84(%eax),%edx
  800428:	a1 20 30 80 00       	mov    0x803020,%eax
  80042d:	8b 80 c4 3c 01 00    	mov    0x13cc4(%eax),%eax
  800433:	89 c1                	mov    %eax,%ecx
  800435:	a1 20 30 80 00       	mov    0x803020,%eax
  80043a:	8b 40 74             	mov    0x74(%eax),%eax
  80043d:	52                   	push   %edx
  80043e:	51                   	push   %ecx
  80043f:	50                   	push   %eax
  800440:	68 89 20 80 00       	push   $0x802089
  800445:	e8 65 16 00 00       	call   801aaf <sys_create_env>
  80044a:	83 c4 10             	add    $0x10,%esp
  80044d:	89 c2                	mov    %eax,%edx
  80044f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800452:	89 54 85 80          	mov    %edx,-0x80(%ebp,%eax,4)
		sys_run_env(IDs[i]);
  800456:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800459:	8b 44 85 80          	mov    -0x80(%ebp,%eax,4),%eax
  80045d:	83 ec 0c             	sub    $0xc,%esp
  800460:	50                   	push   %eax
  800461:	e8 67 16 00 00       	call   801acd <sys_run_env>
  800466:	83 c4 10             	add    $0x10,%esp

	// Create & run the slave environments
	int IDs[4];
	IDs[0] = sys_create_env("fos_helloWorld", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
	sys_run_env(IDs[0]);
	for(int i = 1; i < 4; ++i)
  800469:	ff 45 e4             	incl   -0x1c(%ebp)
  80046c:	83 7d e4 03          	cmpl   $0x3,-0x1c(%ebp)
  800470:	7e ab                	jle    80041d <_main+0x3e5>
	{
		IDs[i] = sys_create_env("dummy_process", (myEnv->page_WS_max_size),(myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
		sys_run_env(IDs[i]);
	}
	// To check that the slave environments completed successfully
	rsttst();
  800472:	e8 20 17 00 00       	call   801b97 <rsttst>

	uint32 freePagesBefore = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  800477:	e8 de 13 00 00       	call   80185a <sys_calculate_free_frames>
  80047c:	89 c3                	mov    %eax,%ebx
  80047e:	e8 f0 13 00 00       	call   801873 <sys_calculate_modified_frames>
  800483:	01 d8                	add    %ebx,%eax
  800485:	89 45 a0             	mov    %eax,-0x60(%ebp)
	uint32 usedDiskPagesBefore = sys_pf_calculate_allocated_pages();
  800488:	e8 50 14 00 00       	call   8018dd <sys_pf_calculate_allocated_pages>
  80048d:	89 45 9c             	mov    %eax,-0x64(%ebp)
	// Check the number of pages shall be deleted with the first fault after freeing the process
	int pagesToBeDeletedCount = sys_calculate_pages_tobe_removed_ready_exit(2);
  800490:	83 ec 0c             	sub    $0xc,%esp
  800493:	6a 02                	push   $0x2
  800495:	e8 5c 14 00 00       	call   8018f6 <sys_calculate_pages_tobe_removed_ready_exit>
  80049a:	83 c4 10             	add    $0x10,%esp
  80049d:	89 45 98             	mov    %eax,-0x68(%ebp)

	// FAULT with TWO STACK Pages to FREE the rapid running MASTER process
	char x = *ptr3;
  8004a0:	a1 08 30 80 00       	mov    0x803008,%eax
  8004a5:	8a 00                	mov    (%eax),%al
  8004a7:	88 45 97             	mov    %al,-0x69(%ebp)

	uint32 expectedPages[16] = {0xeebfc000,0x800000,0x801000,0x802000,0x803000,0xeebfd000,0,0,0,0,0,0,0,0,0,0};
  8004aa:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
  8004b0:	bb 00 22 80 00       	mov    $0x802200,%ebx
  8004b5:	ba 10 00 00 00       	mov    $0x10,%edx
  8004ba:	89 c7                	mov    %eax,%edi
  8004bc:	89 de                	mov    %ebx,%esi
  8004be:	89 d1                	mov    %edx,%ecx
  8004c0:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	//cprintf("Checking PAGE LRU algorithm... \n");
	{
		CheckWSWithoutLastIndex(expectedPages, 16);
  8004c2:	83 ec 08             	sub    $0x8,%esp
  8004c5:	6a 10                	push   $0x10
  8004c7:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
  8004cd:	50                   	push   %eax
  8004ce:	e8 61 02 00 00       	call   800734 <CheckWSWithoutLastIndex>
  8004d3:	83 c4 10             	add    $0x10,%esp

		/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
		//if(myEnv->page_last_WS_index != 2) panic("wrong PAGE WS pointer location");
	}

	x = *(ptr3-PAGE_SIZE);
  8004d6:	a1 08 30 80 00       	mov    0x803008,%eax
  8004db:	8a 80 00 f0 ff ff    	mov    -0x1000(%eax),%al
  8004e1:	88 45 97             	mov    %al,-0x69(%ebp)

	//cprintf("Checking Allocation in Mem & Page File... \n");
	//AFTER freeing MEMORY
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPagesBefore) !=  2) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  8004e4:	e8 f4 13 00 00       	call   8018dd <sys_pf_calculate_allocated_pages>
  8004e9:	2b 45 9c             	sub    -0x64(%ebp),%eax
  8004ec:	83 f8 02             	cmp    $0x2,%eax
  8004ef:	74 14                	je     800505 <_main+0x4cd>
  8004f1:	83 ec 04             	sub    $0x4,%esp
  8004f4:	68 98 20 80 00       	push   $0x802098
  8004f9:	6a 59                	push   $0x59
  8004fb:	68 04 20 80 00       	push   $0x802004
  800500:	e8 bd 01 00 00       	call   8006c2 <_panic>
		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  800505:	e8 50 13 00 00       	call   80185a <sys_calculate_free_frames>
  80050a:	89 c3                	mov    %eax,%ebx
  80050c:	e8 62 13 00 00       	call   801873 <sys_calculate_modified_frames>
  800511:	01 d8                	add    %ebx,%eax
  800513:	89 45 90             	mov    %eax,-0x70(%ebp)
		if( (freePagesBefore + pagesToBeDeletedCount - 3) != freePagesAfter )	// 3 => 2 STACK PAGES and 1 CODE page started from the fault of the stack page ALLOCATED
  800516:	8b 55 98             	mov    -0x68(%ebp),%edx
  800519:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80051c:	01 d0                	add    %edx,%eax
  80051e:	83 e8 03             	sub    $0x3,%eax
  800521:	3b 45 90             	cmp    -0x70(%ebp),%eax
  800524:	74 20                	je     800546 <_main+0x50e>
			panic("Extra memory are wrongly allocated ... It's REplacement: extra/less frames have been FREED for the running RAPID process %d %d", freePagesBefore + pagesToBeDeletedCount, freePagesAfter);
  800526:	8b 55 98             	mov    -0x68(%ebp),%edx
  800529:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80052c:	01 d0                	add    %edx,%eax
  80052e:	83 ec 0c             	sub    $0xc,%esp
  800531:	ff 75 90             	pushl  -0x70(%ebp)
  800534:	50                   	push   %eax
  800535:	68 04 21 80 00       	push   $0x802104
  80053a:	6a 5c                	push   $0x5c
  80053c:	68 04 20 80 00       	push   $0x802004
  800541:	e8 7c 01 00 00       	call   8006c2 <_panic>
	}

	//cprintf("Checking PAGE LRU algorithm... \n");
	{
		expectedPages[6] =  0xeebfb000;
  800546:	c7 85 58 ff ff ff 00 	movl   $0xeebfb000,-0xa8(%ebp)
  80054d:	b0 bf ee 
		CheckWSWithoutLastIndex(expectedPages, 16);
  800550:	83 ec 08             	sub    $0x8,%esp
  800553:	6a 10                	push   $0x10
  800555:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
  80055b:	50                   	push   %eax
  80055c:	e8 d3 01 00 00       	call   800734 <CheckWSWithoutLastIndex>
  800561:	83 c4 10             	add    $0x10,%esp

		/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
		//if(myEnv->page_last_WS_index != 3) panic("wrong PAGE WS pointer location");
	}

	cprintf("Congratulations!! test PAGE replacement [FREEING RAPID PROCESS 2] using LRU is completed successfully.\n");
  800564:	83 ec 0c             	sub    $0xc,%esp
  800567:	68 84 21 80 00       	push   $0x802184
  80056c:	e8 f3 03 00 00       	call   800964 <cprintf>
  800571:	83 c4 10             	add    $0x10,%esp
	return;
  800574:	90                   	nop
}
  800575:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800578:	5b                   	pop    %ebx
  800579:	5e                   	pop    %esi
  80057a:	5f                   	pop    %edi
  80057b:	5d                   	pop    %ebp
  80057c:	c3                   	ret    

0080057d <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80057d:	55                   	push   %ebp
  80057e:	89 e5                	mov    %esp,%ebp
  800580:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800583:	e8 07 12 00 00       	call   80178f <sys_getenvindex>
  800588:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80058b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80058e:	89 d0                	mov    %edx,%eax
  800590:	c1 e0 03             	shl    $0x3,%eax
  800593:	01 d0                	add    %edx,%eax
  800595:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80059c:	01 c8                	add    %ecx,%eax
  80059e:	01 c0                	add    %eax,%eax
  8005a0:	01 d0                	add    %edx,%eax
  8005a2:	01 c0                	add    %eax,%eax
  8005a4:	01 d0                	add    %edx,%eax
  8005a6:	89 c2                	mov    %eax,%edx
  8005a8:	c1 e2 05             	shl    $0x5,%edx
  8005ab:	29 c2                	sub    %eax,%edx
  8005ad:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8005b4:	89 c2                	mov    %eax,%edx
  8005b6:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8005bc:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005c1:	a1 20 30 80 00       	mov    0x803020,%eax
  8005c6:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8005cc:	84 c0                	test   %al,%al
  8005ce:	74 0f                	je     8005df <libmain+0x62>
		binaryname = myEnv->prog_name;
  8005d0:	a1 20 30 80 00       	mov    0x803020,%eax
  8005d5:	05 40 3c 01 00       	add    $0x13c40,%eax
  8005da:	a3 0c 30 80 00       	mov    %eax,0x80300c

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8005df:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8005e3:	7e 0a                	jle    8005ef <libmain+0x72>
		binaryname = argv[0];
  8005e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005e8:	8b 00                	mov    (%eax),%eax
  8005ea:	a3 0c 30 80 00       	mov    %eax,0x80300c

	// call user main routine
	_main(argc, argv);
  8005ef:	83 ec 08             	sub    $0x8,%esp
  8005f2:	ff 75 0c             	pushl  0xc(%ebp)
  8005f5:	ff 75 08             	pushl  0x8(%ebp)
  8005f8:	e8 3b fa ff ff       	call   800038 <_main>
  8005fd:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800600:	e8 25 13 00 00       	call   80192a <sys_disable_interrupt>
	cprintf("**************************************\n");
  800605:	83 ec 0c             	sub    $0xc,%esp
  800608:	68 58 22 80 00       	push   $0x802258
  80060d:	e8 52 03 00 00       	call   800964 <cprintf>
  800612:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800615:	a1 20 30 80 00       	mov    0x803020,%eax
  80061a:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800620:	a1 20 30 80 00       	mov    0x803020,%eax
  800625:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  80062b:	83 ec 04             	sub    $0x4,%esp
  80062e:	52                   	push   %edx
  80062f:	50                   	push   %eax
  800630:	68 80 22 80 00       	push   $0x802280
  800635:	e8 2a 03 00 00       	call   800964 <cprintf>
  80063a:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80063d:	a1 20 30 80 00       	mov    0x803020,%eax
  800642:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800648:	a1 20 30 80 00       	mov    0x803020,%eax
  80064d:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800653:	83 ec 04             	sub    $0x4,%esp
  800656:	52                   	push   %edx
  800657:	50                   	push   %eax
  800658:	68 a8 22 80 00       	push   $0x8022a8
  80065d:	e8 02 03 00 00       	call   800964 <cprintf>
  800662:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800665:	a1 20 30 80 00       	mov    0x803020,%eax
  80066a:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800670:	83 ec 08             	sub    $0x8,%esp
  800673:	50                   	push   %eax
  800674:	68 e9 22 80 00       	push   $0x8022e9
  800679:	e8 e6 02 00 00       	call   800964 <cprintf>
  80067e:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800681:	83 ec 0c             	sub    $0xc,%esp
  800684:	68 58 22 80 00       	push   $0x802258
  800689:	e8 d6 02 00 00       	call   800964 <cprintf>
  80068e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800691:	e8 ae 12 00 00       	call   801944 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800696:	e8 19 00 00 00       	call   8006b4 <exit>
}
  80069b:	90                   	nop
  80069c:	c9                   	leave  
  80069d:	c3                   	ret    

0080069e <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80069e:	55                   	push   %ebp
  80069f:	89 e5                	mov    %esp,%ebp
  8006a1:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006a4:	83 ec 0c             	sub    $0xc,%esp
  8006a7:	6a 00                	push   $0x0
  8006a9:	e8 ad 10 00 00       	call   80175b <sys_env_destroy>
  8006ae:	83 c4 10             	add    $0x10,%esp
}
  8006b1:	90                   	nop
  8006b2:	c9                   	leave  
  8006b3:	c3                   	ret    

008006b4 <exit>:

void
exit(void)
{
  8006b4:	55                   	push   %ebp
  8006b5:	89 e5                	mov    %esp,%ebp
  8006b7:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006ba:	e8 02 11 00 00       	call   8017c1 <sys_env_exit>
}
  8006bf:	90                   	nop
  8006c0:	c9                   	leave  
  8006c1:	c3                   	ret    

008006c2 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006c2:	55                   	push   %ebp
  8006c3:	89 e5                	mov    %esp,%ebp
  8006c5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006c8:	8d 45 10             	lea    0x10(%ebp),%eax
  8006cb:	83 c0 04             	add    $0x4,%eax
  8006ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006d1:	a1 18 c1 80 00       	mov    0x80c118,%eax
  8006d6:	85 c0                	test   %eax,%eax
  8006d8:	74 16                	je     8006f0 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006da:	a1 18 c1 80 00       	mov    0x80c118,%eax
  8006df:	83 ec 08             	sub    $0x8,%esp
  8006e2:	50                   	push   %eax
  8006e3:	68 00 23 80 00       	push   $0x802300
  8006e8:	e8 77 02 00 00       	call   800964 <cprintf>
  8006ed:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8006f0:	a1 0c 30 80 00       	mov    0x80300c,%eax
  8006f5:	ff 75 0c             	pushl  0xc(%ebp)
  8006f8:	ff 75 08             	pushl  0x8(%ebp)
  8006fb:	50                   	push   %eax
  8006fc:	68 05 23 80 00       	push   $0x802305
  800701:	e8 5e 02 00 00       	call   800964 <cprintf>
  800706:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800709:	8b 45 10             	mov    0x10(%ebp),%eax
  80070c:	83 ec 08             	sub    $0x8,%esp
  80070f:	ff 75 f4             	pushl  -0xc(%ebp)
  800712:	50                   	push   %eax
  800713:	e8 e1 01 00 00       	call   8008f9 <vcprintf>
  800718:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80071b:	83 ec 08             	sub    $0x8,%esp
  80071e:	6a 00                	push   $0x0
  800720:	68 21 23 80 00       	push   $0x802321
  800725:	e8 cf 01 00 00       	call   8008f9 <vcprintf>
  80072a:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80072d:	e8 82 ff ff ff       	call   8006b4 <exit>

	// should not return here
	while (1) ;
  800732:	eb fe                	jmp    800732 <_panic+0x70>

00800734 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800734:	55                   	push   %ebp
  800735:	89 e5                	mov    %esp,%ebp
  800737:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80073a:	a1 20 30 80 00       	mov    0x803020,%eax
  80073f:	8b 50 74             	mov    0x74(%eax),%edx
  800742:	8b 45 0c             	mov    0xc(%ebp),%eax
  800745:	39 c2                	cmp    %eax,%edx
  800747:	74 14                	je     80075d <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800749:	83 ec 04             	sub    $0x4,%esp
  80074c:	68 24 23 80 00       	push   $0x802324
  800751:	6a 26                	push   $0x26
  800753:	68 70 23 80 00       	push   $0x802370
  800758:	e8 65 ff ff ff       	call   8006c2 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80075d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800764:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80076b:	e9 b6 00 00 00       	jmp    800826 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800770:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800773:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80077a:	8b 45 08             	mov    0x8(%ebp),%eax
  80077d:	01 d0                	add    %edx,%eax
  80077f:	8b 00                	mov    (%eax),%eax
  800781:	85 c0                	test   %eax,%eax
  800783:	75 08                	jne    80078d <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800785:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800788:	e9 96 00 00 00       	jmp    800823 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80078d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800794:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80079b:	eb 5d                	jmp    8007fa <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80079d:	a1 20 30 80 00       	mov    0x803020,%eax
  8007a2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007a8:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007ab:	c1 e2 04             	shl    $0x4,%edx
  8007ae:	01 d0                	add    %edx,%eax
  8007b0:	8a 40 04             	mov    0x4(%eax),%al
  8007b3:	84 c0                	test   %al,%al
  8007b5:	75 40                	jne    8007f7 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8007bc:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007c2:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007c5:	c1 e2 04             	shl    $0x4,%edx
  8007c8:	01 d0                	add    %edx,%eax
  8007ca:	8b 00                	mov    (%eax),%eax
  8007cc:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007cf:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007d2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007d7:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8007d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007dc:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8007e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e6:	01 c8                	add    %ecx,%eax
  8007e8:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007ea:	39 c2                	cmp    %eax,%edx
  8007ec:	75 09                	jne    8007f7 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8007ee:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8007f5:	eb 12                	jmp    800809 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007f7:	ff 45 e8             	incl   -0x18(%ebp)
  8007fa:	a1 20 30 80 00       	mov    0x803020,%eax
  8007ff:	8b 50 74             	mov    0x74(%eax),%edx
  800802:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800805:	39 c2                	cmp    %eax,%edx
  800807:	77 94                	ja     80079d <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800809:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80080d:	75 14                	jne    800823 <CheckWSWithoutLastIndex+0xef>
			panic(
  80080f:	83 ec 04             	sub    $0x4,%esp
  800812:	68 7c 23 80 00       	push   $0x80237c
  800817:	6a 3a                	push   $0x3a
  800819:	68 70 23 80 00       	push   $0x802370
  80081e:	e8 9f fe ff ff       	call   8006c2 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800823:	ff 45 f0             	incl   -0x10(%ebp)
  800826:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800829:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80082c:	0f 8c 3e ff ff ff    	jl     800770 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800832:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800839:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800840:	eb 20                	jmp    800862 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800842:	a1 20 30 80 00       	mov    0x803020,%eax
  800847:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80084d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800850:	c1 e2 04             	shl    $0x4,%edx
  800853:	01 d0                	add    %edx,%eax
  800855:	8a 40 04             	mov    0x4(%eax),%al
  800858:	3c 01                	cmp    $0x1,%al
  80085a:	75 03                	jne    80085f <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  80085c:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80085f:	ff 45 e0             	incl   -0x20(%ebp)
  800862:	a1 20 30 80 00       	mov    0x803020,%eax
  800867:	8b 50 74             	mov    0x74(%eax),%edx
  80086a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80086d:	39 c2                	cmp    %eax,%edx
  80086f:	77 d1                	ja     800842 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800871:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800874:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800877:	74 14                	je     80088d <CheckWSWithoutLastIndex+0x159>
		panic(
  800879:	83 ec 04             	sub    $0x4,%esp
  80087c:	68 d0 23 80 00       	push   $0x8023d0
  800881:	6a 44                	push   $0x44
  800883:	68 70 23 80 00       	push   $0x802370
  800888:	e8 35 fe ff ff       	call   8006c2 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80088d:	90                   	nop
  80088e:	c9                   	leave  
  80088f:	c3                   	ret    

00800890 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800890:	55                   	push   %ebp
  800891:	89 e5                	mov    %esp,%ebp
  800893:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800896:	8b 45 0c             	mov    0xc(%ebp),%eax
  800899:	8b 00                	mov    (%eax),%eax
  80089b:	8d 48 01             	lea    0x1(%eax),%ecx
  80089e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008a1:	89 0a                	mov    %ecx,(%edx)
  8008a3:	8b 55 08             	mov    0x8(%ebp),%edx
  8008a6:	88 d1                	mov    %dl,%cl
  8008a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008ab:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b2:	8b 00                	mov    (%eax),%eax
  8008b4:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008b9:	75 2c                	jne    8008e7 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008bb:	a0 24 30 80 00       	mov    0x803024,%al
  8008c0:	0f b6 c0             	movzbl %al,%eax
  8008c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008c6:	8b 12                	mov    (%edx),%edx
  8008c8:	89 d1                	mov    %edx,%ecx
  8008ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008cd:	83 c2 08             	add    $0x8,%edx
  8008d0:	83 ec 04             	sub    $0x4,%esp
  8008d3:	50                   	push   %eax
  8008d4:	51                   	push   %ecx
  8008d5:	52                   	push   %edx
  8008d6:	e8 3e 0e 00 00       	call   801719 <sys_cputs>
  8008db:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8008de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8008e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ea:	8b 40 04             	mov    0x4(%eax),%eax
  8008ed:	8d 50 01             	lea    0x1(%eax),%edx
  8008f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f3:	89 50 04             	mov    %edx,0x4(%eax)
}
  8008f6:	90                   	nop
  8008f7:	c9                   	leave  
  8008f8:	c3                   	ret    

008008f9 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8008f9:	55                   	push   %ebp
  8008fa:	89 e5                	mov    %esp,%ebp
  8008fc:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800902:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800909:	00 00 00 
	b.cnt = 0;
  80090c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800913:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800916:	ff 75 0c             	pushl  0xc(%ebp)
  800919:	ff 75 08             	pushl  0x8(%ebp)
  80091c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800922:	50                   	push   %eax
  800923:	68 90 08 80 00       	push   $0x800890
  800928:	e8 11 02 00 00       	call   800b3e <vprintfmt>
  80092d:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800930:	a0 24 30 80 00       	mov    0x803024,%al
  800935:	0f b6 c0             	movzbl %al,%eax
  800938:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80093e:	83 ec 04             	sub    $0x4,%esp
  800941:	50                   	push   %eax
  800942:	52                   	push   %edx
  800943:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800949:	83 c0 08             	add    $0x8,%eax
  80094c:	50                   	push   %eax
  80094d:	e8 c7 0d 00 00       	call   801719 <sys_cputs>
  800952:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800955:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80095c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800962:	c9                   	leave  
  800963:	c3                   	ret    

00800964 <cprintf>:

int cprintf(const char *fmt, ...) {
  800964:	55                   	push   %ebp
  800965:	89 e5                	mov    %esp,%ebp
  800967:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80096a:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800971:	8d 45 0c             	lea    0xc(%ebp),%eax
  800974:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800977:	8b 45 08             	mov    0x8(%ebp),%eax
  80097a:	83 ec 08             	sub    $0x8,%esp
  80097d:	ff 75 f4             	pushl  -0xc(%ebp)
  800980:	50                   	push   %eax
  800981:	e8 73 ff ff ff       	call   8008f9 <vcprintf>
  800986:	83 c4 10             	add    $0x10,%esp
  800989:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80098c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80098f:	c9                   	leave  
  800990:	c3                   	ret    

00800991 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800991:	55                   	push   %ebp
  800992:	89 e5                	mov    %esp,%ebp
  800994:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800997:	e8 8e 0f 00 00       	call   80192a <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80099c:	8d 45 0c             	lea    0xc(%ebp),%eax
  80099f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a5:	83 ec 08             	sub    $0x8,%esp
  8009a8:	ff 75 f4             	pushl  -0xc(%ebp)
  8009ab:	50                   	push   %eax
  8009ac:	e8 48 ff ff ff       	call   8008f9 <vcprintf>
  8009b1:	83 c4 10             	add    $0x10,%esp
  8009b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8009b7:	e8 88 0f 00 00       	call   801944 <sys_enable_interrupt>
	return cnt;
  8009bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009bf:	c9                   	leave  
  8009c0:	c3                   	ret    

008009c1 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009c1:	55                   	push   %ebp
  8009c2:	89 e5                	mov    %esp,%ebp
  8009c4:	53                   	push   %ebx
  8009c5:	83 ec 14             	sub    $0x14,%esp
  8009c8:	8b 45 10             	mov    0x10(%ebp),%eax
  8009cb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009ce:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8009d4:	8b 45 18             	mov    0x18(%ebp),%eax
  8009d7:	ba 00 00 00 00       	mov    $0x0,%edx
  8009dc:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009df:	77 55                	ja     800a36 <printnum+0x75>
  8009e1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009e4:	72 05                	jb     8009eb <printnum+0x2a>
  8009e6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8009e9:	77 4b                	ja     800a36 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8009eb:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8009ee:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8009f1:	8b 45 18             	mov    0x18(%ebp),%eax
  8009f4:	ba 00 00 00 00       	mov    $0x0,%edx
  8009f9:	52                   	push   %edx
  8009fa:	50                   	push   %eax
  8009fb:	ff 75 f4             	pushl  -0xc(%ebp)
  8009fe:	ff 75 f0             	pushl  -0x10(%ebp)
  800a01:	e8 46 13 00 00       	call   801d4c <__udivdi3>
  800a06:	83 c4 10             	add    $0x10,%esp
  800a09:	83 ec 04             	sub    $0x4,%esp
  800a0c:	ff 75 20             	pushl  0x20(%ebp)
  800a0f:	53                   	push   %ebx
  800a10:	ff 75 18             	pushl  0x18(%ebp)
  800a13:	52                   	push   %edx
  800a14:	50                   	push   %eax
  800a15:	ff 75 0c             	pushl  0xc(%ebp)
  800a18:	ff 75 08             	pushl  0x8(%ebp)
  800a1b:	e8 a1 ff ff ff       	call   8009c1 <printnum>
  800a20:	83 c4 20             	add    $0x20,%esp
  800a23:	eb 1a                	jmp    800a3f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a25:	83 ec 08             	sub    $0x8,%esp
  800a28:	ff 75 0c             	pushl  0xc(%ebp)
  800a2b:	ff 75 20             	pushl  0x20(%ebp)
  800a2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a31:	ff d0                	call   *%eax
  800a33:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a36:	ff 4d 1c             	decl   0x1c(%ebp)
  800a39:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a3d:	7f e6                	jg     800a25 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a3f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a42:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a47:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a4a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a4d:	53                   	push   %ebx
  800a4e:	51                   	push   %ecx
  800a4f:	52                   	push   %edx
  800a50:	50                   	push   %eax
  800a51:	e8 06 14 00 00       	call   801e5c <__umoddi3>
  800a56:	83 c4 10             	add    $0x10,%esp
  800a59:	05 34 26 80 00       	add    $0x802634,%eax
  800a5e:	8a 00                	mov    (%eax),%al
  800a60:	0f be c0             	movsbl %al,%eax
  800a63:	83 ec 08             	sub    $0x8,%esp
  800a66:	ff 75 0c             	pushl  0xc(%ebp)
  800a69:	50                   	push   %eax
  800a6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6d:	ff d0                	call   *%eax
  800a6f:	83 c4 10             	add    $0x10,%esp
}
  800a72:	90                   	nop
  800a73:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a76:	c9                   	leave  
  800a77:	c3                   	ret    

00800a78 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800a78:	55                   	push   %ebp
  800a79:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a7b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a7f:	7e 1c                	jle    800a9d <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800a81:	8b 45 08             	mov    0x8(%ebp),%eax
  800a84:	8b 00                	mov    (%eax),%eax
  800a86:	8d 50 08             	lea    0x8(%eax),%edx
  800a89:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8c:	89 10                	mov    %edx,(%eax)
  800a8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a91:	8b 00                	mov    (%eax),%eax
  800a93:	83 e8 08             	sub    $0x8,%eax
  800a96:	8b 50 04             	mov    0x4(%eax),%edx
  800a99:	8b 00                	mov    (%eax),%eax
  800a9b:	eb 40                	jmp    800add <getuint+0x65>
	else if (lflag)
  800a9d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800aa1:	74 1e                	je     800ac1 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800aa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa6:	8b 00                	mov    (%eax),%eax
  800aa8:	8d 50 04             	lea    0x4(%eax),%edx
  800aab:	8b 45 08             	mov    0x8(%ebp),%eax
  800aae:	89 10                	mov    %edx,(%eax)
  800ab0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab3:	8b 00                	mov    (%eax),%eax
  800ab5:	83 e8 04             	sub    $0x4,%eax
  800ab8:	8b 00                	mov    (%eax),%eax
  800aba:	ba 00 00 00 00       	mov    $0x0,%edx
  800abf:	eb 1c                	jmp    800add <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ac1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac4:	8b 00                	mov    (%eax),%eax
  800ac6:	8d 50 04             	lea    0x4(%eax),%edx
  800ac9:	8b 45 08             	mov    0x8(%ebp),%eax
  800acc:	89 10                	mov    %edx,(%eax)
  800ace:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad1:	8b 00                	mov    (%eax),%eax
  800ad3:	83 e8 04             	sub    $0x4,%eax
  800ad6:	8b 00                	mov    (%eax),%eax
  800ad8:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800add:	5d                   	pop    %ebp
  800ade:	c3                   	ret    

00800adf <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800adf:	55                   	push   %ebp
  800ae0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ae2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ae6:	7e 1c                	jle    800b04 <getint+0x25>
		return va_arg(*ap, long long);
  800ae8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aeb:	8b 00                	mov    (%eax),%eax
  800aed:	8d 50 08             	lea    0x8(%eax),%edx
  800af0:	8b 45 08             	mov    0x8(%ebp),%eax
  800af3:	89 10                	mov    %edx,(%eax)
  800af5:	8b 45 08             	mov    0x8(%ebp),%eax
  800af8:	8b 00                	mov    (%eax),%eax
  800afa:	83 e8 08             	sub    $0x8,%eax
  800afd:	8b 50 04             	mov    0x4(%eax),%edx
  800b00:	8b 00                	mov    (%eax),%eax
  800b02:	eb 38                	jmp    800b3c <getint+0x5d>
	else if (lflag)
  800b04:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b08:	74 1a                	je     800b24 <getint+0x45>
		return va_arg(*ap, long);
  800b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0d:	8b 00                	mov    (%eax),%eax
  800b0f:	8d 50 04             	lea    0x4(%eax),%edx
  800b12:	8b 45 08             	mov    0x8(%ebp),%eax
  800b15:	89 10                	mov    %edx,(%eax)
  800b17:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1a:	8b 00                	mov    (%eax),%eax
  800b1c:	83 e8 04             	sub    $0x4,%eax
  800b1f:	8b 00                	mov    (%eax),%eax
  800b21:	99                   	cltd   
  800b22:	eb 18                	jmp    800b3c <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b24:	8b 45 08             	mov    0x8(%ebp),%eax
  800b27:	8b 00                	mov    (%eax),%eax
  800b29:	8d 50 04             	lea    0x4(%eax),%edx
  800b2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2f:	89 10                	mov    %edx,(%eax)
  800b31:	8b 45 08             	mov    0x8(%ebp),%eax
  800b34:	8b 00                	mov    (%eax),%eax
  800b36:	83 e8 04             	sub    $0x4,%eax
  800b39:	8b 00                	mov    (%eax),%eax
  800b3b:	99                   	cltd   
}
  800b3c:	5d                   	pop    %ebp
  800b3d:	c3                   	ret    

00800b3e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b3e:	55                   	push   %ebp
  800b3f:	89 e5                	mov    %esp,%ebp
  800b41:	56                   	push   %esi
  800b42:	53                   	push   %ebx
  800b43:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b46:	eb 17                	jmp    800b5f <vprintfmt+0x21>
			if (ch == '\0')
  800b48:	85 db                	test   %ebx,%ebx
  800b4a:	0f 84 af 03 00 00    	je     800eff <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b50:	83 ec 08             	sub    $0x8,%esp
  800b53:	ff 75 0c             	pushl  0xc(%ebp)
  800b56:	53                   	push   %ebx
  800b57:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5a:	ff d0                	call   *%eax
  800b5c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b5f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b62:	8d 50 01             	lea    0x1(%eax),%edx
  800b65:	89 55 10             	mov    %edx,0x10(%ebp)
  800b68:	8a 00                	mov    (%eax),%al
  800b6a:	0f b6 d8             	movzbl %al,%ebx
  800b6d:	83 fb 25             	cmp    $0x25,%ebx
  800b70:	75 d6                	jne    800b48 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b72:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b76:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800b7d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800b84:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800b8b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800b92:	8b 45 10             	mov    0x10(%ebp),%eax
  800b95:	8d 50 01             	lea    0x1(%eax),%edx
  800b98:	89 55 10             	mov    %edx,0x10(%ebp)
  800b9b:	8a 00                	mov    (%eax),%al
  800b9d:	0f b6 d8             	movzbl %al,%ebx
  800ba0:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800ba3:	83 f8 55             	cmp    $0x55,%eax
  800ba6:	0f 87 2b 03 00 00    	ja     800ed7 <vprintfmt+0x399>
  800bac:	8b 04 85 58 26 80 00 	mov    0x802658(,%eax,4),%eax
  800bb3:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bb5:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800bb9:	eb d7                	jmp    800b92 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800bbb:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800bbf:	eb d1                	jmp    800b92 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bc1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800bc8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800bcb:	89 d0                	mov    %edx,%eax
  800bcd:	c1 e0 02             	shl    $0x2,%eax
  800bd0:	01 d0                	add    %edx,%eax
  800bd2:	01 c0                	add    %eax,%eax
  800bd4:	01 d8                	add    %ebx,%eax
  800bd6:	83 e8 30             	sub    $0x30,%eax
  800bd9:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800bdc:	8b 45 10             	mov    0x10(%ebp),%eax
  800bdf:	8a 00                	mov    (%eax),%al
  800be1:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800be4:	83 fb 2f             	cmp    $0x2f,%ebx
  800be7:	7e 3e                	jle    800c27 <vprintfmt+0xe9>
  800be9:	83 fb 39             	cmp    $0x39,%ebx
  800bec:	7f 39                	jg     800c27 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bee:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800bf1:	eb d5                	jmp    800bc8 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800bf3:	8b 45 14             	mov    0x14(%ebp),%eax
  800bf6:	83 c0 04             	add    $0x4,%eax
  800bf9:	89 45 14             	mov    %eax,0x14(%ebp)
  800bfc:	8b 45 14             	mov    0x14(%ebp),%eax
  800bff:	83 e8 04             	sub    $0x4,%eax
  800c02:	8b 00                	mov    (%eax),%eax
  800c04:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c07:	eb 1f                	jmp    800c28 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c09:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c0d:	79 83                	jns    800b92 <vprintfmt+0x54>
				width = 0;
  800c0f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c16:	e9 77 ff ff ff       	jmp    800b92 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c1b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c22:	e9 6b ff ff ff       	jmp    800b92 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c27:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c28:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c2c:	0f 89 60 ff ff ff    	jns    800b92 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c32:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c35:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c38:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c3f:	e9 4e ff ff ff       	jmp    800b92 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c44:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c47:	e9 46 ff ff ff       	jmp    800b92 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c4c:	8b 45 14             	mov    0x14(%ebp),%eax
  800c4f:	83 c0 04             	add    $0x4,%eax
  800c52:	89 45 14             	mov    %eax,0x14(%ebp)
  800c55:	8b 45 14             	mov    0x14(%ebp),%eax
  800c58:	83 e8 04             	sub    $0x4,%eax
  800c5b:	8b 00                	mov    (%eax),%eax
  800c5d:	83 ec 08             	sub    $0x8,%esp
  800c60:	ff 75 0c             	pushl  0xc(%ebp)
  800c63:	50                   	push   %eax
  800c64:	8b 45 08             	mov    0x8(%ebp),%eax
  800c67:	ff d0                	call   *%eax
  800c69:	83 c4 10             	add    $0x10,%esp
			break;
  800c6c:	e9 89 02 00 00       	jmp    800efa <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c71:	8b 45 14             	mov    0x14(%ebp),%eax
  800c74:	83 c0 04             	add    $0x4,%eax
  800c77:	89 45 14             	mov    %eax,0x14(%ebp)
  800c7a:	8b 45 14             	mov    0x14(%ebp),%eax
  800c7d:	83 e8 04             	sub    $0x4,%eax
  800c80:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800c82:	85 db                	test   %ebx,%ebx
  800c84:	79 02                	jns    800c88 <vprintfmt+0x14a>
				err = -err;
  800c86:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800c88:	83 fb 64             	cmp    $0x64,%ebx
  800c8b:	7f 0b                	jg     800c98 <vprintfmt+0x15a>
  800c8d:	8b 34 9d a0 24 80 00 	mov    0x8024a0(,%ebx,4),%esi
  800c94:	85 f6                	test   %esi,%esi
  800c96:	75 19                	jne    800cb1 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800c98:	53                   	push   %ebx
  800c99:	68 45 26 80 00       	push   $0x802645
  800c9e:	ff 75 0c             	pushl  0xc(%ebp)
  800ca1:	ff 75 08             	pushl  0x8(%ebp)
  800ca4:	e8 5e 02 00 00       	call   800f07 <printfmt>
  800ca9:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cac:	e9 49 02 00 00       	jmp    800efa <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cb1:	56                   	push   %esi
  800cb2:	68 4e 26 80 00       	push   $0x80264e
  800cb7:	ff 75 0c             	pushl  0xc(%ebp)
  800cba:	ff 75 08             	pushl  0x8(%ebp)
  800cbd:	e8 45 02 00 00       	call   800f07 <printfmt>
  800cc2:	83 c4 10             	add    $0x10,%esp
			break;
  800cc5:	e9 30 02 00 00       	jmp    800efa <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800cca:	8b 45 14             	mov    0x14(%ebp),%eax
  800ccd:	83 c0 04             	add    $0x4,%eax
  800cd0:	89 45 14             	mov    %eax,0x14(%ebp)
  800cd3:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd6:	83 e8 04             	sub    $0x4,%eax
  800cd9:	8b 30                	mov    (%eax),%esi
  800cdb:	85 f6                	test   %esi,%esi
  800cdd:	75 05                	jne    800ce4 <vprintfmt+0x1a6>
				p = "(null)";
  800cdf:	be 51 26 80 00       	mov    $0x802651,%esi
			if (width > 0 && padc != '-')
  800ce4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ce8:	7e 6d                	jle    800d57 <vprintfmt+0x219>
  800cea:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800cee:	74 67                	je     800d57 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800cf0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cf3:	83 ec 08             	sub    $0x8,%esp
  800cf6:	50                   	push   %eax
  800cf7:	56                   	push   %esi
  800cf8:	e8 0c 03 00 00       	call   801009 <strnlen>
  800cfd:	83 c4 10             	add    $0x10,%esp
  800d00:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d03:	eb 16                	jmp    800d1b <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d05:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d09:	83 ec 08             	sub    $0x8,%esp
  800d0c:	ff 75 0c             	pushl  0xc(%ebp)
  800d0f:	50                   	push   %eax
  800d10:	8b 45 08             	mov    0x8(%ebp),%eax
  800d13:	ff d0                	call   *%eax
  800d15:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d18:	ff 4d e4             	decl   -0x1c(%ebp)
  800d1b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d1f:	7f e4                	jg     800d05 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d21:	eb 34                	jmp    800d57 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d23:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d27:	74 1c                	je     800d45 <vprintfmt+0x207>
  800d29:	83 fb 1f             	cmp    $0x1f,%ebx
  800d2c:	7e 05                	jle    800d33 <vprintfmt+0x1f5>
  800d2e:	83 fb 7e             	cmp    $0x7e,%ebx
  800d31:	7e 12                	jle    800d45 <vprintfmt+0x207>
					putch('?', putdat);
  800d33:	83 ec 08             	sub    $0x8,%esp
  800d36:	ff 75 0c             	pushl  0xc(%ebp)
  800d39:	6a 3f                	push   $0x3f
  800d3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3e:	ff d0                	call   *%eax
  800d40:	83 c4 10             	add    $0x10,%esp
  800d43:	eb 0f                	jmp    800d54 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d45:	83 ec 08             	sub    $0x8,%esp
  800d48:	ff 75 0c             	pushl  0xc(%ebp)
  800d4b:	53                   	push   %ebx
  800d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4f:	ff d0                	call   *%eax
  800d51:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d54:	ff 4d e4             	decl   -0x1c(%ebp)
  800d57:	89 f0                	mov    %esi,%eax
  800d59:	8d 70 01             	lea    0x1(%eax),%esi
  800d5c:	8a 00                	mov    (%eax),%al
  800d5e:	0f be d8             	movsbl %al,%ebx
  800d61:	85 db                	test   %ebx,%ebx
  800d63:	74 24                	je     800d89 <vprintfmt+0x24b>
  800d65:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d69:	78 b8                	js     800d23 <vprintfmt+0x1e5>
  800d6b:	ff 4d e0             	decl   -0x20(%ebp)
  800d6e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d72:	79 af                	jns    800d23 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d74:	eb 13                	jmp    800d89 <vprintfmt+0x24b>
				putch(' ', putdat);
  800d76:	83 ec 08             	sub    $0x8,%esp
  800d79:	ff 75 0c             	pushl  0xc(%ebp)
  800d7c:	6a 20                	push   $0x20
  800d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d81:	ff d0                	call   *%eax
  800d83:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d86:	ff 4d e4             	decl   -0x1c(%ebp)
  800d89:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d8d:	7f e7                	jg     800d76 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800d8f:	e9 66 01 00 00       	jmp    800efa <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800d94:	83 ec 08             	sub    $0x8,%esp
  800d97:	ff 75 e8             	pushl  -0x18(%ebp)
  800d9a:	8d 45 14             	lea    0x14(%ebp),%eax
  800d9d:	50                   	push   %eax
  800d9e:	e8 3c fd ff ff       	call   800adf <getint>
  800da3:	83 c4 10             	add    $0x10,%esp
  800da6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800da9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800dac:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800daf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800db2:	85 d2                	test   %edx,%edx
  800db4:	79 23                	jns    800dd9 <vprintfmt+0x29b>
				putch('-', putdat);
  800db6:	83 ec 08             	sub    $0x8,%esp
  800db9:	ff 75 0c             	pushl  0xc(%ebp)
  800dbc:	6a 2d                	push   $0x2d
  800dbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc1:	ff d0                	call   *%eax
  800dc3:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800dc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dc9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dcc:	f7 d8                	neg    %eax
  800dce:	83 d2 00             	adc    $0x0,%edx
  800dd1:	f7 da                	neg    %edx
  800dd3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dd6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800dd9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800de0:	e9 bc 00 00 00       	jmp    800ea1 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800de5:	83 ec 08             	sub    $0x8,%esp
  800de8:	ff 75 e8             	pushl  -0x18(%ebp)
  800deb:	8d 45 14             	lea    0x14(%ebp),%eax
  800dee:	50                   	push   %eax
  800def:	e8 84 fc ff ff       	call   800a78 <getuint>
  800df4:	83 c4 10             	add    $0x10,%esp
  800df7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dfa:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800dfd:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e04:	e9 98 00 00 00       	jmp    800ea1 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e09:	83 ec 08             	sub    $0x8,%esp
  800e0c:	ff 75 0c             	pushl  0xc(%ebp)
  800e0f:	6a 58                	push   $0x58
  800e11:	8b 45 08             	mov    0x8(%ebp),%eax
  800e14:	ff d0                	call   *%eax
  800e16:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e19:	83 ec 08             	sub    $0x8,%esp
  800e1c:	ff 75 0c             	pushl  0xc(%ebp)
  800e1f:	6a 58                	push   $0x58
  800e21:	8b 45 08             	mov    0x8(%ebp),%eax
  800e24:	ff d0                	call   *%eax
  800e26:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e29:	83 ec 08             	sub    $0x8,%esp
  800e2c:	ff 75 0c             	pushl  0xc(%ebp)
  800e2f:	6a 58                	push   $0x58
  800e31:	8b 45 08             	mov    0x8(%ebp),%eax
  800e34:	ff d0                	call   *%eax
  800e36:	83 c4 10             	add    $0x10,%esp
			break;
  800e39:	e9 bc 00 00 00       	jmp    800efa <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e3e:	83 ec 08             	sub    $0x8,%esp
  800e41:	ff 75 0c             	pushl  0xc(%ebp)
  800e44:	6a 30                	push   $0x30
  800e46:	8b 45 08             	mov    0x8(%ebp),%eax
  800e49:	ff d0                	call   *%eax
  800e4b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e4e:	83 ec 08             	sub    $0x8,%esp
  800e51:	ff 75 0c             	pushl  0xc(%ebp)
  800e54:	6a 78                	push   $0x78
  800e56:	8b 45 08             	mov    0x8(%ebp),%eax
  800e59:	ff d0                	call   *%eax
  800e5b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e5e:	8b 45 14             	mov    0x14(%ebp),%eax
  800e61:	83 c0 04             	add    $0x4,%eax
  800e64:	89 45 14             	mov    %eax,0x14(%ebp)
  800e67:	8b 45 14             	mov    0x14(%ebp),%eax
  800e6a:	83 e8 04             	sub    $0x4,%eax
  800e6d:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e6f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e72:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800e79:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800e80:	eb 1f                	jmp    800ea1 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800e82:	83 ec 08             	sub    $0x8,%esp
  800e85:	ff 75 e8             	pushl  -0x18(%ebp)
  800e88:	8d 45 14             	lea    0x14(%ebp),%eax
  800e8b:	50                   	push   %eax
  800e8c:	e8 e7 fb ff ff       	call   800a78 <getuint>
  800e91:	83 c4 10             	add    $0x10,%esp
  800e94:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e97:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800e9a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ea1:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ea5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ea8:	83 ec 04             	sub    $0x4,%esp
  800eab:	52                   	push   %edx
  800eac:	ff 75 e4             	pushl  -0x1c(%ebp)
  800eaf:	50                   	push   %eax
  800eb0:	ff 75 f4             	pushl  -0xc(%ebp)
  800eb3:	ff 75 f0             	pushl  -0x10(%ebp)
  800eb6:	ff 75 0c             	pushl  0xc(%ebp)
  800eb9:	ff 75 08             	pushl  0x8(%ebp)
  800ebc:	e8 00 fb ff ff       	call   8009c1 <printnum>
  800ec1:	83 c4 20             	add    $0x20,%esp
			break;
  800ec4:	eb 34                	jmp    800efa <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ec6:	83 ec 08             	sub    $0x8,%esp
  800ec9:	ff 75 0c             	pushl  0xc(%ebp)
  800ecc:	53                   	push   %ebx
  800ecd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed0:	ff d0                	call   *%eax
  800ed2:	83 c4 10             	add    $0x10,%esp
			break;
  800ed5:	eb 23                	jmp    800efa <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ed7:	83 ec 08             	sub    $0x8,%esp
  800eda:	ff 75 0c             	pushl  0xc(%ebp)
  800edd:	6a 25                	push   $0x25
  800edf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee2:	ff d0                	call   *%eax
  800ee4:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ee7:	ff 4d 10             	decl   0x10(%ebp)
  800eea:	eb 03                	jmp    800eef <vprintfmt+0x3b1>
  800eec:	ff 4d 10             	decl   0x10(%ebp)
  800eef:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef2:	48                   	dec    %eax
  800ef3:	8a 00                	mov    (%eax),%al
  800ef5:	3c 25                	cmp    $0x25,%al
  800ef7:	75 f3                	jne    800eec <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800ef9:	90                   	nop
		}
	}
  800efa:	e9 47 fc ff ff       	jmp    800b46 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800eff:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f00:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f03:	5b                   	pop    %ebx
  800f04:	5e                   	pop    %esi
  800f05:	5d                   	pop    %ebp
  800f06:	c3                   	ret    

00800f07 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f07:	55                   	push   %ebp
  800f08:	89 e5                	mov    %esp,%ebp
  800f0a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f0d:	8d 45 10             	lea    0x10(%ebp),%eax
  800f10:	83 c0 04             	add    $0x4,%eax
  800f13:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f16:	8b 45 10             	mov    0x10(%ebp),%eax
  800f19:	ff 75 f4             	pushl  -0xc(%ebp)
  800f1c:	50                   	push   %eax
  800f1d:	ff 75 0c             	pushl  0xc(%ebp)
  800f20:	ff 75 08             	pushl  0x8(%ebp)
  800f23:	e8 16 fc ff ff       	call   800b3e <vprintfmt>
  800f28:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f2b:	90                   	nop
  800f2c:	c9                   	leave  
  800f2d:	c3                   	ret    

00800f2e <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f2e:	55                   	push   %ebp
  800f2f:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f34:	8b 40 08             	mov    0x8(%eax),%eax
  800f37:	8d 50 01             	lea    0x1(%eax),%edx
  800f3a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f3d:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f43:	8b 10                	mov    (%eax),%edx
  800f45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f48:	8b 40 04             	mov    0x4(%eax),%eax
  800f4b:	39 c2                	cmp    %eax,%edx
  800f4d:	73 12                	jae    800f61 <sprintputch+0x33>
		*b->buf++ = ch;
  800f4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f52:	8b 00                	mov    (%eax),%eax
  800f54:	8d 48 01             	lea    0x1(%eax),%ecx
  800f57:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f5a:	89 0a                	mov    %ecx,(%edx)
  800f5c:	8b 55 08             	mov    0x8(%ebp),%edx
  800f5f:	88 10                	mov    %dl,(%eax)
}
  800f61:	90                   	nop
  800f62:	5d                   	pop    %ebp
  800f63:	c3                   	ret    

00800f64 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f64:	55                   	push   %ebp
  800f65:	89 e5                	mov    %esp,%ebp
  800f67:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f70:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f73:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f76:	8b 45 08             	mov    0x8(%ebp),%eax
  800f79:	01 d0                	add    %edx,%eax
  800f7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f7e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800f85:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f89:	74 06                	je     800f91 <vsnprintf+0x2d>
  800f8b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f8f:	7f 07                	jg     800f98 <vsnprintf+0x34>
		return -E_INVAL;
  800f91:	b8 03 00 00 00       	mov    $0x3,%eax
  800f96:	eb 20                	jmp    800fb8 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800f98:	ff 75 14             	pushl  0x14(%ebp)
  800f9b:	ff 75 10             	pushl  0x10(%ebp)
  800f9e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fa1:	50                   	push   %eax
  800fa2:	68 2e 0f 80 00       	push   $0x800f2e
  800fa7:	e8 92 fb ff ff       	call   800b3e <vprintfmt>
  800fac:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800faf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fb2:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fb5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800fb8:	c9                   	leave  
  800fb9:	c3                   	ret    

00800fba <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fba:	55                   	push   %ebp
  800fbb:	89 e5                	mov    %esp,%ebp
  800fbd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fc0:	8d 45 10             	lea    0x10(%ebp),%eax
  800fc3:	83 c0 04             	add    $0x4,%eax
  800fc6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800fc9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fcc:	ff 75 f4             	pushl  -0xc(%ebp)
  800fcf:	50                   	push   %eax
  800fd0:	ff 75 0c             	pushl  0xc(%ebp)
  800fd3:	ff 75 08             	pushl  0x8(%ebp)
  800fd6:	e8 89 ff ff ff       	call   800f64 <vsnprintf>
  800fdb:	83 c4 10             	add    $0x10,%esp
  800fde:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800fe1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800fe4:	c9                   	leave  
  800fe5:	c3                   	ret    

00800fe6 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800fe6:	55                   	push   %ebp
  800fe7:	89 e5                	mov    %esp,%ebp
  800fe9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800fec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ff3:	eb 06                	jmp    800ffb <strlen+0x15>
		n++;
  800ff5:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800ff8:	ff 45 08             	incl   0x8(%ebp)
  800ffb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffe:	8a 00                	mov    (%eax),%al
  801000:	84 c0                	test   %al,%al
  801002:	75 f1                	jne    800ff5 <strlen+0xf>
		n++;
	return n;
  801004:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801007:	c9                   	leave  
  801008:	c3                   	ret    

00801009 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801009:	55                   	push   %ebp
  80100a:	89 e5                	mov    %esp,%ebp
  80100c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80100f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801016:	eb 09                	jmp    801021 <strnlen+0x18>
		n++;
  801018:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80101b:	ff 45 08             	incl   0x8(%ebp)
  80101e:	ff 4d 0c             	decl   0xc(%ebp)
  801021:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801025:	74 09                	je     801030 <strnlen+0x27>
  801027:	8b 45 08             	mov    0x8(%ebp),%eax
  80102a:	8a 00                	mov    (%eax),%al
  80102c:	84 c0                	test   %al,%al
  80102e:	75 e8                	jne    801018 <strnlen+0xf>
		n++;
	return n;
  801030:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801033:	c9                   	leave  
  801034:	c3                   	ret    

00801035 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801035:	55                   	push   %ebp
  801036:	89 e5                	mov    %esp,%ebp
  801038:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80103b:	8b 45 08             	mov    0x8(%ebp),%eax
  80103e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801041:	90                   	nop
  801042:	8b 45 08             	mov    0x8(%ebp),%eax
  801045:	8d 50 01             	lea    0x1(%eax),%edx
  801048:	89 55 08             	mov    %edx,0x8(%ebp)
  80104b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80104e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801051:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801054:	8a 12                	mov    (%edx),%dl
  801056:	88 10                	mov    %dl,(%eax)
  801058:	8a 00                	mov    (%eax),%al
  80105a:	84 c0                	test   %al,%al
  80105c:	75 e4                	jne    801042 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80105e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801061:	c9                   	leave  
  801062:	c3                   	ret    

00801063 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801063:	55                   	push   %ebp
  801064:	89 e5                	mov    %esp,%ebp
  801066:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801069:	8b 45 08             	mov    0x8(%ebp),%eax
  80106c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80106f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801076:	eb 1f                	jmp    801097 <strncpy+0x34>
		*dst++ = *src;
  801078:	8b 45 08             	mov    0x8(%ebp),%eax
  80107b:	8d 50 01             	lea    0x1(%eax),%edx
  80107e:	89 55 08             	mov    %edx,0x8(%ebp)
  801081:	8b 55 0c             	mov    0xc(%ebp),%edx
  801084:	8a 12                	mov    (%edx),%dl
  801086:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801088:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108b:	8a 00                	mov    (%eax),%al
  80108d:	84 c0                	test   %al,%al
  80108f:	74 03                	je     801094 <strncpy+0x31>
			src++;
  801091:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801094:	ff 45 fc             	incl   -0x4(%ebp)
  801097:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80109a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80109d:	72 d9                	jb     801078 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80109f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010a2:	c9                   	leave  
  8010a3:	c3                   	ret    

008010a4 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010a4:	55                   	push   %ebp
  8010a5:	89 e5                	mov    %esp,%ebp
  8010a7:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ad:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010b0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010b4:	74 30                	je     8010e6 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8010b6:	eb 16                	jmp    8010ce <strlcpy+0x2a>
			*dst++ = *src++;
  8010b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bb:	8d 50 01             	lea    0x1(%eax),%edx
  8010be:	89 55 08             	mov    %edx,0x8(%ebp)
  8010c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010c4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010c7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010ca:	8a 12                	mov    (%edx),%dl
  8010cc:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8010ce:	ff 4d 10             	decl   0x10(%ebp)
  8010d1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010d5:	74 09                	je     8010e0 <strlcpy+0x3c>
  8010d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010da:	8a 00                	mov    (%eax),%al
  8010dc:	84 c0                	test   %al,%al
  8010de:	75 d8                	jne    8010b8 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8010e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e3:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8010e6:	8b 55 08             	mov    0x8(%ebp),%edx
  8010e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ec:	29 c2                	sub    %eax,%edx
  8010ee:	89 d0                	mov    %edx,%eax
}
  8010f0:	c9                   	leave  
  8010f1:	c3                   	ret    

008010f2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8010f2:	55                   	push   %ebp
  8010f3:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8010f5:	eb 06                	jmp    8010fd <strcmp+0xb>
		p++, q++;
  8010f7:	ff 45 08             	incl   0x8(%ebp)
  8010fa:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8010fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801100:	8a 00                	mov    (%eax),%al
  801102:	84 c0                	test   %al,%al
  801104:	74 0e                	je     801114 <strcmp+0x22>
  801106:	8b 45 08             	mov    0x8(%ebp),%eax
  801109:	8a 10                	mov    (%eax),%dl
  80110b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80110e:	8a 00                	mov    (%eax),%al
  801110:	38 c2                	cmp    %al,%dl
  801112:	74 e3                	je     8010f7 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801114:	8b 45 08             	mov    0x8(%ebp),%eax
  801117:	8a 00                	mov    (%eax),%al
  801119:	0f b6 d0             	movzbl %al,%edx
  80111c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111f:	8a 00                	mov    (%eax),%al
  801121:	0f b6 c0             	movzbl %al,%eax
  801124:	29 c2                	sub    %eax,%edx
  801126:	89 d0                	mov    %edx,%eax
}
  801128:	5d                   	pop    %ebp
  801129:	c3                   	ret    

0080112a <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80112a:	55                   	push   %ebp
  80112b:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80112d:	eb 09                	jmp    801138 <strncmp+0xe>
		n--, p++, q++;
  80112f:	ff 4d 10             	decl   0x10(%ebp)
  801132:	ff 45 08             	incl   0x8(%ebp)
  801135:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801138:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80113c:	74 17                	je     801155 <strncmp+0x2b>
  80113e:	8b 45 08             	mov    0x8(%ebp),%eax
  801141:	8a 00                	mov    (%eax),%al
  801143:	84 c0                	test   %al,%al
  801145:	74 0e                	je     801155 <strncmp+0x2b>
  801147:	8b 45 08             	mov    0x8(%ebp),%eax
  80114a:	8a 10                	mov    (%eax),%dl
  80114c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114f:	8a 00                	mov    (%eax),%al
  801151:	38 c2                	cmp    %al,%dl
  801153:	74 da                	je     80112f <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801155:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801159:	75 07                	jne    801162 <strncmp+0x38>
		return 0;
  80115b:	b8 00 00 00 00       	mov    $0x0,%eax
  801160:	eb 14                	jmp    801176 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801162:	8b 45 08             	mov    0x8(%ebp),%eax
  801165:	8a 00                	mov    (%eax),%al
  801167:	0f b6 d0             	movzbl %al,%edx
  80116a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116d:	8a 00                	mov    (%eax),%al
  80116f:	0f b6 c0             	movzbl %al,%eax
  801172:	29 c2                	sub    %eax,%edx
  801174:	89 d0                	mov    %edx,%eax
}
  801176:	5d                   	pop    %ebp
  801177:	c3                   	ret    

00801178 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801178:	55                   	push   %ebp
  801179:	89 e5                	mov    %esp,%ebp
  80117b:	83 ec 04             	sub    $0x4,%esp
  80117e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801181:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801184:	eb 12                	jmp    801198 <strchr+0x20>
		if (*s == c)
  801186:	8b 45 08             	mov    0x8(%ebp),%eax
  801189:	8a 00                	mov    (%eax),%al
  80118b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80118e:	75 05                	jne    801195 <strchr+0x1d>
			return (char *) s;
  801190:	8b 45 08             	mov    0x8(%ebp),%eax
  801193:	eb 11                	jmp    8011a6 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801195:	ff 45 08             	incl   0x8(%ebp)
  801198:	8b 45 08             	mov    0x8(%ebp),%eax
  80119b:	8a 00                	mov    (%eax),%al
  80119d:	84 c0                	test   %al,%al
  80119f:	75 e5                	jne    801186 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011a1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011a6:	c9                   	leave  
  8011a7:	c3                   	ret    

008011a8 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011a8:	55                   	push   %ebp
  8011a9:	89 e5                	mov    %esp,%ebp
  8011ab:	83 ec 04             	sub    $0x4,%esp
  8011ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b1:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011b4:	eb 0d                	jmp    8011c3 <strfind+0x1b>
		if (*s == c)
  8011b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b9:	8a 00                	mov    (%eax),%al
  8011bb:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011be:	74 0e                	je     8011ce <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011c0:	ff 45 08             	incl   0x8(%ebp)
  8011c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c6:	8a 00                	mov    (%eax),%al
  8011c8:	84 c0                	test   %al,%al
  8011ca:	75 ea                	jne    8011b6 <strfind+0xe>
  8011cc:	eb 01                	jmp    8011cf <strfind+0x27>
		if (*s == c)
			break;
  8011ce:	90                   	nop
	return (char *) s;
  8011cf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011d2:	c9                   	leave  
  8011d3:	c3                   	ret    

008011d4 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8011d4:	55                   	push   %ebp
  8011d5:	89 e5                	mov    %esp,%ebp
  8011d7:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8011da:	8b 45 08             	mov    0x8(%ebp),%eax
  8011dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8011e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8011e6:	eb 0e                	jmp    8011f6 <memset+0x22>
		*p++ = c;
  8011e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011eb:	8d 50 01             	lea    0x1(%eax),%edx
  8011ee:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011f4:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8011f6:	ff 4d f8             	decl   -0x8(%ebp)
  8011f9:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8011fd:	79 e9                	jns    8011e8 <memset+0x14>
		*p++ = c;

	return v;
  8011ff:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801202:	c9                   	leave  
  801203:	c3                   	ret    

00801204 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801204:	55                   	push   %ebp
  801205:	89 e5                	mov    %esp,%ebp
  801207:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80120a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80120d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801210:	8b 45 08             	mov    0x8(%ebp),%eax
  801213:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801216:	eb 16                	jmp    80122e <memcpy+0x2a>
		*d++ = *s++;
  801218:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80121b:	8d 50 01             	lea    0x1(%eax),%edx
  80121e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801221:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801224:	8d 4a 01             	lea    0x1(%edx),%ecx
  801227:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80122a:	8a 12                	mov    (%edx),%dl
  80122c:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80122e:	8b 45 10             	mov    0x10(%ebp),%eax
  801231:	8d 50 ff             	lea    -0x1(%eax),%edx
  801234:	89 55 10             	mov    %edx,0x10(%ebp)
  801237:	85 c0                	test   %eax,%eax
  801239:	75 dd                	jne    801218 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80123b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80123e:	c9                   	leave  
  80123f:	c3                   	ret    

00801240 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801240:	55                   	push   %ebp
  801241:	89 e5                	mov    %esp,%ebp
  801243:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801246:	8b 45 0c             	mov    0xc(%ebp),%eax
  801249:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80124c:	8b 45 08             	mov    0x8(%ebp),%eax
  80124f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801252:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801255:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801258:	73 50                	jae    8012aa <memmove+0x6a>
  80125a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80125d:	8b 45 10             	mov    0x10(%ebp),%eax
  801260:	01 d0                	add    %edx,%eax
  801262:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801265:	76 43                	jbe    8012aa <memmove+0x6a>
		s += n;
  801267:	8b 45 10             	mov    0x10(%ebp),%eax
  80126a:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80126d:	8b 45 10             	mov    0x10(%ebp),%eax
  801270:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801273:	eb 10                	jmp    801285 <memmove+0x45>
			*--d = *--s;
  801275:	ff 4d f8             	decl   -0x8(%ebp)
  801278:	ff 4d fc             	decl   -0x4(%ebp)
  80127b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80127e:	8a 10                	mov    (%eax),%dl
  801280:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801283:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801285:	8b 45 10             	mov    0x10(%ebp),%eax
  801288:	8d 50 ff             	lea    -0x1(%eax),%edx
  80128b:	89 55 10             	mov    %edx,0x10(%ebp)
  80128e:	85 c0                	test   %eax,%eax
  801290:	75 e3                	jne    801275 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801292:	eb 23                	jmp    8012b7 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801294:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801297:	8d 50 01             	lea    0x1(%eax),%edx
  80129a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80129d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012a0:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012a3:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012a6:	8a 12                	mov    (%edx),%dl
  8012a8:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ad:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012b0:	89 55 10             	mov    %edx,0x10(%ebp)
  8012b3:	85 c0                	test   %eax,%eax
  8012b5:	75 dd                	jne    801294 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8012b7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012ba:	c9                   	leave  
  8012bb:	c3                   	ret    

008012bc <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012bc:	55                   	push   %ebp
  8012bd:	89 e5                	mov    %esp,%ebp
  8012bf:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8012c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012cb:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8012ce:	eb 2a                	jmp    8012fa <memcmp+0x3e>
		if (*s1 != *s2)
  8012d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012d3:	8a 10                	mov    (%eax),%dl
  8012d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012d8:	8a 00                	mov    (%eax),%al
  8012da:	38 c2                	cmp    %al,%dl
  8012dc:	74 16                	je     8012f4 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8012de:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012e1:	8a 00                	mov    (%eax),%al
  8012e3:	0f b6 d0             	movzbl %al,%edx
  8012e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012e9:	8a 00                	mov    (%eax),%al
  8012eb:	0f b6 c0             	movzbl %al,%eax
  8012ee:	29 c2                	sub    %eax,%edx
  8012f0:	89 d0                	mov    %edx,%eax
  8012f2:	eb 18                	jmp    80130c <memcmp+0x50>
		s1++, s2++;
  8012f4:	ff 45 fc             	incl   -0x4(%ebp)
  8012f7:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8012fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8012fd:	8d 50 ff             	lea    -0x1(%eax),%edx
  801300:	89 55 10             	mov    %edx,0x10(%ebp)
  801303:	85 c0                	test   %eax,%eax
  801305:	75 c9                	jne    8012d0 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801307:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80130c:	c9                   	leave  
  80130d:	c3                   	ret    

0080130e <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80130e:	55                   	push   %ebp
  80130f:	89 e5                	mov    %esp,%ebp
  801311:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801314:	8b 55 08             	mov    0x8(%ebp),%edx
  801317:	8b 45 10             	mov    0x10(%ebp),%eax
  80131a:	01 d0                	add    %edx,%eax
  80131c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80131f:	eb 15                	jmp    801336 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801321:	8b 45 08             	mov    0x8(%ebp),%eax
  801324:	8a 00                	mov    (%eax),%al
  801326:	0f b6 d0             	movzbl %al,%edx
  801329:	8b 45 0c             	mov    0xc(%ebp),%eax
  80132c:	0f b6 c0             	movzbl %al,%eax
  80132f:	39 c2                	cmp    %eax,%edx
  801331:	74 0d                	je     801340 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801333:	ff 45 08             	incl   0x8(%ebp)
  801336:	8b 45 08             	mov    0x8(%ebp),%eax
  801339:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80133c:	72 e3                	jb     801321 <memfind+0x13>
  80133e:	eb 01                	jmp    801341 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801340:	90                   	nop
	return (void *) s;
  801341:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801344:	c9                   	leave  
  801345:	c3                   	ret    

00801346 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801346:	55                   	push   %ebp
  801347:	89 e5                	mov    %esp,%ebp
  801349:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80134c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801353:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80135a:	eb 03                	jmp    80135f <strtol+0x19>
		s++;
  80135c:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80135f:	8b 45 08             	mov    0x8(%ebp),%eax
  801362:	8a 00                	mov    (%eax),%al
  801364:	3c 20                	cmp    $0x20,%al
  801366:	74 f4                	je     80135c <strtol+0x16>
  801368:	8b 45 08             	mov    0x8(%ebp),%eax
  80136b:	8a 00                	mov    (%eax),%al
  80136d:	3c 09                	cmp    $0x9,%al
  80136f:	74 eb                	je     80135c <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801371:	8b 45 08             	mov    0x8(%ebp),%eax
  801374:	8a 00                	mov    (%eax),%al
  801376:	3c 2b                	cmp    $0x2b,%al
  801378:	75 05                	jne    80137f <strtol+0x39>
		s++;
  80137a:	ff 45 08             	incl   0x8(%ebp)
  80137d:	eb 13                	jmp    801392 <strtol+0x4c>
	else if (*s == '-')
  80137f:	8b 45 08             	mov    0x8(%ebp),%eax
  801382:	8a 00                	mov    (%eax),%al
  801384:	3c 2d                	cmp    $0x2d,%al
  801386:	75 0a                	jne    801392 <strtol+0x4c>
		s++, neg = 1;
  801388:	ff 45 08             	incl   0x8(%ebp)
  80138b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801392:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801396:	74 06                	je     80139e <strtol+0x58>
  801398:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80139c:	75 20                	jne    8013be <strtol+0x78>
  80139e:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a1:	8a 00                	mov    (%eax),%al
  8013a3:	3c 30                	cmp    $0x30,%al
  8013a5:	75 17                	jne    8013be <strtol+0x78>
  8013a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013aa:	40                   	inc    %eax
  8013ab:	8a 00                	mov    (%eax),%al
  8013ad:	3c 78                	cmp    $0x78,%al
  8013af:	75 0d                	jne    8013be <strtol+0x78>
		s += 2, base = 16;
  8013b1:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013b5:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013bc:	eb 28                	jmp    8013e6 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8013be:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013c2:	75 15                	jne    8013d9 <strtol+0x93>
  8013c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c7:	8a 00                	mov    (%eax),%al
  8013c9:	3c 30                	cmp    $0x30,%al
  8013cb:	75 0c                	jne    8013d9 <strtol+0x93>
		s++, base = 8;
  8013cd:	ff 45 08             	incl   0x8(%ebp)
  8013d0:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8013d7:	eb 0d                	jmp    8013e6 <strtol+0xa0>
	else if (base == 0)
  8013d9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013dd:	75 07                	jne    8013e6 <strtol+0xa0>
		base = 10;
  8013df:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8013e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e9:	8a 00                	mov    (%eax),%al
  8013eb:	3c 2f                	cmp    $0x2f,%al
  8013ed:	7e 19                	jle    801408 <strtol+0xc2>
  8013ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f2:	8a 00                	mov    (%eax),%al
  8013f4:	3c 39                	cmp    $0x39,%al
  8013f6:	7f 10                	jg     801408 <strtol+0xc2>
			dig = *s - '0';
  8013f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fb:	8a 00                	mov    (%eax),%al
  8013fd:	0f be c0             	movsbl %al,%eax
  801400:	83 e8 30             	sub    $0x30,%eax
  801403:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801406:	eb 42                	jmp    80144a <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801408:	8b 45 08             	mov    0x8(%ebp),%eax
  80140b:	8a 00                	mov    (%eax),%al
  80140d:	3c 60                	cmp    $0x60,%al
  80140f:	7e 19                	jle    80142a <strtol+0xe4>
  801411:	8b 45 08             	mov    0x8(%ebp),%eax
  801414:	8a 00                	mov    (%eax),%al
  801416:	3c 7a                	cmp    $0x7a,%al
  801418:	7f 10                	jg     80142a <strtol+0xe4>
			dig = *s - 'a' + 10;
  80141a:	8b 45 08             	mov    0x8(%ebp),%eax
  80141d:	8a 00                	mov    (%eax),%al
  80141f:	0f be c0             	movsbl %al,%eax
  801422:	83 e8 57             	sub    $0x57,%eax
  801425:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801428:	eb 20                	jmp    80144a <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80142a:	8b 45 08             	mov    0x8(%ebp),%eax
  80142d:	8a 00                	mov    (%eax),%al
  80142f:	3c 40                	cmp    $0x40,%al
  801431:	7e 39                	jle    80146c <strtol+0x126>
  801433:	8b 45 08             	mov    0x8(%ebp),%eax
  801436:	8a 00                	mov    (%eax),%al
  801438:	3c 5a                	cmp    $0x5a,%al
  80143a:	7f 30                	jg     80146c <strtol+0x126>
			dig = *s - 'A' + 10;
  80143c:	8b 45 08             	mov    0x8(%ebp),%eax
  80143f:	8a 00                	mov    (%eax),%al
  801441:	0f be c0             	movsbl %al,%eax
  801444:	83 e8 37             	sub    $0x37,%eax
  801447:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80144a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80144d:	3b 45 10             	cmp    0x10(%ebp),%eax
  801450:	7d 19                	jge    80146b <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801452:	ff 45 08             	incl   0x8(%ebp)
  801455:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801458:	0f af 45 10          	imul   0x10(%ebp),%eax
  80145c:	89 c2                	mov    %eax,%edx
  80145e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801461:	01 d0                	add    %edx,%eax
  801463:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801466:	e9 7b ff ff ff       	jmp    8013e6 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80146b:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80146c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801470:	74 08                	je     80147a <strtol+0x134>
		*endptr = (char *) s;
  801472:	8b 45 0c             	mov    0xc(%ebp),%eax
  801475:	8b 55 08             	mov    0x8(%ebp),%edx
  801478:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80147a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80147e:	74 07                	je     801487 <strtol+0x141>
  801480:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801483:	f7 d8                	neg    %eax
  801485:	eb 03                	jmp    80148a <strtol+0x144>
  801487:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80148a:	c9                   	leave  
  80148b:	c3                   	ret    

0080148c <ltostr>:

void
ltostr(long value, char *str)
{
  80148c:	55                   	push   %ebp
  80148d:	89 e5                	mov    %esp,%ebp
  80148f:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801492:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801499:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014a0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014a4:	79 13                	jns    8014b9 <ltostr+0x2d>
	{
		neg = 1;
  8014a6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b0:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014b3:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8014b6:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bc:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014c1:	99                   	cltd   
  8014c2:	f7 f9                	idiv   %ecx
  8014c4:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8014c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014ca:	8d 50 01             	lea    0x1(%eax),%edx
  8014cd:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014d0:	89 c2                	mov    %eax,%edx
  8014d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d5:	01 d0                	add    %edx,%eax
  8014d7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014da:	83 c2 30             	add    $0x30,%edx
  8014dd:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8014df:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014e2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014e7:	f7 e9                	imul   %ecx
  8014e9:	c1 fa 02             	sar    $0x2,%edx
  8014ec:	89 c8                	mov    %ecx,%eax
  8014ee:	c1 f8 1f             	sar    $0x1f,%eax
  8014f1:	29 c2                	sub    %eax,%edx
  8014f3:	89 d0                	mov    %edx,%eax
  8014f5:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8014f8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014fb:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801500:	f7 e9                	imul   %ecx
  801502:	c1 fa 02             	sar    $0x2,%edx
  801505:	89 c8                	mov    %ecx,%eax
  801507:	c1 f8 1f             	sar    $0x1f,%eax
  80150a:	29 c2                	sub    %eax,%edx
  80150c:	89 d0                	mov    %edx,%eax
  80150e:	c1 e0 02             	shl    $0x2,%eax
  801511:	01 d0                	add    %edx,%eax
  801513:	01 c0                	add    %eax,%eax
  801515:	29 c1                	sub    %eax,%ecx
  801517:	89 ca                	mov    %ecx,%edx
  801519:	85 d2                	test   %edx,%edx
  80151b:	75 9c                	jne    8014b9 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80151d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801524:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801527:	48                   	dec    %eax
  801528:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80152b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80152f:	74 3d                	je     80156e <ltostr+0xe2>
		start = 1 ;
  801531:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801538:	eb 34                	jmp    80156e <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80153a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80153d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801540:	01 d0                	add    %edx,%eax
  801542:	8a 00                	mov    (%eax),%al
  801544:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801547:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80154a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80154d:	01 c2                	add    %eax,%edx
  80154f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801552:	8b 45 0c             	mov    0xc(%ebp),%eax
  801555:	01 c8                	add    %ecx,%eax
  801557:	8a 00                	mov    (%eax),%al
  801559:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80155b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80155e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801561:	01 c2                	add    %eax,%edx
  801563:	8a 45 eb             	mov    -0x15(%ebp),%al
  801566:	88 02                	mov    %al,(%edx)
		start++ ;
  801568:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80156b:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80156e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801571:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801574:	7c c4                	jl     80153a <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801576:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801579:	8b 45 0c             	mov    0xc(%ebp),%eax
  80157c:	01 d0                	add    %edx,%eax
  80157e:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801581:	90                   	nop
  801582:	c9                   	leave  
  801583:	c3                   	ret    

00801584 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801584:	55                   	push   %ebp
  801585:	89 e5                	mov    %esp,%ebp
  801587:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80158a:	ff 75 08             	pushl  0x8(%ebp)
  80158d:	e8 54 fa ff ff       	call   800fe6 <strlen>
  801592:	83 c4 04             	add    $0x4,%esp
  801595:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801598:	ff 75 0c             	pushl  0xc(%ebp)
  80159b:	e8 46 fa ff ff       	call   800fe6 <strlen>
  8015a0:	83 c4 04             	add    $0x4,%esp
  8015a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015a6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015b4:	eb 17                	jmp    8015cd <strcconcat+0x49>
		final[s] = str1[s] ;
  8015b6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8015bc:	01 c2                	add    %eax,%edx
  8015be:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c4:	01 c8                	add    %ecx,%eax
  8015c6:	8a 00                	mov    (%eax),%al
  8015c8:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8015ca:	ff 45 fc             	incl   -0x4(%ebp)
  8015cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015d0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015d3:	7c e1                	jl     8015b6 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8015d5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8015dc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8015e3:	eb 1f                	jmp    801604 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8015e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015e8:	8d 50 01             	lea    0x1(%eax),%edx
  8015eb:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8015ee:	89 c2                	mov    %eax,%edx
  8015f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8015f3:	01 c2                	add    %eax,%edx
  8015f5:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8015f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015fb:	01 c8                	add    %ecx,%eax
  8015fd:	8a 00                	mov    (%eax),%al
  8015ff:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801601:	ff 45 f8             	incl   -0x8(%ebp)
  801604:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801607:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80160a:	7c d9                	jl     8015e5 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80160c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80160f:	8b 45 10             	mov    0x10(%ebp),%eax
  801612:	01 d0                	add    %edx,%eax
  801614:	c6 00 00             	movb   $0x0,(%eax)
}
  801617:	90                   	nop
  801618:	c9                   	leave  
  801619:	c3                   	ret    

0080161a <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80161a:	55                   	push   %ebp
  80161b:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80161d:	8b 45 14             	mov    0x14(%ebp),%eax
  801620:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801626:	8b 45 14             	mov    0x14(%ebp),%eax
  801629:	8b 00                	mov    (%eax),%eax
  80162b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801632:	8b 45 10             	mov    0x10(%ebp),%eax
  801635:	01 d0                	add    %edx,%eax
  801637:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80163d:	eb 0c                	jmp    80164b <strsplit+0x31>
			*string++ = 0;
  80163f:	8b 45 08             	mov    0x8(%ebp),%eax
  801642:	8d 50 01             	lea    0x1(%eax),%edx
  801645:	89 55 08             	mov    %edx,0x8(%ebp)
  801648:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80164b:	8b 45 08             	mov    0x8(%ebp),%eax
  80164e:	8a 00                	mov    (%eax),%al
  801650:	84 c0                	test   %al,%al
  801652:	74 18                	je     80166c <strsplit+0x52>
  801654:	8b 45 08             	mov    0x8(%ebp),%eax
  801657:	8a 00                	mov    (%eax),%al
  801659:	0f be c0             	movsbl %al,%eax
  80165c:	50                   	push   %eax
  80165d:	ff 75 0c             	pushl  0xc(%ebp)
  801660:	e8 13 fb ff ff       	call   801178 <strchr>
  801665:	83 c4 08             	add    $0x8,%esp
  801668:	85 c0                	test   %eax,%eax
  80166a:	75 d3                	jne    80163f <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80166c:	8b 45 08             	mov    0x8(%ebp),%eax
  80166f:	8a 00                	mov    (%eax),%al
  801671:	84 c0                	test   %al,%al
  801673:	74 5a                	je     8016cf <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801675:	8b 45 14             	mov    0x14(%ebp),%eax
  801678:	8b 00                	mov    (%eax),%eax
  80167a:	83 f8 0f             	cmp    $0xf,%eax
  80167d:	75 07                	jne    801686 <strsplit+0x6c>
		{
			return 0;
  80167f:	b8 00 00 00 00       	mov    $0x0,%eax
  801684:	eb 66                	jmp    8016ec <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801686:	8b 45 14             	mov    0x14(%ebp),%eax
  801689:	8b 00                	mov    (%eax),%eax
  80168b:	8d 48 01             	lea    0x1(%eax),%ecx
  80168e:	8b 55 14             	mov    0x14(%ebp),%edx
  801691:	89 0a                	mov    %ecx,(%edx)
  801693:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80169a:	8b 45 10             	mov    0x10(%ebp),%eax
  80169d:	01 c2                	add    %eax,%edx
  80169f:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a2:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016a4:	eb 03                	jmp    8016a9 <strsplit+0x8f>
			string++;
  8016a6:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ac:	8a 00                	mov    (%eax),%al
  8016ae:	84 c0                	test   %al,%al
  8016b0:	74 8b                	je     80163d <strsplit+0x23>
  8016b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b5:	8a 00                	mov    (%eax),%al
  8016b7:	0f be c0             	movsbl %al,%eax
  8016ba:	50                   	push   %eax
  8016bb:	ff 75 0c             	pushl  0xc(%ebp)
  8016be:	e8 b5 fa ff ff       	call   801178 <strchr>
  8016c3:	83 c4 08             	add    $0x8,%esp
  8016c6:	85 c0                	test   %eax,%eax
  8016c8:	74 dc                	je     8016a6 <strsplit+0x8c>
			string++;
	}
  8016ca:	e9 6e ff ff ff       	jmp    80163d <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8016cf:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8016d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8016d3:	8b 00                	mov    (%eax),%eax
  8016d5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8016df:	01 d0                	add    %edx,%eax
  8016e1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8016e7:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8016ec:	c9                   	leave  
  8016ed:	c3                   	ret    

008016ee <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8016ee:	55                   	push   %ebp
  8016ef:	89 e5                	mov    %esp,%ebp
  8016f1:	57                   	push   %edi
  8016f2:	56                   	push   %esi
  8016f3:	53                   	push   %ebx
  8016f4:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8016f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016fd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801700:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801703:	8b 7d 18             	mov    0x18(%ebp),%edi
  801706:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801709:	cd 30                	int    $0x30
  80170b:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80170e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801711:	83 c4 10             	add    $0x10,%esp
  801714:	5b                   	pop    %ebx
  801715:	5e                   	pop    %esi
  801716:	5f                   	pop    %edi
  801717:	5d                   	pop    %ebp
  801718:	c3                   	ret    

00801719 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801719:	55                   	push   %ebp
  80171a:	89 e5                	mov    %esp,%ebp
  80171c:	83 ec 04             	sub    $0x4,%esp
  80171f:	8b 45 10             	mov    0x10(%ebp),%eax
  801722:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801725:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801729:	8b 45 08             	mov    0x8(%ebp),%eax
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	52                   	push   %edx
  801731:	ff 75 0c             	pushl  0xc(%ebp)
  801734:	50                   	push   %eax
  801735:	6a 00                	push   $0x0
  801737:	e8 b2 ff ff ff       	call   8016ee <syscall>
  80173c:	83 c4 18             	add    $0x18,%esp
}
  80173f:	90                   	nop
  801740:	c9                   	leave  
  801741:	c3                   	ret    

00801742 <sys_cgetc>:

int
sys_cgetc(void)
{
  801742:	55                   	push   %ebp
  801743:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801745:	6a 00                	push   $0x0
  801747:	6a 00                	push   $0x0
  801749:	6a 00                	push   $0x0
  80174b:	6a 00                	push   $0x0
  80174d:	6a 00                	push   $0x0
  80174f:	6a 01                	push   $0x1
  801751:	e8 98 ff ff ff       	call   8016ee <syscall>
  801756:	83 c4 18             	add    $0x18,%esp
}
  801759:	c9                   	leave  
  80175a:	c3                   	ret    

0080175b <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80175b:	55                   	push   %ebp
  80175c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80175e:	8b 45 08             	mov    0x8(%ebp),%eax
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	50                   	push   %eax
  80176a:	6a 05                	push   $0x5
  80176c:	e8 7d ff ff ff       	call   8016ee <syscall>
  801771:	83 c4 18             	add    $0x18,%esp
}
  801774:	c9                   	leave  
  801775:	c3                   	ret    

00801776 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801776:	55                   	push   %ebp
  801777:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801779:	6a 00                	push   $0x0
  80177b:	6a 00                	push   $0x0
  80177d:	6a 00                	push   $0x0
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	6a 02                	push   $0x2
  801785:	e8 64 ff ff ff       	call   8016ee <syscall>
  80178a:	83 c4 18             	add    $0x18,%esp
}
  80178d:	c9                   	leave  
  80178e:	c3                   	ret    

0080178f <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80178f:	55                   	push   %ebp
  801790:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801792:	6a 00                	push   $0x0
  801794:	6a 00                	push   $0x0
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 00                	push   $0x0
  80179c:	6a 03                	push   $0x3
  80179e:	e8 4b ff ff ff       	call   8016ee <syscall>
  8017a3:	83 c4 18             	add    $0x18,%esp
}
  8017a6:	c9                   	leave  
  8017a7:	c3                   	ret    

008017a8 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017a8:	55                   	push   %ebp
  8017a9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017ab:	6a 00                	push   $0x0
  8017ad:	6a 00                	push   $0x0
  8017af:	6a 00                	push   $0x0
  8017b1:	6a 00                	push   $0x0
  8017b3:	6a 00                	push   $0x0
  8017b5:	6a 04                	push   $0x4
  8017b7:	e8 32 ff ff ff       	call   8016ee <syscall>
  8017bc:	83 c4 18             	add    $0x18,%esp
}
  8017bf:	c9                   	leave  
  8017c0:	c3                   	ret    

008017c1 <sys_env_exit>:


void sys_env_exit(void)
{
  8017c1:	55                   	push   %ebp
  8017c2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8017c4:	6a 00                	push   $0x0
  8017c6:	6a 00                	push   $0x0
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	6a 06                	push   $0x6
  8017d0:	e8 19 ff ff ff       	call   8016ee <syscall>
  8017d5:	83 c4 18             	add    $0x18,%esp
}
  8017d8:	90                   	nop
  8017d9:	c9                   	leave  
  8017da:	c3                   	ret    

008017db <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8017db:	55                   	push   %ebp
  8017dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8017de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 00                	push   $0x0
  8017e8:	6a 00                	push   $0x0
  8017ea:	52                   	push   %edx
  8017eb:	50                   	push   %eax
  8017ec:	6a 07                	push   $0x7
  8017ee:	e8 fb fe ff ff       	call   8016ee <syscall>
  8017f3:	83 c4 18             	add    $0x18,%esp
}
  8017f6:	c9                   	leave  
  8017f7:	c3                   	ret    

008017f8 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8017f8:	55                   	push   %ebp
  8017f9:	89 e5                	mov    %esp,%ebp
  8017fb:	56                   	push   %esi
  8017fc:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8017fd:	8b 75 18             	mov    0x18(%ebp),%esi
  801800:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801803:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801806:	8b 55 0c             	mov    0xc(%ebp),%edx
  801809:	8b 45 08             	mov    0x8(%ebp),%eax
  80180c:	56                   	push   %esi
  80180d:	53                   	push   %ebx
  80180e:	51                   	push   %ecx
  80180f:	52                   	push   %edx
  801810:	50                   	push   %eax
  801811:	6a 08                	push   $0x8
  801813:	e8 d6 fe ff ff       	call   8016ee <syscall>
  801818:	83 c4 18             	add    $0x18,%esp
}
  80181b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80181e:	5b                   	pop    %ebx
  80181f:	5e                   	pop    %esi
  801820:	5d                   	pop    %ebp
  801821:	c3                   	ret    

00801822 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801822:	55                   	push   %ebp
  801823:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801825:	8b 55 0c             	mov    0xc(%ebp),%edx
  801828:	8b 45 08             	mov    0x8(%ebp),%eax
  80182b:	6a 00                	push   $0x0
  80182d:	6a 00                	push   $0x0
  80182f:	6a 00                	push   $0x0
  801831:	52                   	push   %edx
  801832:	50                   	push   %eax
  801833:	6a 09                	push   $0x9
  801835:	e8 b4 fe ff ff       	call   8016ee <syscall>
  80183a:	83 c4 18             	add    $0x18,%esp
}
  80183d:	c9                   	leave  
  80183e:	c3                   	ret    

0080183f <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80183f:	55                   	push   %ebp
  801840:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801842:	6a 00                	push   $0x0
  801844:	6a 00                	push   $0x0
  801846:	6a 00                	push   $0x0
  801848:	ff 75 0c             	pushl  0xc(%ebp)
  80184b:	ff 75 08             	pushl  0x8(%ebp)
  80184e:	6a 0a                	push   $0xa
  801850:	e8 99 fe ff ff       	call   8016ee <syscall>
  801855:	83 c4 18             	add    $0x18,%esp
}
  801858:	c9                   	leave  
  801859:	c3                   	ret    

0080185a <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80185a:	55                   	push   %ebp
  80185b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80185d:	6a 00                	push   $0x0
  80185f:	6a 00                	push   $0x0
  801861:	6a 00                	push   $0x0
  801863:	6a 00                	push   $0x0
  801865:	6a 00                	push   $0x0
  801867:	6a 0b                	push   $0xb
  801869:	e8 80 fe ff ff       	call   8016ee <syscall>
  80186e:	83 c4 18             	add    $0x18,%esp
}
  801871:	c9                   	leave  
  801872:	c3                   	ret    

00801873 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801873:	55                   	push   %ebp
  801874:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801876:	6a 00                	push   $0x0
  801878:	6a 00                	push   $0x0
  80187a:	6a 00                	push   $0x0
  80187c:	6a 00                	push   $0x0
  80187e:	6a 00                	push   $0x0
  801880:	6a 0c                	push   $0xc
  801882:	e8 67 fe ff ff       	call   8016ee <syscall>
  801887:	83 c4 18             	add    $0x18,%esp
}
  80188a:	c9                   	leave  
  80188b:	c3                   	ret    

0080188c <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80188c:	55                   	push   %ebp
  80188d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80188f:	6a 00                	push   $0x0
  801891:	6a 00                	push   $0x0
  801893:	6a 00                	push   $0x0
  801895:	6a 00                	push   $0x0
  801897:	6a 00                	push   $0x0
  801899:	6a 0d                	push   $0xd
  80189b:	e8 4e fe ff ff       	call   8016ee <syscall>
  8018a0:	83 c4 18             	add    $0x18,%esp
}
  8018a3:	c9                   	leave  
  8018a4:	c3                   	ret    

008018a5 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018a5:	55                   	push   %ebp
  8018a6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018a8:	6a 00                	push   $0x0
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 00                	push   $0x0
  8018ae:	ff 75 0c             	pushl  0xc(%ebp)
  8018b1:	ff 75 08             	pushl  0x8(%ebp)
  8018b4:	6a 11                	push   $0x11
  8018b6:	e8 33 fe ff ff       	call   8016ee <syscall>
  8018bb:	83 c4 18             	add    $0x18,%esp
	return;
  8018be:	90                   	nop
}
  8018bf:	c9                   	leave  
  8018c0:	c3                   	ret    

008018c1 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8018c1:	55                   	push   %ebp
  8018c2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8018c4:	6a 00                	push   $0x0
  8018c6:	6a 00                	push   $0x0
  8018c8:	6a 00                	push   $0x0
  8018ca:	ff 75 0c             	pushl  0xc(%ebp)
  8018cd:	ff 75 08             	pushl  0x8(%ebp)
  8018d0:	6a 12                	push   $0x12
  8018d2:	e8 17 fe ff ff       	call   8016ee <syscall>
  8018d7:	83 c4 18             	add    $0x18,%esp
	return ;
  8018da:	90                   	nop
}
  8018db:	c9                   	leave  
  8018dc:	c3                   	ret    

008018dd <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8018dd:	55                   	push   %ebp
  8018de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8018e0:	6a 00                	push   $0x0
  8018e2:	6a 00                	push   $0x0
  8018e4:	6a 00                	push   $0x0
  8018e6:	6a 00                	push   $0x0
  8018e8:	6a 00                	push   $0x0
  8018ea:	6a 0e                	push   $0xe
  8018ec:	e8 fd fd ff ff       	call   8016ee <syscall>
  8018f1:	83 c4 18             	add    $0x18,%esp
}
  8018f4:	c9                   	leave  
  8018f5:	c3                   	ret    

008018f6 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8018f6:	55                   	push   %ebp
  8018f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 00                	push   $0x0
  8018ff:	6a 00                	push   $0x0
  801901:	ff 75 08             	pushl  0x8(%ebp)
  801904:	6a 0f                	push   $0xf
  801906:	e8 e3 fd ff ff       	call   8016ee <syscall>
  80190b:	83 c4 18             	add    $0x18,%esp
}
  80190e:	c9                   	leave  
  80190f:	c3                   	ret    

00801910 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801910:	55                   	push   %ebp
  801911:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801913:	6a 00                	push   $0x0
  801915:	6a 00                	push   $0x0
  801917:	6a 00                	push   $0x0
  801919:	6a 00                	push   $0x0
  80191b:	6a 00                	push   $0x0
  80191d:	6a 10                	push   $0x10
  80191f:	e8 ca fd ff ff       	call   8016ee <syscall>
  801924:	83 c4 18             	add    $0x18,%esp
}
  801927:	90                   	nop
  801928:	c9                   	leave  
  801929:	c3                   	ret    

0080192a <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80192a:	55                   	push   %ebp
  80192b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80192d:	6a 00                	push   $0x0
  80192f:	6a 00                	push   $0x0
  801931:	6a 00                	push   $0x0
  801933:	6a 00                	push   $0x0
  801935:	6a 00                	push   $0x0
  801937:	6a 14                	push   $0x14
  801939:	e8 b0 fd ff ff       	call   8016ee <syscall>
  80193e:	83 c4 18             	add    $0x18,%esp
}
  801941:	90                   	nop
  801942:	c9                   	leave  
  801943:	c3                   	ret    

00801944 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801944:	55                   	push   %ebp
  801945:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801947:	6a 00                	push   $0x0
  801949:	6a 00                	push   $0x0
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	6a 00                	push   $0x0
  801951:	6a 15                	push   $0x15
  801953:	e8 96 fd ff ff       	call   8016ee <syscall>
  801958:	83 c4 18             	add    $0x18,%esp
}
  80195b:	90                   	nop
  80195c:	c9                   	leave  
  80195d:	c3                   	ret    

0080195e <sys_cputc>:


void
sys_cputc(const char c)
{
  80195e:	55                   	push   %ebp
  80195f:	89 e5                	mov    %esp,%ebp
  801961:	83 ec 04             	sub    $0x4,%esp
  801964:	8b 45 08             	mov    0x8(%ebp),%eax
  801967:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80196a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80196e:	6a 00                	push   $0x0
  801970:	6a 00                	push   $0x0
  801972:	6a 00                	push   $0x0
  801974:	6a 00                	push   $0x0
  801976:	50                   	push   %eax
  801977:	6a 16                	push   $0x16
  801979:	e8 70 fd ff ff       	call   8016ee <syscall>
  80197e:	83 c4 18             	add    $0x18,%esp
}
  801981:	90                   	nop
  801982:	c9                   	leave  
  801983:	c3                   	ret    

00801984 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801984:	55                   	push   %ebp
  801985:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801987:	6a 00                	push   $0x0
  801989:	6a 00                	push   $0x0
  80198b:	6a 00                	push   $0x0
  80198d:	6a 00                	push   $0x0
  80198f:	6a 00                	push   $0x0
  801991:	6a 17                	push   $0x17
  801993:	e8 56 fd ff ff       	call   8016ee <syscall>
  801998:	83 c4 18             	add    $0x18,%esp
}
  80199b:	90                   	nop
  80199c:	c9                   	leave  
  80199d:	c3                   	ret    

0080199e <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80199e:	55                   	push   %ebp
  80199f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a4:	6a 00                	push   $0x0
  8019a6:	6a 00                	push   $0x0
  8019a8:	6a 00                	push   $0x0
  8019aa:	ff 75 0c             	pushl  0xc(%ebp)
  8019ad:	50                   	push   %eax
  8019ae:	6a 18                	push   $0x18
  8019b0:	e8 39 fd ff ff       	call   8016ee <syscall>
  8019b5:	83 c4 18             	add    $0x18,%esp
}
  8019b8:	c9                   	leave  
  8019b9:	c3                   	ret    

008019ba <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8019ba:	55                   	push   %ebp
  8019bb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c3:	6a 00                	push   $0x0
  8019c5:	6a 00                	push   $0x0
  8019c7:	6a 00                	push   $0x0
  8019c9:	52                   	push   %edx
  8019ca:	50                   	push   %eax
  8019cb:	6a 1b                	push   $0x1b
  8019cd:	e8 1c fd ff ff       	call   8016ee <syscall>
  8019d2:	83 c4 18             	add    $0x18,%esp
}
  8019d5:	c9                   	leave  
  8019d6:	c3                   	ret    

008019d7 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019d7:	55                   	push   %ebp
  8019d8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019da:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e0:	6a 00                	push   $0x0
  8019e2:	6a 00                	push   $0x0
  8019e4:	6a 00                	push   $0x0
  8019e6:	52                   	push   %edx
  8019e7:	50                   	push   %eax
  8019e8:	6a 19                	push   $0x19
  8019ea:	e8 ff fc ff ff       	call   8016ee <syscall>
  8019ef:	83 c4 18             	add    $0x18,%esp
}
  8019f2:	90                   	nop
  8019f3:	c9                   	leave  
  8019f4:	c3                   	ret    

008019f5 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8019f5:	55                   	push   %ebp
  8019f6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8019f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8019fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fe:	6a 00                	push   $0x0
  801a00:	6a 00                	push   $0x0
  801a02:	6a 00                	push   $0x0
  801a04:	52                   	push   %edx
  801a05:	50                   	push   %eax
  801a06:	6a 1a                	push   $0x1a
  801a08:	e8 e1 fc ff ff       	call   8016ee <syscall>
  801a0d:	83 c4 18             	add    $0x18,%esp
}
  801a10:	90                   	nop
  801a11:	c9                   	leave  
  801a12:	c3                   	ret    

00801a13 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a13:	55                   	push   %ebp
  801a14:	89 e5                	mov    %esp,%ebp
  801a16:	83 ec 04             	sub    $0x4,%esp
  801a19:	8b 45 10             	mov    0x10(%ebp),%eax
  801a1c:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a1f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a22:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a26:	8b 45 08             	mov    0x8(%ebp),%eax
  801a29:	6a 00                	push   $0x0
  801a2b:	51                   	push   %ecx
  801a2c:	52                   	push   %edx
  801a2d:	ff 75 0c             	pushl  0xc(%ebp)
  801a30:	50                   	push   %eax
  801a31:	6a 1c                	push   $0x1c
  801a33:	e8 b6 fc ff ff       	call   8016ee <syscall>
  801a38:	83 c4 18             	add    $0x18,%esp
}
  801a3b:	c9                   	leave  
  801a3c:	c3                   	ret    

00801a3d <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a3d:	55                   	push   %ebp
  801a3e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a40:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a43:	8b 45 08             	mov    0x8(%ebp),%eax
  801a46:	6a 00                	push   $0x0
  801a48:	6a 00                	push   $0x0
  801a4a:	6a 00                	push   $0x0
  801a4c:	52                   	push   %edx
  801a4d:	50                   	push   %eax
  801a4e:	6a 1d                	push   $0x1d
  801a50:	e8 99 fc ff ff       	call   8016ee <syscall>
  801a55:	83 c4 18             	add    $0x18,%esp
}
  801a58:	c9                   	leave  
  801a59:	c3                   	ret    

00801a5a <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801a5a:	55                   	push   %ebp
  801a5b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801a5d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a60:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a63:	8b 45 08             	mov    0x8(%ebp),%eax
  801a66:	6a 00                	push   $0x0
  801a68:	6a 00                	push   $0x0
  801a6a:	51                   	push   %ecx
  801a6b:	52                   	push   %edx
  801a6c:	50                   	push   %eax
  801a6d:	6a 1e                	push   $0x1e
  801a6f:	e8 7a fc ff ff       	call   8016ee <syscall>
  801a74:	83 c4 18             	add    $0x18,%esp
}
  801a77:	c9                   	leave  
  801a78:	c3                   	ret    

00801a79 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801a79:	55                   	push   %ebp
  801a7a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801a7c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a7f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a82:	6a 00                	push   $0x0
  801a84:	6a 00                	push   $0x0
  801a86:	6a 00                	push   $0x0
  801a88:	52                   	push   %edx
  801a89:	50                   	push   %eax
  801a8a:	6a 1f                	push   $0x1f
  801a8c:	e8 5d fc ff ff       	call   8016ee <syscall>
  801a91:	83 c4 18             	add    $0x18,%esp
}
  801a94:	c9                   	leave  
  801a95:	c3                   	ret    

00801a96 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801a96:	55                   	push   %ebp
  801a97:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801a99:	6a 00                	push   $0x0
  801a9b:	6a 00                	push   $0x0
  801a9d:	6a 00                	push   $0x0
  801a9f:	6a 00                	push   $0x0
  801aa1:	6a 00                	push   $0x0
  801aa3:	6a 20                	push   $0x20
  801aa5:	e8 44 fc ff ff       	call   8016ee <syscall>
  801aaa:	83 c4 18             	add    $0x18,%esp
}
  801aad:	c9                   	leave  
  801aae:	c3                   	ret    

00801aaf <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801aaf:	55                   	push   %ebp
  801ab0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801ab2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab5:	6a 00                	push   $0x0
  801ab7:	ff 75 14             	pushl  0x14(%ebp)
  801aba:	ff 75 10             	pushl  0x10(%ebp)
  801abd:	ff 75 0c             	pushl  0xc(%ebp)
  801ac0:	50                   	push   %eax
  801ac1:	6a 21                	push   $0x21
  801ac3:	e8 26 fc ff ff       	call   8016ee <syscall>
  801ac8:	83 c4 18             	add    $0x18,%esp
}
  801acb:	c9                   	leave  
  801acc:	c3                   	ret    

00801acd <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801acd:	55                   	push   %ebp
  801ace:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801ad0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad3:	6a 00                	push   $0x0
  801ad5:	6a 00                	push   $0x0
  801ad7:	6a 00                	push   $0x0
  801ad9:	6a 00                	push   $0x0
  801adb:	50                   	push   %eax
  801adc:	6a 22                	push   $0x22
  801ade:	e8 0b fc ff ff       	call   8016ee <syscall>
  801ae3:	83 c4 18             	add    $0x18,%esp
}
  801ae6:	90                   	nop
  801ae7:	c9                   	leave  
  801ae8:	c3                   	ret    

00801ae9 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801ae9:	55                   	push   %ebp
  801aea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801aec:	8b 45 08             	mov    0x8(%ebp),%eax
  801aef:	6a 00                	push   $0x0
  801af1:	6a 00                	push   $0x0
  801af3:	6a 00                	push   $0x0
  801af5:	6a 00                	push   $0x0
  801af7:	50                   	push   %eax
  801af8:	6a 23                	push   $0x23
  801afa:	e8 ef fb ff ff       	call   8016ee <syscall>
  801aff:	83 c4 18             	add    $0x18,%esp
}
  801b02:	90                   	nop
  801b03:	c9                   	leave  
  801b04:	c3                   	ret    

00801b05 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b05:	55                   	push   %ebp
  801b06:	89 e5                	mov    %esp,%ebp
  801b08:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b0b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b0e:	8d 50 04             	lea    0x4(%eax),%edx
  801b11:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b14:	6a 00                	push   $0x0
  801b16:	6a 00                	push   $0x0
  801b18:	6a 00                	push   $0x0
  801b1a:	52                   	push   %edx
  801b1b:	50                   	push   %eax
  801b1c:	6a 24                	push   $0x24
  801b1e:	e8 cb fb ff ff       	call   8016ee <syscall>
  801b23:	83 c4 18             	add    $0x18,%esp
	return result;
  801b26:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b29:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b2c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b2f:	89 01                	mov    %eax,(%ecx)
  801b31:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b34:	8b 45 08             	mov    0x8(%ebp),%eax
  801b37:	c9                   	leave  
  801b38:	c2 04 00             	ret    $0x4

00801b3b <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b3b:	55                   	push   %ebp
  801b3c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b3e:	6a 00                	push   $0x0
  801b40:	6a 00                	push   $0x0
  801b42:	ff 75 10             	pushl  0x10(%ebp)
  801b45:	ff 75 0c             	pushl  0xc(%ebp)
  801b48:	ff 75 08             	pushl  0x8(%ebp)
  801b4b:	6a 13                	push   $0x13
  801b4d:	e8 9c fb ff ff       	call   8016ee <syscall>
  801b52:	83 c4 18             	add    $0x18,%esp
	return ;
  801b55:	90                   	nop
}
  801b56:	c9                   	leave  
  801b57:	c3                   	ret    

00801b58 <sys_rcr2>:
uint32 sys_rcr2()
{
  801b58:	55                   	push   %ebp
  801b59:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801b5b:	6a 00                	push   $0x0
  801b5d:	6a 00                	push   $0x0
  801b5f:	6a 00                	push   $0x0
  801b61:	6a 00                	push   $0x0
  801b63:	6a 00                	push   $0x0
  801b65:	6a 25                	push   $0x25
  801b67:	e8 82 fb ff ff       	call   8016ee <syscall>
  801b6c:	83 c4 18             	add    $0x18,%esp
}
  801b6f:	c9                   	leave  
  801b70:	c3                   	ret    

00801b71 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801b71:	55                   	push   %ebp
  801b72:	89 e5                	mov    %esp,%ebp
  801b74:	83 ec 04             	sub    $0x4,%esp
  801b77:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801b7d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801b81:	6a 00                	push   $0x0
  801b83:	6a 00                	push   $0x0
  801b85:	6a 00                	push   $0x0
  801b87:	6a 00                	push   $0x0
  801b89:	50                   	push   %eax
  801b8a:	6a 26                	push   $0x26
  801b8c:	e8 5d fb ff ff       	call   8016ee <syscall>
  801b91:	83 c4 18             	add    $0x18,%esp
	return ;
  801b94:	90                   	nop
}
  801b95:	c9                   	leave  
  801b96:	c3                   	ret    

00801b97 <rsttst>:
void rsttst()
{
  801b97:	55                   	push   %ebp
  801b98:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801b9a:	6a 00                	push   $0x0
  801b9c:	6a 00                	push   $0x0
  801b9e:	6a 00                	push   $0x0
  801ba0:	6a 00                	push   $0x0
  801ba2:	6a 00                	push   $0x0
  801ba4:	6a 28                	push   $0x28
  801ba6:	e8 43 fb ff ff       	call   8016ee <syscall>
  801bab:	83 c4 18             	add    $0x18,%esp
	return ;
  801bae:	90                   	nop
}
  801baf:	c9                   	leave  
  801bb0:	c3                   	ret    

00801bb1 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801bb1:	55                   	push   %ebp
  801bb2:	89 e5                	mov    %esp,%ebp
  801bb4:	83 ec 04             	sub    $0x4,%esp
  801bb7:	8b 45 14             	mov    0x14(%ebp),%eax
  801bba:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801bbd:	8b 55 18             	mov    0x18(%ebp),%edx
  801bc0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801bc4:	52                   	push   %edx
  801bc5:	50                   	push   %eax
  801bc6:	ff 75 10             	pushl  0x10(%ebp)
  801bc9:	ff 75 0c             	pushl  0xc(%ebp)
  801bcc:	ff 75 08             	pushl  0x8(%ebp)
  801bcf:	6a 27                	push   $0x27
  801bd1:	e8 18 fb ff ff       	call   8016ee <syscall>
  801bd6:	83 c4 18             	add    $0x18,%esp
	return ;
  801bd9:	90                   	nop
}
  801bda:	c9                   	leave  
  801bdb:	c3                   	ret    

00801bdc <chktst>:
void chktst(uint32 n)
{
  801bdc:	55                   	push   %ebp
  801bdd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801bdf:	6a 00                	push   $0x0
  801be1:	6a 00                	push   $0x0
  801be3:	6a 00                	push   $0x0
  801be5:	6a 00                	push   $0x0
  801be7:	ff 75 08             	pushl  0x8(%ebp)
  801bea:	6a 29                	push   $0x29
  801bec:	e8 fd fa ff ff       	call   8016ee <syscall>
  801bf1:	83 c4 18             	add    $0x18,%esp
	return ;
  801bf4:	90                   	nop
}
  801bf5:	c9                   	leave  
  801bf6:	c3                   	ret    

00801bf7 <inctst>:

void inctst()
{
  801bf7:	55                   	push   %ebp
  801bf8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801bfa:	6a 00                	push   $0x0
  801bfc:	6a 00                	push   $0x0
  801bfe:	6a 00                	push   $0x0
  801c00:	6a 00                	push   $0x0
  801c02:	6a 00                	push   $0x0
  801c04:	6a 2a                	push   $0x2a
  801c06:	e8 e3 fa ff ff       	call   8016ee <syscall>
  801c0b:	83 c4 18             	add    $0x18,%esp
	return ;
  801c0e:	90                   	nop
}
  801c0f:	c9                   	leave  
  801c10:	c3                   	ret    

00801c11 <gettst>:
uint32 gettst()
{
  801c11:	55                   	push   %ebp
  801c12:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c14:	6a 00                	push   $0x0
  801c16:	6a 00                	push   $0x0
  801c18:	6a 00                	push   $0x0
  801c1a:	6a 00                	push   $0x0
  801c1c:	6a 00                	push   $0x0
  801c1e:	6a 2b                	push   $0x2b
  801c20:	e8 c9 fa ff ff       	call   8016ee <syscall>
  801c25:	83 c4 18             	add    $0x18,%esp
}
  801c28:	c9                   	leave  
  801c29:	c3                   	ret    

00801c2a <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c2a:	55                   	push   %ebp
  801c2b:	89 e5                	mov    %esp,%ebp
  801c2d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c30:	6a 00                	push   $0x0
  801c32:	6a 00                	push   $0x0
  801c34:	6a 00                	push   $0x0
  801c36:	6a 00                	push   $0x0
  801c38:	6a 00                	push   $0x0
  801c3a:	6a 2c                	push   $0x2c
  801c3c:	e8 ad fa ff ff       	call   8016ee <syscall>
  801c41:	83 c4 18             	add    $0x18,%esp
  801c44:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c47:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c4b:	75 07                	jne    801c54 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c4d:	b8 01 00 00 00       	mov    $0x1,%eax
  801c52:	eb 05                	jmp    801c59 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c54:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c59:	c9                   	leave  
  801c5a:	c3                   	ret    

00801c5b <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801c5b:	55                   	push   %ebp
  801c5c:	89 e5                	mov    %esp,%ebp
  801c5e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c61:	6a 00                	push   $0x0
  801c63:	6a 00                	push   $0x0
  801c65:	6a 00                	push   $0x0
  801c67:	6a 00                	push   $0x0
  801c69:	6a 00                	push   $0x0
  801c6b:	6a 2c                	push   $0x2c
  801c6d:	e8 7c fa ff ff       	call   8016ee <syscall>
  801c72:	83 c4 18             	add    $0x18,%esp
  801c75:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801c78:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801c7c:	75 07                	jne    801c85 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801c7e:	b8 01 00 00 00       	mov    $0x1,%eax
  801c83:	eb 05                	jmp    801c8a <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801c85:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801c8a:	c9                   	leave  
  801c8b:	c3                   	ret    

00801c8c <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801c8c:	55                   	push   %ebp
  801c8d:	89 e5                	mov    %esp,%ebp
  801c8f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c92:	6a 00                	push   $0x0
  801c94:	6a 00                	push   $0x0
  801c96:	6a 00                	push   $0x0
  801c98:	6a 00                	push   $0x0
  801c9a:	6a 00                	push   $0x0
  801c9c:	6a 2c                	push   $0x2c
  801c9e:	e8 4b fa ff ff       	call   8016ee <syscall>
  801ca3:	83 c4 18             	add    $0x18,%esp
  801ca6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801ca9:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801cad:	75 07                	jne    801cb6 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801caf:	b8 01 00 00 00       	mov    $0x1,%eax
  801cb4:	eb 05                	jmp    801cbb <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801cb6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cbb:	c9                   	leave  
  801cbc:	c3                   	ret    

00801cbd <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801cbd:	55                   	push   %ebp
  801cbe:	89 e5                	mov    %esp,%ebp
  801cc0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cc3:	6a 00                	push   $0x0
  801cc5:	6a 00                	push   $0x0
  801cc7:	6a 00                	push   $0x0
  801cc9:	6a 00                	push   $0x0
  801ccb:	6a 00                	push   $0x0
  801ccd:	6a 2c                	push   $0x2c
  801ccf:	e8 1a fa ff ff       	call   8016ee <syscall>
  801cd4:	83 c4 18             	add    $0x18,%esp
  801cd7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801cda:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801cde:	75 07                	jne    801ce7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801ce0:	b8 01 00 00 00       	mov    $0x1,%eax
  801ce5:	eb 05                	jmp    801cec <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801ce7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cec:	c9                   	leave  
  801ced:	c3                   	ret    

00801cee <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801cee:	55                   	push   %ebp
  801cef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801cf1:	6a 00                	push   $0x0
  801cf3:	6a 00                	push   $0x0
  801cf5:	6a 00                	push   $0x0
  801cf7:	6a 00                	push   $0x0
  801cf9:	ff 75 08             	pushl  0x8(%ebp)
  801cfc:	6a 2d                	push   $0x2d
  801cfe:	e8 eb f9 ff ff       	call   8016ee <syscall>
  801d03:	83 c4 18             	add    $0x18,%esp
	return ;
  801d06:	90                   	nop
}
  801d07:	c9                   	leave  
  801d08:	c3                   	ret    

00801d09 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801d09:	55                   	push   %ebp
  801d0a:	89 e5                	mov    %esp,%ebp
  801d0c:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801d0d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d10:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d13:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d16:	8b 45 08             	mov    0x8(%ebp),%eax
  801d19:	6a 00                	push   $0x0
  801d1b:	53                   	push   %ebx
  801d1c:	51                   	push   %ecx
  801d1d:	52                   	push   %edx
  801d1e:	50                   	push   %eax
  801d1f:	6a 2e                	push   $0x2e
  801d21:	e8 c8 f9 ff ff       	call   8016ee <syscall>
  801d26:	83 c4 18             	add    $0x18,%esp
}
  801d29:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d2c:	c9                   	leave  
  801d2d:	c3                   	ret    

00801d2e <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801d2e:	55                   	push   %ebp
  801d2f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801d31:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d34:	8b 45 08             	mov    0x8(%ebp),%eax
  801d37:	6a 00                	push   $0x0
  801d39:	6a 00                	push   $0x0
  801d3b:	6a 00                	push   $0x0
  801d3d:	52                   	push   %edx
  801d3e:	50                   	push   %eax
  801d3f:	6a 2f                	push   $0x2f
  801d41:	e8 a8 f9 ff ff       	call   8016ee <syscall>
  801d46:	83 c4 18             	add    $0x18,%esp
}
  801d49:	c9                   	leave  
  801d4a:	c3                   	ret    
  801d4b:	90                   	nop

00801d4c <__udivdi3>:
  801d4c:	55                   	push   %ebp
  801d4d:	57                   	push   %edi
  801d4e:	56                   	push   %esi
  801d4f:	53                   	push   %ebx
  801d50:	83 ec 1c             	sub    $0x1c,%esp
  801d53:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801d57:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801d5b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d5f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801d63:	89 ca                	mov    %ecx,%edx
  801d65:	89 f8                	mov    %edi,%eax
  801d67:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801d6b:	85 f6                	test   %esi,%esi
  801d6d:	75 2d                	jne    801d9c <__udivdi3+0x50>
  801d6f:	39 cf                	cmp    %ecx,%edi
  801d71:	77 65                	ja     801dd8 <__udivdi3+0x8c>
  801d73:	89 fd                	mov    %edi,%ebp
  801d75:	85 ff                	test   %edi,%edi
  801d77:	75 0b                	jne    801d84 <__udivdi3+0x38>
  801d79:	b8 01 00 00 00       	mov    $0x1,%eax
  801d7e:	31 d2                	xor    %edx,%edx
  801d80:	f7 f7                	div    %edi
  801d82:	89 c5                	mov    %eax,%ebp
  801d84:	31 d2                	xor    %edx,%edx
  801d86:	89 c8                	mov    %ecx,%eax
  801d88:	f7 f5                	div    %ebp
  801d8a:	89 c1                	mov    %eax,%ecx
  801d8c:	89 d8                	mov    %ebx,%eax
  801d8e:	f7 f5                	div    %ebp
  801d90:	89 cf                	mov    %ecx,%edi
  801d92:	89 fa                	mov    %edi,%edx
  801d94:	83 c4 1c             	add    $0x1c,%esp
  801d97:	5b                   	pop    %ebx
  801d98:	5e                   	pop    %esi
  801d99:	5f                   	pop    %edi
  801d9a:	5d                   	pop    %ebp
  801d9b:	c3                   	ret    
  801d9c:	39 ce                	cmp    %ecx,%esi
  801d9e:	77 28                	ja     801dc8 <__udivdi3+0x7c>
  801da0:	0f bd fe             	bsr    %esi,%edi
  801da3:	83 f7 1f             	xor    $0x1f,%edi
  801da6:	75 40                	jne    801de8 <__udivdi3+0x9c>
  801da8:	39 ce                	cmp    %ecx,%esi
  801daa:	72 0a                	jb     801db6 <__udivdi3+0x6a>
  801dac:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801db0:	0f 87 9e 00 00 00    	ja     801e54 <__udivdi3+0x108>
  801db6:	b8 01 00 00 00       	mov    $0x1,%eax
  801dbb:	89 fa                	mov    %edi,%edx
  801dbd:	83 c4 1c             	add    $0x1c,%esp
  801dc0:	5b                   	pop    %ebx
  801dc1:	5e                   	pop    %esi
  801dc2:	5f                   	pop    %edi
  801dc3:	5d                   	pop    %ebp
  801dc4:	c3                   	ret    
  801dc5:	8d 76 00             	lea    0x0(%esi),%esi
  801dc8:	31 ff                	xor    %edi,%edi
  801dca:	31 c0                	xor    %eax,%eax
  801dcc:	89 fa                	mov    %edi,%edx
  801dce:	83 c4 1c             	add    $0x1c,%esp
  801dd1:	5b                   	pop    %ebx
  801dd2:	5e                   	pop    %esi
  801dd3:	5f                   	pop    %edi
  801dd4:	5d                   	pop    %ebp
  801dd5:	c3                   	ret    
  801dd6:	66 90                	xchg   %ax,%ax
  801dd8:	89 d8                	mov    %ebx,%eax
  801dda:	f7 f7                	div    %edi
  801ddc:	31 ff                	xor    %edi,%edi
  801dde:	89 fa                	mov    %edi,%edx
  801de0:	83 c4 1c             	add    $0x1c,%esp
  801de3:	5b                   	pop    %ebx
  801de4:	5e                   	pop    %esi
  801de5:	5f                   	pop    %edi
  801de6:	5d                   	pop    %ebp
  801de7:	c3                   	ret    
  801de8:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ded:	89 eb                	mov    %ebp,%ebx
  801def:	29 fb                	sub    %edi,%ebx
  801df1:	89 f9                	mov    %edi,%ecx
  801df3:	d3 e6                	shl    %cl,%esi
  801df5:	89 c5                	mov    %eax,%ebp
  801df7:	88 d9                	mov    %bl,%cl
  801df9:	d3 ed                	shr    %cl,%ebp
  801dfb:	89 e9                	mov    %ebp,%ecx
  801dfd:	09 f1                	or     %esi,%ecx
  801dff:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e03:	89 f9                	mov    %edi,%ecx
  801e05:	d3 e0                	shl    %cl,%eax
  801e07:	89 c5                	mov    %eax,%ebp
  801e09:	89 d6                	mov    %edx,%esi
  801e0b:	88 d9                	mov    %bl,%cl
  801e0d:	d3 ee                	shr    %cl,%esi
  801e0f:	89 f9                	mov    %edi,%ecx
  801e11:	d3 e2                	shl    %cl,%edx
  801e13:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e17:	88 d9                	mov    %bl,%cl
  801e19:	d3 e8                	shr    %cl,%eax
  801e1b:	09 c2                	or     %eax,%edx
  801e1d:	89 d0                	mov    %edx,%eax
  801e1f:	89 f2                	mov    %esi,%edx
  801e21:	f7 74 24 0c          	divl   0xc(%esp)
  801e25:	89 d6                	mov    %edx,%esi
  801e27:	89 c3                	mov    %eax,%ebx
  801e29:	f7 e5                	mul    %ebp
  801e2b:	39 d6                	cmp    %edx,%esi
  801e2d:	72 19                	jb     801e48 <__udivdi3+0xfc>
  801e2f:	74 0b                	je     801e3c <__udivdi3+0xf0>
  801e31:	89 d8                	mov    %ebx,%eax
  801e33:	31 ff                	xor    %edi,%edi
  801e35:	e9 58 ff ff ff       	jmp    801d92 <__udivdi3+0x46>
  801e3a:	66 90                	xchg   %ax,%ax
  801e3c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801e40:	89 f9                	mov    %edi,%ecx
  801e42:	d3 e2                	shl    %cl,%edx
  801e44:	39 c2                	cmp    %eax,%edx
  801e46:	73 e9                	jae    801e31 <__udivdi3+0xe5>
  801e48:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801e4b:	31 ff                	xor    %edi,%edi
  801e4d:	e9 40 ff ff ff       	jmp    801d92 <__udivdi3+0x46>
  801e52:	66 90                	xchg   %ax,%ax
  801e54:	31 c0                	xor    %eax,%eax
  801e56:	e9 37 ff ff ff       	jmp    801d92 <__udivdi3+0x46>
  801e5b:	90                   	nop

00801e5c <__umoddi3>:
  801e5c:	55                   	push   %ebp
  801e5d:	57                   	push   %edi
  801e5e:	56                   	push   %esi
  801e5f:	53                   	push   %ebx
  801e60:	83 ec 1c             	sub    $0x1c,%esp
  801e63:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801e67:	8b 74 24 34          	mov    0x34(%esp),%esi
  801e6b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e6f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801e73:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801e77:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801e7b:	89 f3                	mov    %esi,%ebx
  801e7d:	89 fa                	mov    %edi,%edx
  801e7f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e83:	89 34 24             	mov    %esi,(%esp)
  801e86:	85 c0                	test   %eax,%eax
  801e88:	75 1a                	jne    801ea4 <__umoddi3+0x48>
  801e8a:	39 f7                	cmp    %esi,%edi
  801e8c:	0f 86 a2 00 00 00    	jbe    801f34 <__umoddi3+0xd8>
  801e92:	89 c8                	mov    %ecx,%eax
  801e94:	89 f2                	mov    %esi,%edx
  801e96:	f7 f7                	div    %edi
  801e98:	89 d0                	mov    %edx,%eax
  801e9a:	31 d2                	xor    %edx,%edx
  801e9c:	83 c4 1c             	add    $0x1c,%esp
  801e9f:	5b                   	pop    %ebx
  801ea0:	5e                   	pop    %esi
  801ea1:	5f                   	pop    %edi
  801ea2:	5d                   	pop    %ebp
  801ea3:	c3                   	ret    
  801ea4:	39 f0                	cmp    %esi,%eax
  801ea6:	0f 87 ac 00 00 00    	ja     801f58 <__umoddi3+0xfc>
  801eac:	0f bd e8             	bsr    %eax,%ebp
  801eaf:	83 f5 1f             	xor    $0x1f,%ebp
  801eb2:	0f 84 ac 00 00 00    	je     801f64 <__umoddi3+0x108>
  801eb8:	bf 20 00 00 00       	mov    $0x20,%edi
  801ebd:	29 ef                	sub    %ebp,%edi
  801ebf:	89 fe                	mov    %edi,%esi
  801ec1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ec5:	89 e9                	mov    %ebp,%ecx
  801ec7:	d3 e0                	shl    %cl,%eax
  801ec9:	89 d7                	mov    %edx,%edi
  801ecb:	89 f1                	mov    %esi,%ecx
  801ecd:	d3 ef                	shr    %cl,%edi
  801ecf:	09 c7                	or     %eax,%edi
  801ed1:	89 e9                	mov    %ebp,%ecx
  801ed3:	d3 e2                	shl    %cl,%edx
  801ed5:	89 14 24             	mov    %edx,(%esp)
  801ed8:	89 d8                	mov    %ebx,%eax
  801eda:	d3 e0                	shl    %cl,%eax
  801edc:	89 c2                	mov    %eax,%edx
  801ede:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ee2:	d3 e0                	shl    %cl,%eax
  801ee4:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ee8:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eec:	89 f1                	mov    %esi,%ecx
  801eee:	d3 e8                	shr    %cl,%eax
  801ef0:	09 d0                	or     %edx,%eax
  801ef2:	d3 eb                	shr    %cl,%ebx
  801ef4:	89 da                	mov    %ebx,%edx
  801ef6:	f7 f7                	div    %edi
  801ef8:	89 d3                	mov    %edx,%ebx
  801efa:	f7 24 24             	mull   (%esp)
  801efd:	89 c6                	mov    %eax,%esi
  801eff:	89 d1                	mov    %edx,%ecx
  801f01:	39 d3                	cmp    %edx,%ebx
  801f03:	0f 82 87 00 00 00    	jb     801f90 <__umoddi3+0x134>
  801f09:	0f 84 91 00 00 00    	je     801fa0 <__umoddi3+0x144>
  801f0f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f13:	29 f2                	sub    %esi,%edx
  801f15:	19 cb                	sbb    %ecx,%ebx
  801f17:	89 d8                	mov    %ebx,%eax
  801f19:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f1d:	d3 e0                	shl    %cl,%eax
  801f1f:	89 e9                	mov    %ebp,%ecx
  801f21:	d3 ea                	shr    %cl,%edx
  801f23:	09 d0                	or     %edx,%eax
  801f25:	89 e9                	mov    %ebp,%ecx
  801f27:	d3 eb                	shr    %cl,%ebx
  801f29:	89 da                	mov    %ebx,%edx
  801f2b:	83 c4 1c             	add    $0x1c,%esp
  801f2e:	5b                   	pop    %ebx
  801f2f:	5e                   	pop    %esi
  801f30:	5f                   	pop    %edi
  801f31:	5d                   	pop    %ebp
  801f32:	c3                   	ret    
  801f33:	90                   	nop
  801f34:	89 fd                	mov    %edi,%ebp
  801f36:	85 ff                	test   %edi,%edi
  801f38:	75 0b                	jne    801f45 <__umoddi3+0xe9>
  801f3a:	b8 01 00 00 00       	mov    $0x1,%eax
  801f3f:	31 d2                	xor    %edx,%edx
  801f41:	f7 f7                	div    %edi
  801f43:	89 c5                	mov    %eax,%ebp
  801f45:	89 f0                	mov    %esi,%eax
  801f47:	31 d2                	xor    %edx,%edx
  801f49:	f7 f5                	div    %ebp
  801f4b:	89 c8                	mov    %ecx,%eax
  801f4d:	f7 f5                	div    %ebp
  801f4f:	89 d0                	mov    %edx,%eax
  801f51:	e9 44 ff ff ff       	jmp    801e9a <__umoddi3+0x3e>
  801f56:	66 90                	xchg   %ax,%ax
  801f58:	89 c8                	mov    %ecx,%eax
  801f5a:	89 f2                	mov    %esi,%edx
  801f5c:	83 c4 1c             	add    $0x1c,%esp
  801f5f:	5b                   	pop    %ebx
  801f60:	5e                   	pop    %esi
  801f61:	5f                   	pop    %edi
  801f62:	5d                   	pop    %ebp
  801f63:	c3                   	ret    
  801f64:	3b 04 24             	cmp    (%esp),%eax
  801f67:	72 06                	jb     801f6f <__umoddi3+0x113>
  801f69:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801f6d:	77 0f                	ja     801f7e <__umoddi3+0x122>
  801f6f:	89 f2                	mov    %esi,%edx
  801f71:	29 f9                	sub    %edi,%ecx
  801f73:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801f77:	89 14 24             	mov    %edx,(%esp)
  801f7a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f7e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f82:	8b 14 24             	mov    (%esp),%edx
  801f85:	83 c4 1c             	add    $0x1c,%esp
  801f88:	5b                   	pop    %ebx
  801f89:	5e                   	pop    %esi
  801f8a:	5f                   	pop    %edi
  801f8b:	5d                   	pop    %ebp
  801f8c:	c3                   	ret    
  801f8d:	8d 76 00             	lea    0x0(%esi),%esi
  801f90:	2b 04 24             	sub    (%esp),%eax
  801f93:	19 fa                	sbb    %edi,%edx
  801f95:	89 d1                	mov    %edx,%ecx
  801f97:	89 c6                	mov    %eax,%esi
  801f99:	e9 71 ff ff ff       	jmp    801f0f <__umoddi3+0xb3>
  801f9e:	66 90                	xchg   %ax,%ax
  801fa0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801fa4:	72 ea                	jb     801f90 <__umoddi3+0x134>
  801fa6:	89 d9                	mov    %ebx,%ecx
  801fa8:	e9 62 ff ff ff       	jmp    801f0f <__umoddi3+0xb3>
