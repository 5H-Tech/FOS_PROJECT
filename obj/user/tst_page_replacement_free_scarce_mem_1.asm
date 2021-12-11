
obj/user/tst_page_replacement_free_scarce_mem_1:     file format elf32-i386


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
  800031:	e8 16 04 00 00       	call   80044c <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

#include <inc/lib.h>

char* ptr = (char*) 0xeebfe000 - (PAGE_SIZE) -1;
void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec 8c 00 00 00    	sub    $0x8c,%esp
	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800044:	a1 20 30 80 00       	mov    0x803020,%eax
  800049:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80004f:	8b 00                	mov    (%eax),%eax
  800051:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800054:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800057:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80005c:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800061:	74 14                	je     800077 <_main+0x3f>
  800063:	83 ec 04             	sub    $0x4,%esp
  800066:	68 40 1f 80 00       	push   $0x801f40
  80006b:	6a 0c                	push   $0xc
  80006d:	68 84 1f 80 00       	push   $0x801f84
  800072:	e8 1a 05 00 00       	call   800591 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800077:	a1 20 30 80 00       	mov    0x803020,%eax
  80007c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800082:	83 c0 10             	add    $0x10,%eax
  800085:	8b 00                	mov    (%eax),%eax
  800087:	89 45 e0             	mov    %eax,-0x20(%ebp)
  80008a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80008d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800092:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800097:	74 14                	je     8000ad <_main+0x75>
  800099:	83 ec 04             	sub    $0x4,%esp
  80009c:	68 40 1f 80 00       	push   $0x801f40
  8000a1:	6a 0d                	push   $0xd
  8000a3:	68 84 1f 80 00       	push   $0x801f84
  8000a8:	e8 e4 04 00 00       	call   800591 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000ad:	a1 20 30 80 00       	mov    0x803020,%eax
  8000b2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000b8:	83 c0 20             	add    $0x20,%eax
  8000bb:	8b 00                	mov    (%eax),%eax
  8000bd:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8000c0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8000c3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c8:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000cd:	74 14                	je     8000e3 <_main+0xab>
  8000cf:	83 ec 04             	sub    $0x4,%esp
  8000d2:	68 40 1f 80 00       	push   $0x801f40
  8000d7:	6a 0e                	push   $0xe
  8000d9:	68 84 1f 80 00       	push   $0x801f84
  8000de:	e8 ae 04 00 00       	call   800591 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000e3:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e8:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8000ee:	83 c0 30             	add    $0x30,%eax
  8000f1:	8b 00                	mov    (%eax),%eax
  8000f3:	89 45 d8             	mov    %eax,-0x28(%ebp)
  8000f6:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000f9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000fe:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800103:	74 14                	je     800119 <_main+0xe1>
  800105:	83 ec 04             	sub    $0x4,%esp
  800108:	68 40 1f 80 00       	push   $0x801f40
  80010d:	6a 0f                	push   $0xf
  80010f:	68 84 1f 80 00       	push   $0x801f84
  800114:	e8 78 04 00 00       	call   800591 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800119:	a1 20 30 80 00       	mov    0x803020,%eax
  80011e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800124:	83 c0 40             	add    $0x40,%eax
  800127:	8b 00                	mov    (%eax),%eax
  800129:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  80012c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80012f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800134:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800139:	74 14                	je     80014f <_main+0x117>
  80013b:	83 ec 04             	sub    $0x4,%esp
  80013e:	68 40 1f 80 00       	push   $0x801f40
  800143:	6a 10                	push   $0x10
  800145:	68 84 1f 80 00       	push   $0x801f84
  80014a:	e8 42 04 00 00       	call   800591 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80014f:	a1 20 30 80 00       	mov    0x803020,%eax
  800154:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80015a:	83 c0 50             	add    $0x50,%eax
  80015d:	8b 00                	mov    (%eax),%eax
  80015f:	89 45 d0             	mov    %eax,-0x30(%ebp)
  800162:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800165:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80016a:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80016f:	74 14                	je     800185 <_main+0x14d>
  800171:	83 ec 04             	sub    $0x4,%esp
  800174:	68 40 1f 80 00       	push   $0x801f40
  800179:	6a 11                	push   $0x11
  80017b:	68 84 1f 80 00       	push   $0x801f84
  800180:	e8 0c 04 00 00       	call   800591 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800185:	a1 20 30 80 00       	mov    0x803020,%eax
  80018a:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800190:	83 c0 60             	add    $0x60,%eax
  800193:	8b 00                	mov    (%eax),%eax
  800195:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800198:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80019b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001a0:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001a5:	74 14                	je     8001bb <_main+0x183>
  8001a7:	83 ec 04             	sub    $0x4,%esp
  8001aa:	68 40 1f 80 00       	push   $0x801f40
  8001af:	6a 12                	push   $0x12
  8001b1:	68 84 1f 80 00       	push   $0x801f84
  8001b6:	e8 d6 03 00 00       	call   800591 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001bb:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c0:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001c6:	83 c0 70             	add    $0x70,%eax
  8001c9:	8b 00                	mov    (%eax),%eax
  8001cb:	89 45 c8             	mov    %eax,-0x38(%ebp)
  8001ce:	8b 45 c8             	mov    -0x38(%ebp),%eax
  8001d1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d6:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001db:	74 14                	je     8001f1 <_main+0x1b9>
  8001dd:	83 ec 04             	sub    $0x4,%esp
  8001e0:	68 40 1f 80 00       	push   $0x801f40
  8001e5:	6a 13                	push   $0x13
  8001e7:	68 84 1f 80 00       	push   $0x801f84
  8001ec:	e8 a0 03 00 00       	call   800591 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001f1:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f6:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8001fc:	83 e8 80             	sub    $0xffffff80,%eax
  8001ff:	8b 00                	mov    (%eax),%eax
  800201:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  800204:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800207:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80020c:	3d 00 20 80 00       	cmp    $0x802000,%eax
  800211:	74 14                	je     800227 <_main+0x1ef>
  800213:	83 ec 04             	sub    $0x4,%esp
  800216:	68 40 1f 80 00       	push   $0x801f40
  80021b:	6a 14                	push   $0x14
  80021d:	68 84 1f 80 00       	push   $0x801f84
  800222:	e8 6a 03 00 00       	call   800591 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800227:	a1 20 30 80 00       	mov    0x803020,%eax
  80022c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800232:	05 90 00 00 00       	add    $0x90,%eax
  800237:	8b 00                	mov    (%eax),%eax
  800239:	89 45 c0             	mov    %eax,-0x40(%ebp)
  80023c:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80023f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800244:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800249:	74 14                	je     80025f <_main+0x227>
  80024b:	83 ec 04             	sub    $0x4,%esp
  80024e:	68 40 1f 80 00       	push   $0x801f40
  800253:	6a 15                	push   $0x15
  800255:	68 84 1f 80 00       	push   $0x801f84
  80025a:	e8 32 03 00 00       	call   800591 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80025f:	a1 20 30 80 00       	mov    0x803020,%eax
  800264:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80026a:	05 a0 00 00 00       	add    $0xa0,%eax
  80026f:	8b 00                	mov    (%eax),%eax
  800271:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800274:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800277:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80027c:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800281:	74 14                	je     800297 <_main+0x25f>
  800283:	83 ec 04             	sub    $0x4,%esp
  800286:	68 40 1f 80 00       	push   $0x801f40
  80028b:	6a 16                	push   $0x16
  80028d:	68 84 1f 80 00       	push   $0x801f84
  800292:	e8 fa 02 00 00       	call   800591 <_panic>
		if( myEnv->__uptr_pws[11].empty !=   1)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800297:	a1 20 30 80 00       	mov    0x803020,%eax
  80029c:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002a2:	05 b0 00 00 00       	add    $0xb0,%eax
  8002a7:	8a 40 04             	mov    0x4(%eax),%al
  8002aa:	3c 01                	cmp    $0x1,%al
  8002ac:	74 14                	je     8002c2 <_main+0x28a>
  8002ae:	83 ec 04             	sub    $0x4,%esp
  8002b1:	68 40 1f 80 00       	push   $0x801f40
  8002b6:	6a 17                	push   $0x17
  8002b8:	68 84 1f 80 00       	push   $0x801f84
  8002bd:	e8 cf 02 00 00       	call   800591 <_panic>
		if( myEnv->__uptr_pws[12].empty !=   1)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8002c2:	a1 20 30 80 00       	mov    0x803020,%eax
  8002c7:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002cd:	05 c0 00 00 00       	add    $0xc0,%eax
  8002d2:	8a 40 04             	mov    0x4(%eax),%al
  8002d5:	3c 01                	cmp    $0x1,%al
  8002d7:	74 14                	je     8002ed <_main+0x2b5>
  8002d9:	83 ec 04             	sub    $0x4,%esp
  8002dc:	68 40 1f 80 00       	push   $0x801f40
  8002e1:	6a 18                	push   $0x18
  8002e3:	68 84 1f 80 00       	push   $0x801f84
  8002e8:	e8 a4 02 00 00       	call   800591 <_panic>
		if( myEnv->__uptr_pws[13].empty !=   1)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8002ed:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8002f8:	05 d0 00 00 00       	add    $0xd0,%eax
  8002fd:	8a 40 04             	mov    0x4(%eax),%al
  800300:	3c 01                	cmp    $0x1,%al
  800302:	74 14                	je     800318 <_main+0x2e0>
  800304:	83 ec 04             	sub    $0x4,%esp
  800307:	68 40 1f 80 00       	push   $0x801f40
  80030c:	6a 19                	push   $0x19
  80030e:	68 84 1f 80 00       	push   $0x801f84
  800313:	e8 79 02 00 00       	call   800591 <_panic>
		if( myEnv->__uptr_pws[14].empty !=   1)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800318:	a1 20 30 80 00       	mov    0x803020,%eax
  80031d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800323:	05 e0 00 00 00       	add    $0xe0,%eax
  800328:	8a 40 04             	mov    0x4(%eax),%al
  80032b:	3c 01                	cmp    $0x1,%al
  80032d:	74 14                	je     800343 <_main+0x30b>
  80032f:	83 ec 04             	sub    $0x4,%esp
  800332:	68 40 1f 80 00       	push   $0x801f40
  800337:	6a 1a                	push   $0x1a
  800339:	68 84 1f 80 00       	push   $0x801f84
  80033e:	e8 4e 02 00 00       	call   800591 <_panic>
		if( myEnv->page_last_WS_index !=  11)	panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  800343:	a1 20 30 80 00       	mov    0x803020,%eax
  800348:	8b 80 18 3c 01 00    	mov    0x13c18(%eax),%eax
  80034e:	83 f8 0b             	cmp    $0xb,%eax
  800351:	74 14                	je     800367 <_main+0x32f>
  800353:	83 ec 04             	sub    $0x4,%esp
  800356:	68 b4 1f 80 00       	push   $0x801fb4
  80035b:	6a 1b                	push   $0x1b
  80035d:	68 84 1f 80 00       	push   $0x801f84
  800362:	e8 2a 02 00 00       	call   800591 <_panic>
	}

	// Access stack (take large time stamp)
	env_sleep(6000);
  800367:	83 ec 0c             	sub    $0xc,%esp
  80036a:	68 70 17 00 00       	push   $0x1770
  80036f:	e8 a6 18 00 00       	call   801c1a <env_sleep>
  800374:	83 c4 10             	add    $0x10,%esp

	cprintf("before scarcing memory\n");
  800377:	83 ec 0c             	sub    $0xc,%esp
  80037a:	68 fa 1f 80 00       	push   $0x801ffa
  80037f:	e8 af 04 00 00       	call   800833 <cprintf>
  800384:	83 c4 10             	add    $0x10,%esp
	sys_scarce_memory();	// FREEING 50% from allocated pages (11 pages) ==> LRU 6 pages shall be removed
  800387:	e8 53 14 00 00       	call   8017df <sys_scarce_memory>
	cprintf("after scarcing memory\n");
  80038c:	83 ec 0c             	sub    $0xc,%esp
  80038f:	68 12 20 80 00       	push   $0x802012
  800394:	e8 9a 04 00 00       	call   800833 <cprintf>
  800399:	83 c4 10             	add    $0x10,%esp

	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80039c:	e8 0b 14 00 00       	call   8017ac <sys_pf_calculate_allocated_pages>
  8003a1:	89 45 b8             	mov    %eax,-0x48(%ebp)
	int freePages = sys_calculate_free_frames();
  8003a4:	e8 80 13 00 00       	call   801729 <sys_calculate_free_frames>
  8003a9:	89 45 b4             	mov    %eax,-0x4c(%ebp)

	// FAULT a STACK Page
	char x = *ptr;
  8003ac:	a1 00 30 80 00       	mov    0x803000,%eax
  8003b1:	8a 00                	mov    (%eax),%al
  8003b3:	88 45 b3             	mov    %al,-0x4d(%ebp)

	uint32 expectedPages[15] = {0xeebfd000,0x800000,0x801000,0x802000,0x803000,0xeebfc000,0,0,0,0,0,0,0,0,0};
  8003b6:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
  8003bc:	bb 80 21 80 00       	mov    $0x802180,%ebx
  8003c1:	ba 0f 00 00 00       	mov    $0xf,%edx
  8003c6:	89 c7                	mov    %eax,%edi
  8003c8:	89 de                	mov    %ebx,%esi
  8003ca:	89 d1                	mov    %edx,%ecx
  8003cc:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	//cprintf("Checking PAGE LRU algorithm... \n");
	{
		CheckWSWithoutLastIndex(expectedPages, 15);
  8003ce:	83 ec 08             	sub    $0x8,%esp
  8003d1:	6a 0f                	push   $0xf
  8003d3:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
  8003d9:	50                   	push   %eax
  8003da:	e8 24 02 00 00       	call   800603 <CheckWSWithoutLastIndex>
  8003df:	83 c4 10             	add    $0x10,%esp
	}

	// Checking the PAGE FILE
	// Checking the number of pages freed after the memory being scarce...
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  8003e2:	e8 c5 13 00 00       	call   8017ac <sys_pf_calculate_allocated_pages>
  8003e7:	2b 45 b8             	sub    -0x48(%ebp),%eax
  8003ea:	83 f8 01             	cmp    $0x1,%eax
  8003ed:	74 14                	je     800403 <_main+0x3cb>
  8003ef:	83 ec 04             	sub    $0x4,%esp
  8003f2:	68 2c 20 80 00       	push   $0x80202c
  8003f7:	6a 49                	push   $0x49
  8003f9:	68 84 1f 80 00       	push   $0x801f84
  8003fe:	e8 8e 01 00 00       	call   800591 <_panic>
		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  800403:	e8 21 13 00 00       	call   801729 <sys_calculate_free_frames>
  800408:	89 c3                	mov    %eax,%ebx
  80040a:	e8 33 13 00 00       	call   801742 <sys_calculate_modified_frames>
  80040f:	01 d8                	add    %ebx,%eax
  800411:	89 45 ac             	mov    %eax,-0x54(%ebp)
		if( (freePages - freePagesAfter) != -5 )
  800414:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800417:	2b 45 ac             	sub    -0x54(%ebp),%eax
  80041a:	83 f8 fb             	cmp    $0xfffffffb,%eax
  80041d:	74 14                	je     800433 <_main+0x3fb>
			panic("Extra memory are wrongly allocated ... It's REplacement: extra/less frames have been FREED after the memory being scarce");
  80041f:	83 ec 04             	sub    $0x4,%esp
  800422:	68 98 20 80 00       	push   $0x802098
  800427:	6a 4c                	push   $0x4c
  800429:	68 84 1f 80 00       	push   $0x801f84
  80042e:	e8 5e 01 00 00       	call   800591 <_panic>
	}

	cprintf("Congratulations!! test PAGE replacement [FREEING SCARCE MEMORY 1] using LRU is completed successfully.\n");
  800433:	83 ec 0c             	sub    $0xc,%esp
  800436:	68 14 21 80 00       	push   $0x802114
  80043b:	e8 f3 03 00 00       	call   800833 <cprintf>
  800440:	83 c4 10             	add    $0x10,%esp

	return;
  800443:	90                   	nop
}
  800444:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800447:	5b                   	pop    %ebx
  800448:	5e                   	pop    %esi
  800449:	5f                   	pop    %edi
  80044a:	5d                   	pop    %ebp
  80044b:	c3                   	ret    

0080044c <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80044c:	55                   	push   %ebp
  80044d:	89 e5                	mov    %esp,%ebp
  80044f:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800452:	e8 07 12 00 00       	call   80165e <sys_getenvindex>
  800457:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80045a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80045d:	89 d0                	mov    %edx,%eax
  80045f:	c1 e0 03             	shl    $0x3,%eax
  800462:	01 d0                	add    %edx,%eax
  800464:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  80046b:	01 c8                	add    %ecx,%eax
  80046d:	01 c0                	add    %eax,%eax
  80046f:	01 d0                	add    %edx,%eax
  800471:	01 c0                	add    %eax,%eax
  800473:	01 d0                	add    %edx,%eax
  800475:	89 c2                	mov    %eax,%edx
  800477:	c1 e2 05             	shl    $0x5,%edx
  80047a:	29 c2                	sub    %eax,%edx
  80047c:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800483:	89 c2                	mov    %eax,%edx
  800485:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  80048b:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800490:	a1 20 30 80 00       	mov    0x803020,%eax
  800495:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  80049b:	84 c0                	test   %al,%al
  80049d:	74 0f                	je     8004ae <libmain+0x62>
		binaryname = myEnv->prog_name;
  80049f:	a1 20 30 80 00       	mov    0x803020,%eax
  8004a4:	05 40 3c 01 00       	add    $0x13c40,%eax
  8004a9:	a3 04 30 80 00       	mov    %eax,0x803004

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8004ae:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8004b2:	7e 0a                	jle    8004be <libmain+0x72>
		binaryname = argv[0];
  8004b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004b7:	8b 00                	mov    (%eax),%eax
  8004b9:	a3 04 30 80 00       	mov    %eax,0x803004

	// call user main routine
	_main(argc, argv);
  8004be:	83 ec 08             	sub    $0x8,%esp
  8004c1:	ff 75 0c             	pushl  0xc(%ebp)
  8004c4:	ff 75 08             	pushl  0x8(%ebp)
  8004c7:	e8 6c fb ff ff       	call   800038 <_main>
  8004cc:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8004cf:	e8 25 13 00 00       	call   8017f9 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8004d4:	83 ec 0c             	sub    $0xc,%esp
  8004d7:	68 d4 21 80 00       	push   $0x8021d4
  8004dc:	e8 52 03 00 00       	call   800833 <cprintf>
  8004e1:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8004e4:	a1 20 30 80 00       	mov    0x803020,%eax
  8004e9:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8004ef:	a1 20 30 80 00       	mov    0x803020,%eax
  8004f4:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8004fa:	83 ec 04             	sub    $0x4,%esp
  8004fd:	52                   	push   %edx
  8004fe:	50                   	push   %eax
  8004ff:	68 fc 21 80 00       	push   $0x8021fc
  800504:	e8 2a 03 00 00       	call   800833 <cprintf>
  800509:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  80050c:	a1 20 30 80 00       	mov    0x803020,%eax
  800511:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800517:	a1 20 30 80 00       	mov    0x803020,%eax
  80051c:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800522:	83 ec 04             	sub    $0x4,%esp
  800525:	52                   	push   %edx
  800526:	50                   	push   %eax
  800527:	68 24 22 80 00       	push   $0x802224
  80052c:	e8 02 03 00 00       	call   800833 <cprintf>
  800531:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800534:	a1 20 30 80 00       	mov    0x803020,%eax
  800539:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80053f:	83 ec 08             	sub    $0x8,%esp
  800542:	50                   	push   %eax
  800543:	68 65 22 80 00       	push   $0x802265
  800548:	e8 e6 02 00 00       	call   800833 <cprintf>
  80054d:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800550:	83 ec 0c             	sub    $0xc,%esp
  800553:	68 d4 21 80 00       	push   $0x8021d4
  800558:	e8 d6 02 00 00       	call   800833 <cprintf>
  80055d:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800560:	e8 ae 12 00 00       	call   801813 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800565:	e8 19 00 00 00       	call   800583 <exit>
}
  80056a:	90                   	nop
  80056b:	c9                   	leave  
  80056c:	c3                   	ret    

0080056d <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80056d:	55                   	push   %ebp
  80056e:	89 e5                	mov    %esp,%ebp
  800570:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800573:	83 ec 0c             	sub    $0xc,%esp
  800576:	6a 00                	push   $0x0
  800578:	e8 ad 10 00 00       	call   80162a <sys_env_destroy>
  80057d:	83 c4 10             	add    $0x10,%esp
}
  800580:	90                   	nop
  800581:	c9                   	leave  
  800582:	c3                   	ret    

00800583 <exit>:

void
exit(void)
{
  800583:	55                   	push   %ebp
  800584:	89 e5                	mov    %esp,%ebp
  800586:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800589:	e8 02 11 00 00       	call   801690 <sys_env_exit>
}
  80058e:	90                   	nop
  80058f:	c9                   	leave  
  800590:	c3                   	ret    

00800591 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800591:	55                   	push   %ebp
  800592:	89 e5                	mov    %esp,%ebp
  800594:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800597:	8d 45 10             	lea    0x10(%ebp),%eax
  80059a:	83 c0 04             	add    $0x4,%eax
  80059d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8005a0:	a1 18 31 80 00       	mov    0x803118,%eax
  8005a5:	85 c0                	test   %eax,%eax
  8005a7:	74 16                	je     8005bf <_panic+0x2e>
		cprintf("%s: ", argv0);
  8005a9:	a1 18 31 80 00       	mov    0x803118,%eax
  8005ae:	83 ec 08             	sub    $0x8,%esp
  8005b1:	50                   	push   %eax
  8005b2:	68 7c 22 80 00       	push   $0x80227c
  8005b7:	e8 77 02 00 00       	call   800833 <cprintf>
  8005bc:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8005bf:	a1 04 30 80 00       	mov    0x803004,%eax
  8005c4:	ff 75 0c             	pushl  0xc(%ebp)
  8005c7:	ff 75 08             	pushl  0x8(%ebp)
  8005ca:	50                   	push   %eax
  8005cb:	68 81 22 80 00       	push   $0x802281
  8005d0:	e8 5e 02 00 00       	call   800833 <cprintf>
  8005d5:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8005d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8005db:	83 ec 08             	sub    $0x8,%esp
  8005de:	ff 75 f4             	pushl  -0xc(%ebp)
  8005e1:	50                   	push   %eax
  8005e2:	e8 e1 01 00 00       	call   8007c8 <vcprintf>
  8005e7:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8005ea:	83 ec 08             	sub    $0x8,%esp
  8005ed:	6a 00                	push   $0x0
  8005ef:	68 9d 22 80 00       	push   $0x80229d
  8005f4:	e8 cf 01 00 00       	call   8007c8 <vcprintf>
  8005f9:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8005fc:	e8 82 ff ff ff       	call   800583 <exit>

	// should not return here
	while (1) ;
  800601:	eb fe                	jmp    800601 <_panic+0x70>

00800603 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800603:	55                   	push   %ebp
  800604:	89 e5                	mov    %esp,%ebp
  800606:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800609:	a1 20 30 80 00       	mov    0x803020,%eax
  80060e:	8b 50 74             	mov    0x74(%eax),%edx
  800611:	8b 45 0c             	mov    0xc(%ebp),%eax
  800614:	39 c2                	cmp    %eax,%edx
  800616:	74 14                	je     80062c <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800618:	83 ec 04             	sub    $0x4,%esp
  80061b:	68 a0 22 80 00       	push   $0x8022a0
  800620:	6a 26                	push   $0x26
  800622:	68 ec 22 80 00       	push   $0x8022ec
  800627:	e8 65 ff ff ff       	call   800591 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80062c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800633:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80063a:	e9 b6 00 00 00       	jmp    8006f5 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80063f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800642:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800649:	8b 45 08             	mov    0x8(%ebp),%eax
  80064c:	01 d0                	add    %edx,%eax
  80064e:	8b 00                	mov    (%eax),%eax
  800650:	85 c0                	test   %eax,%eax
  800652:	75 08                	jne    80065c <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800654:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800657:	e9 96 00 00 00       	jmp    8006f2 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  80065c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800663:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80066a:	eb 5d                	jmp    8006c9 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80066c:	a1 20 30 80 00       	mov    0x803020,%eax
  800671:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800677:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80067a:	c1 e2 04             	shl    $0x4,%edx
  80067d:	01 d0                	add    %edx,%eax
  80067f:	8a 40 04             	mov    0x4(%eax),%al
  800682:	84 c0                	test   %al,%al
  800684:	75 40                	jne    8006c6 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800686:	a1 20 30 80 00       	mov    0x803020,%eax
  80068b:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800691:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800694:	c1 e2 04             	shl    $0x4,%edx
  800697:	01 d0                	add    %edx,%eax
  800699:	8b 00                	mov    (%eax),%eax
  80069b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80069e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8006a1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8006a6:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8006a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006ab:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8006b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b5:	01 c8                	add    %ecx,%eax
  8006b7:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8006b9:	39 c2                	cmp    %eax,%edx
  8006bb:	75 09                	jne    8006c6 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8006bd:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8006c4:	eb 12                	jmp    8006d8 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006c6:	ff 45 e8             	incl   -0x18(%ebp)
  8006c9:	a1 20 30 80 00       	mov    0x803020,%eax
  8006ce:	8b 50 74             	mov    0x74(%eax),%edx
  8006d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006d4:	39 c2                	cmp    %eax,%edx
  8006d6:	77 94                	ja     80066c <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8006d8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8006dc:	75 14                	jne    8006f2 <CheckWSWithoutLastIndex+0xef>
			panic(
  8006de:	83 ec 04             	sub    $0x4,%esp
  8006e1:	68 f8 22 80 00       	push   $0x8022f8
  8006e6:	6a 3a                	push   $0x3a
  8006e8:	68 ec 22 80 00       	push   $0x8022ec
  8006ed:	e8 9f fe ff ff       	call   800591 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8006f2:	ff 45 f0             	incl   -0x10(%ebp)
  8006f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006f8:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8006fb:	0f 8c 3e ff ff ff    	jl     80063f <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800701:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800708:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80070f:	eb 20                	jmp    800731 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800711:	a1 20 30 80 00       	mov    0x803020,%eax
  800716:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80071c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80071f:	c1 e2 04             	shl    $0x4,%edx
  800722:	01 d0                	add    %edx,%eax
  800724:	8a 40 04             	mov    0x4(%eax),%al
  800727:	3c 01                	cmp    $0x1,%al
  800729:	75 03                	jne    80072e <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  80072b:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80072e:	ff 45 e0             	incl   -0x20(%ebp)
  800731:	a1 20 30 80 00       	mov    0x803020,%eax
  800736:	8b 50 74             	mov    0x74(%eax),%edx
  800739:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80073c:	39 c2                	cmp    %eax,%edx
  80073e:	77 d1                	ja     800711 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800740:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800743:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800746:	74 14                	je     80075c <CheckWSWithoutLastIndex+0x159>
		panic(
  800748:	83 ec 04             	sub    $0x4,%esp
  80074b:	68 4c 23 80 00       	push   $0x80234c
  800750:	6a 44                	push   $0x44
  800752:	68 ec 22 80 00       	push   $0x8022ec
  800757:	e8 35 fe ff ff       	call   800591 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80075c:	90                   	nop
  80075d:	c9                   	leave  
  80075e:	c3                   	ret    

0080075f <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80075f:	55                   	push   %ebp
  800760:	89 e5                	mov    %esp,%ebp
  800762:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800765:	8b 45 0c             	mov    0xc(%ebp),%eax
  800768:	8b 00                	mov    (%eax),%eax
  80076a:	8d 48 01             	lea    0x1(%eax),%ecx
  80076d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800770:	89 0a                	mov    %ecx,(%edx)
  800772:	8b 55 08             	mov    0x8(%ebp),%edx
  800775:	88 d1                	mov    %dl,%cl
  800777:	8b 55 0c             	mov    0xc(%ebp),%edx
  80077a:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80077e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800781:	8b 00                	mov    (%eax),%eax
  800783:	3d ff 00 00 00       	cmp    $0xff,%eax
  800788:	75 2c                	jne    8007b6 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80078a:	a0 24 30 80 00       	mov    0x803024,%al
  80078f:	0f b6 c0             	movzbl %al,%eax
  800792:	8b 55 0c             	mov    0xc(%ebp),%edx
  800795:	8b 12                	mov    (%edx),%edx
  800797:	89 d1                	mov    %edx,%ecx
  800799:	8b 55 0c             	mov    0xc(%ebp),%edx
  80079c:	83 c2 08             	add    $0x8,%edx
  80079f:	83 ec 04             	sub    $0x4,%esp
  8007a2:	50                   	push   %eax
  8007a3:	51                   	push   %ecx
  8007a4:	52                   	push   %edx
  8007a5:	e8 3e 0e 00 00       	call   8015e8 <sys_cputs>
  8007aa:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8007ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007b0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8007b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007b9:	8b 40 04             	mov    0x4(%eax),%eax
  8007bc:	8d 50 01             	lea    0x1(%eax),%edx
  8007bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007c2:	89 50 04             	mov    %edx,0x4(%eax)
}
  8007c5:	90                   	nop
  8007c6:	c9                   	leave  
  8007c7:	c3                   	ret    

008007c8 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8007c8:	55                   	push   %ebp
  8007c9:	89 e5                	mov    %esp,%ebp
  8007cb:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8007d1:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8007d8:	00 00 00 
	b.cnt = 0;
  8007db:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8007e2:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8007e5:	ff 75 0c             	pushl  0xc(%ebp)
  8007e8:	ff 75 08             	pushl  0x8(%ebp)
  8007eb:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8007f1:	50                   	push   %eax
  8007f2:	68 5f 07 80 00       	push   $0x80075f
  8007f7:	e8 11 02 00 00       	call   800a0d <vprintfmt>
  8007fc:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8007ff:	a0 24 30 80 00       	mov    0x803024,%al
  800804:	0f b6 c0             	movzbl %al,%eax
  800807:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80080d:	83 ec 04             	sub    $0x4,%esp
  800810:	50                   	push   %eax
  800811:	52                   	push   %edx
  800812:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800818:	83 c0 08             	add    $0x8,%eax
  80081b:	50                   	push   %eax
  80081c:	e8 c7 0d 00 00       	call   8015e8 <sys_cputs>
  800821:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800824:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80082b:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800831:	c9                   	leave  
  800832:	c3                   	ret    

00800833 <cprintf>:

int cprintf(const char *fmt, ...) {
  800833:	55                   	push   %ebp
  800834:	89 e5                	mov    %esp,%ebp
  800836:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800839:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800840:	8d 45 0c             	lea    0xc(%ebp),%eax
  800843:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800846:	8b 45 08             	mov    0x8(%ebp),%eax
  800849:	83 ec 08             	sub    $0x8,%esp
  80084c:	ff 75 f4             	pushl  -0xc(%ebp)
  80084f:	50                   	push   %eax
  800850:	e8 73 ff ff ff       	call   8007c8 <vcprintf>
  800855:	83 c4 10             	add    $0x10,%esp
  800858:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80085b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80085e:	c9                   	leave  
  80085f:	c3                   	ret    

00800860 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800860:	55                   	push   %ebp
  800861:	89 e5                	mov    %esp,%ebp
  800863:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800866:	e8 8e 0f 00 00       	call   8017f9 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80086b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80086e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800871:	8b 45 08             	mov    0x8(%ebp),%eax
  800874:	83 ec 08             	sub    $0x8,%esp
  800877:	ff 75 f4             	pushl  -0xc(%ebp)
  80087a:	50                   	push   %eax
  80087b:	e8 48 ff ff ff       	call   8007c8 <vcprintf>
  800880:	83 c4 10             	add    $0x10,%esp
  800883:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800886:	e8 88 0f 00 00       	call   801813 <sys_enable_interrupt>
	return cnt;
  80088b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80088e:	c9                   	leave  
  80088f:	c3                   	ret    

00800890 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800890:	55                   	push   %ebp
  800891:	89 e5                	mov    %esp,%ebp
  800893:	53                   	push   %ebx
  800894:	83 ec 14             	sub    $0x14,%esp
  800897:	8b 45 10             	mov    0x10(%ebp),%eax
  80089a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80089d:	8b 45 14             	mov    0x14(%ebp),%eax
  8008a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8008a3:	8b 45 18             	mov    0x18(%ebp),%eax
  8008a6:	ba 00 00 00 00       	mov    $0x0,%edx
  8008ab:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8008ae:	77 55                	ja     800905 <printnum+0x75>
  8008b0:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8008b3:	72 05                	jb     8008ba <printnum+0x2a>
  8008b5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8008b8:	77 4b                	ja     800905 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8008ba:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8008bd:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8008c0:	8b 45 18             	mov    0x18(%ebp),%eax
  8008c3:	ba 00 00 00 00       	mov    $0x0,%edx
  8008c8:	52                   	push   %edx
  8008c9:	50                   	push   %eax
  8008ca:	ff 75 f4             	pushl  -0xc(%ebp)
  8008cd:	ff 75 f0             	pushl  -0x10(%ebp)
  8008d0:	e8 fb 13 00 00       	call   801cd0 <__udivdi3>
  8008d5:	83 c4 10             	add    $0x10,%esp
  8008d8:	83 ec 04             	sub    $0x4,%esp
  8008db:	ff 75 20             	pushl  0x20(%ebp)
  8008de:	53                   	push   %ebx
  8008df:	ff 75 18             	pushl  0x18(%ebp)
  8008e2:	52                   	push   %edx
  8008e3:	50                   	push   %eax
  8008e4:	ff 75 0c             	pushl  0xc(%ebp)
  8008e7:	ff 75 08             	pushl  0x8(%ebp)
  8008ea:	e8 a1 ff ff ff       	call   800890 <printnum>
  8008ef:	83 c4 20             	add    $0x20,%esp
  8008f2:	eb 1a                	jmp    80090e <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8008f4:	83 ec 08             	sub    $0x8,%esp
  8008f7:	ff 75 0c             	pushl  0xc(%ebp)
  8008fa:	ff 75 20             	pushl  0x20(%ebp)
  8008fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800900:	ff d0                	call   *%eax
  800902:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800905:	ff 4d 1c             	decl   0x1c(%ebp)
  800908:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80090c:	7f e6                	jg     8008f4 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80090e:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800911:	bb 00 00 00 00       	mov    $0x0,%ebx
  800916:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800919:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80091c:	53                   	push   %ebx
  80091d:	51                   	push   %ecx
  80091e:	52                   	push   %edx
  80091f:	50                   	push   %eax
  800920:	e8 bb 14 00 00       	call   801de0 <__umoddi3>
  800925:	83 c4 10             	add    $0x10,%esp
  800928:	05 b4 25 80 00       	add    $0x8025b4,%eax
  80092d:	8a 00                	mov    (%eax),%al
  80092f:	0f be c0             	movsbl %al,%eax
  800932:	83 ec 08             	sub    $0x8,%esp
  800935:	ff 75 0c             	pushl  0xc(%ebp)
  800938:	50                   	push   %eax
  800939:	8b 45 08             	mov    0x8(%ebp),%eax
  80093c:	ff d0                	call   *%eax
  80093e:	83 c4 10             	add    $0x10,%esp
}
  800941:	90                   	nop
  800942:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800945:	c9                   	leave  
  800946:	c3                   	ret    

00800947 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800947:	55                   	push   %ebp
  800948:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80094a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80094e:	7e 1c                	jle    80096c <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800950:	8b 45 08             	mov    0x8(%ebp),%eax
  800953:	8b 00                	mov    (%eax),%eax
  800955:	8d 50 08             	lea    0x8(%eax),%edx
  800958:	8b 45 08             	mov    0x8(%ebp),%eax
  80095b:	89 10                	mov    %edx,(%eax)
  80095d:	8b 45 08             	mov    0x8(%ebp),%eax
  800960:	8b 00                	mov    (%eax),%eax
  800962:	83 e8 08             	sub    $0x8,%eax
  800965:	8b 50 04             	mov    0x4(%eax),%edx
  800968:	8b 00                	mov    (%eax),%eax
  80096a:	eb 40                	jmp    8009ac <getuint+0x65>
	else if (lflag)
  80096c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800970:	74 1e                	je     800990 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800972:	8b 45 08             	mov    0x8(%ebp),%eax
  800975:	8b 00                	mov    (%eax),%eax
  800977:	8d 50 04             	lea    0x4(%eax),%edx
  80097a:	8b 45 08             	mov    0x8(%ebp),%eax
  80097d:	89 10                	mov    %edx,(%eax)
  80097f:	8b 45 08             	mov    0x8(%ebp),%eax
  800982:	8b 00                	mov    (%eax),%eax
  800984:	83 e8 04             	sub    $0x4,%eax
  800987:	8b 00                	mov    (%eax),%eax
  800989:	ba 00 00 00 00       	mov    $0x0,%edx
  80098e:	eb 1c                	jmp    8009ac <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800990:	8b 45 08             	mov    0x8(%ebp),%eax
  800993:	8b 00                	mov    (%eax),%eax
  800995:	8d 50 04             	lea    0x4(%eax),%edx
  800998:	8b 45 08             	mov    0x8(%ebp),%eax
  80099b:	89 10                	mov    %edx,(%eax)
  80099d:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a0:	8b 00                	mov    (%eax),%eax
  8009a2:	83 e8 04             	sub    $0x4,%eax
  8009a5:	8b 00                	mov    (%eax),%eax
  8009a7:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8009ac:	5d                   	pop    %ebp
  8009ad:	c3                   	ret    

008009ae <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8009ae:	55                   	push   %ebp
  8009af:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8009b1:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8009b5:	7e 1c                	jle    8009d3 <getint+0x25>
		return va_arg(*ap, long long);
  8009b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ba:	8b 00                	mov    (%eax),%eax
  8009bc:	8d 50 08             	lea    0x8(%eax),%edx
  8009bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c2:	89 10                	mov    %edx,(%eax)
  8009c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c7:	8b 00                	mov    (%eax),%eax
  8009c9:	83 e8 08             	sub    $0x8,%eax
  8009cc:	8b 50 04             	mov    0x4(%eax),%edx
  8009cf:	8b 00                	mov    (%eax),%eax
  8009d1:	eb 38                	jmp    800a0b <getint+0x5d>
	else if (lflag)
  8009d3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009d7:	74 1a                	je     8009f3 <getint+0x45>
		return va_arg(*ap, long);
  8009d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009dc:	8b 00                	mov    (%eax),%eax
  8009de:	8d 50 04             	lea    0x4(%eax),%edx
  8009e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e4:	89 10                	mov    %edx,(%eax)
  8009e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e9:	8b 00                	mov    (%eax),%eax
  8009eb:	83 e8 04             	sub    $0x4,%eax
  8009ee:	8b 00                	mov    (%eax),%eax
  8009f0:	99                   	cltd   
  8009f1:	eb 18                	jmp    800a0b <getint+0x5d>
	else
		return va_arg(*ap, int);
  8009f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f6:	8b 00                	mov    (%eax),%eax
  8009f8:	8d 50 04             	lea    0x4(%eax),%edx
  8009fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fe:	89 10                	mov    %edx,(%eax)
  800a00:	8b 45 08             	mov    0x8(%ebp),%eax
  800a03:	8b 00                	mov    (%eax),%eax
  800a05:	83 e8 04             	sub    $0x4,%eax
  800a08:	8b 00                	mov    (%eax),%eax
  800a0a:	99                   	cltd   
}
  800a0b:	5d                   	pop    %ebp
  800a0c:	c3                   	ret    

00800a0d <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800a0d:	55                   	push   %ebp
  800a0e:	89 e5                	mov    %esp,%ebp
  800a10:	56                   	push   %esi
  800a11:	53                   	push   %ebx
  800a12:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a15:	eb 17                	jmp    800a2e <vprintfmt+0x21>
			if (ch == '\0')
  800a17:	85 db                	test   %ebx,%ebx
  800a19:	0f 84 af 03 00 00    	je     800dce <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800a1f:	83 ec 08             	sub    $0x8,%esp
  800a22:	ff 75 0c             	pushl  0xc(%ebp)
  800a25:	53                   	push   %ebx
  800a26:	8b 45 08             	mov    0x8(%ebp),%eax
  800a29:	ff d0                	call   *%eax
  800a2b:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800a2e:	8b 45 10             	mov    0x10(%ebp),%eax
  800a31:	8d 50 01             	lea    0x1(%eax),%edx
  800a34:	89 55 10             	mov    %edx,0x10(%ebp)
  800a37:	8a 00                	mov    (%eax),%al
  800a39:	0f b6 d8             	movzbl %al,%ebx
  800a3c:	83 fb 25             	cmp    $0x25,%ebx
  800a3f:	75 d6                	jne    800a17 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800a41:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800a45:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800a4c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800a53:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800a5a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800a61:	8b 45 10             	mov    0x10(%ebp),%eax
  800a64:	8d 50 01             	lea    0x1(%eax),%edx
  800a67:	89 55 10             	mov    %edx,0x10(%ebp)
  800a6a:	8a 00                	mov    (%eax),%al
  800a6c:	0f b6 d8             	movzbl %al,%ebx
  800a6f:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800a72:	83 f8 55             	cmp    $0x55,%eax
  800a75:	0f 87 2b 03 00 00    	ja     800da6 <vprintfmt+0x399>
  800a7b:	8b 04 85 d8 25 80 00 	mov    0x8025d8(,%eax,4),%eax
  800a82:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800a84:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800a88:	eb d7                	jmp    800a61 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800a8a:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800a8e:	eb d1                	jmp    800a61 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a90:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800a97:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a9a:	89 d0                	mov    %edx,%eax
  800a9c:	c1 e0 02             	shl    $0x2,%eax
  800a9f:	01 d0                	add    %edx,%eax
  800aa1:	01 c0                	add    %eax,%eax
  800aa3:	01 d8                	add    %ebx,%eax
  800aa5:	83 e8 30             	sub    $0x30,%eax
  800aa8:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800aab:	8b 45 10             	mov    0x10(%ebp),%eax
  800aae:	8a 00                	mov    (%eax),%al
  800ab0:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ab3:	83 fb 2f             	cmp    $0x2f,%ebx
  800ab6:	7e 3e                	jle    800af6 <vprintfmt+0xe9>
  800ab8:	83 fb 39             	cmp    $0x39,%ebx
  800abb:	7f 39                	jg     800af6 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800abd:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800ac0:	eb d5                	jmp    800a97 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800ac2:	8b 45 14             	mov    0x14(%ebp),%eax
  800ac5:	83 c0 04             	add    $0x4,%eax
  800ac8:	89 45 14             	mov    %eax,0x14(%ebp)
  800acb:	8b 45 14             	mov    0x14(%ebp),%eax
  800ace:	83 e8 04             	sub    $0x4,%eax
  800ad1:	8b 00                	mov    (%eax),%eax
  800ad3:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800ad6:	eb 1f                	jmp    800af7 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800ad8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800adc:	79 83                	jns    800a61 <vprintfmt+0x54>
				width = 0;
  800ade:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800ae5:	e9 77 ff ff ff       	jmp    800a61 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800aea:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800af1:	e9 6b ff ff ff       	jmp    800a61 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800af6:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800af7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800afb:	0f 89 60 ff ff ff    	jns    800a61 <vprintfmt+0x54>
				width = precision, precision = -1;
  800b01:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b04:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800b07:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800b0e:	e9 4e ff ff ff       	jmp    800a61 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800b13:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800b16:	e9 46 ff ff ff       	jmp    800a61 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800b1b:	8b 45 14             	mov    0x14(%ebp),%eax
  800b1e:	83 c0 04             	add    $0x4,%eax
  800b21:	89 45 14             	mov    %eax,0x14(%ebp)
  800b24:	8b 45 14             	mov    0x14(%ebp),%eax
  800b27:	83 e8 04             	sub    $0x4,%eax
  800b2a:	8b 00                	mov    (%eax),%eax
  800b2c:	83 ec 08             	sub    $0x8,%esp
  800b2f:	ff 75 0c             	pushl  0xc(%ebp)
  800b32:	50                   	push   %eax
  800b33:	8b 45 08             	mov    0x8(%ebp),%eax
  800b36:	ff d0                	call   *%eax
  800b38:	83 c4 10             	add    $0x10,%esp
			break;
  800b3b:	e9 89 02 00 00       	jmp    800dc9 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800b40:	8b 45 14             	mov    0x14(%ebp),%eax
  800b43:	83 c0 04             	add    $0x4,%eax
  800b46:	89 45 14             	mov    %eax,0x14(%ebp)
  800b49:	8b 45 14             	mov    0x14(%ebp),%eax
  800b4c:	83 e8 04             	sub    $0x4,%eax
  800b4f:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800b51:	85 db                	test   %ebx,%ebx
  800b53:	79 02                	jns    800b57 <vprintfmt+0x14a>
				err = -err;
  800b55:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800b57:	83 fb 64             	cmp    $0x64,%ebx
  800b5a:	7f 0b                	jg     800b67 <vprintfmt+0x15a>
  800b5c:	8b 34 9d 20 24 80 00 	mov    0x802420(,%ebx,4),%esi
  800b63:	85 f6                	test   %esi,%esi
  800b65:	75 19                	jne    800b80 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800b67:	53                   	push   %ebx
  800b68:	68 c5 25 80 00       	push   $0x8025c5
  800b6d:	ff 75 0c             	pushl  0xc(%ebp)
  800b70:	ff 75 08             	pushl  0x8(%ebp)
  800b73:	e8 5e 02 00 00       	call   800dd6 <printfmt>
  800b78:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800b7b:	e9 49 02 00 00       	jmp    800dc9 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800b80:	56                   	push   %esi
  800b81:	68 ce 25 80 00       	push   $0x8025ce
  800b86:	ff 75 0c             	pushl  0xc(%ebp)
  800b89:	ff 75 08             	pushl  0x8(%ebp)
  800b8c:	e8 45 02 00 00       	call   800dd6 <printfmt>
  800b91:	83 c4 10             	add    $0x10,%esp
			break;
  800b94:	e9 30 02 00 00       	jmp    800dc9 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800b99:	8b 45 14             	mov    0x14(%ebp),%eax
  800b9c:	83 c0 04             	add    $0x4,%eax
  800b9f:	89 45 14             	mov    %eax,0x14(%ebp)
  800ba2:	8b 45 14             	mov    0x14(%ebp),%eax
  800ba5:	83 e8 04             	sub    $0x4,%eax
  800ba8:	8b 30                	mov    (%eax),%esi
  800baa:	85 f6                	test   %esi,%esi
  800bac:	75 05                	jne    800bb3 <vprintfmt+0x1a6>
				p = "(null)";
  800bae:	be d1 25 80 00       	mov    $0x8025d1,%esi
			if (width > 0 && padc != '-')
  800bb3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bb7:	7e 6d                	jle    800c26 <vprintfmt+0x219>
  800bb9:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800bbd:	74 67                	je     800c26 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800bbf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800bc2:	83 ec 08             	sub    $0x8,%esp
  800bc5:	50                   	push   %eax
  800bc6:	56                   	push   %esi
  800bc7:	e8 0c 03 00 00       	call   800ed8 <strnlen>
  800bcc:	83 c4 10             	add    $0x10,%esp
  800bcf:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800bd2:	eb 16                	jmp    800bea <vprintfmt+0x1dd>
					putch(padc, putdat);
  800bd4:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800bd8:	83 ec 08             	sub    $0x8,%esp
  800bdb:	ff 75 0c             	pushl  0xc(%ebp)
  800bde:	50                   	push   %eax
  800bdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800be2:	ff d0                	call   *%eax
  800be4:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800be7:	ff 4d e4             	decl   -0x1c(%ebp)
  800bea:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bee:	7f e4                	jg     800bd4 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800bf0:	eb 34                	jmp    800c26 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800bf2:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800bf6:	74 1c                	je     800c14 <vprintfmt+0x207>
  800bf8:	83 fb 1f             	cmp    $0x1f,%ebx
  800bfb:	7e 05                	jle    800c02 <vprintfmt+0x1f5>
  800bfd:	83 fb 7e             	cmp    $0x7e,%ebx
  800c00:	7e 12                	jle    800c14 <vprintfmt+0x207>
					putch('?', putdat);
  800c02:	83 ec 08             	sub    $0x8,%esp
  800c05:	ff 75 0c             	pushl  0xc(%ebp)
  800c08:	6a 3f                	push   $0x3f
  800c0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0d:	ff d0                	call   *%eax
  800c0f:	83 c4 10             	add    $0x10,%esp
  800c12:	eb 0f                	jmp    800c23 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800c14:	83 ec 08             	sub    $0x8,%esp
  800c17:	ff 75 0c             	pushl  0xc(%ebp)
  800c1a:	53                   	push   %ebx
  800c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1e:	ff d0                	call   *%eax
  800c20:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800c23:	ff 4d e4             	decl   -0x1c(%ebp)
  800c26:	89 f0                	mov    %esi,%eax
  800c28:	8d 70 01             	lea    0x1(%eax),%esi
  800c2b:	8a 00                	mov    (%eax),%al
  800c2d:	0f be d8             	movsbl %al,%ebx
  800c30:	85 db                	test   %ebx,%ebx
  800c32:	74 24                	je     800c58 <vprintfmt+0x24b>
  800c34:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c38:	78 b8                	js     800bf2 <vprintfmt+0x1e5>
  800c3a:	ff 4d e0             	decl   -0x20(%ebp)
  800c3d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800c41:	79 af                	jns    800bf2 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c43:	eb 13                	jmp    800c58 <vprintfmt+0x24b>
				putch(' ', putdat);
  800c45:	83 ec 08             	sub    $0x8,%esp
  800c48:	ff 75 0c             	pushl  0xc(%ebp)
  800c4b:	6a 20                	push   $0x20
  800c4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c50:	ff d0                	call   *%eax
  800c52:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800c55:	ff 4d e4             	decl   -0x1c(%ebp)
  800c58:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c5c:	7f e7                	jg     800c45 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800c5e:	e9 66 01 00 00       	jmp    800dc9 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800c63:	83 ec 08             	sub    $0x8,%esp
  800c66:	ff 75 e8             	pushl  -0x18(%ebp)
  800c69:	8d 45 14             	lea    0x14(%ebp),%eax
  800c6c:	50                   	push   %eax
  800c6d:	e8 3c fd ff ff       	call   8009ae <getint>
  800c72:	83 c4 10             	add    $0x10,%esp
  800c75:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c78:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800c7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c7e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c81:	85 d2                	test   %edx,%edx
  800c83:	79 23                	jns    800ca8 <vprintfmt+0x29b>
				putch('-', putdat);
  800c85:	83 ec 08             	sub    $0x8,%esp
  800c88:	ff 75 0c             	pushl  0xc(%ebp)
  800c8b:	6a 2d                	push   $0x2d
  800c8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c90:	ff d0                	call   *%eax
  800c92:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800c95:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c98:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c9b:	f7 d8                	neg    %eax
  800c9d:	83 d2 00             	adc    $0x0,%edx
  800ca0:	f7 da                	neg    %edx
  800ca2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ca5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ca8:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800caf:	e9 bc 00 00 00       	jmp    800d70 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800cb4:	83 ec 08             	sub    $0x8,%esp
  800cb7:	ff 75 e8             	pushl  -0x18(%ebp)
  800cba:	8d 45 14             	lea    0x14(%ebp),%eax
  800cbd:	50                   	push   %eax
  800cbe:	e8 84 fc ff ff       	call   800947 <getuint>
  800cc3:	83 c4 10             	add    $0x10,%esp
  800cc6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cc9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ccc:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800cd3:	e9 98 00 00 00       	jmp    800d70 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800cd8:	83 ec 08             	sub    $0x8,%esp
  800cdb:	ff 75 0c             	pushl  0xc(%ebp)
  800cde:	6a 58                	push   $0x58
  800ce0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce3:	ff d0                	call   *%eax
  800ce5:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ce8:	83 ec 08             	sub    $0x8,%esp
  800ceb:	ff 75 0c             	pushl  0xc(%ebp)
  800cee:	6a 58                	push   $0x58
  800cf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf3:	ff d0                	call   *%eax
  800cf5:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800cf8:	83 ec 08             	sub    $0x8,%esp
  800cfb:	ff 75 0c             	pushl  0xc(%ebp)
  800cfe:	6a 58                	push   $0x58
  800d00:	8b 45 08             	mov    0x8(%ebp),%eax
  800d03:	ff d0                	call   *%eax
  800d05:	83 c4 10             	add    $0x10,%esp
			break;
  800d08:	e9 bc 00 00 00       	jmp    800dc9 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800d0d:	83 ec 08             	sub    $0x8,%esp
  800d10:	ff 75 0c             	pushl  0xc(%ebp)
  800d13:	6a 30                	push   $0x30
  800d15:	8b 45 08             	mov    0x8(%ebp),%eax
  800d18:	ff d0                	call   *%eax
  800d1a:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800d1d:	83 ec 08             	sub    $0x8,%esp
  800d20:	ff 75 0c             	pushl  0xc(%ebp)
  800d23:	6a 78                	push   $0x78
  800d25:	8b 45 08             	mov    0x8(%ebp),%eax
  800d28:	ff d0                	call   *%eax
  800d2a:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800d2d:	8b 45 14             	mov    0x14(%ebp),%eax
  800d30:	83 c0 04             	add    $0x4,%eax
  800d33:	89 45 14             	mov    %eax,0x14(%ebp)
  800d36:	8b 45 14             	mov    0x14(%ebp),%eax
  800d39:	83 e8 04             	sub    $0x4,%eax
  800d3c:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800d3e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d41:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800d48:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800d4f:	eb 1f                	jmp    800d70 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800d51:	83 ec 08             	sub    $0x8,%esp
  800d54:	ff 75 e8             	pushl  -0x18(%ebp)
  800d57:	8d 45 14             	lea    0x14(%ebp),%eax
  800d5a:	50                   	push   %eax
  800d5b:	e8 e7 fb ff ff       	call   800947 <getuint>
  800d60:	83 c4 10             	add    $0x10,%esp
  800d63:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d66:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800d69:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800d70:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800d74:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d77:	83 ec 04             	sub    $0x4,%esp
  800d7a:	52                   	push   %edx
  800d7b:	ff 75 e4             	pushl  -0x1c(%ebp)
  800d7e:	50                   	push   %eax
  800d7f:	ff 75 f4             	pushl  -0xc(%ebp)
  800d82:	ff 75 f0             	pushl  -0x10(%ebp)
  800d85:	ff 75 0c             	pushl  0xc(%ebp)
  800d88:	ff 75 08             	pushl  0x8(%ebp)
  800d8b:	e8 00 fb ff ff       	call   800890 <printnum>
  800d90:	83 c4 20             	add    $0x20,%esp
			break;
  800d93:	eb 34                	jmp    800dc9 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800d95:	83 ec 08             	sub    $0x8,%esp
  800d98:	ff 75 0c             	pushl  0xc(%ebp)
  800d9b:	53                   	push   %ebx
  800d9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9f:	ff d0                	call   *%eax
  800da1:	83 c4 10             	add    $0x10,%esp
			break;
  800da4:	eb 23                	jmp    800dc9 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800da6:	83 ec 08             	sub    $0x8,%esp
  800da9:	ff 75 0c             	pushl  0xc(%ebp)
  800dac:	6a 25                	push   $0x25
  800dae:	8b 45 08             	mov    0x8(%ebp),%eax
  800db1:	ff d0                	call   *%eax
  800db3:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800db6:	ff 4d 10             	decl   0x10(%ebp)
  800db9:	eb 03                	jmp    800dbe <vprintfmt+0x3b1>
  800dbb:	ff 4d 10             	decl   0x10(%ebp)
  800dbe:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc1:	48                   	dec    %eax
  800dc2:	8a 00                	mov    (%eax),%al
  800dc4:	3c 25                	cmp    $0x25,%al
  800dc6:	75 f3                	jne    800dbb <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800dc8:	90                   	nop
		}
	}
  800dc9:	e9 47 fc ff ff       	jmp    800a15 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800dce:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800dcf:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800dd2:	5b                   	pop    %ebx
  800dd3:	5e                   	pop    %esi
  800dd4:	5d                   	pop    %ebp
  800dd5:	c3                   	ret    

00800dd6 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800dd6:	55                   	push   %ebp
  800dd7:	89 e5                	mov    %esp,%ebp
  800dd9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ddc:	8d 45 10             	lea    0x10(%ebp),%eax
  800ddf:	83 c0 04             	add    $0x4,%eax
  800de2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800de5:	8b 45 10             	mov    0x10(%ebp),%eax
  800de8:	ff 75 f4             	pushl  -0xc(%ebp)
  800deb:	50                   	push   %eax
  800dec:	ff 75 0c             	pushl  0xc(%ebp)
  800def:	ff 75 08             	pushl  0x8(%ebp)
  800df2:	e8 16 fc ff ff       	call   800a0d <vprintfmt>
  800df7:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800dfa:	90                   	nop
  800dfb:	c9                   	leave  
  800dfc:	c3                   	ret    

00800dfd <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800dfd:	55                   	push   %ebp
  800dfe:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800e00:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e03:	8b 40 08             	mov    0x8(%eax),%eax
  800e06:	8d 50 01             	lea    0x1(%eax),%edx
  800e09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e0c:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800e0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e12:	8b 10                	mov    (%eax),%edx
  800e14:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e17:	8b 40 04             	mov    0x4(%eax),%eax
  800e1a:	39 c2                	cmp    %eax,%edx
  800e1c:	73 12                	jae    800e30 <sprintputch+0x33>
		*b->buf++ = ch;
  800e1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e21:	8b 00                	mov    (%eax),%eax
  800e23:	8d 48 01             	lea    0x1(%eax),%ecx
  800e26:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e29:	89 0a                	mov    %ecx,(%edx)
  800e2b:	8b 55 08             	mov    0x8(%ebp),%edx
  800e2e:	88 10                	mov    %dl,(%eax)
}
  800e30:	90                   	nop
  800e31:	5d                   	pop    %ebp
  800e32:	c3                   	ret    

00800e33 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800e33:	55                   	push   %ebp
  800e34:	89 e5                	mov    %esp,%ebp
  800e36:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800e39:	8b 45 08             	mov    0x8(%ebp),%eax
  800e3c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800e3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e42:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e45:	8b 45 08             	mov    0x8(%ebp),%eax
  800e48:	01 d0                	add    %edx,%eax
  800e4a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e4d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800e54:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e58:	74 06                	je     800e60 <vsnprintf+0x2d>
  800e5a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e5e:	7f 07                	jg     800e67 <vsnprintf+0x34>
		return -E_INVAL;
  800e60:	b8 03 00 00 00       	mov    $0x3,%eax
  800e65:	eb 20                	jmp    800e87 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800e67:	ff 75 14             	pushl  0x14(%ebp)
  800e6a:	ff 75 10             	pushl  0x10(%ebp)
  800e6d:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e70:	50                   	push   %eax
  800e71:	68 fd 0d 80 00       	push   $0x800dfd
  800e76:	e8 92 fb ff ff       	call   800a0d <vprintfmt>
  800e7b:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800e7e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e81:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800e84:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800e87:	c9                   	leave  
  800e88:	c3                   	ret    

00800e89 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800e89:	55                   	push   %ebp
  800e8a:	89 e5                	mov    %esp,%ebp
  800e8c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800e8f:	8d 45 10             	lea    0x10(%ebp),%eax
  800e92:	83 c0 04             	add    $0x4,%eax
  800e95:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800e98:	8b 45 10             	mov    0x10(%ebp),%eax
  800e9b:	ff 75 f4             	pushl  -0xc(%ebp)
  800e9e:	50                   	push   %eax
  800e9f:	ff 75 0c             	pushl  0xc(%ebp)
  800ea2:	ff 75 08             	pushl  0x8(%ebp)
  800ea5:	e8 89 ff ff ff       	call   800e33 <vsnprintf>
  800eaa:	83 c4 10             	add    $0x10,%esp
  800ead:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800eb0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800eb3:	c9                   	leave  
  800eb4:	c3                   	ret    

00800eb5 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800eb5:	55                   	push   %ebp
  800eb6:	89 e5                	mov    %esp,%ebp
  800eb8:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800ebb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ec2:	eb 06                	jmp    800eca <strlen+0x15>
		n++;
  800ec4:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800ec7:	ff 45 08             	incl   0x8(%ebp)
  800eca:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecd:	8a 00                	mov    (%eax),%al
  800ecf:	84 c0                	test   %al,%al
  800ed1:	75 f1                	jne    800ec4 <strlen+0xf>
		n++;
	return n;
  800ed3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ed6:	c9                   	leave  
  800ed7:	c3                   	ret    

00800ed8 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ed8:	55                   	push   %ebp
  800ed9:	89 e5                	mov    %esp,%ebp
  800edb:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ede:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ee5:	eb 09                	jmp    800ef0 <strnlen+0x18>
		n++;
  800ee7:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800eea:	ff 45 08             	incl   0x8(%ebp)
  800eed:	ff 4d 0c             	decl   0xc(%ebp)
  800ef0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ef4:	74 09                	je     800eff <strnlen+0x27>
  800ef6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef9:	8a 00                	mov    (%eax),%al
  800efb:	84 c0                	test   %al,%al
  800efd:	75 e8                	jne    800ee7 <strnlen+0xf>
		n++;
	return n;
  800eff:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f02:	c9                   	leave  
  800f03:	c3                   	ret    

00800f04 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800f04:	55                   	push   %ebp
  800f05:	89 e5                	mov    %esp,%ebp
  800f07:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800f0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800f10:	90                   	nop
  800f11:	8b 45 08             	mov    0x8(%ebp),%eax
  800f14:	8d 50 01             	lea    0x1(%eax),%edx
  800f17:	89 55 08             	mov    %edx,0x8(%ebp)
  800f1a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f1d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f20:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f23:	8a 12                	mov    (%edx),%dl
  800f25:	88 10                	mov    %dl,(%eax)
  800f27:	8a 00                	mov    (%eax),%al
  800f29:	84 c0                	test   %al,%al
  800f2b:	75 e4                	jne    800f11 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800f2d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800f30:	c9                   	leave  
  800f31:	c3                   	ret    

00800f32 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800f32:	55                   	push   %ebp
  800f33:	89 e5                	mov    %esp,%ebp
  800f35:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800f38:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800f3e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f45:	eb 1f                	jmp    800f66 <strncpy+0x34>
		*dst++ = *src;
  800f47:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4a:	8d 50 01             	lea    0x1(%eax),%edx
  800f4d:	89 55 08             	mov    %edx,0x8(%ebp)
  800f50:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f53:	8a 12                	mov    (%edx),%dl
  800f55:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800f57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5a:	8a 00                	mov    (%eax),%al
  800f5c:	84 c0                	test   %al,%al
  800f5e:	74 03                	je     800f63 <strncpy+0x31>
			src++;
  800f60:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800f63:	ff 45 fc             	incl   -0x4(%ebp)
  800f66:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f69:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f6c:	72 d9                	jb     800f47 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800f6e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f71:	c9                   	leave  
  800f72:	c3                   	ret    

00800f73 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800f73:	55                   	push   %ebp
  800f74:	89 e5                	mov    %esp,%ebp
  800f76:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800f79:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800f7f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f83:	74 30                	je     800fb5 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800f85:	eb 16                	jmp    800f9d <strlcpy+0x2a>
			*dst++ = *src++;
  800f87:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8a:	8d 50 01             	lea    0x1(%eax),%edx
  800f8d:	89 55 08             	mov    %edx,0x8(%ebp)
  800f90:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f93:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f96:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f99:	8a 12                	mov    (%edx),%dl
  800f9b:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800f9d:	ff 4d 10             	decl   0x10(%ebp)
  800fa0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa4:	74 09                	je     800faf <strlcpy+0x3c>
  800fa6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa9:	8a 00                	mov    (%eax),%al
  800fab:	84 c0                	test   %al,%al
  800fad:	75 d8                	jne    800f87 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800faf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb2:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800fb5:	8b 55 08             	mov    0x8(%ebp),%edx
  800fb8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fbb:	29 c2                	sub    %eax,%edx
  800fbd:	89 d0                	mov    %edx,%eax
}
  800fbf:	c9                   	leave  
  800fc0:	c3                   	ret    

00800fc1 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800fc1:	55                   	push   %ebp
  800fc2:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800fc4:	eb 06                	jmp    800fcc <strcmp+0xb>
		p++, q++;
  800fc6:	ff 45 08             	incl   0x8(%ebp)
  800fc9:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800fcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcf:	8a 00                	mov    (%eax),%al
  800fd1:	84 c0                	test   %al,%al
  800fd3:	74 0e                	je     800fe3 <strcmp+0x22>
  800fd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd8:	8a 10                	mov    (%eax),%dl
  800fda:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fdd:	8a 00                	mov    (%eax),%al
  800fdf:	38 c2                	cmp    %al,%dl
  800fe1:	74 e3                	je     800fc6 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800fe3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe6:	8a 00                	mov    (%eax),%al
  800fe8:	0f b6 d0             	movzbl %al,%edx
  800feb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fee:	8a 00                	mov    (%eax),%al
  800ff0:	0f b6 c0             	movzbl %al,%eax
  800ff3:	29 c2                	sub    %eax,%edx
  800ff5:	89 d0                	mov    %edx,%eax
}
  800ff7:	5d                   	pop    %ebp
  800ff8:	c3                   	ret    

00800ff9 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ff9:	55                   	push   %ebp
  800ffa:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ffc:	eb 09                	jmp    801007 <strncmp+0xe>
		n--, p++, q++;
  800ffe:	ff 4d 10             	decl   0x10(%ebp)
  801001:	ff 45 08             	incl   0x8(%ebp)
  801004:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801007:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80100b:	74 17                	je     801024 <strncmp+0x2b>
  80100d:	8b 45 08             	mov    0x8(%ebp),%eax
  801010:	8a 00                	mov    (%eax),%al
  801012:	84 c0                	test   %al,%al
  801014:	74 0e                	je     801024 <strncmp+0x2b>
  801016:	8b 45 08             	mov    0x8(%ebp),%eax
  801019:	8a 10                	mov    (%eax),%dl
  80101b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80101e:	8a 00                	mov    (%eax),%al
  801020:	38 c2                	cmp    %al,%dl
  801022:	74 da                	je     800ffe <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801024:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801028:	75 07                	jne    801031 <strncmp+0x38>
		return 0;
  80102a:	b8 00 00 00 00       	mov    $0x0,%eax
  80102f:	eb 14                	jmp    801045 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801031:	8b 45 08             	mov    0x8(%ebp),%eax
  801034:	8a 00                	mov    (%eax),%al
  801036:	0f b6 d0             	movzbl %al,%edx
  801039:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103c:	8a 00                	mov    (%eax),%al
  80103e:	0f b6 c0             	movzbl %al,%eax
  801041:	29 c2                	sub    %eax,%edx
  801043:	89 d0                	mov    %edx,%eax
}
  801045:	5d                   	pop    %ebp
  801046:	c3                   	ret    

00801047 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801047:	55                   	push   %ebp
  801048:	89 e5                	mov    %esp,%ebp
  80104a:	83 ec 04             	sub    $0x4,%esp
  80104d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801050:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801053:	eb 12                	jmp    801067 <strchr+0x20>
		if (*s == c)
  801055:	8b 45 08             	mov    0x8(%ebp),%eax
  801058:	8a 00                	mov    (%eax),%al
  80105a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80105d:	75 05                	jne    801064 <strchr+0x1d>
			return (char *) s;
  80105f:	8b 45 08             	mov    0x8(%ebp),%eax
  801062:	eb 11                	jmp    801075 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801064:	ff 45 08             	incl   0x8(%ebp)
  801067:	8b 45 08             	mov    0x8(%ebp),%eax
  80106a:	8a 00                	mov    (%eax),%al
  80106c:	84 c0                	test   %al,%al
  80106e:	75 e5                	jne    801055 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801070:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801075:	c9                   	leave  
  801076:	c3                   	ret    

00801077 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801077:	55                   	push   %ebp
  801078:	89 e5                	mov    %esp,%ebp
  80107a:	83 ec 04             	sub    $0x4,%esp
  80107d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801080:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801083:	eb 0d                	jmp    801092 <strfind+0x1b>
		if (*s == c)
  801085:	8b 45 08             	mov    0x8(%ebp),%eax
  801088:	8a 00                	mov    (%eax),%al
  80108a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80108d:	74 0e                	je     80109d <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80108f:	ff 45 08             	incl   0x8(%ebp)
  801092:	8b 45 08             	mov    0x8(%ebp),%eax
  801095:	8a 00                	mov    (%eax),%al
  801097:	84 c0                	test   %al,%al
  801099:	75 ea                	jne    801085 <strfind+0xe>
  80109b:	eb 01                	jmp    80109e <strfind+0x27>
		if (*s == c)
			break;
  80109d:	90                   	nop
	return (char *) s;
  80109e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010a1:	c9                   	leave  
  8010a2:	c3                   	ret    

008010a3 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8010a3:	55                   	push   %ebp
  8010a4:	89 e5                	mov    %esp,%ebp
  8010a6:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8010a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8010af:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8010b5:	eb 0e                	jmp    8010c5 <memset+0x22>
		*p++ = c;
  8010b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ba:	8d 50 01             	lea    0x1(%eax),%edx
  8010bd:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8010c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010c3:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8010c5:	ff 4d f8             	decl   -0x8(%ebp)
  8010c8:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8010cc:	79 e9                	jns    8010b7 <memset+0x14>
		*p++ = c;

	return v;
  8010ce:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010d1:	c9                   	leave  
  8010d2:	c3                   	ret    

008010d3 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8010d3:	55                   	push   %ebp
  8010d4:	89 e5                	mov    %esp,%ebp
  8010d6:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8010d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010dc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8010df:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8010e5:	eb 16                	jmp    8010fd <memcpy+0x2a>
		*d++ = *s++;
  8010e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ea:	8d 50 01             	lea    0x1(%eax),%edx
  8010ed:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010f0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010f3:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010f6:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010f9:	8a 12                	mov    (%edx),%dl
  8010fb:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8010fd:	8b 45 10             	mov    0x10(%ebp),%eax
  801100:	8d 50 ff             	lea    -0x1(%eax),%edx
  801103:	89 55 10             	mov    %edx,0x10(%ebp)
  801106:	85 c0                	test   %eax,%eax
  801108:	75 dd                	jne    8010e7 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80110a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80110d:	c9                   	leave  
  80110e:	c3                   	ret    

0080110f <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80110f:	55                   	push   %ebp
  801110:	89 e5                	mov    %esp,%ebp
  801112:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801115:	8b 45 0c             	mov    0xc(%ebp),%eax
  801118:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80111b:	8b 45 08             	mov    0x8(%ebp),%eax
  80111e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801121:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801124:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801127:	73 50                	jae    801179 <memmove+0x6a>
  801129:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80112c:	8b 45 10             	mov    0x10(%ebp),%eax
  80112f:	01 d0                	add    %edx,%eax
  801131:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801134:	76 43                	jbe    801179 <memmove+0x6a>
		s += n;
  801136:	8b 45 10             	mov    0x10(%ebp),%eax
  801139:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80113c:	8b 45 10             	mov    0x10(%ebp),%eax
  80113f:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801142:	eb 10                	jmp    801154 <memmove+0x45>
			*--d = *--s;
  801144:	ff 4d f8             	decl   -0x8(%ebp)
  801147:	ff 4d fc             	decl   -0x4(%ebp)
  80114a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80114d:	8a 10                	mov    (%eax),%dl
  80114f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801152:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801154:	8b 45 10             	mov    0x10(%ebp),%eax
  801157:	8d 50 ff             	lea    -0x1(%eax),%edx
  80115a:	89 55 10             	mov    %edx,0x10(%ebp)
  80115d:	85 c0                	test   %eax,%eax
  80115f:	75 e3                	jne    801144 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801161:	eb 23                	jmp    801186 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801163:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801166:	8d 50 01             	lea    0x1(%eax),%edx
  801169:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80116c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80116f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801172:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801175:	8a 12                	mov    (%edx),%dl
  801177:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801179:	8b 45 10             	mov    0x10(%ebp),%eax
  80117c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80117f:	89 55 10             	mov    %edx,0x10(%ebp)
  801182:	85 c0                	test   %eax,%eax
  801184:	75 dd                	jne    801163 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801186:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801189:	c9                   	leave  
  80118a:	c3                   	ret    

0080118b <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80118b:	55                   	push   %ebp
  80118c:	89 e5                	mov    %esp,%ebp
  80118e:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801191:	8b 45 08             	mov    0x8(%ebp),%eax
  801194:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801197:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119a:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80119d:	eb 2a                	jmp    8011c9 <memcmp+0x3e>
		if (*s1 != *s2)
  80119f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011a2:	8a 10                	mov    (%eax),%dl
  8011a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011a7:	8a 00                	mov    (%eax),%al
  8011a9:	38 c2                	cmp    %al,%dl
  8011ab:	74 16                	je     8011c3 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8011ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011b0:	8a 00                	mov    (%eax),%al
  8011b2:	0f b6 d0             	movzbl %al,%edx
  8011b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011b8:	8a 00                	mov    (%eax),%al
  8011ba:	0f b6 c0             	movzbl %al,%eax
  8011bd:	29 c2                	sub    %eax,%edx
  8011bf:	89 d0                	mov    %edx,%eax
  8011c1:	eb 18                	jmp    8011db <memcmp+0x50>
		s1++, s2++;
  8011c3:	ff 45 fc             	incl   -0x4(%ebp)
  8011c6:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8011c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8011cc:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011cf:	89 55 10             	mov    %edx,0x10(%ebp)
  8011d2:	85 c0                	test   %eax,%eax
  8011d4:	75 c9                	jne    80119f <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8011d6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011db:	c9                   	leave  
  8011dc:	c3                   	ret    

008011dd <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8011dd:	55                   	push   %ebp
  8011de:	89 e5                	mov    %esp,%ebp
  8011e0:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8011e3:	8b 55 08             	mov    0x8(%ebp),%edx
  8011e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e9:	01 d0                	add    %edx,%eax
  8011eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8011ee:	eb 15                	jmp    801205 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8011f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f3:	8a 00                	mov    (%eax),%al
  8011f5:	0f b6 d0             	movzbl %al,%edx
  8011f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011fb:	0f b6 c0             	movzbl %al,%eax
  8011fe:	39 c2                	cmp    %eax,%edx
  801200:	74 0d                	je     80120f <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801202:	ff 45 08             	incl   0x8(%ebp)
  801205:	8b 45 08             	mov    0x8(%ebp),%eax
  801208:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80120b:	72 e3                	jb     8011f0 <memfind+0x13>
  80120d:	eb 01                	jmp    801210 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80120f:	90                   	nop
	return (void *) s;
  801210:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801213:	c9                   	leave  
  801214:	c3                   	ret    

00801215 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801215:	55                   	push   %ebp
  801216:	89 e5                	mov    %esp,%ebp
  801218:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80121b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801222:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801229:	eb 03                	jmp    80122e <strtol+0x19>
		s++;
  80122b:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80122e:	8b 45 08             	mov    0x8(%ebp),%eax
  801231:	8a 00                	mov    (%eax),%al
  801233:	3c 20                	cmp    $0x20,%al
  801235:	74 f4                	je     80122b <strtol+0x16>
  801237:	8b 45 08             	mov    0x8(%ebp),%eax
  80123a:	8a 00                	mov    (%eax),%al
  80123c:	3c 09                	cmp    $0x9,%al
  80123e:	74 eb                	je     80122b <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801240:	8b 45 08             	mov    0x8(%ebp),%eax
  801243:	8a 00                	mov    (%eax),%al
  801245:	3c 2b                	cmp    $0x2b,%al
  801247:	75 05                	jne    80124e <strtol+0x39>
		s++;
  801249:	ff 45 08             	incl   0x8(%ebp)
  80124c:	eb 13                	jmp    801261 <strtol+0x4c>
	else if (*s == '-')
  80124e:	8b 45 08             	mov    0x8(%ebp),%eax
  801251:	8a 00                	mov    (%eax),%al
  801253:	3c 2d                	cmp    $0x2d,%al
  801255:	75 0a                	jne    801261 <strtol+0x4c>
		s++, neg = 1;
  801257:	ff 45 08             	incl   0x8(%ebp)
  80125a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801261:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801265:	74 06                	je     80126d <strtol+0x58>
  801267:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80126b:	75 20                	jne    80128d <strtol+0x78>
  80126d:	8b 45 08             	mov    0x8(%ebp),%eax
  801270:	8a 00                	mov    (%eax),%al
  801272:	3c 30                	cmp    $0x30,%al
  801274:	75 17                	jne    80128d <strtol+0x78>
  801276:	8b 45 08             	mov    0x8(%ebp),%eax
  801279:	40                   	inc    %eax
  80127a:	8a 00                	mov    (%eax),%al
  80127c:	3c 78                	cmp    $0x78,%al
  80127e:	75 0d                	jne    80128d <strtol+0x78>
		s += 2, base = 16;
  801280:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801284:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80128b:	eb 28                	jmp    8012b5 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80128d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801291:	75 15                	jne    8012a8 <strtol+0x93>
  801293:	8b 45 08             	mov    0x8(%ebp),%eax
  801296:	8a 00                	mov    (%eax),%al
  801298:	3c 30                	cmp    $0x30,%al
  80129a:	75 0c                	jne    8012a8 <strtol+0x93>
		s++, base = 8;
  80129c:	ff 45 08             	incl   0x8(%ebp)
  80129f:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8012a6:	eb 0d                	jmp    8012b5 <strtol+0xa0>
	else if (base == 0)
  8012a8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8012ac:	75 07                	jne    8012b5 <strtol+0xa0>
		base = 10;
  8012ae:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8012b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b8:	8a 00                	mov    (%eax),%al
  8012ba:	3c 2f                	cmp    $0x2f,%al
  8012bc:	7e 19                	jle    8012d7 <strtol+0xc2>
  8012be:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c1:	8a 00                	mov    (%eax),%al
  8012c3:	3c 39                	cmp    $0x39,%al
  8012c5:	7f 10                	jg     8012d7 <strtol+0xc2>
			dig = *s - '0';
  8012c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ca:	8a 00                	mov    (%eax),%al
  8012cc:	0f be c0             	movsbl %al,%eax
  8012cf:	83 e8 30             	sub    $0x30,%eax
  8012d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8012d5:	eb 42                	jmp    801319 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8012d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012da:	8a 00                	mov    (%eax),%al
  8012dc:	3c 60                	cmp    $0x60,%al
  8012de:	7e 19                	jle    8012f9 <strtol+0xe4>
  8012e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e3:	8a 00                	mov    (%eax),%al
  8012e5:	3c 7a                	cmp    $0x7a,%al
  8012e7:	7f 10                	jg     8012f9 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8012e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ec:	8a 00                	mov    (%eax),%al
  8012ee:	0f be c0             	movsbl %al,%eax
  8012f1:	83 e8 57             	sub    $0x57,%eax
  8012f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8012f7:	eb 20                	jmp    801319 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8012f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fc:	8a 00                	mov    (%eax),%al
  8012fe:	3c 40                	cmp    $0x40,%al
  801300:	7e 39                	jle    80133b <strtol+0x126>
  801302:	8b 45 08             	mov    0x8(%ebp),%eax
  801305:	8a 00                	mov    (%eax),%al
  801307:	3c 5a                	cmp    $0x5a,%al
  801309:	7f 30                	jg     80133b <strtol+0x126>
			dig = *s - 'A' + 10;
  80130b:	8b 45 08             	mov    0x8(%ebp),%eax
  80130e:	8a 00                	mov    (%eax),%al
  801310:	0f be c0             	movsbl %al,%eax
  801313:	83 e8 37             	sub    $0x37,%eax
  801316:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801319:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80131c:	3b 45 10             	cmp    0x10(%ebp),%eax
  80131f:	7d 19                	jge    80133a <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801321:	ff 45 08             	incl   0x8(%ebp)
  801324:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801327:	0f af 45 10          	imul   0x10(%ebp),%eax
  80132b:	89 c2                	mov    %eax,%edx
  80132d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801330:	01 d0                	add    %edx,%eax
  801332:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801335:	e9 7b ff ff ff       	jmp    8012b5 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80133a:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80133b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80133f:	74 08                	je     801349 <strtol+0x134>
		*endptr = (char *) s;
  801341:	8b 45 0c             	mov    0xc(%ebp),%eax
  801344:	8b 55 08             	mov    0x8(%ebp),%edx
  801347:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801349:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80134d:	74 07                	je     801356 <strtol+0x141>
  80134f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801352:	f7 d8                	neg    %eax
  801354:	eb 03                	jmp    801359 <strtol+0x144>
  801356:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801359:	c9                   	leave  
  80135a:	c3                   	ret    

0080135b <ltostr>:

void
ltostr(long value, char *str)
{
  80135b:	55                   	push   %ebp
  80135c:	89 e5                	mov    %esp,%ebp
  80135e:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801361:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801368:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80136f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801373:	79 13                	jns    801388 <ltostr+0x2d>
	{
		neg = 1;
  801375:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80137c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137f:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801382:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801385:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801388:	8b 45 08             	mov    0x8(%ebp),%eax
  80138b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801390:	99                   	cltd   
  801391:	f7 f9                	idiv   %ecx
  801393:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801396:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801399:	8d 50 01             	lea    0x1(%eax),%edx
  80139c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80139f:	89 c2                	mov    %eax,%edx
  8013a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a4:	01 d0                	add    %edx,%eax
  8013a6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013a9:	83 c2 30             	add    $0x30,%edx
  8013ac:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8013ae:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8013b1:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8013b6:	f7 e9                	imul   %ecx
  8013b8:	c1 fa 02             	sar    $0x2,%edx
  8013bb:	89 c8                	mov    %ecx,%eax
  8013bd:	c1 f8 1f             	sar    $0x1f,%eax
  8013c0:	29 c2                	sub    %eax,%edx
  8013c2:	89 d0                	mov    %edx,%eax
  8013c4:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8013c7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8013ca:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8013cf:	f7 e9                	imul   %ecx
  8013d1:	c1 fa 02             	sar    $0x2,%edx
  8013d4:	89 c8                	mov    %ecx,%eax
  8013d6:	c1 f8 1f             	sar    $0x1f,%eax
  8013d9:	29 c2                	sub    %eax,%edx
  8013db:	89 d0                	mov    %edx,%eax
  8013dd:	c1 e0 02             	shl    $0x2,%eax
  8013e0:	01 d0                	add    %edx,%eax
  8013e2:	01 c0                	add    %eax,%eax
  8013e4:	29 c1                	sub    %eax,%ecx
  8013e6:	89 ca                	mov    %ecx,%edx
  8013e8:	85 d2                	test   %edx,%edx
  8013ea:	75 9c                	jne    801388 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8013ec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8013f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013f6:	48                   	dec    %eax
  8013f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8013fa:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8013fe:	74 3d                	je     80143d <ltostr+0xe2>
		start = 1 ;
  801400:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801407:	eb 34                	jmp    80143d <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801409:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80140c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80140f:	01 d0                	add    %edx,%eax
  801411:	8a 00                	mov    (%eax),%al
  801413:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801416:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801419:	8b 45 0c             	mov    0xc(%ebp),%eax
  80141c:	01 c2                	add    %eax,%edx
  80141e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801421:	8b 45 0c             	mov    0xc(%ebp),%eax
  801424:	01 c8                	add    %ecx,%eax
  801426:	8a 00                	mov    (%eax),%al
  801428:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80142a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80142d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801430:	01 c2                	add    %eax,%edx
  801432:	8a 45 eb             	mov    -0x15(%ebp),%al
  801435:	88 02                	mov    %al,(%edx)
		start++ ;
  801437:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80143a:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80143d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801440:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801443:	7c c4                	jl     801409 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801445:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801448:	8b 45 0c             	mov    0xc(%ebp),%eax
  80144b:	01 d0                	add    %edx,%eax
  80144d:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801450:	90                   	nop
  801451:	c9                   	leave  
  801452:	c3                   	ret    

00801453 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801453:	55                   	push   %ebp
  801454:	89 e5                	mov    %esp,%ebp
  801456:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801459:	ff 75 08             	pushl  0x8(%ebp)
  80145c:	e8 54 fa ff ff       	call   800eb5 <strlen>
  801461:	83 c4 04             	add    $0x4,%esp
  801464:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801467:	ff 75 0c             	pushl  0xc(%ebp)
  80146a:	e8 46 fa ff ff       	call   800eb5 <strlen>
  80146f:	83 c4 04             	add    $0x4,%esp
  801472:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801475:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80147c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801483:	eb 17                	jmp    80149c <strcconcat+0x49>
		final[s] = str1[s] ;
  801485:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801488:	8b 45 10             	mov    0x10(%ebp),%eax
  80148b:	01 c2                	add    %eax,%edx
  80148d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801490:	8b 45 08             	mov    0x8(%ebp),%eax
  801493:	01 c8                	add    %ecx,%eax
  801495:	8a 00                	mov    (%eax),%al
  801497:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801499:	ff 45 fc             	incl   -0x4(%ebp)
  80149c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80149f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8014a2:	7c e1                	jl     801485 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8014a4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8014ab:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8014b2:	eb 1f                	jmp    8014d3 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8014b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014b7:	8d 50 01             	lea    0x1(%eax),%edx
  8014ba:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014bd:	89 c2                	mov    %eax,%edx
  8014bf:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c2:	01 c2                	add    %eax,%edx
  8014c4:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8014c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ca:	01 c8                	add    %ecx,%eax
  8014cc:	8a 00                	mov    (%eax),%al
  8014ce:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8014d0:	ff 45 f8             	incl   -0x8(%ebp)
  8014d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014d6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8014d9:	7c d9                	jl     8014b4 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8014db:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014de:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e1:	01 d0                	add    %edx,%eax
  8014e3:	c6 00 00             	movb   $0x0,(%eax)
}
  8014e6:	90                   	nop
  8014e7:	c9                   	leave  
  8014e8:	c3                   	ret    

008014e9 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8014e9:	55                   	push   %ebp
  8014ea:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8014ec:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ef:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8014f5:	8b 45 14             	mov    0x14(%ebp),%eax
  8014f8:	8b 00                	mov    (%eax),%eax
  8014fa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801501:	8b 45 10             	mov    0x10(%ebp),%eax
  801504:	01 d0                	add    %edx,%eax
  801506:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80150c:	eb 0c                	jmp    80151a <strsplit+0x31>
			*string++ = 0;
  80150e:	8b 45 08             	mov    0x8(%ebp),%eax
  801511:	8d 50 01             	lea    0x1(%eax),%edx
  801514:	89 55 08             	mov    %edx,0x8(%ebp)
  801517:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80151a:	8b 45 08             	mov    0x8(%ebp),%eax
  80151d:	8a 00                	mov    (%eax),%al
  80151f:	84 c0                	test   %al,%al
  801521:	74 18                	je     80153b <strsplit+0x52>
  801523:	8b 45 08             	mov    0x8(%ebp),%eax
  801526:	8a 00                	mov    (%eax),%al
  801528:	0f be c0             	movsbl %al,%eax
  80152b:	50                   	push   %eax
  80152c:	ff 75 0c             	pushl  0xc(%ebp)
  80152f:	e8 13 fb ff ff       	call   801047 <strchr>
  801534:	83 c4 08             	add    $0x8,%esp
  801537:	85 c0                	test   %eax,%eax
  801539:	75 d3                	jne    80150e <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80153b:	8b 45 08             	mov    0x8(%ebp),%eax
  80153e:	8a 00                	mov    (%eax),%al
  801540:	84 c0                	test   %al,%al
  801542:	74 5a                	je     80159e <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801544:	8b 45 14             	mov    0x14(%ebp),%eax
  801547:	8b 00                	mov    (%eax),%eax
  801549:	83 f8 0f             	cmp    $0xf,%eax
  80154c:	75 07                	jne    801555 <strsplit+0x6c>
		{
			return 0;
  80154e:	b8 00 00 00 00       	mov    $0x0,%eax
  801553:	eb 66                	jmp    8015bb <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801555:	8b 45 14             	mov    0x14(%ebp),%eax
  801558:	8b 00                	mov    (%eax),%eax
  80155a:	8d 48 01             	lea    0x1(%eax),%ecx
  80155d:	8b 55 14             	mov    0x14(%ebp),%edx
  801560:	89 0a                	mov    %ecx,(%edx)
  801562:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801569:	8b 45 10             	mov    0x10(%ebp),%eax
  80156c:	01 c2                	add    %eax,%edx
  80156e:	8b 45 08             	mov    0x8(%ebp),%eax
  801571:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801573:	eb 03                	jmp    801578 <strsplit+0x8f>
			string++;
  801575:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801578:	8b 45 08             	mov    0x8(%ebp),%eax
  80157b:	8a 00                	mov    (%eax),%al
  80157d:	84 c0                	test   %al,%al
  80157f:	74 8b                	je     80150c <strsplit+0x23>
  801581:	8b 45 08             	mov    0x8(%ebp),%eax
  801584:	8a 00                	mov    (%eax),%al
  801586:	0f be c0             	movsbl %al,%eax
  801589:	50                   	push   %eax
  80158a:	ff 75 0c             	pushl  0xc(%ebp)
  80158d:	e8 b5 fa ff ff       	call   801047 <strchr>
  801592:	83 c4 08             	add    $0x8,%esp
  801595:	85 c0                	test   %eax,%eax
  801597:	74 dc                	je     801575 <strsplit+0x8c>
			string++;
	}
  801599:	e9 6e ff ff ff       	jmp    80150c <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80159e:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80159f:	8b 45 14             	mov    0x14(%ebp),%eax
  8015a2:	8b 00                	mov    (%eax),%eax
  8015a4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8015ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ae:	01 d0                	add    %edx,%eax
  8015b0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8015b6:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8015bb:	c9                   	leave  
  8015bc:	c3                   	ret    

008015bd <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8015bd:	55                   	push   %ebp
  8015be:	89 e5                	mov    %esp,%ebp
  8015c0:	57                   	push   %edi
  8015c1:	56                   	push   %esi
  8015c2:	53                   	push   %ebx
  8015c3:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8015c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015cc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015cf:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015d2:	8b 7d 18             	mov    0x18(%ebp),%edi
  8015d5:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8015d8:	cd 30                	int    $0x30
  8015da:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8015dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8015e0:	83 c4 10             	add    $0x10,%esp
  8015e3:	5b                   	pop    %ebx
  8015e4:	5e                   	pop    %esi
  8015e5:	5f                   	pop    %edi
  8015e6:	5d                   	pop    %ebp
  8015e7:	c3                   	ret    

008015e8 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8015e8:	55                   	push   %ebp
  8015e9:	89 e5                	mov    %esp,%ebp
  8015eb:	83 ec 04             	sub    $0x4,%esp
  8015ee:	8b 45 10             	mov    0x10(%ebp),%eax
  8015f1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8015f4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	52                   	push   %edx
  801600:	ff 75 0c             	pushl  0xc(%ebp)
  801603:	50                   	push   %eax
  801604:	6a 00                	push   $0x0
  801606:	e8 b2 ff ff ff       	call   8015bd <syscall>
  80160b:	83 c4 18             	add    $0x18,%esp
}
  80160e:	90                   	nop
  80160f:	c9                   	leave  
  801610:	c3                   	ret    

00801611 <sys_cgetc>:

int
sys_cgetc(void)
{
  801611:	55                   	push   %ebp
  801612:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801614:	6a 00                	push   $0x0
  801616:	6a 00                	push   $0x0
  801618:	6a 00                	push   $0x0
  80161a:	6a 00                	push   $0x0
  80161c:	6a 00                	push   $0x0
  80161e:	6a 01                	push   $0x1
  801620:	e8 98 ff ff ff       	call   8015bd <syscall>
  801625:	83 c4 18             	add    $0x18,%esp
}
  801628:	c9                   	leave  
  801629:	c3                   	ret    

0080162a <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80162a:	55                   	push   %ebp
  80162b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80162d:	8b 45 08             	mov    0x8(%ebp),%eax
  801630:	6a 00                	push   $0x0
  801632:	6a 00                	push   $0x0
  801634:	6a 00                	push   $0x0
  801636:	6a 00                	push   $0x0
  801638:	50                   	push   %eax
  801639:	6a 05                	push   $0x5
  80163b:	e8 7d ff ff ff       	call   8015bd <syscall>
  801640:	83 c4 18             	add    $0x18,%esp
}
  801643:	c9                   	leave  
  801644:	c3                   	ret    

00801645 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801645:	55                   	push   %ebp
  801646:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	6a 00                	push   $0x0
  80164e:	6a 00                	push   $0x0
  801650:	6a 00                	push   $0x0
  801652:	6a 02                	push   $0x2
  801654:	e8 64 ff ff ff       	call   8015bd <syscall>
  801659:	83 c4 18             	add    $0x18,%esp
}
  80165c:	c9                   	leave  
  80165d:	c3                   	ret    

0080165e <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80165e:	55                   	push   %ebp
  80165f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801661:	6a 00                	push   $0x0
  801663:	6a 00                	push   $0x0
  801665:	6a 00                	push   $0x0
  801667:	6a 00                	push   $0x0
  801669:	6a 00                	push   $0x0
  80166b:	6a 03                	push   $0x3
  80166d:	e8 4b ff ff ff       	call   8015bd <syscall>
  801672:	83 c4 18             	add    $0x18,%esp
}
  801675:	c9                   	leave  
  801676:	c3                   	ret    

00801677 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801677:	55                   	push   %ebp
  801678:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80167a:	6a 00                	push   $0x0
  80167c:	6a 00                	push   $0x0
  80167e:	6a 00                	push   $0x0
  801680:	6a 00                	push   $0x0
  801682:	6a 00                	push   $0x0
  801684:	6a 04                	push   $0x4
  801686:	e8 32 ff ff ff       	call   8015bd <syscall>
  80168b:	83 c4 18             	add    $0x18,%esp
}
  80168e:	c9                   	leave  
  80168f:	c3                   	ret    

00801690 <sys_env_exit>:


void sys_env_exit(void)
{
  801690:	55                   	push   %ebp
  801691:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801693:	6a 00                	push   $0x0
  801695:	6a 00                	push   $0x0
  801697:	6a 00                	push   $0x0
  801699:	6a 00                	push   $0x0
  80169b:	6a 00                	push   $0x0
  80169d:	6a 06                	push   $0x6
  80169f:	e8 19 ff ff ff       	call   8015bd <syscall>
  8016a4:	83 c4 18             	add    $0x18,%esp
}
  8016a7:	90                   	nop
  8016a8:	c9                   	leave  
  8016a9:	c3                   	ret    

008016aa <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8016aa:	55                   	push   %ebp
  8016ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8016ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b3:	6a 00                	push   $0x0
  8016b5:	6a 00                	push   $0x0
  8016b7:	6a 00                	push   $0x0
  8016b9:	52                   	push   %edx
  8016ba:	50                   	push   %eax
  8016bb:	6a 07                	push   $0x7
  8016bd:	e8 fb fe ff ff       	call   8015bd <syscall>
  8016c2:	83 c4 18             	add    $0x18,%esp
}
  8016c5:	c9                   	leave  
  8016c6:	c3                   	ret    

008016c7 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8016c7:	55                   	push   %ebp
  8016c8:	89 e5                	mov    %esp,%ebp
  8016ca:	56                   	push   %esi
  8016cb:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8016cc:	8b 75 18             	mov    0x18(%ebp),%esi
  8016cf:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016d2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016db:	56                   	push   %esi
  8016dc:	53                   	push   %ebx
  8016dd:	51                   	push   %ecx
  8016de:	52                   	push   %edx
  8016df:	50                   	push   %eax
  8016e0:	6a 08                	push   $0x8
  8016e2:	e8 d6 fe ff ff       	call   8015bd <syscall>
  8016e7:	83 c4 18             	add    $0x18,%esp
}
  8016ea:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8016ed:	5b                   	pop    %ebx
  8016ee:	5e                   	pop    %esi
  8016ef:	5d                   	pop    %ebp
  8016f0:	c3                   	ret    

008016f1 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8016f1:	55                   	push   %ebp
  8016f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8016f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fa:	6a 00                	push   $0x0
  8016fc:	6a 00                	push   $0x0
  8016fe:	6a 00                	push   $0x0
  801700:	52                   	push   %edx
  801701:	50                   	push   %eax
  801702:	6a 09                	push   $0x9
  801704:	e8 b4 fe ff ff       	call   8015bd <syscall>
  801709:	83 c4 18             	add    $0x18,%esp
}
  80170c:	c9                   	leave  
  80170d:	c3                   	ret    

0080170e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80170e:	55                   	push   %ebp
  80170f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801711:	6a 00                	push   $0x0
  801713:	6a 00                	push   $0x0
  801715:	6a 00                	push   $0x0
  801717:	ff 75 0c             	pushl  0xc(%ebp)
  80171a:	ff 75 08             	pushl  0x8(%ebp)
  80171d:	6a 0a                	push   $0xa
  80171f:	e8 99 fe ff ff       	call   8015bd <syscall>
  801724:	83 c4 18             	add    $0x18,%esp
}
  801727:	c9                   	leave  
  801728:	c3                   	ret    

00801729 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801729:	55                   	push   %ebp
  80172a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80172c:	6a 00                	push   $0x0
  80172e:	6a 00                	push   $0x0
  801730:	6a 00                	push   $0x0
  801732:	6a 00                	push   $0x0
  801734:	6a 00                	push   $0x0
  801736:	6a 0b                	push   $0xb
  801738:	e8 80 fe ff ff       	call   8015bd <syscall>
  80173d:	83 c4 18             	add    $0x18,%esp
}
  801740:	c9                   	leave  
  801741:	c3                   	ret    

00801742 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801742:	55                   	push   %ebp
  801743:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801745:	6a 00                	push   $0x0
  801747:	6a 00                	push   $0x0
  801749:	6a 00                	push   $0x0
  80174b:	6a 00                	push   $0x0
  80174d:	6a 00                	push   $0x0
  80174f:	6a 0c                	push   $0xc
  801751:	e8 67 fe ff ff       	call   8015bd <syscall>
  801756:	83 c4 18             	add    $0x18,%esp
}
  801759:	c9                   	leave  
  80175a:	c3                   	ret    

0080175b <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80175b:	55                   	push   %ebp
  80175c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80175e:	6a 00                	push   $0x0
  801760:	6a 00                	push   $0x0
  801762:	6a 00                	push   $0x0
  801764:	6a 00                	push   $0x0
  801766:	6a 00                	push   $0x0
  801768:	6a 0d                	push   $0xd
  80176a:	e8 4e fe ff ff       	call   8015bd <syscall>
  80176f:	83 c4 18             	add    $0x18,%esp
}
  801772:	c9                   	leave  
  801773:	c3                   	ret    

00801774 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801774:	55                   	push   %ebp
  801775:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	6a 00                	push   $0x0
  80177d:	ff 75 0c             	pushl  0xc(%ebp)
  801780:	ff 75 08             	pushl  0x8(%ebp)
  801783:	6a 11                	push   $0x11
  801785:	e8 33 fe ff ff       	call   8015bd <syscall>
  80178a:	83 c4 18             	add    $0x18,%esp
	return;
  80178d:	90                   	nop
}
  80178e:	c9                   	leave  
  80178f:	c3                   	ret    

00801790 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801790:	55                   	push   %ebp
  801791:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	ff 75 0c             	pushl  0xc(%ebp)
  80179c:	ff 75 08             	pushl  0x8(%ebp)
  80179f:	6a 12                	push   $0x12
  8017a1:	e8 17 fe ff ff       	call   8015bd <syscall>
  8017a6:	83 c4 18             	add    $0x18,%esp
	return ;
  8017a9:	90                   	nop
}
  8017aa:	c9                   	leave  
  8017ab:	c3                   	ret    

008017ac <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8017ac:	55                   	push   %ebp
  8017ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8017af:	6a 00                	push   $0x0
  8017b1:	6a 00                	push   $0x0
  8017b3:	6a 00                	push   $0x0
  8017b5:	6a 00                	push   $0x0
  8017b7:	6a 00                	push   $0x0
  8017b9:	6a 0e                	push   $0xe
  8017bb:	e8 fd fd ff ff       	call   8015bd <syscall>
  8017c0:	83 c4 18             	add    $0x18,%esp
}
  8017c3:	c9                   	leave  
  8017c4:	c3                   	ret    

008017c5 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8017c5:	55                   	push   %ebp
  8017c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8017c8:	6a 00                	push   $0x0
  8017ca:	6a 00                	push   $0x0
  8017cc:	6a 00                	push   $0x0
  8017ce:	6a 00                	push   $0x0
  8017d0:	ff 75 08             	pushl  0x8(%ebp)
  8017d3:	6a 0f                	push   $0xf
  8017d5:	e8 e3 fd ff ff       	call   8015bd <syscall>
  8017da:	83 c4 18             	add    $0x18,%esp
}
  8017dd:	c9                   	leave  
  8017de:	c3                   	ret    

008017df <sys_scarce_memory>:

void sys_scarce_memory()
{
  8017df:	55                   	push   %ebp
  8017e0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 00                	push   $0x0
  8017e8:	6a 00                	push   $0x0
  8017ea:	6a 00                	push   $0x0
  8017ec:	6a 10                	push   $0x10
  8017ee:	e8 ca fd ff ff       	call   8015bd <syscall>
  8017f3:	83 c4 18             	add    $0x18,%esp
}
  8017f6:	90                   	nop
  8017f7:	c9                   	leave  
  8017f8:	c3                   	ret    

008017f9 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8017f9:	55                   	push   %ebp
  8017fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8017fc:	6a 00                	push   $0x0
  8017fe:	6a 00                	push   $0x0
  801800:	6a 00                	push   $0x0
  801802:	6a 00                	push   $0x0
  801804:	6a 00                	push   $0x0
  801806:	6a 14                	push   $0x14
  801808:	e8 b0 fd ff ff       	call   8015bd <syscall>
  80180d:	83 c4 18             	add    $0x18,%esp
}
  801810:	90                   	nop
  801811:	c9                   	leave  
  801812:	c3                   	ret    

00801813 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801813:	55                   	push   %ebp
  801814:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801816:	6a 00                	push   $0x0
  801818:	6a 00                	push   $0x0
  80181a:	6a 00                	push   $0x0
  80181c:	6a 00                	push   $0x0
  80181e:	6a 00                	push   $0x0
  801820:	6a 15                	push   $0x15
  801822:	e8 96 fd ff ff       	call   8015bd <syscall>
  801827:	83 c4 18             	add    $0x18,%esp
}
  80182a:	90                   	nop
  80182b:	c9                   	leave  
  80182c:	c3                   	ret    

0080182d <sys_cputc>:


void
sys_cputc(const char c)
{
  80182d:	55                   	push   %ebp
  80182e:	89 e5                	mov    %esp,%ebp
  801830:	83 ec 04             	sub    $0x4,%esp
  801833:	8b 45 08             	mov    0x8(%ebp),%eax
  801836:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801839:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	6a 00                	push   $0x0
  801845:	50                   	push   %eax
  801846:	6a 16                	push   $0x16
  801848:	e8 70 fd ff ff       	call   8015bd <syscall>
  80184d:	83 c4 18             	add    $0x18,%esp
}
  801850:	90                   	nop
  801851:	c9                   	leave  
  801852:	c3                   	ret    

00801853 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801853:	55                   	push   %ebp
  801854:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801856:	6a 00                	push   $0x0
  801858:	6a 00                	push   $0x0
  80185a:	6a 00                	push   $0x0
  80185c:	6a 00                	push   $0x0
  80185e:	6a 00                	push   $0x0
  801860:	6a 17                	push   $0x17
  801862:	e8 56 fd ff ff       	call   8015bd <syscall>
  801867:	83 c4 18             	add    $0x18,%esp
}
  80186a:	90                   	nop
  80186b:	c9                   	leave  
  80186c:	c3                   	ret    

0080186d <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80186d:	55                   	push   %ebp
  80186e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801870:	8b 45 08             	mov    0x8(%ebp),%eax
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	ff 75 0c             	pushl  0xc(%ebp)
  80187c:	50                   	push   %eax
  80187d:	6a 18                	push   $0x18
  80187f:	e8 39 fd ff ff       	call   8015bd <syscall>
  801884:	83 c4 18             	add    $0x18,%esp
}
  801887:	c9                   	leave  
  801888:	c3                   	ret    

00801889 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801889:	55                   	push   %ebp
  80188a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80188c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80188f:	8b 45 08             	mov    0x8(%ebp),%eax
  801892:	6a 00                	push   $0x0
  801894:	6a 00                	push   $0x0
  801896:	6a 00                	push   $0x0
  801898:	52                   	push   %edx
  801899:	50                   	push   %eax
  80189a:	6a 1b                	push   $0x1b
  80189c:	e8 1c fd ff ff       	call   8015bd <syscall>
  8018a1:	83 c4 18             	add    $0x18,%esp
}
  8018a4:	c9                   	leave  
  8018a5:	c3                   	ret    

008018a6 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018a6:	55                   	push   %ebp
  8018a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8018af:	6a 00                	push   $0x0
  8018b1:	6a 00                	push   $0x0
  8018b3:	6a 00                	push   $0x0
  8018b5:	52                   	push   %edx
  8018b6:	50                   	push   %eax
  8018b7:	6a 19                	push   $0x19
  8018b9:	e8 ff fc ff ff       	call   8015bd <syscall>
  8018be:	83 c4 18             	add    $0x18,%esp
}
  8018c1:	90                   	nop
  8018c2:	c9                   	leave  
  8018c3:	c3                   	ret    

008018c4 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018c4:	55                   	push   %ebp
  8018c5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cd:	6a 00                	push   $0x0
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 00                	push   $0x0
  8018d3:	52                   	push   %edx
  8018d4:	50                   	push   %eax
  8018d5:	6a 1a                	push   $0x1a
  8018d7:	e8 e1 fc ff ff       	call   8015bd <syscall>
  8018dc:	83 c4 18             	add    $0x18,%esp
}
  8018df:	90                   	nop
  8018e0:	c9                   	leave  
  8018e1:	c3                   	ret    

008018e2 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8018e2:	55                   	push   %ebp
  8018e3:	89 e5                	mov    %esp,%ebp
  8018e5:	83 ec 04             	sub    $0x4,%esp
  8018e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8018eb:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8018ee:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8018f1:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8018f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f8:	6a 00                	push   $0x0
  8018fa:	51                   	push   %ecx
  8018fb:	52                   	push   %edx
  8018fc:	ff 75 0c             	pushl  0xc(%ebp)
  8018ff:	50                   	push   %eax
  801900:	6a 1c                	push   $0x1c
  801902:	e8 b6 fc ff ff       	call   8015bd <syscall>
  801907:	83 c4 18             	add    $0x18,%esp
}
  80190a:	c9                   	leave  
  80190b:	c3                   	ret    

0080190c <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80190c:	55                   	push   %ebp
  80190d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80190f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801912:	8b 45 08             	mov    0x8(%ebp),%eax
  801915:	6a 00                	push   $0x0
  801917:	6a 00                	push   $0x0
  801919:	6a 00                	push   $0x0
  80191b:	52                   	push   %edx
  80191c:	50                   	push   %eax
  80191d:	6a 1d                	push   $0x1d
  80191f:	e8 99 fc ff ff       	call   8015bd <syscall>
  801924:	83 c4 18             	add    $0x18,%esp
}
  801927:	c9                   	leave  
  801928:	c3                   	ret    

00801929 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801929:	55                   	push   %ebp
  80192a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80192c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80192f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801932:	8b 45 08             	mov    0x8(%ebp),%eax
  801935:	6a 00                	push   $0x0
  801937:	6a 00                	push   $0x0
  801939:	51                   	push   %ecx
  80193a:	52                   	push   %edx
  80193b:	50                   	push   %eax
  80193c:	6a 1e                	push   $0x1e
  80193e:	e8 7a fc ff ff       	call   8015bd <syscall>
  801943:	83 c4 18             	add    $0x18,%esp
}
  801946:	c9                   	leave  
  801947:	c3                   	ret    

00801948 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801948:	55                   	push   %ebp
  801949:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80194b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80194e:	8b 45 08             	mov    0x8(%ebp),%eax
  801951:	6a 00                	push   $0x0
  801953:	6a 00                	push   $0x0
  801955:	6a 00                	push   $0x0
  801957:	52                   	push   %edx
  801958:	50                   	push   %eax
  801959:	6a 1f                	push   $0x1f
  80195b:	e8 5d fc ff ff       	call   8015bd <syscall>
  801960:	83 c4 18             	add    $0x18,%esp
}
  801963:	c9                   	leave  
  801964:	c3                   	ret    

00801965 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801965:	55                   	push   %ebp
  801966:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801968:	6a 00                	push   $0x0
  80196a:	6a 00                	push   $0x0
  80196c:	6a 00                	push   $0x0
  80196e:	6a 00                	push   $0x0
  801970:	6a 00                	push   $0x0
  801972:	6a 20                	push   $0x20
  801974:	e8 44 fc ff ff       	call   8015bd <syscall>
  801979:	83 c4 18             	add    $0x18,%esp
}
  80197c:	c9                   	leave  
  80197d:	c3                   	ret    

0080197e <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80197e:	55                   	push   %ebp
  80197f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801981:	8b 45 08             	mov    0x8(%ebp),%eax
  801984:	6a 00                	push   $0x0
  801986:	ff 75 14             	pushl  0x14(%ebp)
  801989:	ff 75 10             	pushl  0x10(%ebp)
  80198c:	ff 75 0c             	pushl  0xc(%ebp)
  80198f:	50                   	push   %eax
  801990:	6a 21                	push   $0x21
  801992:	e8 26 fc ff ff       	call   8015bd <syscall>
  801997:	83 c4 18             	add    $0x18,%esp
}
  80199a:	c9                   	leave  
  80199b:	c3                   	ret    

0080199c <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80199c:	55                   	push   %ebp
  80199d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80199f:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a2:	6a 00                	push   $0x0
  8019a4:	6a 00                	push   $0x0
  8019a6:	6a 00                	push   $0x0
  8019a8:	6a 00                	push   $0x0
  8019aa:	50                   	push   %eax
  8019ab:	6a 22                	push   $0x22
  8019ad:	e8 0b fc ff ff       	call   8015bd <syscall>
  8019b2:	83 c4 18             	add    $0x18,%esp
}
  8019b5:	90                   	nop
  8019b6:	c9                   	leave  
  8019b7:	c3                   	ret    

008019b8 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8019b8:	55                   	push   %ebp
  8019b9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8019bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 00                	push   $0x0
  8019c4:	6a 00                	push   $0x0
  8019c6:	50                   	push   %eax
  8019c7:	6a 23                	push   $0x23
  8019c9:	e8 ef fb ff ff       	call   8015bd <syscall>
  8019ce:	83 c4 18             	add    $0x18,%esp
}
  8019d1:	90                   	nop
  8019d2:	c9                   	leave  
  8019d3:	c3                   	ret    

008019d4 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8019d4:	55                   	push   %ebp
  8019d5:	89 e5                	mov    %esp,%ebp
  8019d7:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8019da:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8019dd:	8d 50 04             	lea    0x4(%eax),%edx
  8019e0:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 00                	push   $0x0
  8019e7:	6a 00                	push   $0x0
  8019e9:	52                   	push   %edx
  8019ea:	50                   	push   %eax
  8019eb:	6a 24                	push   $0x24
  8019ed:	e8 cb fb ff ff       	call   8015bd <syscall>
  8019f2:	83 c4 18             	add    $0x18,%esp
	return result;
  8019f5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8019f8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019fb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019fe:	89 01                	mov    %eax,(%ecx)
  801a00:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801a03:	8b 45 08             	mov    0x8(%ebp),%eax
  801a06:	c9                   	leave  
  801a07:	c2 04 00             	ret    $0x4

00801a0a <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801a0a:	55                   	push   %ebp
  801a0b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801a0d:	6a 00                	push   $0x0
  801a0f:	6a 00                	push   $0x0
  801a11:	ff 75 10             	pushl  0x10(%ebp)
  801a14:	ff 75 0c             	pushl  0xc(%ebp)
  801a17:	ff 75 08             	pushl  0x8(%ebp)
  801a1a:	6a 13                	push   $0x13
  801a1c:	e8 9c fb ff ff       	call   8015bd <syscall>
  801a21:	83 c4 18             	add    $0x18,%esp
	return ;
  801a24:	90                   	nop
}
  801a25:	c9                   	leave  
  801a26:	c3                   	ret    

00801a27 <sys_rcr2>:
uint32 sys_rcr2()
{
  801a27:	55                   	push   %ebp
  801a28:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a2a:	6a 00                	push   $0x0
  801a2c:	6a 00                	push   $0x0
  801a2e:	6a 00                	push   $0x0
  801a30:	6a 00                	push   $0x0
  801a32:	6a 00                	push   $0x0
  801a34:	6a 25                	push   $0x25
  801a36:	e8 82 fb ff ff       	call   8015bd <syscall>
  801a3b:	83 c4 18             	add    $0x18,%esp
}
  801a3e:	c9                   	leave  
  801a3f:	c3                   	ret    

00801a40 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801a40:	55                   	push   %ebp
  801a41:	89 e5                	mov    %esp,%ebp
  801a43:	83 ec 04             	sub    $0x4,%esp
  801a46:	8b 45 08             	mov    0x8(%ebp),%eax
  801a49:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a4c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a50:	6a 00                	push   $0x0
  801a52:	6a 00                	push   $0x0
  801a54:	6a 00                	push   $0x0
  801a56:	6a 00                	push   $0x0
  801a58:	50                   	push   %eax
  801a59:	6a 26                	push   $0x26
  801a5b:	e8 5d fb ff ff       	call   8015bd <syscall>
  801a60:	83 c4 18             	add    $0x18,%esp
	return ;
  801a63:	90                   	nop
}
  801a64:	c9                   	leave  
  801a65:	c3                   	ret    

00801a66 <rsttst>:
void rsttst()
{
  801a66:	55                   	push   %ebp
  801a67:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a69:	6a 00                	push   $0x0
  801a6b:	6a 00                	push   $0x0
  801a6d:	6a 00                	push   $0x0
  801a6f:	6a 00                	push   $0x0
  801a71:	6a 00                	push   $0x0
  801a73:	6a 28                	push   $0x28
  801a75:	e8 43 fb ff ff       	call   8015bd <syscall>
  801a7a:	83 c4 18             	add    $0x18,%esp
	return ;
  801a7d:	90                   	nop
}
  801a7e:	c9                   	leave  
  801a7f:	c3                   	ret    

00801a80 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a80:	55                   	push   %ebp
  801a81:	89 e5                	mov    %esp,%ebp
  801a83:	83 ec 04             	sub    $0x4,%esp
  801a86:	8b 45 14             	mov    0x14(%ebp),%eax
  801a89:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a8c:	8b 55 18             	mov    0x18(%ebp),%edx
  801a8f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a93:	52                   	push   %edx
  801a94:	50                   	push   %eax
  801a95:	ff 75 10             	pushl  0x10(%ebp)
  801a98:	ff 75 0c             	pushl  0xc(%ebp)
  801a9b:	ff 75 08             	pushl  0x8(%ebp)
  801a9e:	6a 27                	push   $0x27
  801aa0:	e8 18 fb ff ff       	call   8015bd <syscall>
  801aa5:	83 c4 18             	add    $0x18,%esp
	return ;
  801aa8:	90                   	nop
}
  801aa9:	c9                   	leave  
  801aaa:	c3                   	ret    

00801aab <chktst>:
void chktst(uint32 n)
{
  801aab:	55                   	push   %ebp
  801aac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801aae:	6a 00                	push   $0x0
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	6a 00                	push   $0x0
  801ab6:	ff 75 08             	pushl  0x8(%ebp)
  801ab9:	6a 29                	push   $0x29
  801abb:	e8 fd fa ff ff       	call   8015bd <syscall>
  801ac0:	83 c4 18             	add    $0x18,%esp
	return ;
  801ac3:	90                   	nop
}
  801ac4:	c9                   	leave  
  801ac5:	c3                   	ret    

00801ac6 <inctst>:

void inctst()
{
  801ac6:	55                   	push   %ebp
  801ac7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 00                	push   $0x0
  801acd:	6a 00                	push   $0x0
  801acf:	6a 00                	push   $0x0
  801ad1:	6a 00                	push   $0x0
  801ad3:	6a 2a                	push   $0x2a
  801ad5:	e8 e3 fa ff ff       	call   8015bd <syscall>
  801ada:	83 c4 18             	add    $0x18,%esp
	return ;
  801add:	90                   	nop
}
  801ade:	c9                   	leave  
  801adf:	c3                   	ret    

00801ae0 <gettst>:
uint32 gettst()
{
  801ae0:	55                   	push   %ebp
  801ae1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ae3:	6a 00                	push   $0x0
  801ae5:	6a 00                	push   $0x0
  801ae7:	6a 00                	push   $0x0
  801ae9:	6a 00                	push   $0x0
  801aeb:	6a 00                	push   $0x0
  801aed:	6a 2b                	push   $0x2b
  801aef:	e8 c9 fa ff ff       	call   8015bd <syscall>
  801af4:	83 c4 18             	add    $0x18,%esp
}
  801af7:	c9                   	leave  
  801af8:	c3                   	ret    

00801af9 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801af9:	55                   	push   %ebp
  801afa:	89 e5                	mov    %esp,%ebp
  801afc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801aff:	6a 00                	push   $0x0
  801b01:	6a 00                	push   $0x0
  801b03:	6a 00                	push   $0x0
  801b05:	6a 00                	push   $0x0
  801b07:	6a 00                	push   $0x0
  801b09:	6a 2c                	push   $0x2c
  801b0b:	e8 ad fa ff ff       	call   8015bd <syscall>
  801b10:	83 c4 18             	add    $0x18,%esp
  801b13:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801b16:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801b1a:	75 07                	jne    801b23 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801b1c:	b8 01 00 00 00       	mov    $0x1,%eax
  801b21:	eb 05                	jmp    801b28 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801b23:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b28:	c9                   	leave  
  801b29:	c3                   	ret    

00801b2a <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801b2a:	55                   	push   %ebp
  801b2b:	89 e5                	mov    %esp,%ebp
  801b2d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b30:	6a 00                	push   $0x0
  801b32:	6a 00                	push   $0x0
  801b34:	6a 00                	push   $0x0
  801b36:	6a 00                	push   $0x0
  801b38:	6a 00                	push   $0x0
  801b3a:	6a 2c                	push   $0x2c
  801b3c:	e8 7c fa ff ff       	call   8015bd <syscall>
  801b41:	83 c4 18             	add    $0x18,%esp
  801b44:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801b47:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801b4b:	75 07                	jne    801b54 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801b4d:	b8 01 00 00 00       	mov    $0x1,%eax
  801b52:	eb 05                	jmp    801b59 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801b54:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b59:	c9                   	leave  
  801b5a:	c3                   	ret    

00801b5b <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801b5b:	55                   	push   %ebp
  801b5c:	89 e5                	mov    %esp,%ebp
  801b5e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b61:	6a 00                	push   $0x0
  801b63:	6a 00                	push   $0x0
  801b65:	6a 00                	push   $0x0
  801b67:	6a 00                	push   $0x0
  801b69:	6a 00                	push   $0x0
  801b6b:	6a 2c                	push   $0x2c
  801b6d:	e8 4b fa ff ff       	call   8015bd <syscall>
  801b72:	83 c4 18             	add    $0x18,%esp
  801b75:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801b78:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801b7c:	75 07                	jne    801b85 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801b7e:	b8 01 00 00 00       	mov    $0x1,%eax
  801b83:	eb 05                	jmp    801b8a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801b85:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b8a:	c9                   	leave  
  801b8b:	c3                   	ret    

00801b8c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801b8c:	55                   	push   %ebp
  801b8d:	89 e5                	mov    %esp,%ebp
  801b8f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b92:	6a 00                	push   $0x0
  801b94:	6a 00                	push   $0x0
  801b96:	6a 00                	push   $0x0
  801b98:	6a 00                	push   $0x0
  801b9a:	6a 00                	push   $0x0
  801b9c:	6a 2c                	push   $0x2c
  801b9e:	e8 1a fa ff ff       	call   8015bd <syscall>
  801ba3:	83 c4 18             	add    $0x18,%esp
  801ba6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801ba9:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801bad:	75 07                	jne    801bb6 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801baf:	b8 01 00 00 00       	mov    $0x1,%eax
  801bb4:	eb 05                	jmp    801bbb <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801bb6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bbb:	c9                   	leave  
  801bbc:	c3                   	ret    

00801bbd <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801bbd:	55                   	push   %ebp
  801bbe:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801bc0:	6a 00                	push   $0x0
  801bc2:	6a 00                	push   $0x0
  801bc4:	6a 00                	push   $0x0
  801bc6:	6a 00                	push   $0x0
  801bc8:	ff 75 08             	pushl  0x8(%ebp)
  801bcb:	6a 2d                	push   $0x2d
  801bcd:	e8 eb f9 ff ff       	call   8015bd <syscall>
  801bd2:	83 c4 18             	add    $0x18,%esp
	return ;
  801bd5:	90                   	nop
}
  801bd6:	c9                   	leave  
  801bd7:	c3                   	ret    

00801bd8 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801bd8:	55                   	push   %ebp
  801bd9:	89 e5                	mov    %esp,%ebp
  801bdb:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801bdc:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bdf:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801be2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801be5:	8b 45 08             	mov    0x8(%ebp),%eax
  801be8:	6a 00                	push   $0x0
  801bea:	53                   	push   %ebx
  801beb:	51                   	push   %ecx
  801bec:	52                   	push   %edx
  801bed:	50                   	push   %eax
  801bee:	6a 2e                	push   $0x2e
  801bf0:	e8 c8 f9 ff ff       	call   8015bd <syscall>
  801bf5:	83 c4 18             	add    $0x18,%esp
}
  801bf8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801bfb:	c9                   	leave  
  801bfc:	c3                   	ret    

00801bfd <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801bfd:	55                   	push   %ebp
  801bfe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801c00:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c03:	8b 45 08             	mov    0x8(%ebp),%eax
  801c06:	6a 00                	push   $0x0
  801c08:	6a 00                	push   $0x0
  801c0a:	6a 00                	push   $0x0
  801c0c:	52                   	push   %edx
  801c0d:	50                   	push   %eax
  801c0e:	6a 2f                	push   $0x2f
  801c10:	e8 a8 f9 ff ff       	call   8015bd <syscall>
  801c15:	83 c4 18             	add    $0x18,%esp
}
  801c18:	c9                   	leave  
  801c19:	c3                   	ret    

00801c1a <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  801c1a:	55                   	push   %ebp
  801c1b:	89 e5                	mov    %esp,%ebp
  801c1d:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  801c20:	8b 55 08             	mov    0x8(%ebp),%edx
  801c23:	89 d0                	mov    %edx,%eax
  801c25:	c1 e0 02             	shl    $0x2,%eax
  801c28:	01 d0                	add    %edx,%eax
  801c2a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c31:	01 d0                	add    %edx,%eax
  801c33:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c3a:	01 d0                	add    %edx,%eax
  801c3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c43:	01 d0                	add    %edx,%eax
  801c45:	c1 e0 04             	shl    $0x4,%eax
  801c48:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801c4b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  801c52:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801c55:	83 ec 0c             	sub    $0xc,%esp
  801c58:	50                   	push   %eax
  801c59:	e8 76 fd ff ff       	call   8019d4 <sys_get_virtual_time>
  801c5e:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  801c61:	eb 41                	jmp    801ca4 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  801c63:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801c66:	83 ec 0c             	sub    $0xc,%esp
  801c69:	50                   	push   %eax
  801c6a:	e8 65 fd ff ff       	call   8019d4 <sys_get_virtual_time>
  801c6f:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  801c72:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801c75:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c78:	29 c2                	sub    %eax,%edx
  801c7a:	89 d0                	mov    %edx,%eax
  801c7c:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801c7f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801c82:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801c85:	89 d1                	mov    %edx,%ecx
  801c87:	29 c1                	sub    %eax,%ecx
  801c89:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801c8c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801c8f:	39 c2                	cmp    %eax,%edx
  801c91:	0f 97 c0             	seta   %al
  801c94:	0f b6 c0             	movzbl %al,%eax
  801c97:	29 c1                	sub    %eax,%ecx
  801c99:	89 c8                	mov    %ecx,%eax
  801c9b:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801c9e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801ca1:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801ca4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ca7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801caa:	72 b7                	jb     801c63 <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801cac:	90                   	nop
  801cad:	c9                   	leave  
  801cae:	c3                   	ret    

00801caf <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801caf:	55                   	push   %ebp
  801cb0:	89 e5                	mov    %esp,%ebp
  801cb2:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801cb5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801cbc:	eb 03                	jmp    801cc1 <busy_wait+0x12>
  801cbe:	ff 45 fc             	incl   -0x4(%ebp)
  801cc1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801cc4:	3b 45 08             	cmp    0x8(%ebp),%eax
  801cc7:	72 f5                	jb     801cbe <busy_wait+0xf>
	return i;
  801cc9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801ccc:	c9                   	leave  
  801ccd:	c3                   	ret    
  801cce:	66 90                	xchg   %ax,%ax

00801cd0 <__udivdi3>:
  801cd0:	55                   	push   %ebp
  801cd1:	57                   	push   %edi
  801cd2:	56                   	push   %esi
  801cd3:	53                   	push   %ebx
  801cd4:	83 ec 1c             	sub    $0x1c,%esp
  801cd7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801cdb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801cdf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ce3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801ce7:	89 ca                	mov    %ecx,%edx
  801ce9:	89 f8                	mov    %edi,%eax
  801ceb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801cef:	85 f6                	test   %esi,%esi
  801cf1:	75 2d                	jne    801d20 <__udivdi3+0x50>
  801cf3:	39 cf                	cmp    %ecx,%edi
  801cf5:	77 65                	ja     801d5c <__udivdi3+0x8c>
  801cf7:	89 fd                	mov    %edi,%ebp
  801cf9:	85 ff                	test   %edi,%edi
  801cfb:	75 0b                	jne    801d08 <__udivdi3+0x38>
  801cfd:	b8 01 00 00 00       	mov    $0x1,%eax
  801d02:	31 d2                	xor    %edx,%edx
  801d04:	f7 f7                	div    %edi
  801d06:	89 c5                	mov    %eax,%ebp
  801d08:	31 d2                	xor    %edx,%edx
  801d0a:	89 c8                	mov    %ecx,%eax
  801d0c:	f7 f5                	div    %ebp
  801d0e:	89 c1                	mov    %eax,%ecx
  801d10:	89 d8                	mov    %ebx,%eax
  801d12:	f7 f5                	div    %ebp
  801d14:	89 cf                	mov    %ecx,%edi
  801d16:	89 fa                	mov    %edi,%edx
  801d18:	83 c4 1c             	add    $0x1c,%esp
  801d1b:	5b                   	pop    %ebx
  801d1c:	5e                   	pop    %esi
  801d1d:	5f                   	pop    %edi
  801d1e:	5d                   	pop    %ebp
  801d1f:	c3                   	ret    
  801d20:	39 ce                	cmp    %ecx,%esi
  801d22:	77 28                	ja     801d4c <__udivdi3+0x7c>
  801d24:	0f bd fe             	bsr    %esi,%edi
  801d27:	83 f7 1f             	xor    $0x1f,%edi
  801d2a:	75 40                	jne    801d6c <__udivdi3+0x9c>
  801d2c:	39 ce                	cmp    %ecx,%esi
  801d2e:	72 0a                	jb     801d3a <__udivdi3+0x6a>
  801d30:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801d34:	0f 87 9e 00 00 00    	ja     801dd8 <__udivdi3+0x108>
  801d3a:	b8 01 00 00 00       	mov    $0x1,%eax
  801d3f:	89 fa                	mov    %edi,%edx
  801d41:	83 c4 1c             	add    $0x1c,%esp
  801d44:	5b                   	pop    %ebx
  801d45:	5e                   	pop    %esi
  801d46:	5f                   	pop    %edi
  801d47:	5d                   	pop    %ebp
  801d48:	c3                   	ret    
  801d49:	8d 76 00             	lea    0x0(%esi),%esi
  801d4c:	31 ff                	xor    %edi,%edi
  801d4e:	31 c0                	xor    %eax,%eax
  801d50:	89 fa                	mov    %edi,%edx
  801d52:	83 c4 1c             	add    $0x1c,%esp
  801d55:	5b                   	pop    %ebx
  801d56:	5e                   	pop    %esi
  801d57:	5f                   	pop    %edi
  801d58:	5d                   	pop    %ebp
  801d59:	c3                   	ret    
  801d5a:	66 90                	xchg   %ax,%ax
  801d5c:	89 d8                	mov    %ebx,%eax
  801d5e:	f7 f7                	div    %edi
  801d60:	31 ff                	xor    %edi,%edi
  801d62:	89 fa                	mov    %edi,%edx
  801d64:	83 c4 1c             	add    $0x1c,%esp
  801d67:	5b                   	pop    %ebx
  801d68:	5e                   	pop    %esi
  801d69:	5f                   	pop    %edi
  801d6a:	5d                   	pop    %ebp
  801d6b:	c3                   	ret    
  801d6c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801d71:	89 eb                	mov    %ebp,%ebx
  801d73:	29 fb                	sub    %edi,%ebx
  801d75:	89 f9                	mov    %edi,%ecx
  801d77:	d3 e6                	shl    %cl,%esi
  801d79:	89 c5                	mov    %eax,%ebp
  801d7b:	88 d9                	mov    %bl,%cl
  801d7d:	d3 ed                	shr    %cl,%ebp
  801d7f:	89 e9                	mov    %ebp,%ecx
  801d81:	09 f1                	or     %esi,%ecx
  801d83:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801d87:	89 f9                	mov    %edi,%ecx
  801d89:	d3 e0                	shl    %cl,%eax
  801d8b:	89 c5                	mov    %eax,%ebp
  801d8d:	89 d6                	mov    %edx,%esi
  801d8f:	88 d9                	mov    %bl,%cl
  801d91:	d3 ee                	shr    %cl,%esi
  801d93:	89 f9                	mov    %edi,%ecx
  801d95:	d3 e2                	shl    %cl,%edx
  801d97:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d9b:	88 d9                	mov    %bl,%cl
  801d9d:	d3 e8                	shr    %cl,%eax
  801d9f:	09 c2                	or     %eax,%edx
  801da1:	89 d0                	mov    %edx,%eax
  801da3:	89 f2                	mov    %esi,%edx
  801da5:	f7 74 24 0c          	divl   0xc(%esp)
  801da9:	89 d6                	mov    %edx,%esi
  801dab:	89 c3                	mov    %eax,%ebx
  801dad:	f7 e5                	mul    %ebp
  801daf:	39 d6                	cmp    %edx,%esi
  801db1:	72 19                	jb     801dcc <__udivdi3+0xfc>
  801db3:	74 0b                	je     801dc0 <__udivdi3+0xf0>
  801db5:	89 d8                	mov    %ebx,%eax
  801db7:	31 ff                	xor    %edi,%edi
  801db9:	e9 58 ff ff ff       	jmp    801d16 <__udivdi3+0x46>
  801dbe:	66 90                	xchg   %ax,%ax
  801dc0:	8b 54 24 08          	mov    0x8(%esp),%edx
  801dc4:	89 f9                	mov    %edi,%ecx
  801dc6:	d3 e2                	shl    %cl,%edx
  801dc8:	39 c2                	cmp    %eax,%edx
  801dca:	73 e9                	jae    801db5 <__udivdi3+0xe5>
  801dcc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801dcf:	31 ff                	xor    %edi,%edi
  801dd1:	e9 40 ff ff ff       	jmp    801d16 <__udivdi3+0x46>
  801dd6:	66 90                	xchg   %ax,%ax
  801dd8:	31 c0                	xor    %eax,%eax
  801dda:	e9 37 ff ff ff       	jmp    801d16 <__udivdi3+0x46>
  801ddf:	90                   	nop

00801de0 <__umoddi3>:
  801de0:	55                   	push   %ebp
  801de1:	57                   	push   %edi
  801de2:	56                   	push   %esi
  801de3:	53                   	push   %ebx
  801de4:	83 ec 1c             	sub    $0x1c,%esp
  801de7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801deb:	8b 74 24 34          	mov    0x34(%esp),%esi
  801def:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801df3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801df7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801dfb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801dff:	89 f3                	mov    %esi,%ebx
  801e01:	89 fa                	mov    %edi,%edx
  801e03:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e07:	89 34 24             	mov    %esi,(%esp)
  801e0a:	85 c0                	test   %eax,%eax
  801e0c:	75 1a                	jne    801e28 <__umoddi3+0x48>
  801e0e:	39 f7                	cmp    %esi,%edi
  801e10:	0f 86 a2 00 00 00    	jbe    801eb8 <__umoddi3+0xd8>
  801e16:	89 c8                	mov    %ecx,%eax
  801e18:	89 f2                	mov    %esi,%edx
  801e1a:	f7 f7                	div    %edi
  801e1c:	89 d0                	mov    %edx,%eax
  801e1e:	31 d2                	xor    %edx,%edx
  801e20:	83 c4 1c             	add    $0x1c,%esp
  801e23:	5b                   	pop    %ebx
  801e24:	5e                   	pop    %esi
  801e25:	5f                   	pop    %edi
  801e26:	5d                   	pop    %ebp
  801e27:	c3                   	ret    
  801e28:	39 f0                	cmp    %esi,%eax
  801e2a:	0f 87 ac 00 00 00    	ja     801edc <__umoddi3+0xfc>
  801e30:	0f bd e8             	bsr    %eax,%ebp
  801e33:	83 f5 1f             	xor    $0x1f,%ebp
  801e36:	0f 84 ac 00 00 00    	je     801ee8 <__umoddi3+0x108>
  801e3c:	bf 20 00 00 00       	mov    $0x20,%edi
  801e41:	29 ef                	sub    %ebp,%edi
  801e43:	89 fe                	mov    %edi,%esi
  801e45:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801e49:	89 e9                	mov    %ebp,%ecx
  801e4b:	d3 e0                	shl    %cl,%eax
  801e4d:	89 d7                	mov    %edx,%edi
  801e4f:	89 f1                	mov    %esi,%ecx
  801e51:	d3 ef                	shr    %cl,%edi
  801e53:	09 c7                	or     %eax,%edi
  801e55:	89 e9                	mov    %ebp,%ecx
  801e57:	d3 e2                	shl    %cl,%edx
  801e59:	89 14 24             	mov    %edx,(%esp)
  801e5c:	89 d8                	mov    %ebx,%eax
  801e5e:	d3 e0                	shl    %cl,%eax
  801e60:	89 c2                	mov    %eax,%edx
  801e62:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e66:	d3 e0                	shl    %cl,%eax
  801e68:	89 44 24 04          	mov    %eax,0x4(%esp)
  801e6c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e70:	89 f1                	mov    %esi,%ecx
  801e72:	d3 e8                	shr    %cl,%eax
  801e74:	09 d0                	or     %edx,%eax
  801e76:	d3 eb                	shr    %cl,%ebx
  801e78:	89 da                	mov    %ebx,%edx
  801e7a:	f7 f7                	div    %edi
  801e7c:	89 d3                	mov    %edx,%ebx
  801e7e:	f7 24 24             	mull   (%esp)
  801e81:	89 c6                	mov    %eax,%esi
  801e83:	89 d1                	mov    %edx,%ecx
  801e85:	39 d3                	cmp    %edx,%ebx
  801e87:	0f 82 87 00 00 00    	jb     801f14 <__umoddi3+0x134>
  801e8d:	0f 84 91 00 00 00    	je     801f24 <__umoddi3+0x144>
  801e93:	8b 54 24 04          	mov    0x4(%esp),%edx
  801e97:	29 f2                	sub    %esi,%edx
  801e99:	19 cb                	sbb    %ecx,%ebx
  801e9b:	89 d8                	mov    %ebx,%eax
  801e9d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ea1:	d3 e0                	shl    %cl,%eax
  801ea3:	89 e9                	mov    %ebp,%ecx
  801ea5:	d3 ea                	shr    %cl,%edx
  801ea7:	09 d0                	or     %edx,%eax
  801ea9:	89 e9                	mov    %ebp,%ecx
  801eab:	d3 eb                	shr    %cl,%ebx
  801ead:	89 da                	mov    %ebx,%edx
  801eaf:	83 c4 1c             	add    $0x1c,%esp
  801eb2:	5b                   	pop    %ebx
  801eb3:	5e                   	pop    %esi
  801eb4:	5f                   	pop    %edi
  801eb5:	5d                   	pop    %ebp
  801eb6:	c3                   	ret    
  801eb7:	90                   	nop
  801eb8:	89 fd                	mov    %edi,%ebp
  801eba:	85 ff                	test   %edi,%edi
  801ebc:	75 0b                	jne    801ec9 <__umoddi3+0xe9>
  801ebe:	b8 01 00 00 00       	mov    $0x1,%eax
  801ec3:	31 d2                	xor    %edx,%edx
  801ec5:	f7 f7                	div    %edi
  801ec7:	89 c5                	mov    %eax,%ebp
  801ec9:	89 f0                	mov    %esi,%eax
  801ecb:	31 d2                	xor    %edx,%edx
  801ecd:	f7 f5                	div    %ebp
  801ecf:	89 c8                	mov    %ecx,%eax
  801ed1:	f7 f5                	div    %ebp
  801ed3:	89 d0                	mov    %edx,%eax
  801ed5:	e9 44 ff ff ff       	jmp    801e1e <__umoddi3+0x3e>
  801eda:	66 90                	xchg   %ax,%ax
  801edc:	89 c8                	mov    %ecx,%eax
  801ede:	89 f2                	mov    %esi,%edx
  801ee0:	83 c4 1c             	add    $0x1c,%esp
  801ee3:	5b                   	pop    %ebx
  801ee4:	5e                   	pop    %esi
  801ee5:	5f                   	pop    %edi
  801ee6:	5d                   	pop    %ebp
  801ee7:	c3                   	ret    
  801ee8:	3b 04 24             	cmp    (%esp),%eax
  801eeb:	72 06                	jb     801ef3 <__umoddi3+0x113>
  801eed:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801ef1:	77 0f                	ja     801f02 <__umoddi3+0x122>
  801ef3:	89 f2                	mov    %esi,%edx
  801ef5:	29 f9                	sub    %edi,%ecx
  801ef7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801efb:	89 14 24             	mov    %edx,(%esp)
  801efe:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f02:	8b 44 24 04          	mov    0x4(%esp),%eax
  801f06:	8b 14 24             	mov    (%esp),%edx
  801f09:	83 c4 1c             	add    $0x1c,%esp
  801f0c:	5b                   	pop    %ebx
  801f0d:	5e                   	pop    %esi
  801f0e:	5f                   	pop    %edi
  801f0f:	5d                   	pop    %ebp
  801f10:	c3                   	ret    
  801f11:	8d 76 00             	lea    0x0(%esi),%esi
  801f14:	2b 04 24             	sub    (%esp),%eax
  801f17:	19 fa                	sbb    %edi,%edx
  801f19:	89 d1                	mov    %edx,%ecx
  801f1b:	89 c6                	mov    %eax,%esi
  801f1d:	e9 71 ff ff ff       	jmp    801e93 <__umoddi3+0xb3>
  801f22:	66 90                	xchg   %ax,%ax
  801f24:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801f28:	72 ea                	jb     801f14 <__umoddi3+0x134>
  801f2a:	89 d9                	mov    %ebx,%ecx
  801f2c:	e9 62 ff ff ff       	jmp    801e93 <__umoddi3+0xb3>
