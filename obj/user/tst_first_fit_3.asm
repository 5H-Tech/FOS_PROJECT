
obj/user/tst_first_fit_3:     file format elf32-i386


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
  800031:	e8 94 0d 00 00       	call   800dca <libmain>
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
  800045:	e8 e1 25 00 00       	call   80262b <sys_set_uheap_strategy>
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
  800095:	68 00 29 80 00       	push   $0x802900
  80009a:	6a 16                	push   $0x16
  80009c:	68 1c 29 80 00       	push   $0x80291c
  8000a1:	e8 69 0e 00 00       	call   800f0f <_panic>
	}

	int envID = sys_getenvid();
  8000a6:	e8 08 20 00 00       	call   8020b3 <sys_getenvid>
  8000ab:	89 45 ec             	mov    %eax,-0x14(%ebp)



	int Mega = 1024*1024;
  8000ae:	c7 45 e8 00 00 10 00 	movl   $0x100000,-0x18(%ebp)
	int kilo = 1024;
  8000b5:	c7 45 e4 00 04 00 00 	movl   $0x400,-0x1c(%ebp)
	void* ptr_allocations[20] = {0};
  8000bc:	8d 55 8c             	lea    -0x74(%ebp),%edx
  8000bf:	b9 14 00 00 00       	mov    $0x14,%ecx
  8000c4:	b8 00 00 00 00       	mov    $0x0,%eax
  8000c9:	89 d7                	mov    %edx,%edi
  8000cb:	f3 ab                	rep stos %eax,%es:(%edi)
	int freeFrames ;
	int usedDiskPages;
	//[1] Allocate all
	{
		//Allocate Shared 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8000cd:	e8 c5 20 00 00       	call   802197 <sys_calculate_free_frames>
  8000d2:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8000d5:	e8 40 21 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  8000da:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[0] = smalloc("x", 1*Mega, 1);
  8000dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000e0:	83 ec 04             	sub    $0x4,%esp
  8000e3:	6a 01                	push   $0x1
  8000e5:	50                   	push   %eax
  8000e6:	68 33 29 80 00       	push   $0x802933
  8000eb:	e8 7f 1e 00 00       	call   801f6f <smalloc>
  8000f0:	83 c4 10             	add    $0x10,%esp
  8000f3:	89 45 8c             	mov    %eax,-0x74(%ebp)
		if (ptr_allocations[0] != (uint32*)USER_HEAP_START) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  8000f6:	8b 45 8c             	mov    -0x74(%ebp),%eax
  8000f9:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8000fe:	74 14                	je     800114 <_main+0xdc>
  800100:	83 ec 04             	sub    $0x4,%esp
  800103:	68 38 29 80 00       	push   $0x802938
  800108:	6a 28                	push   $0x28
  80010a:	68 1c 29 80 00       	push   $0x80291c
  80010f:	e8 fb 0d 00 00       	call   800f0f <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  256+1+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800114:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800117:	e8 7b 20 00 00       	call   802197 <sys_calculate_free_frames>
  80011c:	29 c3                	sub    %eax,%ebx
  80011e:	89 d8                	mov    %ebx,%eax
  800120:	3d 03 01 00 00       	cmp    $0x103,%eax
  800125:	74 14                	je     80013b <_main+0x103>
  800127:	83 ec 04             	sub    $0x4,%esp
  80012a:	68 a4 29 80 00       	push   $0x8029a4
  80012f:	6a 29                	push   $0x29
  800131:	68 1c 29 80 00       	push   $0x80291c
  800136:	e8 d4 0d 00 00       	call   800f0f <_panic>
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  80013b:	e8 da 20 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800140:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800143:	74 14                	je     800159 <_main+0x121>
  800145:	83 ec 04             	sub    $0x4,%esp
  800148:	68 22 2a 80 00       	push   $0x802a22
  80014d:	6a 2a                	push   $0x2a
  80014f:	68 1c 29 80 00       	push   $0x80291c
  800154:	e8 b6 0d 00 00       	call   800f0f <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  800159:	e8 39 20 00 00       	call   802197 <sys_calculate_free_frames>
  80015e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800161:	e8 b4 20 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800166:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[1] = malloc(1*Mega-kilo);
  800169:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80016c:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80016f:	83 ec 0c             	sub    $0xc,%esp
  800172:	50                   	push   %eax
  800173:	e8 c3 1d 00 00       	call   801f3b <malloc>
  800178:	83 c4 10             	add    $0x10,%esp
  80017b:	89 45 90             	mov    %eax,-0x70(%ebp)
		if ((uint32) ptr_allocations[1] != (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  80017e:	8b 45 90             	mov    -0x70(%ebp),%eax
  800181:	89 c2                	mov    %eax,%edx
  800183:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800186:	05 00 00 00 80       	add    $0x80000000,%eax
  80018b:	39 c2                	cmp    %eax,%edx
  80018d:	74 14                	je     8001a3 <_main+0x16b>
  80018f:	83 ec 04             	sub    $0x4,%esp
  800192:	68 40 2a 80 00       	push   $0x802a40
  800197:	6a 30                	push   $0x30
  800199:	68 1c 29 80 00       	push   $0x80291c
  80019e:	e8 6c 0d 00 00       	call   800f0f <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8001a3:	e8 72 20 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  8001a8:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8001ab:	3d 00 01 00 00       	cmp    $0x100,%eax
  8001b0:	74 14                	je     8001c6 <_main+0x18e>
  8001b2:	83 ec 04             	sub    $0x4,%esp
  8001b5:	68 22 2a 80 00       	push   $0x802a22
  8001ba:	6a 32                	push   $0x32
  8001bc:	68 1c 29 80 00       	push   $0x80291c
  8001c1:	e8 49 0d 00 00       	call   800f0f <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1 ) panic("Wrong allocation: ");
  8001c6:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  8001c9:	e8 c9 1f 00 00       	call   802197 <sys_calculate_free_frames>
  8001ce:	29 c3                	sub    %eax,%ebx
  8001d0:	89 d8                	mov    %ebx,%eax
  8001d2:	83 f8 01             	cmp    $0x1,%eax
  8001d5:	74 14                	je     8001eb <_main+0x1b3>
  8001d7:	83 ec 04             	sub    $0x4,%esp
  8001da:	68 70 2a 80 00       	push   $0x802a70
  8001df:	6a 33                	push   $0x33
  8001e1:	68 1c 29 80 00       	push   $0x80291c
  8001e6:	e8 24 0d 00 00       	call   800f0f <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  8001eb:	e8 a7 1f 00 00       	call   802197 <sys_calculate_free_frames>
  8001f0:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8001f3:	e8 22 20 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  8001f8:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[2] = malloc(1*Mega-kilo);
  8001fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8001fe:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800201:	83 ec 0c             	sub    $0xc,%esp
  800204:	50                   	push   %eax
  800205:	e8 31 1d 00 00       	call   801f3b <malloc>
  80020a:	83 c4 10             	add    $0x10,%esp
  80020d:	89 45 94             	mov    %eax,-0x6c(%ebp)
		if ((uint32) ptr_allocations[2] != (USER_HEAP_START + 2*Mega)) panic("Wrong start address for the allocated space... ");
  800210:	8b 45 94             	mov    -0x6c(%ebp),%eax
  800213:	89 c2                	mov    %eax,%edx
  800215:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800218:	01 c0                	add    %eax,%eax
  80021a:	05 00 00 00 80       	add    $0x80000000,%eax
  80021f:	39 c2                	cmp    %eax,%edx
  800221:	74 14                	je     800237 <_main+0x1ff>
  800223:	83 ec 04             	sub    $0x4,%esp
  800226:	68 40 2a 80 00       	push   $0x802a40
  80022b:	6a 39                	push   $0x39
  80022d:	68 1c 29 80 00       	push   $0x80291c
  800232:	e8 d8 0c 00 00       	call   800f0f <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  800237:	e8 de 1f 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  80023c:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80023f:	3d 00 01 00 00       	cmp    $0x100,%eax
  800244:	74 14                	je     80025a <_main+0x222>
  800246:	83 ec 04             	sub    $0x4,%esp
  800249:	68 22 2a 80 00       	push   $0x802a22
  80024e:	6a 3b                	push   $0x3b
  800250:	68 1c 29 80 00       	push   $0x80291c
  800255:	e8 b5 0c 00 00       	call   800f0f <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  80025a:	e8 38 1f 00 00       	call   802197 <sys_calculate_free_frames>
  80025f:	89 c2                	mov    %eax,%edx
  800261:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800264:	39 c2                	cmp    %eax,%edx
  800266:	74 14                	je     80027c <_main+0x244>
  800268:	83 ec 04             	sub    $0x4,%esp
  80026b:	68 70 2a 80 00       	push   $0x802a70
  800270:	6a 3c                	push   $0x3c
  800272:	68 1c 29 80 00       	push   $0x80291c
  800277:	e8 93 0c 00 00       	call   800f0f <_panic>

		//Allocate 1 MB
		freeFrames = sys_calculate_free_frames() ;
  80027c:	e8 16 1f 00 00       	call   802197 <sys_calculate_free_frames>
  800281:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800284:	e8 91 1f 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800289:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[3] = malloc(1*Mega-kilo);
  80028c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80028f:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800292:	83 ec 0c             	sub    $0xc,%esp
  800295:	50                   	push   %eax
  800296:	e8 a0 1c 00 00       	call   801f3b <malloc>
  80029b:	83 c4 10             	add    $0x10,%esp
  80029e:	89 45 98             	mov    %eax,-0x68(%ebp)
		if ((uint32) ptr_allocations[3] != (USER_HEAP_START + 3*Mega) ) panic("Wrong start address for the allocated space... ");
  8002a1:	8b 45 98             	mov    -0x68(%ebp),%eax
  8002a4:	89 c1                	mov    %eax,%ecx
  8002a6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002a9:	89 c2                	mov    %eax,%edx
  8002ab:	01 d2                	add    %edx,%edx
  8002ad:	01 d0                	add    %edx,%eax
  8002af:	05 00 00 00 80       	add    $0x80000000,%eax
  8002b4:	39 c1                	cmp    %eax,%ecx
  8002b6:	74 14                	je     8002cc <_main+0x294>
  8002b8:	83 ec 04             	sub    $0x4,%esp
  8002bb:	68 40 2a 80 00       	push   $0x802a40
  8002c0:	6a 42                	push   $0x42
  8002c2:	68 1c 29 80 00       	push   $0x80291c
  8002c7:	e8 43 0c 00 00       	call   800f0f <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256 ) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8002cc:	e8 49 1f 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  8002d1:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8002d4:	3d 00 01 00 00       	cmp    $0x100,%eax
  8002d9:	74 14                	je     8002ef <_main+0x2b7>
  8002db:	83 ec 04             	sub    $0x4,%esp
  8002de:	68 22 2a 80 00       	push   $0x802a22
  8002e3:	6a 44                	push   $0x44
  8002e5:	68 1c 29 80 00       	push   $0x80291c
  8002ea:	e8 20 0c 00 00       	call   800f0f <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0 ) panic("Wrong allocation: ");
  8002ef:	e8 a3 1e 00 00       	call   802197 <sys_calculate_free_frames>
  8002f4:	89 c2                	mov    %eax,%edx
  8002f6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8002f9:	39 c2                	cmp    %eax,%edx
  8002fb:	74 14                	je     800311 <_main+0x2d9>
  8002fd:	83 ec 04             	sub    $0x4,%esp
  800300:	68 70 2a 80 00       	push   $0x802a70
  800305:	6a 45                	push   $0x45
  800307:	68 1c 29 80 00       	push   $0x80291c
  80030c:	e8 fe 0b 00 00       	call   800f0f <_panic>

		//Allocate 2 MB
		freeFrames = sys_calculate_free_frames() ;
  800311:	e8 81 1e 00 00       	call   802197 <sys_calculate_free_frames>
  800316:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800319:	e8 fc 1e 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  80031e:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[4] = malloc(2*Mega-kilo);
  800321:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800324:	01 c0                	add    %eax,%eax
  800326:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800329:	83 ec 0c             	sub    $0xc,%esp
  80032c:	50                   	push   %eax
  80032d:	e8 09 1c 00 00       	call   801f3b <malloc>
  800332:	83 c4 10             	add    $0x10,%esp
  800335:	89 45 9c             	mov    %eax,-0x64(%ebp)
		if ((uint32) ptr_allocations[4] != (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  800338:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80033b:	89 c2                	mov    %eax,%edx
  80033d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800340:	c1 e0 02             	shl    $0x2,%eax
  800343:	05 00 00 00 80       	add    $0x80000000,%eax
  800348:	39 c2                	cmp    %eax,%edx
  80034a:	74 14                	je     800360 <_main+0x328>
  80034c:	83 ec 04             	sub    $0x4,%esp
  80034f:	68 40 2a 80 00       	push   $0x802a40
  800354:	6a 4b                	push   $0x4b
  800356:	68 1c 29 80 00       	push   $0x80291c
  80035b:	e8 af 0b 00 00       	call   800f0f <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  800360:	e8 b5 1e 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800365:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800368:	3d 00 02 00 00       	cmp    $0x200,%eax
  80036d:	74 14                	je     800383 <_main+0x34b>
  80036f:	83 ec 04             	sub    $0x4,%esp
  800372:	68 22 2a 80 00       	push   $0x802a22
  800377:	6a 4d                	push   $0x4d
  800379:	68 1c 29 80 00       	push   $0x80291c
  80037e:	e8 8c 0b 00 00       	call   800f0f <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  800383:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800386:	e8 0c 1e 00 00       	call   802197 <sys_calculate_free_frames>
  80038b:	29 c3                	sub    %eax,%ebx
  80038d:	89 d8                	mov    %ebx,%eax
  80038f:	83 f8 01             	cmp    $0x1,%eax
  800392:	74 14                	je     8003a8 <_main+0x370>
  800394:	83 ec 04             	sub    $0x4,%esp
  800397:	68 70 2a 80 00       	push   $0x802a70
  80039c:	6a 4e                	push   $0x4e
  80039e:	68 1c 29 80 00       	push   $0x80291c
  8003a3:	e8 67 0b 00 00       	call   800f0f <_panic>

		//Allocate Shared 2 MB
		freeFrames = sys_calculate_free_frames() ;
  8003a8:	e8 ea 1d 00 00       	call   802197 <sys_calculate_free_frames>
  8003ad:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8003b0:	e8 65 1e 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  8003b5:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[5] = smalloc("y", 2*Mega, 1);
  8003b8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8003bb:	01 c0                	add    %eax,%eax
  8003bd:	83 ec 04             	sub    $0x4,%esp
  8003c0:	6a 01                	push   $0x1
  8003c2:	50                   	push   %eax
  8003c3:	68 83 2a 80 00       	push   $0x802a83
  8003c8:	e8 a2 1b 00 00       	call   801f6f <smalloc>
  8003cd:	83 c4 10             	add    $0x10,%esp
  8003d0:	89 45 a0             	mov    %eax,-0x60(%ebp)
		if (ptr_allocations[5] != (uint32*)(USER_HEAP_START + 6*Mega)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  8003d3:	8b 4d a0             	mov    -0x60(%ebp),%ecx
  8003d6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003d9:	89 d0                	mov    %edx,%eax
  8003db:	01 c0                	add    %eax,%eax
  8003dd:	01 d0                	add    %edx,%eax
  8003df:	01 c0                	add    %eax,%eax
  8003e1:	05 00 00 00 80       	add    $0x80000000,%eax
  8003e6:	39 c1                	cmp    %eax,%ecx
  8003e8:	74 14                	je     8003fe <_main+0x3c6>
  8003ea:	83 ec 04             	sub    $0x4,%esp
  8003ed:	68 38 29 80 00       	push   $0x802938
  8003f2:	6a 54                	push   $0x54
  8003f4:	68 1c 29 80 00       	push   $0x80291c
  8003f9:	e8 11 0b 00 00       	call   800f0f <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  512+1+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  8003fe:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800401:	e8 91 1d 00 00       	call   802197 <sys_calculate_free_frames>
  800406:	29 c3                	sub    %eax,%ebx
  800408:	89 d8                	mov    %ebx,%eax
  80040a:	3d 03 02 00 00       	cmp    $0x203,%eax
  80040f:	74 14                	je     800425 <_main+0x3ed>
  800411:	83 ec 04             	sub    $0x4,%esp
  800414:	68 a4 29 80 00       	push   $0x8029a4
  800419:	6a 55                	push   $0x55
  80041b:	68 1c 29 80 00       	push   $0x80291c
  800420:	e8 ea 0a 00 00       	call   800f0f <_panic>
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  800425:	e8 f0 1d 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  80042a:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  80042d:	74 14                	je     800443 <_main+0x40b>
  80042f:	83 ec 04             	sub    $0x4,%esp
  800432:	68 22 2a 80 00       	push   $0x802a22
  800437:	6a 56                	push   $0x56
  800439:	68 1c 29 80 00       	push   $0x80291c
  80043e:	e8 cc 0a 00 00       	call   800f0f <_panic>

		//Allocate 3 MB
		freeFrames = sys_calculate_free_frames() ;
  800443:	e8 4f 1d 00 00       	call   802197 <sys_calculate_free_frames>
  800448:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80044b:	e8 ca 1d 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800450:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[6] = malloc(3*Mega-kilo);
  800453:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800456:	89 c2                	mov    %eax,%edx
  800458:	01 d2                	add    %edx,%edx
  80045a:	01 d0                	add    %edx,%eax
  80045c:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80045f:	83 ec 0c             	sub    $0xc,%esp
  800462:	50                   	push   %eax
  800463:	e8 d3 1a 00 00       	call   801f3b <malloc>
  800468:	83 c4 10             	add    $0x10,%esp
  80046b:	89 45 a4             	mov    %eax,-0x5c(%ebp)
		if ((uint32) ptr_allocations[6] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  80046e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800471:	89 c2                	mov    %eax,%edx
  800473:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800476:	c1 e0 03             	shl    $0x3,%eax
  800479:	05 00 00 00 80       	add    $0x80000000,%eax
  80047e:	39 c2                	cmp    %eax,%edx
  800480:	74 14                	je     800496 <_main+0x45e>
  800482:	83 ec 04             	sub    $0x4,%esp
  800485:	68 40 2a 80 00       	push   $0x802a40
  80048a:	6a 5c                	push   $0x5c
  80048c:	68 1c 29 80 00       	push   $0x80291c
  800491:	e8 79 0a 00 00       	call   800f0f <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 768 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  768) panic("Wrong page file allocation: ");
  800496:	e8 7f 1d 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  80049b:	2b 45 dc             	sub    -0x24(%ebp),%eax
  80049e:	3d 00 03 00 00       	cmp    $0x300,%eax
  8004a3:	74 14                	je     8004b9 <_main+0x481>
  8004a5:	83 ec 04             	sub    $0x4,%esp
  8004a8:	68 22 2a 80 00       	push   $0x802a22
  8004ad:	6a 5e                	push   $0x5e
  8004af:	68 1c 29 80 00       	push   $0x80291c
  8004b4:	e8 56 0a 00 00       	call   800f0f <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 1) panic("Wrong allocation: ");
  8004b9:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  8004bc:	e8 d6 1c 00 00       	call   802197 <sys_calculate_free_frames>
  8004c1:	29 c3                	sub    %eax,%ebx
  8004c3:	89 d8                	mov    %ebx,%eax
  8004c5:	83 f8 01             	cmp    $0x1,%eax
  8004c8:	74 14                	je     8004de <_main+0x4a6>
  8004ca:	83 ec 04             	sub    $0x4,%esp
  8004cd:	68 70 2a 80 00       	push   $0x802a70
  8004d2:	6a 5f                	push   $0x5f
  8004d4:	68 1c 29 80 00       	push   $0x80291c
  8004d9:	e8 31 0a 00 00       	call   800f0f <_panic>

		//Allocate Shared 3 MB
		freeFrames = sys_calculate_free_frames() ;
  8004de:	e8 b4 1c 00 00       	call   802197 <sys_calculate_free_frames>
  8004e3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8004e6:	e8 2f 1d 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  8004eb:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[7] = smalloc("z", 3*Mega, 0);
  8004ee:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8004f1:	89 c2                	mov    %eax,%edx
  8004f3:	01 d2                	add    %edx,%edx
  8004f5:	01 d0                	add    %edx,%eax
  8004f7:	83 ec 04             	sub    $0x4,%esp
  8004fa:	6a 00                	push   $0x0
  8004fc:	50                   	push   %eax
  8004fd:	68 85 2a 80 00       	push   $0x802a85
  800502:	e8 68 1a 00 00       	call   801f6f <smalloc>
  800507:	83 c4 10             	add    $0x10,%esp
  80050a:	89 45 a8             	mov    %eax,-0x58(%ebp)
		if (ptr_allocations[7] != (uint32*)(USER_HEAP_START + 11*Mega)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  80050d:	8b 4d a8             	mov    -0x58(%ebp),%ecx
  800510:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800513:	89 d0                	mov    %edx,%eax
  800515:	c1 e0 02             	shl    $0x2,%eax
  800518:	01 d0                	add    %edx,%eax
  80051a:	01 c0                	add    %eax,%eax
  80051c:	01 d0                	add    %edx,%eax
  80051e:	05 00 00 00 80       	add    $0x80000000,%eax
  800523:	39 c1                	cmp    %eax,%ecx
  800525:	74 14                	je     80053b <_main+0x503>
  800527:	83 ec 04             	sub    $0x4,%esp
  80052a:	68 38 29 80 00       	push   $0x802938
  80052f:	6a 65                	push   $0x65
  800531:	68 1c 29 80 00       	push   $0x80291c
  800536:	e8 d4 09 00 00       	call   800f0f <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  768+2+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  80053b:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  80053e:	e8 54 1c 00 00       	call   802197 <sys_calculate_free_frames>
  800543:	29 c3                	sub    %eax,%ebx
  800545:	89 d8                	mov    %ebx,%eax
  800547:	3d 04 03 00 00       	cmp    $0x304,%eax
  80054c:	74 14                	je     800562 <_main+0x52a>
  80054e:	83 ec 04             	sub    $0x4,%esp
  800551:	68 a4 29 80 00       	push   $0x8029a4
  800556:	6a 66                	push   $0x66
  800558:	68 1c 29 80 00       	push   $0x80291c
  80055d:	e8 ad 09 00 00       	call   800f0f <_panic>
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  800562:	e8 b3 1c 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800567:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  80056a:	74 14                	je     800580 <_main+0x548>
  80056c:	83 ec 04             	sub    $0x4,%esp
  80056f:	68 22 2a 80 00       	push   $0x802a22
  800574:	6a 67                	push   $0x67
  800576:	68 1c 29 80 00       	push   $0x80291c
  80057b:	e8 8f 09 00 00       	call   800f0f <_panic>
	}

	//[2] Free some to create holes
	{
		//1 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800580:	e8 12 1c 00 00       	call   802197 <sys_calculate_free_frames>
  800585:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800588:	e8 8d 1c 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  80058d:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[1]);
  800590:	8b 45 90             	mov    -0x70(%ebp),%eax
  800593:	83 ec 0c             	sub    $0xc,%esp
  800596:	50                   	push   %eax
  800597:	e8 b9 19 00 00       	call   801f55 <free>
  80059c:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  80059f:	e8 76 1c 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  8005a4:	8b 55 dc             	mov    -0x24(%ebp),%edx
  8005a7:	29 c2                	sub    %eax,%edx
  8005a9:	89 d0                	mov    %edx,%eax
  8005ab:	3d 00 01 00 00       	cmp    $0x100,%eax
  8005b0:	74 14                	je     8005c6 <_main+0x58e>
  8005b2:	83 ec 04             	sub    $0x4,%esp
  8005b5:	68 87 2a 80 00       	push   $0x802a87
  8005ba:	6a 71                	push   $0x71
  8005bc:	68 1c 29 80 00       	push   $0x80291c
  8005c1:	e8 49 09 00 00       	call   800f0f <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  8005c6:	e8 cc 1b 00 00       	call   802197 <sys_calculate_free_frames>
  8005cb:	89 c2                	mov    %eax,%edx
  8005cd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005d0:	39 c2                	cmp    %eax,%edx
  8005d2:	74 14                	je     8005e8 <_main+0x5b0>
  8005d4:	83 ec 04             	sub    $0x4,%esp
  8005d7:	68 9e 2a 80 00       	push   $0x802a9e
  8005dc:	6a 72                	push   $0x72
  8005de:	68 1c 29 80 00       	push   $0x80291c
  8005e3:	e8 27 09 00 00       	call   800f0f <_panic>

		//2 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  8005e8:	e8 aa 1b 00 00       	call   802197 <sys_calculate_free_frames>
  8005ed:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8005f0:	e8 25 1c 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  8005f5:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[4]);
  8005f8:	8b 45 9c             	mov    -0x64(%ebp),%eax
  8005fb:	83 ec 0c             	sub    $0xc,%esp
  8005fe:	50                   	push   %eax
  8005ff:	e8 51 19 00 00       	call   801f55 <free>
  800604:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 512) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  512) panic("Wrong page file free: ");
  800607:	e8 0e 1c 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  80060c:	8b 55 dc             	mov    -0x24(%ebp),%edx
  80060f:	29 c2                	sub    %eax,%edx
  800611:	89 d0                	mov    %edx,%eax
  800613:	3d 00 02 00 00       	cmp    $0x200,%eax
  800618:	74 14                	je     80062e <_main+0x5f6>
  80061a:	83 ec 04             	sub    $0x4,%esp
  80061d:	68 87 2a 80 00       	push   $0x802a87
  800622:	6a 79                	push   $0x79
  800624:	68 1c 29 80 00       	push   $0x80291c
  800629:	e8 e1 08 00 00       	call   800f0f <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  80062e:	e8 64 1b 00 00       	call   802197 <sys_calculate_free_frames>
  800633:	89 c2                	mov    %eax,%edx
  800635:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800638:	39 c2                	cmp    %eax,%edx
  80063a:	74 14                	je     800650 <_main+0x618>
  80063c:	83 ec 04             	sub    $0x4,%esp
  80063f:	68 9e 2a 80 00       	push   $0x802a9e
  800644:	6a 7a                	push   $0x7a
  800646:	68 1c 29 80 00       	push   $0x80291c
  80064b:	e8 bf 08 00 00       	call   800f0f <_panic>

		//3 MB Hole
		freeFrames = sys_calculate_free_frames() ;
  800650:	e8 42 1b 00 00       	call   802197 <sys_calculate_free_frames>
  800655:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800658:	e8 bd 1b 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  80065d:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[6]);
  800660:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  800663:	83 ec 0c             	sub    $0xc,%esp
  800666:	50                   	push   %eax
  800667:	e8 e9 18 00 00       	call   801f55 <free>
  80066c:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 768) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  768) panic("Wrong page file free: ");
  80066f:	e8 a6 1b 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800674:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800677:	29 c2                	sub    %eax,%edx
  800679:	89 d0                	mov    %edx,%eax
  80067b:	3d 00 03 00 00       	cmp    $0x300,%eax
  800680:	74 17                	je     800699 <_main+0x661>
  800682:	83 ec 04             	sub    $0x4,%esp
  800685:	68 87 2a 80 00       	push   $0x802a87
  80068a:	68 81 00 00 00       	push   $0x81
  80068f:	68 1c 29 80 00       	push   $0x80291c
  800694:	e8 76 08 00 00       	call   800f0f <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800699:	e8 f9 1a 00 00       	call   802197 <sys_calculate_free_frames>
  80069e:	89 c2                	mov    %eax,%edx
  8006a0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006a3:	39 c2                	cmp    %eax,%edx
  8006a5:	74 17                	je     8006be <_main+0x686>
  8006a7:	83 ec 04             	sub    $0x4,%esp
  8006aa:	68 9e 2a 80 00       	push   $0x802a9e
  8006af:	68 82 00 00 00       	push   $0x82
  8006b4:	68 1c 29 80 00       	push   $0x80291c
  8006b9:	e8 51 08 00 00       	call   800f0f <_panic>
	}

	//[3] Allocate again [test first fit]
	{
		//Allocate 512 KB - should be placed in 1st hole
		freeFrames = sys_calculate_free_frames() ;
  8006be:	e8 d4 1a 00 00       	call   802197 <sys_calculate_free_frames>
  8006c3:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8006c6:	e8 4f 1b 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  8006cb:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[8] = malloc(512*kilo - kilo);
  8006ce:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8006d1:	89 d0                	mov    %edx,%eax
  8006d3:	c1 e0 09             	shl    $0x9,%eax
  8006d6:	29 d0                	sub    %edx,%eax
  8006d8:	83 ec 0c             	sub    $0xc,%esp
  8006db:	50                   	push   %eax
  8006dc:	e8 5a 18 00 00       	call   801f3b <malloc>
  8006e1:	83 c4 10             	add    $0x10,%esp
  8006e4:	89 45 ac             	mov    %eax,-0x54(%ebp)
		if ((uint32) ptr_allocations[8] != (USER_HEAP_START + 1*Mega)) panic("Wrong start address for the allocated space... ");
  8006e7:	8b 45 ac             	mov    -0x54(%ebp),%eax
  8006ea:	89 c2                	mov    %eax,%edx
  8006ec:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8006ef:	05 00 00 00 80       	add    $0x80000000,%eax
  8006f4:	39 c2                	cmp    %eax,%edx
  8006f6:	74 17                	je     80070f <_main+0x6d7>
  8006f8:	83 ec 04             	sub    $0x4,%esp
  8006fb:	68 40 2a 80 00       	push   $0x802a40
  800700:	68 8b 00 00 00       	push   $0x8b
  800705:	68 1c 29 80 00       	push   $0x80291c
  80070a:	e8 00 08 00 00       	call   800f0f <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 128) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  128) panic("Wrong page file allocation: ");
  80070f:	e8 06 1b 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800714:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800717:	3d 80 00 00 00       	cmp    $0x80,%eax
  80071c:	74 17                	je     800735 <_main+0x6fd>
  80071e:	83 ec 04             	sub    $0x4,%esp
  800721:	68 22 2a 80 00       	push   $0x802a22
  800726:	68 8d 00 00 00       	push   $0x8d
  80072b:	68 1c 29 80 00       	push   $0x80291c
  800730:	e8 da 07 00 00       	call   800f0f <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800735:	e8 5d 1a 00 00       	call   802197 <sys_calculate_free_frames>
  80073a:	89 c2                	mov    %eax,%edx
  80073c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80073f:	39 c2                	cmp    %eax,%edx
  800741:	74 17                	je     80075a <_main+0x722>
  800743:	83 ec 04             	sub    $0x4,%esp
  800746:	68 70 2a 80 00       	push   $0x802a70
  80074b:	68 8e 00 00 00       	push   $0x8e
  800750:	68 1c 29 80 00       	push   $0x80291c
  800755:	e8 b5 07 00 00       	call   800f0f <_panic>

		//Allocate 1 MB - should be placed in 2nd hole
		freeFrames = sys_calculate_free_frames() ;
  80075a:	e8 38 1a 00 00       	call   802197 <sys_calculate_free_frames>
  80075f:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800762:	e8 b3 1a 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800767:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[9] = malloc(1*Mega - kilo);
  80076a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80076d:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800770:	83 ec 0c             	sub    $0xc,%esp
  800773:	50                   	push   %eax
  800774:	e8 c2 17 00 00       	call   801f3b <malloc>
  800779:	83 c4 10             	add    $0x10,%esp
  80077c:	89 45 b0             	mov    %eax,-0x50(%ebp)
		if ((uint32) ptr_allocations[9] != (USER_HEAP_START + 4*Mega)) panic("Wrong start address for the allocated space... ");
  80077f:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800782:	89 c2                	mov    %eax,%edx
  800784:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800787:	c1 e0 02             	shl    $0x2,%eax
  80078a:	05 00 00 00 80       	add    $0x80000000,%eax
  80078f:	39 c2                	cmp    %eax,%edx
  800791:	74 17                	je     8007aa <_main+0x772>
  800793:	83 ec 04             	sub    $0x4,%esp
  800796:	68 40 2a 80 00       	push   $0x802a40
  80079b:	68 94 00 00 00       	push   $0x94
  8007a0:	68 1c 29 80 00       	push   $0x80291c
  8007a5:	e8 65 07 00 00       	call   800f0f <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256) panic("Wrong page file allocation: ");
  8007aa:	e8 6b 1a 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  8007af:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8007b2:	3d 00 01 00 00       	cmp    $0x100,%eax
  8007b7:	74 17                	je     8007d0 <_main+0x798>
  8007b9:	83 ec 04             	sub    $0x4,%esp
  8007bc:	68 22 2a 80 00       	push   $0x802a22
  8007c1:	68 96 00 00 00       	push   $0x96
  8007c6:	68 1c 29 80 00       	push   $0x80291c
  8007cb:	e8 3f 07 00 00       	call   800f0f <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  8007d0:	e8 c2 19 00 00       	call   802197 <sys_calculate_free_frames>
  8007d5:	89 c2                	mov    %eax,%edx
  8007d7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007da:	39 c2                	cmp    %eax,%edx
  8007dc:	74 17                	je     8007f5 <_main+0x7bd>
  8007de:	83 ec 04             	sub    $0x4,%esp
  8007e1:	68 70 2a 80 00       	push   $0x802a70
  8007e6:	68 97 00 00 00       	push   $0x97
  8007eb:	68 1c 29 80 00       	push   $0x80291c
  8007f0:	e8 1a 07 00 00       	call   800f0f <_panic>

		//Allocate 256 KB - should be placed in remaining of 1st hole
		freeFrames = sys_calculate_free_frames() ;
  8007f5:	e8 9d 19 00 00       	call   802197 <sys_calculate_free_frames>
  8007fa:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8007fd:	e8 18 1a 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800802:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[10] = malloc(256*kilo - kilo);
  800805:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800808:	89 d0                	mov    %edx,%eax
  80080a:	c1 e0 08             	shl    $0x8,%eax
  80080d:	29 d0                	sub    %edx,%eax
  80080f:	83 ec 0c             	sub    $0xc,%esp
  800812:	50                   	push   %eax
  800813:	e8 23 17 00 00       	call   801f3b <malloc>
  800818:	83 c4 10             	add    $0x10,%esp
  80081b:	89 45 b4             	mov    %eax,-0x4c(%ebp)
		if ((uint32) ptr_allocations[10] != (USER_HEAP_START + 1*Mega + 512*kilo)) panic("Wrong start address for the allocated space... ");
  80081e:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800821:	89 c2                	mov    %eax,%edx
  800823:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800826:	c1 e0 09             	shl    $0x9,%eax
  800829:	89 c1                	mov    %eax,%ecx
  80082b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80082e:	01 c8                	add    %ecx,%eax
  800830:	05 00 00 00 80       	add    $0x80000000,%eax
  800835:	39 c2                	cmp    %eax,%edx
  800837:	74 17                	je     800850 <_main+0x818>
  800839:	83 ec 04             	sub    $0x4,%esp
  80083c:	68 40 2a 80 00       	push   $0x802a40
  800841:	68 9d 00 00 00       	push   $0x9d
  800846:	68 1c 29 80 00       	push   $0x80291c
  80084b:	e8 bf 06 00 00       	call   800f0f <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 64) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  64) panic("Wrong page file allocation: ");
  800850:	e8 c5 19 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800855:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800858:	83 f8 40             	cmp    $0x40,%eax
  80085b:	74 17                	je     800874 <_main+0x83c>
  80085d:	83 ec 04             	sub    $0x4,%esp
  800860:	68 22 2a 80 00       	push   $0x802a22
  800865:	68 9f 00 00 00       	push   $0x9f
  80086a:	68 1c 29 80 00       	push   $0x80291c
  80086f:	e8 9b 06 00 00       	call   800f0f <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800874:	e8 1e 19 00 00       	call   802197 <sys_calculate_free_frames>
  800879:	89 c2                	mov    %eax,%edx
  80087b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80087e:	39 c2                	cmp    %eax,%edx
  800880:	74 17                	je     800899 <_main+0x861>
  800882:	83 ec 04             	sub    $0x4,%esp
  800885:	68 70 2a 80 00       	push   $0x802a70
  80088a:	68 a0 00 00 00       	push   $0xa0
  80088f:	68 1c 29 80 00       	push   $0x80291c
  800894:	e8 76 06 00 00       	call   800f0f <_panic>

		//Allocate 2 MB - should be placed in 3rd hole
		freeFrames = sys_calculate_free_frames() ;
  800899:	e8 f9 18 00 00       	call   802197 <sys_calculate_free_frames>
  80089e:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8008a1:	e8 74 19 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  8008a6:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[11] = malloc(2*Mega);
  8008a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008ac:	01 c0                	add    %eax,%eax
  8008ae:	83 ec 0c             	sub    $0xc,%esp
  8008b1:	50                   	push   %eax
  8008b2:	e8 84 16 00 00       	call   801f3b <malloc>
  8008b7:	83 c4 10             	add    $0x10,%esp
  8008ba:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if ((uint32) ptr_allocations[11] != (USER_HEAP_START + 8*Mega)) panic("Wrong start address for the allocated space... ");
  8008bd:	8b 45 b8             	mov    -0x48(%ebp),%eax
  8008c0:	89 c2                	mov    %eax,%edx
  8008c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008c5:	c1 e0 03             	shl    $0x3,%eax
  8008c8:	05 00 00 00 80       	add    $0x80000000,%eax
  8008cd:	39 c2                	cmp    %eax,%edx
  8008cf:	74 17                	je     8008e8 <_main+0x8b0>
  8008d1:	83 ec 04             	sub    $0x4,%esp
  8008d4:	68 40 2a 80 00       	push   $0x802a40
  8008d9:	68 a6 00 00 00       	push   $0xa6
  8008de:	68 1c 29 80 00       	push   $0x80291c
  8008e3:	e8 27 06 00 00       	call   800f0f <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 256) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  512) panic("Wrong page file allocation: ");
  8008e8:	e8 2d 19 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  8008ed:	2b 45 dc             	sub    -0x24(%ebp),%eax
  8008f0:	3d 00 02 00 00       	cmp    $0x200,%eax
  8008f5:	74 17                	je     80090e <_main+0x8d6>
  8008f7:	83 ec 04             	sub    $0x4,%esp
  8008fa:	68 22 2a 80 00       	push   $0x802a22
  8008ff:	68 a8 00 00 00       	push   $0xa8
  800904:	68 1c 29 80 00       	push   $0x80291c
  800909:	e8 01 06 00 00       	call   800f0f <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  80090e:	e8 84 18 00 00       	call   802197 <sys_calculate_free_frames>
  800913:	89 c2                	mov    %eax,%edx
  800915:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800918:	39 c2                	cmp    %eax,%edx
  80091a:	74 17                	je     800933 <_main+0x8fb>
  80091c:	83 ec 04             	sub    $0x4,%esp
  80091f:	68 70 2a 80 00       	push   $0x802a70
  800924:	68 a9 00 00 00       	push   $0xa9
  800929:	68 1c 29 80 00       	push   $0x80291c
  80092e:	e8 dc 05 00 00       	call   800f0f <_panic>

		//Allocate 4 MB - should be placed in end of all allocations
		freeFrames = sys_calculate_free_frames() ;
  800933:	e8 5f 18 00 00       	call   802197 <sys_calculate_free_frames>
  800938:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  80093b:	e8 da 18 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800940:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[12] = malloc(4*Mega - kilo);
  800943:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800946:	c1 e0 02             	shl    $0x2,%eax
  800949:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  80094c:	83 ec 0c             	sub    $0xc,%esp
  80094f:	50                   	push   %eax
  800950:	e8 e6 15 00 00       	call   801f3b <malloc>
  800955:	83 c4 10             	add    $0x10,%esp
  800958:	89 45 bc             	mov    %eax,-0x44(%ebp)
		if ((uint32) ptr_allocations[12] != (USER_HEAP_START + 14*Mega) ) panic("Wrong start address for the allocated space... ");
  80095b:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80095e:	89 c1                	mov    %eax,%ecx
  800960:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800963:	89 d0                	mov    %edx,%eax
  800965:	01 c0                	add    %eax,%eax
  800967:	01 d0                	add    %edx,%eax
  800969:	01 c0                	add    %eax,%eax
  80096b:	01 d0                	add    %edx,%eax
  80096d:	01 c0                	add    %eax,%eax
  80096f:	05 00 00 00 80       	add    $0x80000000,%eax
  800974:	39 c1                	cmp    %eax,%ecx
  800976:	74 17                	je     80098f <_main+0x957>
  800978:	83 ec 04             	sub    $0x4,%esp
  80097b:	68 40 2a 80 00       	push   $0x802a40
  800980:	68 af 00 00 00       	push   $0xaf
  800985:	68 1c 29 80 00       	push   $0x80291c
  80098a:	e8 80 05 00 00       	call   800f0f <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 1024 + 1) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  1024) panic("Wrong page file allocation: ");
  80098f:	e8 86 18 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800994:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800997:	3d 00 04 00 00       	cmp    $0x400,%eax
  80099c:	74 17                	je     8009b5 <_main+0x97d>
  80099e:	83 ec 04             	sub    $0x4,%esp
  8009a1:	68 22 2a 80 00       	push   $0x802a22
  8009a6:	68 b1 00 00 00       	push   $0xb1
  8009ab:	68 1c 29 80 00       	push   $0x80291c
  8009b0:	e8 5a 05 00 00       	call   800f0f <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 2) panic("Wrong allocation: ");
  8009b5:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  8009b8:	e8 da 17 00 00       	call   802197 <sys_calculate_free_frames>
  8009bd:	29 c3                	sub    %eax,%ebx
  8009bf:	89 d8                	mov    %ebx,%eax
  8009c1:	83 f8 02             	cmp    $0x2,%eax
  8009c4:	74 17                	je     8009dd <_main+0x9a5>
  8009c6:	83 ec 04             	sub    $0x4,%esp
  8009c9:	68 70 2a 80 00       	push   $0x802a70
  8009ce:	68 b2 00 00 00       	push   $0xb2
  8009d3:	68 1c 29 80 00       	push   $0x80291c
  8009d8:	e8 32 05 00 00       	call   800f0f <_panic>
	}

	//[4] Free contiguous allocations
	{
		//1 MB Hole appended to previous 256 KB hole
		freeFrames = sys_calculate_free_frames() ;
  8009dd:	e8 b5 17 00 00       	call   802197 <sys_calculate_free_frames>
  8009e2:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  8009e5:	e8 30 18 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  8009ea:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[2]);
  8009ed:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8009f0:	83 ec 0c             	sub    $0xc,%esp
  8009f3:	50                   	push   %eax
  8009f4:	e8 5c 15 00 00       	call   801f55 <free>
  8009f9:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  8009fc:	e8 19 18 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800a01:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800a04:	29 c2                	sub    %eax,%edx
  800a06:	89 d0                	mov    %edx,%eax
  800a08:	3d 00 01 00 00       	cmp    $0x100,%eax
  800a0d:	74 17                	je     800a26 <_main+0x9ee>
  800a0f:	83 ec 04             	sub    $0x4,%esp
  800a12:	68 87 2a 80 00       	push   $0x802a87
  800a17:	68 bc 00 00 00       	push   $0xbc
  800a1c:	68 1c 29 80 00       	push   $0x80291c
  800a21:	e8 e9 04 00 00       	call   800f0f <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800a26:	e8 6c 17 00 00       	call   802197 <sys_calculate_free_frames>
  800a2b:	89 c2                	mov    %eax,%edx
  800a2d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a30:	39 c2                	cmp    %eax,%edx
  800a32:	74 17                	je     800a4b <_main+0xa13>
  800a34:	83 ec 04             	sub    $0x4,%esp
  800a37:	68 9e 2a 80 00       	push   $0x802a9e
  800a3c:	68 bd 00 00 00       	push   $0xbd
  800a41:	68 1c 29 80 00       	push   $0x80291c
  800a46:	e8 c4 04 00 00       	call   800f0f <_panic>

		//1 MB Hole appended to next 1 MB hole
		freeFrames = sys_calculate_free_frames() ;
  800a4b:	e8 47 17 00 00       	call   802197 <sys_calculate_free_frames>
  800a50:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800a53:	e8 c2 17 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800a58:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[9]);
  800a5b:	8b 45 b0             	mov    -0x50(%ebp),%eax
  800a5e:	83 ec 0c             	sub    $0xc,%esp
  800a61:	50                   	push   %eax
  800a62:	e8 ee 14 00 00       	call   801f55 <free>
  800a67:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800a6a:	e8 ab 17 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800a6f:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800a72:	29 c2                	sub    %eax,%edx
  800a74:	89 d0                	mov    %edx,%eax
  800a76:	3d 00 01 00 00       	cmp    $0x100,%eax
  800a7b:	74 17                	je     800a94 <_main+0xa5c>
  800a7d:	83 ec 04             	sub    $0x4,%esp
  800a80:	68 87 2a 80 00       	push   $0x802a87
  800a85:	68 c4 00 00 00       	push   $0xc4
  800a8a:	68 1c 29 80 00       	push   $0x80291c
  800a8f:	e8 7b 04 00 00       	call   800f0f <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800a94:	e8 fe 16 00 00       	call   802197 <sys_calculate_free_frames>
  800a99:	89 c2                	mov    %eax,%edx
  800a9b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a9e:	39 c2                	cmp    %eax,%edx
  800aa0:	74 17                	je     800ab9 <_main+0xa81>
  800aa2:	83 ec 04             	sub    $0x4,%esp
  800aa5:	68 9e 2a 80 00       	push   $0x802a9e
  800aaa:	68 c5 00 00 00       	push   $0xc5
  800aaf:	68 1c 29 80 00       	push   $0x80291c
  800ab4:	e8 56 04 00 00       	call   800f0f <_panic>

		//1 MB Hole appended to previous 1 MB + 256 KB hole and next 2 MB hole
		freeFrames = sys_calculate_free_frames() ;
  800ab9:	e8 d9 16 00 00       	call   802197 <sys_calculate_free_frames>
  800abe:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800ac1:	e8 54 17 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800ac6:	89 45 dc             	mov    %eax,-0x24(%ebp)
		free(ptr_allocations[3]);
  800ac9:	8b 45 98             	mov    -0x68(%ebp),%eax
  800acc:	83 ec 0c             	sub    $0xc,%esp
  800acf:	50                   	push   %eax
  800ad0:	e8 80 14 00 00       	call   801f55 <free>
  800ad5:	83 c4 10             	add    $0x10,%esp
		//if ((sys_calculate_free_frames() - freeFrames) != 256) panic("Wrong free: ");
		if( (usedDiskPages - sys_pf_calculate_allocated_pages()) !=  256) panic("Wrong page file free: ");
  800ad8:	e8 3d 17 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800add:	8b 55 dc             	mov    -0x24(%ebp),%edx
  800ae0:	29 c2                	sub    %eax,%edx
  800ae2:	89 d0                	mov    %edx,%eax
  800ae4:	3d 00 01 00 00       	cmp    $0x100,%eax
  800ae9:	74 17                	je     800b02 <_main+0xaca>
  800aeb:	83 ec 04             	sub    $0x4,%esp
  800aee:	68 87 2a 80 00       	push   $0x802a87
  800af3:	68 cc 00 00 00       	push   $0xcc
  800af8:	68 1c 29 80 00       	push   $0x80291c
  800afd:	e8 0d 04 00 00       	call   800f0f <_panic>
		if ((sys_calculate_free_frames() - freeFrames) != 0) panic("Wrong free: ");
  800b02:	e8 90 16 00 00       	call   802197 <sys_calculate_free_frames>
  800b07:	89 c2                	mov    %eax,%edx
  800b09:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b0c:	39 c2                	cmp    %eax,%edx
  800b0e:	74 17                	je     800b27 <_main+0xaef>
  800b10:	83 ec 04             	sub    $0x4,%esp
  800b13:	68 9e 2a 80 00       	push   $0x802a9e
  800b18:	68 cd 00 00 00       	push   $0xcd
  800b1d:	68 1c 29 80 00       	push   $0x80291c
  800b22:	e8 e8 03 00 00       	call   800f0f <_panic>

	//[5] Allocate again [test first fit]
	{
		//[FIRST FIT Case]
		//Allocate 1 MB + 256 KB - should be placed in the contiguous hole (256 KB + 4 MB)
		freeFrames = sys_calculate_free_frames() ;
  800b27:	e8 6b 16 00 00       	call   802197 <sys_calculate_free_frames>
  800b2c:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800b2f:	e8 e6 16 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800b34:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[13] = malloc(1*Mega + 256*kilo - kilo);
  800b37:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800b3a:	c1 e0 08             	shl    $0x8,%eax
  800b3d:	89 c2                	mov    %eax,%edx
  800b3f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b42:	01 d0                	add    %edx,%eax
  800b44:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800b47:	83 ec 0c             	sub    $0xc,%esp
  800b4a:	50                   	push   %eax
  800b4b:	e8 eb 13 00 00       	call   801f3b <malloc>
  800b50:	83 c4 10             	add    $0x10,%esp
  800b53:	89 45 c0             	mov    %eax,-0x40(%ebp)
		if ((uint32) ptr_allocations[13] != (USER_HEAP_START + 1*Mega + 768*kilo)) panic("Wrong start address for the allocated space... ");
  800b56:	8b 45 c0             	mov    -0x40(%ebp),%eax
  800b59:	89 c1                	mov    %eax,%ecx
  800b5b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800b5e:	89 d0                	mov    %edx,%eax
  800b60:	01 c0                	add    %eax,%eax
  800b62:	01 d0                	add    %edx,%eax
  800b64:	c1 e0 08             	shl    $0x8,%eax
  800b67:	89 c2                	mov    %eax,%edx
  800b69:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b6c:	01 d0                	add    %edx,%eax
  800b6e:	05 00 00 00 80       	add    $0x80000000,%eax
  800b73:	39 c1                	cmp    %eax,%ecx
  800b75:	74 17                	je     800b8e <_main+0xb56>
  800b77:	83 ec 04             	sub    $0x4,%esp
  800b7a:	68 40 2a 80 00       	push   $0x802a40
  800b7f:	68 d7 00 00 00       	push   $0xd7
  800b84:	68 1c 29 80 00       	push   $0x80291c
  800b89:	e8 81 03 00 00       	call   800f0f <_panic>
		//if ((freeFrames - sys_calculate_free_frames()) != 512+32) panic("Wrong allocation: ");
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  256+64) panic("Wrong page file allocation: ");
  800b8e:	e8 87 16 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800b93:	2b 45 dc             	sub    -0x24(%ebp),%eax
  800b96:	3d 40 01 00 00       	cmp    $0x140,%eax
  800b9b:	74 17                	je     800bb4 <_main+0xb7c>
  800b9d:	83 ec 04             	sub    $0x4,%esp
  800ba0:	68 22 2a 80 00       	push   $0x802a22
  800ba5:	68 d9 00 00 00       	push   $0xd9
  800baa:	68 1c 29 80 00       	push   $0x80291c
  800baf:	e8 5b 03 00 00       	call   800f0f <_panic>
		if ((freeFrames - sys_calculate_free_frames()) != 0) panic("Wrong allocation: ");
  800bb4:	e8 de 15 00 00       	call   802197 <sys_calculate_free_frames>
  800bb9:	89 c2                	mov    %eax,%edx
  800bbb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800bbe:	39 c2                	cmp    %eax,%edx
  800bc0:	74 17                	je     800bd9 <_main+0xba1>
  800bc2:	83 ec 04             	sub    $0x4,%esp
  800bc5:	68 70 2a 80 00       	push   $0x802a70
  800bca:	68 da 00 00 00       	push   $0xda
  800bcf:	68 1c 29 80 00       	push   $0x80291c
  800bd4:	e8 36 03 00 00       	call   800f0f <_panic>

		//Allocate Shared 4 MB [should be placed at the end of all allocations
		freeFrames = sys_calculate_free_frames() ;
  800bd9:	e8 b9 15 00 00       	call   802197 <sys_calculate_free_frames>
  800bde:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800be1:	e8 34 16 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800be6:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[14] = smalloc("w", 4*Mega, 0);
  800be9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800bec:	c1 e0 02             	shl    $0x2,%eax
  800bef:	83 ec 04             	sub    $0x4,%esp
  800bf2:	6a 00                	push   $0x0
  800bf4:	50                   	push   %eax
  800bf5:	68 ab 2a 80 00       	push   $0x802aab
  800bfa:	e8 70 13 00 00       	call   801f6f <smalloc>
  800bff:	83 c4 10             	add    $0x10,%esp
  800c02:	89 45 c4             	mov    %eax,-0x3c(%ebp)
		if (ptr_allocations[14] != (uint32*)(USER_HEAP_START + 18*Mega)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  800c05:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  800c08:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800c0b:	89 d0                	mov    %edx,%eax
  800c0d:	c1 e0 03             	shl    $0x3,%eax
  800c10:	01 d0                	add    %edx,%eax
  800c12:	01 c0                	add    %eax,%eax
  800c14:	05 00 00 00 80       	add    $0x80000000,%eax
  800c19:	39 c1                	cmp    %eax,%ecx
  800c1b:	74 17                	je     800c34 <_main+0xbfc>
  800c1d:	83 ec 04             	sub    $0x4,%esp
  800c20:	68 38 29 80 00       	push   $0x802938
  800c25:	68 e0 00 00 00       	push   $0xe0
  800c2a:	68 1c 29 80 00       	push   $0x80291c
  800c2f:	e8 db 02 00 00       	call   800f0f <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  1024+2+2) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800c34:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800c37:	e8 5b 15 00 00       	call   802197 <sys_calculate_free_frames>
  800c3c:	29 c3                	sub    %eax,%ebx
  800c3e:	89 d8                	mov    %ebx,%eax
  800c40:	3d 04 04 00 00       	cmp    $0x404,%eax
  800c45:	74 17                	je     800c5e <_main+0xc26>
  800c47:	83 ec 04             	sub    $0x4,%esp
  800c4a:	68 a4 29 80 00       	push   $0x8029a4
  800c4f:	68 e1 00 00 00       	push   $0xe1
  800c54:	68 1c 29 80 00       	push   $0x80291c
  800c59:	e8 b1 02 00 00       	call   800f0f <_panic>
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  800c5e:	e8 b7 15 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800c63:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800c66:	74 17                	je     800c7f <_main+0xc47>
  800c68:	83 ec 04             	sub    $0x4,%esp
  800c6b:	68 22 2a 80 00       	push   $0x802a22
  800c70:	68 e2 00 00 00       	push   $0xe2
  800c75:	68 1c 29 80 00       	push   $0x80291c
  800c7a:	e8 90 02 00 00       	call   800f0f <_panic>

		//Get shared of 3 MB [should be placed in the remaining part of the contiguous (256 KB + 4 MB) hole
		freeFrames = sys_calculate_free_frames() ;
  800c7f:	e8 13 15 00 00       	call   802197 <sys_calculate_free_frames>
  800c84:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800c87:	e8 8e 15 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800c8c:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[15] = sget(envID, "z");
  800c8f:	83 ec 08             	sub    $0x8,%esp
  800c92:	68 85 2a 80 00       	push   $0x802a85
  800c97:	ff 75 ec             	pushl  -0x14(%ebp)
  800c9a:	e8 f0 12 00 00       	call   801f8f <sget>
  800c9f:	83 c4 10             	add    $0x10,%esp
  800ca2:	89 45 c8             	mov    %eax,-0x38(%ebp)
		if (ptr_allocations[15] != (uint32*)(USER_HEAP_START + 3*Mega)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  800ca5:	8b 55 c8             	mov    -0x38(%ebp),%edx
  800ca8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800cab:	89 c1                	mov    %eax,%ecx
  800cad:	01 c9                	add    %ecx,%ecx
  800caf:	01 c8                	add    %ecx,%eax
  800cb1:	05 00 00 00 80       	add    $0x80000000,%eax
  800cb6:	39 c2                	cmp    %eax,%edx
  800cb8:	74 17                	je     800cd1 <_main+0xc99>
  800cba:	83 ec 04             	sub    $0x4,%esp
  800cbd:	68 38 29 80 00       	push   $0x802938
  800cc2:	68 e8 00 00 00       	push   $0xe8
  800cc7:	68 1c 29 80 00       	push   $0x80291c
  800ccc:	e8 3e 02 00 00       	call   800f0f <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  0+0+0) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800cd1:	e8 c1 14 00 00       	call   802197 <sys_calculate_free_frames>
  800cd6:	89 c2                	mov    %eax,%edx
  800cd8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cdb:	39 c2                	cmp    %eax,%edx
  800cdd:	74 17                	je     800cf6 <_main+0xcbe>
  800cdf:	83 ec 04             	sub    $0x4,%esp
  800ce2:	68 a4 29 80 00       	push   $0x8029a4
  800ce7:	68 e9 00 00 00       	push   $0xe9
  800cec:	68 1c 29 80 00       	push   $0x80291c
  800cf1:	e8 19 02 00 00       	call   800f0f <_panic>
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  800cf6:	e8 1f 15 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800cfb:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800cfe:	74 17                	je     800d17 <_main+0xcdf>
  800d00:	83 ec 04             	sub    $0x4,%esp
  800d03:	68 22 2a 80 00       	push   $0x802a22
  800d08:	68 ea 00 00 00       	push   $0xea
  800d0d:	68 1c 29 80 00       	push   $0x80291c
  800d12:	e8 f8 01 00 00       	call   800f0f <_panic>

		//Get shared of 1st 1 MB [should be placed in the remaining part of the 3 MB hole
		freeFrames = sys_calculate_free_frames() ;
  800d17:	e8 7b 14 00 00       	call   802197 <sys_calculate_free_frames>
  800d1c:	89 45 e0             	mov    %eax,-0x20(%ebp)
		usedDiskPages = sys_pf_calculate_allocated_pages();
  800d1f:	e8 f6 14 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800d24:	89 45 dc             	mov    %eax,-0x24(%ebp)
		ptr_allocations[16] = sget(envID, "x");
  800d27:	83 ec 08             	sub    $0x8,%esp
  800d2a:	68 33 29 80 00       	push   $0x802933
  800d2f:	ff 75 ec             	pushl  -0x14(%ebp)
  800d32:	e8 58 12 00 00       	call   801f8f <sget>
  800d37:	83 c4 10             	add    $0x10,%esp
  800d3a:	89 45 cc             	mov    %eax,-0x34(%ebp)
		if (ptr_allocations[16] != (uint32*)(USER_HEAP_START + 10*Mega)) panic("Returned address is not correct. check the setting of it and/or the updating of the shared_mem_free_address");
  800d3d:	8b 4d cc             	mov    -0x34(%ebp),%ecx
  800d40:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800d43:	89 d0                	mov    %edx,%eax
  800d45:	c1 e0 02             	shl    $0x2,%eax
  800d48:	01 d0                	add    %edx,%eax
  800d4a:	01 c0                	add    %eax,%eax
  800d4c:	05 00 00 00 80       	add    $0x80000000,%eax
  800d51:	39 c1                	cmp    %eax,%ecx
  800d53:	74 17                	je     800d6c <_main+0xd34>
  800d55:	83 ec 04             	sub    $0x4,%esp
  800d58:	68 38 29 80 00       	push   $0x802938
  800d5d:	68 f0 00 00 00       	push   $0xf0
  800d62:	68 1c 29 80 00       	push   $0x80291c
  800d67:	e8 a3 01 00 00       	call   800f0f <_panic>
		if ((freeFrames - sys_calculate_free_frames()) !=  0+0+0) panic("Wrong allocation: make sure that you allocate the required space in the user environment and add its frames to frames_storage");
  800d6c:	e8 26 14 00 00       	call   802197 <sys_calculate_free_frames>
  800d71:	89 c2                	mov    %eax,%edx
  800d73:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d76:	39 c2                	cmp    %eax,%edx
  800d78:	74 17                	je     800d91 <_main+0xd59>
  800d7a:	83 ec 04             	sub    $0x4,%esp
  800d7d:	68 a4 29 80 00       	push   $0x8029a4
  800d82:	68 f1 00 00 00       	push   $0xf1
  800d87:	68 1c 29 80 00       	push   $0x80291c
  800d8c:	e8 7e 01 00 00       	call   800f0f <_panic>
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Wrong page file allocation: ");
  800d91:	e8 84 14 00 00       	call   80221a <sys_pf_calculate_allocated_pages>
  800d96:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800d99:	74 17                	je     800db2 <_main+0xd7a>
  800d9b:	83 ec 04             	sub    $0x4,%esp
  800d9e:	68 22 2a 80 00       	push   $0x802a22
  800da3:	68 f2 00 00 00       	push   $0xf2
  800da8:	68 1c 29 80 00       	push   $0x80291c
  800dad:	e8 5d 01 00 00       	call   800f0f <_panic>

	}
	cprintf("Congratulations!! test FIRST FIT allocation (3) completed successfully.\n");
  800db2:	83 ec 0c             	sub    $0xc,%esp
  800db5:	68 b0 2a 80 00       	push   $0x802ab0
  800dba:	e8 f2 03 00 00       	call   8011b1 <cprintf>
  800dbf:	83 c4 10             	add    $0x10,%esp

	return;
  800dc2:	90                   	nop
}
  800dc3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800dc6:	5b                   	pop    %ebx
  800dc7:	5f                   	pop    %edi
  800dc8:	5d                   	pop    %ebp
  800dc9:	c3                   	ret    

00800dca <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800dca:	55                   	push   %ebp
  800dcb:	89 e5                	mov    %esp,%ebp
  800dcd:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800dd0:	e8 f7 12 00 00       	call   8020cc <sys_getenvindex>
  800dd5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800dd8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ddb:	89 d0                	mov    %edx,%eax
  800ddd:	c1 e0 03             	shl    $0x3,%eax
  800de0:	01 d0                	add    %edx,%eax
  800de2:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800de9:	01 c8                	add    %ecx,%eax
  800deb:	01 c0                	add    %eax,%eax
  800ded:	01 d0                	add    %edx,%eax
  800def:	01 c0                	add    %eax,%eax
  800df1:	01 d0                	add    %edx,%eax
  800df3:	89 c2                	mov    %eax,%edx
  800df5:	c1 e2 05             	shl    $0x5,%edx
  800df8:	29 c2                	sub    %eax,%edx
  800dfa:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800e01:	89 c2                	mov    %eax,%edx
  800e03:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800e09:	a3 20 40 80 00       	mov    %eax,0x804020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800e0e:	a1 20 40 80 00       	mov    0x804020,%eax
  800e13:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800e19:	84 c0                	test   %al,%al
  800e1b:	74 0f                	je     800e2c <libmain+0x62>
		binaryname = myEnv->prog_name;
  800e1d:	a1 20 40 80 00       	mov    0x804020,%eax
  800e22:	05 40 3c 01 00       	add    $0x13c40,%eax
  800e27:	a3 00 40 80 00       	mov    %eax,0x804000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800e2c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e30:	7e 0a                	jle    800e3c <libmain+0x72>
		binaryname = argv[0];
  800e32:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e35:	8b 00                	mov    (%eax),%eax
  800e37:	a3 00 40 80 00       	mov    %eax,0x804000

	// call user main routine
	_main(argc, argv);
  800e3c:	83 ec 08             	sub    $0x8,%esp
  800e3f:	ff 75 0c             	pushl  0xc(%ebp)
  800e42:	ff 75 08             	pushl  0x8(%ebp)
  800e45:	e8 ee f1 ff ff       	call   800038 <_main>
  800e4a:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800e4d:	e8 15 14 00 00       	call   802267 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800e52:	83 ec 0c             	sub    $0xc,%esp
  800e55:	68 14 2b 80 00       	push   $0x802b14
  800e5a:	e8 52 03 00 00       	call   8011b1 <cprintf>
  800e5f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800e62:	a1 20 40 80 00       	mov    0x804020,%eax
  800e67:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800e6d:	a1 20 40 80 00       	mov    0x804020,%eax
  800e72:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800e78:	83 ec 04             	sub    $0x4,%esp
  800e7b:	52                   	push   %edx
  800e7c:	50                   	push   %eax
  800e7d:	68 3c 2b 80 00       	push   $0x802b3c
  800e82:	e8 2a 03 00 00       	call   8011b1 <cprintf>
  800e87:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800e8a:	a1 20 40 80 00       	mov    0x804020,%eax
  800e8f:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800e95:	a1 20 40 80 00       	mov    0x804020,%eax
  800e9a:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  800ea0:	83 ec 04             	sub    $0x4,%esp
  800ea3:	52                   	push   %edx
  800ea4:	50                   	push   %eax
  800ea5:	68 64 2b 80 00       	push   $0x802b64
  800eaa:	e8 02 03 00 00       	call   8011b1 <cprintf>
  800eaf:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800eb2:	a1 20 40 80 00       	mov    0x804020,%eax
  800eb7:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800ebd:	83 ec 08             	sub    $0x8,%esp
  800ec0:	50                   	push   %eax
  800ec1:	68 a5 2b 80 00       	push   $0x802ba5
  800ec6:	e8 e6 02 00 00       	call   8011b1 <cprintf>
  800ecb:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800ece:	83 ec 0c             	sub    $0xc,%esp
  800ed1:	68 14 2b 80 00       	push   $0x802b14
  800ed6:	e8 d6 02 00 00       	call   8011b1 <cprintf>
  800edb:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800ede:	e8 9e 13 00 00       	call   802281 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800ee3:	e8 19 00 00 00       	call   800f01 <exit>
}
  800ee8:	90                   	nop
  800ee9:	c9                   	leave  
  800eea:	c3                   	ret    

00800eeb <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800eeb:	55                   	push   %ebp
  800eec:	89 e5                	mov    %esp,%ebp
  800eee:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800ef1:	83 ec 0c             	sub    $0xc,%esp
  800ef4:	6a 00                	push   $0x0
  800ef6:	e8 9d 11 00 00       	call   802098 <sys_env_destroy>
  800efb:	83 c4 10             	add    $0x10,%esp
}
  800efe:	90                   	nop
  800eff:	c9                   	leave  
  800f00:	c3                   	ret    

00800f01 <exit>:

void
exit(void)
{
  800f01:	55                   	push   %ebp
  800f02:	89 e5                	mov    %esp,%ebp
  800f04:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800f07:	e8 f2 11 00 00       	call   8020fe <sys_env_exit>
}
  800f0c:	90                   	nop
  800f0d:	c9                   	leave  
  800f0e:	c3                   	ret    

00800f0f <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800f0f:	55                   	push   %ebp
  800f10:	89 e5                	mov    %esp,%ebp
  800f12:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800f15:	8d 45 10             	lea    0x10(%ebp),%eax
  800f18:	83 c0 04             	add    $0x4,%eax
  800f1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800f1e:	a1 18 41 80 00       	mov    0x804118,%eax
  800f23:	85 c0                	test   %eax,%eax
  800f25:	74 16                	je     800f3d <_panic+0x2e>
		cprintf("%s: ", argv0);
  800f27:	a1 18 41 80 00       	mov    0x804118,%eax
  800f2c:	83 ec 08             	sub    $0x8,%esp
  800f2f:	50                   	push   %eax
  800f30:	68 bc 2b 80 00       	push   $0x802bbc
  800f35:	e8 77 02 00 00       	call   8011b1 <cprintf>
  800f3a:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800f3d:	a1 00 40 80 00       	mov    0x804000,%eax
  800f42:	ff 75 0c             	pushl  0xc(%ebp)
  800f45:	ff 75 08             	pushl  0x8(%ebp)
  800f48:	50                   	push   %eax
  800f49:	68 c1 2b 80 00       	push   $0x802bc1
  800f4e:	e8 5e 02 00 00       	call   8011b1 <cprintf>
  800f53:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800f56:	8b 45 10             	mov    0x10(%ebp),%eax
  800f59:	83 ec 08             	sub    $0x8,%esp
  800f5c:	ff 75 f4             	pushl  -0xc(%ebp)
  800f5f:	50                   	push   %eax
  800f60:	e8 e1 01 00 00       	call   801146 <vcprintf>
  800f65:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800f68:	83 ec 08             	sub    $0x8,%esp
  800f6b:	6a 00                	push   $0x0
  800f6d:	68 dd 2b 80 00       	push   $0x802bdd
  800f72:	e8 cf 01 00 00       	call   801146 <vcprintf>
  800f77:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800f7a:	e8 82 ff ff ff       	call   800f01 <exit>

	// should not return here
	while (1) ;
  800f7f:	eb fe                	jmp    800f7f <_panic+0x70>

00800f81 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800f81:	55                   	push   %ebp
  800f82:	89 e5                	mov    %esp,%ebp
  800f84:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800f87:	a1 20 40 80 00       	mov    0x804020,%eax
  800f8c:	8b 50 74             	mov    0x74(%eax),%edx
  800f8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f92:	39 c2                	cmp    %eax,%edx
  800f94:	74 14                	je     800faa <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800f96:	83 ec 04             	sub    $0x4,%esp
  800f99:	68 e0 2b 80 00       	push   $0x802be0
  800f9e:	6a 26                	push   $0x26
  800fa0:	68 2c 2c 80 00       	push   $0x802c2c
  800fa5:	e8 65 ff ff ff       	call   800f0f <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800faa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800fb1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800fb8:	e9 b6 00 00 00       	jmp    801073 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800fbd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fc0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fca:	01 d0                	add    %edx,%eax
  800fcc:	8b 00                	mov    (%eax),%eax
  800fce:	85 c0                	test   %eax,%eax
  800fd0:	75 08                	jne    800fda <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800fd2:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800fd5:	e9 96 00 00 00       	jmp    801070 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800fda:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800fe1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800fe8:	eb 5d                	jmp    801047 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800fea:	a1 20 40 80 00       	mov    0x804020,%eax
  800fef:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800ff5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800ff8:	c1 e2 04             	shl    $0x4,%edx
  800ffb:	01 d0                	add    %edx,%eax
  800ffd:	8a 40 04             	mov    0x4(%eax),%al
  801000:	84 c0                	test   %al,%al
  801002:	75 40                	jne    801044 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801004:	a1 20 40 80 00       	mov    0x804020,%eax
  801009:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80100f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801012:	c1 e2 04             	shl    $0x4,%edx
  801015:	01 d0                	add    %edx,%eax
  801017:	8b 00                	mov    (%eax),%eax
  801019:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80101c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80101f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801024:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801026:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801029:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801030:	8b 45 08             	mov    0x8(%ebp),%eax
  801033:	01 c8                	add    %ecx,%eax
  801035:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801037:	39 c2                	cmp    %eax,%edx
  801039:	75 09                	jne    801044 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  80103b:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801042:	eb 12                	jmp    801056 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801044:	ff 45 e8             	incl   -0x18(%ebp)
  801047:	a1 20 40 80 00       	mov    0x804020,%eax
  80104c:	8b 50 74             	mov    0x74(%eax),%edx
  80104f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801052:	39 c2                	cmp    %eax,%edx
  801054:	77 94                	ja     800fea <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801056:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80105a:	75 14                	jne    801070 <CheckWSWithoutLastIndex+0xef>
			panic(
  80105c:	83 ec 04             	sub    $0x4,%esp
  80105f:	68 38 2c 80 00       	push   $0x802c38
  801064:	6a 3a                	push   $0x3a
  801066:	68 2c 2c 80 00       	push   $0x802c2c
  80106b:	e8 9f fe ff ff       	call   800f0f <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801070:	ff 45 f0             	incl   -0x10(%ebp)
  801073:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801076:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801079:	0f 8c 3e ff ff ff    	jl     800fbd <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80107f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801086:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80108d:	eb 20                	jmp    8010af <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80108f:	a1 20 40 80 00       	mov    0x804020,%eax
  801094:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80109a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80109d:	c1 e2 04             	shl    $0x4,%edx
  8010a0:	01 d0                	add    %edx,%eax
  8010a2:	8a 40 04             	mov    0x4(%eax),%al
  8010a5:	3c 01                	cmp    $0x1,%al
  8010a7:	75 03                	jne    8010ac <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8010a9:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8010ac:	ff 45 e0             	incl   -0x20(%ebp)
  8010af:	a1 20 40 80 00       	mov    0x804020,%eax
  8010b4:	8b 50 74             	mov    0x74(%eax),%edx
  8010b7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8010ba:	39 c2                	cmp    %eax,%edx
  8010bc:	77 d1                	ja     80108f <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8010be:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010c1:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8010c4:	74 14                	je     8010da <CheckWSWithoutLastIndex+0x159>
		panic(
  8010c6:	83 ec 04             	sub    $0x4,%esp
  8010c9:	68 8c 2c 80 00       	push   $0x802c8c
  8010ce:	6a 44                	push   $0x44
  8010d0:	68 2c 2c 80 00       	push   $0x802c2c
  8010d5:	e8 35 fe ff ff       	call   800f0f <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8010da:	90                   	nop
  8010db:	c9                   	leave  
  8010dc:	c3                   	ret    

008010dd <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8010dd:	55                   	push   %ebp
  8010de:	89 e5                	mov    %esp,%ebp
  8010e0:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8010e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e6:	8b 00                	mov    (%eax),%eax
  8010e8:	8d 48 01             	lea    0x1(%eax),%ecx
  8010eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010ee:	89 0a                	mov    %ecx,(%edx)
  8010f0:	8b 55 08             	mov    0x8(%ebp),%edx
  8010f3:	88 d1                	mov    %dl,%cl
  8010f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010f8:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8010fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ff:	8b 00                	mov    (%eax),%eax
  801101:	3d ff 00 00 00       	cmp    $0xff,%eax
  801106:	75 2c                	jne    801134 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  801108:	a0 24 40 80 00       	mov    0x804024,%al
  80110d:	0f b6 c0             	movzbl %al,%eax
  801110:	8b 55 0c             	mov    0xc(%ebp),%edx
  801113:	8b 12                	mov    (%edx),%edx
  801115:	89 d1                	mov    %edx,%ecx
  801117:	8b 55 0c             	mov    0xc(%ebp),%edx
  80111a:	83 c2 08             	add    $0x8,%edx
  80111d:	83 ec 04             	sub    $0x4,%esp
  801120:	50                   	push   %eax
  801121:	51                   	push   %ecx
  801122:	52                   	push   %edx
  801123:	e8 2e 0f 00 00       	call   802056 <sys_cputs>
  801128:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80112b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  801134:	8b 45 0c             	mov    0xc(%ebp),%eax
  801137:	8b 40 04             	mov    0x4(%eax),%eax
  80113a:	8d 50 01             	lea    0x1(%eax),%edx
  80113d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801140:	89 50 04             	mov    %edx,0x4(%eax)
}
  801143:	90                   	nop
  801144:	c9                   	leave  
  801145:	c3                   	ret    

00801146 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  801146:	55                   	push   %ebp
  801147:	89 e5                	mov    %esp,%ebp
  801149:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80114f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  801156:	00 00 00 
	b.cnt = 0;
  801159:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  801160:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  801163:	ff 75 0c             	pushl  0xc(%ebp)
  801166:	ff 75 08             	pushl  0x8(%ebp)
  801169:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80116f:	50                   	push   %eax
  801170:	68 dd 10 80 00       	push   $0x8010dd
  801175:	e8 11 02 00 00       	call   80138b <vprintfmt>
  80117a:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80117d:	a0 24 40 80 00       	mov    0x804024,%al
  801182:	0f b6 c0             	movzbl %al,%eax
  801185:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80118b:	83 ec 04             	sub    $0x4,%esp
  80118e:	50                   	push   %eax
  80118f:	52                   	push   %edx
  801190:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  801196:	83 c0 08             	add    $0x8,%eax
  801199:	50                   	push   %eax
  80119a:	e8 b7 0e 00 00       	call   802056 <sys_cputs>
  80119f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8011a2:	c6 05 24 40 80 00 00 	movb   $0x0,0x804024
	return b.cnt;
  8011a9:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8011af:	c9                   	leave  
  8011b0:	c3                   	ret    

008011b1 <cprintf>:

int cprintf(const char *fmt, ...) {
  8011b1:	55                   	push   %ebp
  8011b2:	89 e5                	mov    %esp,%ebp
  8011b4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8011b7:	c6 05 24 40 80 00 01 	movb   $0x1,0x804024
	va_start(ap, fmt);
  8011be:	8d 45 0c             	lea    0xc(%ebp),%eax
  8011c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8011c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c7:	83 ec 08             	sub    $0x8,%esp
  8011ca:	ff 75 f4             	pushl  -0xc(%ebp)
  8011cd:	50                   	push   %eax
  8011ce:	e8 73 ff ff ff       	call   801146 <vcprintf>
  8011d3:	83 c4 10             	add    $0x10,%esp
  8011d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8011d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8011dc:	c9                   	leave  
  8011dd:	c3                   	ret    

008011de <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8011de:	55                   	push   %ebp
  8011df:	89 e5                	mov    %esp,%ebp
  8011e1:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8011e4:	e8 7e 10 00 00       	call   802267 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8011e9:	8d 45 0c             	lea    0xc(%ebp),%eax
  8011ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8011ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f2:	83 ec 08             	sub    $0x8,%esp
  8011f5:	ff 75 f4             	pushl  -0xc(%ebp)
  8011f8:	50                   	push   %eax
  8011f9:	e8 48 ff ff ff       	call   801146 <vcprintf>
  8011fe:	83 c4 10             	add    $0x10,%esp
  801201:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  801204:	e8 78 10 00 00       	call   802281 <sys_enable_interrupt>
	return cnt;
  801209:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80120c:	c9                   	leave  
  80120d:	c3                   	ret    

0080120e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80120e:	55                   	push   %ebp
  80120f:	89 e5                	mov    %esp,%ebp
  801211:	53                   	push   %ebx
  801212:	83 ec 14             	sub    $0x14,%esp
  801215:	8b 45 10             	mov    0x10(%ebp),%eax
  801218:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80121b:	8b 45 14             	mov    0x14(%ebp),%eax
  80121e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  801221:	8b 45 18             	mov    0x18(%ebp),%eax
  801224:	ba 00 00 00 00       	mov    $0x0,%edx
  801229:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80122c:	77 55                	ja     801283 <printnum+0x75>
  80122e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  801231:	72 05                	jb     801238 <printnum+0x2a>
  801233:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801236:	77 4b                	ja     801283 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  801238:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80123b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80123e:	8b 45 18             	mov    0x18(%ebp),%eax
  801241:	ba 00 00 00 00       	mov    $0x0,%edx
  801246:	52                   	push   %edx
  801247:	50                   	push   %eax
  801248:	ff 75 f4             	pushl  -0xc(%ebp)
  80124b:	ff 75 f0             	pushl  -0x10(%ebp)
  80124e:	e8 35 14 00 00       	call   802688 <__udivdi3>
  801253:	83 c4 10             	add    $0x10,%esp
  801256:	83 ec 04             	sub    $0x4,%esp
  801259:	ff 75 20             	pushl  0x20(%ebp)
  80125c:	53                   	push   %ebx
  80125d:	ff 75 18             	pushl  0x18(%ebp)
  801260:	52                   	push   %edx
  801261:	50                   	push   %eax
  801262:	ff 75 0c             	pushl  0xc(%ebp)
  801265:	ff 75 08             	pushl  0x8(%ebp)
  801268:	e8 a1 ff ff ff       	call   80120e <printnum>
  80126d:	83 c4 20             	add    $0x20,%esp
  801270:	eb 1a                	jmp    80128c <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  801272:	83 ec 08             	sub    $0x8,%esp
  801275:	ff 75 0c             	pushl  0xc(%ebp)
  801278:	ff 75 20             	pushl  0x20(%ebp)
  80127b:	8b 45 08             	mov    0x8(%ebp),%eax
  80127e:	ff d0                	call   *%eax
  801280:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  801283:	ff 4d 1c             	decl   0x1c(%ebp)
  801286:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80128a:	7f e6                	jg     801272 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80128c:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80128f:	bb 00 00 00 00       	mov    $0x0,%ebx
  801294:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801297:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80129a:	53                   	push   %ebx
  80129b:	51                   	push   %ecx
  80129c:	52                   	push   %edx
  80129d:	50                   	push   %eax
  80129e:	e8 f5 14 00 00       	call   802798 <__umoddi3>
  8012a3:	83 c4 10             	add    $0x10,%esp
  8012a6:	05 f4 2e 80 00       	add    $0x802ef4,%eax
  8012ab:	8a 00                	mov    (%eax),%al
  8012ad:	0f be c0             	movsbl %al,%eax
  8012b0:	83 ec 08             	sub    $0x8,%esp
  8012b3:	ff 75 0c             	pushl  0xc(%ebp)
  8012b6:	50                   	push   %eax
  8012b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ba:	ff d0                	call   *%eax
  8012bc:	83 c4 10             	add    $0x10,%esp
}
  8012bf:	90                   	nop
  8012c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8012c3:	c9                   	leave  
  8012c4:	c3                   	ret    

008012c5 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8012c5:	55                   	push   %ebp
  8012c6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8012c8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8012cc:	7e 1c                	jle    8012ea <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8012ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d1:	8b 00                	mov    (%eax),%eax
  8012d3:	8d 50 08             	lea    0x8(%eax),%edx
  8012d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d9:	89 10                	mov    %edx,(%eax)
  8012db:	8b 45 08             	mov    0x8(%ebp),%eax
  8012de:	8b 00                	mov    (%eax),%eax
  8012e0:	83 e8 08             	sub    $0x8,%eax
  8012e3:	8b 50 04             	mov    0x4(%eax),%edx
  8012e6:	8b 00                	mov    (%eax),%eax
  8012e8:	eb 40                	jmp    80132a <getuint+0x65>
	else if (lflag)
  8012ea:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012ee:	74 1e                	je     80130e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8012f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f3:	8b 00                	mov    (%eax),%eax
  8012f5:	8d 50 04             	lea    0x4(%eax),%edx
  8012f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fb:	89 10                	mov    %edx,(%eax)
  8012fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801300:	8b 00                	mov    (%eax),%eax
  801302:	83 e8 04             	sub    $0x4,%eax
  801305:	8b 00                	mov    (%eax),%eax
  801307:	ba 00 00 00 00       	mov    $0x0,%edx
  80130c:	eb 1c                	jmp    80132a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80130e:	8b 45 08             	mov    0x8(%ebp),%eax
  801311:	8b 00                	mov    (%eax),%eax
  801313:	8d 50 04             	lea    0x4(%eax),%edx
  801316:	8b 45 08             	mov    0x8(%ebp),%eax
  801319:	89 10                	mov    %edx,(%eax)
  80131b:	8b 45 08             	mov    0x8(%ebp),%eax
  80131e:	8b 00                	mov    (%eax),%eax
  801320:	83 e8 04             	sub    $0x4,%eax
  801323:	8b 00                	mov    (%eax),%eax
  801325:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80132a:	5d                   	pop    %ebp
  80132b:	c3                   	ret    

0080132c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80132c:	55                   	push   %ebp
  80132d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80132f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  801333:	7e 1c                	jle    801351 <getint+0x25>
		return va_arg(*ap, long long);
  801335:	8b 45 08             	mov    0x8(%ebp),%eax
  801338:	8b 00                	mov    (%eax),%eax
  80133a:	8d 50 08             	lea    0x8(%eax),%edx
  80133d:	8b 45 08             	mov    0x8(%ebp),%eax
  801340:	89 10                	mov    %edx,(%eax)
  801342:	8b 45 08             	mov    0x8(%ebp),%eax
  801345:	8b 00                	mov    (%eax),%eax
  801347:	83 e8 08             	sub    $0x8,%eax
  80134a:	8b 50 04             	mov    0x4(%eax),%edx
  80134d:	8b 00                	mov    (%eax),%eax
  80134f:	eb 38                	jmp    801389 <getint+0x5d>
	else if (lflag)
  801351:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801355:	74 1a                	je     801371 <getint+0x45>
		return va_arg(*ap, long);
  801357:	8b 45 08             	mov    0x8(%ebp),%eax
  80135a:	8b 00                	mov    (%eax),%eax
  80135c:	8d 50 04             	lea    0x4(%eax),%edx
  80135f:	8b 45 08             	mov    0x8(%ebp),%eax
  801362:	89 10                	mov    %edx,(%eax)
  801364:	8b 45 08             	mov    0x8(%ebp),%eax
  801367:	8b 00                	mov    (%eax),%eax
  801369:	83 e8 04             	sub    $0x4,%eax
  80136c:	8b 00                	mov    (%eax),%eax
  80136e:	99                   	cltd   
  80136f:	eb 18                	jmp    801389 <getint+0x5d>
	else
		return va_arg(*ap, int);
  801371:	8b 45 08             	mov    0x8(%ebp),%eax
  801374:	8b 00                	mov    (%eax),%eax
  801376:	8d 50 04             	lea    0x4(%eax),%edx
  801379:	8b 45 08             	mov    0x8(%ebp),%eax
  80137c:	89 10                	mov    %edx,(%eax)
  80137e:	8b 45 08             	mov    0x8(%ebp),%eax
  801381:	8b 00                	mov    (%eax),%eax
  801383:	83 e8 04             	sub    $0x4,%eax
  801386:	8b 00                	mov    (%eax),%eax
  801388:	99                   	cltd   
}
  801389:	5d                   	pop    %ebp
  80138a:	c3                   	ret    

0080138b <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80138b:	55                   	push   %ebp
  80138c:	89 e5                	mov    %esp,%ebp
  80138e:	56                   	push   %esi
  80138f:	53                   	push   %ebx
  801390:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  801393:	eb 17                	jmp    8013ac <vprintfmt+0x21>
			if (ch == '\0')
  801395:	85 db                	test   %ebx,%ebx
  801397:	0f 84 af 03 00 00    	je     80174c <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80139d:	83 ec 08             	sub    $0x8,%esp
  8013a0:	ff 75 0c             	pushl  0xc(%ebp)
  8013a3:	53                   	push   %ebx
  8013a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a7:	ff d0                	call   *%eax
  8013a9:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8013ac:	8b 45 10             	mov    0x10(%ebp),%eax
  8013af:	8d 50 01             	lea    0x1(%eax),%edx
  8013b2:	89 55 10             	mov    %edx,0x10(%ebp)
  8013b5:	8a 00                	mov    (%eax),%al
  8013b7:	0f b6 d8             	movzbl %al,%ebx
  8013ba:	83 fb 25             	cmp    $0x25,%ebx
  8013bd:	75 d6                	jne    801395 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8013bf:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8013c3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8013ca:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8013d1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8013d8:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8013df:	8b 45 10             	mov    0x10(%ebp),%eax
  8013e2:	8d 50 01             	lea    0x1(%eax),%edx
  8013e5:	89 55 10             	mov    %edx,0x10(%ebp)
  8013e8:	8a 00                	mov    (%eax),%al
  8013ea:	0f b6 d8             	movzbl %al,%ebx
  8013ed:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8013f0:	83 f8 55             	cmp    $0x55,%eax
  8013f3:	0f 87 2b 03 00 00    	ja     801724 <vprintfmt+0x399>
  8013f9:	8b 04 85 18 2f 80 00 	mov    0x802f18(,%eax,4),%eax
  801400:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  801402:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  801406:	eb d7                	jmp    8013df <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  801408:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80140c:	eb d1                	jmp    8013df <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80140e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  801415:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801418:	89 d0                	mov    %edx,%eax
  80141a:	c1 e0 02             	shl    $0x2,%eax
  80141d:	01 d0                	add    %edx,%eax
  80141f:	01 c0                	add    %eax,%eax
  801421:	01 d8                	add    %ebx,%eax
  801423:	83 e8 30             	sub    $0x30,%eax
  801426:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  801429:	8b 45 10             	mov    0x10(%ebp),%eax
  80142c:	8a 00                	mov    (%eax),%al
  80142e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  801431:	83 fb 2f             	cmp    $0x2f,%ebx
  801434:	7e 3e                	jle    801474 <vprintfmt+0xe9>
  801436:	83 fb 39             	cmp    $0x39,%ebx
  801439:	7f 39                	jg     801474 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80143b:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80143e:	eb d5                	jmp    801415 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  801440:	8b 45 14             	mov    0x14(%ebp),%eax
  801443:	83 c0 04             	add    $0x4,%eax
  801446:	89 45 14             	mov    %eax,0x14(%ebp)
  801449:	8b 45 14             	mov    0x14(%ebp),%eax
  80144c:	83 e8 04             	sub    $0x4,%eax
  80144f:	8b 00                	mov    (%eax),%eax
  801451:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  801454:	eb 1f                	jmp    801475 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  801456:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80145a:	79 83                	jns    8013df <vprintfmt+0x54>
				width = 0;
  80145c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  801463:	e9 77 ff ff ff       	jmp    8013df <vprintfmt+0x54>

		case '#':
			altflag = 1;
  801468:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80146f:	e9 6b ff ff ff       	jmp    8013df <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  801474:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  801475:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801479:	0f 89 60 ff ff ff    	jns    8013df <vprintfmt+0x54>
				width = precision, precision = -1;
  80147f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801482:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  801485:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80148c:	e9 4e ff ff ff       	jmp    8013df <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  801491:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  801494:	e9 46 ff ff ff       	jmp    8013df <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  801499:	8b 45 14             	mov    0x14(%ebp),%eax
  80149c:	83 c0 04             	add    $0x4,%eax
  80149f:	89 45 14             	mov    %eax,0x14(%ebp)
  8014a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8014a5:	83 e8 04             	sub    $0x4,%eax
  8014a8:	8b 00                	mov    (%eax),%eax
  8014aa:	83 ec 08             	sub    $0x8,%esp
  8014ad:	ff 75 0c             	pushl  0xc(%ebp)
  8014b0:	50                   	push   %eax
  8014b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b4:	ff d0                	call   *%eax
  8014b6:	83 c4 10             	add    $0x10,%esp
			break;
  8014b9:	e9 89 02 00 00       	jmp    801747 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8014be:	8b 45 14             	mov    0x14(%ebp),%eax
  8014c1:	83 c0 04             	add    $0x4,%eax
  8014c4:	89 45 14             	mov    %eax,0x14(%ebp)
  8014c7:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ca:	83 e8 04             	sub    $0x4,%eax
  8014cd:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8014cf:	85 db                	test   %ebx,%ebx
  8014d1:	79 02                	jns    8014d5 <vprintfmt+0x14a>
				err = -err;
  8014d3:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8014d5:	83 fb 64             	cmp    $0x64,%ebx
  8014d8:	7f 0b                	jg     8014e5 <vprintfmt+0x15a>
  8014da:	8b 34 9d 60 2d 80 00 	mov    0x802d60(,%ebx,4),%esi
  8014e1:	85 f6                	test   %esi,%esi
  8014e3:	75 19                	jne    8014fe <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8014e5:	53                   	push   %ebx
  8014e6:	68 05 2f 80 00       	push   $0x802f05
  8014eb:	ff 75 0c             	pushl  0xc(%ebp)
  8014ee:	ff 75 08             	pushl  0x8(%ebp)
  8014f1:	e8 5e 02 00 00       	call   801754 <printfmt>
  8014f6:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8014f9:	e9 49 02 00 00       	jmp    801747 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8014fe:	56                   	push   %esi
  8014ff:	68 0e 2f 80 00       	push   $0x802f0e
  801504:	ff 75 0c             	pushl  0xc(%ebp)
  801507:	ff 75 08             	pushl  0x8(%ebp)
  80150a:	e8 45 02 00 00       	call   801754 <printfmt>
  80150f:	83 c4 10             	add    $0x10,%esp
			break;
  801512:	e9 30 02 00 00       	jmp    801747 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  801517:	8b 45 14             	mov    0x14(%ebp),%eax
  80151a:	83 c0 04             	add    $0x4,%eax
  80151d:	89 45 14             	mov    %eax,0x14(%ebp)
  801520:	8b 45 14             	mov    0x14(%ebp),%eax
  801523:	83 e8 04             	sub    $0x4,%eax
  801526:	8b 30                	mov    (%eax),%esi
  801528:	85 f6                	test   %esi,%esi
  80152a:	75 05                	jne    801531 <vprintfmt+0x1a6>
				p = "(null)";
  80152c:	be 11 2f 80 00       	mov    $0x802f11,%esi
			if (width > 0 && padc != '-')
  801531:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801535:	7e 6d                	jle    8015a4 <vprintfmt+0x219>
  801537:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80153b:	74 67                	je     8015a4 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80153d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801540:	83 ec 08             	sub    $0x8,%esp
  801543:	50                   	push   %eax
  801544:	56                   	push   %esi
  801545:	e8 0c 03 00 00       	call   801856 <strnlen>
  80154a:	83 c4 10             	add    $0x10,%esp
  80154d:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  801550:	eb 16                	jmp    801568 <vprintfmt+0x1dd>
					putch(padc, putdat);
  801552:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  801556:	83 ec 08             	sub    $0x8,%esp
  801559:	ff 75 0c             	pushl  0xc(%ebp)
  80155c:	50                   	push   %eax
  80155d:	8b 45 08             	mov    0x8(%ebp),%eax
  801560:	ff d0                	call   *%eax
  801562:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  801565:	ff 4d e4             	decl   -0x1c(%ebp)
  801568:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80156c:	7f e4                	jg     801552 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80156e:	eb 34                	jmp    8015a4 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  801570:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  801574:	74 1c                	je     801592 <vprintfmt+0x207>
  801576:	83 fb 1f             	cmp    $0x1f,%ebx
  801579:	7e 05                	jle    801580 <vprintfmt+0x1f5>
  80157b:	83 fb 7e             	cmp    $0x7e,%ebx
  80157e:	7e 12                	jle    801592 <vprintfmt+0x207>
					putch('?', putdat);
  801580:	83 ec 08             	sub    $0x8,%esp
  801583:	ff 75 0c             	pushl  0xc(%ebp)
  801586:	6a 3f                	push   $0x3f
  801588:	8b 45 08             	mov    0x8(%ebp),%eax
  80158b:	ff d0                	call   *%eax
  80158d:	83 c4 10             	add    $0x10,%esp
  801590:	eb 0f                	jmp    8015a1 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801592:	83 ec 08             	sub    $0x8,%esp
  801595:	ff 75 0c             	pushl  0xc(%ebp)
  801598:	53                   	push   %ebx
  801599:	8b 45 08             	mov    0x8(%ebp),%eax
  80159c:	ff d0                	call   *%eax
  80159e:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8015a1:	ff 4d e4             	decl   -0x1c(%ebp)
  8015a4:	89 f0                	mov    %esi,%eax
  8015a6:	8d 70 01             	lea    0x1(%eax),%esi
  8015a9:	8a 00                	mov    (%eax),%al
  8015ab:	0f be d8             	movsbl %al,%ebx
  8015ae:	85 db                	test   %ebx,%ebx
  8015b0:	74 24                	je     8015d6 <vprintfmt+0x24b>
  8015b2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8015b6:	78 b8                	js     801570 <vprintfmt+0x1e5>
  8015b8:	ff 4d e0             	decl   -0x20(%ebp)
  8015bb:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8015bf:	79 af                	jns    801570 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8015c1:	eb 13                	jmp    8015d6 <vprintfmt+0x24b>
				putch(' ', putdat);
  8015c3:	83 ec 08             	sub    $0x8,%esp
  8015c6:	ff 75 0c             	pushl  0xc(%ebp)
  8015c9:	6a 20                	push   $0x20
  8015cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ce:	ff d0                	call   *%eax
  8015d0:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8015d3:	ff 4d e4             	decl   -0x1c(%ebp)
  8015d6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8015da:	7f e7                	jg     8015c3 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8015dc:	e9 66 01 00 00       	jmp    801747 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8015e1:	83 ec 08             	sub    $0x8,%esp
  8015e4:	ff 75 e8             	pushl  -0x18(%ebp)
  8015e7:	8d 45 14             	lea    0x14(%ebp),%eax
  8015ea:	50                   	push   %eax
  8015eb:	e8 3c fd ff ff       	call   80132c <getint>
  8015f0:	83 c4 10             	add    $0x10,%esp
  8015f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8015f6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8015f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8015fc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8015ff:	85 d2                	test   %edx,%edx
  801601:	79 23                	jns    801626 <vprintfmt+0x29b>
				putch('-', putdat);
  801603:	83 ec 08             	sub    $0x8,%esp
  801606:	ff 75 0c             	pushl  0xc(%ebp)
  801609:	6a 2d                	push   $0x2d
  80160b:	8b 45 08             	mov    0x8(%ebp),%eax
  80160e:	ff d0                	call   *%eax
  801610:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801613:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801616:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801619:	f7 d8                	neg    %eax
  80161b:	83 d2 00             	adc    $0x0,%edx
  80161e:	f7 da                	neg    %edx
  801620:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801623:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801626:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80162d:	e9 bc 00 00 00       	jmp    8016ee <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801632:	83 ec 08             	sub    $0x8,%esp
  801635:	ff 75 e8             	pushl  -0x18(%ebp)
  801638:	8d 45 14             	lea    0x14(%ebp),%eax
  80163b:	50                   	push   %eax
  80163c:	e8 84 fc ff ff       	call   8012c5 <getuint>
  801641:	83 c4 10             	add    $0x10,%esp
  801644:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801647:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80164a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801651:	e9 98 00 00 00       	jmp    8016ee <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801656:	83 ec 08             	sub    $0x8,%esp
  801659:	ff 75 0c             	pushl  0xc(%ebp)
  80165c:	6a 58                	push   $0x58
  80165e:	8b 45 08             	mov    0x8(%ebp),%eax
  801661:	ff d0                	call   *%eax
  801663:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801666:	83 ec 08             	sub    $0x8,%esp
  801669:	ff 75 0c             	pushl  0xc(%ebp)
  80166c:	6a 58                	push   $0x58
  80166e:	8b 45 08             	mov    0x8(%ebp),%eax
  801671:	ff d0                	call   *%eax
  801673:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801676:	83 ec 08             	sub    $0x8,%esp
  801679:	ff 75 0c             	pushl  0xc(%ebp)
  80167c:	6a 58                	push   $0x58
  80167e:	8b 45 08             	mov    0x8(%ebp),%eax
  801681:	ff d0                	call   *%eax
  801683:	83 c4 10             	add    $0x10,%esp
			break;
  801686:	e9 bc 00 00 00       	jmp    801747 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80168b:	83 ec 08             	sub    $0x8,%esp
  80168e:	ff 75 0c             	pushl  0xc(%ebp)
  801691:	6a 30                	push   $0x30
  801693:	8b 45 08             	mov    0x8(%ebp),%eax
  801696:	ff d0                	call   *%eax
  801698:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80169b:	83 ec 08             	sub    $0x8,%esp
  80169e:	ff 75 0c             	pushl  0xc(%ebp)
  8016a1:	6a 78                	push   $0x78
  8016a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a6:	ff d0                	call   *%eax
  8016a8:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8016ab:	8b 45 14             	mov    0x14(%ebp),%eax
  8016ae:	83 c0 04             	add    $0x4,%eax
  8016b1:	89 45 14             	mov    %eax,0x14(%ebp)
  8016b4:	8b 45 14             	mov    0x14(%ebp),%eax
  8016b7:	83 e8 04             	sub    $0x4,%eax
  8016ba:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8016bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8016bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8016c6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8016cd:	eb 1f                	jmp    8016ee <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8016cf:	83 ec 08             	sub    $0x8,%esp
  8016d2:	ff 75 e8             	pushl  -0x18(%ebp)
  8016d5:	8d 45 14             	lea    0x14(%ebp),%eax
  8016d8:	50                   	push   %eax
  8016d9:	e8 e7 fb ff ff       	call   8012c5 <getuint>
  8016de:	83 c4 10             	add    $0x10,%esp
  8016e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8016e4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8016e7:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8016ee:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8016f2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8016f5:	83 ec 04             	sub    $0x4,%esp
  8016f8:	52                   	push   %edx
  8016f9:	ff 75 e4             	pushl  -0x1c(%ebp)
  8016fc:	50                   	push   %eax
  8016fd:	ff 75 f4             	pushl  -0xc(%ebp)
  801700:	ff 75 f0             	pushl  -0x10(%ebp)
  801703:	ff 75 0c             	pushl  0xc(%ebp)
  801706:	ff 75 08             	pushl  0x8(%ebp)
  801709:	e8 00 fb ff ff       	call   80120e <printnum>
  80170e:	83 c4 20             	add    $0x20,%esp
			break;
  801711:	eb 34                	jmp    801747 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801713:	83 ec 08             	sub    $0x8,%esp
  801716:	ff 75 0c             	pushl  0xc(%ebp)
  801719:	53                   	push   %ebx
  80171a:	8b 45 08             	mov    0x8(%ebp),%eax
  80171d:	ff d0                	call   *%eax
  80171f:	83 c4 10             	add    $0x10,%esp
			break;
  801722:	eb 23                	jmp    801747 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801724:	83 ec 08             	sub    $0x8,%esp
  801727:	ff 75 0c             	pushl  0xc(%ebp)
  80172a:	6a 25                	push   $0x25
  80172c:	8b 45 08             	mov    0x8(%ebp),%eax
  80172f:	ff d0                	call   *%eax
  801731:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801734:	ff 4d 10             	decl   0x10(%ebp)
  801737:	eb 03                	jmp    80173c <vprintfmt+0x3b1>
  801739:	ff 4d 10             	decl   0x10(%ebp)
  80173c:	8b 45 10             	mov    0x10(%ebp),%eax
  80173f:	48                   	dec    %eax
  801740:	8a 00                	mov    (%eax),%al
  801742:	3c 25                	cmp    $0x25,%al
  801744:	75 f3                	jne    801739 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801746:	90                   	nop
		}
	}
  801747:	e9 47 fc ff ff       	jmp    801393 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80174c:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80174d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801750:	5b                   	pop    %ebx
  801751:	5e                   	pop    %esi
  801752:	5d                   	pop    %ebp
  801753:	c3                   	ret    

00801754 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801754:	55                   	push   %ebp
  801755:	89 e5                	mov    %esp,%ebp
  801757:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80175a:	8d 45 10             	lea    0x10(%ebp),%eax
  80175d:	83 c0 04             	add    $0x4,%eax
  801760:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801763:	8b 45 10             	mov    0x10(%ebp),%eax
  801766:	ff 75 f4             	pushl  -0xc(%ebp)
  801769:	50                   	push   %eax
  80176a:	ff 75 0c             	pushl  0xc(%ebp)
  80176d:	ff 75 08             	pushl  0x8(%ebp)
  801770:	e8 16 fc ff ff       	call   80138b <vprintfmt>
  801775:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801778:	90                   	nop
  801779:	c9                   	leave  
  80177a:	c3                   	ret    

0080177b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80177b:	55                   	push   %ebp
  80177c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80177e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801781:	8b 40 08             	mov    0x8(%eax),%eax
  801784:	8d 50 01             	lea    0x1(%eax),%edx
  801787:	8b 45 0c             	mov    0xc(%ebp),%eax
  80178a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80178d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801790:	8b 10                	mov    (%eax),%edx
  801792:	8b 45 0c             	mov    0xc(%ebp),%eax
  801795:	8b 40 04             	mov    0x4(%eax),%eax
  801798:	39 c2                	cmp    %eax,%edx
  80179a:	73 12                	jae    8017ae <sprintputch+0x33>
		*b->buf++ = ch;
  80179c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80179f:	8b 00                	mov    (%eax),%eax
  8017a1:	8d 48 01             	lea    0x1(%eax),%ecx
  8017a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017a7:	89 0a                	mov    %ecx,(%edx)
  8017a9:	8b 55 08             	mov    0x8(%ebp),%edx
  8017ac:	88 10                	mov    %dl,(%eax)
}
  8017ae:	90                   	nop
  8017af:	5d                   	pop    %ebp
  8017b0:	c3                   	ret    

008017b1 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8017b1:	55                   	push   %ebp
  8017b2:	89 e5                	mov    %esp,%ebp
  8017b4:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8017b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ba:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8017bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8017c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c6:	01 d0                	add    %edx,%eax
  8017c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8017cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8017d2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017d6:	74 06                	je     8017de <vsnprintf+0x2d>
  8017d8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8017dc:	7f 07                	jg     8017e5 <vsnprintf+0x34>
		return -E_INVAL;
  8017de:	b8 03 00 00 00       	mov    $0x3,%eax
  8017e3:	eb 20                	jmp    801805 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8017e5:	ff 75 14             	pushl  0x14(%ebp)
  8017e8:	ff 75 10             	pushl  0x10(%ebp)
  8017eb:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8017ee:	50                   	push   %eax
  8017ef:	68 7b 17 80 00       	push   $0x80177b
  8017f4:	e8 92 fb ff ff       	call   80138b <vprintfmt>
  8017f9:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8017fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8017ff:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801802:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801805:	c9                   	leave  
  801806:	c3                   	ret    

00801807 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801807:	55                   	push   %ebp
  801808:	89 e5                	mov    %esp,%ebp
  80180a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80180d:	8d 45 10             	lea    0x10(%ebp),%eax
  801810:	83 c0 04             	add    $0x4,%eax
  801813:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801816:	8b 45 10             	mov    0x10(%ebp),%eax
  801819:	ff 75 f4             	pushl  -0xc(%ebp)
  80181c:	50                   	push   %eax
  80181d:	ff 75 0c             	pushl  0xc(%ebp)
  801820:	ff 75 08             	pushl  0x8(%ebp)
  801823:	e8 89 ff ff ff       	call   8017b1 <vsnprintf>
  801828:	83 c4 10             	add    $0x10,%esp
  80182b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80182e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801831:	c9                   	leave  
  801832:	c3                   	ret    

00801833 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801833:	55                   	push   %ebp
  801834:	89 e5                	mov    %esp,%ebp
  801836:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801839:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801840:	eb 06                	jmp    801848 <strlen+0x15>
		n++;
  801842:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801845:	ff 45 08             	incl   0x8(%ebp)
  801848:	8b 45 08             	mov    0x8(%ebp),%eax
  80184b:	8a 00                	mov    (%eax),%al
  80184d:	84 c0                	test   %al,%al
  80184f:	75 f1                	jne    801842 <strlen+0xf>
		n++;
	return n;
  801851:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801854:	c9                   	leave  
  801855:	c3                   	ret    

00801856 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801856:	55                   	push   %ebp
  801857:	89 e5                	mov    %esp,%ebp
  801859:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80185c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801863:	eb 09                	jmp    80186e <strnlen+0x18>
		n++;
  801865:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801868:	ff 45 08             	incl   0x8(%ebp)
  80186b:	ff 4d 0c             	decl   0xc(%ebp)
  80186e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801872:	74 09                	je     80187d <strnlen+0x27>
  801874:	8b 45 08             	mov    0x8(%ebp),%eax
  801877:	8a 00                	mov    (%eax),%al
  801879:	84 c0                	test   %al,%al
  80187b:	75 e8                	jne    801865 <strnlen+0xf>
		n++;
	return n;
  80187d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801880:	c9                   	leave  
  801881:	c3                   	ret    

00801882 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801882:	55                   	push   %ebp
  801883:	89 e5                	mov    %esp,%ebp
  801885:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801888:	8b 45 08             	mov    0x8(%ebp),%eax
  80188b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80188e:	90                   	nop
  80188f:	8b 45 08             	mov    0x8(%ebp),%eax
  801892:	8d 50 01             	lea    0x1(%eax),%edx
  801895:	89 55 08             	mov    %edx,0x8(%ebp)
  801898:	8b 55 0c             	mov    0xc(%ebp),%edx
  80189b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80189e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8018a1:	8a 12                	mov    (%edx),%dl
  8018a3:	88 10                	mov    %dl,(%eax)
  8018a5:	8a 00                	mov    (%eax),%al
  8018a7:	84 c0                	test   %al,%al
  8018a9:	75 e4                	jne    80188f <strcpy+0xd>
		/* do nothing */;
	return ret;
  8018ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8018ae:	c9                   	leave  
  8018af:	c3                   	ret    

008018b0 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8018b0:	55                   	push   %ebp
  8018b1:	89 e5                	mov    %esp,%ebp
  8018b3:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8018b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8018bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018c3:	eb 1f                	jmp    8018e4 <strncpy+0x34>
		*dst++ = *src;
  8018c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c8:	8d 50 01             	lea    0x1(%eax),%edx
  8018cb:	89 55 08             	mov    %edx,0x8(%ebp)
  8018ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018d1:	8a 12                	mov    (%edx),%dl
  8018d3:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8018d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018d8:	8a 00                	mov    (%eax),%al
  8018da:	84 c0                	test   %al,%al
  8018dc:	74 03                	je     8018e1 <strncpy+0x31>
			src++;
  8018de:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8018e1:	ff 45 fc             	incl   -0x4(%ebp)
  8018e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018e7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8018ea:	72 d9                	jb     8018c5 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8018ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8018ef:	c9                   	leave  
  8018f0:	c3                   	ret    

008018f1 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8018f1:	55                   	push   %ebp
  8018f2:	89 e5                	mov    %esp,%ebp
  8018f4:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8018f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8018fd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801901:	74 30                	je     801933 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801903:	eb 16                	jmp    80191b <strlcpy+0x2a>
			*dst++ = *src++;
  801905:	8b 45 08             	mov    0x8(%ebp),%eax
  801908:	8d 50 01             	lea    0x1(%eax),%edx
  80190b:	89 55 08             	mov    %edx,0x8(%ebp)
  80190e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801911:	8d 4a 01             	lea    0x1(%edx),%ecx
  801914:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801917:	8a 12                	mov    (%edx),%dl
  801919:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80191b:	ff 4d 10             	decl   0x10(%ebp)
  80191e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801922:	74 09                	je     80192d <strlcpy+0x3c>
  801924:	8b 45 0c             	mov    0xc(%ebp),%eax
  801927:	8a 00                	mov    (%eax),%al
  801929:	84 c0                	test   %al,%al
  80192b:	75 d8                	jne    801905 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80192d:	8b 45 08             	mov    0x8(%ebp),%eax
  801930:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801933:	8b 55 08             	mov    0x8(%ebp),%edx
  801936:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801939:	29 c2                	sub    %eax,%edx
  80193b:	89 d0                	mov    %edx,%eax
}
  80193d:	c9                   	leave  
  80193e:	c3                   	ret    

0080193f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80193f:	55                   	push   %ebp
  801940:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801942:	eb 06                	jmp    80194a <strcmp+0xb>
		p++, q++;
  801944:	ff 45 08             	incl   0x8(%ebp)
  801947:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80194a:	8b 45 08             	mov    0x8(%ebp),%eax
  80194d:	8a 00                	mov    (%eax),%al
  80194f:	84 c0                	test   %al,%al
  801951:	74 0e                	je     801961 <strcmp+0x22>
  801953:	8b 45 08             	mov    0x8(%ebp),%eax
  801956:	8a 10                	mov    (%eax),%dl
  801958:	8b 45 0c             	mov    0xc(%ebp),%eax
  80195b:	8a 00                	mov    (%eax),%al
  80195d:	38 c2                	cmp    %al,%dl
  80195f:	74 e3                	je     801944 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801961:	8b 45 08             	mov    0x8(%ebp),%eax
  801964:	8a 00                	mov    (%eax),%al
  801966:	0f b6 d0             	movzbl %al,%edx
  801969:	8b 45 0c             	mov    0xc(%ebp),%eax
  80196c:	8a 00                	mov    (%eax),%al
  80196e:	0f b6 c0             	movzbl %al,%eax
  801971:	29 c2                	sub    %eax,%edx
  801973:	89 d0                	mov    %edx,%eax
}
  801975:	5d                   	pop    %ebp
  801976:	c3                   	ret    

00801977 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801977:	55                   	push   %ebp
  801978:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80197a:	eb 09                	jmp    801985 <strncmp+0xe>
		n--, p++, q++;
  80197c:	ff 4d 10             	decl   0x10(%ebp)
  80197f:	ff 45 08             	incl   0x8(%ebp)
  801982:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801985:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801989:	74 17                	je     8019a2 <strncmp+0x2b>
  80198b:	8b 45 08             	mov    0x8(%ebp),%eax
  80198e:	8a 00                	mov    (%eax),%al
  801990:	84 c0                	test   %al,%al
  801992:	74 0e                	je     8019a2 <strncmp+0x2b>
  801994:	8b 45 08             	mov    0x8(%ebp),%eax
  801997:	8a 10                	mov    (%eax),%dl
  801999:	8b 45 0c             	mov    0xc(%ebp),%eax
  80199c:	8a 00                	mov    (%eax),%al
  80199e:	38 c2                	cmp    %al,%dl
  8019a0:	74 da                	je     80197c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8019a2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8019a6:	75 07                	jne    8019af <strncmp+0x38>
		return 0;
  8019a8:	b8 00 00 00 00       	mov    $0x0,%eax
  8019ad:	eb 14                	jmp    8019c3 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8019af:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b2:	8a 00                	mov    (%eax),%al
  8019b4:	0f b6 d0             	movzbl %al,%edx
  8019b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019ba:	8a 00                	mov    (%eax),%al
  8019bc:	0f b6 c0             	movzbl %al,%eax
  8019bf:	29 c2                	sub    %eax,%edx
  8019c1:	89 d0                	mov    %edx,%eax
}
  8019c3:	5d                   	pop    %ebp
  8019c4:	c3                   	ret    

008019c5 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8019c5:	55                   	push   %ebp
  8019c6:	89 e5                	mov    %esp,%ebp
  8019c8:	83 ec 04             	sub    $0x4,%esp
  8019cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019ce:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8019d1:	eb 12                	jmp    8019e5 <strchr+0x20>
		if (*s == c)
  8019d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d6:	8a 00                	mov    (%eax),%al
  8019d8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8019db:	75 05                	jne    8019e2 <strchr+0x1d>
			return (char *) s;
  8019dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e0:	eb 11                	jmp    8019f3 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8019e2:	ff 45 08             	incl   0x8(%ebp)
  8019e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e8:	8a 00                	mov    (%eax),%al
  8019ea:	84 c0                	test   %al,%al
  8019ec:	75 e5                	jne    8019d3 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8019ee:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019f3:	c9                   	leave  
  8019f4:	c3                   	ret    

008019f5 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8019f5:	55                   	push   %ebp
  8019f6:	89 e5                	mov    %esp,%ebp
  8019f8:	83 ec 04             	sub    $0x4,%esp
  8019fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019fe:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801a01:	eb 0d                	jmp    801a10 <strfind+0x1b>
		if (*s == c)
  801a03:	8b 45 08             	mov    0x8(%ebp),%eax
  801a06:	8a 00                	mov    (%eax),%al
  801a08:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801a0b:	74 0e                	je     801a1b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801a0d:	ff 45 08             	incl   0x8(%ebp)
  801a10:	8b 45 08             	mov    0x8(%ebp),%eax
  801a13:	8a 00                	mov    (%eax),%al
  801a15:	84 c0                	test   %al,%al
  801a17:	75 ea                	jne    801a03 <strfind+0xe>
  801a19:	eb 01                	jmp    801a1c <strfind+0x27>
		if (*s == c)
			break;
  801a1b:	90                   	nop
	return (char *) s;
  801a1c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801a1f:	c9                   	leave  
  801a20:	c3                   	ret    

00801a21 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801a21:	55                   	push   %ebp
  801a22:	89 e5                	mov    %esp,%ebp
  801a24:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801a27:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801a2d:	8b 45 10             	mov    0x10(%ebp),%eax
  801a30:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801a33:	eb 0e                	jmp    801a43 <memset+0x22>
		*p++ = c;
  801a35:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a38:	8d 50 01             	lea    0x1(%eax),%edx
  801a3b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a3e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a41:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801a43:	ff 4d f8             	decl   -0x8(%ebp)
  801a46:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801a4a:	79 e9                	jns    801a35 <memset+0x14>
		*p++ = c;

	return v;
  801a4c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801a4f:	c9                   	leave  
  801a50:	c3                   	ret    

00801a51 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801a51:	55                   	push   %ebp
  801a52:	89 e5                	mov    %esp,%ebp
  801a54:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801a57:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a5a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801a5d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a60:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801a63:	eb 16                	jmp    801a7b <memcpy+0x2a>
		*d++ = *s++;
  801a65:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a68:	8d 50 01             	lea    0x1(%eax),%edx
  801a6b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801a6e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a71:	8d 4a 01             	lea    0x1(%edx),%ecx
  801a74:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801a77:	8a 12                	mov    (%edx),%dl
  801a79:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801a7b:	8b 45 10             	mov    0x10(%ebp),%eax
  801a7e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801a81:	89 55 10             	mov    %edx,0x10(%ebp)
  801a84:	85 c0                	test   %eax,%eax
  801a86:	75 dd                	jne    801a65 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801a88:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801a8b:	c9                   	leave  
  801a8c:	c3                   	ret    

00801a8d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801a8d:	55                   	push   %ebp
  801a8e:	89 e5                	mov    %esp,%ebp
  801a90:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801a93:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a96:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801a99:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801a9f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801aa2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801aa5:	73 50                	jae    801af7 <memmove+0x6a>
  801aa7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801aaa:	8b 45 10             	mov    0x10(%ebp),%eax
  801aad:	01 d0                	add    %edx,%eax
  801aaf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801ab2:	76 43                	jbe    801af7 <memmove+0x6a>
		s += n;
  801ab4:	8b 45 10             	mov    0x10(%ebp),%eax
  801ab7:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801aba:	8b 45 10             	mov    0x10(%ebp),%eax
  801abd:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801ac0:	eb 10                	jmp    801ad2 <memmove+0x45>
			*--d = *--s;
  801ac2:	ff 4d f8             	decl   -0x8(%ebp)
  801ac5:	ff 4d fc             	decl   -0x4(%ebp)
  801ac8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801acb:	8a 10                	mov    (%eax),%dl
  801acd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ad0:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801ad2:	8b 45 10             	mov    0x10(%ebp),%eax
  801ad5:	8d 50 ff             	lea    -0x1(%eax),%edx
  801ad8:	89 55 10             	mov    %edx,0x10(%ebp)
  801adb:	85 c0                	test   %eax,%eax
  801add:	75 e3                	jne    801ac2 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801adf:	eb 23                	jmp    801b04 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801ae1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ae4:	8d 50 01             	lea    0x1(%eax),%edx
  801ae7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801aea:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801aed:	8d 4a 01             	lea    0x1(%edx),%ecx
  801af0:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801af3:	8a 12                	mov    (%edx),%dl
  801af5:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801af7:	8b 45 10             	mov    0x10(%ebp),%eax
  801afa:	8d 50 ff             	lea    -0x1(%eax),%edx
  801afd:	89 55 10             	mov    %edx,0x10(%ebp)
  801b00:	85 c0                	test   %eax,%eax
  801b02:	75 dd                	jne    801ae1 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801b04:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801b07:	c9                   	leave  
  801b08:	c3                   	ret    

00801b09 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801b09:	55                   	push   %ebp
  801b0a:	89 e5                	mov    %esp,%ebp
  801b0c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801b0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b12:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801b15:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b18:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801b1b:	eb 2a                	jmp    801b47 <memcmp+0x3e>
		if (*s1 != *s2)
  801b1d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b20:	8a 10                	mov    (%eax),%dl
  801b22:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b25:	8a 00                	mov    (%eax),%al
  801b27:	38 c2                	cmp    %al,%dl
  801b29:	74 16                	je     801b41 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801b2b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801b2e:	8a 00                	mov    (%eax),%al
  801b30:	0f b6 d0             	movzbl %al,%edx
  801b33:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b36:	8a 00                	mov    (%eax),%al
  801b38:	0f b6 c0             	movzbl %al,%eax
  801b3b:	29 c2                	sub    %eax,%edx
  801b3d:	89 d0                	mov    %edx,%eax
  801b3f:	eb 18                	jmp    801b59 <memcmp+0x50>
		s1++, s2++;
  801b41:	ff 45 fc             	incl   -0x4(%ebp)
  801b44:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801b47:	8b 45 10             	mov    0x10(%ebp),%eax
  801b4a:	8d 50 ff             	lea    -0x1(%eax),%edx
  801b4d:	89 55 10             	mov    %edx,0x10(%ebp)
  801b50:	85 c0                	test   %eax,%eax
  801b52:	75 c9                	jne    801b1d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801b54:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b59:	c9                   	leave  
  801b5a:	c3                   	ret    

00801b5b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801b5b:	55                   	push   %ebp
  801b5c:	89 e5                	mov    %esp,%ebp
  801b5e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801b61:	8b 55 08             	mov    0x8(%ebp),%edx
  801b64:	8b 45 10             	mov    0x10(%ebp),%eax
  801b67:	01 d0                	add    %edx,%eax
  801b69:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801b6c:	eb 15                	jmp    801b83 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801b6e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b71:	8a 00                	mov    (%eax),%al
  801b73:	0f b6 d0             	movzbl %al,%edx
  801b76:	8b 45 0c             	mov    0xc(%ebp),%eax
  801b79:	0f b6 c0             	movzbl %al,%eax
  801b7c:	39 c2                	cmp    %eax,%edx
  801b7e:	74 0d                	je     801b8d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801b80:	ff 45 08             	incl   0x8(%ebp)
  801b83:	8b 45 08             	mov    0x8(%ebp),%eax
  801b86:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801b89:	72 e3                	jb     801b6e <memfind+0x13>
  801b8b:	eb 01                	jmp    801b8e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801b8d:	90                   	nop
	return (void *) s;
  801b8e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801b91:	c9                   	leave  
  801b92:	c3                   	ret    

00801b93 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801b93:	55                   	push   %ebp
  801b94:	89 e5                	mov    %esp,%ebp
  801b96:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801b99:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801ba0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801ba7:	eb 03                	jmp    801bac <strtol+0x19>
		s++;
  801ba9:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801bac:	8b 45 08             	mov    0x8(%ebp),%eax
  801baf:	8a 00                	mov    (%eax),%al
  801bb1:	3c 20                	cmp    $0x20,%al
  801bb3:	74 f4                	je     801ba9 <strtol+0x16>
  801bb5:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb8:	8a 00                	mov    (%eax),%al
  801bba:	3c 09                	cmp    $0x9,%al
  801bbc:	74 eb                	je     801ba9 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801bbe:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc1:	8a 00                	mov    (%eax),%al
  801bc3:	3c 2b                	cmp    $0x2b,%al
  801bc5:	75 05                	jne    801bcc <strtol+0x39>
		s++;
  801bc7:	ff 45 08             	incl   0x8(%ebp)
  801bca:	eb 13                	jmp    801bdf <strtol+0x4c>
	else if (*s == '-')
  801bcc:	8b 45 08             	mov    0x8(%ebp),%eax
  801bcf:	8a 00                	mov    (%eax),%al
  801bd1:	3c 2d                	cmp    $0x2d,%al
  801bd3:	75 0a                	jne    801bdf <strtol+0x4c>
		s++, neg = 1;
  801bd5:	ff 45 08             	incl   0x8(%ebp)
  801bd8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801bdf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801be3:	74 06                	je     801beb <strtol+0x58>
  801be5:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801be9:	75 20                	jne    801c0b <strtol+0x78>
  801beb:	8b 45 08             	mov    0x8(%ebp),%eax
  801bee:	8a 00                	mov    (%eax),%al
  801bf0:	3c 30                	cmp    $0x30,%al
  801bf2:	75 17                	jne    801c0b <strtol+0x78>
  801bf4:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf7:	40                   	inc    %eax
  801bf8:	8a 00                	mov    (%eax),%al
  801bfa:	3c 78                	cmp    $0x78,%al
  801bfc:	75 0d                	jne    801c0b <strtol+0x78>
		s += 2, base = 16;
  801bfe:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801c02:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801c09:	eb 28                	jmp    801c33 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801c0b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801c0f:	75 15                	jne    801c26 <strtol+0x93>
  801c11:	8b 45 08             	mov    0x8(%ebp),%eax
  801c14:	8a 00                	mov    (%eax),%al
  801c16:	3c 30                	cmp    $0x30,%al
  801c18:	75 0c                	jne    801c26 <strtol+0x93>
		s++, base = 8;
  801c1a:	ff 45 08             	incl   0x8(%ebp)
  801c1d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801c24:	eb 0d                	jmp    801c33 <strtol+0xa0>
	else if (base == 0)
  801c26:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801c2a:	75 07                	jne    801c33 <strtol+0xa0>
		base = 10;
  801c2c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801c33:	8b 45 08             	mov    0x8(%ebp),%eax
  801c36:	8a 00                	mov    (%eax),%al
  801c38:	3c 2f                	cmp    $0x2f,%al
  801c3a:	7e 19                	jle    801c55 <strtol+0xc2>
  801c3c:	8b 45 08             	mov    0x8(%ebp),%eax
  801c3f:	8a 00                	mov    (%eax),%al
  801c41:	3c 39                	cmp    $0x39,%al
  801c43:	7f 10                	jg     801c55 <strtol+0xc2>
			dig = *s - '0';
  801c45:	8b 45 08             	mov    0x8(%ebp),%eax
  801c48:	8a 00                	mov    (%eax),%al
  801c4a:	0f be c0             	movsbl %al,%eax
  801c4d:	83 e8 30             	sub    $0x30,%eax
  801c50:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801c53:	eb 42                	jmp    801c97 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801c55:	8b 45 08             	mov    0x8(%ebp),%eax
  801c58:	8a 00                	mov    (%eax),%al
  801c5a:	3c 60                	cmp    $0x60,%al
  801c5c:	7e 19                	jle    801c77 <strtol+0xe4>
  801c5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c61:	8a 00                	mov    (%eax),%al
  801c63:	3c 7a                	cmp    $0x7a,%al
  801c65:	7f 10                	jg     801c77 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801c67:	8b 45 08             	mov    0x8(%ebp),%eax
  801c6a:	8a 00                	mov    (%eax),%al
  801c6c:	0f be c0             	movsbl %al,%eax
  801c6f:	83 e8 57             	sub    $0x57,%eax
  801c72:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801c75:	eb 20                	jmp    801c97 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801c77:	8b 45 08             	mov    0x8(%ebp),%eax
  801c7a:	8a 00                	mov    (%eax),%al
  801c7c:	3c 40                	cmp    $0x40,%al
  801c7e:	7e 39                	jle    801cb9 <strtol+0x126>
  801c80:	8b 45 08             	mov    0x8(%ebp),%eax
  801c83:	8a 00                	mov    (%eax),%al
  801c85:	3c 5a                	cmp    $0x5a,%al
  801c87:	7f 30                	jg     801cb9 <strtol+0x126>
			dig = *s - 'A' + 10;
  801c89:	8b 45 08             	mov    0x8(%ebp),%eax
  801c8c:	8a 00                	mov    (%eax),%al
  801c8e:	0f be c0             	movsbl %al,%eax
  801c91:	83 e8 37             	sub    $0x37,%eax
  801c94:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801c97:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801c9a:	3b 45 10             	cmp    0x10(%ebp),%eax
  801c9d:	7d 19                	jge    801cb8 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801c9f:	ff 45 08             	incl   0x8(%ebp)
  801ca2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ca5:	0f af 45 10          	imul   0x10(%ebp),%eax
  801ca9:	89 c2                	mov    %eax,%edx
  801cab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801cae:	01 d0                	add    %edx,%eax
  801cb0:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801cb3:	e9 7b ff ff ff       	jmp    801c33 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801cb8:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801cb9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801cbd:	74 08                	je     801cc7 <strtol+0x134>
		*endptr = (char *) s;
  801cbf:	8b 45 0c             	mov    0xc(%ebp),%eax
  801cc2:	8b 55 08             	mov    0x8(%ebp),%edx
  801cc5:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801cc7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801ccb:	74 07                	je     801cd4 <strtol+0x141>
  801ccd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801cd0:	f7 d8                	neg    %eax
  801cd2:	eb 03                	jmp    801cd7 <strtol+0x144>
  801cd4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801cd7:	c9                   	leave  
  801cd8:	c3                   	ret    

00801cd9 <ltostr>:

void
ltostr(long value, char *str)
{
  801cd9:	55                   	push   %ebp
  801cda:	89 e5                	mov    %esp,%ebp
  801cdc:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801cdf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801ce6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801ced:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801cf1:	79 13                	jns    801d06 <ltostr+0x2d>
	{
		neg = 1;
  801cf3:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801cfa:	8b 45 0c             	mov    0xc(%ebp),%eax
  801cfd:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801d00:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801d03:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801d06:	8b 45 08             	mov    0x8(%ebp),%eax
  801d09:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801d0e:	99                   	cltd   
  801d0f:	f7 f9                	idiv   %ecx
  801d11:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801d14:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d17:	8d 50 01             	lea    0x1(%eax),%edx
  801d1a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801d1d:	89 c2                	mov    %eax,%edx
  801d1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d22:	01 d0                	add    %edx,%eax
  801d24:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801d27:	83 c2 30             	add    $0x30,%edx
  801d2a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801d2c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801d2f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801d34:	f7 e9                	imul   %ecx
  801d36:	c1 fa 02             	sar    $0x2,%edx
  801d39:	89 c8                	mov    %ecx,%eax
  801d3b:	c1 f8 1f             	sar    $0x1f,%eax
  801d3e:	29 c2                	sub    %eax,%edx
  801d40:	89 d0                	mov    %edx,%eax
  801d42:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801d45:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801d48:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801d4d:	f7 e9                	imul   %ecx
  801d4f:	c1 fa 02             	sar    $0x2,%edx
  801d52:	89 c8                	mov    %ecx,%eax
  801d54:	c1 f8 1f             	sar    $0x1f,%eax
  801d57:	29 c2                	sub    %eax,%edx
  801d59:	89 d0                	mov    %edx,%eax
  801d5b:	c1 e0 02             	shl    $0x2,%eax
  801d5e:	01 d0                	add    %edx,%eax
  801d60:	01 c0                	add    %eax,%eax
  801d62:	29 c1                	sub    %eax,%ecx
  801d64:	89 ca                	mov    %ecx,%edx
  801d66:	85 d2                	test   %edx,%edx
  801d68:	75 9c                	jne    801d06 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801d6a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801d71:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801d74:	48                   	dec    %eax
  801d75:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801d78:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801d7c:	74 3d                	je     801dbb <ltostr+0xe2>
		start = 1 ;
  801d7e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801d85:	eb 34                	jmp    801dbb <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801d87:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801d8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d8d:	01 d0                	add    %edx,%eax
  801d8f:	8a 00                	mov    (%eax),%al
  801d91:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801d94:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801d97:	8b 45 0c             	mov    0xc(%ebp),%eax
  801d9a:	01 c2                	add    %eax,%edx
  801d9c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801d9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801da2:	01 c8                	add    %ecx,%eax
  801da4:	8a 00                	mov    (%eax),%al
  801da6:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801da8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801dab:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dae:	01 c2                	add    %eax,%edx
  801db0:	8a 45 eb             	mov    -0x15(%ebp),%al
  801db3:	88 02                	mov    %al,(%edx)
		start++ ;
  801db5:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801db8:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801dbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801dbe:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801dc1:	7c c4                	jl     801d87 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801dc3:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801dc6:	8b 45 0c             	mov    0xc(%ebp),%eax
  801dc9:	01 d0                	add    %edx,%eax
  801dcb:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801dce:	90                   	nop
  801dcf:	c9                   	leave  
  801dd0:	c3                   	ret    

00801dd1 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801dd1:	55                   	push   %ebp
  801dd2:	89 e5                	mov    %esp,%ebp
  801dd4:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801dd7:	ff 75 08             	pushl  0x8(%ebp)
  801dda:	e8 54 fa ff ff       	call   801833 <strlen>
  801ddf:	83 c4 04             	add    $0x4,%esp
  801de2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801de5:	ff 75 0c             	pushl  0xc(%ebp)
  801de8:	e8 46 fa ff ff       	call   801833 <strlen>
  801ded:	83 c4 04             	add    $0x4,%esp
  801df0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801df3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801dfa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801e01:	eb 17                	jmp    801e1a <strcconcat+0x49>
		final[s] = str1[s] ;
  801e03:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e06:	8b 45 10             	mov    0x10(%ebp),%eax
  801e09:	01 c2                	add    %eax,%edx
  801e0b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801e0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e11:	01 c8                	add    %ecx,%eax
  801e13:	8a 00                	mov    (%eax),%al
  801e15:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801e17:	ff 45 fc             	incl   -0x4(%ebp)
  801e1a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801e1d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801e20:	7c e1                	jl     801e03 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801e22:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801e29:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801e30:	eb 1f                	jmp    801e51 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801e32:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801e35:	8d 50 01             	lea    0x1(%eax),%edx
  801e38:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801e3b:	89 c2                	mov    %eax,%edx
  801e3d:	8b 45 10             	mov    0x10(%ebp),%eax
  801e40:	01 c2                	add    %eax,%edx
  801e42:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801e45:	8b 45 0c             	mov    0xc(%ebp),%eax
  801e48:	01 c8                	add    %ecx,%eax
  801e4a:	8a 00                	mov    (%eax),%al
  801e4c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801e4e:	ff 45 f8             	incl   -0x8(%ebp)
  801e51:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e54:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801e57:	7c d9                	jl     801e32 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801e59:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e5c:	8b 45 10             	mov    0x10(%ebp),%eax
  801e5f:	01 d0                	add    %edx,%eax
  801e61:	c6 00 00             	movb   $0x0,(%eax)
}
  801e64:	90                   	nop
  801e65:	c9                   	leave  
  801e66:	c3                   	ret    

00801e67 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801e67:	55                   	push   %ebp
  801e68:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801e6a:	8b 45 14             	mov    0x14(%ebp),%eax
  801e6d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801e73:	8b 45 14             	mov    0x14(%ebp),%eax
  801e76:	8b 00                	mov    (%eax),%eax
  801e78:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801e7f:	8b 45 10             	mov    0x10(%ebp),%eax
  801e82:	01 d0                	add    %edx,%eax
  801e84:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801e8a:	eb 0c                	jmp    801e98 <strsplit+0x31>
			*string++ = 0;
  801e8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e8f:	8d 50 01             	lea    0x1(%eax),%edx
  801e92:	89 55 08             	mov    %edx,0x8(%ebp)
  801e95:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801e98:	8b 45 08             	mov    0x8(%ebp),%eax
  801e9b:	8a 00                	mov    (%eax),%al
  801e9d:	84 c0                	test   %al,%al
  801e9f:	74 18                	je     801eb9 <strsplit+0x52>
  801ea1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ea4:	8a 00                	mov    (%eax),%al
  801ea6:	0f be c0             	movsbl %al,%eax
  801ea9:	50                   	push   %eax
  801eaa:	ff 75 0c             	pushl  0xc(%ebp)
  801ead:	e8 13 fb ff ff       	call   8019c5 <strchr>
  801eb2:	83 c4 08             	add    $0x8,%esp
  801eb5:	85 c0                	test   %eax,%eax
  801eb7:	75 d3                	jne    801e8c <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801eb9:	8b 45 08             	mov    0x8(%ebp),%eax
  801ebc:	8a 00                	mov    (%eax),%al
  801ebe:	84 c0                	test   %al,%al
  801ec0:	74 5a                	je     801f1c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801ec2:	8b 45 14             	mov    0x14(%ebp),%eax
  801ec5:	8b 00                	mov    (%eax),%eax
  801ec7:	83 f8 0f             	cmp    $0xf,%eax
  801eca:	75 07                	jne    801ed3 <strsplit+0x6c>
		{
			return 0;
  801ecc:	b8 00 00 00 00       	mov    $0x0,%eax
  801ed1:	eb 66                	jmp    801f39 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801ed3:	8b 45 14             	mov    0x14(%ebp),%eax
  801ed6:	8b 00                	mov    (%eax),%eax
  801ed8:	8d 48 01             	lea    0x1(%eax),%ecx
  801edb:	8b 55 14             	mov    0x14(%ebp),%edx
  801ede:	89 0a                	mov    %ecx,(%edx)
  801ee0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ee7:	8b 45 10             	mov    0x10(%ebp),%eax
  801eea:	01 c2                	add    %eax,%edx
  801eec:	8b 45 08             	mov    0x8(%ebp),%eax
  801eef:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ef1:	eb 03                	jmp    801ef6 <strsplit+0x8f>
			string++;
  801ef3:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ef6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ef9:	8a 00                	mov    (%eax),%al
  801efb:	84 c0                	test   %al,%al
  801efd:	74 8b                	je     801e8a <strsplit+0x23>
  801eff:	8b 45 08             	mov    0x8(%ebp),%eax
  801f02:	8a 00                	mov    (%eax),%al
  801f04:	0f be c0             	movsbl %al,%eax
  801f07:	50                   	push   %eax
  801f08:	ff 75 0c             	pushl  0xc(%ebp)
  801f0b:	e8 b5 fa ff ff       	call   8019c5 <strchr>
  801f10:	83 c4 08             	add    $0x8,%esp
  801f13:	85 c0                	test   %eax,%eax
  801f15:	74 dc                	je     801ef3 <strsplit+0x8c>
			string++;
	}
  801f17:	e9 6e ff ff ff       	jmp    801e8a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801f1c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801f1d:	8b 45 14             	mov    0x14(%ebp),%eax
  801f20:	8b 00                	mov    (%eax),%eax
  801f22:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801f29:	8b 45 10             	mov    0x10(%ebp),%eax
  801f2c:	01 d0                	add    %edx,%eax
  801f2e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801f34:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801f39:	c9                   	leave  
  801f3a:	c3                   	ret    

00801f3b <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801f3b:	55                   	push   %ebp
  801f3c:	89 e5                	mov    %esp,%ebp
  801f3e:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801f41:	83 ec 04             	sub    $0x4,%esp
  801f44:	68 70 30 80 00       	push   $0x803070
  801f49:	6a 16                	push   $0x16
  801f4b:	68 95 30 80 00       	push   $0x803095
  801f50:	e8 ba ef ff ff       	call   800f0f <_panic>

00801f55 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801f55:	55                   	push   %ebp
  801f56:	89 e5                	mov    %esp,%ebp
  801f58:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801f5b:	83 ec 04             	sub    $0x4,%esp
  801f5e:	68 a4 30 80 00       	push   $0x8030a4
  801f63:	6a 2e                	push   $0x2e
  801f65:	68 95 30 80 00       	push   $0x803095
  801f6a:	e8 a0 ef ff ff       	call   800f0f <_panic>

00801f6f <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801f6f:	55                   	push   %ebp
  801f70:	89 e5                	mov    %esp,%ebp
  801f72:	83 ec 18             	sub    $0x18,%esp
  801f75:	8b 45 10             	mov    0x10(%ebp),%eax
  801f78:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801f7b:	83 ec 04             	sub    $0x4,%esp
  801f7e:	68 c8 30 80 00       	push   $0x8030c8
  801f83:	6a 3b                	push   $0x3b
  801f85:	68 95 30 80 00       	push   $0x803095
  801f8a:	e8 80 ef ff ff       	call   800f0f <_panic>

00801f8f <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801f8f:	55                   	push   %ebp
  801f90:	89 e5                	mov    %esp,%ebp
  801f92:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801f95:	83 ec 04             	sub    $0x4,%esp
  801f98:	68 c8 30 80 00       	push   $0x8030c8
  801f9d:	6a 41                	push   $0x41
  801f9f:	68 95 30 80 00       	push   $0x803095
  801fa4:	e8 66 ef ff ff       	call   800f0f <_panic>

00801fa9 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801fa9:	55                   	push   %ebp
  801faa:	89 e5                	mov    %esp,%ebp
  801fac:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801faf:	83 ec 04             	sub    $0x4,%esp
  801fb2:	68 c8 30 80 00       	push   $0x8030c8
  801fb7:	6a 47                	push   $0x47
  801fb9:	68 95 30 80 00       	push   $0x803095
  801fbe:	e8 4c ef ff ff       	call   800f0f <_panic>

00801fc3 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801fc3:	55                   	push   %ebp
  801fc4:	89 e5                	mov    %esp,%ebp
  801fc6:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801fc9:	83 ec 04             	sub    $0x4,%esp
  801fcc:	68 c8 30 80 00       	push   $0x8030c8
  801fd1:	6a 4c                	push   $0x4c
  801fd3:	68 95 30 80 00       	push   $0x803095
  801fd8:	e8 32 ef ff ff       	call   800f0f <_panic>

00801fdd <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801fdd:	55                   	push   %ebp
  801fde:	89 e5                	mov    %esp,%ebp
  801fe0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801fe3:	83 ec 04             	sub    $0x4,%esp
  801fe6:	68 c8 30 80 00       	push   $0x8030c8
  801feb:	6a 52                	push   $0x52
  801fed:	68 95 30 80 00       	push   $0x803095
  801ff2:	e8 18 ef ff ff       	call   800f0f <_panic>

00801ff7 <shrink>:
}
void shrink(uint32 newSize)
{
  801ff7:	55                   	push   %ebp
  801ff8:	89 e5                	mov    %esp,%ebp
  801ffa:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ffd:	83 ec 04             	sub    $0x4,%esp
  802000:	68 c8 30 80 00       	push   $0x8030c8
  802005:	6a 56                	push   $0x56
  802007:	68 95 30 80 00       	push   $0x803095
  80200c:	e8 fe ee ff ff       	call   800f0f <_panic>

00802011 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  802011:	55                   	push   %ebp
  802012:	89 e5                	mov    %esp,%ebp
  802014:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  802017:	83 ec 04             	sub    $0x4,%esp
  80201a:	68 c8 30 80 00       	push   $0x8030c8
  80201f:	6a 5b                	push   $0x5b
  802021:	68 95 30 80 00       	push   $0x803095
  802026:	e8 e4 ee ff ff       	call   800f0f <_panic>

0080202b <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80202b:	55                   	push   %ebp
  80202c:	89 e5                	mov    %esp,%ebp
  80202e:	57                   	push   %edi
  80202f:	56                   	push   %esi
  802030:	53                   	push   %ebx
  802031:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  802034:	8b 45 08             	mov    0x8(%ebp),%eax
  802037:	8b 55 0c             	mov    0xc(%ebp),%edx
  80203a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80203d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802040:	8b 7d 18             	mov    0x18(%ebp),%edi
  802043:	8b 75 1c             	mov    0x1c(%ebp),%esi
  802046:	cd 30                	int    $0x30
  802048:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80204b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80204e:	83 c4 10             	add    $0x10,%esp
  802051:	5b                   	pop    %ebx
  802052:	5e                   	pop    %esi
  802053:	5f                   	pop    %edi
  802054:	5d                   	pop    %ebp
  802055:	c3                   	ret    

00802056 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  802056:	55                   	push   %ebp
  802057:	89 e5                	mov    %esp,%ebp
  802059:	83 ec 04             	sub    $0x4,%esp
  80205c:	8b 45 10             	mov    0x10(%ebp),%eax
  80205f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  802062:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802066:	8b 45 08             	mov    0x8(%ebp),%eax
  802069:	6a 00                	push   $0x0
  80206b:	6a 00                	push   $0x0
  80206d:	52                   	push   %edx
  80206e:	ff 75 0c             	pushl  0xc(%ebp)
  802071:	50                   	push   %eax
  802072:	6a 00                	push   $0x0
  802074:	e8 b2 ff ff ff       	call   80202b <syscall>
  802079:	83 c4 18             	add    $0x18,%esp
}
  80207c:	90                   	nop
  80207d:	c9                   	leave  
  80207e:	c3                   	ret    

0080207f <sys_cgetc>:

int
sys_cgetc(void)
{
  80207f:	55                   	push   %ebp
  802080:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  802082:	6a 00                	push   $0x0
  802084:	6a 00                	push   $0x0
  802086:	6a 00                	push   $0x0
  802088:	6a 00                	push   $0x0
  80208a:	6a 00                	push   $0x0
  80208c:	6a 01                	push   $0x1
  80208e:	e8 98 ff ff ff       	call   80202b <syscall>
  802093:	83 c4 18             	add    $0x18,%esp
}
  802096:	c9                   	leave  
  802097:	c3                   	ret    

00802098 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  802098:	55                   	push   %ebp
  802099:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80209b:	8b 45 08             	mov    0x8(%ebp),%eax
  80209e:	6a 00                	push   $0x0
  8020a0:	6a 00                	push   $0x0
  8020a2:	6a 00                	push   $0x0
  8020a4:	6a 00                	push   $0x0
  8020a6:	50                   	push   %eax
  8020a7:	6a 05                	push   $0x5
  8020a9:	e8 7d ff ff ff       	call   80202b <syscall>
  8020ae:	83 c4 18             	add    $0x18,%esp
}
  8020b1:	c9                   	leave  
  8020b2:	c3                   	ret    

008020b3 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8020b3:	55                   	push   %ebp
  8020b4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8020b6:	6a 00                	push   $0x0
  8020b8:	6a 00                	push   $0x0
  8020ba:	6a 00                	push   $0x0
  8020bc:	6a 00                	push   $0x0
  8020be:	6a 00                	push   $0x0
  8020c0:	6a 02                	push   $0x2
  8020c2:	e8 64 ff ff ff       	call   80202b <syscall>
  8020c7:	83 c4 18             	add    $0x18,%esp
}
  8020ca:	c9                   	leave  
  8020cb:	c3                   	ret    

008020cc <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8020cc:	55                   	push   %ebp
  8020cd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8020cf:	6a 00                	push   $0x0
  8020d1:	6a 00                	push   $0x0
  8020d3:	6a 00                	push   $0x0
  8020d5:	6a 00                	push   $0x0
  8020d7:	6a 00                	push   $0x0
  8020d9:	6a 03                	push   $0x3
  8020db:	e8 4b ff ff ff       	call   80202b <syscall>
  8020e0:	83 c4 18             	add    $0x18,%esp
}
  8020e3:	c9                   	leave  
  8020e4:	c3                   	ret    

008020e5 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8020e5:	55                   	push   %ebp
  8020e6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8020e8:	6a 00                	push   $0x0
  8020ea:	6a 00                	push   $0x0
  8020ec:	6a 00                	push   $0x0
  8020ee:	6a 00                	push   $0x0
  8020f0:	6a 00                	push   $0x0
  8020f2:	6a 04                	push   $0x4
  8020f4:	e8 32 ff ff ff       	call   80202b <syscall>
  8020f9:	83 c4 18             	add    $0x18,%esp
}
  8020fc:	c9                   	leave  
  8020fd:	c3                   	ret    

008020fe <sys_env_exit>:


void sys_env_exit(void)
{
  8020fe:	55                   	push   %ebp
  8020ff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  802101:	6a 00                	push   $0x0
  802103:	6a 00                	push   $0x0
  802105:	6a 00                	push   $0x0
  802107:	6a 00                	push   $0x0
  802109:	6a 00                	push   $0x0
  80210b:	6a 06                	push   $0x6
  80210d:	e8 19 ff ff ff       	call   80202b <syscall>
  802112:	83 c4 18             	add    $0x18,%esp
}
  802115:	90                   	nop
  802116:	c9                   	leave  
  802117:	c3                   	ret    

00802118 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  802118:	55                   	push   %ebp
  802119:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80211b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80211e:	8b 45 08             	mov    0x8(%ebp),%eax
  802121:	6a 00                	push   $0x0
  802123:	6a 00                	push   $0x0
  802125:	6a 00                	push   $0x0
  802127:	52                   	push   %edx
  802128:	50                   	push   %eax
  802129:	6a 07                	push   $0x7
  80212b:	e8 fb fe ff ff       	call   80202b <syscall>
  802130:	83 c4 18             	add    $0x18,%esp
}
  802133:	c9                   	leave  
  802134:	c3                   	ret    

00802135 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  802135:	55                   	push   %ebp
  802136:	89 e5                	mov    %esp,%ebp
  802138:	56                   	push   %esi
  802139:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80213a:	8b 75 18             	mov    0x18(%ebp),%esi
  80213d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802140:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802143:	8b 55 0c             	mov    0xc(%ebp),%edx
  802146:	8b 45 08             	mov    0x8(%ebp),%eax
  802149:	56                   	push   %esi
  80214a:	53                   	push   %ebx
  80214b:	51                   	push   %ecx
  80214c:	52                   	push   %edx
  80214d:	50                   	push   %eax
  80214e:	6a 08                	push   $0x8
  802150:	e8 d6 fe ff ff       	call   80202b <syscall>
  802155:	83 c4 18             	add    $0x18,%esp
}
  802158:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80215b:	5b                   	pop    %ebx
  80215c:	5e                   	pop    %esi
  80215d:	5d                   	pop    %ebp
  80215e:	c3                   	ret    

0080215f <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80215f:	55                   	push   %ebp
  802160:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  802162:	8b 55 0c             	mov    0xc(%ebp),%edx
  802165:	8b 45 08             	mov    0x8(%ebp),%eax
  802168:	6a 00                	push   $0x0
  80216a:	6a 00                	push   $0x0
  80216c:	6a 00                	push   $0x0
  80216e:	52                   	push   %edx
  80216f:	50                   	push   %eax
  802170:	6a 09                	push   $0x9
  802172:	e8 b4 fe ff ff       	call   80202b <syscall>
  802177:	83 c4 18             	add    $0x18,%esp
}
  80217a:	c9                   	leave  
  80217b:	c3                   	ret    

0080217c <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80217c:	55                   	push   %ebp
  80217d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80217f:	6a 00                	push   $0x0
  802181:	6a 00                	push   $0x0
  802183:	6a 00                	push   $0x0
  802185:	ff 75 0c             	pushl  0xc(%ebp)
  802188:	ff 75 08             	pushl  0x8(%ebp)
  80218b:	6a 0a                	push   $0xa
  80218d:	e8 99 fe ff ff       	call   80202b <syscall>
  802192:	83 c4 18             	add    $0x18,%esp
}
  802195:	c9                   	leave  
  802196:	c3                   	ret    

00802197 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  802197:	55                   	push   %ebp
  802198:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80219a:	6a 00                	push   $0x0
  80219c:	6a 00                	push   $0x0
  80219e:	6a 00                	push   $0x0
  8021a0:	6a 00                	push   $0x0
  8021a2:	6a 00                	push   $0x0
  8021a4:	6a 0b                	push   $0xb
  8021a6:	e8 80 fe ff ff       	call   80202b <syscall>
  8021ab:	83 c4 18             	add    $0x18,%esp
}
  8021ae:	c9                   	leave  
  8021af:	c3                   	ret    

008021b0 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8021b0:	55                   	push   %ebp
  8021b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8021b3:	6a 00                	push   $0x0
  8021b5:	6a 00                	push   $0x0
  8021b7:	6a 00                	push   $0x0
  8021b9:	6a 00                	push   $0x0
  8021bb:	6a 00                	push   $0x0
  8021bd:	6a 0c                	push   $0xc
  8021bf:	e8 67 fe ff ff       	call   80202b <syscall>
  8021c4:	83 c4 18             	add    $0x18,%esp
}
  8021c7:	c9                   	leave  
  8021c8:	c3                   	ret    

008021c9 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8021c9:	55                   	push   %ebp
  8021ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8021cc:	6a 00                	push   $0x0
  8021ce:	6a 00                	push   $0x0
  8021d0:	6a 00                	push   $0x0
  8021d2:	6a 00                	push   $0x0
  8021d4:	6a 00                	push   $0x0
  8021d6:	6a 0d                	push   $0xd
  8021d8:	e8 4e fe ff ff       	call   80202b <syscall>
  8021dd:	83 c4 18             	add    $0x18,%esp
}
  8021e0:	c9                   	leave  
  8021e1:	c3                   	ret    

008021e2 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8021e2:	55                   	push   %ebp
  8021e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8021e5:	6a 00                	push   $0x0
  8021e7:	6a 00                	push   $0x0
  8021e9:	6a 00                	push   $0x0
  8021eb:	ff 75 0c             	pushl  0xc(%ebp)
  8021ee:	ff 75 08             	pushl  0x8(%ebp)
  8021f1:	6a 11                	push   $0x11
  8021f3:	e8 33 fe ff ff       	call   80202b <syscall>
  8021f8:	83 c4 18             	add    $0x18,%esp
	return;
  8021fb:	90                   	nop
}
  8021fc:	c9                   	leave  
  8021fd:	c3                   	ret    

008021fe <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8021fe:	55                   	push   %ebp
  8021ff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  802201:	6a 00                	push   $0x0
  802203:	6a 00                	push   $0x0
  802205:	6a 00                	push   $0x0
  802207:	ff 75 0c             	pushl  0xc(%ebp)
  80220a:	ff 75 08             	pushl  0x8(%ebp)
  80220d:	6a 12                	push   $0x12
  80220f:	e8 17 fe ff ff       	call   80202b <syscall>
  802214:	83 c4 18             	add    $0x18,%esp
	return ;
  802217:	90                   	nop
}
  802218:	c9                   	leave  
  802219:	c3                   	ret    

0080221a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80221a:	55                   	push   %ebp
  80221b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80221d:	6a 00                	push   $0x0
  80221f:	6a 00                	push   $0x0
  802221:	6a 00                	push   $0x0
  802223:	6a 00                	push   $0x0
  802225:	6a 00                	push   $0x0
  802227:	6a 0e                	push   $0xe
  802229:	e8 fd fd ff ff       	call   80202b <syscall>
  80222e:	83 c4 18             	add    $0x18,%esp
}
  802231:	c9                   	leave  
  802232:	c3                   	ret    

00802233 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  802233:	55                   	push   %ebp
  802234:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802236:	6a 00                	push   $0x0
  802238:	6a 00                	push   $0x0
  80223a:	6a 00                	push   $0x0
  80223c:	6a 00                	push   $0x0
  80223e:	ff 75 08             	pushl  0x8(%ebp)
  802241:	6a 0f                	push   $0xf
  802243:	e8 e3 fd ff ff       	call   80202b <syscall>
  802248:	83 c4 18             	add    $0x18,%esp
}
  80224b:	c9                   	leave  
  80224c:	c3                   	ret    

0080224d <sys_scarce_memory>:

void sys_scarce_memory()
{
  80224d:	55                   	push   %ebp
  80224e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  802250:	6a 00                	push   $0x0
  802252:	6a 00                	push   $0x0
  802254:	6a 00                	push   $0x0
  802256:	6a 00                	push   $0x0
  802258:	6a 00                	push   $0x0
  80225a:	6a 10                	push   $0x10
  80225c:	e8 ca fd ff ff       	call   80202b <syscall>
  802261:	83 c4 18             	add    $0x18,%esp
}
  802264:	90                   	nop
  802265:	c9                   	leave  
  802266:	c3                   	ret    

00802267 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802267:	55                   	push   %ebp
  802268:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80226a:	6a 00                	push   $0x0
  80226c:	6a 00                	push   $0x0
  80226e:	6a 00                	push   $0x0
  802270:	6a 00                	push   $0x0
  802272:	6a 00                	push   $0x0
  802274:	6a 14                	push   $0x14
  802276:	e8 b0 fd ff ff       	call   80202b <syscall>
  80227b:	83 c4 18             	add    $0x18,%esp
}
  80227e:	90                   	nop
  80227f:	c9                   	leave  
  802280:	c3                   	ret    

00802281 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  802281:	55                   	push   %ebp
  802282:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802284:	6a 00                	push   $0x0
  802286:	6a 00                	push   $0x0
  802288:	6a 00                	push   $0x0
  80228a:	6a 00                	push   $0x0
  80228c:	6a 00                	push   $0x0
  80228e:	6a 15                	push   $0x15
  802290:	e8 96 fd ff ff       	call   80202b <syscall>
  802295:	83 c4 18             	add    $0x18,%esp
}
  802298:	90                   	nop
  802299:	c9                   	leave  
  80229a:	c3                   	ret    

0080229b <sys_cputc>:


void
sys_cputc(const char c)
{
  80229b:	55                   	push   %ebp
  80229c:	89 e5                	mov    %esp,%ebp
  80229e:	83 ec 04             	sub    $0x4,%esp
  8022a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8022a4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8022a7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8022ab:	6a 00                	push   $0x0
  8022ad:	6a 00                	push   $0x0
  8022af:	6a 00                	push   $0x0
  8022b1:	6a 00                	push   $0x0
  8022b3:	50                   	push   %eax
  8022b4:	6a 16                	push   $0x16
  8022b6:	e8 70 fd ff ff       	call   80202b <syscall>
  8022bb:	83 c4 18             	add    $0x18,%esp
}
  8022be:	90                   	nop
  8022bf:	c9                   	leave  
  8022c0:	c3                   	ret    

008022c1 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8022c1:	55                   	push   %ebp
  8022c2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8022c4:	6a 00                	push   $0x0
  8022c6:	6a 00                	push   $0x0
  8022c8:	6a 00                	push   $0x0
  8022ca:	6a 00                	push   $0x0
  8022cc:	6a 00                	push   $0x0
  8022ce:	6a 17                	push   $0x17
  8022d0:	e8 56 fd ff ff       	call   80202b <syscall>
  8022d5:	83 c4 18             	add    $0x18,%esp
}
  8022d8:	90                   	nop
  8022d9:	c9                   	leave  
  8022da:	c3                   	ret    

008022db <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8022db:	55                   	push   %ebp
  8022dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8022de:	8b 45 08             	mov    0x8(%ebp),%eax
  8022e1:	6a 00                	push   $0x0
  8022e3:	6a 00                	push   $0x0
  8022e5:	6a 00                	push   $0x0
  8022e7:	ff 75 0c             	pushl  0xc(%ebp)
  8022ea:	50                   	push   %eax
  8022eb:	6a 18                	push   $0x18
  8022ed:	e8 39 fd ff ff       	call   80202b <syscall>
  8022f2:	83 c4 18             	add    $0x18,%esp
}
  8022f5:	c9                   	leave  
  8022f6:	c3                   	ret    

008022f7 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8022f7:	55                   	push   %ebp
  8022f8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8022fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022fd:	8b 45 08             	mov    0x8(%ebp),%eax
  802300:	6a 00                	push   $0x0
  802302:	6a 00                	push   $0x0
  802304:	6a 00                	push   $0x0
  802306:	52                   	push   %edx
  802307:	50                   	push   %eax
  802308:	6a 1b                	push   $0x1b
  80230a:	e8 1c fd ff ff       	call   80202b <syscall>
  80230f:	83 c4 18             	add    $0x18,%esp
}
  802312:	c9                   	leave  
  802313:	c3                   	ret    

00802314 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802314:	55                   	push   %ebp
  802315:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802317:	8b 55 0c             	mov    0xc(%ebp),%edx
  80231a:	8b 45 08             	mov    0x8(%ebp),%eax
  80231d:	6a 00                	push   $0x0
  80231f:	6a 00                	push   $0x0
  802321:	6a 00                	push   $0x0
  802323:	52                   	push   %edx
  802324:	50                   	push   %eax
  802325:	6a 19                	push   $0x19
  802327:	e8 ff fc ff ff       	call   80202b <syscall>
  80232c:	83 c4 18             	add    $0x18,%esp
}
  80232f:	90                   	nop
  802330:	c9                   	leave  
  802331:	c3                   	ret    

00802332 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802332:	55                   	push   %ebp
  802333:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802335:	8b 55 0c             	mov    0xc(%ebp),%edx
  802338:	8b 45 08             	mov    0x8(%ebp),%eax
  80233b:	6a 00                	push   $0x0
  80233d:	6a 00                	push   $0x0
  80233f:	6a 00                	push   $0x0
  802341:	52                   	push   %edx
  802342:	50                   	push   %eax
  802343:	6a 1a                	push   $0x1a
  802345:	e8 e1 fc ff ff       	call   80202b <syscall>
  80234a:	83 c4 18             	add    $0x18,%esp
}
  80234d:	90                   	nop
  80234e:	c9                   	leave  
  80234f:	c3                   	ret    

00802350 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  802350:	55                   	push   %ebp
  802351:	89 e5                	mov    %esp,%ebp
  802353:	83 ec 04             	sub    $0x4,%esp
  802356:	8b 45 10             	mov    0x10(%ebp),%eax
  802359:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80235c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80235f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802363:	8b 45 08             	mov    0x8(%ebp),%eax
  802366:	6a 00                	push   $0x0
  802368:	51                   	push   %ecx
  802369:	52                   	push   %edx
  80236a:	ff 75 0c             	pushl  0xc(%ebp)
  80236d:	50                   	push   %eax
  80236e:	6a 1c                	push   $0x1c
  802370:	e8 b6 fc ff ff       	call   80202b <syscall>
  802375:	83 c4 18             	add    $0x18,%esp
}
  802378:	c9                   	leave  
  802379:	c3                   	ret    

0080237a <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80237a:	55                   	push   %ebp
  80237b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80237d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802380:	8b 45 08             	mov    0x8(%ebp),%eax
  802383:	6a 00                	push   $0x0
  802385:	6a 00                	push   $0x0
  802387:	6a 00                	push   $0x0
  802389:	52                   	push   %edx
  80238a:	50                   	push   %eax
  80238b:	6a 1d                	push   $0x1d
  80238d:	e8 99 fc ff ff       	call   80202b <syscall>
  802392:	83 c4 18             	add    $0x18,%esp
}
  802395:	c9                   	leave  
  802396:	c3                   	ret    

00802397 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802397:	55                   	push   %ebp
  802398:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80239a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80239d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8023a3:	6a 00                	push   $0x0
  8023a5:	6a 00                	push   $0x0
  8023a7:	51                   	push   %ecx
  8023a8:	52                   	push   %edx
  8023a9:	50                   	push   %eax
  8023aa:	6a 1e                	push   $0x1e
  8023ac:	e8 7a fc ff ff       	call   80202b <syscall>
  8023b1:	83 c4 18             	add    $0x18,%esp
}
  8023b4:	c9                   	leave  
  8023b5:	c3                   	ret    

008023b6 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8023b6:	55                   	push   %ebp
  8023b7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8023b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8023bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8023bf:	6a 00                	push   $0x0
  8023c1:	6a 00                	push   $0x0
  8023c3:	6a 00                	push   $0x0
  8023c5:	52                   	push   %edx
  8023c6:	50                   	push   %eax
  8023c7:	6a 1f                	push   $0x1f
  8023c9:	e8 5d fc ff ff       	call   80202b <syscall>
  8023ce:	83 c4 18             	add    $0x18,%esp
}
  8023d1:	c9                   	leave  
  8023d2:	c3                   	ret    

008023d3 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8023d3:	55                   	push   %ebp
  8023d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8023d6:	6a 00                	push   $0x0
  8023d8:	6a 00                	push   $0x0
  8023da:	6a 00                	push   $0x0
  8023dc:	6a 00                	push   $0x0
  8023de:	6a 00                	push   $0x0
  8023e0:	6a 20                	push   $0x20
  8023e2:	e8 44 fc ff ff       	call   80202b <syscall>
  8023e7:	83 c4 18             	add    $0x18,%esp
}
  8023ea:	c9                   	leave  
  8023eb:	c3                   	ret    

008023ec <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8023ec:	55                   	push   %ebp
  8023ed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8023ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8023f2:	6a 00                	push   $0x0
  8023f4:	ff 75 14             	pushl  0x14(%ebp)
  8023f7:	ff 75 10             	pushl  0x10(%ebp)
  8023fa:	ff 75 0c             	pushl  0xc(%ebp)
  8023fd:	50                   	push   %eax
  8023fe:	6a 21                	push   $0x21
  802400:	e8 26 fc ff ff       	call   80202b <syscall>
  802405:	83 c4 18             	add    $0x18,%esp
}
  802408:	c9                   	leave  
  802409:	c3                   	ret    

0080240a <sys_run_env>:

void
sys_run_env(int32 envId)
{
  80240a:	55                   	push   %ebp
  80240b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80240d:	8b 45 08             	mov    0x8(%ebp),%eax
  802410:	6a 00                	push   $0x0
  802412:	6a 00                	push   $0x0
  802414:	6a 00                	push   $0x0
  802416:	6a 00                	push   $0x0
  802418:	50                   	push   %eax
  802419:	6a 22                	push   $0x22
  80241b:	e8 0b fc ff ff       	call   80202b <syscall>
  802420:	83 c4 18             	add    $0x18,%esp
}
  802423:	90                   	nop
  802424:	c9                   	leave  
  802425:	c3                   	ret    

00802426 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802426:	55                   	push   %ebp
  802427:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802429:	8b 45 08             	mov    0x8(%ebp),%eax
  80242c:	6a 00                	push   $0x0
  80242e:	6a 00                	push   $0x0
  802430:	6a 00                	push   $0x0
  802432:	6a 00                	push   $0x0
  802434:	50                   	push   %eax
  802435:	6a 23                	push   $0x23
  802437:	e8 ef fb ff ff       	call   80202b <syscall>
  80243c:	83 c4 18             	add    $0x18,%esp
}
  80243f:	90                   	nop
  802440:	c9                   	leave  
  802441:	c3                   	ret    

00802442 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802442:	55                   	push   %ebp
  802443:	89 e5                	mov    %esp,%ebp
  802445:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802448:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80244b:	8d 50 04             	lea    0x4(%eax),%edx
  80244e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802451:	6a 00                	push   $0x0
  802453:	6a 00                	push   $0x0
  802455:	6a 00                	push   $0x0
  802457:	52                   	push   %edx
  802458:	50                   	push   %eax
  802459:	6a 24                	push   $0x24
  80245b:	e8 cb fb ff ff       	call   80202b <syscall>
  802460:	83 c4 18             	add    $0x18,%esp
	return result;
  802463:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802466:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802469:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80246c:	89 01                	mov    %eax,(%ecx)
  80246e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802471:	8b 45 08             	mov    0x8(%ebp),%eax
  802474:	c9                   	leave  
  802475:	c2 04 00             	ret    $0x4

00802478 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802478:	55                   	push   %ebp
  802479:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80247b:	6a 00                	push   $0x0
  80247d:	6a 00                	push   $0x0
  80247f:	ff 75 10             	pushl  0x10(%ebp)
  802482:	ff 75 0c             	pushl  0xc(%ebp)
  802485:	ff 75 08             	pushl  0x8(%ebp)
  802488:	6a 13                	push   $0x13
  80248a:	e8 9c fb ff ff       	call   80202b <syscall>
  80248f:	83 c4 18             	add    $0x18,%esp
	return ;
  802492:	90                   	nop
}
  802493:	c9                   	leave  
  802494:	c3                   	ret    

00802495 <sys_rcr2>:
uint32 sys_rcr2()
{
  802495:	55                   	push   %ebp
  802496:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802498:	6a 00                	push   $0x0
  80249a:	6a 00                	push   $0x0
  80249c:	6a 00                	push   $0x0
  80249e:	6a 00                	push   $0x0
  8024a0:	6a 00                	push   $0x0
  8024a2:	6a 25                	push   $0x25
  8024a4:	e8 82 fb ff ff       	call   80202b <syscall>
  8024a9:	83 c4 18             	add    $0x18,%esp
}
  8024ac:	c9                   	leave  
  8024ad:	c3                   	ret    

008024ae <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8024ae:	55                   	push   %ebp
  8024af:	89 e5                	mov    %esp,%ebp
  8024b1:	83 ec 04             	sub    $0x4,%esp
  8024b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8024b7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8024ba:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8024be:	6a 00                	push   $0x0
  8024c0:	6a 00                	push   $0x0
  8024c2:	6a 00                	push   $0x0
  8024c4:	6a 00                	push   $0x0
  8024c6:	50                   	push   %eax
  8024c7:	6a 26                	push   $0x26
  8024c9:	e8 5d fb ff ff       	call   80202b <syscall>
  8024ce:	83 c4 18             	add    $0x18,%esp
	return ;
  8024d1:	90                   	nop
}
  8024d2:	c9                   	leave  
  8024d3:	c3                   	ret    

008024d4 <rsttst>:
void rsttst()
{
  8024d4:	55                   	push   %ebp
  8024d5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8024d7:	6a 00                	push   $0x0
  8024d9:	6a 00                	push   $0x0
  8024db:	6a 00                	push   $0x0
  8024dd:	6a 00                	push   $0x0
  8024df:	6a 00                	push   $0x0
  8024e1:	6a 28                	push   $0x28
  8024e3:	e8 43 fb ff ff       	call   80202b <syscall>
  8024e8:	83 c4 18             	add    $0x18,%esp
	return ;
  8024eb:	90                   	nop
}
  8024ec:	c9                   	leave  
  8024ed:	c3                   	ret    

008024ee <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8024ee:	55                   	push   %ebp
  8024ef:	89 e5                	mov    %esp,%ebp
  8024f1:	83 ec 04             	sub    $0x4,%esp
  8024f4:	8b 45 14             	mov    0x14(%ebp),%eax
  8024f7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8024fa:	8b 55 18             	mov    0x18(%ebp),%edx
  8024fd:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802501:	52                   	push   %edx
  802502:	50                   	push   %eax
  802503:	ff 75 10             	pushl  0x10(%ebp)
  802506:	ff 75 0c             	pushl  0xc(%ebp)
  802509:	ff 75 08             	pushl  0x8(%ebp)
  80250c:	6a 27                	push   $0x27
  80250e:	e8 18 fb ff ff       	call   80202b <syscall>
  802513:	83 c4 18             	add    $0x18,%esp
	return ;
  802516:	90                   	nop
}
  802517:	c9                   	leave  
  802518:	c3                   	ret    

00802519 <chktst>:
void chktst(uint32 n)
{
  802519:	55                   	push   %ebp
  80251a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80251c:	6a 00                	push   $0x0
  80251e:	6a 00                	push   $0x0
  802520:	6a 00                	push   $0x0
  802522:	6a 00                	push   $0x0
  802524:	ff 75 08             	pushl  0x8(%ebp)
  802527:	6a 29                	push   $0x29
  802529:	e8 fd fa ff ff       	call   80202b <syscall>
  80252e:	83 c4 18             	add    $0x18,%esp
	return ;
  802531:	90                   	nop
}
  802532:	c9                   	leave  
  802533:	c3                   	ret    

00802534 <inctst>:

void inctst()
{
  802534:	55                   	push   %ebp
  802535:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802537:	6a 00                	push   $0x0
  802539:	6a 00                	push   $0x0
  80253b:	6a 00                	push   $0x0
  80253d:	6a 00                	push   $0x0
  80253f:	6a 00                	push   $0x0
  802541:	6a 2a                	push   $0x2a
  802543:	e8 e3 fa ff ff       	call   80202b <syscall>
  802548:	83 c4 18             	add    $0x18,%esp
	return ;
  80254b:	90                   	nop
}
  80254c:	c9                   	leave  
  80254d:	c3                   	ret    

0080254e <gettst>:
uint32 gettst()
{
  80254e:	55                   	push   %ebp
  80254f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802551:	6a 00                	push   $0x0
  802553:	6a 00                	push   $0x0
  802555:	6a 00                	push   $0x0
  802557:	6a 00                	push   $0x0
  802559:	6a 00                	push   $0x0
  80255b:	6a 2b                	push   $0x2b
  80255d:	e8 c9 fa ff ff       	call   80202b <syscall>
  802562:	83 c4 18             	add    $0x18,%esp
}
  802565:	c9                   	leave  
  802566:	c3                   	ret    

00802567 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802567:	55                   	push   %ebp
  802568:	89 e5                	mov    %esp,%ebp
  80256a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80256d:	6a 00                	push   $0x0
  80256f:	6a 00                	push   $0x0
  802571:	6a 00                	push   $0x0
  802573:	6a 00                	push   $0x0
  802575:	6a 00                	push   $0x0
  802577:	6a 2c                	push   $0x2c
  802579:	e8 ad fa ff ff       	call   80202b <syscall>
  80257e:	83 c4 18             	add    $0x18,%esp
  802581:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802584:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802588:	75 07                	jne    802591 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80258a:	b8 01 00 00 00       	mov    $0x1,%eax
  80258f:	eb 05                	jmp    802596 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802591:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802596:	c9                   	leave  
  802597:	c3                   	ret    

00802598 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802598:	55                   	push   %ebp
  802599:	89 e5                	mov    %esp,%ebp
  80259b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80259e:	6a 00                	push   $0x0
  8025a0:	6a 00                	push   $0x0
  8025a2:	6a 00                	push   $0x0
  8025a4:	6a 00                	push   $0x0
  8025a6:	6a 00                	push   $0x0
  8025a8:	6a 2c                	push   $0x2c
  8025aa:	e8 7c fa ff ff       	call   80202b <syscall>
  8025af:	83 c4 18             	add    $0x18,%esp
  8025b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8025b5:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8025b9:	75 07                	jne    8025c2 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8025bb:	b8 01 00 00 00       	mov    $0x1,%eax
  8025c0:	eb 05                	jmp    8025c7 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8025c2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8025c7:	c9                   	leave  
  8025c8:	c3                   	ret    

008025c9 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8025c9:	55                   	push   %ebp
  8025ca:	89 e5                	mov    %esp,%ebp
  8025cc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8025cf:	6a 00                	push   $0x0
  8025d1:	6a 00                	push   $0x0
  8025d3:	6a 00                	push   $0x0
  8025d5:	6a 00                	push   $0x0
  8025d7:	6a 00                	push   $0x0
  8025d9:	6a 2c                	push   $0x2c
  8025db:	e8 4b fa ff ff       	call   80202b <syscall>
  8025e0:	83 c4 18             	add    $0x18,%esp
  8025e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8025e6:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8025ea:	75 07                	jne    8025f3 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8025ec:	b8 01 00 00 00       	mov    $0x1,%eax
  8025f1:	eb 05                	jmp    8025f8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8025f3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8025f8:	c9                   	leave  
  8025f9:	c3                   	ret    

008025fa <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8025fa:	55                   	push   %ebp
  8025fb:	89 e5                	mov    %esp,%ebp
  8025fd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802600:	6a 00                	push   $0x0
  802602:	6a 00                	push   $0x0
  802604:	6a 00                	push   $0x0
  802606:	6a 00                	push   $0x0
  802608:	6a 00                	push   $0x0
  80260a:	6a 2c                	push   $0x2c
  80260c:	e8 1a fa ff ff       	call   80202b <syscall>
  802611:	83 c4 18             	add    $0x18,%esp
  802614:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802617:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80261b:	75 07                	jne    802624 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80261d:	b8 01 00 00 00       	mov    $0x1,%eax
  802622:	eb 05                	jmp    802629 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802624:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802629:	c9                   	leave  
  80262a:	c3                   	ret    

0080262b <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80262b:	55                   	push   %ebp
  80262c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80262e:	6a 00                	push   $0x0
  802630:	6a 00                	push   $0x0
  802632:	6a 00                	push   $0x0
  802634:	6a 00                	push   $0x0
  802636:	ff 75 08             	pushl  0x8(%ebp)
  802639:	6a 2d                	push   $0x2d
  80263b:	e8 eb f9 ff ff       	call   80202b <syscall>
  802640:	83 c4 18             	add    $0x18,%esp
	return ;
  802643:	90                   	nop
}
  802644:	c9                   	leave  
  802645:	c3                   	ret    

00802646 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802646:	55                   	push   %ebp
  802647:	89 e5                	mov    %esp,%ebp
  802649:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80264a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80264d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802650:	8b 55 0c             	mov    0xc(%ebp),%edx
  802653:	8b 45 08             	mov    0x8(%ebp),%eax
  802656:	6a 00                	push   $0x0
  802658:	53                   	push   %ebx
  802659:	51                   	push   %ecx
  80265a:	52                   	push   %edx
  80265b:	50                   	push   %eax
  80265c:	6a 2e                	push   $0x2e
  80265e:	e8 c8 f9 ff ff       	call   80202b <syscall>
  802663:	83 c4 18             	add    $0x18,%esp
}
  802666:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802669:	c9                   	leave  
  80266a:	c3                   	ret    

0080266b <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80266b:	55                   	push   %ebp
  80266c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80266e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802671:	8b 45 08             	mov    0x8(%ebp),%eax
  802674:	6a 00                	push   $0x0
  802676:	6a 00                	push   $0x0
  802678:	6a 00                	push   $0x0
  80267a:	52                   	push   %edx
  80267b:	50                   	push   %eax
  80267c:	6a 2f                	push   $0x2f
  80267e:	e8 a8 f9 ff ff       	call   80202b <syscall>
  802683:	83 c4 18             	add    $0x18,%esp
}
  802686:	c9                   	leave  
  802687:	c3                   	ret    

00802688 <__udivdi3>:
  802688:	55                   	push   %ebp
  802689:	57                   	push   %edi
  80268a:	56                   	push   %esi
  80268b:	53                   	push   %ebx
  80268c:	83 ec 1c             	sub    $0x1c,%esp
  80268f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802693:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802697:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80269b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80269f:	89 ca                	mov    %ecx,%edx
  8026a1:	89 f8                	mov    %edi,%eax
  8026a3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8026a7:	85 f6                	test   %esi,%esi
  8026a9:	75 2d                	jne    8026d8 <__udivdi3+0x50>
  8026ab:	39 cf                	cmp    %ecx,%edi
  8026ad:	77 65                	ja     802714 <__udivdi3+0x8c>
  8026af:	89 fd                	mov    %edi,%ebp
  8026b1:	85 ff                	test   %edi,%edi
  8026b3:	75 0b                	jne    8026c0 <__udivdi3+0x38>
  8026b5:	b8 01 00 00 00       	mov    $0x1,%eax
  8026ba:	31 d2                	xor    %edx,%edx
  8026bc:	f7 f7                	div    %edi
  8026be:	89 c5                	mov    %eax,%ebp
  8026c0:	31 d2                	xor    %edx,%edx
  8026c2:	89 c8                	mov    %ecx,%eax
  8026c4:	f7 f5                	div    %ebp
  8026c6:	89 c1                	mov    %eax,%ecx
  8026c8:	89 d8                	mov    %ebx,%eax
  8026ca:	f7 f5                	div    %ebp
  8026cc:	89 cf                	mov    %ecx,%edi
  8026ce:	89 fa                	mov    %edi,%edx
  8026d0:	83 c4 1c             	add    $0x1c,%esp
  8026d3:	5b                   	pop    %ebx
  8026d4:	5e                   	pop    %esi
  8026d5:	5f                   	pop    %edi
  8026d6:	5d                   	pop    %ebp
  8026d7:	c3                   	ret    
  8026d8:	39 ce                	cmp    %ecx,%esi
  8026da:	77 28                	ja     802704 <__udivdi3+0x7c>
  8026dc:	0f bd fe             	bsr    %esi,%edi
  8026df:	83 f7 1f             	xor    $0x1f,%edi
  8026e2:	75 40                	jne    802724 <__udivdi3+0x9c>
  8026e4:	39 ce                	cmp    %ecx,%esi
  8026e6:	72 0a                	jb     8026f2 <__udivdi3+0x6a>
  8026e8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8026ec:	0f 87 9e 00 00 00    	ja     802790 <__udivdi3+0x108>
  8026f2:	b8 01 00 00 00       	mov    $0x1,%eax
  8026f7:	89 fa                	mov    %edi,%edx
  8026f9:	83 c4 1c             	add    $0x1c,%esp
  8026fc:	5b                   	pop    %ebx
  8026fd:	5e                   	pop    %esi
  8026fe:	5f                   	pop    %edi
  8026ff:	5d                   	pop    %ebp
  802700:	c3                   	ret    
  802701:	8d 76 00             	lea    0x0(%esi),%esi
  802704:	31 ff                	xor    %edi,%edi
  802706:	31 c0                	xor    %eax,%eax
  802708:	89 fa                	mov    %edi,%edx
  80270a:	83 c4 1c             	add    $0x1c,%esp
  80270d:	5b                   	pop    %ebx
  80270e:	5e                   	pop    %esi
  80270f:	5f                   	pop    %edi
  802710:	5d                   	pop    %ebp
  802711:	c3                   	ret    
  802712:	66 90                	xchg   %ax,%ax
  802714:	89 d8                	mov    %ebx,%eax
  802716:	f7 f7                	div    %edi
  802718:	31 ff                	xor    %edi,%edi
  80271a:	89 fa                	mov    %edi,%edx
  80271c:	83 c4 1c             	add    $0x1c,%esp
  80271f:	5b                   	pop    %ebx
  802720:	5e                   	pop    %esi
  802721:	5f                   	pop    %edi
  802722:	5d                   	pop    %ebp
  802723:	c3                   	ret    
  802724:	bd 20 00 00 00       	mov    $0x20,%ebp
  802729:	89 eb                	mov    %ebp,%ebx
  80272b:	29 fb                	sub    %edi,%ebx
  80272d:	89 f9                	mov    %edi,%ecx
  80272f:	d3 e6                	shl    %cl,%esi
  802731:	89 c5                	mov    %eax,%ebp
  802733:	88 d9                	mov    %bl,%cl
  802735:	d3 ed                	shr    %cl,%ebp
  802737:	89 e9                	mov    %ebp,%ecx
  802739:	09 f1                	or     %esi,%ecx
  80273b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80273f:	89 f9                	mov    %edi,%ecx
  802741:	d3 e0                	shl    %cl,%eax
  802743:	89 c5                	mov    %eax,%ebp
  802745:	89 d6                	mov    %edx,%esi
  802747:	88 d9                	mov    %bl,%cl
  802749:	d3 ee                	shr    %cl,%esi
  80274b:	89 f9                	mov    %edi,%ecx
  80274d:	d3 e2                	shl    %cl,%edx
  80274f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802753:	88 d9                	mov    %bl,%cl
  802755:	d3 e8                	shr    %cl,%eax
  802757:	09 c2                	or     %eax,%edx
  802759:	89 d0                	mov    %edx,%eax
  80275b:	89 f2                	mov    %esi,%edx
  80275d:	f7 74 24 0c          	divl   0xc(%esp)
  802761:	89 d6                	mov    %edx,%esi
  802763:	89 c3                	mov    %eax,%ebx
  802765:	f7 e5                	mul    %ebp
  802767:	39 d6                	cmp    %edx,%esi
  802769:	72 19                	jb     802784 <__udivdi3+0xfc>
  80276b:	74 0b                	je     802778 <__udivdi3+0xf0>
  80276d:	89 d8                	mov    %ebx,%eax
  80276f:	31 ff                	xor    %edi,%edi
  802771:	e9 58 ff ff ff       	jmp    8026ce <__udivdi3+0x46>
  802776:	66 90                	xchg   %ax,%ax
  802778:	8b 54 24 08          	mov    0x8(%esp),%edx
  80277c:	89 f9                	mov    %edi,%ecx
  80277e:	d3 e2                	shl    %cl,%edx
  802780:	39 c2                	cmp    %eax,%edx
  802782:	73 e9                	jae    80276d <__udivdi3+0xe5>
  802784:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802787:	31 ff                	xor    %edi,%edi
  802789:	e9 40 ff ff ff       	jmp    8026ce <__udivdi3+0x46>
  80278e:	66 90                	xchg   %ax,%ax
  802790:	31 c0                	xor    %eax,%eax
  802792:	e9 37 ff ff ff       	jmp    8026ce <__udivdi3+0x46>
  802797:	90                   	nop

00802798 <__umoddi3>:
  802798:	55                   	push   %ebp
  802799:	57                   	push   %edi
  80279a:	56                   	push   %esi
  80279b:	53                   	push   %ebx
  80279c:	83 ec 1c             	sub    $0x1c,%esp
  80279f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8027a3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8027a7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8027ab:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8027af:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8027b3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8027b7:	89 f3                	mov    %esi,%ebx
  8027b9:	89 fa                	mov    %edi,%edx
  8027bb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8027bf:	89 34 24             	mov    %esi,(%esp)
  8027c2:	85 c0                	test   %eax,%eax
  8027c4:	75 1a                	jne    8027e0 <__umoddi3+0x48>
  8027c6:	39 f7                	cmp    %esi,%edi
  8027c8:	0f 86 a2 00 00 00    	jbe    802870 <__umoddi3+0xd8>
  8027ce:	89 c8                	mov    %ecx,%eax
  8027d0:	89 f2                	mov    %esi,%edx
  8027d2:	f7 f7                	div    %edi
  8027d4:	89 d0                	mov    %edx,%eax
  8027d6:	31 d2                	xor    %edx,%edx
  8027d8:	83 c4 1c             	add    $0x1c,%esp
  8027db:	5b                   	pop    %ebx
  8027dc:	5e                   	pop    %esi
  8027dd:	5f                   	pop    %edi
  8027de:	5d                   	pop    %ebp
  8027df:	c3                   	ret    
  8027e0:	39 f0                	cmp    %esi,%eax
  8027e2:	0f 87 ac 00 00 00    	ja     802894 <__umoddi3+0xfc>
  8027e8:	0f bd e8             	bsr    %eax,%ebp
  8027eb:	83 f5 1f             	xor    $0x1f,%ebp
  8027ee:	0f 84 ac 00 00 00    	je     8028a0 <__umoddi3+0x108>
  8027f4:	bf 20 00 00 00       	mov    $0x20,%edi
  8027f9:	29 ef                	sub    %ebp,%edi
  8027fb:	89 fe                	mov    %edi,%esi
  8027fd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802801:	89 e9                	mov    %ebp,%ecx
  802803:	d3 e0                	shl    %cl,%eax
  802805:	89 d7                	mov    %edx,%edi
  802807:	89 f1                	mov    %esi,%ecx
  802809:	d3 ef                	shr    %cl,%edi
  80280b:	09 c7                	or     %eax,%edi
  80280d:	89 e9                	mov    %ebp,%ecx
  80280f:	d3 e2                	shl    %cl,%edx
  802811:	89 14 24             	mov    %edx,(%esp)
  802814:	89 d8                	mov    %ebx,%eax
  802816:	d3 e0                	shl    %cl,%eax
  802818:	89 c2                	mov    %eax,%edx
  80281a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80281e:	d3 e0                	shl    %cl,%eax
  802820:	89 44 24 04          	mov    %eax,0x4(%esp)
  802824:	8b 44 24 08          	mov    0x8(%esp),%eax
  802828:	89 f1                	mov    %esi,%ecx
  80282a:	d3 e8                	shr    %cl,%eax
  80282c:	09 d0                	or     %edx,%eax
  80282e:	d3 eb                	shr    %cl,%ebx
  802830:	89 da                	mov    %ebx,%edx
  802832:	f7 f7                	div    %edi
  802834:	89 d3                	mov    %edx,%ebx
  802836:	f7 24 24             	mull   (%esp)
  802839:	89 c6                	mov    %eax,%esi
  80283b:	89 d1                	mov    %edx,%ecx
  80283d:	39 d3                	cmp    %edx,%ebx
  80283f:	0f 82 87 00 00 00    	jb     8028cc <__umoddi3+0x134>
  802845:	0f 84 91 00 00 00    	je     8028dc <__umoddi3+0x144>
  80284b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80284f:	29 f2                	sub    %esi,%edx
  802851:	19 cb                	sbb    %ecx,%ebx
  802853:	89 d8                	mov    %ebx,%eax
  802855:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802859:	d3 e0                	shl    %cl,%eax
  80285b:	89 e9                	mov    %ebp,%ecx
  80285d:	d3 ea                	shr    %cl,%edx
  80285f:	09 d0                	or     %edx,%eax
  802861:	89 e9                	mov    %ebp,%ecx
  802863:	d3 eb                	shr    %cl,%ebx
  802865:	89 da                	mov    %ebx,%edx
  802867:	83 c4 1c             	add    $0x1c,%esp
  80286a:	5b                   	pop    %ebx
  80286b:	5e                   	pop    %esi
  80286c:	5f                   	pop    %edi
  80286d:	5d                   	pop    %ebp
  80286e:	c3                   	ret    
  80286f:	90                   	nop
  802870:	89 fd                	mov    %edi,%ebp
  802872:	85 ff                	test   %edi,%edi
  802874:	75 0b                	jne    802881 <__umoddi3+0xe9>
  802876:	b8 01 00 00 00       	mov    $0x1,%eax
  80287b:	31 d2                	xor    %edx,%edx
  80287d:	f7 f7                	div    %edi
  80287f:	89 c5                	mov    %eax,%ebp
  802881:	89 f0                	mov    %esi,%eax
  802883:	31 d2                	xor    %edx,%edx
  802885:	f7 f5                	div    %ebp
  802887:	89 c8                	mov    %ecx,%eax
  802889:	f7 f5                	div    %ebp
  80288b:	89 d0                	mov    %edx,%eax
  80288d:	e9 44 ff ff ff       	jmp    8027d6 <__umoddi3+0x3e>
  802892:	66 90                	xchg   %ax,%ax
  802894:	89 c8                	mov    %ecx,%eax
  802896:	89 f2                	mov    %esi,%edx
  802898:	83 c4 1c             	add    $0x1c,%esp
  80289b:	5b                   	pop    %ebx
  80289c:	5e                   	pop    %esi
  80289d:	5f                   	pop    %edi
  80289e:	5d                   	pop    %ebp
  80289f:	c3                   	ret    
  8028a0:	3b 04 24             	cmp    (%esp),%eax
  8028a3:	72 06                	jb     8028ab <__umoddi3+0x113>
  8028a5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8028a9:	77 0f                	ja     8028ba <__umoddi3+0x122>
  8028ab:	89 f2                	mov    %esi,%edx
  8028ad:	29 f9                	sub    %edi,%ecx
  8028af:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8028b3:	89 14 24             	mov    %edx,(%esp)
  8028b6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8028ba:	8b 44 24 04          	mov    0x4(%esp),%eax
  8028be:	8b 14 24             	mov    (%esp),%edx
  8028c1:	83 c4 1c             	add    $0x1c,%esp
  8028c4:	5b                   	pop    %ebx
  8028c5:	5e                   	pop    %esi
  8028c6:	5f                   	pop    %edi
  8028c7:	5d                   	pop    %ebp
  8028c8:	c3                   	ret    
  8028c9:	8d 76 00             	lea    0x0(%esi),%esi
  8028cc:	2b 04 24             	sub    (%esp),%eax
  8028cf:	19 fa                	sbb    %edi,%edx
  8028d1:	89 d1                	mov    %edx,%ecx
  8028d3:	89 c6                	mov    %eax,%esi
  8028d5:	e9 71 ff ff ff       	jmp    80284b <__umoddi3+0xb3>
  8028da:	66 90                	xchg   %ax,%ax
  8028dc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8028e0:	72 ea                	jb     8028cc <__umoddi3+0x134>
  8028e2:	89 d9                	mov    %ebx,%ecx
  8028e4:	e9 62 ff ff ff       	jmp    80284b <__umoddi3+0xb3>