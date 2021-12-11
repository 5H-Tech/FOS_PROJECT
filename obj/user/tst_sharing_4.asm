
obj/user/tst_sharing_4:     file format elf32-i386


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
  800031:	e8 2e 05 00 00       	call   800564 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Test the free of shared variables (create_shared_memory)
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	83 ec 44             	sub    $0x44,%esp
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  80003f:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800043:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80004a:	eb 23                	jmp    80006f <_main+0x37>
		{
			if (myEnv->__uptr_pws[i].empty)
  80004c:	a1 20 30 80 00       	mov    0x803020,%eax
  800051:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800057:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80005a:	c1 e2 04             	shl    $0x4,%edx
  80005d:	01 d0                	add    %edx,%eax
  80005f:	8a 40 04             	mov    0x4(%eax),%al
  800062:	84 c0                	test   %al,%al
  800064:	74 06                	je     80006c <_main+0x34>
			{
				fullWS = 0;
  800066:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  80006a:	eb 12                	jmp    80007e <_main+0x46>
_main(void)
{
	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  80006c:	ff 45 f0             	incl   -0x10(%ebp)
  80006f:	a1 20 30 80 00       	mov    0x803020,%eax
  800074:	8b 50 74             	mov    0x74(%eax),%edx
  800077:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80007a:	39 c2                	cmp    %eax,%edx
  80007c:	77 ce                	ja     80004c <_main+0x14>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  80007e:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800082:	74 14                	je     800098 <_main+0x60>
  800084:	83 ec 04             	sub    $0x4,%esp
  800087:	68 a0 20 80 00       	push   $0x8020a0
  80008c:	6a 12                	push   $0x12
  80008e:	68 bc 20 80 00       	push   $0x8020bc
  800093:	e8 11 06 00 00       	call   8006a9 <_panic>
	}

	cprintf("************************************************\n");
  800098:	83 ec 0c             	sub    $0xc,%esp
  80009b:	68 d4 20 80 00       	push   $0x8020d4
  8000a0:	e8 a6 08 00 00       	call   80094b <cprintf>
  8000a5:	83 c4 10             	add    $0x10,%esp
	cprintf("MAKE SURE to have a FRESH RUN for this test\n(i.e. don't run any program/test before it)\n");
  8000a8:	83 ec 0c             	sub    $0xc,%esp
  8000ab:	68 08 21 80 00       	push   $0x802108
  8000b0:	e8 96 08 00 00       	call   80094b <cprintf>
  8000b5:	83 c4 10             	add    $0x10,%esp
	cprintf("************************************************\n\n\n");
  8000b8:	83 ec 0c             	sub    $0xc,%esp
  8000bb:	68 64 21 80 00       	push   $0x802164
  8000c0:	e8 86 08 00 00       	call   80094b <cprintf>
  8000c5:	83 c4 10             	add    $0x10,%esp

	int Mega = 1024*1024;
  8000c8:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000cf:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)
	int envID = sys_getenvid();
  8000d6:	e8 72 17 00 00       	call   80184d <sys_getenvid>
  8000db:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	cprintf("STEP A: checking free of a shared object ... \n");
  8000de:	83 ec 0c             	sub    $0xc,%esp
  8000e1:	68 98 21 80 00       	push   $0x802198
  8000e6:	e8 60 08 00 00       	call   80094b <cprintf>
  8000eb:	83 c4 10             	add    $0x10,%esp
	{
		uint32 *x;
		int freeFrames = sys_calculate_free_frames() ;
  8000ee:	e8 3e 18 00 00       	call   801931 <sys_calculate_free_frames>
  8000f3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		x = smalloc("x", PAGE_SIZE, 1);
  8000f6:	83 ec 04             	sub    $0x4,%esp
  8000f9:	6a 01                	push   $0x1
  8000fb:	68 00 10 00 00       	push   $0x1000
  800100:	68 c7 21 80 00       	push   $0x8021c7
  800105:	e8 ff 15 00 00       	call   801709 <smalloc>
  80010a:	83 c4 10             	add    $0x10,%esp
  80010d:	89 45 dc             	mov    %eax,-0x24(%ebp)
		if (x != (uint32*)USER_HEAP_START) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  800110:	81 7d dc 00 00 00 80 	cmpl   $0x80000000,-0x24(%ebp)
  800117:	74 14                	je     80012d <_main+0xf5>
  800119:	83 ec 04             	sub    $0x4,%esp
  80011c:	68 cc 21 80 00       	push   $0x8021cc
  800121:	6a 21                	push   $0x21
  800123:	68 bc 20 80 00       	push   $0x8020bc
  800128:	e8 7c 05 00 00       	call   8006a9 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  80012d:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800130:	e8 fc 17 00 00       	call   801931 <sys_calculate_free_frames>
  800135:	29 c3                	sub    %eax,%ebx
  800137:	89 d8                	mov    %ebx,%eax
  800139:	83 f8 04             	cmp    $0x4,%eax
  80013c:	74 14                	je     800152 <_main+0x11a>
  80013e:	83 ec 04             	sub    $0x4,%esp
  800141:	68 38 22 80 00       	push   $0x802238
  800146:	6a 22                	push   $0x22
  800148:	68 bc 20 80 00       	push   $0x8020bc
  80014d:	e8 57 05 00 00       	call   8006a9 <_panic>

		sfree(x);
  800152:	83 ec 0c             	sub    $0xc,%esp
  800155:	ff 75 dc             	pushl  -0x24(%ebp)
  800158:	e8 e6 15 00 00       	call   801743 <sfree>
  80015d:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) ==  0+0+2) panic("Wrong free: make sure that you free the shared object by calling free_share_object()");
  800160:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800163:	e8 c9 17 00 00       	call   801931 <sys_calculate_free_frames>
  800168:	29 c3                	sub    %eax,%ebx
  80016a:	89 d8                	mov    %ebx,%eax
  80016c:	83 f8 02             	cmp    $0x2,%eax
  80016f:	75 14                	jne    800185 <_main+0x14d>
  800171:	83 ec 04             	sub    $0x4,%esp
  800174:	68 b8 22 80 00       	push   $0x8022b8
  800179:	6a 25                	push   $0x25
  80017b:	68 bc 20 80 00       	push   $0x8020bc
  800180:	e8 24 05 00 00       	call   8006a9 <_panic>
		else if ((freeFrames - sys_calculate_free_frames()) !=  0) panic("Wrong free: revise your freeSharedObject logic");
  800185:	e8 a7 17 00 00       	call   801931 <sys_calculate_free_frames>
  80018a:	89 c2                	mov    %eax,%edx
  80018c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80018f:	39 c2                	cmp    %eax,%edx
  800191:	74 14                	je     8001a7 <_main+0x16f>
  800193:	83 ec 04             	sub    $0x4,%esp
  800196:	68 10 23 80 00       	push   $0x802310
  80019b:	6a 26                	push   $0x26
  80019d:	68 bc 20 80 00       	push   $0x8020bc
  8001a2:	e8 02 05 00 00       	call   8006a9 <_panic>
	}
	cprintf("Step A completed successfully!!\n\n\n");
  8001a7:	83 ec 0c             	sub    $0xc,%esp
  8001aa:	68 40 23 80 00       	push   $0x802340
  8001af:	e8 97 07 00 00       	call   80094b <cprintf>
  8001b4:	83 c4 10             	add    $0x10,%esp


	cprintf("STEP B: checking free of 2 shared objects ... \n");
  8001b7:	83 ec 0c             	sub    $0xc,%esp
  8001ba:	68 64 23 80 00       	push   $0x802364
  8001bf:	e8 87 07 00 00       	call   80094b <cprintf>
  8001c4:	83 c4 10             	add    $0x10,%esp
	{
		uint32 *x, *z ;
		int freeFrames = sys_calculate_free_frames() ;
  8001c7:	e8 65 17 00 00       	call   801931 <sys_calculate_free_frames>
  8001cc:	89 45 d8             	mov    %eax,-0x28(%ebp)
		z = smalloc("z", PAGE_SIZE, 1);
  8001cf:	83 ec 04             	sub    $0x4,%esp
  8001d2:	6a 01                	push   $0x1
  8001d4:	68 00 10 00 00       	push   $0x1000
  8001d9:	68 94 23 80 00       	push   $0x802394
  8001de:	e8 26 15 00 00       	call   801709 <smalloc>
  8001e3:	83 c4 10             	add    $0x10,%esp
  8001e6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		x = smalloc("x", PAGE_SIZE, 1);
  8001e9:	83 ec 04             	sub    $0x4,%esp
  8001ec:	6a 01                	push   $0x1
  8001ee:	68 00 10 00 00       	push   $0x1000
  8001f3:	68 c7 21 80 00       	push   $0x8021c7
  8001f8:	e8 0c 15 00 00       	call   801709 <smalloc>
  8001fd:	83 c4 10             	add    $0x10,%esp
  800200:	89 45 d0             	mov    %eax,-0x30(%ebp)

		if(x == NULL) panic("Wrong free: make sure that you free the shared object by calling free_share_object()");
  800203:	83 7d d0 00          	cmpl   $0x0,-0x30(%ebp)
  800207:	75 14                	jne    80021d <_main+0x1e5>
  800209:	83 ec 04             	sub    $0x4,%esp
  80020c:	68 b8 22 80 00       	push   $0x8022b8
  800211:	6a 32                	push   $0x32
  800213:	68 bc 20 80 00       	push   $0x8020bc
  800218:	e8 8c 04 00 00       	call   8006a9 <_panic>

		if ((freeFrames - sys_calculate_free_frames()) !=  2+1+4) panic("Wrong previous free: make sure that you correctly free shared object before (Step A)");
  80021d:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  800220:	e8 0c 17 00 00       	call   801931 <sys_calculate_free_frames>
  800225:	29 c3                	sub    %eax,%ebx
  800227:	89 d8                	mov    %ebx,%eax
  800229:	83 f8 07             	cmp    $0x7,%eax
  80022c:	74 14                	je     800242 <_main+0x20a>
  80022e:	83 ec 04             	sub    $0x4,%esp
  800231:	68 98 23 80 00       	push   $0x802398
  800236:	6a 34                	push   $0x34
  800238:	68 bc 20 80 00       	push   $0x8020bc
  80023d:	e8 67 04 00 00       	call   8006a9 <_panic>

		sfree(z);
  800242:	83 ec 0c             	sub    $0xc,%esp
  800245:	ff 75 d4             	pushl  -0x2c(%ebp)
  800248:	e8 f6 14 00 00       	call   801743 <sfree>
  80024d:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong free: check your logic");
  800250:	8b 5d d8             	mov    -0x28(%ebp),%ebx
  800253:	e8 d9 16 00 00       	call   801931 <sys_calculate_free_frames>
  800258:	29 c3                	sub    %eax,%ebx
  80025a:	89 d8                	mov    %ebx,%eax
  80025c:	83 f8 04             	cmp    $0x4,%eax
  80025f:	74 14                	je     800275 <_main+0x23d>
  800261:	83 ec 04             	sub    $0x4,%esp
  800264:	68 ed 23 80 00       	push   $0x8023ed
  800269:	6a 37                	push   $0x37
  80026b:	68 bc 20 80 00       	push   $0x8020bc
  800270:	e8 34 04 00 00       	call   8006a9 <_panic>

		sfree(x);
  800275:	83 ec 0c             	sub    $0xc,%esp
  800278:	ff 75 d0             	pushl  -0x30(%ebp)
  80027b:	e8 c3 14 00 00       	call   801743 <sfree>
  800280:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  0) panic("Wrong free: check your logic");
  800283:	e8 a9 16 00 00       	call   801931 <sys_calculate_free_frames>
  800288:	89 c2                	mov    %eax,%edx
  80028a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80028d:	39 c2                	cmp    %eax,%edx
  80028f:	74 14                	je     8002a5 <_main+0x26d>
  800291:	83 ec 04             	sub    $0x4,%esp
  800294:	68 ed 23 80 00       	push   $0x8023ed
  800299:	6a 3a                	push   $0x3a
  80029b:	68 bc 20 80 00       	push   $0x8020bc
  8002a0:	e8 04 04 00 00       	call   8006a9 <_panic>

	}
	cprintf("Step B completed successfully!!\n\n\n");
  8002a5:	83 ec 0c             	sub    $0xc,%esp
  8002a8:	68 0c 24 80 00       	push   $0x80240c
  8002ad:	e8 99 06 00 00       	call   80094b <cprintf>
  8002b2:	83 c4 10             	add    $0x10,%esp

	cprintf("STEP C: checking range of loop during free... \n");
  8002b5:	83 ec 0c             	sub    $0xc,%esp
  8002b8:	68 30 24 80 00       	push   $0x802430
  8002bd:	e8 89 06 00 00       	call   80094b <cprintf>
  8002c2:	83 c4 10             	add    $0x10,%esp
	{
		uint32 *w, *u;
		int freeFrames = sys_calculate_free_frames() ;
  8002c5:	e8 67 16 00 00       	call   801931 <sys_calculate_free_frames>
  8002ca:	89 45 cc             	mov    %eax,-0x34(%ebp)
		w = smalloc("w", 3 * PAGE_SIZE+1, 1);
  8002cd:	83 ec 04             	sub    $0x4,%esp
  8002d0:	6a 01                	push   $0x1
  8002d2:	68 01 30 00 00       	push   $0x3001
  8002d7:	68 60 24 80 00       	push   $0x802460
  8002dc:	e8 28 14 00 00       	call   801709 <smalloc>
  8002e1:	83 c4 10             	add    $0x10,%esp
  8002e4:	89 45 c8             	mov    %eax,-0x38(%ebp)
		u = smalloc("u", PAGE_SIZE, 1);
  8002e7:	83 ec 04             	sub    $0x4,%esp
  8002ea:	6a 01                	push   $0x1
  8002ec:	68 00 10 00 00       	push   $0x1000
  8002f1:	68 62 24 80 00       	push   $0x802462
  8002f6:	e8 0e 14 00 00       	call   801709 <smalloc>
  8002fb:	83 c4 10             	add    $0x10,%esp
  8002fe:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		if ((freeFrames - sys_calculate_free_frames()) != 5+1+4) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800301:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  800304:	e8 28 16 00 00       	call   801931 <sys_calculate_free_frames>
  800309:	29 c3                	sub    %eax,%ebx
  80030b:	89 d8                	mov    %ebx,%eax
  80030d:	83 f8 0a             	cmp    $0xa,%eax
  800310:	74 14                	je     800326 <_main+0x2ee>
  800312:	83 ec 04             	sub    $0x4,%esp
  800315:	68 38 22 80 00       	push   $0x802238
  80031a:	6a 45                	push   $0x45
  80031c:	68 bc 20 80 00       	push   $0x8020bc
  800321:	e8 83 03 00 00       	call   8006a9 <_panic>

		sfree(w);
  800326:	83 ec 0c             	sub    $0xc,%esp
  800329:	ff 75 c8             	pushl  -0x38(%ebp)
  80032c:	e8 12 14 00 00       	call   801743 <sfree>
  800331:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong free: check your logic");
  800334:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  800337:	e8 f5 15 00 00       	call   801931 <sys_calculate_free_frames>
  80033c:	29 c3                	sub    %eax,%ebx
  80033e:	89 d8                	mov    %ebx,%eax
  800340:	83 f8 04             	cmp    $0x4,%eax
  800343:	74 14                	je     800359 <_main+0x321>
  800345:	83 ec 04             	sub    $0x4,%esp
  800348:	68 ed 23 80 00       	push   $0x8023ed
  80034d:	6a 48                	push   $0x48
  80034f:	68 bc 20 80 00       	push   $0x8020bc
  800354:	e8 50 03 00 00       	call   8006a9 <_panic>

		uint32 *o;

		o = smalloc("o", 2 * PAGE_SIZE-1,1);
  800359:	83 ec 04             	sub    $0x4,%esp
  80035c:	6a 01                	push   $0x1
  80035e:	68 ff 1f 00 00       	push   $0x1fff
  800363:	68 64 24 80 00       	push   $0x802464
  800368:	e8 9c 13 00 00       	call   801709 <smalloc>
  80036d:	83 c4 10             	add    $0x10,%esp
  800370:	89 45 c0             	mov    %eax,-0x40(%ebp)

		cprintf("2\n");
  800373:	83 ec 0c             	sub    $0xc,%esp
  800376:	68 66 24 80 00       	push   $0x802466
  80037b:	e8 cb 05 00 00       	call   80094b <cprintf>
  800380:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) != 3+1+4) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800383:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  800386:	e8 a6 15 00 00       	call   801931 <sys_calculate_free_frames>
  80038b:	29 c3                	sub    %eax,%ebx
  80038d:	89 d8                	mov    %ebx,%eax
  80038f:	83 f8 08             	cmp    $0x8,%eax
  800392:	74 14                	je     8003a8 <_main+0x370>
  800394:	83 ec 04             	sub    $0x4,%esp
  800397:	68 38 22 80 00       	push   $0x802238
  80039c:	6a 4f                	push   $0x4f
  80039e:	68 bc 20 80 00       	push   $0x8020bc
  8003a3:	e8 01 03 00 00       	call   8006a9 <_panic>

		sfree(o);
  8003a8:	83 ec 0c             	sub    $0xc,%esp
  8003ab:	ff 75 c0             	pushl  -0x40(%ebp)
  8003ae:	e8 90 13 00 00       	call   801743 <sfree>
  8003b3:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  1+1+2) panic("Wrong free: check your logic");
  8003b6:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  8003b9:	e8 73 15 00 00       	call   801931 <sys_calculate_free_frames>
  8003be:	29 c3                	sub    %eax,%ebx
  8003c0:	89 d8                	mov    %ebx,%eax
  8003c2:	83 f8 04             	cmp    $0x4,%eax
  8003c5:	74 14                	je     8003db <_main+0x3a3>
  8003c7:	83 ec 04             	sub    $0x4,%esp
  8003ca:	68 ed 23 80 00       	push   $0x8023ed
  8003cf:	6a 52                	push   $0x52
  8003d1:	68 bc 20 80 00       	push   $0x8020bc
  8003d6:	e8 ce 02 00 00       	call   8006a9 <_panic>

		sfree(u);
  8003db:	83 ec 0c             	sub    $0xc,%esp
  8003de:	ff 75 c4             	pushl  -0x3c(%ebp)
  8003e1:	e8 5d 13 00 00       	call   801743 <sfree>
  8003e6:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  0) panic("Wrong free: check your logic");
  8003e9:	e8 43 15 00 00       	call   801931 <sys_calculate_free_frames>
  8003ee:	89 c2                	mov    %eax,%edx
  8003f0:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8003f3:	39 c2                	cmp    %eax,%edx
  8003f5:	74 14                	je     80040b <_main+0x3d3>
  8003f7:	83 ec 04             	sub    $0x4,%esp
  8003fa:	68 ed 23 80 00       	push   $0x8023ed
  8003ff:	6a 55                	push   $0x55
  800401:	68 bc 20 80 00       	push   $0x8020bc
  800406:	e8 9e 02 00 00       	call   8006a9 <_panic>


		//Checking boundaries of page tables
		freeFrames = sys_calculate_free_frames() ;
  80040b:	e8 21 15 00 00       	call   801931 <sys_calculate_free_frames>
  800410:	89 45 cc             	mov    %eax,-0x34(%ebp)
		w = smalloc("w", 3 * Mega - 1*kilo, 1);
  800413:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800416:	89 c2                	mov    %eax,%edx
  800418:	01 d2                	add    %edx,%edx
  80041a:	01 d0                	add    %edx,%eax
  80041c:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80041f:	83 ec 04             	sub    $0x4,%esp
  800422:	6a 01                	push   $0x1
  800424:	50                   	push   %eax
  800425:	68 60 24 80 00       	push   $0x802460
  80042a:	e8 da 12 00 00       	call   801709 <smalloc>
  80042f:	83 c4 10             	add    $0x10,%esp
  800432:	89 45 c8             	mov    %eax,-0x38(%ebp)
		u = smalloc("u", 7 * Mega - 1*kilo, 1);
  800435:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800438:	89 d0                	mov    %edx,%eax
  80043a:	01 c0                	add    %eax,%eax
  80043c:	01 d0                	add    %edx,%eax
  80043e:	01 c0                	add    %eax,%eax
  800440:	01 d0                	add    %edx,%eax
  800442:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800445:	83 ec 04             	sub    $0x4,%esp
  800448:	6a 01                	push   $0x1
  80044a:	50                   	push   %eax
  80044b:	68 62 24 80 00       	push   $0x802462
  800450:	e8 b4 12 00 00       	call   801709 <smalloc>
  800455:	83 c4 10             	add    $0x10,%esp
  800458:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		o = smalloc("o", 2 * Mega + 1*kilo, 1);
  80045b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80045e:	01 c0                	add    %eax,%eax
  800460:	89 c2                	mov    %eax,%edx
  800462:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800465:	01 d0                	add    %edx,%eax
  800467:	83 ec 04             	sub    $0x4,%esp
  80046a:	6a 01                	push   $0x1
  80046c:	50                   	push   %eax
  80046d:	68 64 24 80 00       	push   $0x802464
  800472:	e8 92 12 00 00       	call   801709 <smalloc>
  800477:	83 c4 10             	add    $0x10,%esp
  80047a:	89 45 c0             	mov    %eax,-0x40(%ebp)

		if ((freeFrames - sys_calculate_free_frames()) != 3073+4+7) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  80047d:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  800480:	e8 ac 14 00 00       	call   801931 <sys_calculate_free_frames>
  800485:	29 c3                	sub    %eax,%ebx
  800487:	89 d8                	mov    %ebx,%eax
  800489:	3d 0c 0c 00 00       	cmp    $0xc0c,%eax
  80048e:	74 14                	je     8004a4 <_main+0x46c>
  800490:	83 ec 04             	sub    $0x4,%esp
  800493:	68 38 22 80 00       	push   $0x802238
  800498:	6a 5e                	push   $0x5e
  80049a:	68 bc 20 80 00       	push   $0x8020bc
  80049f:	e8 05 02 00 00       	call   8006a9 <_panic>

		sfree(o);
  8004a4:	83 ec 0c             	sub    $0xc,%esp
  8004a7:	ff 75 c0             	pushl  -0x40(%ebp)
  8004aa:	e8 94 12 00 00       	call   801743 <sfree>
  8004af:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  2560+3+5) panic("Wrong free: check your logic");
  8004b2:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  8004b5:	e8 77 14 00 00       	call   801931 <sys_calculate_free_frames>
  8004ba:	29 c3                	sub    %eax,%ebx
  8004bc:	89 d8                	mov    %ebx,%eax
  8004be:	3d 08 0a 00 00       	cmp    $0xa08,%eax
  8004c3:	74 14                	je     8004d9 <_main+0x4a1>
  8004c5:	83 ec 04             	sub    $0x4,%esp
  8004c8:	68 ed 23 80 00       	push   $0x8023ed
  8004cd:	6a 61                	push   $0x61
  8004cf:	68 bc 20 80 00       	push   $0x8020bc
  8004d4:	e8 d0 01 00 00       	call   8006a9 <_panic>

		sfree(w);
  8004d9:	83 ec 0c             	sub    $0xc,%esp
  8004dc:	ff 75 c8             	pushl  -0x38(%ebp)
  8004df:	e8 5f 12 00 00       	call   801743 <sfree>
  8004e4:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  1792+3+3) panic("Wrong free: check your logic");
  8004e7:	8b 5d cc             	mov    -0x34(%ebp),%ebx
  8004ea:	e8 42 14 00 00       	call   801931 <sys_calculate_free_frames>
  8004ef:	29 c3                	sub    %eax,%ebx
  8004f1:	89 d8                	mov    %ebx,%eax
  8004f3:	3d 06 07 00 00       	cmp    $0x706,%eax
  8004f8:	74 14                	je     80050e <_main+0x4d6>
  8004fa:	83 ec 04             	sub    $0x4,%esp
  8004fd:	68 ed 23 80 00       	push   $0x8023ed
  800502:	6a 64                	push   $0x64
  800504:	68 bc 20 80 00       	push   $0x8020bc
  800509:	e8 9b 01 00 00       	call   8006a9 <_panic>

		sfree(u);
  80050e:	83 ec 0c             	sub    $0xc,%esp
  800511:	ff 75 c4             	pushl  -0x3c(%ebp)
  800514:	e8 2a 12 00 00       	call   801743 <sfree>
  800519:	83 c4 10             	add    $0x10,%esp
		if ((freeFrames - sys_calculate_free_frames()) !=  0) panic("Wrong free: check your logic");
  80051c:	e8 10 14 00 00       	call   801931 <sys_calculate_free_frames>
  800521:	89 c2                	mov    %eax,%edx
  800523:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800526:	39 c2                	cmp    %eax,%edx
  800528:	74 14                	je     80053e <_main+0x506>
  80052a:	83 ec 04             	sub    $0x4,%esp
  80052d:	68 ed 23 80 00       	push   $0x8023ed
  800532:	6a 67                	push   $0x67
  800534:	68 bc 20 80 00       	push   $0x8020bc
  800539:	e8 6b 01 00 00       	call   8006a9 <_panic>
	}
	cprintf("Step C completed successfully!!\n\n\n");
  80053e:	83 ec 0c             	sub    $0xc,%esp
  800541:	68 6c 24 80 00       	push   $0x80246c
  800546:	e8 00 04 00 00       	call   80094b <cprintf>
  80054b:	83 c4 10             	add    $0x10,%esp

	cprintf("Congratulations!! Test of freeSharedObjects [4] completed successfully!!\n\n\n");
  80054e:	83 ec 0c             	sub    $0xc,%esp
  800551:	68 90 24 80 00       	push   $0x802490
  800556:	e8 f0 03 00 00       	call   80094b <cprintf>
  80055b:	83 c4 10             	add    $0x10,%esp

	return;
  80055e:	90                   	nop
}
  80055f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800562:	c9                   	leave  
  800563:	c3                   	ret    

00800564 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800564:	55                   	push   %ebp
  800565:	89 e5                	mov    %esp,%ebp
  800567:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80056a:	e8 f7 12 00 00       	call   801866 <sys_getenvindex>
  80056f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800572:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800575:	89 d0                	mov    %edx,%eax
  800577:	c1 e0 03             	shl    $0x3,%eax
  80057a:	01 d0                	add    %edx,%eax
  80057c:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800583:	01 c8                	add    %ecx,%eax
  800585:	01 c0                	add    %eax,%eax
  800587:	01 d0                	add    %edx,%eax
  800589:	01 c0                	add    %eax,%eax
  80058b:	01 d0                	add    %edx,%eax
  80058d:	89 c2                	mov    %eax,%edx
  80058f:	c1 e2 05             	shl    $0x5,%edx
  800592:	29 c2                	sub    %eax,%edx
  800594:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80059b:	89 c2                	mov    %eax,%edx
  80059d:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8005a3:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8005a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ad:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8005b3:	84 c0                	test   %al,%al
  8005b5:	74 0f                	je     8005c6 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8005b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8005bc:	05 40 3c 01 00       	add    $0x13c40,%eax
  8005c1:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8005c6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8005ca:	7e 0a                	jle    8005d6 <libmain+0x72>
		binaryname = argv[0];
  8005cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005cf:	8b 00                	mov    (%eax),%eax
  8005d1:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8005d6:	83 ec 08             	sub    $0x8,%esp
  8005d9:	ff 75 0c             	pushl  0xc(%ebp)
  8005dc:	ff 75 08             	pushl  0x8(%ebp)
  8005df:	e8 54 fa ff ff       	call   800038 <_main>
  8005e4:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8005e7:	e8 15 14 00 00       	call   801a01 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8005ec:	83 ec 0c             	sub    $0xc,%esp
  8005ef:	68 f4 24 80 00       	push   $0x8024f4
  8005f4:	e8 52 03 00 00       	call   80094b <cprintf>
  8005f9:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8005fc:	a1 20 30 80 00       	mov    0x803020,%eax
  800601:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800607:	a1 20 30 80 00       	mov    0x803020,%eax
  80060c:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800612:	83 ec 04             	sub    $0x4,%esp
  800615:	52                   	push   %edx
  800616:	50                   	push   %eax
  800617:	68 1c 25 80 00       	push   $0x80251c
  80061c:	e8 2a 03 00 00       	call   80094b <cprintf>
  800621:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800624:	a1 20 30 80 00       	mov    0x803020,%eax
  800629:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  80062f:	a1 20 30 80 00       	mov    0x803020,%eax
  800634:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80063a:	83 ec 04             	sub    $0x4,%esp
  80063d:	52                   	push   %edx
  80063e:	50                   	push   %eax
  80063f:	68 44 25 80 00       	push   $0x802544
  800644:	e8 02 03 00 00       	call   80094b <cprintf>
  800649:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80064c:	a1 20 30 80 00       	mov    0x803020,%eax
  800651:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800657:	83 ec 08             	sub    $0x8,%esp
  80065a:	50                   	push   %eax
  80065b:	68 85 25 80 00       	push   $0x802585
  800660:	e8 e6 02 00 00       	call   80094b <cprintf>
  800665:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800668:	83 ec 0c             	sub    $0xc,%esp
  80066b:	68 f4 24 80 00       	push   $0x8024f4
  800670:	e8 d6 02 00 00       	call   80094b <cprintf>
  800675:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800678:	e8 9e 13 00 00       	call   801a1b <sys_enable_interrupt>

	// exit gracefully
	exit();
  80067d:	e8 19 00 00 00       	call   80069b <exit>
}
  800682:	90                   	nop
  800683:	c9                   	leave  
  800684:	c3                   	ret    

00800685 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800685:	55                   	push   %ebp
  800686:	89 e5                	mov    %esp,%ebp
  800688:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80068b:	83 ec 0c             	sub    $0xc,%esp
  80068e:	6a 00                	push   $0x0
  800690:	e8 9d 11 00 00       	call   801832 <sys_env_destroy>
  800695:	83 c4 10             	add    $0x10,%esp
}
  800698:	90                   	nop
  800699:	c9                   	leave  
  80069a:	c3                   	ret    

0080069b <exit>:

void
exit(void)
{
  80069b:	55                   	push   %ebp
  80069c:	89 e5                	mov    %esp,%ebp
  80069e:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006a1:	e8 f2 11 00 00       	call   801898 <sys_env_exit>
}
  8006a6:	90                   	nop
  8006a7:	c9                   	leave  
  8006a8:	c3                   	ret    

008006a9 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006a9:	55                   	push   %ebp
  8006aa:	89 e5                	mov    %esp,%ebp
  8006ac:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8006af:	8d 45 10             	lea    0x10(%ebp),%eax
  8006b2:	83 c0 04             	add    $0x4,%eax
  8006b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8006b8:	a1 18 31 80 00       	mov    0x803118,%eax
  8006bd:	85 c0                	test   %eax,%eax
  8006bf:	74 16                	je     8006d7 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8006c1:	a1 18 31 80 00       	mov    0x803118,%eax
  8006c6:	83 ec 08             	sub    $0x8,%esp
  8006c9:	50                   	push   %eax
  8006ca:	68 9c 25 80 00       	push   $0x80259c
  8006cf:	e8 77 02 00 00       	call   80094b <cprintf>
  8006d4:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8006d7:	a1 00 30 80 00       	mov    0x803000,%eax
  8006dc:	ff 75 0c             	pushl  0xc(%ebp)
  8006df:	ff 75 08             	pushl  0x8(%ebp)
  8006e2:	50                   	push   %eax
  8006e3:	68 a1 25 80 00       	push   $0x8025a1
  8006e8:	e8 5e 02 00 00       	call   80094b <cprintf>
  8006ed:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8006f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8006f3:	83 ec 08             	sub    $0x8,%esp
  8006f6:	ff 75 f4             	pushl  -0xc(%ebp)
  8006f9:	50                   	push   %eax
  8006fa:	e8 e1 01 00 00       	call   8008e0 <vcprintf>
  8006ff:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800702:	83 ec 08             	sub    $0x8,%esp
  800705:	6a 00                	push   $0x0
  800707:	68 bd 25 80 00       	push   $0x8025bd
  80070c:	e8 cf 01 00 00       	call   8008e0 <vcprintf>
  800711:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800714:	e8 82 ff ff ff       	call   80069b <exit>

	// should not return here
	while (1) ;
  800719:	eb fe                	jmp    800719 <_panic+0x70>

0080071b <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80071b:	55                   	push   %ebp
  80071c:	89 e5                	mov    %esp,%ebp
  80071e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800721:	a1 20 30 80 00       	mov    0x803020,%eax
  800726:	8b 50 74             	mov    0x74(%eax),%edx
  800729:	8b 45 0c             	mov    0xc(%ebp),%eax
  80072c:	39 c2                	cmp    %eax,%edx
  80072e:	74 14                	je     800744 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800730:	83 ec 04             	sub    $0x4,%esp
  800733:	68 c0 25 80 00       	push   $0x8025c0
  800738:	6a 26                	push   $0x26
  80073a:	68 0c 26 80 00       	push   $0x80260c
  80073f:	e8 65 ff ff ff       	call   8006a9 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800744:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80074b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800752:	e9 b6 00 00 00       	jmp    80080d <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800757:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80075a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800761:	8b 45 08             	mov    0x8(%ebp),%eax
  800764:	01 d0                	add    %edx,%eax
  800766:	8b 00                	mov    (%eax),%eax
  800768:	85 c0                	test   %eax,%eax
  80076a:	75 08                	jne    800774 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80076c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80076f:	e9 96 00 00 00       	jmp    80080a <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800774:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80077b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800782:	eb 5d                	jmp    8007e1 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800784:	a1 20 30 80 00       	mov    0x803020,%eax
  800789:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80078f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800792:	c1 e2 04             	shl    $0x4,%edx
  800795:	01 d0                	add    %edx,%eax
  800797:	8a 40 04             	mov    0x4(%eax),%al
  80079a:	84 c0                	test   %al,%al
  80079c:	75 40                	jne    8007de <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80079e:	a1 20 30 80 00       	mov    0x803020,%eax
  8007a3:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8007a9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007ac:	c1 e2 04             	shl    $0x4,%edx
  8007af:	01 d0                	add    %edx,%eax
  8007b1:	8b 00                	mov    (%eax),%eax
  8007b3:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8007b6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8007b9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8007be:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8007c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007c3:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8007ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cd:	01 c8                	add    %ecx,%eax
  8007cf:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007d1:	39 c2                	cmp    %eax,%edx
  8007d3:	75 09                	jne    8007de <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  8007d5:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8007dc:	eb 12                	jmp    8007f0 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007de:	ff 45 e8             	incl   -0x18(%ebp)
  8007e1:	a1 20 30 80 00       	mov    0x803020,%eax
  8007e6:	8b 50 74             	mov    0x74(%eax),%edx
  8007e9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8007ec:	39 c2                	cmp    %eax,%edx
  8007ee:	77 94                	ja     800784 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8007f0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8007f4:	75 14                	jne    80080a <CheckWSWithoutLastIndex+0xef>
			panic(
  8007f6:	83 ec 04             	sub    $0x4,%esp
  8007f9:	68 18 26 80 00       	push   $0x802618
  8007fe:	6a 3a                	push   $0x3a
  800800:	68 0c 26 80 00       	push   $0x80260c
  800805:	e8 9f fe ff ff       	call   8006a9 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80080a:	ff 45 f0             	incl   -0x10(%ebp)
  80080d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800810:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800813:	0f 8c 3e ff ff ff    	jl     800757 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800819:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800820:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800827:	eb 20                	jmp    800849 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800829:	a1 20 30 80 00       	mov    0x803020,%eax
  80082e:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800834:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800837:	c1 e2 04             	shl    $0x4,%edx
  80083a:	01 d0                	add    %edx,%eax
  80083c:	8a 40 04             	mov    0x4(%eax),%al
  80083f:	3c 01                	cmp    $0x1,%al
  800841:	75 03                	jne    800846 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800843:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800846:	ff 45 e0             	incl   -0x20(%ebp)
  800849:	a1 20 30 80 00       	mov    0x803020,%eax
  80084e:	8b 50 74             	mov    0x74(%eax),%edx
  800851:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800854:	39 c2                	cmp    %eax,%edx
  800856:	77 d1                	ja     800829 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800858:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80085b:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80085e:	74 14                	je     800874 <CheckWSWithoutLastIndex+0x159>
		panic(
  800860:	83 ec 04             	sub    $0x4,%esp
  800863:	68 6c 26 80 00       	push   $0x80266c
  800868:	6a 44                	push   $0x44
  80086a:	68 0c 26 80 00       	push   $0x80260c
  80086f:	e8 35 fe ff ff       	call   8006a9 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800874:	90                   	nop
  800875:	c9                   	leave  
  800876:	c3                   	ret    

00800877 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800877:	55                   	push   %ebp
  800878:	89 e5                	mov    %esp,%ebp
  80087a:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80087d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800880:	8b 00                	mov    (%eax),%eax
  800882:	8d 48 01             	lea    0x1(%eax),%ecx
  800885:	8b 55 0c             	mov    0xc(%ebp),%edx
  800888:	89 0a                	mov    %ecx,(%edx)
  80088a:	8b 55 08             	mov    0x8(%ebp),%edx
  80088d:	88 d1                	mov    %dl,%cl
  80088f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800892:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800896:	8b 45 0c             	mov    0xc(%ebp),%eax
  800899:	8b 00                	mov    (%eax),%eax
  80089b:	3d ff 00 00 00       	cmp    $0xff,%eax
  8008a0:	75 2c                	jne    8008ce <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8008a2:	a0 24 30 80 00       	mov    0x803024,%al
  8008a7:	0f b6 c0             	movzbl %al,%eax
  8008aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008ad:	8b 12                	mov    (%edx),%edx
  8008af:	89 d1                	mov    %edx,%ecx
  8008b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008b4:	83 c2 08             	add    $0x8,%edx
  8008b7:	83 ec 04             	sub    $0x4,%esp
  8008ba:	50                   	push   %eax
  8008bb:	51                   	push   %ecx
  8008bc:	52                   	push   %edx
  8008bd:	e8 2e 0f 00 00       	call   8017f0 <sys_cputs>
  8008c2:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8008c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8008ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008d1:	8b 40 04             	mov    0x4(%eax),%eax
  8008d4:	8d 50 01             	lea    0x1(%eax),%edx
  8008d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008da:	89 50 04             	mov    %edx,0x4(%eax)
}
  8008dd:	90                   	nop
  8008de:	c9                   	leave  
  8008df:	c3                   	ret    

008008e0 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8008e0:	55                   	push   %ebp
  8008e1:	89 e5                	mov    %esp,%ebp
  8008e3:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8008e9:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8008f0:	00 00 00 
	b.cnt = 0;
  8008f3:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8008fa:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8008fd:	ff 75 0c             	pushl  0xc(%ebp)
  800900:	ff 75 08             	pushl  0x8(%ebp)
  800903:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800909:	50                   	push   %eax
  80090a:	68 77 08 80 00       	push   $0x800877
  80090f:	e8 11 02 00 00       	call   800b25 <vprintfmt>
  800914:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800917:	a0 24 30 80 00       	mov    0x803024,%al
  80091c:	0f b6 c0             	movzbl %al,%eax
  80091f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800925:	83 ec 04             	sub    $0x4,%esp
  800928:	50                   	push   %eax
  800929:	52                   	push   %edx
  80092a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800930:	83 c0 08             	add    $0x8,%eax
  800933:	50                   	push   %eax
  800934:	e8 b7 0e 00 00       	call   8017f0 <sys_cputs>
  800939:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80093c:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800943:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800949:	c9                   	leave  
  80094a:	c3                   	ret    

0080094b <cprintf>:

int cprintf(const char *fmt, ...) {
  80094b:	55                   	push   %ebp
  80094c:	89 e5                	mov    %esp,%ebp
  80094e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800951:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800958:	8d 45 0c             	lea    0xc(%ebp),%eax
  80095b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80095e:	8b 45 08             	mov    0x8(%ebp),%eax
  800961:	83 ec 08             	sub    $0x8,%esp
  800964:	ff 75 f4             	pushl  -0xc(%ebp)
  800967:	50                   	push   %eax
  800968:	e8 73 ff ff ff       	call   8008e0 <vcprintf>
  80096d:	83 c4 10             	add    $0x10,%esp
  800970:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800973:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800976:	c9                   	leave  
  800977:	c3                   	ret    

00800978 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800978:	55                   	push   %ebp
  800979:	89 e5                	mov    %esp,%ebp
  80097b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80097e:	e8 7e 10 00 00       	call   801a01 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800983:	8d 45 0c             	lea    0xc(%ebp),%eax
  800986:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800989:	8b 45 08             	mov    0x8(%ebp),%eax
  80098c:	83 ec 08             	sub    $0x8,%esp
  80098f:	ff 75 f4             	pushl  -0xc(%ebp)
  800992:	50                   	push   %eax
  800993:	e8 48 ff ff ff       	call   8008e0 <vcprintf>
  800998:	83 c4 10             	add    $0x10,%esp
  80099b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80099e:	e8 78 10 00 00       	call   801a1b <sys_enable_interrupt>
	return cnt;
  8009a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009a6:	c9                   	leave  
  8009a7:	c3                   	ret    

008009a8 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8009a8:	55                   	push   %ebp
  8009a9:	89 e5                	mov    %esp,%ebp
  8009ab:	53                   	push   %ebx
  8009ac:	83 ec 14             	sub    $0x14,%esp
  8009af:	8b 45 10             	mov    0x10(%ebp),%eax
  8009b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8009b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8009bb:	8b 45 18             	mov    0x18(%ebp),%eax
  8009be:	ba 00 00 00 00       	mov    $0x0,%edx
  8009c3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009c6:	77 55                	ja     800a1d <printnum+0x75>
  8009c8:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8009cb:	72 05                	jb     8009d2 <printnum+0x2a>
  8009cd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8009d0:	77 4b                	ja     800a1d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8009d2:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8009d5:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8009d8:	8b 45 18             	mov    0x18(%ebp),%eax
  8009db:	ba 00 00 00 00       	mov    $0x0,%edx
  8009e0:	52                   	push   %edx
  8009e1:	50                   	push   %eax
  8009e2:	ff 75 f4             	pushl  -0xc(%ebp)
  8009e5:	ff 75 f0             	pushl  -0x10(%ebp)
  8009e8:	e8 37 14 00 00       	call   801e24 <__udivdi3>
  8009ed:	83 c4 10             	add    $0x10,%esp
  8009f0:	83 ec 04             	sub    $0x4,%esp
  8009f3:	ff 75 20             	pushl  0x20(%ebp)
  8009f6:	53                   	push   %ebx
  8009f7:	ff 75 18             	pushl  0x18(%ebp)
  8009fa:	52                   	push   %edx
  8009fb:	50                   	push   %eax
  8009fc:	ff 75 0c             	pushl  0xc(%ebp)
  8009ff:	ff 75 08             	pushl  0x8(%ebp)
  800a02:	e8 a1 ff ff ff       	call   8009a8 <printnum>
  800a07:	83 c4 20             	add    $0x20,%esp
  800a0a:	eb 1a                	jmp    800a26 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a0c:	83 ec 08             	sub    $0x8,%esp
  800a0f:	ff 75 0c             	pushl  0xc(%ebp)
  800a12:	ff 75 20             	pushl  0x20(%ebp)
  800a15:	8b 45 08             	mov    0x8(%ebp),%eax
  800a18:	ff d0                	call   *%eax
  800a1a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a1d:	ff 4d 1c             	decl   0x1c(%ebp)
  800a20:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a24:	7f e6                	jg     800a0c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a26:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a29:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a2e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a31:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a34:	53                   	push   %ebx
  800a35:	51                   	push   %ecx
  800a36:	52                   	push   %edx
  800a37:	50                   	push   %eax
  800a38:	e8 f7 14 00 00       	call   801f34 <__umoddi3>
  800a3d:	83 c4 10             	add    $0x10,%esp
  800a40:	05 d4 28 80 00       	add    $0x8028d4,%eax
  800a45:	8a 00                	mov    (%eax),%al
  800a47:	0f be c0             	movsbl %al,%eax
  800a4a:	83 ec 08             	sub    $0x8,%esp
  800a4d:	ff 75 0c             	pushl  0xc(%ebp)
  800a50:	50                   	push   %eax
  800a51:	8b 45 08             	mov    0x8(%ebp),%eax
  800a54:	ff d0                	call   *%eax
  800a56:	83 c4 10             	add    $0x10,%esp
}
  800a59:	90                   	nop
  800a5a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800a5d:	c9                   	leave  
  800a5e:	c3                   	ret    

00800a5f <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800a5f:	55                   	push   %ebp
  800a60:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800a62:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800a66:	7e 1c                	jle    800a84 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800a68:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6b:	8b 00                	mov    (%eax),%eax
  800a6d:	8d 50 08             	lea    0x8(%eax),%edx
  800a70:	8b 45 08             	mov    0x8(%ebp),%eax
  800a73:	89 10                	mov    %edx,(%eax)
  800a75:	8b 45 08             	mov    0x8(%ebp),%eax
  800a78:	8b 00                	mov    (%eax),%eax
  800a7a:	83 e8 08             	sub    $0x8,%eax
  800a7d:	8b 50 04             	mov    0x4(%eax),%edx
  800a80:	8b 00                	mov    (%eax),%eax
  800a82:	eb 40                	jmp    800ac4 <getuint+0x65>
	else if (lflag)
  800a84:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a88:	74 1e                	je     800aa8 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800a8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8d:	8b 00                	mov    (%eax),%eax
  800a8f:	8d 50 04             	lea    0x4(%eax),%edx
  800a92:	8b 45 08             	mov    0x8(%ebp),%eax
  800a95:	89 10                	mov    %edx,(%eax)
  800a97:	8b 45 08             	mov    0x8(%ebp),%eax
  800a9a:	8b 00                	mov    (%eax),%eax
  800a9c:	83 e8 04             	sub    $0x4,%eax
  800a9f:	8b 00                	mov    (%eax),%eax
  800aa1:	ba 00 00 00 00       	mov    $0x0,%edx
  800aa6:	eb 1c                	jmp    800ac4 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800aa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aab:	8b 00                	mov    (%eax),%eax
  800aad:	8d 50 04             	lea    0x4(%eax),%edx
  800ab0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab3:	89 10                	mov    %edx,(%eax)
  800ab5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab8:	8b 00                	mov    (%eax),%eax
  800aba:	83 e8 04             	sub    $0x4,%eax
  800abd:	8b 00                	mov    (%eax),%eax
  800abf:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800ac4:	5d                   	pop    %ebp
  800ac5:	c3                   	ret    

00800ac6 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800ac6:	55                   	push   %ebp
  800ac7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ac9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800acd:	7e 1c                	jle    800aeb <getint+0x25>
		return va_arg(*ap, long long);
  800acf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad2:	8b 00                	mov    (%eax),%eax
  800ad4:	8d 50 08             	lea    0x8(%eax),%edx
  800ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ada:	89 10                	mov    %edx,(%eax)
  800adc:	8b 45 08             	mov    0x8(%ebp),%eax
  800adf:	8b 00                	mov    (%eax),%eax
  800ae1:	83 e8 08             	sub    $0x8,%eax
  800ae4:	8b 50 04             	mov    0x4(%eax),%edx
  800ae7:	8b 00                	mov    (%eax),%eax
  800ae9:	eb 38                	jmp    800b23 <getint+0x5d>
	else if (lflag)
  800aeb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800aef:	74 1a                	je     800b0b <getint+0x45>
		return va_arg(*ap, long);
  800af1:	8b 45 08             	mov    0x8(%ebp),%eax
  800af4:	8b 00                	mov    (%eax),%eax
  800af6:	8d 50 04             	lea    0x4(%eax),%edx
  800af9:	8b 45 08             	mov    0x8(%ebp),%eax
  800afc:	89 10                	mov    %edx,(%eax)
  800afe:	8b 45 08             	mov    0x8(%ebp),%eax
  800b01:	8b 00                	mov    (%eax),%eax
  800b03:	83 e8 04             	sub    $0x4,%eax
  800b06:	8b 00                	mov    (%eax),%eax
  800b08:	99                   	cltd   
  800b09:	eb 18                	jmp    800b23 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0e:	8b 00                	mov    (%eax),%eax
  800b10:	8d 50 04             	lea    0x4(%eax),%edx
  800b13:	8b 45 08             	mov    0x8(%ebp),%eax
  800b16:	89 10                	mov    %edx,(%eax)
  800b18:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1b:	8b 00                	mov    (%eax),%eax
  800b1d:	83 e8 04             	sub    $0x4,%eax
  800b20:	8b 00                	mov    (%eax),%eax
  800b22:	99                   	cltd   
}
  800b23:	5d                   	pop    %ebp
  800b24:	c3                   	ret    

00800b25 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b25:	55                   	push   %ebp
  800b26:	89 e5                	mov    %esp,%ebp
  800b28:	56                   	push   %esi
  800b29:	53                   	push   %ebx
  800b2a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b2d:	eb 17                	jmp    800b46 <vprintfmt+0x21>
			if (ch == '\0')
  800b2f:	85 db                	test   %ebx,%ebx
  800b31:	0f 84 af 03 00 00    	je     800ee6 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b37:	83 ec 08             	sub    $0x8,%esp
  800b3a:	ff 75 0c             	pushl  0xc(%ebp)
  800b3d:	53                   	push   %ebx
  800b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b41:	ff d0                	call   *%eax
  800b43:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b46:	8b 45 10             	mov    0x10(%ebp),%eax
  800b49:	8d 50 01             	lea    0x1(%eax),%edx
  800b4c:	89 55 10             	mov    %edx,0x10(%ebp)
  800b4f:	8a 00                	mov    (%eax),%al
  800b51:	0f b6 d8             	movzbl %al,%ebx
  800b54:	83 fb 25             	cmp    $0x25,%ebx
  800b57:	75 d6                	jne    800b2f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800b59:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800b5d:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800b64:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800b6b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800b72:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800b79:	8b 45 10             	mov    0x10(%ebp),%eax
  800b7c:	8d 50 01             	lea    0x1(%eax),%edx
  800b7f:	89 55 10             	mov    %edx,0x10(%ebp)
  800b82:	8a 00                	mov    (%eax),%al
  800b84:	0f b6 d8             	movzbl %al,%ebx
  800b87:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800b8a:	83 f8 55             	cmp    $0x55,%eax
  800b8d:	0f 87 2b 03 00 00    	ja     800ebe <vprintfmt+0x399>
  800b93:	8b 04 85 f8 28 80 00 	mov    0x8028f8(,%eax,4),%eax
  800b9a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800b9c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800ba0:	eb d7                	jmp    800b79 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800ba2:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800ba6:	eb d1                	jmp    800b79 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ba8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800baf:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800bb2:	89 d0                	mov    %edx,%eax
  800bb4:	c1 e0 02             	shl    $0x2,%eax
  800bb7:	01 d0                	add    %edx,%eax
  800bb9:	01 c0                	add    %eax,%eax
  800bbb:	01 d8                	add    %ebx,%eax
  800bbd:	83 e8 30             	sub    $0x30,%eax
  800bc0:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800bc3:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc6:	8a 00                	mov    (%eax),%al
  800bc8:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800bcb:	83 fb 2f             	cmp    $0x2f,%ebx
  800bce:	7e 3e                	jle    800c0e <vprintfmt+0xe9>
  800bd0:	83 fb 39             	cmp    $0x39,%ebx
  800bd3:	7f 39                	jg     800c0e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800bd5:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800bd8:	eb d5                	jmp    800baf <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800bda:	8b 45 14             	mov    0x14(%ebp),%eax
  800bdd:	83 c0 04             	add    $0x4,%eax
  800be0:	89 45 14             	mov    %eax,0x14(%ebp)
  800be3:	8b 45 14             	mov    0x14(%ebp),%eax
  800be6:	83 e8 04             	sub    $0x4,%eax
  800be9:	8b 00                	mov    (%eax),%eax
  800beb:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800bee:	eb 1f                	jmp    800c0f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800bf0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bf4:	79 83                	jns    800b79 <vprintfmt+0x54>
				width = 0;
  800bf6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800bfd:	e9 77 ff ff ff       	jmp    800b79 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c02:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c09:	e9 6b ff ff ff       	jmp    800b79 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c0e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c0f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c13:	0f 89 60 ff ff ff    	jns    800b79 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c19:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c1c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c1f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c26:	e9 4e ff ff ff       	jmp    800b79 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c2b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c2e:	e9 46 ff ff ff       	jmp    800b79 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c33:	8b 45 14             	mov    0x14(%ebp),%eax
  800c36:	83 c0 04             	add    $0x4,%eax
  800c39:	89 45 14             	mov    %eax,0x14(%ebp)
  800c3c:	8b 45 14             	mov    0x14(%ebp),%eax
  800c3f:	83 e8 04             	sub    $0x4,%eax
  800c42:	8b 00                	mov    (%eax),%eax
  800c44:	83 ec 08             	sub    $0x8,%esp
  800c47:	ff 75 0c             	pushl  0xc(%ebp)
  800c4a:	50                   	push   %eax
  800c4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4e:	ff d0                	call   *%eax
  800c50:	83 c4 10             	add    $0x10,%esp
			break;
  800c53:	e9 89 02 00 00       	jmp    800ee1 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800c58:	8b 45 14             	mov    0x14(%ebp),%eax
  800c5b:	83 c0 04             	add    $0x4,%eax
  800c5e:	89 45 14             	mov    %eax,0x14(%ebp)
  800c61:	8b 45 14             	mov    0x14(%ebp),%eax
  800c64:	83 e8 04             	sub    $0x4,%eax
  800c67:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800c69:	85 db                	test   %ebx,%ebx
  800c6b:	79 02                	jns    800c6f <vprintfmt+0x14a>
				err = -err;
  800c6d:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800c6f:	83 fb 64             	cmp    $0x64,%ebx
  800c72:	7f 0b                	jg     800c7f <vprintfmt+0x15a>
  800c74:	8b 34 9d 40 27 80 00 	mov    0x802740(,%ebx,4),%esi
  800c7b:	85 f6                	test   %esi,%esi
  800c7d:	75 19                	jne    800c98 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800c7f:	53                   	push   %ebx
  800c80:	68 e5 28 80 00       	push   $0x8028e5
  800c85:	ff 75 0c             	pushl  0xc(%ebp)
  800c88:	ff 75 08             	pushl  0x8(%ebp)
  800c8b:	e8 5e 02 00 00       	call   800eee <printfmt>
  800c90:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800c93:	e9 49 02 00 00       	jmp    800ee1 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800c98:	56                   	push   %esi
  800c99:	68 ee 28 80 00       	push   $0x8028ee
  800c9e:	ff 75 0c             	pushl  0xc(%ebp)
  800ca1:	ff 75 08             	pushl  0x8(%ebp)
  800ca4:	e8 45 02 00 00       	call   800eee <printfmt>
  800ca9:	83 c4 10             	add    $0x10,%esp
			break;
  800cac:	e9 30 02 00 00       	jmp    800ee1 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800cb1:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb4:	83 c0 04             	add    $0x4,%eax
  800cb7:	89 45 14             	mov    %eax,0x14(%ebp)
  800cba:	8b 45 14             	mov    0x14(%ebp),%eax
  800cbd:	83 e8 04             	sub    $0x4,%eax
  800cc0:	8b 30                	mov    (%eax),%esi
  800cc2:	85 f6                	test   %esi,%esi
  800cc4:	75 05                	jne    800ccb <vprintfmt+0x1a6>
				p = "(null)";
  800cc6:	be f1 28 80 00       	mov    $0x8028f1,%esi
			if (width > 0 && padc != '-')
  800ccb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ccf:	7e 6d                	jle    800d3e <vprintfmt+0x219>
  800cd1:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800cd5:	74 67                	je     800d3e <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800cd7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cda:	83 ec 08             	sub    $0x8,%esp
  800cdd:	50                   	push   %eax
  800cde:	56                   	push   %esi
  800cdf:	e8 0c 03 00 00       	call   800ff0 <strnlen>
  800ce4:	83 c4 10             	add    $0x10,%esp
  800ce7:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800cea:	eb 16                	jmp    800d02 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800cec:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800cf0:	83 ec 08             	sub    $0x8,%esp
  800cf3:	ff 75 0c             	pushl  0xc(%ebp)
  800cf6:	50                   	push   %eax
  800cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfa:	ff d0                	call   *%eax
  800cfc:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800cff:	ff 4d e4             	decl   -0x1c(%ebp)
  800d02:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d06:	7f e4                	jg     800cec <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d08:	eb 34                	jmp    800d3e <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d0a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d0e:	74 1c                	je     800d2c <vprintfmt+0x207>
  800d10:	83 fb 1f             	cmp    $0x1f,%ebx
  800d13:	7e 05                	jle    800d1a <vprintfmt+0x1f5>
  800d15:	83 fb 7e             	cmp    $0x7e,%ebx
  800d18:	7e 12                	jle    800d2c <vprintfmt+0x207>
					putch('?', putdat);
  800d1a:	83 ec 08             	sub    $0x8,%esp
  800d1d:	ff 75 0c             	pushl  0xc(%ebp)
  800d20:	6a 3f                	push   $0x3f
  800d22:	8b 45 08             	mov    0x8(%ebp),%eax
  800d25:	ff d0                	call   *%eax
  800d27:	83 c4 10             	add    $0x10,%esp
  800d2a:	eb 0f                	jmp    800d3b <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d2c:	83 ec 08             	sub    $0x8,%esp
  800d2f:	ff 75 0c             	pushl  0xc(%ebp)
  800d32:	53                   	push   %ebx
  800d33:	8b 45 08             	mov    0x8(%ebp),%eax
  800d36:	ff d0                	call   *%eax
  800d38:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d3b:	ff 4d e4             	decl   -0x1c(%ebp)
  800d3e:	89 f0                	mov    %esi,%eax
  800d40:	8d 70 01             	lea    0x1(%eax),%esi
  800d43:	8a 00                	mov    (%eax),%al
  800d45:	0f be d8             	movsbl %al,%ebx
  800d48:	85 db                	test   %ebx,%ebx
  800d4a:	74 24                	je     800d70 <vprintfmt+0x24b>
  800d4c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d50:	78 b8                	js     800d0a <vprintfmt+0x1e5>
  800d52:	ff 4d e0             	decl   -0x20(%ebp)
  800d55:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800d59:	79 af                	jns    800d0a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d5b:	eb 13                	jmp    800d70 <vprintfmt+0x24b>
				putch(' ', putdat);
  800d5d:	83 ec 08             	sub    $0x8,%esp
  800d60:	ff 75 0c             	pushl  0xc(%ebp)
  800d63:	6a 20                	push   $0x20
  800d65:	8b 45 08             	mov    0x8(%ebp),%eax
  800d68:	ff d0                	call   *%eax
  800d6a:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800d6d:	ff 4d e4             	decl   -0x1c(%ebp)
  800d70:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d74:	7f e7                	jg     800d5d <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800d76:	e9 66 01 00 00       	jmp    800ee1 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800d7b:	83 ec 08             	sub    $0x8,%esp
  800d7e:	ff 75 e8             	pushl  -0x18(%ebp)
  800d81:	8d 45 14             	lea    0x14(%ebp),%eax
  800d84:	50                   	push   %eax
  800d85:	e8 3c fd ff ff       	call   800ac6 <getint>
  800d8a:	83 c4 10             	add    $0x10,%esp
  800d8d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d90:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800d93:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d96:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d99:	85 d2                	test   %edx,%edx
  800d9b:	79 23                	jns    800dc0 <vprintfmt+0x29b>
				putch('-', putdat);
  800d9d:	83 ec 08             	sub    $0x8,%esp
  800da0:	ff 75 0c             	pushl  0xc(%ebp)
  800da3:	6a 2d                	push   $0x2d
  800da5:	8b 45 08             	mov    0x8(%ebp),%eax
  800da8:	ff d0                	call   *%eax
  800daa:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800dad:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800db0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800db3:	f7 d8                	neg    %eax
  800db5:	83 d2 00             	adc    $0x0,%edx
  800db8:	f7 da                	neg    %edx
  800dba:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dbd:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800dc0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800dc7:	e9 bc 00 00 00       	jmp    800e88 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800dcc:	83 ec 08             	sub    $0x8,%esp
  800dcf:	ff 75 e8             	pushl  -0x18(%ebp)
  800dd2:	8d 45 14             	lea    0x14(%ebp),%eax
  800dd5:	50                   	push   %eax
  800dd6:	e8 84 fc ff ff       	call   800a5f <getuint>
  800ddb:	83 c4 10             	add    $0x10,%esp
  800dde:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800de1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800de4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800deb:	e9 98 00 00 00       	jmp    800e88 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800df0:	83 ec 08             	sub    $0x8,%esp
  800df3:	ff 75 0c             	pushl  0xc(%ebp)
  800df6:	6a 58                	push   $0x58
  800df8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfb:	ff d0                	call   *%eax
  800dfd:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e00:	83 ec 08             	sub    $0x8,%esp
  800e03:	ff 75 0c             	pushl  0xc(%ebp)
  800e06:	6a 58                	push   $0x58
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	ff d0                	call   *%eax
  800e0d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e10:	83 ec 08             	sub    $0x8,%esp
  800e13:	ff 75 0c             	pushl  0xc(%ebp)
  800e16:	6a 58                	push   $0x58
  800e18:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1b:	ff d0                	call   *%eax
  800e1d:	83 c4 10             	add    $0x10,%esp
			break;
  800e20:	e9 bc 00 00 00       	jmp    800ee1 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e25:	83 ec 08             	sub    $0x8,%esp
  800e28:	ff 75 0c             	pushl  0xc(%ebp)
  800e2b:	6a 30                	push   $0x30
  800e2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e30:	ff d0                	call   *%eax
  800e32:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e35:	83 ec 08             	sub    $0x8,%esp
  800e38:	ff 75 0c             	pushl  0xc(%ebp)
  800e3b:	6a 78                	push   $0x78
  800e3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e40:	ff d0                	call   *%eax
  800e42:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800e45:	8b 45 14             	mov    0x14(%ebp),%eax
  800e48:	83 c0 04             	add    $0x4,%eax
  800e4b:	89 45 14             	mov    %eax,0x14(%ebp)
  800e4e:	8b 45 14             	mov    0x14(%ebp),%eax
  800e51:	83 e8 04             	sub    $0x4,%eax
  800e54:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800e56:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e59:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800e60:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800e67:	eb 1f                	jmp    800e88 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800e69:	83 ec 08             	sub    $0x8,%esp
  800e6c:	ff 75 e8             	pushl  -0x18(%ebp)
  800e6f:	8d 45 14             	lea    0x14(%ebp),%eax
  800e72:	50                   	push   %eax
  800e73:	e8 e7 fb ff ff       	call   800a5f <getuint>
  800e78:	83 c4 10             	add    $0x10,%esp
  800e7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e7e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800e81:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800e88:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800e8c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e8f:	83 ec 04             	sub    $0x4,%esp
  800e92:	52                   	push   %edx
  800e93:	ff 75 e4             	pushl  -0x1c(%ebp)
  800e96:	50                   	push   %eax
  800e97:	ff 75 f4             	pushl  -0xc(%ebp)
  800e9a:	ff 75 f0             	pushl  -0x10(%ebp)
  800e9d:	ff 75 0c             	pushl  0xc(%ebp)
  800ea0:	ff 75 08             	pushl  0x8(%ebp)
  800ea3:	e8 00 fb ff ff       	call   8009a8 <printnum>
  800ea8:	83 c4 20             	add    $0x20,%esp
			break;
  800eab:	eb 34                	jmp    800ee1 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ead:	83 ec 08             	sub    $0x8,%esp
  800eb0:	ff 75 0c             	pushl  0xc(%ebp)
  800eb3:	53                   	push   %ebx
  800eb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb7:	ff d0                	call   *%eax
  800eb9:	83 c4 10             	add    $0x10,%esp
			break;
  800ebc:	eb 23                	jmp    800ee1 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ebe:	83 ec 08             	sub    $0x8,%esp
  800ec1:	ff 75 0c             	pushl  0xc(%ebp)
  800ec4:	6a 25                	push   $0x25
  800ec6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec9:	ff d0                	call   *%eax
  800ecb:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800ece:	ff 4d 10             	decl   0x10(%ebp)
  800ed1:	eb 03                	jmp    800ed6 <vprintfmt+0x3b1>
  800ed3:	ff 4d 10             	decl   0x10(%ebp)
  800ed6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed9:	48                   	dec    %eax
  800eda:	8a 00                	mov    (%eax),%al
  800edc:	3c 25                	cmp    $0x25,%al
  800ede:	75 f3                	jne    800ed3 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800ee0:	90                   	nop
		}
	}
  800ee1:	e9 47 fc ff ff       	jmp    800b2d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ee6:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ee7:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800eea:	5b                   	pop    %ebx
  800eeb:	5e                   	pop    %esi
  800eec:	5d                   	pop    %ebp
  800eed:	c3                   	ret    

00800eee <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800eee:	55                   	push   %ebp
  800eef:	89 e5                	mov    %esp,%ebp
  800ef1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ef4:	8d 45 10             	lea    0x10(%ebp),%eax
  800ef7:	83 c0 04             	add    $0x4,%eax
  800efa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800efd:	8b 45 10             	mov    0x10(%ebp),%eax
  800f00:	ff 75 f4             	pushl  -0xc(%ebp)
  800f03:	50                   	push   %eax
  800f04:	ff 75 0c             	pushl  0xc(%ebp)
  800f07:	ff 75 08             	pushl  0x8(%ebp)
  800f0a:	e8 16 fc ff ff       	call   800b25 <vprintfmt>
  800f0f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f12:	90                   	nop
  800f13:	c9                   	leave  
  800f14:	c3                   	ret    

00800f15 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f15:	55                   	push   %ebp
  800f16:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1b:	8b 40 08             	mov    0x8(%eax),%eax
  800f1e:	8d 50 01             	lea    0x1(%eax),%edx
  800f21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f24:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2a:	8b 10                	mov    (%eax),%edx
  800f2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f2f:	8b 40 04             	mov    0x4(%eax),%eax
  800f32:	39 c2                	cmp    %eax,%edx
  800f34:	73 12                	jae    800f48 <sprintputch+0x33>
		*b->buf++ = ch;
  800f36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f39:	8b 00                	mov    (%eax),%eax
  800f3b:	8d 48 01             	lea    0x1(%eax),%ecx
  800f3e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f41:	89 0a                	mov    %ecx,(%edx)
  800f43:	8b 55 08             	mov    0x8(%ebp),%edx
  800f46:	88 10                	mov    %dl,(%eax)
}
  800f48:	90                   	nop
  800f49:	5d                   	pop    %ebp
  800f4a:	c3                   	ret    

00800f4b <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800f4b:	55                   	push   %ebp
  800f4c:	89 e5                	mov    %esp,%ebp
  800f4e:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800f51:	8b 45 08             	mov    0x8(%ebp),%eax
  800f54:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800f57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f60:	01 d0                	add    %edx,%eax
  800f62:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f65:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800f6c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f70:	74 06                	je     800f78 <vsnprintf+0x2d>
  800f72:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f76:	7f 07                	jg     800f7f <vsnprintf+0x34>
		return -E_INVAL;
  800f78:	b8 03 00 00 00       	mov    $0x3,%eax
  800f7d:	eb 20                	jmp    800f9f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800f7f:	ff 75 14             	pushl  0x14(%ebp)
  800f82:	ff 75 10             	pushl  0x10(%ebp)
  800f85:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800f88:	50                   	push   %eax
  800f89:	68 15 0f 80 00       	push   $0x800f15
  800f8e:	e8 92 fb ff ff       	call   800b25 <vprintfmt>
  800f93:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800f96:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f99:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800f9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800f9f:	c9                   	leave  
  800fa0:	c3                   	ret    

00800fa1 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800fa1:	55                   	push   %ebp
  800fa2:	89 e5                	mov    %esp,%ebp
  800fa4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800fa7:	8d 45 10             	lea    0x10(%ebp),%eax
  800faa:	83 c0 04             	add    $0x4,%eax
  800fad:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800fb0:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb3:	ff 75 f4             	pushl  -0xc(%ebp)
  800fb6:	50                   	push   %eax
  800fb7:	ff 75 0c             	pushl  0xc(%ebp)
  800fba:	ff 75 08             	pushl  0x8(%ebp)
  800fbd:	e8 89 ff ff ff       	call   800f4b <vsnprintf>
  800fc2:	83 c4 10             	add    $0x10,%esp
  800fc5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800fc8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800fcb:	c9                   	leave  
  800fcc:	c3                   	ret    

00800fcd <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800fcd:	55                   	push   %ebp
  800fce:	89 e5                	mov    %esp,%ebp
  800fd0:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800fd3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800fda:	eb 06                	jmp    800fe2 <strlen+0x15>
		n++;
  800fdc:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800fdf:	ff 45 08             	incl   0x8(%ebp)
  800fe2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe5:	8a 00                	mov    (%eax),%al
  800fe7:	84 c0                	test   %al,%al
  800fe9:	75 f1                	jne    800fdc <strlen+0xf>
		n++;
	return n;
  800feb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800fee:	c9                   	leave  
  800fef:	c3                   	ret    

00800ff0 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ff0:	55                   	push   %ebp
  800ff1:	89 e5                	mov    %esp,%ebp
  800ff3:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ff6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ffd:	eb 09                	jmp    801008 <strnlen+0x18>
		n++;
  800fff:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801002:	ff 45 08             	incl   0x8(%ebp)
  801005:	ff 4d 0c             	decl   0xc(%ebp)
  801008:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80100c:	74 09                	je     801017 <strnlen+0x27>
  80100e:	8b 45 08             	mov    0x8(%ebp),%eax
  801011:	8a 00                	mov    (%eax),%al
  801013:	84 c0                	test   %al,%al
  801015:	75 e8                	jne    800fff <strnlen+0xf>
		n++;
	return n;
  801017:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80101a:	c9                   	leave  
  80101b:	c3                   	ret    

0080101c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80101c:	55                   	push   %ebp
  80101d:	89 e5                	mov    %esp,%ebp
  80101f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801022:	8b 45 08             	mov    0x8(%ebp),%eax
  801025:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801028:	90                   	nop
  801029:	8b 45 08             	mov    0x8(%ebp),%eax
  80102c:	8d 50 01             	lea    0x1(%eax),%edx
  80102f:	89 55 08             	mov    %edx,0x8(%ebp)
  801032:	8b 55 0c             	mov    0xc(%ebp),%edx
  801035:	8d 4a 01             	lea    0x1(%edx),%ecx
  801038:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80103b:	8a 12                	mov    (%edx),%dl
  80103d:	88 10                	mov    %dl,(%eax)
  80103f:	8a 00                	mov    (%eax),%al
  801041:	84 c0                	test   %al,%al
  801043:	75 e4                	jne    801029 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801045:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801048:	c9                   	leave  
  801049:	c3                   	ret    

0080104a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80104a:	55                   	push   %ebp
  80104b:	89 e5                	mov    %esp,%ebp
  80104d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801050:	8b 45 08             	mov    0x8(%ebp),%eax
  801053:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801056:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80105d:	eb 1f                	jmp    80107e <strncpy+0x34>
		*dst++ = *src;
  80105f:	8b 45 08             	mov    0x8(%ebp),%eax
  801062:	8d 50 01             	lea    0x1(%eax),%edx
  801065:	89 55 08             	mov    %edx,0x8(%ebp)
  801068:	8b 55 0c             	mov    0xc(%ebp),%edx
  80106b:	8a 12                	mov    (%edx),%dl
  80106d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80106f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801072:	8a 00                	mov    (%eax),%al
  801074:	84 c0                	test   %al,%al
  801076:	74 03                	je     80107b <strncpy+0x31>
			src++;
  801078:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80107b:	ff 45 fc             	incl   -0x4(%ebp)
  80107e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801081:	3b 45 10             	cmp    0x10(%ebp),%eax
  801084:	72 d9                	jb     80105f <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801086:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801089:	c9                   	leave  
  80108a:	c3                   	ret    

0080108b <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80108b:	55                   	push   %ebp
  80108c:	89 e5                	mov    %esp,%ebp
  80108e:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801091:	8b 45 08             	mov    0x8(%ebp),%eax
  801094:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801097:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80109b:	74 30                	je     8010cd <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80109d:	eb 16                	jmp    8010b5 <strlcpy+0x2a>
			*dst++ = *src++;
  80109f:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a2:	8d 50 01             	lea    0x1(%eax),%edx
  8010a5:	89 55 08             	mov    %edx,0x8(%ebp)
  8010a8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010ab:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010ae:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010b1:	8a 12                	mov    (%edx),%dl
  8010b3:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8010b5:	ff 4d 10             	decl   0x10(%ebp)
  8010b8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010bc:	74 09                	je     8010c7 <strlcpy+0x3c>
  8010be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c1:	8a 00                	mov    (%eax),%al
  8010c3:	84 c0                	test   %al,%al
  8010c5:	75 d8                	jne    80109f <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8010c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ca:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8010cd:	8b 55 08             	mov    0x8(%ebp),%edx
  8010d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010d3:	29 c2                	sub    %eax,%edx
  8010d5:	89 d0                	mov    %edx,%eax
}
  8010d7:	c9                   	leave  
  8010d8:	c3                   	ret    

008010d9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8010d9:	55                   	push   %ebp
  8010da:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8010dc:	eb 06                	jmp    8010e4 <strcmp+0xb>
		p++, q++;
  8010de:	ff 45 08             	incl   0x8(%ebp)
  8010e1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8010e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e7:	8a 00                	mov    (%eax),%al
  8010e9:	84 c0                	test   %al,%al
  8010eb:	74 0e                	je     8010fb <strcmp+0x22>
  8010ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f0:	8a 10                	mov    (%eax),%dl
  8010f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f5:	8a 00                	mov    (%eax),%al
  8010f7:	38 c2                	cmp    %al,%dl
  8010f9:	74 e3                	je     8010de <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8010fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fe:	8a 00                	mov    (%eax),%al
  801100:	0f b6 d0             	movzbl %al,%edx
  801103:	8b 45 0c             	mov    0xc(%ebp),%eax
  801106:	8a 00                	mov    (%eax),%al
  801108:	0f b6 c0             	movzbl %al,%eax
  80110b:	29 c2                	sub    %eax,%edx
  80110d:	89 d0                	mov    %edx,%eax
}
  80110f:	5d                   	pop    %ebp
  801110:	c3                   	ret    

00801111 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801111:	55                   	push   %ebp
  801112:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801114:	eb 09                	jmp    80111f <strncmp+0xe>
		n--, p++, q++;
  801116:	ff 4d 10             	decl   0x10(%ebp)
  801119:	ff 45 08             	incl   0x8(%ebp)
  80111c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80111f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801123:	74 17                	je     80113c <strncmp+0x2b>
  801125:	8b 45 08             	mov    0x8(%ebp),%eax
  801128:	8a 00                	mov    (%eax),%al
  80112a:	84 c0                	test   %al,%al
  80112c:	74 0e                	je     80113c <strncmp+0x2b>
  80112e:	8b 45 08             	mov    0x8(%ebp),%eax
  801131:	8a 10                	mov    (%eax),%dl
  801133:	8b 45 0c             	mov    0xc(%ebp),%eax
  801136:	8a 00                	mov    (%eax),%al
  801138:	38 c2                	cmp    %al,%dl
  80113a:	74 da                	je     801116 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80113c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801140:	75 07                	jne    801149 <strncmp+0x38>
		return 0;
  801142:	b8 00 00 00 00       	mov    $0x0,%eax
  801147:	eb 14                	jmp    80115d <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801149:	8b 45 08             	mov    0x8(%ebp),%eax
  80114c:	8a 00                	mov    (%eax),%al
  80114e:	0f b6 d0             	movzbl %al,%edx
  801151:	8b 45 0c             	mov    0xc(%ebp),%eax
  801154:	8a 00                	mov    (%eax),%al
  801156:	0f b6 c0             	movzbl %al,%eax
  801159:	29 c2                	sub    %eax,%edx
  80115b:	89 d0                	mov    %edx,%eax
}
  80115d:	5d                   	pop    %ebp
  80115e:	c3                   	ret    

0080115f <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80115f:	55                   	push   %ebp
  801160:	89 e5                	mov    %esp,%ebp
  801162:	83 ec 04             	sub    $0x4,%esp
  801165:	8b 45 0c             	mov    0xc(%ebp),%eax
  801168:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80116b:	eb 12                	jmp    80117f <strchr+0x20>
		if (*s == c)
  80116d:	8b 45 08             	mov    0x8(%ebp),%eax
  801170:	8a 00                	mov    (%eax),%al
  801172:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801175:	75 05                	jne    80117c <strchr+0x1d>
			return (char *) s;
  801177:	8b 45 08             	mov    0x8(%ebp),%eax
  80117a:	eb 11                	jmp    80118d <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80117c:	ff 45 08             	incl   0x8(%ebp)
  80117f:	8b 45 08             	mov    0x8(%ebp),%eax
  801182:	8a 00                	mov    (%eax),%al
  801184:	84 c0                	test   %al,%al
  801186:	75 e5                	jne    80116d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801188:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80118d:	c9                   	leave  
  80118e:	c3                   	ret    

0080118f <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80118f:	55                   	push   %ebp
  801190:	89 e5                	mov    %esp,%ebp
  801192:	83 ec 04             	sub    $0x4,%esp
  801195:	8b 45 0c             	mov    0xc(%ebp),%eax
  801198:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80119b:	eb 0d                	jmp    8011aa <strfind+0x1b>
		if (*s == c)
  80119d:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a0:	8a 00                	mov    (%eax),%al
  8011a2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011a5:	74 0e                	je     8011b5 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8011a7:	ff 45 08             	incl   0x8(%ebp)
  8011aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ad:	8a 00                	mov    (%eax),%al
  8011af:	84 c0                	test   %al,%al
  8011b1:	75 ea                	jne    80119d <strfind+0xe>
  8011b3:	eb 01                	jmp    8011b6 <strfind+0x27>
		if (*s == c)
			break;
  8011b5:	90                   	nop
	return (char *) s;
  8011b6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011b9:	c9                   	leave  
  8011ba:	c3                   	ret    

008011bb <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8011bb:	55                   	push   %ebp
  8011bc:	89 e5                	mov    %esp,%ebp
  8011be:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8011c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8011c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ca:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8011cd:	eb 0e                	jmp    8011dd <memset+0x22>
		*p++ = c;
  8011cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011d2:	8d 50 01             	lea    0x1(%eax),%edx
  8011d5:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011db:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8011dd:	ff 4d f8             	decl   -0x8(%ebp)
  8011e0:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8011e4:	79 e9                	jns    8011cf <memset+0x14>
		*p++ = c;

	return v;
  8011e6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011e9:	c9                   	leave  
  8011ea:	c3                   	ret    

008011eb <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8011eb:	55                   	push   %ebp
  8011ec:	89 e5                	mov    %esp,%ebp
  8011ee:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8011f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8011f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8011fd:	eb 16                	jmp    801215 <memcpy+0x2a>
		*d++ = *s++;
  8011ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801202:	8d 50 01             	lea    0x1(%eax),%edx
  801205:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801208:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80120b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80120e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801211:	8a 12                	mov    (%edx),%dl
  801213:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801215:	8b 45 10             	mov    0x10(%ebp),%eax
  801218:	8d 50 ff             	lea    -0x1(%eax),%edx
  80121b:	89 55 10             	mov    %edx,0x10(%ebp)
  80121e:	85 c0                	test   %eax,%eax
  801220:	75 dd                	jne    8011ff <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801222:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801225:	c9                   	leave  
  801226:	c3                   	ret    

00801227 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801227:	55                   	push   %ebp
  801228:	89 e5                	mov    %esp,%ebp
  80122a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80122d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801230:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801233:	8b 45 08             	mov    0x8(%ebp),%eax
  801236:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801239:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80123c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80123f:	73 50                	jae    801291 <memmove+0x6a>
  801241:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801244:	8b 45 10             	mov    0x10(%ebp),%eax
  801247:	01 d0                	add    %edx,%eax
  801249:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80124c:	76 43                	jbe    801291 <memmove+0x6a>
		s += n;
  80124e:	8b 45 10             	mov    0x10(%ebp),%eax
  801251:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801254:	8b 45 10             	mov    0x10(%ebp),%eax
  801257:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80125a:	eb 10                	jmp    80126c <memmove+0x45>
			*--d = *--s;
  80125c:	ff 4d f8             	decl   -0x8(%ebp)
  80125f:	ff 4d fc             	decl   -0x4(%ebp)
  801262:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801265:	8a 10                	mov    (%eax),%dl
  801267:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80126a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80126c:	8b 45 10             	mov    0x10(%ebp),%eax
  80126f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801272:	89 55 10             	mov    %edx,0x10(%ebp)
  801275:	85 c0                	test   %eax,%eax
  801277:	75 e3                	jne    80125c <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801279:	eb 23                	jmp    80129e <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80127b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80127e:	8d 50 01             	lea    0x1(%eax),%edx
  801281:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801284:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801287:	8d 4a 01             	lea    0x1(%edx),%ecx
  80128a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80128d:	8a 12                	mov    (%edx),%dl
  80128f:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801291:	8b 45 10             	mov    0x10(%ebp),%eax
  801294:	8d 50 ff             	lea    -0x1(%eax),%edx
  801297:	89 55 10             	mov    %edx,0x10(%ebp)
  80129a:	85 c0                	test   %eax,%eax
  80129c:	75 dd                	jne    80127b <memmove+0x54>
			*d++ = *s++;

	return dst;
  80129e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8012a1:	c9                   	leave  
  8012a2:	c3                   	ret    

008012a3 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8012a3:	55                   	push   %ebp
  8012a4:	89 e5                	mov    %esp,%ebp
  8012a6:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8012a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8012af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b2:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8012b5:	eb 2a                	jmp    8012e1 <memcmp+0x3e>
		if (*s1 != *s2)
  8012b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012ba:	8a 10                	mov    (%eax),%dl
  8012bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012bf:	8a 00                	mov    (%eax),%al
  8012c1:	38 c2                	cmp    %al,%dl
  8012c3:	74 16                	je     8012db <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8012c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012c8:	8a 00                	mov    (%eax),%al
  8012ca:	0f b6 d0             	movzbl %al,%edx
  8012cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012d0:	8a 00                	mov    (%eax),%al
  8012d2:	0f b6 c0             	movzbl %al,%eax
  8012d5:	29 c2                	sub    %eax,%edx
  8012d7:	89 d0                	mov    %edx,%eax
  8012d9:	eb 18                	jmp    8012f3 <memcmp+0x50>
		s1++, s2++;
  8012db:	ff 45 fc             	incl   -0x4(%ebp)
  8012de:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8012e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012e4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012e7:	89 55 10             	mov    %edx,0x10(%ebp)
  8012ea:	85 c0                	test   %eax,%eax
  8012ec:	75 c9                	jne    8012b7 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8012ee:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8012f3:	c9                   	leave  
  8012f4:	c3                   	ret    

008012f5 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8012f5:	55                   	push   %ebp
  8012f6:	89 e5                	mov    %esp,%ebp
  8012f8:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8012fb:	8b 55 08             	mov    0x8(%ebp),%edx
  8012fe:	8b 45 10             	mov    0x10(%ebp),%eax
  801301:	01 d0                	add    %edx,%eax
  801303:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801306:	eb 15                	jmp    80131d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801308:	8b 45 08             	mov    0x8(%ebp),%eax
  80130b:	8a 00                	mov    (%eax),%al
  80130d:	0f b6 d0             	movzbl %al,%edx
  801310:	8b 45 0c             	mov    0xc(%ebp),%eax
  801313:	0f b6 c0             	movzbl %al,%eax
  801316:	39 c2                	cmp    %eax,%edx
  801318:	74 0d                	je     801327 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80131a:	ff 45 08             	incl   0x8(%ebp)
  80131d:	8b 45 08             	mov    0x8(%ebp),%eax
  801320:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801323:	72 e3                	jb     801308 <memfind+0x13>
  801325:	eb 01                	jmp    801328 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801327:	90                   	nop
	return (void *) s;
  801328:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80132b:	c9                   	leave  
  80132c:	c3                   	ret    

0080132d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80132d:	55                   	push   %ebp
  80132e:	89 e5                	mov    %esp,%ebp
  801330:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801333:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80133a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801341:	eb 03                	jmp    801346 <strtol+0x19>
		s++;
  801343:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801346:	8b 45 08             	mov    0x8(%ebp),%eax
  801349:	8a 00                	mov    (%eax),%al
  80134b:	3c 20                	cmp    $0x20,%al
  80134d:	74 f4                	je     801343 <strtol+0x16>
  80134f:	8b 45 08             	mov    0x8(%ebp),%eax
  801352:	8a 00                	mov    (%eax),%al
  801354:	3c 09                	cmp    $0x9,%al
  801356:	74 eb                	je     801343 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801358:	8b 45 08             	mov    0x8(%ebp),%eax
  80135b:	8a 00                	mov    (%eax),%al
  80135d:	3c 2b                	cmp    $0x2b,%al
  80135f:	75 05                	jne    801366 <strtol+0x39>
		s++;
  801361:	ff 45 08             	incl   0x8(%ebp)
  801364:	eb 13                	jmp    801379 <strtol+0x4c>
	else if (*s == '-')
  801366:	8b 45 08             	mov    0x8(%ebp),%eax
  801369:	8a 00                	mov    (%eax),%al
  80136b:	3c 2d                	cmp    $0x2d,%al
  80136d:	75 0a                	jne    801379 <strtol+0x4c>
		s++, neg = 1;
  80136f:	ff 45 08             	incl   0x8(%ebp)
  801372:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801379:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80137d:	74 06                	je     801385 <strtol+0x58>
  80137f:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801383:	75 20                	jne    8013a5 <strtol+0x78>
  801385:	8b 45 08             	mov    0x8(%ebp),%eax
  801388:	8a 00                	mov    (%eax),%al
  80138a:	3c 30                	cmp    $0x30,%al
  80138c:	75 17                	jne    8013a5 <strtol+0x78>
  80138e:	8b 45 08             	mov    0x8(%ebp),%eax
  801391:	40                   	inc    %eax
  801392:	8a 00                	mov    (%eax),%al
  801394:	3c 78                	cmp    $0x78,%al
  801396:	75 0d                	jne    8013a5 <strtol+0x78>
		s += 2, base = 16;
  801398:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80139c:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8013a3:	eb 28                	jmp    8013cd <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8013a5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013a9:	75 15                	jne    8013c0 <strtol+0x93>
  8013ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ae:	8a 00                	mov    (%eax),%al
  8013b0:	3c 30                	cmp    $0x30,%al
  8013b2:	75 0c                	jne    8013c0 <strtol+0x93>
		s++, base = 8;
  8013b4:	ff 45 08             	incl   0x8(%ebp)
  8013b7:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8013be:	eb 0d                	jmp    8013cd <strtol+0xa0>
	else if (base == 0)
  8013c0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013c4:	75 07                	jne    8013cd <strtol+0xa0>
		base = 10;
  8013c6:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8013cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d0:	8a 00                	mov    (%eax),%al
  8013d2:	3c 2f                	cmp    $0x2f,%al
  8013d4:	7e 19                	jle    8013ef <strtol+0xc2>
  8013d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d9:	8a 00                	mov    (%eax),%al
  8013db:	3c 39                	cmp    $0x39,%al
  8013dd:	7f 10                	jg     8013ef <strtol+0xc2>
			dig = *s - '0';
  8013df:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e2:	8a 00                	mov    (%eax),%al
  8013e4:	0f be c0             	movsbl %al,%eax
  8013e7:	83 e8 30             	sub    $0x30,%eax
  8013ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8013ed:	eb 42                	jmp    801431 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8013ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f2:	8a 00                	mov    (%eax),%al
  8013f4:	3c 60                	cmp    $0x60,%al
  8013f6:	7e 19                	jle    801411 <strtol+0xe4>
  8013f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fb:	8a 00                	mov    (%eax),%al
  8013fd:	3c 7a                	cmp    $0x7a,%al
  8013ff:	7f 10                	jg     801411 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801401:	8b 45 08             	mov    0x8(%ebp),%eax
  801404:	8a 00                	mov    (%eax),%al
  801406:	0f be c0             	movsbl %al,%eax
  801409:	83 e8 57             	sub    $0x57,%eax
  80140c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80140f:	eb 20                	jmp    801431 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801411:	8b 45 08             	mov    0x8(%ebp),%eax
  801414:	8a 00                	mov    (%eax),%al
  801416:	3c 40                	cmp    $0x40,%al
  801418:	7e 39                	jle    801453 <strtol+0x126>
  80141a:	8b 45 08             	mov    0x8(%ebp),%eax
  80141d:	8a 00                	mov    (%eax),%al
  80141f:	3c 5a                	cmp    $0x5a,%al
  801421:	7f 30                	jg     801453 <strtol+0x126>
			dig = *s - 'A' + 10;
  801423:	8b 45 08             	mov    0x8(%ebp),%eax
  801426:	8a 00                	mov    (%eax),%al
  801428:	0f be c0             	movsbl %al,%eax
  80142b:	83 e8 37             	sub    $0x37,%eax
  80142e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801431:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801434:	3b 45 10             	cmp    0x10(%ebp),%eax
  801437:	7d 19                	jge    801452 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801439:	ff 45 08             	incl   0x8(%ebp)
  80143c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80143f:	0f af 45 10          	imul   0x10(%ebp),%eax
  801443:	89 c2                	mov    %eax,%edx
  801445:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801448:	01 d0                	add    %edx,%eax
  80144a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80144d:	e9 7b ff ff ff       	jmp    8013cd <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801452:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801453:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801457:	74 08                	je     801461 <strtol+0x134>
		*endptr = (char *) s;
  801459:	8b 45 0c             	mov    0xc(%ebp),%eax
  80145c:	8b 55 08             	mov    0x8(%ebp),%edx
  80145f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801461:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801465:	74 07                	je     80146e <strtol+0x141>
  801467:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80146a:	f7 d8                	neg    %eax
  80146c:	eb 03                	jmp    801471 <strtol+0x144>
  80146e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801471:	c9                   	leave  
  801472:	c3                   	ret    

00801473 <ltostr>:

void
ltostr(long value, char *str)
{
  801473:	55                   	push   %ebp
  801474:	89 e5                	mov    %esp,%ebp
  801476:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801479:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801480:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801487:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80148b:	79 13                	jns    8014a0 <ltostr+0x2d>
	{
		neg = 1;
  80148d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801494:	8b 45 0c             	mov    0xc(%ebp),%eax
  801497:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80149a:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80149d:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8014a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8014a8:	99                   	cltd   
  8014a9:	f7 f9                	idiv   %ecx
  8014ab:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8014ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014b1:	8d 50 01             	lea    0x1(%eax),%edx
  8014b4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014b7:	89 c2                	mov    %eax,%edx
  8014b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014bc:	01 d0                	add    %edx,%eax
  8014be:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8014c1:	83 c2 30             	add    $0x30,%edx
  8014c4:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8014c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014c9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014ce:	f7 e9                	imul   %ecx
  8014d0:	c1 fa 02             	sar    $0x2,%edx
  8014d3:	89 c8                	mov    %ecx,%eax
  8014d5:	c1 f8 1f             	sar    $0x1f,%eax
  8014d8:	29 c2                	sub    %eax,%edx
  8014da:	89 d0                	mov    %edx,%eax
  8014dc:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8014df:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8014e2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8014e7:	f7 e9                	imul   %ecx
  8014e9:	c1 fa 02             	sar    $0x2,%edx
  8014ec:	89 c8                	mov    %ecx,%eax
  8014ee:	c1 f8 1f             	sar    $0x1f,%eax
  8014f1:	29 c2                	sub    %eax,%edx
  8014f3:	89 d0                	mov    %edx,%eax
  8014f5:	c1 e0 02             	shl    $0x2,%eax
  8014f8:	01 d0                	add    %edx,%eax
  8014fa:	01 c0                	add    %eax,%eax
  8014fc:	29 c1                	sub    %eax,%ecx
  8014fe:	89 ca                	mov    %ecx,%edx
  801500:	85 d2                	test   %edx,%edx
  801502:	75 9c                	jne    8014a0 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801504:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80150b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80150e:	48                   	dec    %eax
  80150f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801512:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801516:	74 3d                	je     801555 <ltostr+0xe2>
		start = 1 ;
  801518:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80151f:	eb 34                	jmp    801555 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801521:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801524:	8b 45 0c             	mov    0xc(%ebp),%eax
  801527:	01 d0                	add    %edx,%eax
  801529:	8a 00                	mov    (%eax),%al
  80152b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80152e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801531:	8b 45 0c             	mov    0xc(%ebp),%eax
  801534:	01 c2                	add    %eax,%edx
  801536:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801539:	8b 45 0c             	mov    0xc(%ebp),%eax
  80153c:	01 c8                	add    %ecx,%eax
  80153e:	8a 00                	mov    (%eax),%al
  801540:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801542:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801545:	8b 45 0c             	mov    0xc(%ebp),%eax
  801548:	01 c2                	add    %eax,%edx
  80154a:	8a 45 eb             	mov    -0x15(%ebp),%al
  80154d:	88 02                	mov    %al,(%edx)
		start++ ;
  80154f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801552:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801555:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801558:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80155b:	7c c4                	jl     801521 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80155d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801560:	8b 45 0c             	mov    0xc(%ebp),%eax
  801563:	01 d0                	add    %edx,%eax
  801565:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801568:	90                   	nop
  801569:	c9                   	leave  
  80156a:	c3                   	ret    

0080156b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80156b:	55                   	push   %ebp
  80156c:	89 e5                	mov    %esp,%ebp
  80156e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801571:	ff 75 08             	pushl  0x8(%ebp)
  801574:	e8 54 fa ff ff       	call   800fcd <strlen>
  801579:	83 c4 04             	add    $0x4,%esp
  80157c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80157f:	ff 75 0c             	pushl  0xc(%ebp)
  801582:	e8 46 fa ff ff       	call   800fcd <strlen>
  801587:	83 c4 04             	add    $0x4,%esp
  80158a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80158d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801594:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80159b:	eb 17                	jmp    8015b4 <strcconcat+0x49>
		final[s] = str1[s] ;
  80159d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8015a3:	01 c2                	add    %eax,%edx
  8015a5:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8015a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ab:	01 c8                	add    %ecx,%eax
  8015ad:	8a 00                	mov    (%eax),%al
  8015af:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8015b1:	ff 45 fc             	incl   -0x4(%ebp)
  8015b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015b7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8015ba:	7c e1                	jl     80159d <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8015bc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8015c3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8015ca:	eb 1f                	jmp    8015eb <strcconcat+0x80>
		final[s++] = str2[i] ;
  8015cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015cf:	8d 50 01             	lea    0x1(%eax),%edx
  8015d2:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8015d5:	89 c2                	mov    %eax,%edx
  8015d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8015da:	01 c2                	add    %eax,%edx
  8015dc:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8015df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e2:	01 c8                	add    %ecx,%eax
  8015e4:	8a 00                	mov    (%eax),%al
  8015e6:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8015e8:	ff 45 f8             	incl   -0x8(%ebp)
  8015eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015ee:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015f1:	7c d9                	jl     8015cc <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8015f3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8015f9:	01 d0                	add    %edx,%eax
  8015fb:	c6 00 00             	movb   $0x0,(%eax)
}
  8015fe:	90                   	nop
  8015ff:	c9                   	leave  
  801600:	c3                   	ret    

00801601 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801601:	55                   	push   %ebp
  801602:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801604:	8b 45 14             	mov    0x14(%ebp),%eax
  801607:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80160d:	8b 45 14             	mov    0x14(%ebp),%eax
  801610:	8b 00                	mov    (%eax),%eax
  801612:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801619:	8b 45 10             	mov    0x10(%ebp),%eax
  80161c:	01 d0                	add    %edx,%eax
  80161e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801624:	eb 0c                	jmp    801632 <strsplit+0x31>
			*string++ = 0;
  801626:	8b 45 08             	mov    0x8(%ebp),%eax
  801629:	8d 50 01             	lea    0x1(%eax),%edx
  80162c:	89 55 08             	mov    %edx,0x8(%ebp)
  80162f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801632:	8b 45 08             	mov    0x8(%ebp),%eax
  801635:	8a 00                	mov    (%eax),%al
  801637:	84 c0                	test   %al,%al
  801639:	74 18                	je     801653 <strsplit+0x52>
  80163b:	8b 45 08             	mov    0x8(%ebp),%eax
  80163e:	8a 00                	mov    (%eax),%al
  801640:	0f be c0             	movsbl %al,%eax
  801643:	50                   	push   %eax
  801644:	ff 75 0c             	pushl  0xc(%ebp)
  801647:	e8 13 fb ff ff       	call   80115f <strchr>
  80164c:	83 c4 08             	add    $0x8,%esp
  80164f:	85 c0                	test   %eax,%eax
  801651:	75 d3                	jne    801626 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801653:	8b 45 08             	mov    0x8(%ebp),%eax
  801656:	8a 00                	mov    (%eax),%al
  801658:	84 c0                	test   %al,%al
  80165a:	74 5a                	je     8016b6 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80165c:	8b 45 14             	mov    0x14(%ebp),%eax
  80165f:	8b 00                	mov    (%eax),%eax
  801661:	83 f8 0f             	cmp    $0xf,%eax
  801664:	75 07                	jne    80166d <strsplit+0x6c>
		{
			return 0;
  801666:	b8 00 00 00 00       	mov    $0x0,%eax
  80166b:	eb 66                	jmp    8016d3 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80166d:	8b 45 14             	mov    0x14(%ebp),%eax
  801670:	8b 00                	mov    (%eax),%eax
  801672:	8d 48 01             	lea    0x1(%eax),%ecx
  801675:	8b 55 14             	mov    0x14(%ebp),%edx
  801678:	89 0a                	mov    %ecx,(%edx)
  80167a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801681:	8b 45 10             	mov    0x10(%ebp),%eax
  801684:	01 c2                	add    %eax,%edx
  801686:	8b 45 08             	mov    0x8(%ebp),%eax
  801689:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80168b:	eb 03                	jmp    801690 <strsplit+0x8f>
			string++;
  80168d:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801690:	8b 45 08             	mov    0x8(%ebp),%eax
  801693:	8a 00                	mov    (%eax),%al
  801695:	84 c0                	test   %al,%al
  801697:	74 8b                	je     801624 <strsplit+0x23>
  801699:	8b 45 08             	mov    0x8(%ebp),%eax
  80169c:	8a 00                	mov    (%eax),%al
  80169e:	0f be c0             	movsbl %al,%eax
  8016a1:	50                   	push   %eax
  8016a2:	ff 75 0c             	pushl  0xc(%ebp)
  8016a5:	e8 b5 fa ff ff       	call   80115f <strchr>
  8016aa:	83 c4 08             	add    $0x8,%esp
  8016ad:	85 c0                	test   %eax,%eax
  8016af:	74 dc                	je     80168d <strsplit+0x8c>
			string++;
	}
  8016b1:	e9 6e ff ff ff       	jmp    801624 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8016b6:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8016b7:	8b 45 14             	mov    0x14(%ebp),%eax
  8016ba:	8b 00                	mov    (%eax),%eax
  8016bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8016c6:	01 d0                	add    %edx,%eax
  8016c8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8016ce:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8016d3:	c9                   	leave  
  8016d4:	c3                   	ret    

008016d5 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  8016d5:	55                   	push   %ebp
  8016d6:	89 e5                	mov    %esp,%ebp
  8016d8:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  8016db:	83 ec 04             	sub    $0x4,%esp
  8016de:	68 50 2a 80 00       	push   $0x802a50
  8016e3:	6a 16                	push   $0x16
  8016e5:	68 75 2a 80 00       	push   $0x802a75
  8016ea:	e8 ba ef ff ff       	call   8006a9 <_panic>

008016ef <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8016ef:	55                   	push   %ebp
  8016f0:	89 e5                	mov    %esp,%ebp
  8016f2:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8016f5:	83 ec 04             	sub    $0x4,%esp
  8016f8:	68 84 2a 80 00       	push   $0x802a84
  8016fd:	6a 2e                	push   $0x2e
  8016ff:	68 75 2a 80 00       	push   $0x802a75
  801704:	e8 a0 ef ff ff       	call   8006a9 <_panic>

00801709 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801709:	55                   	push   %ebp
  80170a:	89 e5                	mov    %esp,%ebp
  80170c:	83 ec 18             	sub    $0x18,%esp
  80170f:	8b 45 10             	mov    0x10(%ebp),%eax
  801712:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801715:	83 ec 04             	sub    $0x4,%esp
  801718:	68 a8 2a 80 00       	push   $0x802aa8
  80171d:	6a 3b                	push   $0x3b
  80171f:	68 75 2a 80 00       	push   $0x802a75
  801724:	e8 80 ef ff ff       	call   8006a9 <_panic>

00801729 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801729:	55                   	push   %ebp
  80172a:	89 e5                	mov    %esp,%ebp
  80172c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80172f:	83 ec 04             	sub    $0x4,%esp
  801732:	68 a8 2a 80 00       	push   $0x802aa8
  801737:	6a 41                	push   $0x41
  801739:	68 75 2a 80 00       	push   $0x802a75
  80173e:	e8 66 ef ff ff       	call   8006a9 <_panic>

00801743 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801743:	55                   	push   %ebp
  801744:	89 e5                	mov    %esp,%ebp
  801746:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801749:	83 ec 04             	sub    $0x4,%esp
  80174c:	68 a8 2a 80 00       	push   $0x802aa8
  801751:	6a 47                	push   $0x47
  801753:	68 75 2a 80 00       	push   $0x802a75
  801758:	e8 4c ef ff ff       	call   8006a9 <_panic>

0080175d <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  80175d:	55                   	push   %ebp
  80175e:	89 e5                	mov    %esp,%ebp
  801760:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801763:	83 ec 04             	sub    $0x4,%esp
  801766:	68 a8 2a 80 00       	push   $0x802aa8
  80176b:	6a 4c                	push   $0x4c
  80176d:	68 75 2a 80 00       	push   $0x802a75
  801772:	e8 32 ef ff ff       	call   8006a9 <_panic>

00801777 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801777:	55                   	push   %ebp
  801778:	89 e5                	mov    %esp,%ebp
  80177a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80177d:	83 ec 04             	sub    $0x4,%esp
  801780:	68 a8 2a 80 00       	push   $0x802aa8
  801785:	6a 52                	push   $0x52
  801787:	68 75 2a 80 00       	push   $0x802a75
  80178c:	e8 18 ef ff ff       	call   8006a9 <_panic>

00801791 <shrink>:
}
void shrink(uint32 newSize)
{
  801791:	55                   	push   %ebp
  801792:	89 e5                	mov    %esp,%ebp
  801794:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801797:	83 ec 04             	sub    $0x4,%esp
  80179a:	68 a8 2a 80 00       	push   $0x802aa8
  80179f:	6a 56                	push   $0x56
  8017a1:	68 75 2a 80 00       	push   $0x802a75
  8017a6:	e8 fe ee ff ff       	call   8006a9 <_panic>

008017ab <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8017ab:	55                   	push   %ebp
  8017ac:	89 e5                	mov    %esp,%ebp
  8017ae:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8017b1:	83 ec 04             	sub    $0x4,%esp
  8017b4:	68 a8 2a 80 00       	push   $0x802aa8
  8017b9:	6a 5b                	push   $0x5b
  8017bb:	68 75 2a 80 00       	push   $0x802a75
  8017c0:	e8 e4 ee ff ff       	call   8006a9 <_panic>

008017c5 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8017c5:	55                   	push   %ebp
  8017c6:	89 e5                	mov    %esp,%ebp
  8017c8:	57                   	push   %edi
  8017c9:	56                   	push   %esi
  8017ca:	53                   	push   %ebx
  8017cb:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8017ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017d4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017d7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017da:	8b 7d 18             	mov    0x18(%ebp),%edi
  8017dd:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8017e0:	cd 30                	int    $0x30
  8017e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8017e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8017e8:	83 c4 10             	add    $0x10,%esp
  8017eb:	5b                   	pop    %ebx
  8017ec:	5e                   	pop    %esi
  8017ed:	5f                   	pop    %edi
  8017ee:	5d                   	pop    %ebp
  8017ef:	c3                   	ret    

008017f0 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8017f0:	55                   	push   %ebp
  8017f1:	89 e5                	mov    %esp,%ebp
  8017f3:	83 ec 04             	sub    $0x4,%esp
  8017f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8017f9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8017fc:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801800:	8b 45 08             	mov    0x8(%ebp),%eax
  801803:	6a 00                	push   $0x0
  801805:	6a 00                	push   $0x0
  801807:	52                   	push   %edx
  801808:	ff 75 0c             	pushl  0xc(%ebp)
  80180b:	50                   	push   %eax
  80180c:	6a 00                	push   $0x0
  80180e:	e8 b2 ff ff ff       	call   8017c5 <syscall>
  801813:	83 c4 18             	add    $0x18,%esp
}
  801816:	90                   	nop
  801817:	c9                   	leave  
  801818:	c3                   	ret    

00801819 <sys_cgetc>:

int
sys_cgetc(void)
{
  801819:	55                   	push   %ebp
  80181a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80181c:	6a 00                	push   $0x0
  80181e:	6a 00                	push   $0x0
  801820:	6a 00                	push   $0x0
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	6a 01                	push   $0x1
  801828:	e8 98 ff ff ff       	call   8017c5 <syscall>
  80182d:	83 c4 18             	add    $0x18,%esp
}
  801830:	c9                   	leave  
  801831:	c3                   	ret    

00801832 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801832:	55                   	push   %ebp
  801833:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801835:	8b 45 08             	mov    0x8(%ebp),%eax
  801838:	6a 00                	push   $0x0
  80183a:	6a 00                	push   $0x0
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	50                   	push   %eax
  801841:	6a 05                	push   $0x5
  801843:	e8 7d ff ff ff       	call   8017c5 <syscall>
  801848:	83 c4 18             	add    $0x18,%esp
}
  80184b:	c9                   	leave  
  80184c:	c3                   	ret    

0080184d <sys_getenvid>:

int32 sys_getenvid(void)
{
  80184d:	55                   	push   %ebp
  80184e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801850:	6a 00                	push   $0x0
  801852:	6a 00                	push   $0x0
  801854:	6a 00                	push   $0x0
  801856:	6a 00                	push   $0x0
  801858:	6a 00                	push   $0x0
  80185a:	6a 02                	push   $0x2
  80185c:	e8 64 ff ff ff       	call   8017c5 <syscall>
  801861:	83 c4 18             	add    $0x18,%esp
}
  801864:	c9                   	leave  
  801865:	c3                   	ret    

00801866 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801866:	55                   	push   %ebp
  801867:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801869:	6a 00                	push   $0x0
  80186b:	6a 00                	push   $0x0
  80186d:	6a 00                	push   $0x0
  80186f:	6a 00                	push   $0x0
  801871:	6a 00                	push   $0x0
  801873:	6a 03                	push   $0x3
  801875:	e8 4b ff ff ff       	call   8017c5 <syscall>
  80187a:	83 c4 18             	add    $0x18,%esp
}
  80187d:	c9                   	leave  
  80187e:	c3                   	ret    

0080187f <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80187f:	55                   	push   %ebp
  801880:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801882:	6a 00                	push   $0x0
  801884:	6a 00                	push   $0x0
  801886:	6a 00                	push   $0x0
  801888:	6a 00                	push   $0x0
  80188a:	6a 00                	push   $0x0
  80188c:	6a 04                	push   $0x4
  80188e:	e8 32 ff ff ff       	call   8017c5 <syscall>
  801893:	83 c4 18             	add    $0x18,%esp
}
  801896:	c9                   	leave  
  801897:	c3                   	ret    

00801898 <sys_env_exit>:


void sys_env_exit(void)
{
  801898:	55                   	push   %ebp
  801899:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80189b:	6a 00                	push   $0x0
  80189d:	6a 00                	push   $0x0
  80189f:	6a 00                	push   $0x0
  8018a1:	6a 00                	push   $0x0
  8018a3:	6a 00                	push   $0x0
  8018a5:	6a 06                	push   $0x6
  8018a7:	e8 19 ff ff ff       	call   8017c5 <syscall>
  8018ac:	83 c4 18             	add    $0x18,%esp
}
  8018af:	90                   	nop
  8018b0:	c9                   	leave  
  8018b1:	c3                   	ret    

008018b2 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8018b2:	55                   	push   %ebp
  8018b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8018b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bb:	6a 00                	push   $0x0
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	52                   	push   %edx
  8018c2:	50                   	push   %eax
  8018c3:	6a 07                	push   $0x7
  8018c5:	e8 fb fe ff ff       	call   8017c5 <syscall>
  8018ca:	83 c4 18             	add    $0x18,%esp
}
  8018cd:	c9                   	leave  
  8018ce:	c3                   	ret    

008018cf <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8018cf:	55                   	push   %ebp
  8018d0:	89 e5                	mov    %esp,%ebp
  8018d2:	56                   	push   %esi
  8018d3:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8018d4:	8b 75 18             	mov    0x18(%ebp),%esi
  8018d7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018da:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e3:	56                   	push   %esi
  8018e4:	53                   	push   %ebx
  8018e5:	51                   	push   %ecx
  8018e6:	52                   	push   %edx
  8018e7:	50                   	push   %eax
  8018e8:	6a 08                	push   $0x8
  8018ea:	e8 d6 fe ff ff       	call   8017c5 <syscall>
  8018ef:	83 c4 18             	add    $0x18,%esp
}
  8018f2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8018f5:	5b                   	pop    %ebx
  8018f6:	5e                   	pop    %esi
  8018f7:	5d                   	pop    %ebp
  8018f8:	c3                   	ret    

008018f9 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8018f9:	55                   	push   %ebp
  8018fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8018fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801902:	6a 00                	push   $0x0
  801904:	6a 00                	push   $0x0
  801906:	6a 00                	push   $0x0
  801908:	52                   	push   %edx
  801909:	50                   	push   %eax
  80190a:	6a 09                	push   $0x9
  80190c:	e8 b4 fe ff ff       	call   8017c5 <syscall>
  801911:	83 c4 18             	add    $0x18,%esp
}
  801914:	c9                   	leave  
  801915:	c3                   	ret    

00801916 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801916:	55                   	push   %ebp
  801917:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801919:	6a 00                	push   $0x0
  80191b:	6a 00                	push   $0x0
  80191d:	6a 00                	push   $0x0
  80191f:	ff 75 0c             	pushl  0xc(%ebp)
  801922:	ff 75 08             	pushl  0x8(%ebp)
  801925:	6a 0a                	push   $0xa
  801927:	e8 99 fe ff ff       	call   8017c5 <syscall>
  80192c:	83 c4 18             	add    $0x18,%esp
}
  80192f:	c9                   	leave  
  801930:	c3                   	ret    

00801931 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801931:	55                   	push   %ebp
  801932:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801934:	6a 00                	push   $0x0
  801936:	6a 00                	push   $0x0
  801938:	6a 00                	push   $0x0
  80193a:	6a 00                	push   $0x0
  80193c:	6a 00                	push   $0x0
  80193e:	6a 0b                	push   $0xb
  801940:	e8 80 fe ff ff       	call   8017c5 <syscall>
  801945:	83 c4 18             	add    $0x18,%esp
}
  801948:	c9                   	leave  
  801949:	c3                   	ret    

0080194a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80194a:	55                   	push   %ebp
  80194b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80194d:	6a 00                	push   $0x0
  80194f:	6a 00                	push   $0x0
  801951:	6a 00                	push   $0x0
  801953:	6a 00                	push   $0x0
  801955:	6a 00                	push   $0x0
  801957:	6a 0c                	push   $0xc
  801959:	e8 67 fe ff ff       	call   8017c5 <syscall>
  80195e:	83 c4 18             	add    $0x18,%esp
}
  801961:	c9                   	leave  
  801962:	c3                   	ret    

00801963 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801963:	55                   	push   %ebp
  801964:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801966:	6a 00                	push   $0x0
  801968:	6a 00                	push   $0x0
  80196a:	6a 00                	push   $0x0
  80196c:	6a 00                	push   $0x0
  80196e:	6a 00                	push   $0x0
  801970:	6a 0d                	push   $0xd
  801972:	e8 4e fe ff ff       	call   8017c5 <syscall>
  801977:	83 c4 18             	add    $0x18,%esp
}
  80197a:	c9                   	leave  
  80197b:	c3                   	ret    

0080197c <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80197c:	55                   	push   %ebp
  80197d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80197f:	6a 00                	push   $0x0
  801981:	6a 00                	push   $0x0
  801983:	6a 00                	push   $0x0
  801985:	ff 75 0c             	pushl  0xc(%ebp)
  801988:	ff 75 08             	pushl  0x8(%ebp)
  80198b:	6a 11                	push   $0x11
  80198d:	e8 33 fe ff ff       	call   8017c5 <syscall>
  801992:	83 c4 18             	add    $0x18,%esp
	return;
  801995:	90                   	nop
}
  801996:	c9                   	leave  
  801997:	c3                   	ret    

00801998 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801998:	55                   	push   %ebp
  801999:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80199b:	6a 00                	push   $0x0
  80199d:	6a 00                	push   $0x0
  80199f:	6a 00                	push   $0x0
  8019a1:	ff 75 0c             	pushl  0xc(%ebp)
  8019a4:	ff 75 08             	pushl  0x8(%ebp)
  8019a7:	6a 12                	push   $0x12
  8019a9:	e8 17 fe ff ff       	call   8017c5 <syscall>
  8019ae:	83 c4 18             	add    $0x18,%esp
	return ;
  8019b1:	90                   	nop
}
  8019b2:	c9                   	leave  
  8019b3:	c3                   	ret    

008019b4 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8019b4:	55                   	push   %ebp
  8019b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8019b7:	6a 00                	push   $0x0
  8019b9:	6a 00                	push   $0x0
  8019bb:	6a 00                	push   $0x0
  8019bd:	6a 00                	push   $0x0
  8019bf:	6a 00                	push   $0x0
  8019c1:	6a 0e                	push   $0xe
  8019c3:	e8 fd fd ff ff       	call   8017c5 <syscall>
  8019c8:	83 c4 18             	add    $0x18,%esp
}
  8019cb:	c9                   	leave  
  8019cc:	c3                   	ret    

008019cd <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8019cd:	55                   	push   %ebp
  8019ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8019d0:	6a 00                	push   $0x0
  8019d2:	6a 00                	push   $0x0
  8019d4:	6a 00                	push   $0x0
  8019d6:	6a 00                	push   $0x0
  8019d8:	ff 75 08             	pushl  0x8(%ebp)
  8019db:	6a 0f                	push   $0xf
  8019dd:	e8 e3 fd ff ff       	call   8017c5 <syscall>
  8019e2:	83 c4 18             	add    $0x18,%esp
}
  8019e5:	c9                   	leave  
  8019e6:	c3                   	ret    

008019e7 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8019e7:	55                   	push   %ebp
  8019e8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8019ea:	6a 00                	push   $0x0
  8019ec:	6a 00                	push   $0x0
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 00                	push   $0x0
  8019f2:	6a 00                	push   $0x0
  8019f4:	6a 10                	push   $0x10
  8019f6:	e8 ca fd ff ff       	call   8017c5 <syscall>
  8019fb:	83 c4 18             	add    $0x18,%esp
}
  8019fe:	90                   	nop
  8019ff:	c9                   	leave  
  801a00:	c3                   	ret    

00801a01 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801a01:	55                   	push   %ebp
  801a02:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801a04:	6a 00                	push   $0x0
  801a06:	6a 00                	push   $0x0
  801a08:	6a 00                	push   $0x0
  801a0a:	6a 00                	push   $0x0
  801a0c:	6a 00                	push   $0x0
  801a0e:	6a 14                	push   $0x14
  801a10:	e8 b0 fd ff ff       	call   8017c5 <syscall>
  801a15:	83 c4 18             	add    $0x18,%esp
}
  801a18:	90                   	nop
  801a19:	c9                   	leave  
  801a1a:	c3                   	ret    

00801a1b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801a1b:	55                   	push   %ebp
  801a1c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801a1e:	6a 00                	push   $0x0
  801a20:	6a 00                	push   $0x0
  801a22:	6a 00                	push   $0x0
  801a24:	6a 00                	push   $0x0
  801a26:	6a 00                	push   $0x0
  801a28:	6a 15                	push   $0x15
  801a2a:	e8 96 fd ff ff       	call   8017c5 <syscall>
  801a2f:	83 c4 18             	add    $0x18,%esp
}
  801a32:	90                   	nop
  801a33:	c9                   	leave  
  801a34:	c3                   	ret    

00801a35 <sys_cputc>:


void
sys_cputc(const char c)
{
  801a35:	55                   	push   %ebp
  801a36:	89 e5                	mov    %esp,%ebp
  801a38:	83 ec 04             	sub    $0x4,%esp
  801a3b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a3e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801a41:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a45:	6a 00                	push   $0x0
  801a47:	6a 00                	push   $0x0
  801a49:	6a 00                	push   $0x0
  801a4b:	6a 00                	push   $0x0
  801a4d:	50                   	push   %eax
  801a4e:	6a 16                	push   $0x16
  801a50:	e8 70 fd ff ff       	call   8017c5 <syscall>
  801a55:	83 c4 18             	add    $0x18,%esp
}
  801a58:	90                   	nop
  801a59:	c9                   	leave  
  801a5a:	c3                   	ret    

00801a5b <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801a5b:	55                   	push   %ebp
  801a5c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801a5e:	6a 00                	push   $0x0
  801a60:	6a 00                	push   $0x0
  801a62:	6a 00                	push   $0x0
  801a64:	6a 00                	push   $0x0
  801a66:	6a 00                	push   $0x0
  801a68:	6a 17                	push   $0x17
  801a6a:	e8 56 fd ff ff       	call   8017c5 <syscall>
  801a6f:	83 c4 18             	add    $0x18,%esp
}
  801a72:	90                   	nop
  801a73:	c9                   	leave  
  801a74:	c3                   	ret    

00801a75 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801a75:	55                   	push   %ebp
  801a76:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801a78:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7b:	6a 00                	push   $0x0
  801a7d:	6a 00                	push   $0x0
  801a7f:	6a 00                	push   $0x0
  801a81:	ff 75 0c             	pushl  0xc(%ebp)
  801a84:	50                   	push   %eax
  801a85:	6a 18                	push   $0x18
  801a87:	e8 39 fd ff ff       	call   8017c5 <syscall>
  801a8c:	83 c4 18             	add    $0x18,%esp
}
  801a8f:	c9                   	leave  
  801a90:	c3                   	ret    

00801a91 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801a91:	55                   	push   %ebp
  801a92:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a94:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a97:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9a:	6a 00                	push   $0x0
  801a9c:	6a 00                	push   $0x0
  801a9e:	6a 00                	push   $0x0
  801aa0:	52                   	push   %edx
  801aa1:	50                   	push   %eax
  801aa2:	6a 1b                	push   $0x1b
  801aa4:	e8 1c fd ff ff       	call   8017c5 <syscall>
  801aa9:	83 c4 18             	add    $0x18,%esp
}
  801aac:	c9                   	leave  
  801aad:	c3                   	ret    

00801aae <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801aae:	55                   	push   %ebp
  801aaf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ab1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ab4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab7:	6a 00                	push   $0x0
  801ab9:	6a 00                	push   $0x0
  801abb:	6a 00                	push   $0x0
  801abd:	52                   	push   %edx
  801abe:	50                   	push   %eax
  801abf:	6a 19                	push   $0x19
  801ac1:	e8 ff fc ff ff       	call   8017c5 <syscall>
  801ac6:	83 c4 18             	add    $0x18,%esp
}
  801ac9:	90                   	nop
  801aca:	c9                   	leave  
  801acb:	c3                   	ret    

00801acc <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801acc:	55                   	push   %ebp
  801acd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801acf:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ad2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad5:	6a 00                	push   $0x0
  801ad7:	6a 00                	push   $0x0
  801ad9:	6a 00                	push   $0x0
  801adb:	52                   	push   %edx
  801adc:	50                   	push   %eax
  801add:	6a 1a                	push   $0x1a
  801adf:	e8 e1 fc ff ff       	call   8017c5 <syscall>
  801ae4:	83 c4 18             	add    $0x18,%esp
}
  801ae7:	90                   	nop
  801ae8:	c9                   	leave  
  801ae9:	c3                   	ret    

00801aea <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801aea:	55                   	push   %ebp
  801aeb:	89 e5                	mov    %esp,%ebp
  801aed:	83 ec 04             	sub    $0x4,%esp
  801af0:	8b 45 10             	mov    0x10(%ebp),%eax
  801af3:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801af6:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801af9:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801afd:	8b 45 08             	mov    0x8(%ebp),%eax
  801b00:	6a 00                	push   $0x0
  801b02:	51                   	push   %ecx
  801b03:	52                   	push   %edx
  801b04:	ff 75 0c             	pushl  0xc(%ebp)
  801b07:	50                   	push   %eax
  801b08:	6a 1c                	push   $0x1c
  801b0a:	e8 b6 fc ff ff       	call   8017c5 <syscall>
  801b0f:	83 c4 18             	add    $0x18,%esp
}
  801b12:	c9                   	leave  
  801b13:	c3                   	ret    

00801b14 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801b14:	55                   	push   %ebp
  801b15:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801b17:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1d:	6a 00                	push   $0x0
  801b1f:	6a 00                	push   $0x0
  801b21:	6a 00                	push   $0x0
  801b23:	52                   	push   %edx
  801b24:	50                   	push   %eax
  801b25:	6a 1d                	push   $0x1d
  801b27:	e8 99 fc ff ff       	call   8017c5 <syscall>
  801b2c:	83 c4 18             	add    $0x18,%esp
}
  801b2f:	c9                   	leave  
  801b30:	c3                   	ret    

00801b31 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801b31:	55                   	push   %ebp
  801b32:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801b34:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b37:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3d:	6a 00                	push   $0x0
  801b3f:	6a 00                	push   $0x0
  801b41:	51                   	push   %ecx
  801b42:	52                   	push   %edx
  801b43:	50                   	push   %eax
  801b44:	6a 1e                	push   $0x1e
  801b46:	e8 7a fc ff ff       	call   8017c5 <syscall>
  801b4b:	83 c4 18             	add    $0x18,%esp
}
  801b4e:	c9                   	leave  
  801b4f:	c3                   	ret    

00801b50 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801b50:	55                   	push   %ebp
  801b51:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801b53:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b56:	8b 45 08             	mov    0x8(%ebp),%eax
  801b59:	6a 00                	push   $0x0
  801b5b:	6a 00                	push   $0x0
  801b5d:	6a 00                	push   $0x0
  801b5f:	52                   	push   %edx
  801b60:	50                   	push   %eax
  801b61:	6a 1f                	push   $0x1f
  801b63:	e8 5d fc ff ff       	call   8017c5 <syscall>
  801b68:	83 c4 18             	add    $0x18,%esp
}
  801b6b:	c9                   	leave  
  801b6c:	c3                   	ret    

00801b6d <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801b6d:	55                   	push   %ebp
  801b6e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801b70:	6a 00                	push   $0x0
  801b72:	6a 00                	push   $0x0
  801b74:	6a 00                	push   $0x0
  801b76:	6a 00                	push   $0x0
  801b78:	6a 00                	push   $0x0
  801b7a:	6a 20                	push   $0x20
  801b7c:	e8 44 fc ff ff       	call   8017c5 <syscall>
  801b81:	83 c4 18             	add    $0x18,%esp
}
  801b84:	c9                   	leave  
  801b85:	c3                   	ret    

00801b86 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801b86:	55                   	push   %ebp
  801b87:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801b89:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8c:	6a 00                	push   $0x0
  801b8e:	ff 75 14             	pushl  0x14(%ebp)
  801b91:	ff 75 10             	pushl  0x10(%ebp)
  801b94:	ff 75 0c             	pushl  0xc(%ebp)
  801b97:	50                   	push   %eax
  801b98:	6a 21                	push   $0x21
  801b9a:	e8 26 fc ff ff       	call   8017c5 <syscall>
  801b9f:	83 c4 18             	add    $0x18,%esp
}
  801ba2:	c9                   	leave  
  801ba3:	c3                   	ret    

00801ba4 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801ba4:	55                   	push   %ebp
  801ba5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801ba7:	8b 45 08             	mov    0x8(%ebp),%eax
  801baa:	6a 00                	push   $0x0
  801bac:	6a 00                	push   $0x0
  801bae:	6a 00                	push   $0x0
  801bb0:	6a 00                	push   $0x0
  801bb2:	50                   	push   %eax
  801bb3:	6a 22                	push   $0x22
  801bb5:	e8 0b fc ff ff       	call   8017c5 <syscall>
  801bba:	83 c4 18             	add    $0x18,%esp
}
  801bbd:	90                   	nop
  801bbe:	c9                   	leave  
  801bbf:	c3                   	ret    

00801bc0 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801bc0:	55                   	push   %ebp
  801bc1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801bc3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc6:	6a 00                	push   $0x0
  801bc8:	6a 00                	push   $0x0
  801bca:	6a 00                	push   $0x0
  801bcc:	6a 00                	push   $0x0
  801bce:	50                   	push   %eax
  801bcf:	6a 23                	push   $0x23
  801bd1:	e8 ef fb ff ff       	call   8017c5 <syscall>
  801bd6:	83 c4 18             	add    $0x18,%esp
}
  801bd9:	90                   	nop
  801bda:	c9                   	leave  
  801bdb:	c3                   	ret    

00801bdc <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801bdc:	55                   	push   %ebp
  801bdd:	89 e5                	mov    %esp,%ebp
  801bdf:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801be2:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801be5:	8d 50 04             	lea    0x4(%eax),%edx
  801be8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801beb:	6a 00                	push   $0x0
  801bed:	6a 00                	push   $0x0
  801bef:	6a 00                	push   $0x0
  801bf1:	52                   	push   %edx
  801bf2:	50                   	push   %eax
  801bf3:	6a 24                	push   $0x24
  801bf5:	e8 cb fb ff ff       	call   8017c5 <syscall>
  801bfa:	83 c4 18             	add    $0x18,%esp
	return result;
  801bfd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801c00:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c03:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c06:	89 01                	mov    %eax,(%ecx)
  801c08:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801c0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801c0e:	c9                   	leave  
  801c0f:	c2 04 00             	ret    $0x4

00801c12 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801c12:	55                   	push   %ebp
  801c13:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	ff 75 10             	pushl  0x10(%ebp)
  801c1c:	ff 75 0c             	pushl  0xc(%ebp)
  801c1f:	ff 75 08             	pushl  0x8(%ebp)
  801c22:	6a 13                	push   $0x13
  801c24:	e8 9c fb ff ff       	call   8017c5 <syscall>
  801c29:	83 c4 18             	add    $0x18,%esp
	return ;
  801c2c:	90                   	nop
}
  801c2d:	c9                   	leave  
  801c2e:	c3                   	ret    

00801c2f <sys_rcr2>:
uint32 sys_rcr2()
{
  801c2f:	55                   	push   %ebp
  801c30:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801c32:	6a 00                	push   $0x0
  801c34:	6a 00                	push   $0x0
  801c36:	6a 00                	push   $0x0
  801c38:	6a 00                	push   $0x0
  801c3a:	6a 00                	push   $0x0
  801c3c:	6a 25                	push   $0x25
  801c3e:	e8 82 fb ff ff       	call   8017c5 <syscall>
  801c43:	83 c4 18             	add    $0x18,%esp
}
  801c46:	c9                   	leave  
  801c47:	c3                   	ret    

00801c48 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801c48:	55                   	push   %ebp
  801c49:	89 e5                	mov    %esp,%ebp
  801c4b:	83 ec 04             	sub    $0x4,%esp
  801c4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c51:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801c54:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801c58:	6a 00                	push   $0x0
  801c5a:	6a 00                	push   $0x0
  801c5c:	6a 00                	push   $0x0
  801c5e:	6a 00                	push   $0x0
  801c60:	50                   	push   %eax
  801c61:	6a 26                	push   $0x26
  801c63:	e8 5d fb ff ff       	call   8017c5 <syscall>
  801c68:	83 c4 18             	add    $0x18,%esp
	return ;
  801c6b:	90                   	nop
}
  801c6c:	c9                   	leave  
  801c6d:	c3                   	ret    

00801c6e <rsttst>:
void rsttst()
{
  801c6e:	55                   	push   %ebp
  801c6f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801c71:	6a 00                	push   $0x0
  801c73:	6a 00                	push   $0x0
  801c75:	6a 00                	push   $0x0
  801c77:	6a 00                	push   $0x0
  801c79:	6a 00                	push   $0x0
  801c7b:	6a 28                	push   $0x28
  801c7d:	e8 43 fb ff ff       	call   8017c5 <syscall>
  801c82:	83 c4 18             	add    $0x18,%esp
	return ;
  801c85:	90                   	nop
}
  801c86:	c9                   	leave  
  801c87:	c3                   	ret    

00801c88 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801c88:	55                   	push   %ebp
  801c89:	89 e5                	mov    %esp,%ebp
  801c8b:	83 ec 04             	sub    $0x4,%esp
  801c8e:	8b 45 14             	mov    0x14(%ebp),%eax
  801c91:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801c94:	8b 55 18             	mov    0x18(%ebp),%edx
  801c97:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c9b:	52                   	push   %edx
  801c9c:	50                   	push   %eax
  801c9d:	ff 75 10             	pushl  0x10(%ebp)
  801ca0:	ff 75 0c             	pushl  0xc(%ebp)
  801ca3:	ff 75 08             	pushl  0x8(%ebp)
  801ca6:	6a 27                	push   $0x27
  801ca8:	e8 18 fb ff ff       	call   8017c5 <syscall>
  801cad:	83 c4 18             	add    $0x18,%esp
	return ;
  801cb0:	90                   	nop
}
  801cb1:	c9                   	leave  
  801cb2:	c3                   	ret    

00801cb3 <chktst>:
void chktst(uint32 n)
{
  801cb3:	55                   	push   %ebp
  801cb4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801cb6:	6a 00                	push   $0x0
  801cb8:	6a 00                	push   $0x0
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 00                	push   $0x0
  801cbe:	ff 75 08             	pushl  0x8(%ebp)
  801cc1:	6a 29                	push   $0x29
  801cc3:	e8 fd fa ff ff       	call   8017c5 <syscall>
  801cc8:	83 c4 18             	add    $0x18,%esp
	return ;
  801ccb:	90                   	nop
}
  801ccc:	c9                   	leave  
  801ccd:	c3                   	ret    

00801cce <inctst>:

void inctst()
{
  801cce:	55                   	push   %ebp
  801ccf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801cd1:	6a 00                	push   $0x0
  801cd3:	6a 00                	push   $0x0
  801cd5:	6a 00                	push   $0x0
  801cd7:	6a 00                	push   $0x0
  801cd9:	6a 00                	push   $0x0
  801cdb:	6a 2a                	push   $0x2a
  801cdd:	e8 e3 fa ff ff       	call   8017c5 <syscall>
  801ce2:	83 c4 18             	add    $0x18,%esp
	return ;
  801ce5:	90                   	nop
}
  801ce6:	c9                   	leave  
  801ce7:	c3                   	ret    

00801ce8 <gettst>:
uint32 gettst()
{
  801ce8:	55                   	push   %ebp
  801ce9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ceb:	6a 00                	push   $0x0
  801ced:	6a 00                	push   $0x0
  801cef:	6a 00                	push   $0x0
  801cf1:	6a 00                	push   $0x0
  801cf3:	6a 00                	push   $0x0
  801cf5:	6a 2b                	push   $0x2b
  801cf7:	e8 c9 fa ff ff       	call   8017c5 <syscall>
  801cfc:	83 c4 18             	add    $0x18,%esp
}
  801cff:	c9                   	leave  
  801d00:	c3                   	ret    

00801d01 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801d01:	55                   	push   %ebp
  801d02:	89 e5                	mov    %esp,%ebp
  801d04:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d07:	6a 00                	push   $0x0
  801d09:	6a 00                	push   $0x0
  801d0b:	6a 00                	push   $0x0
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 2c                	push   $0x2c
  801d13:	e8 ad fa ff ff       	call   8017c5 <syscall>
  801d18:	83 c4 18             	add    $0x18,%esp
  801d1b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801d1e:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801d22:	75 07                	jne    801d2b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801d24:	b8 01 00 00 00       	mov    $0x1,%eax
  801d29:	eb 05                	jmp    801d30 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801d2b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d30:	c9                   	leave  
  801d31:	c3                   	ret    

00801d32 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801d32:	55                   	push   %ebp
  801d33:	89 e5                	mov    %esp,%ebp
  801d35:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d38:	6a 00                	push   $0x0
  801d3a:	6a 00                	push   $0x0
  801d3c:	6a 00                	push   $0x0
  801d3e:	6a 00                	push   $0x0
  801d40:	6a 00                	push   $0x0
  801d42:	6a 2c                	push   $0x2c
  801d44:	e8 7c fa ff ff       	call   8017c5 <syscall>
  801d49:	83 c4 18             	add    $0x18,%esp
  801d4c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801d4f:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801d53:	75 07                	jne    801d5c <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801d55:	b8 01 00 00 00       	mov    $0x1,%eax
  801d5a:	eb 05                	jmp    801d61 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801d5c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d61:	c9                   	leave  
  801d62:	c3                   	ret    

00801d63 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801d63:	55                   	push   %ebp
  801d64:	89 e5                	mov    %esp,%ebp
  801d66:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d69:	6a 00                	push   $0x0
  801d6b:	6a 00                	push   $0x0
  801d6d:	6a 00                	push   $0x0
  801d6f:	6a 00                	push   $0x0
  801d71:	6a 00                	push   $0x0
  801d73:	6a 2c                	push   $0x2c
  801d75:	e8 4b fa ff ff       	call   8017c5 <syscall>
  801d7a:	83 c4 18             	add    $0x18,%esp
  801d7d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801d80:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801d84:	75 07                	jne    801d8d <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801d86:	b8 01 00 00 00       	mov    $0x1,%eax
  801d8b:	eb 05                	jmp    801d92 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801d8d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d92:	c9                   	leave  
  801d93:	c3                   	ret    

00801d94 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801d94:	55                   	push   %ebp
  801d95:	89 e5                	mov    %esp,%ebp
  801d97:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 00                	push   $0x0
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	6a 2c                	push   $0x2c
  801da6:	e8 1a fa ff ff       	call   8017c5 <syscall>
  801dab:	83 c4 18             	add    $0x18,%esp
  801dae:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801db1:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801db5:	75 07                	jne    801dbe <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801db7:	b8 01 00 00 00       	mov    $0x1,%eax
  801dbc:	eb 05                	jmp    801dc3 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801dbe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801dc3:	c9                   	leave  
  801dc4:	c3                   	ret    

00801dc5 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801dc5:	55                   	push   %ebp
  801dc6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801dc8:	6a 00                	push   $0x0
  801dca:	6a 00                	push   $0x0
  801dcc:	6a 00                	push   $0x0
  801dce:	6a 00                	push   $0x0
  801dd0:	ff 75 08             	pushl  0x8(%ebp)
  801dd3:	6a 2d                	push   $0x2d
  801dd5:	e8 eb f9 ff ff       	call   8017c5 <syscall>
  801dda:	83 c4 18             	add    $0x18,%esp
	return ;
  801ddd:	90                   	nop
}
  801dde:	c9                   	leave  
  801ddf:	c3                   	ret    

00801de0 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801de0:	55                   	push   %ebp
  801de1:	89 e5                	mov    %esp,%ebp
  801de3:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801de4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801de7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801dea:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ded:	8b 45 08             	mov    0x8(%ebp),%eax
  801df0:	6a 00                	push   $0x0
  801df2:	53                   	push   %ebx
  801df3:	51                   	push   %ecx
  801df4:	52                   	push   %edx
  801df5:	50                   	push   %eax
  801df6:	6a 2e                	push   $0x2e
  801df8:	e8 c8 f9 ff ff       	call   8017c5 <syscall>
  801dfd:	83 c4 18             	add    $0x18,%esp
}
  801e00:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801e03:	c9                   	leave  
  801e04:	c3                   	ret    

00801e05 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801e05:	55                   	push   %ebp
  801e06:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801e08:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0e:	6a 00                	push   $0x0
  801e10:	6a 00                	push   $0x0
  801e12:	6a 00                	push   $0x0
  801e14:	52                   	push   %edx
  801e15:	50                   	push   %eax
  801e16:	6a 2f                	push   $0x2f
  801e18:	e8 a8 f9 ff ff       	call   8017c5 <syscall>
  801e1d:	83 c4 18             	add    $0x18,%esp
}
  801e20:	c9                   	leave  
  801e21:	c3                   	ret    
  801e22:	66 90                	xchg   %ax,%ax

00801e24 <__udivdi3>:
  801e24:	55                   	push   %ebp
  801e25:	57                   	push   %edi
  801e26:	56                   	push   %esi
  801e27:	53                   	push   %ebx
  801e28:	83 ec 1c             	sub    $0x1c,%esp
  801e2b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801e2f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801e33:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e37:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801e3b:	89 ca                	mov    %ecx,%edx
  801e3d:	89 f8                	mov    %edi,%eax
  801e3f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801e43:	85 f6                	test   %esi,%esi
  801e45:	75 2d                	jne    801e74 <__udivdi3+0x50>
  801e47:	39 cf                	cmp    %ecx,%edi
  801e49:	77 65                	ja     801eb0 <__udivdi3+0x8c>
  801e4b:	89 fd                	mov    %edi,%ebp
  801e4d:	85 ff                	test   %edi,%edi
  801e4f:	75 0b                	jne    801e5c <__udivdi3+0x38>
  801e51:	b8 01 00 00 00       	mov    $0x1,%eax
  801e56:	31 d2                	xor    %edx,%edx
  801e58:	f7 f7                	div    %edi
  801e5a:	89 c5                	mov    %eax,%ebp
  801e5c:	31 d2                	xor    %edx,%edx
  801e5e:	89 c8                	mov    %ecx,%eax
  801e60:	f7 f5                	div    %ebp
  801e62:	89 c1                	mov    %eax,%ecx
  801e64:	89 d8                	mov    %ebx,%eax
  801e66:	f7 f5                	div    %ebp
  801e68:	89 cf                	mov    %ecx,%edi
  801e6a:	89 fa                	mov    %edi,%edx
  801e6c:	83 c4 1c             	add    $0x1c,%esp
  801e6f:	5b                   	pop    %ebx
  801e70:	5e                   	pop    %esi
  801e71:	5f                   	pop    %edi
  801e72:	5d                   	pop    %ebp
  801e73:	c3                   	ret    
  801e74:	39 ce                	cmp    %ecx,%esi
  801e76:	77 28                	ja     801ea0 <__udivdi3+0x7c>
  801e78:	0f bd fe             	bsr    %esi,%edi
  801e7b:	83 f7 1f             	xor    $0x1f,%edi
  801e7e:	75 40                	jne    801ec0 <__udivdi3+0x9c>
  801e80:	39 ce                	cmp    %ecx,%esi
  801e82:	72 0a                	jb     801e8e <__udivdi3+0x6a>
  801e84:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e88:	0f 87 9e 00 00 00    	ja     801f2c <__udivdi3+0x108>
  801e8e:	b8 01 00 00 00       	mov    $0x1,%eax
  801e93:	89 fa                	mov    %edi,%edx
  801e95:	83 c4 1c             	add    $0x1c,%esp
  801e98:	5b                   	pop    %ebx
  801e99:	5e                   	pop    %esi
  801e9a:	5f                   	pop    %edi
  801e9b:	5d                   	pop    %ebp
  801e9c:	c3                   	ret    
  801e9d:	8d 76 00             	lea    0x0(%esi),%esi
  801ea0:	31 ff                	xor    %edi,%edi
  801ea2:	31 c0                	xor    %eax,%eax
  801ea4:	89 fa                	mov    %edi,%edx
  801ea6:	83 c4 1c             	add    $0x1c,%esp
  801ea9:	5b                   	pop    %ebx
  801eaa:	5e                   	pop    %esi
  801eab:	5f                   	pop    %edi
  801eac:	5d                   	pop    %ebp
  801ead:	c3                   	ret    
  801eae:	66 90                	xchg   %ax,%ax
  801eb0:	89 d8                	mov    %ebx,%eax
  801eb2:	f7 f7                	div    %edi
  801eb4:	31 ff                	xor    %edi,%edi
  801eb6:	89 fa                	mov    %edi,%edx
  801eb8:	83 c4 1c             	add    $0x1c,%esp
  801ebb:	5b                   	pop    %ebx
  801ebc:	5e                   	pop    %esi
  801ebd:	5f                   	pop    %edi
  801ebe:	5d                   	pop    %ebp
  801ebf:	c3                   	ret    
  801ec0:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ec5:	89 eb                	mov    %ebp,%ebx
  801ec7:	29 fb                	sub    %edi,%ebx
  801ec9:	89 f9                	mov    %edi,%ecx
  801ecb:	d3 e6                	shl    %cl,%esi
  801ecd:	89 c5                	mov    %eax,%ebp
  801ecf:	88 d9                	mov    %bl,%cl
  801ed1:	d3 ed                	shr    %cl,%ebp
  801ed3:	89 e9                	mov    %ebp,%ecx
  801ed5:	09 f1                	or     %esi,%ecx
  801ed7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801edb:	89 f9                	mov    %edi,%ecx
  801edd:	d3 e0                	shl    %cl,%eax
  801edf:	89 c5                	mov    %eax,%ebp
  801ee1:	89 d6                	mov    %edx,%esi
  801ee3:	88 d9                	mov    %bl,%cl
  801ee5:	d3 ee                	shr    %cl,%esi
  801ee7:	89 f9                	mov    %edi,%ecx
  801ee9:	d3 e2                	shl    %cl,%edx
  801eeb:	8b 44 24 08          	mov    0x8(%esp),%eax
  801eef:	88 d9                	mov    %bl,%cl
  801ef1:	d3 e8                	shr    %cl,%eax
  801ef3:	09 c2                	or     %eax,%edx
  801ef5:	89 d0                	mov    %edx,%eax
  801ef7:	89 f2                	mov    %esi,%edx
  801ef9:	f7 74 24 0c          	divl   0xc(%esp)
  801efd:	89 d6                	mov    %edx,%esi
  801eff:	89 c3                	mov    %eax,%ebx
  801f01:	f7 e5                	mul    %ebp
  801f03:	39 d6                	cmp    %edx,%esi
  801f05:	72 19                	jb     801f20 <__udivdi3+0xfc>
  801f07:	74 0b                	je     801f14 <__udivdi3+0xf0>
  801f09:	89 d8                	mov    %ebx,%eax
  801f0b:	31 ff                	xor    %edi,%edi
  801f0d:	e9 58 ff ff ff       	jmp    801e6a <__udivdi3+0x46>
  801f12:	66 90                	xchg   %ax,%ax
  801f14:	8b 54 24 08          	mov    0x8(%esp),%edx
  801f18:	89 f9                	mov    %edi,%ecx
  801f1a:	d3 e2                	shl    %cl,%edx
  801f1c:	39 c2                	cmp    %eax,%edx
  801f1e:	73 e9                	jae    801f09 <__udivdi3+0xe5>
  801f20:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801f23:	31 ff                	xor    %edi,%edi
  801f25:	e9 40 ff ff ff       	jmp    801e6a <__udivdi3+0x46>
  801f2a:	66 90                	xchg   %ax,%ax
  801f2c:	31 c0                	xor    %eax,%eax
  801f2e:	e9 37 ff ff ff       	jmp    801e6a <__udivdi3+0x46>
  801f33:	90                   	nop

00801f34 <__umoddi3>:
  801f34:	55                   	push   %ebp
  801f35:	57                   	push   %edi
  801f36:	56                   	push   %esi
  801f37:	53                   	push   %ebx
  801f38:	83 ec 1c             	sub    $0x1c,%esp
  801f3b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801f3f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801f43:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f47:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801f4b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801f4f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801f53:	89 f3                	mov    %esi,%ebx
  801f55:	89 fa                	mov    %edi,%edx
  801f57:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f5b:	89 34 24             	mov    %esi,(%esp)
  801f5e:	85 c0                	test   %eax,%eax
  801f60:	75 1a                	jne    801f7c <__umoddi3+0x48>
  801f62:	39 f7                	cmp    %esi,%edi
  801f64:	0f 86 a2 00 00 00    	jbe    80200c <__umoddi3+0xd8>
  801f6a:	89 c8                	mov    %ecx,%eax
  801f6c:	89 f2                	mov    %esi,%edx
  801f6e:	f7 f7                	div    %edi
  801f70:	89 d0                	mov    %edx,%eax
  801f72:	31 d2                	xor    %edx,%edx
  801f74:	83 c4 1c             	add    $0x1c,%esp
  801f77:	5b                   	pop    %ebx
  801f78:	5e                   	pop    %esi
  801f79:	5f                   	pop    %edi
  801f7a:	5d                   	pop    %ebp
  801f7b:	c3                   	ret    
  801f7c:	39 f0                	cmp    %esi,%eax
  801f7e:	0f 87 ac 00 00 00    	ja     802030 <__umoddi3+0xfc>
  801f84:	0f bd e8             	bsr    %eax,%ebp
  801f87:	83 f5 1f             	xor    $0x1f,%ebp
  801f8a:	0f 84 ac 00 00 00    	je     80203c <__umoddi3+0x108>
  801f90:	bf 20 00 00 00       	mov    $0x20,%edi
  801f95:	29 ef                	sub    %ebp,%edi
  801f97:	89 fe                	mov    %edi,%esi
  801f99:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f9d:	89 e9                	mov    %ebp,%ecx
  801f9f:	d3 e0                	shl    %cl,%eax
  801fa1:	89 d7                	mov    %edx,%edi
  801fa3:	89 f1                	mov    %esi,%ecx
  801fa5:	d3 ef                	shr    %cl,%edi
  801fa7:	09 c7                	or     %eax,%edi
  801fa9:	89 e9                	mov    %ebp,%ecx
  801fab:	d3 e2                	shl    %cl,%edx
  801fad:	89 14 24             	mov    %edx,(%esp)
  801fb0:	89 d8                	mov    %ebx,%eax
  801fb2:	d3 e0                	shl    %cl,%eax
  801fb4:	89 c2                	mov    %eax,%edx
  801fb6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fba:	d3 e0                	shl    %cl,%eax
  801fbc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801fc0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fc4:	89 f1                	mov    %esi,%ecx
  801fc6:	d3 e8                	shr    %cl,%eax
  801fc8:	09 d0                	or     %edx,%eax
  801fca:	d3 eb                	shr    %cl,%ebx
  801fcc:	89 da                	mov    %ebx,%edx
  801fce:	f7 f7                	div    %edi
  801fd0:	89 d3                	mov    %edx,%ebx
  801fd2:	f7 24 24             	mull   (%esp)
  801fd5:	89 c6                	mov    %eax,%esi
  801fd7:	89 d1                	mov    %edx,%ecx
  801fd9:	39 d3                	cmp    %edx,%ebx
  801fdb:	0f 82 87 00 00 00    	jb     802068 <__umoddi3+0x134>
  801fe1:	0f 84 91 00 00 00    	je     802078 <__umoddi3+0x144>
  801fe7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801feb:	29 f2                	sub    %esi,%edx
  801fed:	19 cb                	sbb    %ecx,%ebx
  801fef:	89 d8                	mov    %ebx,%eax
  801ff1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ff5:	d3 e0                	shl    %cl,%eax
  801ff7:	89 e9                	mov    %ebp,%ecx
  801ff9:	d3 ea                	shr    %cl,%edx
  801ffb:	09 d0                	or     %edx,%eax
  801ffd:	89 e9                	mov    %ebp,%ecx
  801fff:	d3 eb                	shr    %cl,%ebx
  802001:	89 da                	mov    %ebx,%edx
  802003:	83 c4 1c             	add    $0x1c,%esp
  802006:	5b                   	pop    %ebx
  802007:	5e                   	pop    %esi
  802008:	5f                   	pop    %edi
  802009:	5d                   	pop    %ebp
  80200a:	c3                   	ret    
  80200b:	90                   	nop
  80200c:	89 fd                	mov    %edi,%ebp
  80200e:	85 ff                	test   %edi,%edi
  802010:	75 0b                	jne    80201d <__umoddi3+0xe9>
  802012:	b8 01 00 00 00       	mov    $0x1,%eax
  802017:	31 d2                	xor    %edx,%edx
  802019:	f7 f7                	div    %edi
  80201b:	89 c5                	mov    %eax,%ebp
  80201d:	89 f0                	mov    %esi,%eax
  80201f:	31 d2                	xor    %edx,%edx
  802021:	f7 f5                	div    %ebp
  802023:	89 c8                	mov    %ecx,%eax
  802025:	f7 f5                	div    %ebp
  802027:	89 d0                	mov    %edx,%eax
  802029:	e9 44 ff ff ff       	jmp    801f72 <__umoddi3+0x3e>
  80202e:	66 90                	xchg   %ax,%ax
  802030:	89 c8                	mov    %ecx,%eax
  802032:	89 f2                	mov    %esi,%edx
  802034:	83 c4 1c             	add    $0x1c,%esp
  802037:	5b                   	pop    %ebx
  802038:	5e                   	pop    %esi
  802039:	5f                   	pop    %edi
  80203a:	5d                   	pop    %ebp
  80203b:	c3                   	ret    
  80203c:	3b 04 24             	cmp    (%esp),%eax
  80203f:	72 06                	jb     802047 <__umoddi3+0x113>
  802041:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802045:	77 0f                	ja     802056 <__umoddi3+0x122>
  802047:	89 f2                	mov    %esi,%edx
  802049:	29 f9                	sub    %edi,%ecx
  80204b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80204f:	89 14 24             	mov    %edx,(%esp)
  802052:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802056:	8b 44 24 04          	mov    0x4(%esp),%eax
  80205a:	8b 14 24             	mov    (%esp),%edx
  80205d:	83 c4 1c             	add    $0x1c,%esp
  802060:	5b                   	pop    %ebx
  802061:	5e                   	pop    %esi
  802062:	5f                   	pop    %edi
  802063:	5d                   	pop    %ebp
  802064:	c3                   	ret    
  802065:	8d 76 00             	lea    0x0(%esi),%esi
  802068:	2b 04 24             	sub    (%esp),%eax
  80206b:	19 fa                	sbb    %edi,%edx
  80206d:	89 d1                	mov    %edx,%ecx
  80206f:	89 c6                	mov    %eax,%esi
  802071:	e9 71 ff ff ff       	jmp    801fe7 <__umoddi3+0xb3>
  802076:	66 90                	xchg   %ax,%ax
  802078:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80207c:	72 ea                	jb     802068 <__umoddi3+0x134>
  80207e:	89 d9                	mov    %ebx,%ecx
  802080:	e9 62 ff ff ff       	jmp    801fe7 <__umoddi3+0xb3>
