
obj/user/tst_first_fit_1:     file format elf32-i386


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
  800031:	e8 ae 0b 00 00       	call   800be4 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* MAKE SURE PAGE_WS_MAX_SIZE = 1000 */
/* *********************************************************** */
#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	53                   	push   %ebx
  80003d:	83 ec 70             	sub    $0x70,%esp
	sys_set_uheap_strategy(UHP_PLACE_FIRSTFIT);
  800040:	83 ec 0c             	sub    $0xc,%esp
  800043:	6a 01                	push   $0x1
  800045:	e8 85 26 00 00       	call   8026cf <sys_set_uheap_strategy>
  80004a:	83 c4 10             	add    $0x10,%esp

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
  80004d:	c6 45 f7 01          	movb   $0x1,-0x9(%ebp)
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  800051:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800058:	eb 23                	jmp    80007d <_main+0x45>
		{
			if (myEnv->__uptr_pws[i].empty)
  80005a:	a1 20 40 80 00       	mov    0x804020,%eax
  80005f:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800065:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800068:	c1 e2 04             	shl    $0x4,%edx
  80006b:	01 d0                	add    %edx,%eax
  80006d:	8a 40 04             	mov    0x4(%eax),%al
  800070:	84 c0                	test   %al,%al
  800072:	74 06                	je     80007a <_main+0x42>
			{
				fullWS = 0;
  800074:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
				break;
  800078:	eb 12                	jmp    80008c <_main+0x54>
	sys_set_uheap_strategy(UHP_PLACE_FIRSTFIT);

	//Initial test to ensure it works on "PLACEMENT" not "REPLACEMENT"
	{
		uint8 fullWS = 1;
		for (int i = 0; i < myEnv->page_WS_max_size; ++i)
  80007a:	ff 45 f0             	incl   -0x10(%ebp)
  80007d:	a1 20 40 80 00       	mov    0x804020,%eax
  800082:	8b 50 74             	mov    0x74(%eax),%edx
  800085:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800088:	39 c2                	cmp    %eax,%edx
  80008a:	77 ce                	ja     80005a <_main+0x22>
			{
				fullWS = 0;
				break;
			}
		}
		if (fullWS) panic("Please increase the WS size");
  80008c:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800090:	74 14                	je     8000a6 <_main+0x6e>
  800092:	83 ec 04             	sub    $0x4,%esp
  800095:	68 a0 29 80 00       	push   $0x8029a0
  80009a:	6a 15                	push   $0x15
  80009c:	68 bc 29 80 00       	push   $0x8029bc
  8000a1:	e8 83 0c 00 00       	call   800d29 <_panic>
	}

	int Mega = 1024*1024;
  8000a6:	c7 45 ec 00 00 10 00 	movl   $0x100000,-0x14(%ebp)
	int kilo = 1024;
  8000ad:	c7 45 e8 00 04 00 00 	movl   $0x400,-0x18(%ebp)
	void* ptr_allocations[20] = {0};
  8000b4:	8d 55 90             	lea    -0x70(%ebp),%edx
  8000b7:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000bc:	b8 00 00 00 00       	mov    $0x0,%eax
  8000c1:	89 d7                	mov    %edx,%edi
  8000c3:	f3 ab                	rep stos %eax,%es:(%edi)
	int freeFrames ;
	int usedDiskPages;
	//[1] Allocate all
	{
		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8000c5:	e8 71 21 00 00       	call   80223b <sys_calculate_free_frames>
  8000ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8000cd:	e8 ec 21 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  8000d2:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[0] = malloc(1*Mega-kilo);
  8000d5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000d8:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	50                   	push   %eax
  8000df:	e8 71 1c 00 00       	call   801d55 <malloc>
  8000e4:	83 c4 10             	add    $0x10,%esp
  8000e7:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[0] != (USER_HEAP_START)) panic("Wrong start address for the allocated space... ");
  8000ea:	8b 45 90             	mov    -0x70(%ebp),%eax
  8000ed:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8000f2:	74 14                	je     800108 <_main+0xd0>
  8000f4:	83 ec 04             	sub    $0x4,%esp
  8000f7:	68 d4 29 80 00       	push   $0x8029d4
  8000fc:	6a 23                	push   $0x23
  8000fe:	68 bc 29 80 00       	push   $0x8029bc
  800103:	e8 21 0c 00 00       	call   800d29 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256+1 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  800108:	e8 b1 21 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  80010d:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800110:	3d 00 01 00 00       	cmp    $0x100,%eax
  800115:	74 14                	je     80012b <_main+0xf3>
  800117:	83 ec 04             	sub    $0x4,%esp
  80011a:	68 04 2a 80 00       	push   $0x802a04
  80011f:	6a 25                	push   $0x25
  800121:	68 bc 29 80 00       	push   $0x8029bc
  800126:	e8 fe 0b 00 00       	call   800d29 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  80012b:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  80012e:	e8 08 21 00 00       	call   80223b <sys_calculate_free_frames>
  800133:	29 c3                	sub    %eax,%ebx
  800135:	89 d8                	mov    %ebx,%eax
  800137:	83 f8 01             	cmp    $0x1,%eax
  80013a:	74 14                	je     800150 <_main+0x118>
  80013c:	83 ec 04             	sub    $0x4,%esp
  80013f:	68 21 2a 80 00       	push   $0x802a21
  800144:	6a 26                	push   $0x26
  800146:	68 bc 29 80 00       	push   $0x8029bc
  80014b:	e8 d9 0b 00 00       	call   800d29 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800150:	e8 e6 20 00 00       	call   80223b <sys_calculate_free_frames>
  800155:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800158:	e8 61 21 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  80015d:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[1] = malloc(1*Mega-kilo);
  800160:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800163:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800166:	83 ec 0c             	sub    $0xc,%esp
  800169:	50                   	push   %eax
  80016a:	e8 e6 1b 00 00       	call   801d55 <malloc>
  80016f:	83 c4 10             	add    $0x10,%esp
  800172:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[1] != (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  800175:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800178:	89 c2                	mov    %eax,%edx
  80017a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80017d:	05 00 00 00 80       	add    $0x80000000,%eax
  800182:	39 c2                	cmp    %eax,%edx
  800184:	74 14                	je     80019a <_main+0x162>
  800186:	83 ec 04             	sub    $0x4,%esp
  800189:	68 d4 29 80 00       	push   $0x8029d4
  80018e:	6a 2c                	push   $0x2c
  800190:	68 bc 29 80 00       	push   $0x8029bc
  800195:	e8 8f 0b 00 00       	call   800d29 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  80019a:	e8 1f 21 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  80019f:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8001a2:	3d 00 01 00 00       	cmp    $0x100,%eax
  8001a7:	74 14                	je     8001bd <_main+0x185>
  8001a9:	83 ec 04             	sub    $0x4,%esp
  8001ac:	68 04 2a 80 00       	push   $0x802a04
  8001b1:	6a 2e                	push   $0x2e
  8001b3:	68 bc 29 80 00       	push   $0x8029bc
  8001b8:	e8 6c 0b 00 00       	call   800d29 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  8001bd:	e8 79 20 00 00       	call   80223b <sys_calculate_free_frames>
  8001c2:	89 c2                	mov    %eax,%edx
  8001c4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001c7:	39 c2                	cmp    %eax,%edx
  8001c9:	74 14                	je     8001df <_main+0x1a7>
  8001cb:	83 ec 04             	sub    $0x4,%esp
  8001ce:	68 21 2a 80 00       	push   $0x802a21
  8001d3:	6a 2f                	push   $0x2f
  8001d5:	68 bc 29 80 00       	push   $0x8029bc
  8001da:	e8 4a 0b 00 00       	call   800d29 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8001df:	e8 57 20 00 00       	call   80223b <sys_calculate_free_frames>
  8001e4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8001e7:	e8 d2 20 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  8001ec:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[2] = malloc(1*Mega-kilo);
  8001ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001f2:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8001f5:	83 ec 0c             	sub    $0xc,%esp
  8001f8:	50                   	push   %eax
  8001f9:	e8 57 1b 00 00       	call   801d55 <malloc>
  8001fe:	83 c4 10             	add    $0x10,%esp
  800201:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[2] != (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the allocated space... ");
  800204:	8b 45 98             	mov    -0x68(%ebp),%eax
  800207:	89 c2                	mov    %eax,%edx
  800209:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80020c:	01 c0                	add    %eax,%eax
  80020e:	05 00 00 00 80       	add    $0x80000000,%eax
  800213:	39 c2                	cmp    %eax,%edx
  800215:	74 14                	je     80022b <_main+0x1f3>
  800217:	83 ec 04             	sub    $0x4,%esp
  80021a:	68 d4 29 80 00       	push   $0x8029d4
  80021f:	6a 35                	push   $0x35
  800221:	68 bc 29 80 00       	push   $0x8029bc
  800226:	e8 fe 0a 00 00       	call   800d29 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  80022b:	e8 8e 20 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  800230:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800233:	3d 00 01 00 00       	cmp    $0x100,%eax
  800238:	74 14                	je     80024e <_main+0x216>
  80023a:	83 ec 04             	sub    $0x4,%esp
  80023d:	68 04 2a 80 00       	push   $0x802a04
  800242:	6a 37                	push   $0x37
  800244:	68 bc 29 80 00       	push   $0x8029bc
  800249:	e8 db 0a 00 00       	call   800d29 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  80024e:	e8 e8 1f 00 00       	call   80223b <sys_calculate_free_frames>
  800253:	89 c2                	mov    %eax,%edx
  800255:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800258:	39 c2                	cmp    %eax,%edx
  80025a:	74 14                	je     800270 <_main+0x238>
  80025c:	83 ec 04             	sub    $0x4,%esp
  80025f:	68 21 2a 80 00       	push   $0x802a21
  800264:	6a 38                	push   $0x38
  800266:	68 bc 29 80 00       	push   $0x8029bc
  80026b:	e8 b9 0a 00 00       	call   800d29 <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800270:	e8 c6 1f 00 00       	call   80223b <sys_calculate_free_frames>
  800275:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800278:	e8 41 20 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  80027d:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[3] = malloc(1*Mega-kilo);
  800280:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800283:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800286:	83 ec 0c             	sub    $0xc,%esp
  800289:	50                   	push   %eax
  80028a:	e8 c6 1a 00 00       	call   801d55 <malloc>
  80028f:	83 c4 10             	add    $0x10,%esp
  800292:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[3] != (USER_HEAP_START + 3*Mega) ) panic("Wrong start address for the allocated space... ");
  800295:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800298:	89 c1                	mov    %eax,%ecx
  80029a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80029d:	89 c2                	mov    %eax,%edx
  80029f:	01 d2                	add    %edx,%edx
  8002a1:	01 d0                	add    %edx,%eax
  8002a3:	05 00 00 00 80       	add    $0x80000000,%eax
  8002a8:	39 c1                	cmp    %eax,%ecx
  8002aa:	74 14                	je     8002c0 <_main+0x288>
  8002ac:	83 ec 04             	sub    $0x4,%esp
  8002af:	68 d4 29 80 00       	push   $0x8029d4
  8002b4:	6a 3e                	push   $0x3e
  8002b6:	68 bc 29 80 00       	push   $0x8029bc
  8002bb:	e8 69 0a 00 00       	call   800d29 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8002c0:	e8 f9 1f 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  8002c5:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8002c8:	3d 00 01 00 00       	cmp    $0x100,%eax
  8002cd:	74 14                	je     8002e3 <_main+0x2ab>
  8002cf:	83 ec 04             	sub    $0x4,%esp
  8002d2:	68 04 2a 80 00       	push   $0x802a04
  8002d7:	6a 40                	push   $0x40
  8002d9:	68 bc 29 80 00       	push   $0x8029bc
  8002de:	e8 46 0a 00 00       	call   800d29 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  8002e3:	e8 53 1f 00 00       	call   80223b <sys_calculate_free_frames>
  8002e8:	89 c2                	mov    %eax,%edx
  8002ea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002ed:	39 c2                	cmp    %eax,%edx
  8002ef:	74 14                	je     800305 <_main+0x2cd>
  8002f1:	83 ec 04             	sub    $0x4,%esp
  8002f4:	68 21 2a 80 00       	push   $0x802a21
  8002f9:	6a 41                	push   $0x41
  8002fb:	68 bc 29 80 00       	push   $0x8029bc
  800300:	e8 24 0a 00 00       	call   800d29 <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800305:	e8 31 1f 00 00       	call   80223b <sys_calculate_free_frames>
  80030a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80030d:	e8 ac 1f 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  800312:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[4] = malloc(2*Mega-kilo);
  800315:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800318:	01 c0                	add    %eax,%eax
  80031a:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80031d:	83 ec 0c             	sub    $0xc,%esp
  800320:	50                   	push   %eax
  800321:	e8 2f 1a 00 00       	call   801d55 <malloc>
  800326:	83 c4 10             	add    $0x10,%esp
  800329:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if ((uint32) ptr_allocations[4] != (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  80032c:	8b 45 a0             	mov    -0x60(%ebp),%eax
  80032f:	89 c2                	mov    %eax,%edx
  800331:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800334:	c1 e0 02             	shl    $0x2,%eax
  800337:	05 00 00 00 80       	add    $0x80000000,%eax
  80033c:	39 c2                	cmp    %eax,%edx
  80033e:	74 14                	je     800354 <_main+0x31c>
  800340:	83 ec 04             	sub    $0x4,%esp
  800343:	68 d4 29 80 00       	push   $0x8029d4
  800348:	6a 47                	push   $0x47
  80034a:	68 bc 29 80 00       	push   $0x8029bc
  80034f:	e8 d5 09 00 00       	call   800d29 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  800354:	e8 65 1f 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  800359:	2b 45 e0             	sub    -0x20(%ebp),%eax
  80035c:	3d 00 02 00 00       	cmp    $0x200,%eax
  800361:	74 14                	je     800377 <_main+0x33f>
  800363:	83 ec 04             	sub    $0x4,%esp
  800366:	68 04 2a 80 00       	push   $0x802a04
  80036b:	6a 49                	push   $0x49
  80036d:	68 bc 29 80 00       	push   $0x8029bc
  800372:	e8 b2 09 00 00       	call   800d29 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  800377:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  80037a:	e8 bc 1e 00 00       	call   80223b <sys_calculate_free_frames>
  80037f:	29 c3                	sub    %eax,%ebx
  800381:	89 d8                	mov    %ebx,%eax
  800383:	83 f8 01             	cmp    $0x1,%eax
  800386:	74 14                	je     80039c <_main+0x364>
  800388:	83 ec 04             	sub    $0x4,%esp
  80038b:	68 21 2a 80 00       	push   $0x802a21
  800390:	6a 4a                	push   $0x4a
  800392:	68 bc 29 80 00       	push   $0x8029bc
  800397:	e8 8d 09 00 00       	call   800d29 <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  80039c:	e8 9a 1e 00 00       	call   80223b <sys_calculate_free_frames>
  8003a1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8003a4:	e8 15 1f 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  8003a9:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[5] = malloc(2*Mega-kilo);
  8003ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8003af:	01 c0                	add    %eax,%eax
  8003b1:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8003b4:	83 ec 0c             	sub    $0xc,%esp
  8003b7:	50                   	push   %eax
  8003b8:	e8 98 19 00 00       	call   801d55 <malloc>
  8003bd:	83 c4 10             	add    $0x10,%esp
  8003c0:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[5] != (USER_HEAP_START + 6*Mega)) panic("Wrong start address for the allocated space... ");
  8003c3:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003c6:	89 c1                	mov    %eax,%ecx
  8003c8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8003cb:	89 d0                	mov    %edx,%eax
  8003cd:	01 c0                	add    %eax,%eax
  8003cf:	01 d0                	add    %edx,%eax
  8003d1:	01 c0                	add    %eax,%eax
  8003d3:	05 00 00 00 80       	add    $0x80000000,%eax
  8003d8:	39 c1                	cmp    %eax,%ecx
  8003da:	74 14                	je     8003f0 <_main+0x3b8>
  8003dc:	83 ec 04             	sub    $0x4,%esp
  8003df:	68 d4 29 80 00       	push   $0x8029d4
  8003e4:	6a 50                	push   $0x50
  8003e6:	68 bc 29 80 00       	push   $0x8029bc
  8003eb:	e8 39 09 00 00       	call   800d29 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  8003f0:	e8 c9 1e 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  8003f5:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8003f8:	3d 00 02 00 00       	cmp    $0x200,%eax
  8003fd:	74 14                	je     800413 <_main+0x3db>
  8003ff:	83 ec 04             	sub    $0x4,%esp
  800402:	68 04 2a 80 00       	push   $0x802a04
  800407:	6a 52                	push   $0x52
  800409:	68 bc 29 80 00       	push   $0x8029bc
  80040e:	e8 16 09 00 00       	call   800d29 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800413:	e8 23 1e 00 00       	call   80223b <sys_calculate_free_frames>
  800418:	89 c2                	mov    %eax,%edx
  80041a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80041d:	39 c2                	cmp    %eax,%edx
  80041f:	74 14                	je     800435 <_main+0x3fd>
  800421:	83 ec 04             	sub    $0x4,%esp
  800424:	68 21 2a 80 00       	push   $0x802a21
  800429:	6a 53                	push   $0x53
  80042b:	68 bc 29 80 00       	push   $0x8029bc
  800430:	e8 f4 08 00 00       	call   800d29 <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  800435:	e8 01 1e 00 00       	call   80223b <sys_calculate_free_frames>
  80043a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80043d:	e8 7c 1e 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  800442:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[6] = malloc(3*Mega-kilo);
  800445:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800448:	89 c2                	mov    %eax,%edx
  80044a:	01 d2                	add    %edx,%edx
  80044c:	01 d0                	add    %edx,%eax
  80044e:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800451:	83 ec 0c             	sub    $0xc,%esp
  800454:	50                   	push   %eax
  800455:	e8 fb 18 00 00       	call   801d55 <malloc>
  80045a:	83 c4 10             	add    $0x10,%esp
  80045d:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if ((uint32) ptr_allocations[6] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  800460:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800463:	89 c2                	mov    %eax,%edx
  800465:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800468:	c1 e0 03             	shl    $0x3,%eax
  80046b:	05 00 00 00 80       	add    $0x80000000,%eax
  800470:	39 c2                	cmp    %eax,%edx
  800472:	74 14                	je     800488 <_main+0x450>
  800474:	83 ec 04             	sub    $0x4,%esp
  800477:	68 d4 29 80 00       	push   $0x8029d4
  80047c:	6a 59                	push   $0x59
  80047e:	68 bc 29 80 00       	push   $0x8029bc
  800483:	e8 a1 08 00 00       	call   800d29 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  768) panic("Wrong page file allocation: ");
  800488:	e8 31 1e 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  80048d:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800490:	3d 00 03 00 00       	cmp    $0x300,%eax
  800495:	74 14                	je     8004ab <_main+0x473>
  800497:	83 ec 04             	sub    $0x4,%esp
  80049a:	68 04 2a 80 00       	push   $0x802a04
  80049f:	6a 5b                	push   $0x5b
  8004a1:	68 bc 29 80 00       	push   $0x8029bc
  8004a6:	e8 7e 08 00 00       	call   800d29 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  8004ab:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8004ae:	e8 88 1d 00 00       	call   80223b <sys_calculate_free_frames>
  8004b3:	29 c3                	sub    %eax,%ebx
  8004b5:	89 d8                	mov    %ebx,%eax
  8004b7:	83 f8 01             	cmp    $0x1,%eax
  8004ba:	74 14                	je     8004d0 <_main+0x498>
  8004bc:	83 ec 04             	sub    $0x4,%esp
  8004bf:	68 21 2a 80 00       	push   $0x802a21
  8004c4:	6a 5c                	push   $0x5c
  8004c6:	68 bc 29 80 00       	push   $0x8029bc
  8004cb:	e8 59 08 00 00       	call   800d29 <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8004d0:	e8 66 1d 00 00       	call   80223b <sys_calculate_free_frames>
  8004d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8004d8:	e8 e1 1d 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  8004dd:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[7] = malloc(3*Mega-kilo);
  8004e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8004e3:	89 c2                	mov    %eax,%edx
  8004e5:	01 d2                	add    %edx,%edx
  8004e7:	01 d0                	add    %edx,%eax
  8004e9:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8004ec:	83 ec 0c             	sub    $0xc,%esp
  8004ef:	50                   	push   %eax
  8004f0:	e8 60 18 00 00       	call   801d55 <malloc>
  8004f5:	83 c4 10             	add    $0x10,%esp
  8004f8:	89 45 ac             	mov    %eax,-0x54(%ebp)
		if ((uint32) ptr_allocations[7] != (USER_HEAP_START + 11*Mega)) panic("Wrong start address for the allocated space... ");
  8004fb:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8004fe:	89 c1                	mov    %eax,%ecx
  800500:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800503:	89 d0                	mov    %edx,%eax
  800505:	c1 e0 02             	shl    $0x2,%eax
  800508:	01 d0                	add    %edx,%eax
  80050a:	01 c0                	add    %eax,%eax
  80050c:	01 d0                	add    %edx,%eax
  80050e:	05 00 00 00 80       	add    $0x80000000,%eax
  800513:	39 c1                	cmp    %eax,%ecx
  800515:	74 14                	je     80052b <_main+0x4f3>
  800517:	83 ec 04             	sub    $0x4,%esp
  80051a:	68 d4 29 80 00       	push   $0x8029d4
  80051f:	6a 62                	push   $0x62
  800521:	68 bc 29 80 00       	push   $0x8029bc
  800526:	e8 fe 07 00 00       	call   800d29 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  768) panic("Wrong page file allocation: ");
  80052b:	e8 8e 1d 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  800530:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800533:	3d 00 03 00 00       	cmp    $0x300,%eax
  800538:	74 14                	je     80054e <_main+0x516>
  80053a:	83 ec 04             	sub    $0x4,%esp
  80053d:	68 04 2a 80 00       	push   $0x802a04
  800542:	6a 64                	push   $0x64
  800544:	68 bc 29 80 00       	push   $0x8029bc
  800549:	e8 db 07 00 00       	call   800d29 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  80054e:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  800551:	e8 e5 1c 00 00       	call   80223b <sys_calculate_free_frames>
  800556:	29 c3                	sub    %eax,%ebx
  800558:	89 d8                	mov    %ebx,%eax
  80055a:	83 f8 01             	cmp    $0x1,%eax
  80055d:	74 14                	je     800573 <_main+0x53b>
  80055f:	83 ec 04             	sub    $0x4,%esp
  800562:	68 21 2a 80 00       	push   $0x802a21
  800567:	6a 65                	push   $0x65
  800569:	68 bc 29 80 00       	push   $0x8029bc
  80056e:	e8 b6 07 00 00       	call   800d29 <_panic>
	}

	//[2] Free some to create holes
	{
		//1 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800573:	e8 c3 1c 00 00       	call   80223b <sys_calculate_free_frames>
  800578:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80057b:	e8 3e 1d 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  800580:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[1]);
  800583:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800586:	83 ec 0c             	sub    $0xc,%esp
  800589:	50                   	push   %eax
  80058a:	e8 d6 19 00 00       	call   801f65 <free>
  80058f:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800592:	e8 27 1d 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  800597:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80059a:	29 c2                	sub    %eax,%edx
  80059c:	89 d0                	mov    %edx,%eax
  80059e:	3d 00 01 00 00       	cmp    $0x100,%eax
  8005a3:	74 14                	je     8005b9 <_main+0x581>
  8005a5:	83 ec 04             	sub    $0x4,%esp
  8005a8:	68 34 2a 80 00       	push   $0x802a34
  8005ad:	6a 6f                	push   $0x6f
  8005af:	68 bc 29 80 00       	push   $0x8029bc
  8005b4:	e8 70 07 00 00       	call   800d29 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  8005b9:	e8 7d 1c 00 00       	call   80223b <sys_calculate_free_frames>
  8005be:	89 c2                	mov    %eax,%edx
  8005c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8005c3:	39 c2                	cmp    %eax,%edx
  8005c5:	74 14                	je     8005db <_main+0x5a3>
  8005c7:	83 ec 04             	sub    $0x4,%esp
  8005ca:	68 4b 2a 80 00       	push   $0x802a4b
  8005cf:	6a 70                	push   $0x70
  8005d1:	68 bc 29 80 00       	push   $0x8029bc
  8005d6:	e8 4e 07 00 00       	call   800d29 <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005db:	e8 5b 1c 00 00       	call   80223b <sys_calculate_free_frames>
  8005e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8005e3:	e8 d6 1c 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  8005e8:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[4]);
  8005eb:	8b 45 a0             	mov    -0x60(%ebp),%eax
  8005ee:	83 ec 0c             	sub    $0xc,%esp
  8005f1:	50                   	push   %eax
  8005f2:	e8 6e 19 00 00       	call   801f65 <free>
  8005f7:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  512) panic("Wrong page file free: ");
  8005fa:	e8 bf 1c 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  8005ff:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800602:	29 c2                	sub    %eax,%edx
  800604:	89 d0                	mov    %edx,%eax
  800606:	3d 00 02 00 00       	cmp    $0x200,%eax
  80060b:	74 14                	je     800621 <_main+0x5e9>
  80060d:	83 ec 04             	sub    $0x4,%esp
  800610:	68 34 2a 80 00       	push   $0x802a34
  800615:	6a 77                	push   $0x77
  800617:	68 bc 29 80 00       	push   $0x8029bc
  80061c:	e8 08 07 00 00       	call   800d29 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800621:	e8 15 1c 00 00       	call   80223b <sys_calculate_free_frames>
  800626:	89 c2                	mov    %eax,%edx
  800628:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80062b:	39 c2                	cmp    %eax,%edx
  80062d:	74 14                	je     800643 <_main+0x60b>
  80062f:	83 ec 04             	sub    $0x4,%esp
  800632:	68 4b 2a 80 00       	push   $0x802a4b
  800637:	6a 78                	push   $0x78
  800639:	68 bc 29 80 00       	push   $0x8029bc
  80063e:	e8 e6 06 00 00       	call   800d29 <_panic>

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800643:	e8 f3 1b 00 00       	call   80223b <sys_calculate_free_frames>
  800648:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80064b:	e8 6e 1c 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  800650:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[6]);
  800653:	8b 45 a8             	mov    -0x58(%ebp),%eax
  800656:	83 ec 0c             	sub    $0xc,%esp
  800659:	50                   	push   %eax
  80065a:	e8 06 19 00 00       	call   801f65 <free>
  80065f:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  768) panic("Wrong page file free: ");
  800662:	e8 57 1c 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  800667:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80066a:	29 c2                	sub    %eax,%edx
  80066c:	89 d0                	mov    %edx,%eax
  80066e:	3d 00 03 00 00       	cmp    $0x300,%eax
  800673:	74 14                	je     800689 <_main+0x651>
  800675:	83 ec 04             	sub    $0x4,%esp
  800678:	68 34 2a 80 00       	push   $0x802a34
  80067d:	6a 7f                	push   $0x7f
  80067f:	68 bc 29 80 00       	push   $0x8029bc
  800684:	e8 a0 06 00 00       	call   800d29 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800689:	e8 ad 1b 00 00       	call   80223b <sys_calculate_free_frames>
  80068e:	89 c2                	mov    %eax,%edx
  800690:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800693:	39 c2                	cmp    %eax,%edx
  800695:	74 17                	je     8006ae <_main+0x676>
  800697:	83 ec 04             	sub    $0x4,%esp
  80069a:	68 4b 2a 80 00       	push   $0x802a4b
  80069f:	68 80 00 00 00       	push   $0x80
  8006a4:	68 bc 29 80 00       	push   $0x8029bc
  8006a9:	e8 7b 06 00 00       	call   800d29 <_panic>
	}

	//[3] Allocate again [test first fit]
	{
		//Allocate 512 KB - should be placed in 1st hole
		freeFrames = sys_calculate_free_frames() ;
  8006ae:	e8 88 1b 00 00       	call   80223b <sys_calculate_free_frames>
  8006b3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8006b6:	e8 03 1c 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  8006bb:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[8] = malloc(512*kilo - kilo);
  8006be:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8006c1:	89 d0                	mov    %edx,%eax
  8006c3:	c1 e0 09             	shl    $0x9,%eax
  8006c6:	29 d0                	sub    %edx,%eax
  8006c8:	83 ec 0c             	sub    $0xc,%esp
  8006cb:	50                   	push   %eax
  8006cc:	e8 84 16 00 00       	call   801d55 <malloc>
  8006d1:	83 c4 10             	add    $0x10,%esp
  8006d4:	89 45 b0             	mov    %eax,-0x50(%ebp)
		if ((uint32) ptr_allocations[8] != (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  8006d7:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8006da:	89 c2                	mov    %eax,%edx
  8006dc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8006df:	05 00 00 00 80       	add    $0x80000000,%eax
  8006e4:	39 c2                	cmp    %eax,%edx
  8006e6:	74 17                	je     8006ff <_main+0x6c7>
  8006e8:	83 ec 04             	sub    $0x4,%esp
  8006eb:	68 d4 29 80 00       	push   $0x8029d4
  8006f0:	68 89 00 00 00       	push   $0x89
  8006f5:	68 bc 29 80 00       	push   $0x8029bc
  8006fa:	e8 2a 06 00 00       	call   800d29 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 128) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  128) panic("Wrong page file allocation: ");
  8006ff:	e8 ba 1b 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  800704:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800707:	3d 80 00 00 00       	cmp    $0x80,%eax
  80070c:	74 17                	je     800725 <_main+0x6ed>
  80070e:	83 ec 04             	sub    $0x4,%esp
  800711:	68 04 2a 80 00       	push   $0x802a04
  800716:	68 8b 00 00 00       	push   $0x8b
  80071b:	68 bc 29 80 00       	push   $0x8029bc
  800720:	e8 04 06 00 00       	call   800d29 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800725:	e8 11 1b 00 00       	call   80223b <sys_calculate_free_frames>
  80072a:	89 c2                	mov    %eax,%edx
  80072c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80072f:	39 c2                	cmp    %eax,%edx
  800731:	74 17                	je     80074a <_main+0x712>
  800733:	83 ec 04             	sub    $0x4,%esp
  800736:	68 21 2a 80 00       	push   $0x802a21
  80073b:	68 8c 00 00 00       	push   $0x8c
  800740:	68 bc 29 80 00       	push   $0x8029bc
  800745:	e8 df 05 00 00       	call   800d29 <_panic>

		//Allocate 1 MB - should be placed in 2nd hole
		freeFrames = sys_calculate_free_frames() ;
  80074a:	e8 ec 1a 00 00       	call   80223b <sys_calculate_free_frames>
  80074f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800752:	e8 67 1b 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  800757:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[9] = malloc(1*Mega - kilo);
  80075a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80075d:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800760:	83 ec 0c             	sub    $0xc,%esp
  800763:	50                   	push   %eax
  800764:	e8 ec 15 00 00       	call   801d55 <malloc>
  800769:	83 c4 10             	add    $0x10,%esp
  80076c:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  80076f:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800772:	89 c2                	mov    %eax,%edx
  800774:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800777:	c1 e0 02             	shl    $0x2,%eax
  80077a:	05 00 00 00 80       	add    $0x80000000,%eax
  80077f:	39 c2                	cmp    %eax,%edx
  800781:	74 17                	je     80079a <_main+0x762>
  800783:	83 ec 04             	sub    $0x4,%esp
  800786:	68 d4 29 80 00       	push   $0x8029d4
  80078b:	68 92 00 00 00       	push   $0x92
  800790:	68 bc 29 80 00       	push   $0x8029bc
  800795:	e8 8f 05 00 00       	call   800d29 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  80079a:	e8 1f 1b 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  80079f:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8007a2:	3d 00 01 00 00       	cmp    $0x100,%eax
  8007a7:	74 17                	je     8007c0 <_main+0x788>
  8007a9:	83 ec 04             	sub    $0x4,%esp
  8007ac:	68 04 2a 80 00       	push   $0x802a04
  8007b1:	68 94 00 00 00       	push   $0x94
  8007b6:	68 bc 29 80 00       	push   $0x8029bc
  8007bb:	e8 69 05 00 00       	call   800d29 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  8007c0:	e8 76 1a 00 00       	call   80223b <sys_calculate_free_frames>
  8007c5:	89 c2                	mov    %eax,%edx
  8007c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8007ca:	39 c2                	cmp    %eax,%edx
  8007cc:	74 17                	je     8007e5 <_main+0x7ad>
  8007ce:	83 ec 04             	sub    $0x4,%esp
  8007d1:	68 21 2a 80 00       	push   $0x802a21
  8007d6:	68 95 00 00 00       	push   $0x95
  8007db:	68 bc 29 80 00       	push   $0x8029bc
  8007e0:	e8 44 05 00 00       	call   800d29 <_panic>

		//Allocate 256 KB - should be placed in remaining of 1st hole
		freeFrames = sys_calculate_free_frames() ;
  8007e5:	e8 51 1a 00 00       	call   80223b <sys_calculate_free_frames>
  8007ea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8007ed:	e8 cc 1a 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  8007f2:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[10] = malloc(256*kilo - kilo);
  8007f5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007f8:	89 d0                	mov    %edx,%eax
  8007fa:	c1 e0 08             	shl    $0x8,%eax
  8007fd:	29 d0                	sub    %edx,%eax
  8007ff:	83 ec 0c             	sub    $0xc,%esp
  800802:	50                   	push   %eax
  800803:	e8 4d 15 00 00       	call   801d55 <malloc>
  800808:	83 c4 10             	add    $0x10,%esp
  80080b:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if ((uint32) ptr_allocations[10] != (USER_HEAP_START + 1*Mega + 512*kilo)) panic("Wrong start address for the allocated space... ");
  80080e:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800811:	89 c2                	mov    %eax,%edx
  800813:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800816:	c1 e0 09             	shl    $0x9,%eax
  800819:	89 c1                	mov    %eax,%ecx
  80081b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80081e:	01 c8                	add    %ecx,%eax
  800820:	05 00 00 00 80       	add    $0x80000000,%eax
  800825:	39 c2                	cmp    %eax,%edx
  800827:	74 17                	je     800840 <_main+0x808>
  800829:	83 ec 04             	sub    $0x4,%esp
  80082c:	68 d4 29 80 00       	push   $0x8029d4
  800831:	68 9b 00 00 00       	push   $0x9b
  800836:	68 bc 29 80 00       	push   $0x8029bc
  80083b:	e8 e9 04 00 00       	call   800d29 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 64) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  64) panic("Wrong page file allocation: ");
  800840:	e8 79 1a 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  800845:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800848:	83 f8 40             	cmp    $0x40,%eax
  80084b:	74 17                	je     800864 <_main+0x82c>
  80084d:	83 ec 04             	sub    $0x4,%esp
  800850:	68 04 2a 80 00       	push   $0x802a04
  800855:	68 9d 00 00 00       	push   $0x9d
  80085a:	68 bc 29 80 00       	push   $0x8029bc
  80085f:	e8 c5 04 00 00       	call   800d29 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800864:	e8 d2 19 00 00       	call   80223b <sys_calculate_free_frames>
  800869:	89 c2                	mov    %eax,%edx
  80086b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80086e:	39 c2                	cmp    %eax,%edx
  800870:	74 17                	je     800889 <_main+0x851>
  800872:	83 ec 04             	sub    $0x4,%esp
  800875:	68 21 2a 80 00       	push   $0x802a21
  80087a:	68 9e 00 00 00       	push   $0x9e
  80087f:	68 bc 29 80 00       	push   $0x8029bc
  800884:	e8 a0 04 00 00       	call   800d29 <_panic>

		//Allocate 2 MB - should be placed in 3rd hole
		freeFrames = sys_calculate_free_frames() ;
  800889:	e8 ad 19 00 00       	call   80223b <sys_calculate_free_frames>
  80088e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800891:	e8 28 1a 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  800896:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[11] = malloc(2*Mega);
  800899:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80089c:	01 c0                	add    %eax,%eax
  80089e:	83 ec 0c             	sub    $0xc,%esp
  8008a1:	50                   	push   %eax
  8008a2:	e8 ae 14 00 00       	call   801d55 <malloc>
  8008a7:	83 c4 10             	add    $0x10,%esp
  8008aa:	89 45 bc             	mov    %eax,-0x44(%ebp)
		if ((uint32) ptr_allocations[11] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  8008ad:	8b 45 bc             	mov    -0x44(%ebp),%eax
  8008b0:	89 c2                	mov    %eax,%edx
  8008b2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008b5:	c1 e0 03             	shl    $0x3,%eax
  8008b8:	05 00 00 00 80       	add    $0x80000000,%eax
  8008bd:	39 c2                	cmp    %eax,%edx
  8008bf:	74 17                	je     8008d8 <_main+0x8a0>
  8008c1:	83 ec 04             	sub    $0x4,%esp
  8008c4:	68 d4 29 80 00       	push   $0x8029d4
  8008c9:	68 a4 00 00 00       	push   $0xa4
  8008ce:	68 bc 29 80 00       	push   $0x8029bc
  8008d3:	e8 51 04 00 00       	call   800d29 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  8008d8:	e8 e1 19 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  8008dd:	2b 45 e0             	sub    -0x20(%ebp),%eax
  8008e0:	3d 00 02 00 00       	cmp    $0x200,%eax
  8008e5:	74 17                	je     8008fe <_main+0x8c6>
  8008e7:	83 ec 04             	sub    $0x4,%esp
  8008ea:	68 04 2a 80 00       	push   $0x802a04
  8008ef:	68 a6 00 00 00       	push   $0xa6
  8008f4:	68 bc 29 80 00       	push   $0x8029bc
  8008f9:	e8 2b 04 00 00       	call   800d29 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  8008fe:	e8 38 19 00 00       	call   80223b <sys_calculate_free_frames>
  800903:	89 c2                	mov    %eax,%edx
  800905:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800908:	39 c2                	cmp    %eax,%edx
  80090a:	74 17                	je     800923 <_main+0x8eb>
  80090c:	83 ec 04             	sub    $0x4,%esp
  80090f:	68 21 2a 80 00       	push   $0x802a21
  800914:	68 a7 00 00 00       	push   $0xa7
  800919:	68 bc 29 80 00       	push   $0x8029bc
  80091e:	e8 06 04 00 00       	call   800d29 <_panic>

		//Allocate 4 MB - should be placed in end of all allocations
		freeFrames = sys_calculate_free_frames() ;
  800923:	e8 13 19 00 00       	call   80223b <sys_calculate_free_frames>
  800928:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80092b:	e8 8e 19 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  800930:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[12] = malloc(4*Mega - kilo);
  800933:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800936:	c1 e0 02             	shl    $0x2,%eax
  800939:	2b 45 e8             	sub    -0x18(%ebp),%eax
  80093c:	83 ec 0c             	sub    $0xc,%esp
  80093f:	50                   	push   %eax
  800940:	e8 10 14 00 00       	call   801d55 <malloc>
  800945:	83 c4 10             	add    $0x10,%esp
  800948:	89 45 c0             	mov    %eax,-0x40(%ebp)
		if ((uint32) ptr_allocations[12] != (USER_HEAP_START + 14*Mega) ) panic("Wrong start address for the allocated space... ");
  80094b:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80094e:	89 c1                	mov    %eax,%ecx
  800950:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800953:	89 d0                	mov    %edx,%eax
  800955:	01 c0                	add    %eax,%eax
  800957:	01 d0                	add    %edx,%eax
  800959:	01 c0                	add    %eax,%eax
  80095b:	01 d0                	add    %edx,%eax
  80095d:	01 c0                	add    %eax,%eax
  80095f:	05 00 00 00 80       	add    $0x80000000,%eax
  800964:	39 c1                	cmp    %eax,%ecx
  800966:	74 17                	je     80097f <_main+0x947>
  800968:	83 ec 04             	sub    $0x4,%esp
  80096b:	68 d4 29 80 00       	push   $0x8029d4
  800970:	68 ad 00 00 00       	push   $0xad
  800975:	68 bc 29 80 00       	push   $0x8029bc
  80097a:	e8 aa 03 00 00       	call   800d29 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1024 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1024) panic("Wrong page file allocation: ");
  80097f:	e8 3a 19 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  800984:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800987:	3d 00 04 00 00       	cmp    $0x400,%eax
  80098c:	74 17                	je     8009a5 <_main+0x96d>
  80098e:	83 ec 04             	sub    $0x4,%esp
  800991:	68 04 2a 80 00       	push   $0x802a04
  800996:	68 af 00 00 00       	push   $0xaf
  80099b:	68 bc 29 80 00       	push   $0x8029bc
  8009a0:	e8 84 03 00 00       	call   800d29 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  8009a5:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  8009a8:	e8 8e 18 00 00       	call   80223b <sys_calculate_free_frames>
  8009ad:	29 c3                	sub    %eax,%ebx
  8009af:	89 d8                	mov    %ebx,%eax
  8009b1:	83 f8 01             	cmp    $0x1,%eax
  8009b4:	74 17                	je     8009cd <_main+0x995>
  8009b6:	83 ec 04             	sub    $0x4,%esp
  8009b9:	68 21 2a 80 00       	push   $0x802a21
  8009be:	68 b0 00 00 00       	push   $0xb0
  8009c3:	68 bc 29 80 00       	push   $0x8029bc
  8009c8:	e8 5c 03 00 00       	call   800d29 <_panic>
	}

	//[4] Free contiguous allocations
	{
		//1 MB Hole appended to previous 256 KB hole
		freeFrames = sys_calculate_free_frames() ;
  8009cd:	e8 69 18 00 00       	call   80223b <sys_calculate_free_frames>
  8009d2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8009d5:	e8 e4 18 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  8009da:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[2]);
  8009dd:	8b 45 98             	mov    -0x68(%ebp),%eax
  8009e0:	83 ec 0c             	sub    $0xc,%esp
  8009e3:	50                   	push   %eax
  8009e4:	e8 7c 15 00 00       	call   801f65 <free>
  8009e9:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  8009ec:	e8 cd 18 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  8009f1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009f4:	29 c2                	sub    %eax,%edx
  8009f6:	89 d0                	mov    %edx,%eax
  8009f8:	3d 00 01 00 00       	cmp    $0x100,%eax
  8009fd:	74 17                	je     800a16 <_main+0x9de>
  8009ff:	83 ec 04             	sub    $0x4,%esp
  800a02:	68 34 2a 80 00       	push   $0x802a34
  800a07:	68 ba 00 00 00       	push   $0xba
  800a0c:	68 bc 29 80 00       	push   $0x8029bc
  800a11:	e8 13 03 00 00       	call   800d29 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800a16:	e8 20 18 00 00       	call   80223b <sys_calculate_free_frames>
  800a1b:	89 c2                	mov    %eax,%edx
  800a1d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800a20:	39 c2                	cmp    %eax,%edx
  800a22:	74 17                	je     800a3b <_main+0xa03>
  800a24:	83 ec 04             	sub    $0x4,%esp
  800a27:	68 4b 2a 80 00       	push   $0x802a4b
  800a2c:	68 bb 00 00 00       	push   $0xbb
  800a31:	68 bc 29 80 00       	push   $0x8029bc
  800a36:	e8 ee 02 00 00       	call   800d29 <_panic>

		//1 MB Hole appended to next 1 MB hole
		freeFrames = sys_calculate_free_frames() ;
  800a3b:	e8 fb 17 00 00       	call   80223b <sys_calculate_free_frames>
  800a40:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800a43:	e8 76 18 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  800a48:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[9]);
  800a4b:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800a4e:	83 ec 0c             	sub    $0xc,%esp
  800a51:	50                   	push   %eax
  800a52:	e8 0e 15 00 00       	call   801f65 <free>
  800a57:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800a5a:	e8 5f 18 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  800a5f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a62:	29 c2                	sub    %eax,%edx
  800a64:	89 d0                	mov    %edx,%eax
  800a66:	3d 00 01 00 00       	cmp    $0x100,%eax
  800a6b:	74 17                	je     800a84 <_main+0xa4c>
  800a6d:	83 ec 04             	sub    $0x4,%esp
  800a70:	68 34 2a 80 00       	push   $0x802a34
  800a75:	68 c2 00 00 00       	push   $0xc2
  800a7a:	68 bc 29 80 00       	push   $0x8029bc
  800a7f:	e8 a5 02 00 00       	call   800d29 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800a84:	e8 b2 17 00 00       	call   80223b <sys_calculate_free_frames>
  800a89:	89 c2                	mov    %eax,%edx
  800a8b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800a8e:	39 c2                	cmp    %eax,%edx
  800a90:	74 17                	je     800aa9 <_main+0xa71>
  800a92:	83 ec 04             	sub    $0x4,%esp
  800a95:	68 4b 2a 80 00       	push   $0x802a4b
  800a9a:	68 c3 00 00 00       	push   $0xc3
  800a9f:	68 bc 29 80 00       	push   $0x8029bc
  800aa4:	e8 80 02 00 00       	call   800d29 <_panic>

		//1 MB Hole appended to previous 1 MB + 256 KB hole and next 2 MB hole
		freeFrames = sys_calculate_free_frames() ;
  800aa9:	e8 8d 17 00 00       	call   80223b <sys_calculate_free_frames>
  800aae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800ab1:	e8 08 18 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  800ab6:	89 45 e0             	mov    %eax,-0x20(%ebp)
		free(ptr_allocations[3]);
  800ab9:	8b 45 9c             	mov    -0x64(%ebp),%eax
  800abc:	83 ec 0c             	sub    $0xc,%esp
  800abf:	50                   	push   %eax
  800ac0:	e8 a0 14 00 00       	call   801f65 <free>
  800ac5:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800ac8:	e8 f1 17 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  800acd:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800ad0:	29 c2                	sub    %eax,%edx
  800ad2:	89 d0                	mov    %edx,%eax
  800ad4:	3d 00 01 00 00       	cmp    $0x100,%eax
  800ad9:	74 17                	je     800af2 <_main+0xaba>
  800adb:	83 ec 04             	sub    $0x4,%esp
  800ade:	68 34 2a 80 00       	push   $0x802a34
  800ae3:	68 ca 00 00 00       	push   $0xca
  800ae8:	68 bc 29 80 00       	push   $0x8029bc
  800aed:	e8 37 02 00 00       	call   800d29 <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800af2:	e8 44 17 00 00       	call   80223b <sys_calculate_free_frames>
  800af7:	89 c2                	mov    %eax,%edx
  800af9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800afc:	39 c2                	cmp    %eax,%edx
  800afe:	74 17                	je     800b17 <_main+0xadf>
  800b00:	83 ec 04             	sub    $0x4,%esp
  800b03:	68 4b 2a 80 00       	push   $0x802a4b
  800b08:	68 cb 00 00 00       	push   $0xcb
  800b0d:	68 bc 29 80 00       	push   $0x8029bc
  800b12:	e8 12 02 00 00       	call   800d29 <_panic>

	//[5] Allocate again [test first fit]
	{
		//[FIRST FIT Case]
		//Allocate 4 MB + 256 KB - should be placed in the contiguous hole (256 KB + 4 MB)
		freeFrames = sys_calculate_free_frames() ;
  800b17:	e8 1f 17 00 00       	call   80223b <sys_calculate_free_frames>
  800b1c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800b1f:	e8 9a 17 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  800b24:	89 45 e0             	mov    %eax,-0x20(%ebp)
		ptr_allocations[13] = malloc(4*Mega + 256*kilo - kilo);
  800b27:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b2a:	c1 e0 06             	shl    $0x6,%eax
  800b2d:	89 c2                	mov    %eax,%edx
  800b2f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b32:	01 d0                	add    %edx,%eax
  800b34:	c1 e0 02             	shl    $0x2,%eax
  800b37:	2b 45 e8             	sub    -0x18(%ebp),%eax
  800b3a:	83 ec 0c             	sub    $0xc,%esp
  800b3d:	50                   	push   %eax
  800b3e:	e8 12 12 00 00       	call   801d55 <malloc>
  800b43:	83 c4 10             	add    $0x10,%esp
  800b46:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		if ((uint32) ptr_allocations[13] != (USER_HEAP_START + 1*Mega + 768*kilo)) panic("Wrong start address for the allocated space... ");
  800b49:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800b4c:	89 c1                	mov    %eax,%ecx
  800b4e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800b51:	89 d0                	mov    %edx,%eax
  800b53:	01 c0                	add    %eax,%eax
  800b55:	01 d0                	add    %edx,%eax
  800b57:	c1 e0 08             	shl    $0x8,%eax
  800b5a:	89 c2                	mov    %eax,%edx
  800b5c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b5f:	01 d0                	add    %edx,%eax
  800b61:	05 00 00 00 80       	add    $0x80000000,%eax
  800b66:	39 c1                	cmp    %eax,%ecx
  800b68:	74 17                	je     800b81 <_main+0xb49>
  800b6a:	83 ec 04             	sub    $0x4,%esp
  800b6d:	68 d4 29 80 00       	push   $0x8029d4
  800b72:	68 d5 00 00 00       	push   $0xd5
  800b77:	68 bc 29 80 00       	push   $0x8029bc
  800b7c:	e8 a8 01 00 00       	call   800d29 <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+32) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1024+64) panic("Wrong page file allocation: ");
  800b81:	e8 38 17 00 00       	call   8022be <sys_pf_calculate_allocated_pages>
  800b86:	2b 45 e0             	sub    -0x20(%ebp),%eax
  800b89:	3d 40 04 00 00       	cmp    $0x440,%eax
  800b8e:	74 17                	je     800ba7 <_main+0xb6f>
  800b90:	83 ec 04             	sub    $0x4,%esp
  800b93:	68 04 2a 80 00       	push   $0x802a04
  800b98:	68 d7 00 00 00       	push   $0xd7
  800b9d:	68 bc 29 80 00       	push   $0x8029bc
  800ba2:	e8 82 01 00 00       	call   800d29 <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800ba7:	e8 8f 16 00 00       	call   80223b <sys_calculate_free_frames>
  800bac:	89 c2                	mov    %eax,%edx
  800bae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800bb1:	39 c2                	cmp    %eax,%edx
  800bb3:	74 17                	je     800bcc <_main+0xb94>
  800bb5:	83 ec 04             	sub    $0x4,%esp
  800bb8:	68 21 2a 80 00       	push   $0x802a21
  800bbd:	68 d8 00 00 00       	push   $0xd8
  800bc2:	68 bc 29 80 00       	push   $0x8029bc
  800bc7:	e8 5d 01 00 00       	call   800d29 <_panic>
	}
	cprintf("Congratulations!! test FIRST FIT allocation (1) completed successfully.\n");
  800bcc:	83 ec 0c             	sub    $0xc,%esp
  800bcf:	68 58 2a 80 00       	push   $0x802a58
  800bd4:	e8 f2 03 00 00       	call   800fcb <cprintf>
  800bd9:	83 c4 10             	add    $0x10,%esp

	return;
  800bdc:	90                   	nop
}
  800bdd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800be0:	5b                   	pop    %ebx
  800be1:	5f                   	pop    %edi
  800be2:	5d                   	pop    %ebp
  800be3:	c3                   	ret    

00800be4 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800be4:	55                   	push   %ebp
  800be5:	89 e5                	mov    %esp,%ebp
  800be7:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800bea:	e8 81 15 00 00       	call   802170 <sys_getenvindex>
  800bef:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800bf2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bf5:	89 d0                	mov    %edx,%eax
  800bf7:	c1 e0 03             	shl    $0x3,%eax
  800bfa:	01 d0                	add    %edx,%eax
  800bfc:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800c03:	01 c8                	add    %ecx,%eax
  800c05:	01 c0                	add    %eax,%eax
  800c07:	01 d0                	add    %edx,%eax
  800c09:	01 c0                	add    %eax,%eax
  800c0b:	01 d0                	add    %edx,%eax
  800c0d:	89 c2                	mov    %eax,%edx
  800c0f:	c1 e2 05             	shl    $0x5,%edx
  800c12:	29 c2                	sub    %eax,%edx
  800c14:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800c1b:	89 c2                	mov    %eax,%edx
  800c1d:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800c23:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800c28:	a1 20 40 80 00       	mov    0x804020,%eax
  800c2d:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800c33:	84 c0                	test   %al,%al
  800c35:	74 0f                	je     800c46 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800c37:	a1 20 40 80 00       	mov    0x804020,%eax
  800c3c:	05 40 3c 01 00       	add    $0x13c40,%eax
  800c41:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800c46:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c4a:	7e 0a                	jle    800c56 <libmain+0x72>
		binaryname = argv[0];
  800c4c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4f:	8b 00                	mov    (%eax),%eax
  800c51:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  800c56:	83 ec 08             	sub    $0x8,%esp
  800c59:	ff 75 0c             	pushl  0xc(%ebp)
  800c5c:	ff 75 08             	pushl  0x8(%ebp)
  800c5f:	e8 d4 f3 ff ff       	call   800038 <_main>
  800c64:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800c67:	e8 9f 16 00 00       	call   80230b <sys_disable_interrupt>
	cprintf("**************************************\n");
  800c6c:	83 ec 0c             	sub    $0xc,%esp
  800c6f:	68 bc 2a 80 00       	push   $0x802abc
  800c74:	e8 52 03 00 00       	call   800fcb <cprintf>
  800c79:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800c7c:	a1 20 40 80 00       	mov    0x804020,%eax
  800c81:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800c87:	a1 20 40 80 00       	mov    0x804020,%eax
  800c8c:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800c92:	83 ec 04             	sub    $0x4,%esp
  800c95:	52                   	push   %edx
  800c96:	50                   	push   %eax
  800c97:	68 e4 2a 80 00       	push   $0x802ae4
  800c9c:	e8 2a 03 00 00       	call   800fcb <cprintf>
  800ca1:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800ca4:	a1 20 40 80 00       	mov    0x804020,%eax
  800ca9:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800caf:	a1 20 40 80 00       	mov    0x804020,%eax
  800cb4:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800cba:	83 ec 04             	sub    $0x4,%esp
  800cbd:	52                   	push   %edx
  800cbe:	50                   	push   %eax
  800cbf:	68 0c 2b 80 00       	push   $0x802b0c
  800cc4:	e8 02 03 00 00       	call   800fcb <cprintf>
  800cc9:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800ccc:	a1 20 40 80 00       	mov    0x804020,%eax
  800cd1:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800cd7:	83 ec 08             	sub    $0x8,%esp
  800cda:	50                   	push   %eax
  800cdb:	68 4d 2b 80 00       	push   $0x802b4d
  800ce0:	e8 e6 02 00 00       	call   800fcb <cprintf>
  800ce5:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800ce8:	83 ec 0c             	sub    $0xc,%esp
  800ceb:	68 bc 2a 80 00       	push   $0x802abc
  800cf0:	e8 d6 02 00 00       	call   800fcb <cprintf>
  800cf5:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800cf8:	e8 28 16 00 00       	call   802325 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800cfd:	e8 19 00 00 00       	call   800d1b <exit>
}
  800d02:	90                   	nop
  800d03:	c9                   	leave  
  800d04:	c3                   	ret    

00800d05 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800d05:	55                   	push   %ebp
  800d06:	89 e5                	mov    %esp,%ebp
  800d08:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800d0b:	83 ec 0c             	sub    $0xc,%esp
  800d0e:	6a 00                	push   $0x0
  800d10:	e8 27 14 00 00       	call   80213c <sys_env_destroy>
  800d15:	83 c4 10             	add    $0x10,%esp
}
  800d18:	90                   	nop
  800d19:	c9                   	leave  
  800d1a:	c3                   	ret    

00800d1b <exit>:

void
exit(void)
{
  800d1b:	55                   	push   %ebp
  800d1c:	89 e5                	mov    %esp,%ebp
  800d1e:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800d21:	e8 7c 14 00 00       	call   8021a2 <sys_env_exit>
}
  800d26:	90                   	nop
  800d27:	c9                   	leave  
  800d28:	c3                   	ret    

00800d29 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800d29:	55                   	push   %ebp
  800d2a:	89 e5                	mov    %esp,%ebp
  800d2c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800d2f:	8d 45 10             	lea    0x10(%ebp),%eax
  800d32:	83 c0 04             	add    $0x4,%eax
  800d35:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800d38:	a1 18 41 80 00       	mov    0x804118,%eax
  800d3d:	85 c0                	test   %eax,%eax
  800d3f:	74 16                	je     800d57 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800d41:	a1 18 41 80 00       	mov    0x804118,%eax
  800d46:	83 ec 08             	sub    $0x8,%esp
  800d49:	50                   	push   %eax
  800d4a:	68 64 2b 80 00       	push   $0x802b64
  800d4f:	e8 77 02 00 00       	call   800fcb <cprintf>
  800d54:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800d57:	a1 00 40 80 00       	mov    0x804000,%eax
  800d5c:	ff 75 0c             	pushl  0xc(%ebp)
  800d5f:	ff 75 08             	pushl  0x8(%ebp)
  800d62:	50                   	push   %eax
  800d63:	68 69 2b 80 00       	push   $0x802b69
  800d68:	e8 5e 02 00 00       	call   800fcb <cprintf>
  800d6d:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800d70:	8b 45 10             	mov    0x10(%ebp),%eax
  800d73:	83 ec 08             	sub    $0x8,%esp
  800d76:	ff 75 f4             	pushl  -0xc(%ebp)
  800d79:	50                   	push   %eax
  800d7a:	e8 e1 01 00 00       	call   800f60 <vcprintf>
  800d7f:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800d82:	83 ec 08             	sub    $0x8,%esp
  800d85:	6a 00                	push   $0x0
  800d87:	68 85 2b 80 00       	push   $0x802b85
  800d8c:	e8 cf 01 00 00       	call   800f60 <vcprintf>
  800d91:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800d94:	e8 82 ff ff ff       	call   800d1b <exit>

	// should not return here
	while (1) ;
  800d99:	eb fe                	jmp    800d99 <_panic+0x70>

00800d9b <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800d9b:	55                   	push   %ebp
  800d9c:	89 e5                	mov    %esp,%ebp
  800d9e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800da1:	a1 20 40 80 00       	mov    0x804020,%eax
  800da6:	8b 50 74             	mov    0x74(%eax),%edx
  800da9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dac:	39 c2                	cmp    %eax,%edx
  800dae:	74 14                	je     800dc4 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800db0:	83 ec 04             	sub    $0x4,%esp
  800db3:	68 88 2b 80 00       	push   $0x802b88
  800db8:	6a 26                	push   $0x26
  800dba:	68 d4 2b 80 00       	push   $0x802bd4
  800dbf:	e8 65 ff ff ff       	call   800d29 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800dc4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800dcb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800dd2:	e9 b6 00 00 00       	jmp    800e8d <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800dd7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dda:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800de1:	8b 45 08             	mov    0x8(%ebp),%eax
  800de4:	01 d0                	add    %edx,%eax
  800de6:	8b 00                	mov    (%eax),%eax
  800de8:	85 c0                	test   %eax,%eax
  800dea:	75 08                	jne    800df4 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800dec:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800def:	e9 96 00 00 00       	jmp    800e8a <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800df4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800dfb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800e02:	eb 5d                	jmp    800e61 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800e04:	a1 20 40 80 00       	mov    0x804020,%eax
  800e09:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800e0f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800e12:	c1 e2 04             	shl    $0x4,%edx
  800e15:	01 d0                	add    %edx,%eax
  800e17:	8a 40 04             	mov    0x4(%eax),%al
  800e1a:	84 c0                	test   %al,%al
  800e1c:	75 40                	jne    800e5e <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800e1e:	a1 20 40 80 00       	mov    0x804020,%eax
  800e23:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800e29:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800e2c:	c1 e2 04             	shl    $0x4,%edx
  800e2f:	01 d0                	add    %edx,%eax
  800e31:	8b 00                	mov    (%eax),%eax
  800e33:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800e36:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800e39:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800e3e:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800e40:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e43:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800e4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4d:	01 c8                	add    %ecx,%eax
  800e4f:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800e51:	39 c2                	cmp    %eax,%edx
  800e53:	75 09                	jne    800e5e <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800e55:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800e5c:	eb 12                	jmp    800e70 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800e5e:	ff 45 e8             	incl   -0x18(%ebp)
  800e61:	a1 20 40 80 00       	mov    0x804020,%eax
  800e66:	8b 50 74             	mov    0x74(%eax),%edx
  800e69:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800e6c:	39 c2                	cmp    %eax,%edx
  800e6e:	77 94                	ja     800e04 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800e70:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800e74:	75 14                	jne    800e8a <CheckWSWithoutLastIndex+0xef>
			panic(
  800e76:	83 ec 04             	sub    $0x4,%esp
  800e79:	68 e0 2b 80 00       	push   $0x802be0
  800e7e:	6a 3a                	push   $0x3a
  800e80:	68 d4 2b 80 00       	push   $0x802bd4
  800e85:	e8 9f fe ff ff       	call   800d29 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800e8a:	ff 45 f0             	incl   -0x10(%ebp)
  800e8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e90:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800e93:	0f 8c 3e ff ff ff    	jl     800dd7 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800e99:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800ea0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800ea7:	eb 20                	jmp    800ec9 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800ea9:	a1 20 40 80 00       	mov    0x804020,%eax
  800eae:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800eb4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800eb7:	c1 e2 04             	shl    $0x4,%edx
  800eba:	01 d0                	add    %edx,%eax
  800ebc:	8a 40 04             	mov    0x4(%eax),%al
  800ebf:	3c 01                	cmp    $0x1,%al
  800ec1:	75 03                	jne    800ec6 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800ec3:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800ec6:	ff 45 e0             	incl   -0x20(%ebp)
  800ec9:	a1 20 40 80 00       	mov    0x804020,%eax
  800ece:	8b 50 74             	mov    0x74(%eax),%edx
  800ed1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ed4:	39 c2                	cmp    %eax,%edx
  800ed6:	77 d1                	ja     800ea9 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800ed8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800edb:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800ede:	74 14                	je     800ef4 <CheckWSWithoutLastIndex+0x159>
		panic(
  800ee0:	83 ec 04             	sub    $0x4,%esp
  800ee3:	68 34 2c 80 00       	push   $0x802c34
  800ee8:	6a 44                	push   $0x44
  800eea:	68 d4 2b 80 00       	push   $0x802bd4
  800eef:	e8 35 fe ff ff       	call   800d29 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800ef4:	90                   	nop
  800ef5:	c9                   	leave  
  800ef6:	c3                   	ret    

00800ef7 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800ef7:	55                   	push   %ebp
  800ef8:	89 e5                	mov    %esp,%ebp
  800efa:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800efd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f00:	8b 00                	mov    (%eax),%eax
  800f02:	8d 48 01             	lea    0x1(%eax),%ecx
  800f05:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f08:	89 0a                	mov    %ecx,(%edx)
  800f0a:	8b 55 08             	mov    0x8(%ebp),%edx
  800f0d:	88 d1                	mov    %dl,%cl
  800f0f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f12:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800f16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f19:	8b 00                	mov    (%eax),%eax
  800f1b:	3d ff 00 00 00       	cmp    $0xff,%eax
  800f20:	75 2c                	jne    800f4e <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800f22:	a0 24 40 80 00       	mov    0x804024,%al
  800f27:	0f b6 c0             	movzbl %al,%eax
  800f2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f2d:	8b 12                	mov    (%edx),%edx
  800f2f:	89 d1                	mov    %edx,%ecx
  800f31:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f34:	83 c2 08             	add    $0x8,%edx
  800f37:	83 ec 04             	sub    $0x4,%esp
  800f3a:	50                   	push   %eax
  800f3b:	51                   	push   %ecx
  800f3c:	52                   	push   %edx
  800f3d:	e8 b8 11 00 00       	call   8020fa <sys_cputs>
  800f42:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800f45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f48:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800f4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f51:	8b 40 04             	mov    0x4(%eax),%eax
  800f54:	8d 50 01             	lea    0x1(%eax),%edx
  800f57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5a:	89 50 04             	mov    %edx,0x4(%eax)
}
  800f5d:	90                   	nop
  800f5e:	c9                   	leave  
  800f5f:	c3                   	ret    

00800f60 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800f60:	55                   	push   %ebp
  800f61:	89 e5                	mov    %esp,%ebp
  800f63:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800f69:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800f70:	00 00 00 
	b.cnt = 0;
  800f73:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800f7a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800f7d:	ff 75 0c             	pushl  0xc(%ebp)
  800f80:	ff 75 08             	pushl  0x8(%ebp)
  800f83:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800f89:	50                   	push   %eax
  800f8a:	68 f7 0e 80 00       	push   $0x800ef7
  800f8f:	e8 11 02 00 00       	call   8011a5 <vprintfmt>
  800f94:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800f97:	a0 24 40 80 00       	mov    0x804024,%al
  800f9c:	0f b6 c0             	movzbl %al,%eax
  800f9f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800fa5:	83 ec 04             	sub    $0x4,%esp
  800fa8:	50                   	push   %eax
  800fa9:	52                   	push   %edx
  800faa:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800fb0:	83 c0 08             	add    $0x8,%eax
  800fb3:	50                   	push   %eax
  800fb4:	e8 41 11 00 00       	call   8020fa <sys_cputs>
  800fb9:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800fbc:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  800fc3:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800fc9:	c9                   	leave  
  800fca:	c3                   	ret    

00800fcb <cprintf>:

int cprintf(const char *fmt, ...) {
  800fcb:	55                   	push   %ebp
  800fcc:	89 e5                	mov    %esp,%ebp
  800fce:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800fd1:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  800fd8:	8d 45 0c             	lea    0xc(%ebp),%eax
  800fdb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800fde:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe1:	83 ec 08             	sub    $0x8,%esp
  800fe4:	ff 75 f4             	pushl  -0xc(%ebp)
  800fe7:	50                   	push   %eax
  800fe8:	e8 73 ff ff ff       	call   800f60 <vcprintf>
  800fed:	83 c4 10             	add    $0x10,%esp
  800ff0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800ff3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ff6:	c9                   	leave  
  800ff7:	c3                   	ret    

00800ff8 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ff8:	55                   	push   %ebp
  800ff9:	89 e5                	mov    %esp,%ebp
  800ffb:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800ffe:	e8 08 13 00 00       	call   80230b <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  801003:	8d 45 0c             	lea    0xc(%ebp),%eax
  801006:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  801009:	8b 45 08             	mov    0x8(%ebp),%eax
  80100c:	83 ec 08             	sub    $0x8,%esp
  80100f:	ff 75 f4             	pushl  -0xc(%ebp)
  801012:	50                   	push   %eax
  801013:	e8 48 ff ff ff       	call   800f60 <vcprintf>
  801018:	83 c4 10             	add    $0x10,%esp
  80101b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80101e:	e8 02 13 00 00       	call   802325 <sys_enable_interrupt>
	return cnt;
  801023:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801026:	c9                   	leave  
  801027:	c3                   	ret    

00801028 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  801028:	55                   	push   %ebp
  801029:	89 e5                	mov    %esp,%ebp
  80102b:	53                   	push   %ebx
  80102c:	83 ec 14             	sub    $0x14,%esp
  80102f:	8b 45 10             	mov    0x10(%ebp),%eax
  801032:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801035:	8b 45 14             	mov    0x14(%ebp),%eax
  801038:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80103b:	8b 45 18             	mov    0x18(%ebp),%eax
  80103e:	ba 00 00 00 00       	mov    $0x0,%edx
  801043:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801046:	77 55                	ja     80109d <printnum+0x75>
  801048:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80104b:	72 05                	jb     801052 <printnum+0x2a>
  80104d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801050:	77 4b                	ja     80109d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  801052:	8b 45 1c             	mov    0x1c(%ebp),%eax
  801055:	8d 58 ff             	lea    -0x1(%eax),%ebx
  801058:	8b 45 18             	mov    0x18(%ebp),%eax
  80105b:	ba 00 00 00 00       	mov    $0x0,%edx
  801060:	52                   	push   %edx
  801061:	50                   	push   %eax
  801062:	ff 75 f4             	pushl  -0xc(%ebp)
  801065:	ff 75 f0             	pushl  -0x10(%ebp)
  801068:	e8 bf 16 00 00       	call   80272c <__udivdi3>
  80106d:	83 c4 10             	add    $0x10,%esp
  801070:	83 ec 04             	sub    $0x4,%esp
  801073:	ff 75 20             	pushl  0x20(%ebp)
  801076:	53                   	push   %ebx
  801077:	ff 75 18             	pushl  0x18(%ebp)
  80107a:	52                   	push   %edx
  80107b:	50                   	push   %eax
  80107c:	ff 75 0c             	pushl  0xc(%ebp)
  80107f:	ff 75 08             	pushl  0x8(%ebp)
  801082:	e8 a1 ff ff ff       	call   801028 <printnum>
  801087:	83 c4 20             	add    $0x20,%esp
  80108a:	eb 1a                	jmp    8010a6 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80108c:	83 ec 08             	sub    $0x8,%esp
  80108f:	ff 75 0c             	pushl  0xc(%ebp)
  801092:	ff 75 20             	pushl  0x20(%ebp)
  801095:	8b 45 08             	mov    0x8(%ebp),%eax
  801098:	ff d0                	call   *%eax
  80109a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80109d:	ff 4d 1c             	decl   0x1c(%ebp)
  8010a0:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8010a4:	7f e6                	jg     80108c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8010a6:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8010a9:	bb 00 00 00 00       	mov    $0x0,%ebx
  8010ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010b1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010b4:	53                   	push   %ebx
  8010b5:	51                   	push   %ecx
  8010b6:	52                   	push   %edx
  8010b7:	50                   	push   %eax
  8010b8:	e8 7f 17 00 00       	call   80283c <__umoddi3>
  8010bd:	83 c4 10             	add    $0x10,%esp
  8010c0:	05 94 2e 80 00       	add    $0x802e94,%eax
  8010c5:	8a 00                	mov    (%eax),%al
  8010c7:	0f be c0             	movsbl %al,%eax
  8010ca:	83 ec 08             	sub    $0x8,%esp
  8010cd:	ff 75 0c             	pushl  0xc(%ebp)
  8010d0:	50                   	push   %eax
  8010d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d4:	ff d0                	call   *%eax
  8010d6:	83 c4 10             	add    $0x10,%esp
}
  8010d9:	90                   	nop
  8010da:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8010dd:	c9                   	leave  
  8010de:	c3                   	ret    

008010df <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8010df:	55                   	push   %ebp
  8010e0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8010e2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8010e6:	7e 1c                	jle    801104 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8010e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010eb:	8b 00                	mov    (%eax),%eax
  8010ed:	8d 50 08             	lea    0x8(%eax),%edx
  8010f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f3:	89 10                	mov    %edx,(%eax)
  8010f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f8:	8b 00                	mov    (%eax),%eax
  8010fa:	83 e8 08             	sub    $0x8,%eax
  8010fd:	8b 50 04             	mov    0x4(%eax),%edx
  801100:	8b 00                	mov    (%eax),%eax
  801102:	eb 40                	jmp    801144 <getuint+0x65>
	else if (lflag)
  801104:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801108:	74 1e                	je     801128 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80110a:	8b 45 08             	mov    0x8(%ebp),%eax
  80110d:	8b 00                	mov    (%eax),%eax
  80110f:	8d 50 04             	lea    0x4(%eax),%edx
  801112:	8b 45 08             	mov    0x8(%ebp),%eax
  801115:	89 10                	mov    %edx,(%eax)
  801117:	8b 45 08             	mov    0x8(%ebp),%eax
  80111a:	8b 00                	mov    (%eax),%eax
  80111c:	83 e8 04             	sub    $0x4,%eax
  80111f:	8b 00                	mov    (%eax),%eax
  801121:	ba 00 00 00 00       	mov    $0x0,%edx
  801126:	eb 1c                	jmp    801144 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  801128:	8b 45 08             	mov    0x8(%ebp),%eax
  80112b:	8b 00                	mov    (%eax),%eax
  80112d:	8d 50 04             	lea    0x4(%eax),%edx
  801130:	8b 45 08             	mov    0x8(%ebp),%eax
  801133:	89 10                	mov    %edx,(%eax)
  801135:	8b 45 08             	mov    0x8(%ebp),%eax
  801138:	8b 00                	mov    (%eax),%eax
  80113a:	83 e8 04             	sub    $0x4,%eax
  80113d:	8b 00                	mov    (%eax),%eax
  80113f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  801144:	5d                   	pop    %ebp
  801145:	c3                   	ret    

00801146 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  801146:	55                   	push   %ebp
  801147:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  801149:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80114d:	7e 1c                	jle    80116b <getint+0x25>
		return va_arg(*ap, long long);
  80114f:	8b 45 08             	mov    0x8(%ebp),%eax
  801152:	8b 00                	mov    (%eax),%eax
  801154:	8d 50 08             	lea    0x8(%eax),%edx
  801157:	8b 45 08             	mov    0x8(%ebp),%eax
  80115a:	89 10                	mov    %edx,(%eax)
  80115c:	8b 45 08             	mov    0x8(%ebp),%eax
  80115f:	8b 00                	mov    (%eax),%eax
  801161:	83 e8 08             	sub    $0x8,%eax
  801164:	8b 50 04             	mov    0x4(%eax),%edx
  801167:	8b 00                	mov    (%eax),%eax
  801169:	eb 38                	jmp    8011a3 <getint+0x5d>
	else if (lflag)
  80116b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80116f:	74 1a                	je     80118b <getint+0x45>
		return va_arg(*ap, long);
  801171:	8b 45 08             	mov    0x8(%ebp),%eax
  801174:	8b 00                	mov    (%eax),%eax
  801176:	8d 50 04             	lea    0x4(%eax),%edx
  801179:	8b 45 08             	mov    0x8(%ebp),%eax
  80117c:	89 10                	mov    %edx,(%eax)
  80117e:	8b 45 08             	mov    0x8(%ebp),%eax
  801181:	8b 00                	mov    (%eax),%eax
  801183:	83 e8 04             	sub    $0x4,%eax
  801186:	8b 00                	mov    (%eax),%eax
  801188:	99                   	cltd   
  801189:	eb 18                	jmp    8011a3 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80118b:	8b 45 08             	mov    0x8(%ebp),%eax
  80118e:	8b 00                	mov    (%eax),%eax
  801190:	8d 50 04             	lea    0x4(%eax),%edx
  801193:	8b 45 08             	mov    0x8(%ebp),%eax
  801196:	89 10                	mov    %edx,(%eax)
  801198:	8b 45 08             	mov    0x8(%ebp),%eax
  80119b:	8b 00                	mov    (%eax),%eax
  80119d:	83 e8 04             	sub    $0x4,%eax
  8011a0:	8b 00                	mov    (%eax),%eax
  8011a2:	99                   	cltd   
}
  8011a3:	5d                   	pop    %ebp
  8011a4:	c3                   	ret    

008011a5 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8011a5:	55                   	push   %ebp
  8011a6:	89 e5                	mov    %esp,%ebp
  8011a8:	56                   	push   %esi
  8011a9:	53                   	push   %ebx
  8011aa:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8011ad:	eb 17                	jmp    8011c6 <vprintfmt+0x21>
			if (ch == '\0')
  8011af:	85 db                	test   %ebx,%ebx
  8011b1:	0f 84 af 03 00 00    	je     801566 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8011b7:	83 ec 08             	sub    $0x8,%esp
  8011ba:	ff 75 0c             	pushl  0xc(%ebp)
  8011bd:	53                   	push   %ebx
  8011be:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c1:	ff d0                	call   *%eax
  8011c3:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8011c6:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c9:	8d 50 01             	lea    0x1(%eax),%edx
  8011cc:	89 55 10             	mov    %edx,0x10(%ebp)
  8011cf:	8a 00                	mov    (%eax),%al
  8011d1:	0f b6 d8             	movzbl %al,%ebx
  8011d4:	83 fb 25             	cmp    $0x25,%ebx
  8011d7:	75 d6                	jne    8011af <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8011d9:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8011dd:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8011e4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8011eb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8011f2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8011f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fc:	8d 50 01             	lea    0x1(%eax),%edx
  8011ff:	89 55 10             	mov    %edx,0x10(%ebp)
  801202:	8a 00                	mov    (%eax),%al
  801204:	0f b6 d8             	movzbl %al,%ebx
  801207:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80120a:	83 f8 55             	cmp    $0x55,%eax
  80120d:	0f 87 2b 03 00 00    	ja     80153e <vprintfmt+0x399>
  801213:	8b 04 85 b8 2e 80 00 	mov    0x802eb8(,%eax,4),%eax
  80121a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80121c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801220:	eb d7                	jmp    8011f9 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801222:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  801226:	eb d1                	jmp    8011f9 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801228:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80122f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801232:	89 d0                	mov    %edx,%eax
  801234:	c1 e0 02             	shl    $0x2,%eax
  801237:	01 d0                	add    %edx,%eax
  801239:	01 c0                	add    %eax,%eax
  80123b:	01 d8                	add    %ebx,%eax
  80123d:	83 e8 30             	sub    $0x30,%eax
  801240:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801243:	8b 45 10             	mov    0x10(%ebp),%eax
  801246:	8a 00                	mov    (%eax),%al
  801248:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80124b:	83 fb 2f             	cmp    $0x2f,%ebx
  80124e:	7e 3e                	jle    80128e <vprintfmt+0xe9>
  801250:	83 fb 39             	cmp    $0x39,%ebx
  801253:	7f 39                	jg     80128e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  801255:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  801258:	eb d5                	jmp    80122f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80125a:	8b 45 14             	mov    0x14(%ebp),%eax
  80125d:	83 c0 04             	add    $0x4,%eax
  801260:	89 45 14             	mov    %eax,0x14(%ebp)
  801263:	8b 45 14             	mov    0x14(%ebp),%eax
  801266:	83 e8 04             	sub    $0x4,%eax
  801269:	8b 00                	mov    (%eax),%eax
  80126b:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80126e:	eb 1f                	jmp    80128f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801270:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801274:	79 83                	jns    8011f9 <vprintfmt+0x54>
				width = 0;
  801276:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80127d:	e9 77 ff ff ff       	jmp    8011f9 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801282:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  801289:	e9 6b ff ff ff       	jmp    8011f9 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80128e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80128f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801293:	0f 89 60 ff ff ff    	jns    8011f9 <vprintfmt+0x54>
				width = precision, precision = -1;
  801299:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80129c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80129f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8012a6:	e9 4e ff ff ff       	jmp    8011f9 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8012ab:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8012ae:	e9 46 ff ff ff       	jmp    8011f9 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8012b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8012b6:	83 c0 04             	add    $0x4,%eax
  8012b9:	89 45 14             	mov    %eax,0x14(%ebp)
  8012bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8012bf:	83 e8 04             	sub    $0x4,%eax
  8012c2:	8b 00                	mov    (%eax),%eax
  8012c4:	83 ec 08             	sub    $0x8,%esp
  8012c7:	ff 75 0c             	pushl  0xc(%ebp)
  8012ca:	50                   	push   %eax
  8012cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ce:	ff d0                	call   *%eax
  8012d0:	83 c4 10             	add    $0x10,%esp
			break;
  8012d3:	e9 89 02 00 00       	jmp    801561 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8012d8:	8b 45 14             	mov    0x14(%ebp),%eax
  8012db:	83 c0 04             	add    $0x4,%eax
  8012de:	89 45 14             	mov    %eax,0x14(%ebp)
  8012e1:	8b 45 14             	mov    0x14(%ebp),%eax
  8012e4:	83 e8 04             	sub    $0x4,%eax
  8012e7:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8012e9:	85 db                	test   %ebx,%ebx
  8012eb:	79 02                	jns    8012ef <vprintfmt+0x14a>
				err = -err;
  8012ed:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8012ef:	83 fb 64             	cmp    $0x64,%ebx
  8012f2:	7f 0b                	jg     8012ff <vprintfmt+0x15a>
  8012f4:	8b 34 9d 00 2d 80 00 	mov    0x802d00(,%ebx,4),%esi
  8012fb:	85 f6                	test   %esi,%esi
  8012fd:	75 19                	jne    801318 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8012ff:	53                   	push   %ebx
  801300:	68 a5 2e 80 00       	push   $0x802ea5
  801305:	ff 75 0c             	pushl  0xc(%ebp)
  801308:	ff 75 08             	pushl  0x8(%ebp)
  80130b:	e8 5e 02 00 00       	call   80156e <printfmt>
  801310:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  801313:	e9 49 02 00 00       	jmp    801561 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  801318:	56                   	push   %esi
  801319:	68 ae 2e 80 00       	push   $0x802eae
  80131e:	ff 75 0c             	pushl  0xc(%ebp)
  801321:	ff 75 08             	pushl  0x8(%ebp)
  801324:	e8 45 02 00 00       	call   80156e <printfmt>
  801329:	83 c4 10             	add    $0x10,%esp
			break;
  80132c:	e9 30 02 00 00       	jmp    801561 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801331:	8b 45 14             	mov    0x14(%ebp),%eax
  801334:	83 c0 04             	add    $0x4,%eax
  801337:	89 45 14             	mov    %eax,0x14(%ebp)
  80133a:	8b 45 14             	mov    0x14(%ebp),%eax
  80133d:	83 e8 04             	sub    $0x4,%eax
  801340:	8b 30                	mov    (%eax),%esi
  801342:	85 f6                	test   %esi,%esi
  801344:	75 05                	jne    80134b <vprintfmt+0x1a6>
				p = "(null)";
  801346:	be b1 2e 80 00       	mov    $0x802eb1,%esi
			if (width > 0 && padc != '-')
  80134b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80134f:	7e 6d                	jle    8013be <vprintfmt+0x219>
  801351:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  801355:	74 67                	je     8013be <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  801357:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80135a:	83 ec 08             	sub    $0x8,%esp
  80135d:	50                   	push   %eax
  80135e:	56                   	push   %esi
  80135f:	e8 0c 03 00 00       	call   801670 <strnlen>
  801364:	83 c4 10             	add    $0x10,%esp
  801367:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80136a:	eb 16                	jmp    801382 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80136c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801370:	83 ec 08             	sub    $0x8,%esp
  801373:	ff 75 0c             	pushl  0xc(%ebp)
  801376:	50                   	push   %eax
  801377:	8b 45 08             	mov    0x8(%ebp),%eax
  80137a:	ff d0                	call   *%eax
  80137c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80137f:	ff 4d e4             	decl   -0x1c(%ebp)
  801382:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801386:	7f e4                	jg     80136c <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801388:	eb 34                	jmp    8013be <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80138a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80138e:	74 1c                	je     8013ac <vprintfmt+0x207>
  801390:	83 fb 1f             	cmp    $0x1f,%ebx
  801393:	7e 05                	jle    80139a <vprintfmt+0x1f5>
  801395:	83 fb 7e             	cmp    $0x7e,%ebx
  801398:	7e 12                	jle    8013ac <vprintfmt+0x207>
					putch('?', putdat);
  80139a:	83 ec 08             	sub    $0x8,%esp
  80139d:	ff 75 0c             	pushl  0xc(%ebp)
  8013a0:	6a 3f                	push   $0x3f
  8013a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a5:	ff d0                	call   *%eax
  8013a7:	83 c4 10             	add    $0x10,%esp
  8013aa:	eb 0f                	jmp    8013bb <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8013ac:	83 ec 08             	sub    $0x8,%esp
  8013af:	ff 75 0c             	pushl  0xc(%ebp)
  8013b2:	53                   	push   %ebx
  8013b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b6:	ff d0                	call   *%eax
  8013b8:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8013bb:	ff 4d e4             	decl   -0x1c(%ebp)
  8013be:	89 f0                	mov    %esi,%eax
  8013c0:	8d 70 01             	lea    0x1(%eax),%esi
  8013c3:	8a 00                	mov    (%eax),%al
  8013c5:	0f be d8             	movsbl %al,%ebx
  8013c8:	85 db                	test   %ebx,%ebx
  8013ca:	74 24                	je     8013f0 <vprintfmt+0x24b>
  8013cc:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8013d0:	78 b8                	js     80138a <vprintfmt+0x1e5>
  8013d2:	ff 4d e0             	decl   -0x20(%ebp)
  8013d5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8013d9:	79 af                	jns    80138a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8013db:	eb 13                	jmp    8013f0 <vprintfmt+0x24b>
				putch(' ', putdat);
  8013dd:	83 ec 08             	sub    $0x8,%esp
  8013e0:	ff 75 0c             	pushl  0xc(%ebp)
  8013e3:	6a 20                	push   $0x20
  8013e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e8:	ff d0                	call   *%eax
  8013ea:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8013ed:	ff 4d e4             	decl   -0x1c(%ebp)
  8013f0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8013f4:	7f e7                	jg     8013dd <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8013f6:	e9 66 01 00 00       	jmp    801561 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8013fb:	83 ec 08             	sub    $0x8,%esp
  8013fe:	ff 75 e8             	pushl  -0x18(%ebp)
  801401:	8d 45 14             	lea    0x14(%ebp),%eax
  801404:	50                   	push   %eax
  801405:	e8 3c fd ff ff       	call   801146 <getint>
  80140a:	83 c4 10             	add    $0x10,%esp
  80140d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801410:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801413:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801416:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801419:	85 d2                	test   %edx,%edx
  80141b:	79 23                	jns    801440 <vprintfmt+0x29b>
				putch('-', putdat);
  80141d:	83 ec 08             	sub    $0x8,%esp
  801420:	ff 75 0c             	pushl  0xc(%ebp)
  801423:	6a 2d                	push   $0x2d
  801425:	8b 45 08             	mov    0x8(%ebp),%eax
  801428:	ff d0                	call   *%eax
  80142a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80142d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801430:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801433:	f7 d8                	neg    %eax
  801435:	83 d2 00             	adc    $0x0,%edx
  801438:	f7 da                	neg    %edx
  80143a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80143d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801440:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801447:	e9 bc 00 00 00       	jmp    801508 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80144c:	83 ec 08             	sub    $0x8,%esp
  80144f:	ff 75 e8             	pushl  -0x18(%ebp)
  801452:	8d 45 14             	lea    0x14(%ebp),%eax
  801455:	50                   	push   %eax
  801456:	e8 84 fc ff ff       	call   8010df <getuint>
  80145b:	83 c4 10             	add    $0x10,%esp
  80145e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801461:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801464:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80146b:	e9 98 00 00 00       	jmp    801508 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801470:	83 ec 08             	sub    $0x8,%esp
  801473:	ff 75 0c             	pushl  0xc(%ebp)
  801476:	6a 58                	push   $0x58
  801478:	8b 45 08             	mov    0x8(%ebp),%eax
  80147b:	ff d0                	call   *%eax
  80147d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801480:	83 ec 08             	sub    $0x8,%esp
  801483:	ff 75 0c             	pushl  0xc(%ebp)
  801486:	6a 58                	push   $0x58
  801488:	8b 45 08             	mov    0x8(%ebp),%eax
  80148b:	ff d0                	call   *%eax
  80148d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801490:	83 ec 08             	sub    $0x8,%esp
  801493:	ff 75 0c             	pushl  0xc(%ebp)
  801496:	6a 58                	push   $0x58
  801498:	8b 45 08             	mov    0x8(%ebp),%eax
  80149b:	ff d0                	call   *%eax
  80149d:	83 c4 10             	add    $0x10,%esp
			break;
  8014a0:	e9 bc 00 00 00       	jmp    801561 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8014a5:	83 ec 08             	sub    $0x8,%esp
  8014a8:	ff 75 0c             	pushl  0xc(%ebp)
  8014ab:	6a 30                	push   $0x30
  8014ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b0:	ff d0                	call   *%eax
  8014b2:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8014b5:	83 ec 08             	sub    $0x8,%esp
  8014b8:	ff 75 0c             	pushl  0xc(%ebp)
  8014bb:	6a 78                	push   $0x78
  8014bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c0:	ff d0                	call   *%eax
  8014c2:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8014c5:	8b 45 14             	mov    0x14(%ebp),%eax
  8014c8:	83 c0 04             	add    $0x4,%eax
  8014cb:	89 45 14             	mov    %eax,0x14(%ebp)
  8014ce:	8b 45 14             	mov    0x14(%ebp),%eax
  8014d1:	83 e8 04             	sub    $0x4,%eax
  8014d4:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8014d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8014d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8014e0:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8014e7:	eb 1f                	jmp    801508 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8014e9:	83 ec 08             	sub    $0x8,%esp
  8014ec:	ff 75 e8             	pushl  -0x18(%ebp)
  8014ef:	8d 45 14             	lea    0x14(%ebp),%eax
  8014f2:	50                   	push   %eax
  8014f3:	e8 e7 fb ff ff       	call   8010df <getuint>
  8014f8:	83 c4 10             	add    $0x10,%esp
  8014fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8014fe:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  801501:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801508:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80150c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80150f:	83 ec 04             	sub    $0x4,%esp
  801512:	52                   	push   %edx
  801513:	ff 75 e4             	pushl  -0x1c(%ebp)
  801516:	50                   	push   %eax
  801517:	ff 75 f4             	pushl  -0xc(%ebp)
  80151a:	ff 75 f0             	pushl  -0x10(%ebp)
  80151d:	ff 75 0c             	pushl  0xc(%ebp)
  801520:	ff 75 08             	pushl  0x8(%ebp)
  801523:	e8 00 fb ff ff       	call   801028 <printnum>
  801528:	83 c4 20             	add    $0x20,%esp
			break;
  80152b:	eb 34                	jmp    801561 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80152d:	83 ec 08             	sub    $0x8,%esp
  801530:	ff 75 0c             	pushl  0xc(%ebp)
  801533:	53                   	push   %ebx
  801534:	8b 45 08             	mov    0x8(%ebp),%eax
  801537:	ff d0                	call   *%eax
  801539:	83 c4 10             	add    $0x10,%esp
			break;
  80153c:	eb 23                	jmp    801561 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80153e:	83 ec 08             	sub    $0x8,%esp
  801541:	ff 75 0c             	pushl  0xc(%ebp)
  801544:	6a 25                	push   $0x25
  801546:	8b 45 08             	mov    0x8(%ebp),%eax
  801549:	ff d0                	call   *%eax
  80154b:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80154e:	ff 4d 10             	decl   0x10(%ebp)
  801551:	eb 03                	jmp    801556 <vprintfmt+0x3b1>
  801553:	ff 4d 10             	decl   0x10(%ebp)
  801556:	8b 45 10             	mov    0x10(%ebp),%eax
  801559:	48                   	dec    %eax
  80155a:	8a 00                	mov    (%eax),%al
  80155c:	3c 25                	cmp    $0x25,%al
  80155e:	75 f3                	jne    801553 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801560:	90                   	nop
		}
	}
  801561:	e9 47 fc ff ff       	jmp    8011ad <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801566:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801567:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80156a:	5b                   	pop    %ebx
  80156b:	5e                   	pop    %esi
  80156c:	5d                   	pop    %ebp
  80156d:	c3                   	ret    

0080156e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80156e:	55                   	push   %ebp
  80156f:	89 e5                	mov    %esp,%ebp
  801571:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801574:	8d 45 10             	lea    0x10(%ebp),%eax
  801577:	83 c0 04             	add    $0x4,%eax
  80157a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80157d:	8b 45 10             	mov    0x10(%ebp),%eax
  801580:	ff 75 f4             	pushl  -0xc(%ebp)
  801583:	50                   	push   %eax
  801584:	ff 75 0c             	pushl  0xc(%ebp)
  801587:	ff 75 08             	pushl  0x8(%ebp)
  80158a:	e8 16 fc ff ff       	call   8011a5 <vprintfmt>
  80158f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801592:	90                   	nop
  801593:	c9                   	leave  
  801594:	c3                   	ret    

00801595 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801595:	55                   	push   %ebp
  801596:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801598:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159b:	8b 40 08             	mov    0x8(%eax),%eax
  80159e:	8d 50 01             	lea    0x1(%eax),%edx
  8015a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a4:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8015a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015aa:	8b 10                	mov    (%eax),%edx
  8015ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015af:	8b 40 04             	mov    0x4(%eax),%eax
  8015b2:	39 c2                	cmp    %eax,%edx
  8015b4:	73 12                	jae    8015c8 <sprintputch+0x33>
		*b->buf++ = ch;
  8015b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b9:	8b 00                	mov    (%eax),%eax
  8015bb:	8d 48 01             	lea    0x1(%eax),%ecx
  8015be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015c1:	89 0a                	mov    %ecx,(%edx)
  8015c3:	8b 55 08             	mov    0x8(%ebp),%edx
  8015c6:	88 10                	mov    %dl,(%eax)
}
  8015c8:	90                   	nop
  8015c9:	5d                   	pop    %ebp
  8015ca:	c3                   	ret    

008015cb <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8015cb:	55                   	push   %ebp
  8015cc:	89 e5                	mov    %esp,%ebp
  8015ce:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8015d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8015d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015da:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e0:	01 d0                	add    %edx,%eax
  8015e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8015e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8015ec:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8015f0:	74 06                	je     8015f8 <vsnprintf+0x2d>
  8015f2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8015f6:	7f 07                	jg     8015ff <vsnprintf+0x34>
		return -E_INVAL;
  8015f8:	b8 03 00 00 00       	mov    $0x3,%eax
  8015fd:	eb 20                	jmp    80161f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8015ff:	ff 75 14             	pushl  0x14(%ebp)
  801602:	ff 75 10             	pushl  0x10(%ebp)
  801605:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801608:	50                   	push   %eax
  801609:	68 95 15 80 00       	push   $0x801595
  80160e:	e8 92 fb ff ff       	call   8011a5 <vprintfmt>
  801613:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801616:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801619:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80161c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80161f:	c9                   	leave  
  801620:	c3                   	ret    

00801621 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801621:	55                   	push   %ebp
  801622:	89 e5                	mov    %esp,%ebp
  801624:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801627:	8d 45 10             	lea    0x10(%ebp),%eax
  80162a:	83 c0 04             	add    $0x4,%eax
  80162d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801630:	8b 45 10             	mov    0x10(%ebp),%eax
  801633:	ff 75 f4             	pushl  -0xc(%ebp)
  801636:	50                   	push   %eax
  801637:	ff 75 0c             	pushl  0xc(%ebp)
  80163a:	ff 75 08             	pushl  0x8(%ebp)
  80163d:	e8 89 ff ff ff       	call   8015cb <vsnprintf>
  801642:	83 c4 10             	add    $0x10,%esp
  801645:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801648:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80164b:	c9                   	leave  
  80164c:	c3                   	ret    

0080164d <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80164d:	55                   	push   %ebp
  80164e:	89 e5                	mov    %esp,%ebp
  801650:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801653:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80165a:	eb 06                	jmp    801662 <strlen+0x15>
		n++;
  80165c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80165f:	ff 45 08             	incl   0x8(%ebp)
  801662:	8b 45 08             	mov    0x8(%ebp),%eax
  801665:	8a 00                	mov    (%eax),%al
  801667:	84 c0                	test   %al,%al
  801669:	75 f1                	jne    80165c <strlen+0xf>
		n++;
	return n;
  80166b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80166e:	c9                   	leave  
  80166f:	c3                   	ret    

00801670 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801670:	55                   	push   %ebp
  801671:	89 e5                	mov    %esp,%ebp
  801673:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801676:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80167d:	eb 09                	jmp    801688 <strnlen+0x18>
		n++;
  80167f:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801682:	ff 45 08             	incl   0x8(%ebp)
  801685:	ff 4d 0c             	decl   0xc(%ebp)
  801688:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80168c:	74 09                	je     801697 <strnlen+0x27>
  80168e:	8b 45 08             	mov    0x8(%ebp),%eax
  801691:	8a 00                	mov    (%eax),%al
  801693:	84 c0                	test   %al,%al
  801695:	75 e8                	jne    80167f <strnlen+0xf>
		n++;
	return n;
  801697:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80169a:	c9                   	leave  
  80169b:	c3                   	ret    

0080169c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80169c:	55                   	push   %ebp
  80169d:	89 e5                	mov    %esp,%ebp
  80169f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8016a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8016a8:	90                   	nop
  8016a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ac:	8d 50 01             	lea    0x1(%eax),%edx
  8016af:	89 55 08             	mov    %edx,0x8(%ebp)
  8016b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016b5:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016b8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8016bb:	8a 12                	mov    (%edx),%dl
  8016bd:	88 10                	mov    %dl,(%eax)
  8016bf:	8a 00                	mov    (%eax),%al
  8016c1:	84 c0                	test   %al,%al
  8016c3:	75 e4                	jne    8016a9 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8016c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8016c8:	c9                   	leave  
  8016c9:	c3                   	ret    

008016ca <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8016ca:	55                   	push   %ebp
  8016cb:	89 e5                	mov    %esp,%ebp
  8016cd:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8016d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8016d6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8016dd:	eb 1f                	jmp    8016fe <strncpy+0x34>
		*dst++ = *src;
  8016df:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e2:	8d 50 01             	lea    0x1(%eax),%edx
  8016e5:	89 55 08             	mov    %edx,0x8(%ebp)
  8016e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016eb:	8a 12                	mov    (%edx),%dl
  8016ed:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8016ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016f2:	8a 00                	mov    (%eax),%al
  8016f4:	84 c0                	test   %al,%al
  8016f6:	74 03                	je     8016fb <strncpy+0x31>
			src++;
  8016f8:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8016fb:	ff 45 fc             	incl   -0x4(%ebp)
  8016fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801701:	3b 45 10             	cmp    0x10(%ebp),%eax
  801704:	72 d9                	jb     8016df <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801706:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801709:	c9                   	leave  
  80170a:	c3                   	ret    

0080170b <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80170b:	55                   	push   %ebp
  80170c:	89 e5                	mov    %esp,%ebp
  80170e:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801711:	8b 45 08             	mov    0x8(%ebp),%eax
  801714:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801717:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80171b:	74 30                	je     80174d <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80171d:	eb 16                	jmp    801735 <strlcpy+0x2a>
			*dst++ = *src++;
  80171f:	8b 45 08             	mov    0x8(%ebp),%eax
  801722:	8d 50 01             	lea    0x1(%eax),%edx
  801725:	89 55 08             	mov    %edx,0x8(%ebp)
  801728:	8b 55 0c             	mov    0xc(%ebp),%edx
  80172b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80172e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801731:	8a 12                	mov    (%edx),%dl
  801733:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801735:	ff 4d 10             	decl   0x10(%ebp)
  801738:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80173c:	74 09                	je     801747 <strlcpy+0x3c>
  80173e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801741:	8a 00                	mov    (%eax),%al
  801743:	84 c0                	test   %al,%al
  801745:	75 d8                	jne    80171f <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801747:	8b 45 08             	mov    0x8(%ebp),%eax
  80174a:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80174d:	8b 55 08             	mov    0x8(%ebp),%edx
  801750:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801753:	29 c2                	sub    %eax,%edx
  801755:	89 d0                	mov    %edx,%eax
}
  801757:	c9                   	leave  
  801758:	c3                   	ret    

00801759 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801759:	55                   	push   %ebp
  80175a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80175c:	eb 06                	jmp    801764 <strcmp+0xb>
		p++, q++;
  80175e:	ff 45 08             	incl   0x8(%ebp)
  801761:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801764:	8b 45 08             	mov    0x8(%ebp),%eax
  801767:	8a 00                	mov    (%eax),%al
  801769:	84 c0                	test   %al,%al
  80176b:	74 0e                	je     80177b <strcmp+0x22>
  80176d:	8b 45 08             	mov    0x8(%ebp),%eax
  801770:	8a 10                	mov    (%eax),%dl
  801772:	8b 45 0c             	mov    0xc(%ebp),%eax
  801775:	8a 00                	mov    (%eax),%al
  801777:	38 c2                	cmp    %al,%dl
  801779:	74 e3                	je     80175e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80177b:	8b 45 08             	mov    0x8(%ebp),%eax
  80177e:	8a 00                	mov    (%eax),%al
  801780:	0f b6 d0             	movzbl %al,%edx
  801783:	8b 45 0c             	mov    0xc(%ebp),%eax
  801786:	8a 00                	mov    (%eax),%al
  801788:	0f b6 c0             	movzbl %al,%eax
  80178b:	29 c2                	sub    %eax,%edx
  80178d:	89 d0                	mov    %edx,%eax
}
  80178f:	5d                   	pop    %ebp
  801790:	c3                   	ret    

00801791 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801791:	55                   	push   %ebp
  801792:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801794:	eb 09                	jmp    80179f <strncmp+0xe>
		n--, p++, q++;
  801796:	ff 4d 10             	decl   0x10(%ebp)
  801799:	ff 45 08             	incl   0x8(%ebp)
  80179c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80179f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017a3:	74 17                	je     8017bc <strncmp+0x2b>
  8017a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a8:	8a 00                	mov    (%eax),%al
  8017aa:	84 c0                	test   %al,%al
  8017ac:	74 0e                	je     8017bc <strncmp+0x2b>
  8017ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b1:	8a 10                	mov    (%eax),%dl
  8017b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b6:	8a 00                	mov    (%eax),%al
  8017b8:	38 c2                	cmp    %al,%dl
  8017ba:	74 da                	je     801796 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8017bc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017c0:	75 07                	jne    8017c9 <strncmp+0x38>
		return 0;
  8017c2:	b8 00 00 00 00       	mov    $0x0,%eax
  8017c7:	eb 14                	jmp    8017dd <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8017c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cc:	8a 00                	mov    (%eax),%al
  8017ce:	0f b6 d0             	movzbl %al,%edx
  8017d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017d4:	8a 00                	mov    (%eax),%al
  8017d6:	0f b6 c0             	movzbl %al,%eax
  8017d9:	29 c2                	sub    %eax,%edx
  8017db:	89 d0                	mov    %edx,%eax
}
  8017dd:	5d                   	pop    %ebp
  8017de:	c3                   	ret    

008017df <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8017df:	55                   	push   %ebp
  8017e0:	89 e5                	mov    %esp,%ebp
  8017e2:	83 ec 04             	sub    $0x4,%esp
  8017e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017e8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8017eb:	eb 12                	jmp    8017ff <strchr+0x20>
		if (*s == c)
  8017ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f0:	8a 00                	mov    (%eax),%al
  8017f2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8017f5:	75 05                	jne    8017fc <strchr+0x1d>
			return (char *) s;
  8017f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fa:	eb 11                	jmp    80180d <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8017fc:	ff 45 08             	incl   0x8(%ebp)
  8017ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801802:	8a 00                	mov    (%eax),%al
  801804:	84 c0                	test   %al,%al
  801806:	75 e5                	jne    8017ed <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801808:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80180d:	c9                   	leave  
  80180e:	c3                   	ret    

0080180f <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80180f:	55                   	push   %ebp
  801810:	89 e5                	mov    %esp,%ebp
  801812:	83 ec 04             	sub    $0x4,%esp
  801815:	8b 45 0c             	mov    0xc(%ebp),%eax
  801818:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80181b:	eb 0d                	jmp    80182a <strfind+0x1b>
		if (*s == c)
  80181d:	8b 45 08             	mov    0x8(%ebp),%eax
  801820:	8a 00                	mov    (%eax),%al
  801822:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801825:	74 0e                	je     801835 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801827:	ff 45 08             	incl   0x8(%ebp)
  80182a:	8b 45 08             	mov    0x8(%ebp),%eax
  80182d:	8a 00                	mov    (%eax),%al
  80182f:	84 c0                	test   %al,%al
  801831:	75 ea                	jne    80181d <strfind+0xe>
  801833:	eb 01                	jmp    801836 <strfind+0x27>
		if (*s == c)
			break;
  801835:	90                   	nop
	return (char *) s;
  801836:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801839:	c9                   	leave  
  80183a:	c3                   	ret    

0080183b <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80183b:	55                   	push   %ebp
  80183c:	89 e5                	mov    %esp,%ebp
  80183e:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801841:	8b 45 08             	mov    0x8(%ebp),%eax
  801844:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801847:	8b 45 10             	mov    0x10(%ebp),%eax
  80184a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80184d:	eb 0e                	jmp    80185d <memset+0x22>
		*p++ = c;
  80184f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801852:	8d 50 01             	lea    0x1(%eax),%edx
  801855:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801858:	8b 55 0c             	mov    0xc(%ebp),%edx
  80185b:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80185d:	ff 4d f8             	decl   -0x8(%ebp)
  801860:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801864:	79 e9                	jns    80184f <memset+0x14>
		*p++ = c;

	return v;
  801866:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801869:	c9                   	leave  
  80186a:	c3                   	ret    

0080186b <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80186b:	55                   	push   %ebp
  80186c:	89 e5                	mov    %esp,%ebp
  80186e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801871:	8b 45 0c             	mov    0xc(%ebp),%eax
  801874:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801877:	8b 45 08             	mov    0x8(%ebp),%eax
  80187a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80187d:	eb 16                	jmp    801895 <memcpy+0x2a>
		*d++ = *s++;
  80187f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801882:	8d 50 01             	lea    0x1(%eax),%edx
  801885:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801888:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80188b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80188e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801891:	8a 12                	mov    (%edx),%dl
  801893:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801895:	8b 45 10             	mov    0x10(%ebp),%eax
  801898:	8d 50 ff             	lea    -0x1(%eax),%edx
  80189b:	89 55 10             	mov    %edx,0x10(%ebp)
  80189e:	85 c0                	test   %eax,%eax
  8018a0:	75 dd                	jne    80187f <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8018a2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8018a5:	c9                   	leave  
  8018a6:	c3                   	ret    

008018a7 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8018a7:	55                   	push   %ebp
  8018a8:	89 e5                	mov    %esp,%ebp
  8018aa:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8018ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8018b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8018b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018bc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8018bf:	73 50                	jae    801911 <memmove+0x6a>
  8018c1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8018c7:	01 d0                	add    %edx,%eax
  8018c9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8018cc:	76 43                	jbe    801911 <memmove+0x6a>
		s += n;
  8018ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8018d1:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8018d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8018d7:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8018da:	eb 10                	jmp    8018ec <memmove+0x45>
			*--d = *--s;
  8018dc:	ff 4d f8             	decl   -0x8(%ebp)
  8018df:	ff 4d fc             	decl   -0x4(%ebp)
  8018e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018e5:	8a 10                	mov    (%eax),%dl
  8018e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018ea:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8018ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ef:	8d 50 ff             	lea    -0x1(%eax),%edx
  8018f2:	89 55 10             	mov    %edx,0x10(%ebp)
  8018f5:	85 c0                	test   %eax,%eax
  8018f7:	75 e3                	jne    8018dc <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8018f9:	eb 23                	jmp    80191e <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8018fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018fe:	8d 50 01             	lea    0x1(%eax),%edx
  801901:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801904:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801907:	8d 4a 01             	lea    0x1(%edx),%ecx
  80190a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80190d:	8a 12                	mov    (%edx),%dl
  80190f:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801911:	8b 45 10             	mov    0x10(%ebp),%eax
  801914:	8d 50 ff             	lea    -0x1(%eax),%edx
  801917:	89 55 10             	mov    %edx,0x10(%ebp)
  80191a:	85 c0                	test   %eax,%eax
  80191c:	75 dd                	jne    8018fb <memmove+0x54>
			*d++ = *s++;

	return dst;
  80191e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801921:	c9                   	leave  
  801922:	c3                   	ret    

00801923 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801923:	55                   	push   %ebp
  801924:	89 e5                	mov    %esp,%ebp
  801926:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801929:	8b 45 08             	mov    0x8(%ebp),%eax
  80192c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80192f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801932:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801935:	eb 2a                	jmp    801961 <memcmp+0x3e>
		if (*s1 != *s2)
  801937:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80193a:	8a 10                	mov    (%eax),%dl
  80193c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80193f:	8a 00                	mov    (%eax),%al
  801941:	38 c2                	cmp    %al,%dl
  801943:	74 16                	je     80195b <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801945:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801948:	8a 00                	mov    (%eax),%al
  80194a:	0f b6 d0             	movzbl %al,%edx
  80194d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801950:	8a 00                	mov    (%eax),%al
  801952:	0f b6 c0             	movzbl %al,%eax
  801955:	29 c2                	sub    %eax,%edx
  801957:	89 d0                	mov    %edx,%eax
  801959:	eb 18                	jmp    801973 <memcmp+0x50>
		s1++, s2++;
  80195b:	ff 45 fc             	incl   -0x4(%ebp)
  80195e:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801961:	8b 45 10             	mov    0x10(%ebp),%eax
  801964:	8d 50 ff             	lea    -0x1(%eax),%edx
  801967:	89 55 10             	mov    %edx,0x10(%ebp)
  80196a:	85 c0                	test   %eax,%eax
  80196c:	75 c9                	jne    801937 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80196e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801973:	c9                   	leave  
  801974:	c3                   	ret    

00801975 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801975:	55                   	push   %ebp
  801976:	89 e5                	mov    %esp,%ebp
  801978:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80197b:	8b 55 08             	mov    0x8(%ebp),%edx
  80197e:	8b 45 10             	mov    0x10(%ebp),%eax
  801981:	01 d0                	add    %edx,%eax
  801983:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801986:	eb 15                	jmp    80199d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801988:	8b 45 08             	mov    0x8(%ebp),%eax
  80198b:	8a 00                	mov    (%eax),%al
  80198d:	0f b6 d0             	movzbl %al,%edx
  801990:	8b 45 0c             	mov    0xc(%ebp),%eax
  801993:	0f b6 c0             	movzbl %al,%eax
  801996:	39 c2                	cmp    %eax,%edx
  801998:	74 0d                	je     8019a7 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80199a:	ff 45 08             	incl   0x8(%ebp)
  80199d:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8019a3:	72 e3                	jb     801988 <memfind+0x13>
  8019a5:	eb 01                	jmp    8019a8 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8019a7:	90                   	nop
	return (void *) s;
  8019a8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8019ab:	c9                   	leave  
  8019ac:	c3                   	ret    

008019ad <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8019ad:	55                   	push   %ebp
  8019ae:	89 e5                	mov    %esp,%ebp
  8019b0:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8019b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8019ba:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8019c1:	eb 03                	jmp    8019c6 <strtol+0x19>
		s++;
  8019c3:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8019c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c9:	8a 00                	mov    (%eax),%al
  8019cb:	3c 20                	cmp    $0x20,%al
  8019cd:	74 f4                	je     8019c3 <strtol+0x16>
  8019cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d2:	8a 00                	mov    (%eax),%al
  8019d4:	3c 09                	cmp    $0x9,%al
  8019d6:	74 eb                	je     8019c3 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8019d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019db:	8a 00                	mov    (%eax),%al
  8019dd:	3c 2b                	cmp    $0x2b,%al
  8019df:	75 05                	jne    8019e6 <strtol+0x39>
		s++;
  8019e1:	ff 45 08             	incl   0x8(%ebp)
  8019e4:	eb 13                	jmp    8019f9 <strtol+0x4c>
	else if (*s == '-')
  8019e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e9:	8a 00                	mov    (%eax),%al
  8019eb:	3c 2d                	cmp    $0x2d,%al
  8019ed:	75 0a                	jne    8019f9 <strtol+0x4c>
		s++, neg = 1;
  8019ef:	ff 45 08             	incl   0x8(%ebp)
  8019f2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8019f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8019fd:	74 06                	je     801a05 <strtol+0x58>
  8019ff:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801a03:	75 20                	jne    801a25 <strtol+0x78>
  801a05:	8b 45 08             	mov    0x8(%ebp),%eax
  801a08:	8a 00                	mov    (%eax),%al
  801a0a:	3c 30                	cmp    $0x30,%al
  801a0c:	75 17                	jne    801a25 <strtol+0x78>
  801a0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a11:	40                   	inc    %eax
  801a12:	8a 00                	mov    (%eax),%al
  801a14:	3c 78                	cmp    $0x78,%al
  801a16:	75 0d                	jne    801a25 <strtol+0x78>
		s += 2, base = 16;
  801a18:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801a1c:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801a23:	eb 28                	jmp    801a4d <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801a25:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801a29:	75 15                	jne    801a40 <strtol+0x93>
  801a2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2e:	8a 00                	mov    (%eax),%al
  801a30:	3c 30                	cmp    $0x30,%al
  801a32:	75 0c                	jne    801a40 <strtol+0x93>
		s++, base = 8;
  801a34:	ff 45 08             	incl   0x8(%ebp)
  801a37:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801a3e:	eb 0d                	jmp    801a4d <strtol+0xa0>
	else if (base == 0)
  801a40:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801a44:	75 07                	jne    801a4d <strtol+0xa0>
		base = 10;
  801a46:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801a4d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a50:	8a 00                	mov    (%eax),%al
  801a52:	3c 2f                	cmp    $0x2f,%al
  801a54:	7e 19                	jle    801a6f <strtol+0xc2>
  801a56:	8b 45 08             	mov    0x8(%ebp),%eax
  801a59:	8a 00                	mov    (%eax),%al
  801a5b:	3c 39                	cmp    $0x39,%al
  801a5d:	7f 10                	jg     801a6f <strtol+0xc2>
			dig = *s - '0';
  801a5f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a62:	8a 00                	mov    (%eax),%al
  801a64:	0f be c0             	movsbl %al,%eax
  801a67:	83 e8 30             	sub    $0x30,%eax
  801a6a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801a6d:	eb 42                	jmp    801ab1 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a72:	8a 00                	mov    (%eax),%al
  801a74:	3c 60                	cmp    $0x60,%al
  801a76:	7e 19                	jle    801a91 <strtol+0xe4>
  801a78:	8b 45 08             	mov    0x8(%ebp),%eax
  801a7b:	8a 00                	mov    (%eax),%al
  801a7d:	3c 7a                	cmp    $0x7a,%al
  801a7f:	7f 10                	jg     801a91 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801a81:	8b 45 08             	mov    0x8(%ebp),%eax
  801a84:	8a 00                	mov    (%eax),%al
  801a86:	0f be c0             	movsbl %al,%eax
  801a89:	83 e8 57             	sub    $0x57,%eax
  801a8c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801a8f:	eb 20                	jmp    801ab1 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801a91:	8b 45 08             	mov    0x8(%ebp),%eax
  801a94:	8a 00                	mov    (%eax),%al
  801a96:	3c 40                	cmp    $0x40,%al
  801a98:	7e 39                	jle    801ad3 <strtol+0x126>
  801a9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9d:	8a 00                	mov    (%eax),%al
  801a9f:	3c 5a                	cmp    $0x5a,%al
  801aa1:	7f 30                	jg     801ad3 <strtol+0x126>
			dig = *s - 'A' + 10;
  801aa3:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa6:	8a 00                	mov    (%eax),%al
  801aa8:	0f be c0             	movsbl %al,%eax
  801aab:	83 e8 37             	sub    $0x37,%eax
  801aae:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801ab1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ab4:	3b 45 10             	cmp    0x10(%ebp),%eax
  801ab7:	7d 19                	jge    801ad2 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801ab9:	ff 45 08             	incl   0x8(%ebp)
  801abc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801abf:	0f af 45 10          	imul   0x10(%ebp),%eax
  801ac3:	89 c2                	mov    %eax,%edx
  801ac5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801ac8:	01 d0                	add    %edx,%eax
  801aca:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801acd:	e9 7b ff ff ff       	jmp    801a4d <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801ad2:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801ad3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801ad7:	74 08                	je     801ae1 <strtol+0x134>
		*endptr = (char *) s;
  801ad9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801adc:	8b 55 08             	mov    0x8(%ebp),%edx
  801adf:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801ae1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801ae5:	74 07                	je     801aee <strtol+0x141>
  801ae7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801aea:	f7 d8                	neg    %eax
  801aec:	eb 03                	jmp    801af1 <strtol+0x144>
  801aee:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801af1:	c9                   	leave  
  801af2:	c3                   	ret    

00801af3 <ltostr>:

void
ltostr(long value, char *str)
{
  801af3:	55                   	push   %ebp
  801af4:	89 e5                	mov    %esp,%ebp
  801af6:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801af9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801b00:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801b07:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801b0b:	79 13                	jns    801b20 <ltostr+0x2d>
	{
		neg = 1;
  801b0d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801b14:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b17:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801b1a:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801b1d:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801b20:	8b 45 08             	mov    0x8(%ebp),%eax
  801b23:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801b28:	99                   	cltd   
  801b29:	f7 f9                	idiv   %ecx
  801b2b:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801b2e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b31:	8d 50 01             	lea    0x1(%eax),%edx
  801b34:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801b37:	89 c2                	mov    %eax,%edx
  801b39:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b3c:	01 d0                	add    %edx,%eax
  801b3e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801b41:	83 c2 30             	add    $0x30,%edx
  801b44:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801b46:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b49:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801b4e:	f7 e9                	imul   %ecx
  801b50:	c1 fa 02             	sar    $0x2,%edx
  801b53:	89 c8                	mov    %ecx,%eax
  801b55:	c1 f8 1f             	sar    $0x1f,%eax
  801b58:	29 c2                	sub    %eax,%edx
  801b5a:	89 d0                	mov    %edx,%eax
  801b5c:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801b5f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b62:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801b67:	f7 e9                	imul   %ecx
  801b69:	c1 fa 02             	sar    $0x2,%edx
  801b6c:	89 c8                	mov    %ecx,%eax
  801b6e:	c1 f8 1f             	sar    $0x1f,%eax
  801b71:	29 c2                	sub    %eax,%edx
  801b73:	89 d0                	mov    %edx,%eax
  801b75:	c1 e0 02             	shl    $0x2,%eax
  801b78:	01 d0                	add    %edx,%eax
  801b7a:	01 c0                	add    %eax,%eax
  801b7c:	29 c1                	sub    %eax,%ecx
  801b7e:	89 ca                	mov    %ecx,%edx
  801b80:	85 d2                	test   %edx,%edx
  801b82:	75 9c                	jne    801b20 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801b84:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801b8b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b8e:	48                   	dec    %eax
  801b8f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801b92:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801b96:	74 3d                	je     801bd5 <ltostr+0xe2>
		start = 1 ;
  801b98:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801b9f:	eb 34                	jmp    801bd5 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801ba1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801ba4:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ba7:	01 d0                	add    %edx,%eax
  801ba9:	8a 00                	mov    (%eax),%al
  801bab:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801bae:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801bb1:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bb4:	01 c2                	add    %eax,%edx
  801bb6:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801bb9:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bbc:	01 c8                	add    %ecx,%eax
  801bbe:	8a 00                	mov    (%eax),%al
  801bc0:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801bc2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801bc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  801bc8:	01 c2                	add    %eax,%edx
  801bca:	8a 45 eb             	mov    -0x15(%ebp),%al
  801bcd:	88 02                	mov    %al,(%edx)
		start++ ;
  801bcf:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801bd2:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801bd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801bd8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801bdb:	7c c4                	jl     801ba1 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801bdd:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801be0:	8b 45 0c             	mov    0xc(%ebp),%eax
  801be3:	01 d0                	add    %edx,%eax
  801be5:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801be8:	90                   	nop
  801be9:	c9                   	leave  
  801bea:	c3                   	ret    

00801beb <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801beb:	55                   	push   %ebp
  801bec:	89 e5                	mov    %esp,%ebp
  801bee:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801bf1:	ff 75 08             	pushl  0x8(%ebp)
  801bf4:	e8 54 fa ff ff       	call   80164d <strlen>
  801bf9:	83 c4 04             	add    $0x4,%esp
  801bfc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801bff:	ff 75 0c             	pushl  0xc(%ebp)
  801c02:	e8 46 fa ff ff       	call   80164d <strlen>
  801c07:	83 c4 04             	add    $0x4,%esp
  801c0a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801c0d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801c14:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801c1b:	eb 17                	jmp    801c34 <strcconcat+0x49>
		final[s] = str1[s] ;
  801c1d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c20:	8b 45 10             	mov    0x10(%ebp),%eax
  801c23:	01 c2                	add    %eax,%edx
  801c25:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801c28:	8b 45 08             	mov    0x8(%ebp),%eax
  801c2b:	01 c8                	add    %ecx,%eax
  801c2d:	8a 00                	mov    (%eax),%al
  801c2f:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801c31:	ff 45 fc             	incl   -0x4(%ebp)
  801c34:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c37:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801c3a:	7c e1                	jl     801c1d <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801c3c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801c43:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801c4a:	eb 1f                	jmp    801c6b <strcconcat+0x80>
		final[s++] = str2[i] ;
  801c4c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801c4f:	8d 50 01             	lea    0x1(%eax),%edx
  801c52:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801c55:	89 c2                	mov    %eax,%edx
  801c57:	8b 45 10             	mov    0x10(%ebp),%eax
  801c5a:	01 c2                	add    %eax,%edx
  801c5c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801c5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801c62:	01 c8                	add    %ecx,%eax
  801c64:	8a 00                	mov    (%eax),%al
  801c66:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801c68:	ff 45 f8             	incl   -0x8(%ebp)
  801c6b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801c6e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801c71:	7c d9                	jl     801c4c <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801c73:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c76:	8b 45 10             	mov    0x10(%ebp),%eax
  801c79:	01 d0                	add    %edx,%eax
  801c7b:	c6 00 00             	movb   $0x0,(%eax)
}
  801c7e:	90                   	nop
  801c7f:	c9                   	leave  
  801c80:	c3                   	ret    

00801c81 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801c81:	55                   	push   %ebp
  801c82:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801c84:	8b 45 14             	mov    0x14(%ebp),%eax
  801c87:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801c8d:	8b 45 14             	mov    0x14(%ebp),%eax
  801c90:	8b 00                	mov    (%eax),%eax
  801c92:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801c99:	8b 45 10             	mov    0x10(%ebp),%eax
  801c9c:	01 d0                	add    %edx,%eax
  801c9e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801ca4:	eb 0c                	jmp    801cb2 <strsplit+0x31>
			*string++ = 0;
  801ca6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca9:	8d 50 01             	lea    0x1(%eax),%edx
  801cac:	89 55 08             	mov    %edx,0x8(%ebp)
  801caf:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801cb2:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb5:	8a 00                	mov    (%eax),%al
  801cb7:	84 c0                	test   %al,%al
  801cb9:	74 18                	je     801cd3 <strsplit+0x52>
  801cbb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cbe:	8a 00                	mov    (%eax),%al
  801cc0:	0f be c0             	movsbl %al,%eax
  801cc3:	50                   	push   %eax
  801cc4:	ff 75 0c             	pushl  0xc(%ebp)
  801cc7:	e8 13 fb ff ff       	call   8017df <strchr>
  801ccc:	83 c4 08             	add    $0x8,%esp
  801ccf:	85 c0                	test   %eax,%eax
  801cd1:	75 d3                	jne    801ca6 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801cd3:	8b 45 08             	mov    0x8(%ebp),%eax
  801cd6:	8a 00                	mov    (%eax),%al
  801cd8:	84 c0                	test   %al,%al
  801cda:	74 5a                	je     801d36 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801cdc:	8b 45 14             	mov    0x14(%ebp),%eax
  801cdf:	8b 00                	mov    (%eax),%eax
  801ce1:	83 f8 0f             	cmp    $0xf,%eax
  801ce4:	75 07                	jne    801ced <strsplit+0x6c>
		{
			return 0;
  801ce6:	b8 00 00 00 00       	mov    $0x0,%eax
  801ceb:	eb 66                	jmp    801d53 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801ced:	8b 45 14             	mov    0x14(%ebp),%eax
  801cf0:	8b 00                	mov    (%eax),%eax
  801cf2:	8d 48 01             	lea    0x1(%eax),%ecx
  801cf5:	8b 55 14             	mov    0x14(%ebp),%edx
  801cf8:	89 0a                	mov    %ecx,(%edx)
  801cfa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d01:	8b 45 10             	mov    0x10(%ebp),%eax
  801d04:	01 c2                	add    %eax,%edx
  801d06:	8b 45 08             	mov    0x8(%ebp),%eax
  801d09:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801d0b:	eb 03                	jmp    801d10 <strsplit+0x8f>
			string++;
  801d0d:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801d10:	8b 45 08             	mov    0x8(%ebp),%eax
  801d13:	8a 00                	mov    (%eax),%al
  801d15:	84 c0                	test   %al,%al
  801d17:	74 8b                	je     801ca4 <strsplit+0x23>
  801d19:	8b 45 08             	mov    0x8(%ebp),%eax
  801d1c:	8a 00                	mov    (%eax),%al
  801d1e:	0f be c0             	movsbl %al,%eax
  801d21:	50                   	push   %eax
  801d22:	ff 75 0c             	pushl  0xc(%ebp)
  801d25:	e8 b5 fa ff ff       	call   8017df <strchr>
  801d2a:	83 c4 08             	add    $0x8,%esp
  801d2d:	85 c0                	test   %eax,%eax
  801d2f:	74 dc                	je     801d0d <strsplit+0x8c>
			string++;
	}
  801d31:	e9 6e ff ff ff       	jmp    801ca4 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801d36:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801d37:	8b 45 14             	mov    0x14(%ebp),%eax
  801d3a:	8b 00                	mov    (%eax),%eax
  801d3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801d43:	8b 45 10             	mov    0x10(%ebp),%eax
  801d46:	01 d0                	add    %edx,%eax
  801d48:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801d4e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801d53:	c9                   	leave  
  801d54:	c3                   	ret    

00801d55 <malloc>:
int sizeofarray=0;
uint32 addresses[100000];
int changed[100000];
int numOfPages[100000];
void* malloc(uint32 size)
{
  801d55:	55                   	push   %ebp
  801d56:	89 e5                	mov    %esp,%ebp
  801d58:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  801d5b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d5e:	c1 e8 0c             	shr    $0xc,%eax
  801d61:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  801d64:	8b 45 08             	mov    0x8(%ebp),%eax
  801d67:	25 ff 0f 00 00       	and    $0xfff,%eax
  801d6c:	85 c0                	test   %eax,%eax
  801d6e:	74 03                	je     801d73 <malloc+0x1e>
			num++;
  801d70:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  801d73:	a1 04 40 80 00       	mov    0x804004,%eax
  801d78:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  801d7d:	75 73                	jne    801df2 <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  801d7f:	83 ec 08             	sub    $0x8,%esp
  801d82:	ff 75 08             	pushl  0x8(%ebp)
  801d85:	68 00 00 00 80       	push   $0x80000000
  801d8a:	e8 13 05 00 00       	call   8022a2 <sys_allocateMem>
  801d8f:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  801d92:	a1 04 40 80 00       	mov    0x804004,%eax
  801d97:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  801d9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d9d:	c1 e0 0c             	shl    $0xc,%eax
  801da0:	89 c2                	mov    %eax,%edx
  801da2:	a1 04 40 80 00       	mov    0x804004,%eax
  801da7:	01 d0                	add    %edx,%eax
  801da9:	a3 04 40 80 00       	mov    %eax,0x804004
			numOfPages[sizeofarray]=num;
  801dae:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801db3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801db6:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
			addresses[sizeofarray]=last_addres;
  801dbd:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801dc2:	8b 15 04 40 80 00    	mov    0x804004,%edx
  801dc8:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
			changed[sizeofarray]=1;
  801dcf:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801dd4:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  801ddb:	01 00 00 00 
			sizeofarray++;
  801ddf:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801de4:	40                   	inc    %eax
  801de5:	a3 2c 40 80 00       	mov    %eax,0x80402c
			return (void*)return_addres;
  801dea:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801ded:	e9 71 01 00 00       	jmp    801f63 <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  801df2:	a1 28 40 80 00       	mov    0x804028,%eax
  801df7:	85 c0                	test   %eax,%eax
  801df9:	75 71                	jne    801e6c <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  801dfb:	a1 04 40 80 00       	mov    0x804004,%eax
  801e00:	83 ec 08             	sub    $0x8,%esp
  801e03:	ff 75 08             	pushl  0x8(%ebp)
  801e06:	50                   	push   %eax
  801e07:	e8 96 04 00 00       	call   8022a2 <sys_allocateMem>
  801e0c:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  801e0f:	a1 04 40 80 00       	mov    0x804004,%eax
  801e14:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  801e17:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801e1a:	c1 e0 0c             	shl    $0xc,%eax
  801e1d:	89 c2                	mov    %eax,%edx
  801e1f:	a1 04 40 80 00       	mov    0x804004,%eax
  801e24:	01 d0                	add    %edx,%eax
  801e26:	a3 04 40 80 00       	mov    %eax,0x804004
				numOfPages[sizeofarray]=num;
  801e2b:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801e30:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801e33:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
				addresses[sizeofarray]=return_addres;
  801e3a:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801e3f:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801e42:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				changed[sizeofarray]=1;
  801e49:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801e4e:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  801e55:	01 00 00 00 
				sizeofarray++;
  801e59:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801e5e:	40                   	inc    %eax
  801e5f:	a3 2c 40 80 00       	mov    %eax,0x80402c
				return (void*)return_addres;
  801e64:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801e67:	e9 f7 00 00 00       	jmp    801f63 <malloc+0x20e>
			}
			else{
				int count=0;
  801e6c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801e73:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  801e7a:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801e81:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801e88:	eb 7c                	jmp    801f06 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  801e8a:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  801e91:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801e98:	eb 1a                	jmp    801eb4 <malloc+0x15f>
					{
						if(addresses[j]==i)
  801e9a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801e9d:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  801ea4:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801ea7:	75 08                	jne    801eb1 <malloc+0x15c>
						{
							index=j;
  801ea9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801eac:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  801eaf:	eb 0d                	jmp    801ebe <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801eb1:	ff 45 dc             	incl   -0x24(%ebp)
  801eb4:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801eb9:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801ebc:	7c dc                	jl     801e9a <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  801ebe:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801ec2:	75 05                	jne    801ec9 <malloc+0x174>
					{
						count++;
  801ec4:	ff 45 f0             	incl   -0x10(%ebp)
  801ec7:	eb 36                	jmp    801eff <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  801ec9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801ecc:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  801ed3:	85 c0                	test   %eax,%eax
  801ed5:	75 05                	jne    801edc <malloc+0x187>
						{
							count++;
  801ed7:	ff 45 f0             	incl   -0x10(%ebp)
  801eda:	eb 23                	jmp    801eff <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  801edc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801edf:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801ee2:	7d 14                	jge    801ef8 <malloc+0x1a3>
  801ee4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801ee7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801eea:	7c 0c                	jl     801ef8 <malloc+0x1a3>
							{
								min=count;
  801eec:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801eef:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801ef2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801ef5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  801ef8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801eff:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801f06:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801f0d:	0f 86 77 ff ff ff    	jbe    801e8a <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  801f13:	83 ec 08             	sub    $0x8,%esp
  801f16:	ff 75 08             	pushl  0x8(%ebp)
  801f19:	ff 75 e4             	pushl  -0x1c(%ebp)
  801f1c:	e8 81 03 00 00       	call   8022a2 <sys_allocateMem>
  801f21:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  801f24:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801f29:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801f2c:	89 14 85 20 76 8c 00 	mov    %edx,0x8c7620(,%eax,4)
				addresses[sizeofarray]=last_addres;
  801f33:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801f38:	8b 15 04 40 80 00    	mov    0x804004,%edx
  801f3e:	89 14 85 20 41 80 00 	mov    %edx,0x804120(,%eax,4)
				changed[sizeofarray]=1;
  801f45:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801f4a:	c7 04 85 a0 5b 86 00 	movl   $0x1,0x865ba0(,%eax,4)
  801f51:	01 00 00 00 
				sizeofarray++;
  801f55:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801f5a:	40                   	inc    %eax
  801f5b:	a3 2c 40 80 00       	mov    %eax,0x80402c
				return(void*) min_addresss;
  801f60:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801f63:	c9                   	leave  
  801f64:	c3                   	ret    

00801f65 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801f65:	55                   	push   %ebp
  801f66:	89 e5                	mov    %esp,%ebp
  801f68:	83 ec 28             	sub    $0x28,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
  801f6b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f6e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    uint32 size;
    int is_found=0;
  801f71:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    int index;
    for(int i=0;i<sizeofarray;i++){
  801f78:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  801f7f:	eb 30                	jmp    801fb1 <free+0x4c>
    	if(addresses[i]==va&&changed[i]==1){
  801f81:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801f84:	8b 04 85 20 41 80 00 	mov    0x804120(,%eax,4),%eax
  801f8b:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  801f8e:	75 1e                	jne    801fae <free+0x49>
  801f90:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801f93:	8b 04 85 a0 5b 86 00 	mov    0x865ba0(,%eax,4),%eax
  801f9a:	83 f8 01             	cmp    $0x1,%eax
  801f9d:	75 0f                	jne    801fae <free+0x49>
    		is_found=1;
  801f9f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    		index=i;
  801fa6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801fa9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    		break;
  801fac:	eb 0d                	jmp    801fbb <free+0x56>
	//you should get the size of the given allocation using its address
    uint32 va=(uint32)virtual_address;
    uint32 size;
    int is_found=0;
    int index;
    for(int i=0;i<sizeofarray;i++){
  801fae:	ff 45 ec             	incl   -0x14(%ebp)
  801fb1:	a1 2c 40 80 00       	mov    0x80402c,%eax
  801fb6:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  801fb9:	7c c6                	jl     801f81 <free+0x1c>
    		is_found=1;
    		index=i;
    		break;
    	}
    }
    if(is_found==1){
  801fbb:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  801fbf:	75 3a                	jne    801ffb <free+0x96>
    	size=numOfPages[index]*PAGE_SIZE;
  801fc1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801fc4:	8b 04 85 20 76 8c 00 	mov    0x8c7620(,%eax,4),%eax
  801fcb:	c1 e0 0c             	shl    $0xc,%eax
  801fce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    	sys_freeMem(va,size);
  801fd1:	83 ec 08             	sub    $0x8,%esp
  801fd4:	ff 75 e4             	pushl  -0x1c(%ebp)
  801fd7:	ff 75 e8             	pushl  -0x18(%ebp)
  801fda:	e8 a7 02 00 00       	call   802286 <sys_freeMem>
  801fdf:	83 c4 10             	add    $0x10,%esp
    	changed[index]=0;
  801fe2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801fe5:	c7 04 85 a0 5b 86 00 	movl   $0x0,0x865ba0(,%eax,4)
  801fec:	00 00 00 00 
    	changes++;
  801ff0:	a1 28 40 80 00       	mov    0x804028,%eax
  801ff5:	40                   	inc    %eax
  801ff6:	a3 28 40 80 00       	mov    %eax,0x804028
    }


	//refer to the project presentation and documentation for details
}
  801ffb:	90                   	nop
  801ffc:	c9                   	leave  
  801ffd:	c3                   	ret    

00801ffe <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801ffe:	55                   	push   %ebp
  801fff:	89 e5                	mov    %esp,%ebp
  802001:	83 ec 18             	sub    $0x18,%esp
  802004:	8b 45 10             	mov    0x10(%ebp),%eax
  802007:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  80200a:	83 ec 04             	sub    $0x4,%esp
  80200d:	68 10 30 80 00       	push   $0x803010
  802012:	68 9f 00 00 00       	push   $0x9f
  802017:	68 33 30 80 00       	push   $0x803033
  80201c:	e8 08 ed ff ff       	call   800d29 <_panic>

00802021 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  802021:	55                   	push   %ebp
  802022:	89 e5                	mov    %esp,%ebp
  802024:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802027:	83 ec 04             	sub    $0x4,%esp
  80202a:	68 10 30 80 00       	push   $0x803010
  80202f:	68 a5 00 00 00       	push   $0xa5
  802034:	68 33 30 80 00       	push   $0x803033
  802039:	e8 eb ec ff ff       	call   800d29 <_panic>

0080203e <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  80203e:	55                   	push   %ebp
  80203f:	89 e5                	mov    %esp,%ebp
  802041:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802044:	83 ec 04             	sub    $0x4,%esp
  802047:	68 10 30 80 00       	push   $0x803010
  80204c:	68 ab 00 00 00       	push   $0xab
  802051:	68 33 30 80 00       	push   $0x803033
  802056:	e8 ce ec ff ff       	call   800d29 <_panic>

0080205b <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  80205b:	55                   	push   %ebp
  80205c:	89 e5                	mov    %esp,%ebp
  80205e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802061:	83 ec 04             	sub    $0x4,%esp
  802064:	68 10 30 80 00       	push   $0x803010
  802069:	68 b0 00 00 00       	push   $0xb0
  80206e:	68 33 30 80 00       	push   $0x803033
  802073:	e8 b1 ec ff ff       	call   800d29 <_panic>

00802078 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  802078:	55                   	push   %ebp
  802079:	89 e5                	mov    %esp,%ebp
  80207b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80207e:	83 ec 04             	sub    $0x4,%esp
  802081:	68 10 30 80 00       	push   $0x803010
  802086:	68 b6 00 00 00       	push   $0xb6
  80208b:	68 33 30 80 00       	push   $0x803033
  802090:	e8 94 ec ff ff       	call   800d29 <_panic>

00802095 <shrink>:
}
void shrink(uint32 newSize)
{
  802095:	55                   	push   %ebp
  802096:	89 e5                	mov    %esp,%ebp
  802098:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80209b:	83 ec 04             	sub    $0x4,%esp
  80209e:	68 10 30 80 00       	push   $0x803010
  8020a3:	68 ba 00 00 00       	push   $0xba
  8020a8:	68 33 30 80 00       	push   $0x803033
  8020ad:	e8 77 ec ff ff       	call   800d29 <_panic>

008020b2 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8020b2:	55                   	push   %ebp
  8020b3:	89 e5                	mov    %esp,%ebp
  8020b5:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8020b8:	83 ec 04             	sub    $0x4,%esp
  8020bb:	68 10 30 80 00       	push   $0x803010
  8020c0:	68 bf 00 00 00       	push   $0xbf
  8020c5:	68 33 30 80 00       	push   $0x803033
  8020ca:	e8 5a ec ff ff       	call   800d29 <_panic>

008020cf <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8020cf:	55                   	push   %ebp
  8020d0:	89 e5                	mov    %esp,%ebp
  8020d2:	57                   	push   %edi
  8020d3:	56                   	push   %esi
  8020d4:	53                   	push   %ebx
  8020d5:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8020d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8020db:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020de:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020e1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8020e4:	8b 7d 18             	mov    0x18(%ebp),%edi
  8020e7:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8020ea:	cd 30                	int    $0x30
  8020ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8020ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8020f2:	83 c4 10             	add    $0x10,%esp
  8020f5:	5b                   	pop    %ebx
  8020f6:	5e                   	pop    %esi
  8020f7:	5f                   	pop    %edi
  8020f8:	5d                   	pop    %ebp
  8020f9:	c3                   	ret    

008020fa <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8020fa:	55                   	push   %ebp
  8020fb:	89 e5                	mov    %esp,%ebp
  8020fd:	83 ec 04             	sub    $0x4,%esp
  802100:	8b 45 10             	mov    0x10(%ebp),%eax
  802103:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802106:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80210a:	8b 45 08             	mov    0x8(%ebp),%eax
  80210d:	6a 00                	push   $0x0
  80210f:	6a 00                	push   $0x0
  802111:	52                   	push   %edx
  802112:	ff 75 0c             	pushl  0xc(%ebp)
  802115:	50                   	push   %eax
  802116:	6a 00                	push   $0x0
  802118:	e8 b2 ff ff ff       	call   8020cf <syscall>
  80211d:	83 c4 18             	add    $0x18,%esp
}
  802120:	90                   	nop
  802121:	c9                   	leave  
  802122:	c3                   	ret    

00802123 <sys_cgetc>:

int
sys_cgetc(void)
{
  802123:	55                   	push   %ebp
  802124:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802126:	6a 00                	push   $0x0
  802128:	6a 00                	push   $0x0
  80212a:	6a 00                	push   $0x0
  80212c:	6a 00                	push   $0x0
  80212e:	6a 00                	push   $0x0
  802130:	6a 01                	push   $0x1
  802132:	e8 98 ff ff ff       	call   8020cf <syscall>
  802137:	83 c4 18             	add    $0x18,%esp
}
  80213a:	c9                   	leave  
  80213b:	c3                   	ret    

0080213c <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80213c:	55                   	push   %ebp
  80213d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80213f:	8b 45 08             	mov    0x8(%ebp),%eax
  802142:	6a 00                	push   $0x0
  802144:	6a 00                	push   $0x0
  802146:	6a 00                	push   $0x0
  802148:	6a 00                	push   $0x0
  80214a:	50                   	push   %eax
  80214b:	6a 05                	push   $0x5
  80214d:	e8 7d ff ff ff       	call   8020cf <syscall>
  802152:	83 c4 18             	add    $0x18,%esp
}
  802155:	c9                   	leave  
  802156:	c3                   	ret    

00802157 <sys_getenvid>:

int32 sys_getenvid(void)
{
  802157:	55                   	push   %ebp
  802158:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80215a:	6a 00                	push   $0x0
  80215c:	6a 00                	push   $0x0
  80215e:	6a 00                	push   $0x0
  802160:	6a 00                	push   $0x0
  802162:	6a 00                	push   $0x0
  802164:	6a 02                	push   $0x2
  802166:	e8 64 ff ff ff       	call   8020cf <syscall>
  80216b:	83 c4 18             	add    $0x18,%esp
}
  80216e:	c9                   	leave  
  80216f:	c3                   	ret    

00802170 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  802170:	55                   	push   %ebp
  802171:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  802173:	6a 00                	push   $0x0
  802175:	6a 00                	push   $0x0
  802177:	6a 00                	push   $0x0
  802179:	6a 00                	push   $0x0
  80217b:	6a 00                	push   $0x0
  80217d:	6a 03                	push   $0x3
  80217f:	e8 4b ff ff ff       	call   8020cf <syscall>
  802184:	83 c4 18             	add    $0x18,%esp
}
  802187:	c9                   	leave  
  802188:	c3                   	ret    

00802189 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  802189:	55                   	push   %ebp
  80218a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80218c:	6a 00                	push   $0x0
  80218e:	6a 00                	push   $0x0
  802190:	6a 00                	push   $0x0
  802192:	6a 00                	push   $0x0
  802194:	6a 00                	push   $0x0
  802196:	6a 04                	push   $0x4
  802198:	e8 32 ff ff ff       	call   8020cf <syscall>
  80219d:	83 c4 18             	add    $0x18,%esp
}
  8021a0:	c9                   	leave  
  8021a1:	c3                   	ret    

008021a2 <sys_env_exit>:


void sys_env_exit(void)
{
  8021a2:	55                   	push   %ebp
  8021a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8021a5:	6a 00                	push   $0x0
  8021a7:	6a 00                	push   $0x0
  8021a9:	6a 00                	push   $0x0
  8021ab:	6a 00                	push   $0x0
  8021ad:	6a 00                	push   $0x0
  8021af:	6a 06                	push   $0x6
  8021b1:	e8 19 ff ff ff       	call   8020cf <syscall>
  8021b6:	83 c4 18             	add    $0x18,%esp
}
  8021b9:	90                   	nop
  8021ba:	c9                   	leave  
  8021bb:	c3                   	ret    

008021bc <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8021bc:	55                   	push   %ebp
  8021bd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8021bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c5:	6a 00                	push   $0x0
  8021c7:	6a 00                	push   $0x0
  8021c9:	6a 00                	push   $0x0
  8021cb:	52                   	push   %edx
  8021cc:	50                   	push   %eax
  8021cd:	6a 07                	push   $0x7
  8021cf:	e8 fb fe ff ff       	call   8020cf <syscall>
  8021d4:	83 c4 18             	add    $0x18,%esp
}
  8021d7:	c9                   	leave  
  8021d8:	c3                   	ret    

008021d9 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8021d9:	55                   	push   %ebp
  8021da:	89 e5                	mov    %esp,%ebp
  8021dc:	56                   	push   %esi
  8021dd:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8021de:	8b 75 18             	mov    0x18(%ebp),%esi
  8021e1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8021e4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8021e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8021ed:	56                   	push   %esi
  8021ee:	53                   	push   %ebx
  8021ef:	51                   	push   %ecx
  8021f0:	52                   	push   %edx
  8021f1:	50                   	push   %eax
  8021f2:	6a 08                	push   $0x8
  8021f4:	e8 d6 fe ff ff       	call   8020cf <syscall>
  8021f9:	83 c4 18             	add    $0x18,%esp
}
  8021fc:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8021ff:	5b                   	pop    %ebx
  802200:	5e                   	pop    %esi
  802201:	5d                   	pop    %ebp
  802202:	c3                   	ret    

00802203 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  802203:	55                   	push   %ebp
  802204:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802206:	8b 55 0c             	mov    0xc(%ebp),%edx
  802209:	8b 45 08             	mov    0x8(%ebp),%eax
  80220c:	6a 00                	push   $0x0
  80220e:	6a 00                	push   $0x0
  802210:	6a 00                	push   $0x0
  802212:	52                   	push   %edx
  802213:	50                   	push   %eax
  802214:	6a 09                	push   $0x9
  802216:	e8 b4 fe ff ff       	call   8020cf <syscall>
  80221b:	83 c4 18             	add    $0x18,%esp
}
  80221e:	c9                   	leave  
  80221f:	c3                   	ret    

00802220 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  802220:	55                   	push   %ebp
  802221:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  802223:	6a 00                	push   $0x0
  802225:	6a 00                	push   $0x0
  802227:	6a 00                	push   $0x0
  802229:	ff 75 0c             	pushl  0xc(%ebp)
  80222c:	ff 75 08             	pushl  0x8(%ebp)
  80222f:	6a 0a                	push   $0xa
  802231:	e8 99 fe ff ff       	call   8020cf <syscall>
  802236:	83 c4 18             	add    $0x18,%esp
}
  802239:	c9                   	leave  
  80223a:	c3                   	ret    

0080223b <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80223b:	55                   	push   %ebp
  80223c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80223e:	6a 00                	push   $0x0
  802240:	6a 00                	push   $0x0
  802242:	6a 00                	push   $0x0
  802244:	6a 00                	push   $0x0
  802246:	6a 00                	push   $0x0
  802248:	6a 0b                	push   $0xb
  80224a:	e8 80 fe ff ff       	call   8020cf <syscall>
  80224f:	83 c4 18             	add    $0x18,%esp
}
  802252:	c9                   	leave  
  802253:	c3                   	ret    

00802254 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  802254:	55                   	push   %ebp
  802255:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  802257:	6a 00                	push   $0x0
  802259:	6a 00                	push   $0x0
  80225b:	6a 00                	push   $0x0
  80225d:	6a 00                	push   $0x0
  80225f:	6a 00                	push   $0x0
  802261:	6a 0c                	push   $0xc
  802263:	e8 67 fe ff ff       	call   8020cf <syscall>
  802268:	83 c4 18             	add    $0x18,%esp
}
  80226b:	c9                   	leave  
  80226c:	c3                   	ret    

0080226d <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80226d:	55                   	push   %ebp
  80226e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  802270:	6a 00                	push   $0x0
  802272:	6a 00                	push   $0x0
  802274:	6a 00                	push   $0x0
  802276:	6a 00                	push   $0x0
  802278:	6a 00                	push   $0x0
  80227a:	6a 0d                	push   $0xd
  80227c:	e8 4e fe ff ff       	call   8020cf <syscall>
  802281:	83 c4 18             	add    $0x18,%esp
}
  802284:	c9                   	leave  
  802285:	c3                   	ret    

00802286 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  802286:	55                   	push   %ebp
  802287:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  802289:	6a 00                	push   $0x0
  80228b:	6a 00                	push   $0x0
  80228d:	6a 00                	push   $0x0
  80228f:	ff 75 0c             	pushl  0xc(%ebp)
  802292:	ff 75 08             	pushl  0x8(%ebp)
  802295:	6a 11                	push   $0x11
  802297:	e8 33 fe ff ff       	call   8020cf <syscall>
  80229c:	83 c4 18             	add    $0x18,%esp
	return;
  80229f:	90                   	nop
}
  8022a0:	c9                   	leave  
  8022a1:	c3                   	ret    

008022a2 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8022a2:	55                   	push   %ebp
  8022a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8022a5:	6a 00                	push   $0x0
  8022a7:	6a 00                	push   $0x0
  8022a9:	6a 00                	push   $0x0
  8022ab:	ff 75 0c             	pushl  0xc(%ebp)
  8022ae:	ff 75 08             	pushl  0x8(%ebp)
  8022b1:	6a 12                	push   $0x12
  8022b3:	e8 17 fe ff ff       	call   8020cf <syscall>
  8022b8:	83 c4 18             	add    $0x18,%esp
	return ;
  8022bb:	90                   	nop
}
  8022bc:	c9                   	leave  
  8022bd:	c3                   	ret    

008022be <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8022be:	55                   	push   %ebp
  8022bf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8022c1:	6a 00                	push   $0x0
  8022c3:	6a 00                	push   $0x0
  8022c5:	6a 00                	push   $0x0
  8022c7:	6a 00                	push   $0x0
  8022c9:	6a 00                	push   $0x0
  8022cb:	6a 0e                	push   $0xe
  8022cd:	e8 fd fd ff ff       	call   8020cf <syscall>
  8022d2:	83 c4 18             	add    $0x18,%esp
}
  8022d5:	c9                   	leave  
  8022d6:	c3                   	ret    

008022d7 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8022d7:	55                   	push   %ebp
  8022d8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8022da:	6a 00                	push   $0x0
  8022dc:	6a 00                	push   $0x0
  8022de:	6a 00                	push   $0x0
  8022e0:	6a 00                	push   $0x0
  8022e2:	ff 75 08             	pushl  0x8(%ebp)
  8022e5:	6a 0f                	push   $0xf
  8022e7:	e8 e3 fd ff ff       	call   8020cf <syscall>
  8022ec:	83 c4 18             	add    $0x18,%esp
}
  8022ef:	c9                   	leave  
  8022f0:	c3                   	ret    

008022f1 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8022f1:	55                   	push   %ebp
  8022f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8022f4:	6a 00                	push   $0x0
  8022f6:	6a 00                	push   $0x0
  8022f8:	6a 00                	push   $0x0
  8022fa:	6a 00                	push   $0x0
  8022fc:	6a 00                	push   $0x0
  8022fe:	6a 10                	push   $0x10
  802300:	e8 ca fd ff ff       	call   8020cf <syscall>
  802305:	83 c4 18             	add    $0x18,%esp
}
  802308:	90                   	nop
  802309:	c9                   	leave  
  80230a:	c3                   	ret    

0080230b <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80230b:	55                   	push   %ebp
  80230c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80230e:	6a 00                	push   $0x0
  802310:	6a 00                	push   $0x0
  802312:	6a 00                	push   $0x0
  802314:	6a 00                	push   $0x0
  802316:	6a 00                	push   $0x0
  802318:	6a 14                	push   $0x14
  80231a:	e8 b0 fd ff ff       	call   8020cf <syscall>
  80231f:	83 c4 18             	add    $0x18,%esp
}
  802322:	90                   	nop
  802323:	c9                   	leave  
  802324:	c3                   	ret    

00802325 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802325:	55                   	push   %ebp
  802326:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802328:	6a 00                	push   $0x0
  80232a:	6a 00                	push   $0x0
  80232c:	6a 00                	push   $0x0
  80232e:	6a 00                	push   $0x0
  802330:	6a 00                	push   $0x0
  802332:	6a 15                	push   $0x15
  802334:	e8 96 fd ff ff       	call   8020cf <syscall>
  802339:	83 c4 18             	add    $0x18,%esp
}
  80233c:	90                   	nop
  80233d:	c9                   	leave  
  80233e:	c3                   	ret    

0080233f <sys_cputc>:


void
sys_cputc(const char c)
{
  80233f:	55                   	push   %ebp
  802340:	89 e5                	mov    %esp,%ebp
  802342:	83 ec 04             	sub    $0x4,%esp
  802345:	8b 45 08             	mov    0x8(%ebp),%eax
  802348:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80234b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80234f:	6a 00                	push   $0x0
  802351:	6a 00                	push   $0x0
  802353:	6a 00                	push   $0x0
  802355:	6a 00                	push   $0x0
  802357:	50                   	push   %eax
  802358:	6a 16                	push   $0x16
  80235a:	e8 70 fd ff ff       	call   8020cf <syscall>
  80235f:	83 c4 18             	add    $0x18,%esp
}
  802362:	90                   	nop
  802363:	c9                   	leave  
  802364:	c3                   	ret    

00802365 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  802365:	55                   	push   %ebp
  802366:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  802368:	6a 00                	push   $0x0
  80236a:	6a 00                	push   $0x0
  80236c:	6a 00                	push   $0x0
  80236e:	6a 00                	push   $0x0
  802370:	6a 00                	push   $0x0
  802372:	6a 17                	push   $0x17
  802374:	e8 56 fd ff ff       	call   8020cf <syscall>
  802379:	83 c4 18             	add    $0x18,%esp
}
  80237c:	90                   	nop
  80237d:	c9                   	leave  
  80237e:	c3                   	ret    

0080237f <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80237f:	55                   	push   %ebp
  802380:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  802382:	8b 45 08             	mov    0x8(%ebp),%eax
  802385:	6a 00                	push   $0x0
  802387:	6a 00                	push   $0x0
  802389:	6a 00                	push   $0x0
  80238b:	ff 75 0c             	pushl  0xc(%ebp)
  80238e:	50                   	push   %eax
  80238f:	6a 18                	push   $0x18
  802391:	e8 39 fd ff ff       	call   8020cf <syscall>
  802396:	83 c4 18             	add    $0x18,%esp
}
  802399:	c9                   	leave  
  80239a:	c3                   	ret    

0080239b <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80239b:	55                   	push   %ebp
  80239c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80239e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8023a4:	6a 00                	push   $0x0
  8023a6:	6a 00                	push   $0x0
  8023a8:	6a 00                	push   $0x0
  8023aa:	52                   	push   %edx
  8023ab:	50                   	push   %eax
  8023ac:	6a 1b                	push   $0x1b
  8023ae:	e8 1c fd ff ff       	call   8020cf <syscall>
  8023b3:	83 c4 18             	add    $0x18,%esp
}
  8023b6:	c9                   	leave  
  8023b7:	c3                   	ret    

008023b8 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8023b8:	55                   	push   %ebp
  8023b9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8023bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023be:	8b 45 08             	mov    0x8(%ebp),%eax
  8023c1:	6a 00                	push   $0x0
  8023c3:	6a 00                	push   $0x0
  8023c5:	6a 00                	push   $0x0
  8023c7:	52                   	push   %edx
  8023c8:	50                   	push   %eax
  8023c9:	6a 19                	push   $0x19
  8023cb:	e8 ff fc ff ff       	call   8020cf <syscall>
  8023d0:	83 c4 18             	add    $0x18,%esp
}
  8023d3:	90                   	nop
  8023d4:	c9                   	leave  
  8023d5:	c3                   	ret    

008023d6 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8023d6:	55                   	push   %ebp
  8023d7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8023d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8023df:	6a 00                	push   $0x0
  8023e1:	6a 00                	push   $0x0
  8023e3:	6a 00                	push   $0x0
  8023e5:	52                   	push   %edx
  8023e6:	50                   	push   %eax
  8023e7:	6a 1a                	push   $0x1a
  8023e9:	e8 e1 fc ff ff       	call   8020cf <syscall>
  8023ee:	83 c4 18             	add    $0x18,%esp
}
  8023f1:	90                   	nop
  8023f2:	c9                   	leave  
  8023f3:	c3                   	ret    

008023f4 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8023f4:	55                   	push   %ebp
  8023f5:	89 e5                	mov    %esp,%ebp
  8023f7:	83 ec 04             	sub    $0x4,%esp
  8023fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8023fd:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802400:	8b 4d 14             	mov    0x14(%ebp),%ecx
  802403:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802407:	8b 45 08             	mov    0x8(%ebp),%eax
  80240a:	6a 00                	push   $0x0
  80240c:	51                   	push   %ecx
  80240d:	52                   	push   %edx
  80240e:	ff 75 0c             	pushl  0xc(%ebp)
  802411:	50                   	push   %eax
  802412:	6a 1c                	push   $0x1c
  802414:	e8 b6 fc ff ff       	call   8020cf <syscall>
  802419:	83 c4 18             	add    $0x18,%esp
}
  80241c:	c9                   	leave  
  80241d:	c3                   	ret    

0080241e <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80241e:	55                   	push   %ebp
  80241f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802421:	8b 55 0c             	mov    0xc(%ebp),%edx
  802424:	8b 45 08             	mov    0x8(%ebp),%eax
  802427:	6a 00                	push   $0x0
  802429:	6a 00                	push   $0x0
  80242b:	6a 00                	push   $0x0
  80242d:	52                   	push   %edx
  80242e:	50                   	push   %eax
  80242f:	6a 1d                	push   $0x1d
  802431:	e8 99 fc ff ff       	call   8020cf <syscall>
  802436:	83 c4 18             	add    $0x18,%esp
}
  802439:	c9                   	leave  
  80243a:	c3                   	ret    

0080243b <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80243b:	55                   	push   %ebp
  80243c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80243e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802441:	8b 55 0c             	mov    0xc(%ebp),%edx
  802444:	8b 45 08             	mov    0x8(%ebp),%eax
  802447:	6a 00                	push   $0x0
  802449:	6a 00                	push   $0x0
  80244b:	51                   	push   %ecx
  80244c:	52                   	push   %edx
  80244d:	50                   	push   %eax
  80244e:	6a 1e                	push   $0x1e
  802450:	e8 7a fc ff ff       	call   8020cf <syscall>
  802455:	83 c4 18             	add    $0x18,%esp
}
  802458:	c9                   	leave  
  802459:	c3                   	ret    

0080245a <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80245a:	55                   	push   %ebp
  80245b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80245d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802460:	8b 45 08             	mov    0x8(%ebp),%eax
  802463:	6a 00                	push   $0x0
  802465:	6a 00                	push   $0x0
  802467:	6a 00                	push   $0x0
  802469:	52                   	push   %edx
  80246a:	50                   	push   %eax
  80246b:	6a 1f                	push   $0x1f
  80246d:	e8 5d fc ff ff       	call   8020cf <syscall>
  802472:	83 c4 18             	add    $0x18,%esp
}
  802475:	c9                   	leave  
  802476:	c3                   	ret    

00802477 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  802477:	55                   	push   %ebp
  802478:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80247a:	6a 00                	push   $0x0
  80247c:	6a 00                	push   $0x0
  80247e:	6a 00                	push   $0x0
  802480:	6a 00                	push   $0x0
  802482:	6a 00                	push   $0x0
  802484:	6a 20                	push   $0x20
  802486:	e8 44 fc ff ff       	call   8020cf <syscall>
  80248b:	83 c4 18             	add    $0x18,%esp
}
  80248e:	c9                   	leave  
  80248f:	c3                   	ret    

00802490 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802490:	55                   	push   %ebp
  802491:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  802493:	8b 45 08             	mov    0x8(%ebp),%eax
  802496:	6a 00                	push   $0x0
  802498:	ff 75 14             	pushl  0x14(%ebp)
  80249b:	ff 75 10             	pushl  0x10(%ebp)
  80249e:	ff 75 0c             	pushl  0xc(%ebp)
  8024a1:	50                   	push   %eax
  8024a2:	6a 21                	push   $0x21
  8024a4:	e8 26 fc ff ff       	call   8020cf <syscall>
  8024a9:	83 c4 18             	add    $0x18,%esp
}
  8024ac:	c9                   	leave  
  8024ad:	c3                   	ret    

008024ae <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8024ae:	55                   	push   %ebp
  8024af:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8024b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8024b4:	6a 00                	push   $0x0
  8024b6:	6a 00                	push   $0x0
  8024b8:	6a 00                	push   $0x0
  8024ba:	6a 00                	push   $0x0
  8024bc:	50                   	push   %eax
  8024bd:	6a 22                	push   $0x22
  8024bf:	e8 0b fc ff ff       	call   8020cf <syscall>
  8024c4:	83 c4 18             	add    $0x18,%esp
}
  8024c7:	90                   	nop
  8024c8:	c9                   	leave  
  8024c9:	c3                   	ret    

008024ca <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8024ca:	55                   	push   %ebp
  8024cb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8024cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8024d0:	6a 00                	push   $0x0
  8024d2:	6a 00                	push   $0x0
  8024d4:	6a 00                	push   $0x0
  8024d6:	6a 00                	push   $0x0
  8024d8:	50                   	push   %eax
  8024d9:	6a 23                	push   $0x23
  8024db:	e8 ef fb ff ff       	call   8020cf <syscall>
  8024e0:	83 c4 18             	add    $0x18,%esp
}
  8024e3:	90                   	nop
  8024e4:	c9                   	leave  
  8024e5:	c3                   	ret    

008024e6 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8024e6:	55                   	push   %ebp
  8024e7:	89 e5                	mov    %esp,%ebp
  8024e9:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8024ec:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8024ef:	8d 50 04             	lea    0x4(%eax),%edx
  8024f2:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8024f5:	6a 00                	push   $0x0
  8024f7:	6a 00                	push   $0x0
  8024f9:	6a 00                	push   $0x0
  8024fb:	52                   	push   %edx
  8024fc:	50                   	push   %eax
  8024fd:	6a 24                	push   $0x24
  8024ff:	e8 cb fb ff ff       	call   8020cf <syscall>
  802504:	83 c4 18             	add    $0x18,%esp
	return result;
  802507:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80250a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80250d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802510:	89 01                	mov    %eax,(%ecx)
  802512:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802515:	8b 45 08             	mov    0x8(%ebp),%eax
  802518:	c9                   	leave  
  802519:	c2 04 00             	ret    $0x4

0080251c <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80251c:	55                   	push   %ebp
  80251d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80251f:	6a 00                	push   $0x0
  802521:	6a 00                	push   $0x0
  802523:	ff 75 10             	pushl  0x10(%ebp)
  802526:	ff 75 0c             	pushl  0xc(%ebp)
  802529:	ff 75 08             	pushl  0x8(%ebp)
  80252c:	6a 13                	push   $0x13
  80252e:	e8 9c fb ff ff       	call   8020cf <syscall>
  802533:	83 c4 18             	add    $0x18,%esp
	return ;
  802536:	90                   	nop
}
  802537:	c9                   	leave  
  802538:	c3                   	ret    

00802539 <sys_rcr2>:
uint32 sys_rcr2()
{
  802539:	55                   	push   %ebp
  80253a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80253c:	6a 00                	push   $0x0
  80253e:	6a 00                	push   $0x0
  802540:	6a 00                	push   $0x0
  802542:	6a 00                	push   $0x0
  802544:	6a 00                	push   $0x0
  802546:	6a 25                	push   $0x25
  802548:	e8 82 fb ff ff       	call   8020cf <syscall>
  80254d:	83 c4 18             	add    $0x18,%esp
}
  802550:	c9                   	leave  
  802551:	c3                   	ret    

00802552 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802552:	55                   	push   %ebp
  802553:	89 e5                	mov    %esp,%ebp
  802555:	83 ec 04             	sub    $0x4,%esp
  802558:	8b 45 08             	mov    0x8(%ebp),%eax
  80255b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80255e:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802562:	6a 00                	push   $0x0
  802564:	6a 00                	push   $0x0
  802566:	6a 00                	push   $0x0
  802568:	6a 00                	push   $0x0
  80256a:	50                   	push   %eax
  80256b:	6a 26                	push   $0x26
  80256d:	e8 5d fb ff ff       	call   8020cf <syscall>
  802572:	83 c4 18             	add    $0x18,%esp
	return ;
  802575:	90                   	nop
}
  802576:	c9                   	leave  
  802577:	c3                   	ret    

00802578 <rsttst>:
void rsttst()
{
  802578:	55                   	push   %ebp
  802579:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80257b:	6a 00                	push   $0x0
  80257d:	6a 00                	push   $0x0
  80257f:	6a 00                	push   $0x0
  802581:	6a 00                	push   $0x0
  802583:	6a 00                	push   $0x0
  802585:	6a 28                	push   $0x28
  802587:	e8 43 fb ff ff       	call   8020cf <syscall>
  80258c:	83 c4 18             	add    $0x18,%esp
	return ;
  80258f:	90                   	nop
}
  802590:	c9                   	leave  
  802591:	c3                   	ret    

00802592 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802592:	55                   	push   %ebp
  802593:	89 e5                	mov    %esp,%ebp
  802595:	83 ec 04             	sub    $0x4,%esp
  802598:	8b 45 14             	mov    0x14(%ebp),%eax
  80259b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80259e:	8b 55 18             	mov    0x18(%ebp),%edx
  8025a1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8025a5:	52                   	push   %edx
  8025a6:	50                   	push   %eax
  8025a7:	ff 75 10             	pushl  0x10(%ebp)
  8025aa:	ff 75 0c             	pushl  0xc(%ebp)
  8025ad:	ff 75 08             	pushl  0x8(%ebp)
  8025b0:	6a 27                	push   $0x27
  8025b2:	e8 18 fb ff ff       	call   8020cf <syscall>
  8025b7:	83 c4 18             	add    $0x18,%esp
	return ;
  8025ba:	90                   	nop
}
  8025bb:	c9                   	leave  
  8025bc:	c3                   	ret    

008025bd <chktst>:
void chktst(uint32 n)
{
  8025bd:	55                   	push   %ebp
  8025be:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8025c0:	6a 00                	push   $0x0
  8025c2:	6a 00                	push   $0x0
  8025c4:	6a 00                	push   $0x0
  8025c6:	6a 00                	push   $0x0
  8025c8:	ff 75 08             	pushl  0x8(%ebp)
  8025cb:	6a 29                	push   $0x29
  8025cd:	e8 fd fa ff ff       	call   8020cf <syscall>
  8025d2:	83 c4 18             	add    $0x18,%esp
	return ;
  8025d5:	90                   	nop
}
  8025d6:	c9                   	leave  
  8025d7:	c3                   	ret    

008025d8 <inctst>:

void inctst()
{
  8025d8:	55                   	push   %ebp
  8025d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8025db:	6a 00                	push   $0x0
  8025dd:	6a 00                	push   $0x0
  8025df:	6a 00                	push   $0x0
  8025e1:	6a 00                	push   $0x0
  8025e3:	6a 00                	push   $0x0
  8025e5:	6a 2a                	push   $0x2a
  8025e7:	e8 e3 fa ff ff       	call   8020cf <syscall>
  8025ec:	83 c4 18             	add    $0x18,%esp
	return ;
  8025ef:	90                   	nop
}
  8025f0:	c9                   	leave  
  8025f1:	c3                   	ret    

008025f2 <gettst>:
uint32 gettst()
{
  8025f2:	55                   	push   %ebp
  8025f3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8025f5:	6a 00                	push   $0x0
  8025f7:	6a 00                	push   $0x0
  8025f9:	6a 00                	push   $0x0
  8025fb:	6a 00                	push   $0x0
  8025fd:	6a 00                	push   $0x0
  8025ff:	6a 2b                	push   $0x2b
  802601:	e8 c9 fa ff ff       	call   8020cf <syscall>
  802606:	83 c4 18             	add    $0x18,%esp
}
  802609:	c9                   	leave  
  80260a:	c3                   	ret    

0080260b <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80260b:	55                   	push   %ebp
  80260c:	89 e5                	mov    %esp,%ebp
  80260e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802611:	6a 00                	push   $0x0
  802613:	6a 00                	push   $0x0
  802615:	6a 00                	push   $0x0
  802617:	6a 00                	push   $0x0
  802619:	6a 00                	push   $0x0
  80261b:	6a 2c                	push   $0x2c
  80261d:	e8 ad fa ff ff       	call   8020cf <syscall>
  802622:	83 c4 18             	add    $0x18,%esp
  802625:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802628:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80262c:	75 07                	jne    802635 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80262e:	b8 01 00 00 00       	mov    $0x1,%eax
  802633:	eb 05                	jmp    80263a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802635:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80263a:	c9                   	leave  
  80263b:	c3                   	ret    

0080263c <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80263c:	55                   	push   %ebp
  80263d:	89 e5                	mov    %esp,%ebp
  80263f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802642:	6a 00                	push   $0x0
  802644:	6a 00                	push   $0x0
  802646:	6a 00                	push   $0x0
  802648:	6a 00                	push   $0x0
  80264a:	6a 00                	push   $0x0
  80264c:	6a 2c                	push   $0x2c
  80264e:	e8 7c fa ff ff       	call   8020cf <syscall>
  802653:	83 c4 18             	add    $0x18,%esp
  802656:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802659:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80265d:	75 07                	jne    802666 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80265f:	b8 01 00 00 00       	mov    $0x1,%eax
  802664:	eb 05                	jmp    80266b <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802666:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80266b:	c9                   	leave  
  80266c:	c3                   	ret    

0080266d <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80266d:	55                   	push   %ebp
  80266e:	89 e5                	mov    %esp,%ebp
  802670:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802673:	6a 00                	push   $0x0
  802675:	6a 00                	push   $0x0
  802677:	6a 00                	push   $0x0
  802679:	6a 00                	push   $0x0
  80267b:	6a 00                	push   $0x0
  80267d:	6a 2c                	push   $0x2c
  80267f:	e8 4b fa ff ff       	call   8020cf <syscall>
  802684:	83 c4 18             	add    $0x18,%esp
  802687:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80268a:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80268e:	75 07                	jne    802697 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802690:	b8 01 00 00 00       	mov    $0x1,%eax
  802695:	eb 05                	jmp    80269c <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802697:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80269c:	c9                   	leave  
  80269d:	c3                   	ret    

0080269e <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80269e:	55                   	push   %ebp
  80269f:	89 e5                	mov    %esp,%ebp
  8026a1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8026a4:	6a 00                	push   $0x0
  8026a6:	6a 00                	push   $0x0
  8026a8:	6a 00                	push   $0x0
  8026aa:	6a 00                	push   $0x0
  8026ac:	6a 00                	push   $0x0
  8026ae:	6a 2c                	push   $0x2c
  8026b0:	e8 1a fa ff ff       	call   8020cf <syscall>
  8026b5:	83 c4 18             	add    $0x18,%esp
  8026b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8026bb:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8026bf:	75 07                	jne    8026c8 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8026c1:	b8 01 00 00 00       	mov    $0x1,%eax
  8026c6:	eb 05                	jmp    8026cd <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8026c8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8026cd:	c9                   	leave  
  8026ce:	c3                   	ret    

008026cf <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8026cf:	55                   	push   %ebp
  8026d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8026d2:	6a 00                	push   $0x0
  8026d4:	6a 00                	push   $0x0
  8026d6:	6a 00                	push   $0x0
  8026d8:	6a 00                	push   $0x0
  8026da:	ff 75 08             	pushl  0x8(%ebp)
  8026dd:	6a 2d                	push   $0x2d
  8026df:	e8 eb f9 ff ff       	call   8020cf <syscall>
  8026e4:	83 c4 18             	add    $0x18,%esp
	return ;
  8026e7:	90                   	nop
}
  8026e8:	c9                   	leave  
  8026e9:	c3                   	ret    

008026ea <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8026ea:	55                   	push   %ebp
  8026eb:	89 e5                	mov    %esp,%ebp
  8026ed:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8026ee:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8026f1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8026f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8026f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8026fa:	6a 00                	push   $0x0
  8026fc:	53                   	push   %ebx
  8026fd:	51                   	push   %ecx
  8026fe:	52                   	push   %edx
  8026ff:	50                   	push   %eax
  802700:	6a 2e                	push   $0x2e
  802702:	e8 c8 f9 ff ff       	call   8020cf <syscall>
  802707:	83 c4 18             	add    $0x18,%esp
}
  80270a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80270d:	c9                   	leave  
  80270e:	c3                   	ret    

0080270f <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80270f:	55                   	push   %ebp
  802710:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802712:	8b 55 0c             	mov    0xc(%ebp),%edx
  802715:	8b 45 08             	mov    0x8(%ebp),%eax
  802718:	6a 00                	push   $0x0
  80271a:	6a 00                	push   $0x0
  80271c:	6a 00                	push   $0x0
  80271e:	52                   	push   %edx
  80271f:	50                   	push   %eax
  802720:	6a 2f                	push   $0x2f
  802722:	e8 a8 f9 ff ff       	call   8020cf <syscall>
  802727:	83 c4 18             	add    $0x18,%esp
}
  80272a:	c9                   	leave  
  80272b:	c3                   	ret    

0080272c <__udivdi3>:
  80272c:	55                   	push   %ebp
  80272d:	57                   	push   %edi
  80272e:	56                   	push   %esi
  80272f:	53                   	push   %ebx
  802730:	83 ec 1c             	sub    $0x1c,%esp
  802733:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802737:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80273b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80273f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802743:	89 ca                	mov    %ecx,%edx
  802745:	89 f8                	mov    %edi,%eax
  802747:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80274b:	85 f6                	test   %esi,%esi
  80274d:	75 2d                	jne    80277c <__udivdi3+0x50>
  80274f:	39 cf                	cmp    %ecx,%edi
  802751:	77 65                	ja     8027b8 <__udivdi3+0x8c>
  802753:	89 fd                	mov    %edi,%ebp
  802755:	85 ff                	test   %edi,%edi
  802757:	75 0b                	jne    802764 <__udivdi3+0x38>
  802759:	b8 01 00 00 00       	mov    $0x1,%eax
  80275e:	31 d2                	xor    %edx,%edx
  802760:	f7 f7                	div    %edi
  802762:	89 c5                	mov    %eax,%ebp
  802764:	31 d2                	xor    %edx,%edx
  802766:	89 c8                	mov    %ecx,%eax
  802768:	f7 f5                	div    %ebp
  80276a:	89 c1                	mov    %eax,%ecx
  80276c:	89 d8                	mov    %ebx,%eax
  80276e:	f7 f5                	div    %ebp
  802770:	89 cf                	mov    %ecx,%edi
  802772:	89 fa                	mov    %edi,%edx
  802774:	83 c4 1c             	add    $0x1c,%esp
  802777:	5b                   	pop    %ebx
  802778:	5e                   	pop    %esi
  802779:	5f                   	pop    %edi
  80277a:	5d                   	pop    %ebp
  80277b:	c3                   	ret    
  80277c:	39 ce                	cmp    %ecx,%esi
  80277e:	77 28                	ja     8027a8 <__udivdi3+0x7c>
  802780:	0f bd fe             	bsr    %esi,%edi
  802783:	83 f7 1f             	xor    $0x1f,%edi
  802786:	75 40                	jne    8027c8 <__udivdi3+0x9c>
  802788:	39 ce                	cmp    %ecx,%esi
  80278a:	72 0a                	jb     802796 <__udivdi3+0x6a>
  80278c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802790:	0f 87 9e 00 00 00    	ja     802834 <__udivdi3+0x108>
  802796:	b8 01 00 00 00       	mov    $0x1,%eax
  80279b:	89 fa                	mov    %edi,%edx
  80279d:	83 c4 1c             	add    $0x1c,%esp
  8027a0:	5b                   	pop    %ebx
  8027a1:	5e                   	pop    %esi
  8027a2:	5f                   	pop    %edi
  8027a3:	5d                   	pop    %ebp
  8027a4:	c3                   	ret    
  8027a5:	8d 76 00             	lea    0x0(%esi),%esi
  8027a8:	31 ff                	xor    %edi,%edi
  8027aa:	31 c0                	xor    %eax,%eax
  8027ac:	89 fa                	mov    %edi,%edx
  8027ae:	83 c4 1c             	add    $0x1c,%esp
  8027b1:	5b                   	pop    %ebx
  8027b2:	5e                   	pop    %esi
  8027b3:	5f                   	pop    %edi
  8027b4:	5d                   	pop    %ebp
  8027b5:	c3                   	ret    
  8027b6:	66 90                	xchg   %ax,%ax
  8027b8:	89 d8                	mov    %ebx,%eax
  8027ba:	f7 f7                	div    %edi
  8027bc:	31 ff                	xor    %edi,%edi
  8027be:	89 fa                	mov    %edi,%edx
  8027c0:	83 c4 1c             	add    $0x1c,%esp
  8027c3:	5b                   	pop    %ebx
  8027c4:	5e                   	pop    %esi
  8027c5:	5f                   	pop    %edi
  8027c6:	5d                   	pop    %ebp
  8027c7:	c3                   	ret    
  8027c8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8027cd:	89 eb                	mov    %ebp,%ebx
  8027cf:	29 fb                	sub    %edi,%ebx
  8027d1:	89 f9                	mov    %edi,%ecx
  8027d3:	d3 e6                	shl    %cl,%esi
  8027d5:	89 c5                	mov    %eax,%ebp
  8027d7:	88 d9                	mov    %bl,%cl
  8027d9:	d3 ed                	shr    %cl,%ebp
  8027db:	89 e9                	mov    %ebp,%ecx
  8027dd:	09 f1                	or     %esi,%ecx
  8027df:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8027e3:	89 f9                	mov    %edi,%ecx
  8027e5:	d3 e0                	shl    %cl,%eax
  8027e7:	89 c5                	mov    %eax,%ebp
  8027e9:	89 d6                	mov    %edx,%esi
  8027eb:	88 d9                	mov    %bl,%cl
  8027ed:	d3 ee                	shr    %cl,%esi
  8027ef:	89 f9                	mov    %edi,%ecx
  8027f1:	d3 e2                	shl    %cl,%edx
  8027f3:	8b 44 24 08          	mov    0x8(%esp),%eax
  8027f7:	88 d9                	mov    %bl,%cl
  8027f9:	d3 e8                	shr    %cl,%eax
  8027fb:	09 c2                	or     %eax,%edx
  8027fd:	89 d0                	mov    %edx,%eax
  8027ff:	89 f2                	mov    %esi,%edx
  802801:	f7 74 24 0c          	divl   0xc(%esp)
  802805:	89 d6                	mov    %edx,%esi
  802807:	89 c3                	mov    %eax,%ebx
  802809:	f7 e5                	mul    %ebp
  80280b:	39 d6                	cmp    %edx,%esi
  80280d:	72 19                	jb     802828 <__udivdi3+0xfc>
  80280f:	74 0b                	je     80281c <__udivdi3+0xf0>
  802811:	89 d8                	mov    %ebx,%eax
  802813:	31 ff                	xor    %edi,%edi
  802815:	e9 58 ff ff ff       	jmp    802772 <__udivdi3+0x46>
  80281a:	66 90                	xchg   %ax,%ax
  80281c:	8b 54 24 08          	mov    0x8(%esp),%edx
  802820:	89 f9                	mov    %edi,%ecx
  802822:	d3 e2                	shl    %cl,%edx
  802824:	39 c2                	cmp    %eax,%edx
  802826:	73 e9                	jae    802811 <__udivdi3+0xe5>
  802828:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80282b:	31 ff                	xor    %edi,%edi
  80282d:	e9 40 ff ff ff       	jmp    802772 <__udivdi3+0x46>
  802832:	66 90                	xchg   %ax,%ax
  802834:	31 c0                	xor    %eax,%eax
  802836:	e9 37 ff ff ff       	jmp    802772 <__udivdi3+0x46>
  80283b:	90                   	nop

0080283c <__umoddi3>:
  80283c:	55                   	push   %ebp
  80283d:	57                   	push   %edi
  80283e:	56                   	push   %esi
  80283f:	53                   	push   %ebx
  802840:	83 ec 1c             	sub    $0x1c,%esp
  802843:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802847:	8b 74 24 34          	mov    0x34(%esp),%esi
  80284b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80284f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802853:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802857:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80285b:	89 f3                	mov    %esi,%ebx
  80285d:	89 fa                	mov    %edi,%edx
  80285f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802863:	89 34 24             	mov    %esi,(%esp)
  802866:	85 c0                	test   %eax,%eax
  802868:	75 1a                	jne    802884 <__umoddi3+0x48>
  80286a:	39 f7                	cmp    %esi,%edi
  80286c:	0f 86 a2 00 00 00    	jbe    802914 <__umoddi3+0xd8>
  802872:	89 c8                	mov    %ecx,%eax
  802874:	89 f2                	mov    %esi,%edx
  802876:	f7 f7                	div    %edi
  802878:	89 d0                	mov    %edx,%eax
  80287a:	31 d2                	xor    %edx,%edx
  80287c:	83 c4 1c             	add    $0x1c,%esp
  80287f:	5b                   	pop    %ebx
  802880:	5e                   	pop    %esi
  802881:	5f                   	pop    %edi
  802882:	5d                   	pop    %ebp
  802883:	c3                   	ret    
  802884:	39 f0                	cmp    %esi,%eax
  802886:	0f 87 ac 00 00 00    	ja     802938 <__umoddi3+0xfc>
  80288c:	0f bd e8             	bsr    %eax,%ebp
  80288f:	83 f5 1f             	xor    $0x1f,%ebp
  802892:	0f 84 ac 00 00 00    	je     802944 <__umoddi3+0x108>
  802898:	bf 20 00 00 00       	mov    $0x20,%edi
  80289d:	29 ef                	sub    %ebp,%edi
  80289f:	89 fe                	mov    %edi,%esi
  8028a1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8028a5:	89 e9                	mov    %ebp,%ecx
  8028a7:	d3 e0                	shl    %cl,%eax
  8028a9:	89 d7                	mov    %edx,%edi
  8028ab:	89 f1                	mov    %esi,%ecx
  8028ad:	d3 ef                	shr    %cl,%edi
  8028af:	09 c7                	or     %eax,%edi
  8028b1:	89 e9                	mov    %ebp,%ecx
  8028b3:	d3 e2                	shl    %cl,%edx
  8028b5:	89 14 24             	mov    %edx,(%esp)
  8028b8:	89 d8                	mov    %ebx,%eax
  8028ba:	d3 e0                	shl    %cl,%eax
  8028bc:	89 c2                	mov    %eax,%edx
  8028be:	8b 44 24 08          	mov    0x8(%esp),%eax
  8028c2:	d3 e0                	shl    %cl,%eax
  8028c4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8028c8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8028cc:	89 f1                	mov    %esi,%ecx
  8028ce:	d3 e8                	shr    %cl,%eax
  8028d0:	09 d0                	or     %edx,%eax
  8028d2:	d3 eb                	shr    %cl,%ebx
  8028d4:	89 da                	mov    %ebx,%edx
  8028d6:	f7 f7                	div    %edi
  8028d8:	89 d3                	mov    %edx,%ebx
  8028da:	f7 24 24             	mull   (%esp)
  8028dd:	89 c6                	mov    %eax,%esi
  8028df:	89 d1                	mov    %edx,%ecx
  8028e1:	39 d3                	cmp    %edx,%ebx
  8028e3:	0f 82 87 00 00 00    	jb     802970 <__umoddi3+0x134>
  8028e9:	0f 84 91 00 00 00    	je     802980 <__umoddi3+0x144>
  8028ef:	8b 54 24 04          	mov    0x4(%esp),%edx
  8028f3:	29 f2                	sub    %esi,%edx
  8028f5:	19 cb                	sbb    %ecx,%ebx
  8028f7:	89 d8                	mov    %ebx,%eax
  8028f9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8028fd:	d3 e0                	shl    %cl,%eax
  8028ff:	89 e9                	mov    %ebp,%ecx
  802901:	d3 ea                	shr    %cl,%edx
  802903:	09 d0                	or     %edx,%eax
  802905:	89 e9                	mov    %ebp,%ecx
  802907:	d3 eb                	shr    %cl,%ebx
  802909:	89 da                	mov    %ebx,%edx
  80290b:	83 c4 1c             	add    $0x1c,%esp
  80290e:	5b                   	pop    %ebx
  80290f:	5e                   	pop    %esi
  802910:	5f                   	pop    %edi
  802911:	5d                   	pop    %ebp
  802912:	c3                   	ret    
  802913:	90                   	nop
  802914:	89 fd                	mov    %edi,%ebp
  802916:	85 ff                	test   %edi,%edi
  802918:	75 0b                	jne    802925 <__umoddi3+0xe9>
  80291a:	b8 01 00 00 00       	mov    $0x1,%eax
  80291f:	31 d2                	xor    %edx,%edx
  802921:	f7 f7                	div    %edi
  802923:	89 c5                	mov    %eax,%ebp
  802925:	89 f0                	mov    %esi,%eax
  802927:	31 d2                	xor    %edx,%edx
  802929:	f7 f5                	div    %ebp
  80292b:	89 c8                	mov    %ecx,%eax
  80292d:	f7 f5                	div    %ebp
  80292f:	89 d0                	mov    %edx,%eax
  802931:	e9 44 ff ff ff       	jmp    80287a <__umoddi3+0x3e>
  802936:	66 90                	xchg   %ax,%ax
  802938:	89 c8                	mov    %ecx,%eax
  80293a:	89 f2                	mov    %esi,%edx
  80293c:	83 c4 1c             	add    $0x1c,%esp
  80293f:	5b                   	pop    %ebx
  802940:	5e                   	pop    %esi
  802941:	5f                   	pop    %edi
  802942:	5d                   	pop    %ebp
  802943:	c3                   	ret    
  802944:	3b 04 24             	cmp    (%esp),%eax
  802947:	72 06                	jb     80294f <__umoddi3+0x113>
  802949:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80294d:	77 0f                	ja     80295e <__umoddi3+0x122>
  80294f:	89 f2                	mov    %esi,%edx
  802951:	29 f9                	sub    %edi,%ecx
  802953:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802957:	89 14 24             	mov    %edx,(%esp)
  80295a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80295e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802962:	8b 14 24             	mov    (%esp),%edx
  802965:	83 c4 1c             	add    $0x1c,%esp
  802968:	5b                   	pop    %ebx
  802969:	5e                   	pop    %esi
  80296a:	5f                   	pop    %edi
  80296b:	5d                   	pop    %ebp
  80296c:	c3                   	ret    
  80296d:	8d 76 00             	lea    0x0(%esi),%esi
  802970:	2b 04 24             	sub    (%esp),%eax
  802973:	19 fa                	sbb    %edi,%edx
  802975:	89 d1                	mov    %edx,%ecx
  802977:	89 c6                	mov    %eax,%esi
  802979:	e9 71 ff ff ff       	jmp    8028ef <__umoddi3+0xb3>
  80297e:	66 90                	xchg   %ax,%ax
  802980:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802984:	72 ea                	jb     802970 <__umoddi3+0x134>
  802986:	89 d9                	mov    %ebx,%ecx
  802988:	e9 62 ff ff ff       	jmp    8028ef <__umoddi3+0xb3>
