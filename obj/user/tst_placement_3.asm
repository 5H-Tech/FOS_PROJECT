
obj/user/tst_placement_3:     file format elf32-i386


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
  800031:	e8 ac 03 00 00       	call   8003e2 <libmain>
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
  80003d:	81 ec 70 00 00 01    	sub    $0x1000070,%esp

	char arr[PAGE_SIZE*1024*4];
	int x = 0;
  800043:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	uint32 actual_active_list[13] = {0xedbfdb78,0xeebfd000,0x803000,0x802000,0x801000,0x800000,0x205000,0x204000,0x203000,0x202000,0x201000,0x200000};
  80004a:	8d 95 a4 ff ff fe    	lea    -0x100005c(%ebp),%edx
  800050:	b9 0d 00 00 00       	mov    $0xd,%ecx
  800055:	b8 00 00 00 00       	mov    $0x0,%eax
  80005a:	89 d7                	mov    %edx,%edi
  80005c:	f3 ab                	rep stos %eax,%es:(%edi)
  80005e:	c7 85 a4 ff ff fe 78 	movl   $0xedbfdb78,-0x100005c(%ebp)
  800065:	db bf ed 
  800068:	c7 85 a8 ff ff fe 00 	movl   $0xeebfd000,-0x1000058(%ebp)
  80006f:	d0 bf ee 
  800072:	c7 85 ac ff ff fe 00 	movl   $0x803000,-0x1000054(%ebp)
  800079:	30 80 00 
  80007c:	c7 85 b0 ff ff fe 00 	movl   $0x802000,-0x1000050(%ebp)
  800083:	20 80 00 
  800086:	c7 85 b4 ff ff fe 00 	movl   $0x801000,-0x100004c(%ebp)
  80008d:	10 80 00 
  800090:	c7 85 b8 ff ff fe 00 	movl   $0x800000,-0x1000048(%ebp)
  800097:	00 80 00 
  80009a:	c7 85 bc ff ff fe 00 	movl   $0x205000,-0x1000044(%ebp)
  8000a1:	50 20 00 
  8000a4:	c7 85 c0 ff ff fe 00 	movl   $0x204000,-0x1000040(%ebp)
  8000ab:	40 20 00 
  8000ae:	c7 85 c4 ff ff fe 00 	movl   $0x203000,-0x100003c(%ebp)
  8000b5:	30 20 00 
  8000b8:	c7 85 c8 ff ff fe 00 	movl   $0x202000,-0x1000038(%ebp)
  8000bf:	20 20 00 
  8000c2:	c7 85 cc ff ff fe 00 	movl   $0x201000,-0x1000034(%ebp)
  8000c9:	10 20 00 
  8000cc:	c7 85 d0 ff ff fe 00 	movl   $0x200000,-0x1000030(%ebp)
  8000d3:	00 20 00 
	uint32 actual_second_list[7] = {};
  8000d6:	8d 95 88 ff ff fe    	lea    -0x1000078(%ebp),%edx
  8000dc:	b9 07 00 00 00       	mov    $0x7,%ecx
  8000e1:	b8 00 00 00 00       	mov    $0x0,%eax
  8000e6:	89 d7                	mov    %edx,%edi
  8000e8:	f3 ab                	rep stos %eax,%es:(%edi)
	("STEP 0: checking Initial LRU lists entries ...\n");
	{
		int check = sys_check_LRU_lists(actual_active_list, actual_second_list, 12, 0);
  8000ea:	6a 00                	push   $0x0
  8000ec:	6a 0c                	push   $0xc
  8000ee:	8d 85 88 ff ff fe    	lea    -0x1000078(%ebp),%eax
  8000f4:	50                   	push   %eax
  8000f5:	8d 85 a4 ff ff fe    	lea    -0x100005c(%ebp),%eax
  8000fb:	50                   	push   %eax
  8000fc:	e8 6d 1a 00 00       	call   801b6e <sys_check_LRU_lists>
  800101:	83 c4 10             	add    $0x10,%esp
  800104:	89 45 e8             	mov    %eax,-0x18(%ebp)
		if(check == 0)
  800107:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  80010b:	75 14                	jne    800121 <_main+0xe9>
			panic("INITIAL PAGE LRU LISTs entry checking failed! Review size of the LRU lists..!!");
  80010d:	83 ec 04             	sub    $0x4,%esp
  800110:	68 20 1e 80 00       	push   $0x801e20
  800115:	6a 14                	push   $0x14
  800117:	68 6f 1e 80 00       	push   $0x801e6f
  80011c:	e8 06 04 00 00       	call   800527 <_panic>
	}

	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800121:	e8 1c 16 00 00       	call   801742 <sys_pf_calculate_allocated_pages>
  800126:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int freePages = sys_calculate_free_frames();
  800129:	e8 91 15 00 00       	call   8016bf <sys_calculate_free_frames>
  80012e:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int i=0;
  800131:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for(;i<=PAGE_SIZE;i++)
  800138:	eb 11                	jmp    80014b <_main+0x113>
	{
		arr[i] = -1;
  80013a:	8d 95 d8 ff ff fe    	lea    -0x1000028(%ebp),%edx
  800140:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800143:	01 d0                	add    %edx,%eax
  800145:	c6 00 ff             	movb   $0xff,(%eax)

	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
	int freePages = sys_calculate_free_frames();

	int i=0;
	for(;i<=PAGE_SIZE;i++)
  800148:	ff 45 f4             	incl   -0xc(%ebp)
  80014b:	81 7d f4 00 10 00 00 	cmpl   $0x1000,-0xc(%ebp)
  800152:	7e e6                	jle    80013a <_main+0x102>
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024;
  800154:	c7 45 f4 00 00 40 00 	movl   $0x400000,-0xc(%ebp)
	for(;i<=(PAGE_SIZE*1024 + PAGE_SIZE);i++)
  80015b:	eb 11                	jmp    80016e <_main+0x136>
	{
		arr[i] = -1;
  80015d:	8d 95 d8 ff ff fe    	lea    -0x1000028(%ebp),%edx
  800163:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800166:	01 d0                	add    %edx,%eax
  800168:	c6 00 ff             	movb   $0xff,(%eax)
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024;
	for(;i<=(PAGE_SIZE*1024 + PAGE_SIZE);i++)
  80016b:	ff 45 f4             	incl   -0xc(%ebp)
  80016e:	81 7d f4 00 10 40 00 	cmpl   $0x401000,-0xc(%ebp)
  800175:	7e e6                	jle    80015d <_main+0x125>
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024*2;
  800177:	c7 45 f4 00 00 80 00 	movl   $0x800000,-0xc(%ebp)
	for(;i<=(PAGE_SIZE*1024*2 + PAGE_SIZE);i++)
  80017e:	eb 11                	jmp    800191 <_main+0x159>
	{
		arr[i] = -1;
  800180:	8d 95 d8 ff ff fe    	lea    -0x1000028(%ebp),%edx
  800186:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800189:	01 d0                	add    %edx,%eax
  80018b:	c6 00 ff             	movb   $0xff,(%eax)
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024*2;
	for(;i<=(PAGE_SIZE*1024*2 + PAGE_SIZE);i++)
  80018e:	ff 45 f4             	incl   -0xc(%ebp)
  800191:	81 7d f4 00 10 80 00 	cmpl   $0x801000,-0xc(%ebp)
  800198:	7e e6                	jle    800180 <_main+0x148>
	{
		arr[i] = -1;
	}

	uint32* secondlistVA= (uint32*)0x200000;
  80019a:	c7 45 dc 00 00 20 00 	movl   $0x200000,-0x24(%ebp)
	x = x + *secondlistVA;
  8001a1:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8001a4:	8b 10                	mov    (%eax),%edx
  8001a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001a9:	01 d0                	add    %edx,%eax
  8001ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
	secondlistVA = (uint32*) 0x202000;
  8001ae:	c7 45 dc 00 20 20 00 	movl   $0x202000,-0x24(%ebp)
	x = x + *secondlistVA;
  8001b5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8001b8:	8b 10                	mov    (%eax),%edx
  8001ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8001bd:	01 d0                	add    %edx,%eax
  8001bf:	89 45 ec             	mov    %eax,-0x14(%ebp)

	actual_second_list[0]=0X205000;
  8001c2:	c7 85 88 ff ff fe 00 	movl   $0x205000,-0x1000078(%ebp)
  8001c9:	50 20 00 
	actual_second_list[1]=0X204000;
  8001cc:	c7 85 8c ff ff fe 00 	movl   $0x204000,-0x1000074(%ebp)
  8001d3:	40 20 00 
	actual_second_list[2]=0x203000;
  8001d6:	c7 85 90 ff ff fe 00 	movl   $0x203000,-0x1000070(%ebp)
  8001dd:	30 20 00 
	actual_second_list[3]=0x201000;
  8001e0:	c7 85 94 ff ff fe 00 	movl   $0x201000,-0x100006c(%ebp)
  8001e7:	10 20 00 
	for (int i=12;i>6;i--)
  8001ea:	c7 45 f0 0c 00 00 00 	movl   $0xc,-0x10(%ebp)
  8001f1:	eb 1a                	jmp    80020d <_main+0x1d5>
		actual_active_list[i]=actual_active_list[i-7];
  8001f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8001f6:	83 e8 07             	sub    $0x7,%eax
  8001f9:	8b 94 85 a4 ff ff fe 	mov    -0x100005c(%ebp,%eax,4),%edx
  800200:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800203:	89 94 85 a4 ff ff fe 	mov    %edx,-0x100005c(%ebp,%eax,4)

	actual_second_list[0]=0X205000;
	actual_second_list[1]=0X204000;
	actual_second_list[2]=0x203000;
	actual_second_list[3]=0x201000;
	for (int i=12;i>6;i--)
  80020a:	ff 4d f0             	decl   -0x10(%ebp)
  80020d:	83 7d f0 06          	cmpl   $0x6,-0x10(%ebp)
  800211:	7f e0                	jg     8001f3 <_main+0x1bb>
		actual_active_list[i]=actual_active_list[i-7];

	actual_active_list[0]=0x202000;
  800213:	c7 85 a4 ff ff fe 00 	movl   $0x202000,-0x100005c(%ebp)
  80021a:	20 20 00 
	actual_active_list[1]=0x200000;
  80021d:	c7 85 a8 ff ff fe 00 	movl   $0x200000,-0x1000058(%ebp)
  800224:	00 20 00 
	actual_active_list[2]=0xee3fe000;
  800227:	c7 85 ac ff ff fe 00 	movl   $0xee3fe000,-0x1000054(%ebp)
  80022e:	e0 3f ee 
	actual_active_list[3]=0xee3fdfa0;
  800231:	c7 85 b0 ff ff fe a0 	movl   $0xee3fdfa0,-0x1000050(%ebp)
  800238:	df 3f ee 
	actual_active_list[4]=0xedffe000;
  80023b:	c7 85 b4 ff ff fe 00 	movl   $0xedffe000,-0x100004c(%ebp)
  800242:	e0 ff ed 
	actual_active_list[5]=0xedffdfa0;
  800245:	c7 85 b8 ff ff fe a0 	movl   $0xedffdfa0,-0x1000048(%ebp)
  80024c:	df ff ed 
	actual_active_list[6]=0xedbfe000;
  80024f:	c7 85 bc ff ff fe 00 	movl   $0xedbfe000,-0x1000044(%ebp)
  800256:	e0 bf ed 

	cprintf("STEP A: checking PLACEMENT fault handling ... \n");
  800259:	83 ec 0c             	sub    $0xc,%esp
  80025c:	68 88 1e 80 00       	push   $0x801e88
  800261:	e8 63 05 00 00       	call   8007c9 <cprintf>
  800266:	83 c4 10             	add    $0x10,%esp
	{
		if( arr[0] !=  -1)  panic("PLACEMENT of stack page failed");
  800269:	8a 85 d8 ff ff fe    	mov    -0x1000028(%ebp),%al
  80026f:	3c ff                	cmp    $0xff,%al
  800271:	74 14                	je     800287 <_main+0x24f>
  800273:	83 ec 04             	sub    $0x4,%esp
  800276:	68 b8 1e 80 00       	push   $0x801eb8
  80027b:	6a 42                	push   $0x42
  80027d:	68 6f 1e 80 00       	push   $0x801e6f
  800282:	e8 a0 02 00 00       	call   800527 <_panic>
		if( arr[PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  800287:	8a 85 d8 0f 00 ff    	mov    -0xfff028(%ebp),%al
  80028d:	3c ff                	cmp    $0xff,%al
  80028f:	74 14                	je     8002a5 <_main+0x26d>
  800291:	83 ec 04             	sub    $0x4,%esp
  800294:	68 b8 1e 80 00       	push   $0x801eb8
  800299:	6a 43                	push   $0x43
  80029b:	68 6f 1e 80 00       	push   $0x801e6f
  8002a0:	e8 82 02 00 00       	call   800527 <_panic>

		if( arr[PAGE_SIZE*1024] !=  -1)  panic("PLACEMENT of stack page failed");
  8002a5:	8a 85 d8 ff 3f ff    	mov    -0xc00028(%ebp),%al
  8002ab:	3c ff                	cmp    $0xff,%al
  8002ad:	74 14                	je     8002c3 <_main+0x28b>
  8002af:	83 ec 04             	sub    $0x4,%esp
  8002b2:	68 b8 1e 80 00       	push   $0x801eb8
  8002b7:	6a 45                	push   $0x45
  8002b9:	68 6f 1e 80 00       	push   $0x801e6f
  8002be:	e8 64 02 00 00       	call   800527 <_panic>
		if( arr[PAGE_SIZE*1025] !=  -1)  panic("PLACEMENT of stack page failed");
  8002c3:	8a 85 d8 0f 40 ff    	mov    -0xbff028(%ebp),%al
  8002c9:	3c ff                	cmp    $0xff,%al
  8002cb:	74 14                	je     8002e1 <_main+0x2a9>
  8002cd:	83 ec 04             	sub    $0x4,%esp
  8002d0:	68 b8 1e 80 00       	push   $0x801eb8
  8002d5:	6a 46                	push   $0x46
  8002d7:	68 6f 1e 80 00       	push   $0x801e6f
  8002dc:	e8 46 02 00 00       	call   800527 <_panic>

		if( arr[PAGE_SIZE*1024*2] !=  -1)  panic("PLACEMENT of stack page failed");
  8002e1:	8a 85 d8 ff 7f ff    	mov    -0x800028(%ebp),%al
  8002e7:	3c ff                	cmp    $0xff,%al
  8002e9:	74 14                	je     8002ff <_main+0x2c7>
  8002eb:	83 ec 04             	sub    $0x4,%esp
  8002ee:	68 b8 1e 80 00       	push   $0x801eb8
  8002f3:	6a 48                	push   $0x48
  8002f5:	68 6f 1e 80 00       	push   $0x801e6f
  8002fa:	e8 28 02 00 00       	call   800527 <_panic>
		if( arr[PAGE_SIZE*1024*2 + PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  8002ff:	8a 85 d8 0f 80 ff    	mov    -0x7ff028(%ebp),%al
  800305:	3c ff                	cmp    $0xff,%al
  800307:	74 14                	je     80031d <_main+0x2e5>
  800309:	83 ec 04             	sub    $0x4,%esp
  80030c:	68 b8 1e 80 00       	push   $0x801eb8
  800311:	6a 49                	push   $0x49
  800313:	68 6f 1e 80 00       	push   $0x801e6f
  800318:	e8 0a 02 00 00       	call   800527 <_panic>

		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5) panic("new stack pages are not written to Page File");
  80031d:	e8 20 14 00 00       	call   801742 <sys_pf_calculate_allocated_pages>
  800322:	2b 45 e4             	sub    -0x1c(%ebp),%eax
  800325:	83 f8 05             	cmp    $0x5,%eax
  800328:	74 14                	je     80033e <_main+0x306>
  80032a:	83 ec 04             	sub    $0x4,%esp
  80032d:	68 d8 1e 80 00       	push   $0x801ed8
  800332:	6a 4b                	push   $0x4b
  800334:	68 6f 1e 80 00       	push   $0x801e6f
  800339:	e8 e9 01 00 00       	call   800527 <_panic>

		if( (freePages - sys_calculate_free_frames() ) != 9 ) panic("allocated memory size incorrect");
  80033e:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  800341:	e8 79 13 00 00       	call   8016bf <sys_calculate_free_frames>
  800346:	29 c3                	sub    %eax,%ebx
  800348:	89 d8                	mov    %ebx,%eax
  80034a:	83 f8 09             	cmp    $0x9,%eax
  80034d:	74 14                	je     800363 <_main+0x32b>
  80034f:	83 ec 04             	sub    $0x4,%esp
  800352:	68 08 1f 80 00       	push   $0x801f08
  800357:	6a 4d                	push   $0x4d
  800359:	68 6f 1e 80 00       	push   $0x801e6f
  80035e:	e8 c4 01 00 00       	call   800527 <_panic>
	}
	cprintf("STEP A passed: PLACEMENT fault handling works!\n\n\n");
  800363:	83 ec 0c             	sub    $0xc,%esp
  800366:	68 28 1f 80 00       	push   $0x801f28
  80036b:	e8 59 04 00 00       	call   8007c9 <cprintf>
  800370:	83 c4 10             	add    $0x10,%esp

	cprintf("STEP B: checking LRU lists entries After Required PAGES IN SECOND LIST...\n");
  800373:	83 ec 0c             	sub    $0xc,%esp
  800376:	68 5c 1f 80 00       	push   $0x801f5c
  80037b:	e8 49 04 00 00       	call   8007c9 <cprintf>
  800380:	83 c4 10             	add    $0x10,%esp
	{
		int check = sys_check_LRU_lists(actual_active_list, actual_second_list, 13, 4);
  800383:	6a 04                	push   $0x4
  800385:	6a 0d                	push   $0xd
  800387:	8d 85 88 ff ff fe    	lea    -0x1000078(%ebp),%eax
  80038d:	50                   	push   %eax
  80038e:	8d 85 a4 ff ff fe    	lea    -0x100005c(%ebp),%eax
  800394:	50                   	push   %eax
  800395:	e8 d4 17 00 00       	call   801b6e <sys_check_LRU_lists>
  80039a:	83 c4 10             	add    $0x10,%esp
  80039d:	89 45 d8             	mov    %eax,-0x28(%ebp)
			if(check == 0)
  8003a0:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
  8003a4:	75 14                	jne    8003ba <_main+0x382>
				panic("LRU lists entries are not correct, check your logic again!!");
  8003a6:	83 ec 04             	sub    $0x4,%esp
  8003a9:	68 a8 1f 80 00       	push   $0x801fa8
  8003ae:	6a 55                	push   $0x55
  8003b0:	68 6f 1e 80 00       	push   $0x801e6f
  8003b5:	e8 6d 01 00 00       	call   800527 <_panic>
	}
	cprintf("STEP B passed: checking LRU lists entries After Required PAGES IN SECOND LIST test are correct\n\n\n");
  8003ba:	83 ec 0c             	sub    $0xc,%esp
  8003bd:	68 e4 1f 80 00       	push   $0x801fe4
  8003c2:	e8 02 04 00 00       	call   8007c9 <cprintf>
  8003c7:	83 c4 10             	add    $0x10,%esp
	cprintf("Congratulations!! Test of PAGE PLACEMENT THIRD SCENARIO completed successfully!!\n\n\n");
  8003ca:	83 ec 0c             	sub    $0xc,%esp
  8003cd:	68 48 20 80 00       	push   $0x802048
  8003d2:	e8 f2 03 00 00       	call   8007c9 <cprintf>
  8003d7:	83 c4 10             	add    $0x10,%esp
	return;
  8003da:	90                   	nop
}
  8003db:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8003de:	5b                   	pop    %ebx
  8003df:	5f                   	pop    %edi
  8003e0:	5d                   	pop    %ebp
  8003e1:	c3                   	ret    

008003e2 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8003e2:	55                   	push   %ebp
  8003e3:	89 e5                	mov    %esp,%ebp
  8003e5:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8003e8:	e8 07 12 00 00       	call   8015f4 <sys_getenvindex>
  8003ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8003f0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003f3:	89 d0                	mov    %edx,%eax
  8003f5:	c1 e0 03             	shl    $0x3,%eax
  8003f8:	01 d0                	add    %edx,%eax
  8003fa:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800401:	01 c8                	add    %ecx,%eax
  800403:	01 c0                	add    %eax,%eax
  800405:	01 d0                	add    %edx,%eax
  800407:	01 c0                	add    %eax,%eax
  800409:	01 d0                	add    %edx,%eax
  80040b:	89 c2                	mov    %eax,%edx
  80040d:	c1 e2 05             	shl    $0x5,%edx
  800410:	29 c2                	sub    %eax,%edx
  800412:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800419:	89 c2                	mov    %eax,%edx
  80041b:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800421:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800426:	a1 20 30 80 00       	mov    0x803020,%eax
  80042b:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800431:	84 c0                	test   %al,%al
  800433:	74 0f                	je     800444 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800435:	a1 20 30 80 00       	mov    0x803020,%eax
  80043a:	05 40 3c 01 00       	add    $0x13c40,%eax
  80043f:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800444:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800448:	7e 0a                	jle    800454 <libmain+0x72>
		binaryname = argv[0];
  80044a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80044d:	8b 00                	mov    (%eax),%eax
  80044f:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800454:	83 ec 08             	sub    $0x8,%esp
  800457:	ff 75 0c             	pushl  0xc(%ebp)
  80045a:	ff 75 08             	pushl  0x8(%ebp)
  80045d:	e8 d6 fb ff ff       	call   800038 <_main>
  800462:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800465:	e8 25 13 00 00       	call   80178f <sys_disable_interrupt>
	cprintf("**************************************\n");
  80046a:	83 ec 0c             	sub    $0xc,%esp
  80046d:	68 b4 20 80 00       	push   $0x8020b4
  800472:	e8 52 03 00 00       	call   8007c9 <cprintf>
  800477:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80047a:	a1 20 30 80 00       	mov    0x803020,%eax
  80047f:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  800485:	a1 20 30 80 00       	mov    0x803020,%eax
  80048a:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800490:	83 ec 04             	sub    $0x4,%esp
  800493:	52                   	push   %edx
  800494:	50                   	push   %eax
  800495:	68 dc 20 80 00       	push   $0x8020dc
  80049a:	e8 2a 03 00 00       	call   8007c9 <cprintf>
  80049f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8004a2:	a1 20 30 80 00       	mov    0x803020,%eax
  8004a7:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8004ad:	a1 20 30 80 00       	mov    0x803020,%eax
  8004b2:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8004b8:	83 ec 04             	sub    $0x4,%esp
  8004bb:	52                   	push   %edx
  8004bc:	50                   	push   %eax
  8004bd:	68 04 21 80 00       	push   $0x802104
  8004c2:	e8 02 03 00 00       	call   8007c9 <cprintf>
  8004c7:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  8004ca:	a1 20 30 80 00       	mov    0x803020,%eax
  8004cf:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  8004d5:	83 ec 08             	sub    $0x8,%esp
  8004d8:	50                   	push   %eax
  8004d9:	68 45 21 80 00       	push   $0x802145
  8004de:	e8 e6 02 00 00       	call   8007c9 <cprintf>
  8004e3:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8004e6:	83 ec 0c             	sub    $0xc,%esp
  8004e9:	68 b4 20 80 00       	push   $0x8020b4
  8004ee:	e8 d6 02 00 00       	call   8007c9 <cprintf>
  8004f3:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8004f6:	e8 ae 12 00 00       	call   8017a9 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8004fb:	e8 19 00 00 00       	call   800519 <exit>
}
  800500:	90                   	nop
  800501:	c9                   	leave  
  800502:	c3                   	ret    

00800503 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800503:	55                   	push   %ebp
  800504:	89 e5                	mov    %esp,%ebp
  800506:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800509:	83 ec 0c             	sub    $0xc,%esp
  80050c:	6a 00                	push   $0x0
  80050e:	e8 ad 10 00 00       	call   8015c0 <sys_env_destroy>
  800513:	83 c4 10             	add    $0x10,%esp
}
  800516:	90                   	nop
  800517:	c9                   	leave  
  800518:	c3                   	ret    

00800519 <exit>:

void
exit(void)
{
  800519:	55                   	push   %ebp
  80051a:	89 e5                	mov    %esp,%ebp
  80051c:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80051f:	e8 02 11 00 00       	call   801626 <sys_env_exit>
}
  800524:	90                   	nop
  800525:	c9                   	leave  
  800526:	c3                   	ret    

00800527 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800527:	55                   	push   %ebp
  800528:	89 e5                	mov    %esp,%ebp
  80052a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80052d:	8d 45 10             	lea    0x10(%ebp),%eax
  800530:	83 c0 04             	add    $0x4,%eax
  800533:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800536:	a1 18 31 80 00       	mov    0x803118,%eax
  80053b:	85 c0                	test   %eax,%eax
  80053d:	74 16                	je     800555 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80053f:	a1 18 31 80 00       	mov    0x803118,%eax
  800544:	83 ec 08             	sub    $0x8,%esp
  800547:	50                   	push   %eax
  800548:	68 5c 21 80 00       	push   $0x80215c
  80054d:	e8 77 02 00 00       	call   8007c9 <cprintf>
  800552:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800555:	a1 00 30 80 00       	mov    0x803000,%eax
  80055a:	ff 75 0c             	pushl  0xc(%ebp)
  80055d:	ff 75 08             	pushl  0x8(%ebp)
  800560:	50                   	push   %eax
  800561:	68 61 21 80 00       	push   $0x802161
  800566:	e8 5e 02 00 00       	call   8007c9 <cprintf>
  80056b:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80056e:	8b 45 10             	mov    0x10(%ebp),%eax
  800571:	83 ec 08             	sub    $0x8,%esp
  800574:	ff 75 f4             	pushl  -0xc(%ebp)
  800577:	50                   	push   %eax
  800578:	e8 e1 01 00 00       	call   80075e <vcprintf>
  80057d:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800580:	83 ec 08             	sub    $0x8,%esp
  800583:	6a 00                	push   $0x0
  800585:	68 7d 21 80 00       	push   $0x80217d
  80058a:	e8 cf 01 00 00       	call   80075e <vcprintf>
  80058f:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800592:	e8 82 ff ff ff       	call   800519 <exit>

	// should not return here
	while (1) ;
  800597:	eb fe                	jmp    800597 <_panic+0x70>

00800599 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800599:	55                   	push   %ebp
  80059a:	89 e5                	mov    %esp,%ebp
  80059c:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80059f:	a1 20 30 80 00       	mov    0x803020,%eax
  8005a4:	8b 50 74             	mov    0x74(%eax),%edx
  8005a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005aa:	39 c2                	cmp    %eax,%edx
  8005ac:	74 14                	je     8005c2 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8005ae:	83 ec 04             	sub    $0x4,%esp
  8005b1:	68 80 21 80 00       	push   $0x802180
  8005b6:	6a 26                	push   $0x26
  8005b8:	68 cc 21 80 00       	push   $0x8021cc
  8005bd:	e8 65 ff ff ff       	call   800527 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8005c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8005c9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8005d0:	e9 b6 00 00 00       	jmp    80068b <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  8005d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005d8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005df:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e2:	01 d0                	add    %edx,%eax
  8005e4:	8b 00                	mov    (%eax),%eax
  8005e6:	85 c0                	test   %eax,%eax
  8005e8:	75 08                	jne    8005f2 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8005ea:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8005ed:	e9 96 00 00 00       	jmp    800688 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8005f2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005f9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800600:	eb 5d                	jmp    80065f <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800602:	a1 20 30 80 00       	mov    0x803020,%eax
  800607:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80060d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800610:	c1 e2 04             	shl    $0x4,%edx
  800613:	01 d0                	add    %edx,%eax
  800615:	8a 40 04             	mov    0x4(%eax),%al
  800618:	84 c0                	test   %al,%al
  80061a:	75 40                	jne    80065c <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80061c:	a1 20 30 80 00       	mov    0x803020,%eax
  800621:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800627:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80062a:	c1 e2 04             	shl    $0x4,%edx
  80062d:	01 d0                	add    %edx,%eax
  80062f:	8b 00                	mov    (%eax),%eax
  800631:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800634:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800637:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80063c:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80063e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800641:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800648:	8b 45 08             	mov    0x8(%ebp),%eax
  80064b:	01 c8                	add    %ecx,%eax
  80064d:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80064f:	39 c2                	cmp    %eax,%edx
  800651:	75 09                	jne    80065c <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800653:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80065a:	eb 12                	jmp    80066e <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80065c:	ff 45 e8             	incl   -0x18(%ebp)
  80065f:	a1 20 30 80 00       	mov    0x803020,%eax
  800664:	8b 50 74             	mov    0x74(%eax),%edx
  800667:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80066a:	39 c2                	cmp    %eax,%edx
  80066c:	77 94                	ja     800602 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80066e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800672:	75 14                	jne    800688 <CheckWSWithoutLastIndex+0xef>
			panic(
  800674:	83 ec 04             	sub    $0x4,%esp
  800677:	68 d8 21 80 00       	push   $0x8021d8
  80067c:	6a 3a                	push   $0x3a
  80067e:	68 cc 21 80 00       	push   $0x8021cc
  800683:	e8 9f fe ff ff       	call   800527 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800688:	ff 45 f0             	incl   -0x10(%ebp)
  80068b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80068e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800691:	0f 8c 3e ff ff ff    	jl     8005d5 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800697:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80069e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8006a5:	eb 20                	jmp    8006c7 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8006a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8006ac:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8006b2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006b5:	c1 e2 04             	shl    $0x4,%edx
  8006b8:	01 d0                	add    %edx,%eax
  8006ba:	8a 40 04             	mov    0x4(%eax),%al
  8006bd:	3c 01                	cmp    $0x1,%al
  8006bf:	75 03                	jne    8006c4 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  8006c1:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8006c4:	ff 45 e0             	incl   -0x20(%ebp)
  8006c7:	a1 20 30 80 00       	mov    0x803020,%eax
  8006cc:	8b 50 74             	mov    0x74(%eax),%edx
  8006cf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006d2:	39 c2                	cmp    %eax,%edx
  8006d4:	77 d1                	ja     8006a7 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8006d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006d9:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8006dc:	74 14                	je     8006f2 <CheckWSWithoutLastIndex+0x159>
		panic(
  8006de:	83 ec 04             	sub    $0x4,%esp
  8006e1:	68 2c 22 80 00       	push   $0x80222c
  8006e6:	6a 44                	push   $0x44
  8006e8:	68 cc 21 80 00       	push   $0x8021cc
  8006ed:	e8 35 fe ff ff       	call   800527 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8006f2:	90                   	nop
  8006f3:	c9                   	leave  
  8006f4:	c3                   	ret    

008006f5 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8006f5:	55                   	push   %ebp
  8006f6:	89 e5                	mov    %esp,%ebp
  8006f8:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8006fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006fe:	8b 00                	mov    (%eax),%eax
  800700:	8d 48 01             	lea    0x1(%eax),%ecx
  800703:	8b 55 0c             	mov    0xc(%ebp),%edx
  800706:	89 0a                	mov    %ecx,(%edx)
  800708:	8b 55 08             	mov    0x8(%ebp),%edx
  80070b:	88 d1                	mov    %dl,%cl
  80070d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800710:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800714:	8b 45 0c             	mov    0xc(%ebp),%eax
  800717:	8b 00                	mov    (%eax),%eax
  800719:	3d ff 00 00 00       	cmp    $0xff,%eax
  80071e:	75 2c                	jne    80074c <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800720:	a0 24 30 80 00       	mov    0x803024,%al
  800725:	0f b6 c0             	movzbl %al,%eax
  800728:	8b 55 0c             	mov    0xc(%ebp),%edx
  80072b:	8b 12                	mov    (%edx),%edx
  80072d:	89 d1                	mov    %edx,%ecx
  80072f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800732:	83 c2 08             	add    $0x8,%edx
  800735:	83 ec 04             	sub    $0x4,%esp
  800738:	50                   	push   %eax
  800739:	51                   	push   %ecx
  80073a:	52                   	push   %edx
  80073b:	e8 3e 0e 00 00       	call   80157e <sys_cputs>
  800740:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800743:	8b 45 0c             	mov    0xc(%ebp),%eax
  800746:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80074c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80074f:	8b 40 04             	mov    0x4(%eax),%eax
  800752:	8d 50 01             	lea    0x1(%eax),%edx
  800755:	8b 45 0c             	mov    0xc(%ebp),%eax
  800758:	89 50 04             	mov    %edx,0x4(%eax)
}
  80075b:	90                   	nop
  80075c:	c9                   	leave  
  80075d:	c3                   	ret    

0080075e <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80075e:	55                   	push   %ebp
  80075f:	89 e5                	mov    %esp,%ebp
  800761:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800767:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80076e:	00 00 00 
	b.cnt = 0;
  800771:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800778:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80077b:	ff 75 0c             	pushl  0xc(%ebp)
  80077e:	ff 75 08             	pushl  0x8(%ebp)
  800781:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800787:	50                   	push   %eax
  800788:	68 f5 06 80 00       	push   $0x8006f5
  80078d:	e8 11 02 00 00       	call   8009a3 <vprintfmt>
  800792:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800795:	a0 24 30 80 00       	mov    0x803024,%al
  80079a:	0f b6 c0             	movzbl %al,%eax
  80079d:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8007a3:	83 ec 04             	sub    $0x4,%esp
  8007a6:	50                   	push   %eax
  8007a7:	52                   	push   %edx
  8007a8:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8007ae:	83 c0 08             	add    $0x8,%eax
  8007b1:	50                   	push   %eax
  8007b2:	e8 c7 0d 00 00       	call   80157e <sys_cputs>
  8007b7:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8007ba:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8007c1:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8007c7:	c9                   	leave  
  8007c8:	c3                   	ret    

008007c9 <cprintf>:

int cprintf(const char *fmt, ...) {
  8007c9:	55                   	push   %ebp
  8007ca:	89 e5                	mov    %esp,%ebp
  8007cc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8007cf:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8007d6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8007d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8007dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007df:	83 ec 08             	sub    $0x8,%esp
  8007e2:	ff 75 f4             	pushl  -0xc(%ebp)
  8007e5:	50                   	push   %eax
  8007e6:	e8 73 ff ff ff       	call   80075e <vcprintf>
  8007eb:	83 c4 10             	add    $0x10,%esp
  8007ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8007f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007f4:	c9                   	leave  
  8007f5:	c3                   	ret    

008007f6 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8007f6:	55                   	push   %ebp
  8007f7:	89 e5                	mov    %esp,%ebp
  8007f9:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8007fc:	e8 8e 0f 00 00       	call   80178f <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800801:	8d 45 0c             	lea    0xc(%ebp),%eax
  800804:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800807:	8b 45 08             	mov    0x8(%ebp),%eax
  80080a:	83 ec 08             	sub    $0x8,%esp
  80080d:	ff 75 f4             	pushl  -0xc(%ebp)
  800810:	50                   	push   %eax
  800811:	e8 48 ff ff ff       	call   80075e <vcprintf>
  800816:	83 c4 10             	add    $0x10,%esp
  800819:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80081c:	e8 88 0f 00 00       	call   8017a9 <sys_enable_interrupt>
	return cnt;
  800821:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800824:	c9                   	leave  
  800825:	c3                   	ret    

00800826 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800826:	55                   	push   %ebp
  800827:	89 e5                	mov    %esp,%ebp
  800829:	53                   	push   %ebx
  80082a:	83 ec 14             	sub    $0x14,%esp
  80082d:	8b 45 10             	mov    0x10(%ebp),%eax
  800830:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800833:	8b 45 14             	mov    0x14(%ebp),%eax
  800836:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800839:	8b 45 18             	mov    0x18(%ebp),%eax
  80083c:	ba 00 00 00 00       	mov    $0x0,%edx
  800841:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800844:	77 55                	ja     80089b <printnum+0x75>
  800846:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800849:	72 05                	jb     800850 <printnum+0x2a>
  80084b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80084e:	77 4b                	ja     80089b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800850:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800853:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800856:	8b 45 18             	mov    0x18(%ebp),%eax
  800859:	ba 00 00 00 00       	mov    $0x0,%edx
  80085e:	52                   	push   %edx
  80085f:	50                   	push   %eax
  800860:	ff 75 f4             	pushl  -0xc(%ebp)
  800863:	ff 75 f0             	pushl  -0x10(%ebp)
  800866:	e8 45 13 00 00       	call   801bb0 <__udivdi3>
  80086b:	83 c4 10             	add    $0x10,%esp
  80086e:	83 ec 04             	sub    $0x4,%esp
  800871:	ff 75 20             	pushl  0x20(%ebp)
  800874:	53                   	push   %ebx
  800875:	ff 75 18             	pushl  0x18(%ebp)
  800878:	52                   	push   %edx
  800879:	50                   	push   %eax
  80087a:	ff 75 0c             	pushl  0xc(%ebp)
  80087d:	ff 75 08             	pushl  0x8(%ebp)
  800880:	e8 a1 ff ff ff       	call   800826 <printnum>
  800885:	83 c4 20             	add    $0x20,%esp
  800888:	eb 1a                	jmp    8008a4 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80088a:	83 ec 08             	sub    $0x8,%esp
  80088d:	ff 75 0c             	pushl  0xc(%ebp)
  800890:	ff 75 20             	pushl  0x20(%ebp)
  800893:	8b 45 08             	mov    0x8(%ebp),%eax
  800896:	ff d0                	call   *%eax
  800898:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80089b:	ff 4d 1c             	decl   0x1c(%ebp)
  80089e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8008a2:	7f e6                	jg     80088a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8008a4:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8008a7:	bb 00 00 00 00       	mov    $0x0,%ebx
  8008ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008af:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008b2:	53                   	push   %ebx
  8008b3:	51                   	push   %ecx
  8008b4:	52                   	push   %edx
  8008b5:	50                   	push   %eax
  8008b6:	e8 05 14 00 00       	call   801cc0 <__umoddi3>
  8008bb:	83 c4 10             	add    $0x10,%esp
  8008be:	05 94 24 80 00       	add    $0x802494,%eax
  8008c3:	8a 00                	mov    (%eax),%al
  8008c5:	0f be c0             	movsbl %al,%eax
  8008c8:	83 ec 08             	sub    $0x8,%esp
  8008cb:	ff 75 0c             	pushl  0xc(%ebp)
  8008ce:	50                   	push   %eax
  8008cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d2:	ff d0                	call   *%eax
  8008d4:	83 c4 10             	add    $0x10,%esp
}
  8008d7:	90                   	nop
  8008d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8008db:	c9                   	leave  
  8008dc:	c3                   	ret    

008008dd <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8008dd:	55                   	push   %ebp
  8008de:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008e0:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008e4:	7e 1c                	jle    800902 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8008e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e9:	8b 00                	mov    (%eax),%eax
  8008eb:	8d 50 08             	lea    0x8(%eax),%edx
  8008ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f1:	89 10                	mov    %edx,(%eax)
  8008f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f6:	8b 00                	mov    (%eax),%eax
  8008f8:	83 e8 08             	sub    $0x8,%eax
  8008fb:	8b 50 04             	mov    0x4(%eax),%edx
  8008fe:	8b 00                	mov    (%eax),%eax
  800900:	eb 40                	jmp    800942 <getuint+0x65>
	else if (lflag)
  800902:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800906:	74 1e                	je     800926 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800908:	8b 45 08             	mov    0x8(%ebp),%eax
  80090b:	8b 00                	mov    (%eax),%eax
  80090d:	8d 50 04             	lea    0x4(%eax),%edx
  800910:	8b 45 08             	mov    0x8(%ebp),%eax
  800913:	89 10                	mov    %edx,(%eax)
  800915:	8b 45 08             	mov    0x8(%ebp),%eax
  800918:	8b 00                	mov    (%eax),%eax
  80091a:	83 e8 04             	sub    $0x4,%eax
  80091d:	8b 00                	mov    (%eax),%eax
  80091f:	ba 00 00 00 00       	mov    $0x0,%edx
  800924:	eb 1c                	jmp    800942 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800926:	8b 45 08             	mov    0x8(%ebp),%eax
  800929:	8b 00                	mov    (%eax),%eax
  80092b:	8d 50 04             	lea    0x4(%eax),%edx
  80092e:	8b 45 08             	mov    0x8(%ebp),%eax
  800931:	89 10                	mov    %edx,(%eax)
  800933:	8b 45 08             	mov    0x8(%ebp),%eax
  800936:	8b 00                	mov    (%eax),%eax
  800938:	83 e8 04             	sub    $0x4,%eax
  80093b:	8b 00                	mov    (%eax),%eax
  80093d:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800942:	5d                   	pop    %ebp
  800943:	c3                   	ret    

00800944 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800944:	55                   	push   %ebp
  800945:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800947:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80094b:	7e 1c                	jle    800969 <getint+0x25>
		return va_arg(*ap, long long);
  80094d:	8b 45 08             	mov    0x8(%ebp),%eax
  800950:	8b 00                	mov    (%eax),%eax
  800952:	8d 50 08             	lea    0x8(%eax),%edx
  800955:	8b 45 08             	mov    0x8(%ebp),%eax
  800958:	89 10                	mov    %edx,(%eax)
  80095a:	8b 45 08             	mov    0x8(%ebp),%eax
  80095d:	8b 00                	mov    (%eax),%eax
  80095f:	83 e8 08             	sub    $0x8,%eax
  800962:	8b 50 04             	mov    0x4(%eax),%edx
  800965:	8b 00                	mov    (%eax),%eax
  800967:	eb 38                	jmp    8009a1 <getint+0x5d>
	else if (lflag)
  800969:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80096d:	74 1a                	je     800989 <getint+0x45>
		return va_arg(*ap, long);
  80096f:	8b 45 08             	mov    0x8(%ebp),%eax
  800972:	8b 00                	mov    (%eax),%eax
  800974:	8d 50 04             	lea    0x4(%eax),%edx
  800977:	8b 45 08             	mov    0x8(%ebp),%eax
  80097a:	89 10                	mov    %edx,(%eax)
  80097c:	8b 45 08             	mov    0x8(%ebp),%eax
  80097f:	8b 00                	mov    (%eax),%eax
  800981:	83 e8 04             	sub    $0x4,%eax
  800984:	8b 00                	mov    (%eax),%eax
  800986:	99                   	cltd   
  800987:	eb 18                	jmp    8009a1 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800989:	8b 45 08             	mov    0x8(%ebp),%eax
  80098c:	8b 00                	mov    (%eax),%eax
  80098e:	8d 50 04             	lea    0x4(%eax),%edx
  800991:	8b 45 08             	mov    0x8(%ebp),%eax
  800994:	89 10                	mov    %edx,(%eax)
  800996:	8b 45 08             	mov    0x8(%ebp),%eax
  800999:	8b 00                	mov    (%eax),%eax
  80099b:	83 e8 04             	sub    $0x4,%eax
  80099e:	8b 00                	mov    (%eax),%eax
  8009a0:	99                   	cltd   
}
  8009a1:	5d                   	pop    %ebp
  8009a2:	c3                   	ret    

008009a3 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8009a3:	55                   	push   %ebp
  8009a4:	89 e5                	mov    %esp,%ebp
  8009a6:	56                   	push   %esi
  8009a7:	53                   	push   %ebx
  8009a8:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009ab:	eb 17                	jmp    8009c4 <vprintfmt+0x21>
			if (ch == '\0')
  8009ad:	85 db                	test   %ebx,%ebx
  8009af:	0f 84 af 03 00 00    	je     800d64 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8009b5:	83 ec 08             	sub    $0x8,%esp
  8009b8:	ff 75 0c             	pushl  0xc(%ebp)
  8009bb:	53                   	push   %ebx
  8009bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bf:	ff d0                	call   *%eax
  8009c1:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8009c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8009c7:	8d 50 01             	lea    0x1(%eax),%edx
  8009ca:	89 55 10             	mov    %edx,0x10(%ebp)
  8009cd:	8a 00                	mov    (%eax),%al
  8009cf:	0f b6 d8             	movzbl %al,%ebx
  8009d2:	83 fb 25             	cmp    $0x25,%ebx
  8009d5:	75 d6                	jne    8009ad <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8009d7:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8009db:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8009e2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8009e9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8009f0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8009f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8009fa:	8d 50 01             	lea    0x1(%eax),%edx
  8009fd:	89 55 10             	mov    %edx,0x10(%ebp)
  800a00:	8a 00                	mov    (%eax),%al
  800a02:	0f b6 d8             	movzbl %al,%ebx
  800a05:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800a08:	83 f8 55             	cmp    $0x55,%eax
  800a0b:	0f 87 2b 03 00 00    	ja     800d3c <vprintfmt+0x399>
  800a11:	8b 04 85 b8 24 80 00 	mov    0x8024b8(,%eax,4),%eax
  800a18:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800a1a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800a1e:	eb d7                	jmp    8009f7 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800a20:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800a24:	eb d1                	jmp    8009f7 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a26:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800a2d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a30:	89 d0                	mov    %edx,%eax
  800a32:	c1 e0 02             	shl    $0x2,%eax
  800a35:	01 d0                	add    %edx,%eax
  800a37:	01 c0                	add    %eax,%eax
  800a39:	01 d8                	add    %ebx,%eax
  800a3b:	83 e8 30             	sub    $0x30,%eax
  800a3e:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800a41:	8b 45 10             	mov    0x10(%ebp),%eax
  800a44:	8a 00                	mov    (%eax),%al
  800a46:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800a49:	83 fb 2f             	cmp    $0x2f,%ebx
  800a4c:	7e 3e                	jle    800a8c <vprintfmt+0xe9>
  800a4e:	83 fb 39             	cmp    $0x39,%ebx
  800a51:	7f 39                	jg     800a8c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800a53:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800a56:	eb d5                	jmp    800a2d <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800a58:	8b 45 14             	mov    0x14(%ebp),%eax
  800a5b:	83 c0 04             	add    $0x4,%eax
  800a5e:	89 45 14             	mov    %eax,0x14(%ebp)
  800a61:	8b 45 14             	mov    0x14(%ebp),%eax
  800a64:	83 e8 04             	sub    $0x4,%eax
  800a67:	8b 00                	mov    (%eax),%eax
  800a69:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800a6c:	eb 1f                	jmp    800a8d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800a6e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a72:	79 83                	jns    8009f7 <vprintfmt+0x54>
				width = 0;
  800a74:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800a7b:	e9 77 ff ff ff       	jmp    8009f7 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800a80:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800a87:	e9 6b ff ff ff       	jmp    8009f7 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800a8c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800a8d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a91:	0f 89 60 ff ff ff    	jns    8009f7 <vprintfmt+0x54>
				width = precision, precision = -1;
  800a97:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a9a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800a9d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800aa4:	e9 4e ff ff ff       	jmp    8009f7 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800aa9:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800aac:	e9 46 ff ff ff       	jmp    8009f7 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800ab1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ab4:	83 c0 04             	add    $0x4,%eax
  800ab7:	89 45 14             	mov    %eax,0x14(%ebp)
  800aba:	8b 45 14             	mov    0x14(%ebp),%eax
  800abd:	83 e8 04             	sub    $0x4,%eax
  800ac0:	8b 00                	mov    (%eax),%eax
  800ac2:	83 ec 08             	sub    $0x8,%esp
  800ac5:	ff 75 0c             	pushl  0xc(%ebp)
  800ac8:	50                   	push   %eax
  800ac9:	8b 45 08             	mov    0x8(%ebp),%eax
  800acc:	ff d0                	call   *%eax
  800ace:	83 c4 10             	add    $0x10,%esp
			break;
  800ad1:	e9 89 02 00 00       	jmp    800d5f <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800ad6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ad9:	83 c0 04             	add    $0x4,%eax
  800adc:	89 45 14             	mov    %eax,0x14(%ebp)
  800adf:	8b 45 14             	mov    0x14(%ebp),%eax
  800ae2:	83 e8 04             	sub    $0x4,%eax
  800ae5:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ae7:	85 db                	test   %ebx,%ebx
  800ae9:	79 02                	jns    800aed <vprintfmt+0x14a>
				err = -err;
  800aeb:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800aed:	83 fb 64             	cmp    $0x64,%ebx
  800af0:	7f 0b                	jg     800afd <vprintfmt+0x15a>
  800af2:	8b 34 9d 00 23 80 00 	mov    0x802300(,%ebx,4),%esi
  800af9:	85 f6                	test   %esi,%esi
  800afb:	75 19                	jne    800b16 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800afd:	53                   	push   %ebx
  800afe:	68 a5 24 80 00       	push   $0x8024a5
  800b03:	ff 75 0c             	pushl  0xc(%ebp)
  800b06:	ff 75 08             	pushl  0x8(%ebp)
  800b09:	e8 5e 02 00 00       	call   800d6c <printfmt>
  800b0e:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800b11:	e9 49 02 00 00       	jmp    800d5f <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800b16:	56                   	push   %esi
  800b17:	68 ae 24 80 00       	push   $0x8024ae
  800b1c:	ff 75 0c             	pushl  0xc(%ebp)
  800b1f:	ff 75 08             	pushl  0x8(%ebp)
  800b22:	e8 45 02 00 00       	call   800d6c <printfmt>
  800b27:	83 c4 10             	add    $0x10,%esp
			break;
  800b2a:	e9 30 02 00 00       	jmp    800d5f <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800b2f:	8b 45 14             	mov    0x14(%ebp),%eax
  800b32:	83 c0 04             	add    $0x4,%eax
  800b35:	89 45 14             	mov    %eax,0x14(%ebp)
  800b38:	8b 45 14             	mov    0x14(%ebp),%eax
  800b3b:	83 e8 04             	sub    $0x4,%eax
  800b3e:	8b 30                	mov    (%eax),%esi
  800b40:	85 f6                	test   %esi,%esi
  800b42:	75 05                	jne    800b49 <vprintfmt+0x1a6>
				p = "(null)";
  800b44:	be b1 24 80 00       	mov    $0x8024b1,%esi
			if (width > 0 && padc != '-')
  800b49:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b4d:	7e 6d                	jle    800bbc <vprintfmt+0x219>
  800b4f:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800b53:	74 67                	je     800bbc <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800b55:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b58:	83 ec 08             	sub    $0x8,%esp
  800b5b:	50                   	push   %eax
  800b5c:	56                   	push   %esi
  800b5d:	e8 0c 03 00 00       	call   800e6e <strnlen>
  800b62:	83 c4 10             	add    $0x10,%esp
  800b65:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800b68:	eb 16                	jmp    800b80 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800b6a:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800b6e:	83 ec 08             	sub    $0x8,%esp
  800b71:	ff 75 0c             	pushl  0xc(%ebp)
  800b74:	50                   	push   %eax
  800b75:	8b 45 08             	mov    0x8(%ebp),%eax
  800b78:	ff d0                	call   *%eax
  800b7a:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800b7d:	ff 4d e4             	decl   -0x1c(%ebp)
  800b80:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b84:	7f e4                	jg     800b6a <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b86:	eb 34                	jmp    800bbc <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800b88:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800b8c:	74 1c                	je     800baa <vprintfmt+0x207>
  800b8e:	83 fb 1f             	cmp    $0x1f,%ebx
  800b91:	7e 05                	jle    800b98 <vprintfmt+0x1f5>
  800b93:	83 fb 7e             	cmp    $0x7e,%ebx
  800b96:	7e 12                	jle    800baa <vprintfmt+0x207>
					putch('?', putdat);
  800b98:	83 ec 08             	sub    $0x8,%esp
  800b9b:	ff 75 0c             	pushl  0xc(%ebp)
  800b9e:	6a 3f                	push   $0x3f
  800ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba3:	ff d0                	call   *%eax
  800ba5:	83 c4 10             	add    $0x10,%esp
  800ba8:	eb 0f                	jmp    800bb9 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800baa:	83 ec 08             	sub    $0x8,%esp
  800bad:	ff 75 0c             	pushl  0xc(%ebp)
  800bb0:	53                   	push   %ebx
  800bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb4:	ff d0                	call   *%eax
  800bb6:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800bb9:	ff 4d e4             	decl   -0x1c(%ebp)
  800bbc:	89 f0                	mov    %esi,%eax
  800bbe:	8d 70 01             	lea    0x1(%eax),%esi
  800bc1:	8a 00                	mov    (%eax),%al
  800bc3:	0f be d8             	movsbl %al,%ebx
  800bc6:	85 db                	test   %ebx,%ebx
  800bc8:	74 24                	je     800bee <vprintfmt+0x24b>
  800bca:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800bce:	78 b8                	js     800b88 <vprintfmt+0x1e5>
  800bd0:	ff 4d e0             	decl   -0x20(%ebp)
  800bd3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800bd7:	79 af                	jns    800b88 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800bd9:	eb 13                	jmp    800bee <vprintfmt+0x24b>
				putch(' ', putdat);
  800bdb:	83 ec 08             	sub    $0x8,%esp
  800bde:	ff 75 0c             	pushl  0xc(%ebp)
  800be1:	6a 20                	push   $0x20
  800be3:	8b 45 08             	mov    0x8(%ebp),%eax
  800be6:	ff d0                	call   *%eax
  800be8:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800beb:	ff 4d e4             	decl   -0x1c(%ebp)
  800bee:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800bf2:	7f e7                	jg     800bdb <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800bf4:	e9 66 01 00 00       	jmp    800d5f <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800bf9:	83 ec 08             	sub    $0x8,%esp
  800bfc:	ff 75 e8             	pushl  -0x18(%ebp)
  800bff:	8d 45 14             	lea    0x14(%ebp),%eax
  800c02:	50                   	push   %eax
  800c03:	e8 3c fd ff ff       	call   800944 <getint>
  800c08:	83 c4 10             	add    $0x10,%esp
  800c0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c0e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800c11:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c14:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c17:	85 d2                	test   %edx,%edx
  800c19:	79 23                	jns    800c3e <vprintfmt+0x29b>
				putch('-', putdat);
  800c1b:	83 ec 08             	sub    $0x8,%esp
  800c1e:	ff 75 0c             	pushl  0xc(%ebp)
  800c21:	6a 2d                	push   $0x2d
  800c23:	8b 45 08             	mov    0x8(%ebp),%eax
  800c26:	ff d0                	call   *%eax
  800c28:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800c2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c2e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c31:	f7 d8                	neg    %eax
  800c33:	83 d2 00             	adc    $0x0,%edx
  800c36:	f7 da                	neg    %edx
  800c38:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c3b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800c3e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c45:	e9 bc 00 00 00       	jmp    800d06 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800c4a:	83 ec 08             	sub    $0x8,%esp
  800c4d:	ff 75 e8             	pushl  -0x18(%ebp)
  800c50:	8d 45 14             	lea    0x14(%ebp),%eax
  800c53:	50                   	push   %eax
  800c54:	e8 84 fc ff ff       	call   8008dd <getuint>
  800c59:	83 c4 10             	add    $0x10,%esp
  800c5c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c5f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800c62:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800c69:	e9 98 00 00 00       	jmp    800d06 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800c6e:	83 ec 08             	sub    $0x8,%esp
  800c71:	ff 75 0c             	pushl  0xc(%ebp)
  800c74:	6a 58                	push   $0x58
  800c76:	8b 45 08             	mov    0x8(%ebp),%eax
  800c79:	ff d0                	call   *%eax
  800c7b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c7e:	83 ec 08             	sub    $0x8,%esp
  800c81:	ff 75 0c             	pushl  0xc(%ebp)
  800c84:	6a 58                	push   $0x58
  800c86:	8b 45 08             	mov    0x8(%ebp),%eax
  800c89:	ff d0                	call   *%eax
  800c8b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c8e:	83 ec 08             	sub    $0x8,%esp
  800c91:	ff 75 0c             	pushl  0xc(%ebp)
  800c94:	6a 58                	push   $0x58
  800c96:	8b 45 08             	mov    0x8(%ebp),%eax
  800c99:	ff d0                	call   *%eax
  800c9b:	83 c4 10             	add    $0x10,%esp
			break;
  800c9e:	e9 bc 00 00 00       	jmp    800d5f <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ca3:	83 ec 08             	sub    $0x8,%esp
  800ca6:	ff 75 0c             	pushl  0xc(%ebp)
  800ca9:	6a 30                	push   $0x30
  800cab:	8b 45 08             	mov    0x8(%ebp),%eax
  800cae:	ff d0                	call   *%eax
  800cb0:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800cb3:	83 ec 08             	sub    $0x8,%esp
  800cb6:	ff 75 0c             	pushl  0xc(%ebp)
  800cb9:	6a 78                	push   $0x78
  800cbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbe:	ff d0                	call   *%eax
  800cc0:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800cc3:	8b 45 14             	mov    0x14(%ebp),%eax
  800cc6:	83 c0 04             	add    $0x4,%eax
  800cc9:	89 45 14             	mov    %eax,0x14(%ebp)
  800ccc:	8b 45 14             	mov    0x14(%ebp),%eax
  800ccf:	83 e8 04             	sub    $0x4,%eax
  800cd2:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800cd4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cd7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800cde:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ce5:	eb 1f                	jmp    800d06 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ce7:	83 ec 08             	sub    $0x8,%esp
  800cea:	ff 75 e8             	pushl  -0x18(%ebp)
  800ced:	8d 45 14             	lea    0x14(%ebp),%eax
  800cf0:	50                   	push   %eax
  800cf1:	e8 e7 fb ff ff       	call   8008dd <getuint>
  800cf6:	83 c4 10             	add    $0x10,%esp
  800cf9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800cfc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800cff:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800d06:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800d0a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d0d:	83 ec 04             	sub    $0x4,%esp
  800d10:	52                   	push   %edx
  800d11:	ff 75 e4             	pushl  -0x1c(%ebp)
  800d14:	50                   	push   %eax
  800d15:	ff 75 f4             	pushl  -0xc(%ebp)
  800d18:	ff 75 f0             	pushl  -0x10(%ebp)
  800d1b:	ff 75 0c             	pushl  0xc(%ebp)
  800d1e:	ff 75 08             	pushl  0x8(%ebp)
  800d21:	e8 00 fb ff ff       	call   800826 <printnum>
  800d26:	83 c4 20             	add    $0x20,%esp
			break;
  800d29:	eb 34                	jmp    800d5f <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800d2b:	83 ec 08             	sub    $0x8,%esp
  800d2e:	ff 75 0c             	pushl  0xc(%ebp)
  800d31:	53                   	push   %ebx
  800d32:	8b 45 08             	mov    0x8(%ebp),%eax
  800d35:	ff d0                	call   *%eax
  800d37:	83 c4 10             	add    $0x10,%esp
			break;
  800d3a:	eb 23                	jmp    800d5f <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800d3c:	83 ec 08             	sub    $0x8,%esp
  800d3f:	ff 75 0c             	pushl  0xc(%ebp)
  800d42:	6a 25                	push   $0x25
  800d44:	8b 45 08             	mov    0x8(%ebp),%eax
  800d47:	ff d0                	call   *%eax
  800d49:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800d4c:	ff 4d 10             	decl   0x10(%ebp)
  800d4f:	eb 03                	jmp    800d54 <vprintfmt+0x3b1>
  800d51:	ff 4d 10             	decl   0x10(%ebp)
  800d54:	8b 45 10             	mov    0x10(%ebp),%eax
  800d57:	48                   	dec    %eax
  800d58:	8a 00                	mov    (%eax),%al
  800d5a:	3c 25                	cmp    $0x25,%al
  800d5c:	75 f3                	jne    800d51 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800d5e:	90                   	nop
		}
	}
  800d5f:	e9 47 fc ff ff       	jmp    8009ab <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800d64:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800d65:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800d68:	5b                   	pop    %ebx
  800d69:	5e                   	pop    %esi
  800d6a:	5d                   	pop    %ebp
  800d6b:	c3                   	ret    

00800d6c <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800d6c:	55                   	push   %ebp
  800d6d:	89 e5                	mov    %esp,%ebp
  800d6f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800d72:	8d 45 10             	lea    0x10(%ebp),%eax
  800d75:	83 c0 04             	add    $0x4,%eax
  800d78:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800d7b:	8b 45 10             	mov    0x10(%ebp),%eax
  800d7e:	ff 75 f4             	pushl  -0xc(%ebp)
  800d81:	50                   	push   %eax
  800d82:	ff 75 0c             	pushl  0xc(%ebp)
  800d85:	ff 75 08             	pushl  0x8(%ebp)
  800d88:	e8 16 fc ff ff       	call   8009a3 <vprintfmt>
  800d8d:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800d90:	90                   	nop
  800d91:	c9                   	leave  
  800d92:	c3                   	ret    

00800d93 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800d93:	55                   	push   %ebp
  800d94:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800d96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d99:	8b 40 08             	mov    0x8(%eax),%eax
  800d9c:	8d 50 01             	lea    0x1(%eax),%edx
  800d9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da2:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800da5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da8:	8b 10                	mov    (%eax),%edx
  800daa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dad:	8b 40 04             	mov    0x4(%eax),%eax
  800db0:	39 c2                	cmp    %eax,%edx
  800db2:	73 12                	jae    800dc6 <sprintputch+0x33>
		*b->buf++ = ch;
  800db4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db7:	8b 00                	mov    (%eax),%eax
  800db9:	8d 48 01             	lea    0x1(%eax),%ecx
  800dbc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dbf:	89 0a                	mov    %ecx,(%edx)
  800dc1:	8b 55 08             	mov    0x8(%ebp),%edx
  800dc4:	88 10                	mov    %dl,(%eax)
}
  800dc6:	90                   	nop
  800dc7:	5d                   	pop    %ebp
  800dc8:	c3                   	ret    

00800dc9 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800dc9:	55                   	push   %ebp
  800dca:	89 e5                	mov    %esp,%ebp
  800dcc:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800dcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800dd5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ddb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dde:	01 d0                	add    %edx,%eax
  800de0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800de3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800dea:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800dee:	74 06                	je     800df6 <vsnprintf+0x2d>
  800df0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800df4:	7f 07                	jg     800dfd <vsnprintf+0x34>
		return -E_INVAL;
  800df6:	b8 03 00 00 00       	mov    $0x3,%eax
  800dfb:	eb 20                	jmp    800e1d <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800dfd:	ff 75 14             	pushl  0x14(%ebp)
  800e00:	ff 75 10             	pushl  0x10(%ebp)
  800e03:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800e06:	50                   	push   %eax
  800e07:	68 93 0d 80 00       	push   $0x800d93
  800e0c:	e8 92 fb ff ff       	call   8009a3 <vprintfmt>
  800e11:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800e14:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800e17:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800e1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800e1d:	c9                   	leave  
  800e1e:	c3                   	ret    

00800e1f <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800e1f:	55                   	push   %ebp
  800e20:	89 e5                	mov    %esp,%ebp
  800e22:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800e25:	8d 45 10             	lea    0x10(%ebp),%eax
  800e28:	83 c0 04             	add    $0x4,%eax
  800e2b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800e2e:	8b 45 10             	mov    0x10(%ebp),%eax
  800e31:	ff 75 f4             	pushl  -0xc(%ebp)
  800e34:	50                   	push   %eax
  800e35:	ff 75 0c             	pushl  0xc(%ebp)
  800e38:	ff 75 08             	pushl  0x8(%ebp)
  800e3b:	e8 89 ff ff ff       	call   800dc9 <vsnprintf>
  800e40:	83 c4 10             	add    $0x10,%esp
  800e43:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800e46:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800e49:	c9                   	leave  
  800e4a:	c3                   	ret    

00800e4b <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800e4b:	55                   	push   %ebp
  800e4c:	89 e5                	mov    %esp,%ebp
  800e4e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800e51:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e58:	eb 06                	jmp    800e60 <strlen+0x15>
		n++;
  800e5a:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800e5d:	ff 45 08             	incl   0x8(%ebp)
  800e60:	8b 45 08             	mov    0x8(%ebp),%eax
  800e63:	8a 00                	mov    (%eax),%al
  800e65:	84 c0                	test   %al,%al
  800e67:	75 f1                	jne    800e5a <strlen+0xf>
		n++;
	return n;
  800e69:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e6c:	c9                   	leave  
  800e6d:	c3                   	ret    

00800e6e <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800e6e:	55                   	push   %ebp
  800e6f:	89 e5                	mov    %esp,%ebp
  800e71:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e74:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e7b:	eb 09                	jmp    800e86 <strnlen+0x18>
		n++;
  800e7d:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e80:	ff 45 08             	incl   0x8(%ebp)
  800e83:	ff 4d 0c             	decl   0xc(%ebp)
  800e86:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e8a:	74 09                	je     800e95 <strnlen+0x27>
  800e8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8f:	8a 00                	mov    (%eax),%al
  800e91:	84 c0                	test   %al,%al
  800e93:	75 e8                	jne    800e7d <strnlen+0xf>
		n++;
	return n;
  800e95:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e98:	c9                   	leave  
  800e99:	c3                   	ret    

00800e9a <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e9a:	55                   	push   %ebp
  800e9b:	89 e5                	mov    %esp,%ebp
  800e9d:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ea0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800ea6:	90                   	nop
  800ea7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaa:	8d 50 01             	lea    0x1(%eax),%edx
  800ead:	89 55 08             	mov    %edx,0x8(%ebp)
  800eb0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800eb3:	8d 4a 01             	lea    0x1(%edx),%ecx
  800eb6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800eb9:	8a 12                	mov    (%edx),%dl
  800ebb:	88 10                	mov    %dl,(%eax)
  800ebd:	8a 00                	mov    (%eax),%al
  800ebf:	84 c0                	test   %al,%al
  800ec1:	75 e4                	jne    800ea7 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800ec3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ec6:	c9                   	leave  
  800ec7:	c3                   	ret    

00800ec8 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800ec8:	55                   	push   %ebp
  800ec9:	89 e5                	mov    %esp,%ebp
  800ecb:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800ece:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800ed4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800edb:	eb 1f                	jmp    800efc <strncpy+0x34>
		*dst++ = *src;
  800edd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee0:	8d 50 01             	lea    0x1(%eax),%edx
  800ee3:	89 55 08             	mov    %edx,0x8(%ebp)
  800ee6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ee9:	8a 12                	mov    (%edx),%dl
  800eeb:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800eed:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ef0:	8a 00                	mov    (%eax),%al
  800ef2:	84 c0                	test   %al,%al
  800ef4:	74 03                	je     800ef9 <strncpy+0x31>
			src++;
  800ef6:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800ef9:	ff 45 fc             	incl   -0x4(%ebp)
  800efc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eff:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f02:	72 d9                	jb     800edd <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800f04:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f07:	c9                   	leave  
  800f08:	c3                   	ret    

00800f09 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800f09:	55                   	push   %ebp
  800f0a:	89 e5                	mov    %esp,%ebp
  800f0c:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800f0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f12:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800f15:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f19:	74 30                	je     800f4b <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800f1b:	eb 16                	jmp    800f33 <strlcpy+0x2a>
			*dst++ = *src++;
  800f1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f20:	8d 50 01             	lea    0x1(%eax),%edx
  800f23:	89 55 08             	mov    %edx,0x8(%ebp)
  800f26:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f29:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f2c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f2f:	8a 12                	mov    (%edx),%dl
  800f31:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800f33:	ff 4d 10             	decl   0x10(%ebp)
  800f36:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f3a:	74 09                	je     800f45 <strlcpy+0x3c>
  800f3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f3f:	8a 00                	mov    (%eax),%al
  800f41:	84 c0                	test   %al,%al
  800f43:	75 d8                	jne    800f1d <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800f45:	8b 45 08             	mov    0x8(%ebp),%eax
  800f48:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800f4b:	8b 55 08             	mov    0x8(%ebp),%edx
  800f4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f51:	29 c2                	sub    %eax,%edx
  800f53:	89 d0                	mov    %edx,%eax
}
  800f55:	c9                   	leave  
  800f56:	c3                   	ret    

00800f57 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800f57:	55                   	push   %ebp
  800f58:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800f5a:	eb 06                	jmp    800f62 <strcmp+0xb>
		p++, q++;
  800f5c:	ff 45 08             	incl   0x8(%ebp)
  800f5f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800f62:	8b 45 08             	mov    0x8(%ebp),%eax
  800f65:	8a 00                	mov    (%eax),%al
  800f67:	84 c0                	test   %al,%al
  800f69:	74 0e                	je     800f79 <strcmp+0x22>
  800f6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6e:	8a 10                	mov    (%eax),%dl
  800f70:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f73:	8a 00                	mov    (%eax),%al
  800f75:	38 c2                	cmp    %al,%dl
  800f77:	74 e3                	je     800f5c <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f79:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7c:	8a 00                	mov    (%eax),%al
  800f7e:	0f b6 d0             	movzbl %al,%edx
  800f81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f84:	8a 00                	mov    (%eax),%al
  800f86:	0f b6 c0             	movzbl %al,%eax
  800f89:	29 c2                	sub    %eax,%edx
  800f8b:	89 d0                	mov    %edx,%eax
}
  800f8d:	5d                   	pop    %ebp
  800f8e:	c3                   	ret    

00800f8f <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f8f:	55                   	push   %ebp
  800f90:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f92:	eb 09                	jmp    800f9d <strncmp+0xe>
		n--, p++, q++;
  800f94:	ff 4d 10             	decl   0x10(%ebp)
  800f97:	ff 45 08             	incl   0x8(%ebp)
  800f9a:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f9d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa1:	74 17                	je     800fba <strncmp+0x2b>
  800fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa6:	8a 00                	mov    (%eax),%al
  800fa8:	84 c0                	test   %al,%al
  800faa:	74 0e                	je     800fba <strncmp+0x2b>
  800fac:	8b 45 08             	mov    0x8(%ebp),%eax
  800faf:	8a 10                	mov    (%eax),%dl
  800fb1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb4:	8a 00                	mov    (%eax),%al
  800fb6:	38 c2                	cmp    %al,%dl
  800fb8:	74 da                	je     800f94 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800fba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fbe:	75 07                	jne    800fc7 <strncmp+0x38>
		return 0;
  800fc0:	b8 00 00 00 00       	mov    $0x0,%eax
  800fc5:	eb 14                	jmp    800fdb <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fca:	8a 00                	mov    (%eax),%al
  800fcc:	0f b6 d0             	movzbl %al,%edx
  800fcf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd2:	8a 00                	mov    (%eax),%al
  800fd4:	0f b6 c0             	movzbl %al,%eax
  800fd7:	29 c2                	sub    %eax,%edx
  800fd9:	89 d0                	mov    %edx,%eax
}
  800fdb:	5d                   	pop    %ebp
  800fdc:	c3                   	ret    

00800fdd <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800fdd:	55                   	push   %ebp
  800fde:	89 e5                	mov    %esp,%ebp
  800fe0:	83 ec 04             	sub    $0x4,%esp
  800fe3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe6:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fe9:	eb 12                	jmp    800ffd <strchr+0x20>
		if (*s == c)
  800feb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fee:	8a 00                	mov    (%eax),%al
  800ff0:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ff3:	75 05                	jne    800ffa <strchr+0x1d>
			return (char *) s;
  800ff5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff8:	eb 11                	jmp    80100b <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ffa:	ff 45 08             	incl   0x8(%ebp)
  800ffd:	8b 45 08             	mov    0x8(%ebp),%eax
  801000:	8a 00                	mov    (%eax),%al
  801002:	84 c0                	test   %al,%al
  801004:	75 e5                	jne    800feb <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801006:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80100b:	c9                   	leave  
  80100c:	c3                   	ret    

0080100d <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80100d:	55                   	push   %ebp
  80100e:	89 e5                	mov    %esp,%ebp
  801010:	83 ec 04             	sub    $0x4,%esp
  801013:	8b 45 0c             	mov    0xc(%ebp),%eax
  801016:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801019:	eb 0d                	jmp    801028 <strfind+0x1b>
		if (*s == c)
  80101b:	8b 45 08             	mov    0x8(%ebp),%eax
  80101e:	8a 00                	mov    (%eax),%al
  801020:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801023:	74 0e                	je     801033 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801025:	ff 45 08             	incl   0x8(%ebp)
  801028:	8b 45 08             	mov    0x8(%ebp),%eax
  80102b:	8a 00                	mov    (%eax),%al
  80102d:	84 c0                	test   %al,%al
  80102f:	75 ea                	jne    80101b <strfind+0xe>
  801031:	eb 01                	jmp    801034 <strfind+0x27>
		if (*s == c)
			break;
  801033:	90                   	nop
	return (char *) s;
  801034:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801037:	c9                   	leave  
  801038:	c3                   	ret    

00801039 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801039:	55                   	push   %ebp
  80103a:	89 e5                	mov    %esp,%ebp
  80103c:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80103f:	8b 45 08             	mov    0x8(%ebp),%eax
  801042:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801045:	8b 45 10             	mov    0x10(%ebp),%eax
  801048:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80104b:	eb 0e                	jmp    80105b <memset+0x22>
		*p++ = c;
  80104d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801050:	8d 50 01             	lea    0x1(%eax),%edx
  801053:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801056:	8b 55 0c             	mov    0xc(%ebp),%edx
  801059:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80105b:	ff 4d f8             	decl   -0x8(%ebp)
  80105e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801062:	79 e9                	jns    80104d <memset+0x14>
		*p++ = c;

	return v;
  801064:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801067:	c9                   	leave  
  801068:	c3                   	ret    

00801069 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801069:	55                   	push   %ebp
  80106a:	89 e5                	mov    %esp,%ebp
  80106c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80106f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801072:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801075:	8b 45 08             	mov    0x8(%ebp),%eax
  801078:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80107b:	eb 16                	jmp    801093 <memcpy+0x2a>
		*d++ = *s++;
  80107d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801080:	8d 50 01             	lea    0x1(%eax),%edx
  801083:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801086:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801089:	8d 4a 01             	lea    0x1(%edx),%ecx
  80108c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80108f:	8a 12                	mov    (%edx),%dl
  801091:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801093:	8b 45 10             	mov    0x10(%ebp),%eax
  801096:	8d 50 ff             	lea    -0x1(%eax),%edx
  801099:	89 55 10             	mov    %edx,0x10(%ebp)
  80109c:	85 c0                	test   %eax,%eax
  80109e:	75 dd                	jne    80107d <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8010a0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010a3:	c9                   	leave  
  8010a4:	c3                   	ret    

008010a5 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8010a5:	55                   	push   %ebp
  8010a6:	89 e5                	mov    %esp,%ebp
  8010a8:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8010ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ae:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8010b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8010b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010ba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010bd:	73 50                	jae    80110f <memmove+0x6a>
  8010bf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8010c5:	01 d0                	add    %edx,%eax
  8010c7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8010ca:	76 43                	jbe    80110f <memmove+0x6a>
		s += n;
  8010cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8010cf:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8010d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d5:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8010d8:	eb 10                	jmp    8010ea <memmove+0x45>
			*--d = *--s;
  8010da:	ff 4d f8             	decl   -0x8(%ebp)
  8010dd:	ff 4d fc             	decl   -0x4(%ebp)
  8010e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010e3:	8a 10                	mov    (%eax),%dl
  8010e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010e8:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8010ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ed:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010f0:	89 55 10             	mov    %edx,0x10(%ebp)
  8010f3:	85 c0                	test   %eax,%eax
  8010f5:	75 e3                	jne    8010da <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8010f7:	eb 23                	jmp    80111c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8010f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010fc:	8d 50 01             	lea    0x1(%eax),%edx
  8010ff:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801102:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801105:	8d 4a 01             	lea    0x1(%edx),%ecx
  801108:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80110b:	8a 12                	mov    (%edx),%dl
  80110d:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80110f:	8b 45 10             	mov    0x10(%ebp),%eax
  801112:	8d 50 ff             	lea    -0x1(%eax),%edx
  801115:	89 55 10             	mov    %edx,0x10(%ebp)
  801118:	85 c0                	test   %eax,%eax
  80111a:	75 dd                	jne    8010f9 <memmove+0x54>
			*d++ = *s++;

	return dst;
  80111c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80111f:	c9                   	leave  
  801120:	c3                   	ret    

00801121 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801121:	55                   	push   %ebp
  801122:	89 e5                	mov    %esp,%ebp
  801124:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801127:	8b 45 08             	mov    0x8(%ebp),%eax
  80112a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80112d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801130:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801133:	eb 2a                	jmp    80115f <memcmp+0x3e>
		if (*s1 != *s2)
  801135:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801138:	8a 10                	mov    (%eax),%dl
  80113a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80113d:	8a 00                	mov    (%eax),%al
  80113f:	38 c2                	cmp    %al,%dl
  801141:	74 16                	je     801159 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801143:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801146:	8a 00                	mov    (%eax),%al
  801148:	0f b6 d0             	movzbl %al,%edx
  80114b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80114e:	8a 00                	mov    (%eax),%al
  801150:	0f b6 c0             	movzbl %al,%eax
  801153:	29 c2                	sub    %eax,%edx
  801155:	89 d0                	mov    %edx,%eax
  801157:	eb 18                	jmp    801171 <memcmp+0x50>
		s1++, s2++;
  801159:	ff 45 fc             	incl   -0x4(%ebp)
  80115c:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80115f:	8b 45 10             	mov    0x10(%ebp),%eax
  801162:	8d 50 ff             	lea    -0x1(%eax),%edx
  801165:	89 55 10             	mov    %edx,0x10(%ebp)
  801168:	85 c0                	test   %eax,%eax
  80116a:	75 c9                	jne    801135 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80116c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801171:	c9                   	leave  
  801172:	c3                   	ret    

00801173 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801173:	55                   	push   %ebp
  801174:	89 e5                	mov    %esp,%ebp
  801176:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801179:	8b 55 08             	mov    0x8(%ebp),%edx
  80117c:	8b 45 10             	mov    0x10(%ebp),%eax
  80117f:	01 d0                	add    %edx,%eax
  801181:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801184:	eb 15                	jmp    80119b <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801186:	8b 45 08             	mov    0x8(%ebp),%eax
  801189:	8a 00                	mov    (%eax),%al
  80118b:	0f b6 d0             	movzbl %al,%edx
  80118e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801191:	0f b6 c0             	movzbl %al,%eax
  801194:	39 c2                	cmp    %eax,%edx
  801196:	74 0d                	je     8011a5 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801198:	ff 45 08             	incl   0x8(%ebp)
  80119b:	8b 45 08             	mov    0x8(%ebp),%eax
  80119e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8011a1:	72 e3                	jb     801186 <memfind+0x13>
  8011a3:	eb 01                	jmp    8011a6 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8011a5:	90                   	nop
	return (void *) s;
  8011a6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8011a9:	c9                   	leave  
  8011aa:	c3                   	ret    

008011ab <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8011ab:	55                   	push   %ebp
  8011ac:	89 e5                	mov    %esp,%ebp
  8011ae:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8011b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8011b8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011bf:	eb 03                	jmp    8011c4 <strtol+0x19>
		s++;
  8011c1:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8011c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c7:	8a 00                	mov    (%eax),%al
  8011c9:	3c 20                	cmp    $0x20,%al
  8011cb:	74 f4                	je     8011c1 <strtol+0x16>
  8011cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d0:	8a 00                	mov    (%eax),%al
  8011d2:	3c 09                	cmp    $0x9,%al
  8011d4:	74 eb                	je     8011c1 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8011d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d9:	8a 00                	mov    (%eax),%al
  8011db:	3c 2b                	cmp    $0x2b,%al
  8011dd:	75 05                	jne    8011e4 <strtol+0x39>
		s++;
  8011df:	ff 45 08             	incl   0x8(%ebp)
  8011e2:	eb 13                	jmp    8011f7 <strtol+0x4c>
	else if (*s == '-')
  8011e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e7:	8a 00                	mov    (%eax),%al
  8011e9:	3c 2d                	cmp    $0x2d,%al
  8011eb:	75 0a                	jne    8011f7 <strtol+0x4c>
		s++, neg = 1;
  8011ed:	ff 45 08             	incl   0x8(%ebp)
  8011f0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8011f7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011fb:	74 06                	je     801203 <strtol+0x58>
  8011fd:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801201:	75 20                	jne    801223 <strtol+0x78>
  801203:	8b 45 08             	mov    0x8(%ebp),%eax
  801206:	8a 00                	mov    (%eax),%al
  801208:	3c 30                	cmp    $0x30,%al
  80120a:	75 17                	jne    801223 <strtol+0x78>
  80120c:	8b 45 08             	mov    0x8(%ebp),%eax
  80120f:	40                   	inc    %eax
  801210:	8a 00                	mov    (%eax),%al
  801212:	3c 78                	cmp    $0x78,%al
  801214:	75 0d                	jne    801223 <strtol+0x78>
		s += 2, base = 16;
  801216:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80121a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801221:	eb 28                	jmp    80124b <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801223:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801227:	75 15                	jne    80123e <strtol+0x93>
  801229:	8b 45 08             	mov    0x8(%ebp),%eax
  80122c:	8a 00                	mov    (%eax),%al
  80122e:	3c 30                	cmp    $0x30,%al
  801230:	75 0c                	jne    80123e <strtol+0x93>
		s++, base = 8;
  801232:	ff 45 08             	incl   0x8(%ebp)
  801235:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80123c:	eb 0d                	jmp    80124b <strtol+0xa0>
	else if (base == 0)
  80123e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801242:	75 07                	jne    80124b <strtol+0xa0>
		base = 10;
  801244:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80124b:	8b 45 08             	mov    0x8(%ebp),%eax
  80124e:	8a 00                	mov    (%eax),%al
  801250:	3c 2f                	cmp    $0x2f,%al
  801252:	7e 19                	jle    80126d <strtol+0xc2>
  801254:	8b 45 08             	mov    0x8(%ebp),%eax
  801257:	8a 00                	mov    (%eax),%al
  801259:	3c 39                	cmp    $0x39,%al
  80125b:	7f 10                	jg     80126d <strtol+0xc2>
			dig = *s - '0';
  80125d:	8b 45 08             	mov    0x8(%ebp),%eax
  801260:	8a 00                	mov    (%eax),%al
  801262:	0f be c0             	movsbl %al,%eax
  801265:	83 e8 30             	sub    $0x30,%eax
  801268:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80126b:	eb 42                	jmp    8012af <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80126d:	8b 45 08             	mov    0x8(%ebp),%eax
  801270:	8a 00                	mov    (%eax),%al
  801272:	3c 60                	cmp    $0x60,%al
  801274:	7e 19                	jle    80128f <strtol+0xe4>
  801276:	8b 45 08             	mov    0x8(%ebp),%eax
  801279:	8a 00                	mov    (%eax),%al
  80127b:	3c 7a                	cmp    $0x7a,%al
  80127d:	7f 10                	jg     80128f <strtol+0xe4>
			dig = *s - 'a' + 10;
  80127f:	8b 45 08             	mov    0x8(%ebp),%eax
  801282:	8a 00                	mov    (%eax),%al
  801284:	0f be c0             	movsbl %al,%eax
  801287:	83 e8 57             	sub    $0x57,%eax
  80128a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80128d:	eb 20                	jmp    8012af <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80128f:	8b 45 08             	mov    0x8(%ebp),%eax
  801292:	8a 00                	mov    (%eax),%al
  801294:	3c 40                	cmp    $0x40,%al
  801296:	7e 39                	jle    8012d1 <strtol+0x126>
  801298:	8b 45 08             	mov    0x8(%ebp),%eax
  80129b:	8a 00                	mov    (%eax),%al
  80129d:	3c 5a                	cmp    $0x5a,%al
  80129f:	7f 30                	jg     8012d1 <strtol+0x126>
			dig = *s - 'A' + 10;
  8012a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a4:	8a 00                	mov    (%eax),%al
  8012a6:	0f be c0             	movsbl %al,%eax
  8012a9:	83 e8 37             	sub    $0x37,%eax
  8012ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8012af:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012b2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012b5:	7d 19                	jge    8012d0 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8012b7:	ff 45 08             	incl   0x8(%ebp)
  8012ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012bd:	0f af 45 10          	imul   0x10(%ebp),%eax
  8012c1:	89 c2                	mov    %eax,%edx
  8012c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012c6:	01 d0                	add    %edx,%eax
  8012c8:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8012cb:	e9 7b ff ff ff       	jmp    80124b <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8012d0:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8012d1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012d5:	74 08                	je     8012df <strtol+0x134>
		*endptr = (char *) s;
  8012d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012da:	8b 55 08             	mov    0x8(%ebp),%edx
  8012dd:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8012df:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012e3:	74 07                	je     8012ec <strtol+0x141>
  8012e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012e8:	f7 d8                	neg    %eax
  8012ea:	eb 03                	jmp    8012ef <strtol+0x144>
  8012ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012ef:	c9                   	leave  
  8012f0:	c3                   	ret    

008012f1 <ltostr>:

void
ltostr(long value, char *str)
{
  8012f1:	55                   	push   %ebp
  8012f2:	89 e5                	mov    %esp,%ebp
  8012f4:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8012f7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8012fe:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801305:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801309:	79 13                	jns    80131e <ltostr+0x2d>
	{
		neg = 1;
  80130b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801312:	8b 45 0c             	mov    0xc(%ebp),%eax
  801315:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801318:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80131b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80131e:	8b 45 08             	mov    0x8(%ebp),%eax
  801321:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801326:	99                   	cltd   
  801327:	f7 f9                	idiv   %ecx
  801329:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80132c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80132f:	8d 50 01             	lea    0x1(%eax),%edx
  801332:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801335:	89 c2                	mov    %eax,%edx
  801337:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133a:	01 d0                	add    %edx,%eax
  80133c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80133f:	83 c2 30             	add    $0x30,%edx
  801342:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801344:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801347:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80134c:	f7 e9                	imul   %ecx
  80134e:	c1 fa 02             	sar    $0x2,%edx
  801351:	89 c8                	mov    %ecx,%eax
  801353:	c1 f8 1f             	sar    $0x1f,%eax
  801356:	29 c2                	sub    %eax,%edx
  801358:	89 d0                	mov    %edx,%eax
  80135a:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80135d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801360:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801365:	f7 e9                	imul   %ecx
  801367:	c1 fa 02             	sar    $0x2,%edx
  80136a:	89 c8                	mov    %ecx,%eax
  80136c:	c1 f8 1f             	sar    $0x1f,%eax
  80136f:	29 c2                	sub    %eax,%edx
  801371:	89 d0                	mov    %edx,%eax
  801373:	c1 e0 02             	shl    $0x2,%eax
  801376:	01 d0                	add    %edx,%eax
  801378:	01 c0                	add    %eax,%eax
  80137a:	29 c1                	sub    %eax,%ecx
  80137c:	89 ca                	mov    %ecx,%edx
  80137e:	85 d2                	test   %edx,%edx
  801380:	75 9c                	jne    80131e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801382:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801389:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80138c:	48                   	dec    %eax
  80138d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801390:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801394:	74 3d                	je     8013d3 <ltostr+0xe2>
		start = 1 ;
  801396:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80139d:	eb 34                	jmp    8013d3 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80139f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a5:	01 d0                	add    %edx,%eax
  8013a7:	8a 00                	mov    (%eax),%al
  8013a9:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8013ac:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b2:	01 c2                	add    %eax,%edx
  8013b4:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8013b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ba:	01 c8                	add    %ecx,%eax
  8013bc:	8a 00                	mov    (%eax),%al
  8013be:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8013c0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8013c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c6:	01 c2                	add    %eax,%edx
  8013c8:	8a 45 eb             	mov    -0x15(%ebp),%al
  8013cb:	88 02                	mov    %al,(%edx)
		start++ ;
  8013cd:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8013d0:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8013d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013d6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013d9:	7c c4                	jl     80139f <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8013db:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8013de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e1:	01 d0                	add    %edx,%eax
  8013e3:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8013e6:	90                   	nop
  8013e7:	c9                   	leave  
  8013e8:	c3                   	ret    

008013e9 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8013e9:	55                   	push   %ebp
  8013ea:	89 e5                	mov    %esp,%ebp
  8013ec:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8013ef:	ff 75 08             	pushl  0x8(%ebp)
  8013f2:	e8 54 fa ff ff       	call   800e4b <strlen>
  8013f7:	83 c4 04             	add    $0x4,%esp
  8013fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8013fd:	ff 75 0c             	pushl  0xc(%ebp)
  801400:	e8 46 fa ff ff       	call   800e4b <strlen>
  801405:	83 c4 04             	add    $0x4,%esp
  801408:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80140b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801412:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801419:	eb 17                	jmp    801432 <strcconcat+0x49>
		final[s] = str1[s] ;
  80141b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80141e:	8b 45 10             	mov    0x10(%ebp),%eax
  801421:	01 c2                	add    %eax,%edx
  801423:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801426:	8b 45 08             	mov    0x8(%ebp),%eax
  801429:	01 c8                	add    %ecx,%eax
  80142b:	8a 00                	mov    (%eax),%al
  80142d:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80142f:	ff 45 fc             	incl   -0x4(%ebp)
  801432:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801435:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801438:	7c e1                	jl     80141b <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80143a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801441:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801448:	eb 1f                	jmp    801469 <strcconcat+0x80>
		final[s++] = str2[i] ;
  80144a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80144d:	8d 50 01             	lea    0x1(%eax),%edx
  801450:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801453:	89 c2                	mov    %eax,%edx
  801455:	8b 45 10             	mov    0x10(%ebp),%eax
  801458:	01 c2                	add    %eax,%edx
  80145a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80145d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801460:	01 c8                	add    %ecx,%eax
  801462:	8a 00                	mov    (%eax),%al
  801464:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801466:	ff 45 f8             	incl   -0x8(%ebp)
  801469:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80146c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80146f:	7c d9                	jl     80144a <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801471:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801474:	8b 45 10             	mov    0x10(%ebp),%eax
  801477:	01 d0                	add    %edx,%eax
  801479:	c6 00 00             	movb   $0x0,(%eax)
}
  80147c:	90                   	nop
  80147d:	c9                   	leave  
  80147e:	c3                   	ret    

0080147f <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80147f:	55                   	push   %ebp
  801480:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801482:	8b 45 14             	mov    0x14(%ebp),%eax
  801485:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80148b:	8b 45 14             	mov    0x14(%ebp),%eax
  80148e:	8b 00                	mov    (%eax),%eax
  801490:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801497:	8b 45 10             	mov    0x10(%ebp),%eax
  80149a:	01 d0                	add    %edx,%eax
  80149c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8014a2:	eb 0c                	jmp    8014b0 <strsplit+0x31>
			*string++ = 0;
  8014a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a7:	8d 50 01             	lea    0x1(%eax),%edx
  8014aa:	89 55 08             	mov    %edx,0x8(%ebp)
  8014ad:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8014b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b3:	8a 00                	mov    (%eax),%al
  8014b5:	84 c0                	test   %al,%al
  8014b7:	74 18                	je     8014d1 <strsplit+0x52>
  8014b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bc:	8a 00                	mov    (%eax),%al
  8014be:	0f be c0             	movsbl %al,%eax
  8014c1:	50                   	push   %eax
  8014c2:	ff 75 0c             	pushl  0xc(%ebp)
  8014c5:	e8 13 fb ff ff       	call   800fdd <strchr>
  8014ca:	83 c4 08             	add    $0x8,%esp
  8014cd:	85 c0                	test   %eax,%eax
  8014cf:	75 d3                	jne    8014a4 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8014d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d4:	8a 00                	mov    (%eax),%al
  8014d6:	84 c0                	test   %al,%al
  8014d8:	74 5a                	je     801534 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8014da:	8b 45 14             	mov    0x14(%ebp),%eax
  8014dd:	8b 00                	mov    (%eax),%eax
  8014df:	83 f8 0f             	cmp    $0xf,%eax
  8014e2:	75 07                	jne    8014eb <strsplit+0x6c>
		{
			return 0;
  8014e4:	b8 00 00 00 00       	mov    $0x0,%eax
  8014e9:	eb 66                	jmp    801551 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8014eb:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ee:	8b 00                	mov    (%eax),%eax
  8014f0:	8d 48 01             	lea    0x1(%eax),%ecx
  8014f3:	8b 55 14             	mov    0x14(%ebp),%edx
  8014f6:	89 0a                	mov    %ecx,(%edx)
  8014f8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014ff:	8b 45 10             	mov    0x10(%ebp),%eax
  801502:	01 c2                	add    %eax,%edx
  801504:	8b 45 08             	mov    0x8(%ebp),%eax
  801507:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801509:	eb 03                	jmp    80150e <strsplit+0x8f>
			string++;
  80150b:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80150e:	8b 45 08             	mov    0x8(%ebp),%eax
  801511:	8a 00                	mov    (%eax),%al
  801513:	84 c0                	test   %al,%al
  801515:	74 8b                	je     8014a2 <strsplit+0x23>
  801517:	8b 45 08             	mov    0x8(%ebp),%eax
  80151a:	8a 00                	mov    (%eax),%al
  80151c:	0f be c0             	movsbl %al,%eax
  80151f:	50                   	push   %eax
  801520:	ff 75 0c             	pushl  0xc(%ebp)
  801523:	e8 b5 fa ff ff       	call   800fdd <strchr>
  801528:	83 c4 08             	add    $0x8,%esp
  80152b:	85 c0                	test   %eax,%eax
  80152d:	74 dc                	je     80150b <strsplit+0x8c>
			string++;
	}
  80152f:	e9 6e ff ff ff       	jmp    8014a2 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801534:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801535:	8b 45 14             	mov    0x14(%ebp),%eax
  801538:	8b 00                	mov    (%eax),%eax
  80153a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801541:	8b 45 10             	mov    0x10(%ebp),%eax
  801544:	01 d0                	add    %edx,%eax
  801546:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80154c:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801551:	c9                   	leave  
  801552:	c3                   	ret    

00801553 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801553:	55                   	push   %ebp
  801554:	89 e5                	mov    %esp,%ebp
  801556:	57                   	push   %edi
  801557:	56                   	push   %esi
  801558:	53                   	push   %ebx
  801559:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80155c:	8b 45 08             	mov    0x8(%ebp),%eax
  80155f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801562:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801565:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801568:	8b 7d 18             	mov    0x18(%ebp),%edi
  80156b:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80156e:	cd 30                	int    $0x30
  801570:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801573:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801576:	83 c4 10             	add    $0x10,%esp
  801579:	5b                   	pop    %ebx
  80157a:	5e                   	pop    %esi
  80157b:	5f                   	pop    %edi
  80157c:	5d                   	pop    %ebp
  80157d:	c3                   	ret    

0080157e <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80157e:	55                   	push   %ebp
  80157f:	89 e5                	mov    %esp,%ebp
  801581:	83 ec 04             	sub    $0x4,%esp
  801584:	8b 45 10             	mov    0x10(%ebp),%eax
  801587:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80158a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80158e:	8b 45 08             	mov    0x8(%ebp),%eax
  801591:	6a 00                	push   $0x0
  801593:	6a 00                	push   $0x0
  801595:	52                   	push   %edx
  801596:	ff 75 0c             	pushl  0xc(%ebp)
  801599:	50                   	push   %eax
  80159a:	6a 00                	push   $0x0
  80159c:	e8 b2 ff ff ff       	call   801553 <syscall>
  8015a1:	83 c4 18             	add    $0x18,%esp
}
  8015a4:	90                   	nop
  8015a5:	c9                   	leave  
  8015a6:	c3                   	ret    

008015a7 <sys_cgetc>:

int
sys_cgetc(void)
{
  8015a7:	55                   	push   %ebp
  8015a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8015aa:	6a 00                	push   $0x0
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 01                	push   $0x1
  8015b6:	e8 98 ff ff ff       	call   801553 <syscall>
  8015bb:	83 c4 18             	add    $0x18,%esp
}
  8015be:	c9                   	leave  
  8015bf:	c3                   	ret    

008015c0 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8015c0:	55                   	push   %ebp
  8015c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8015c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c6:	6a 00                	push   $0x0
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 00                	push   $0x0
  8015cc:	6a 00                	push   $0x0
  8015ce:	50                   	push   %eax
  8015cf:	6a 05                	push   $0x5
  8015d1:	e8 7d ff ff ff       	call   801553 <syscall>
  8015d6:	83 c4 18             	add    $0x18,%esp
}
  8015d9:	c9                   	leave  
  8015da:	c3                   	ret    

008015db <sys_getenvid>:

int32 sys_getenvid(void)
{
  8015db:	55                   	push   %ebp
  8015dc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 00                	push   $0x0
  8015e4:	6a 00                	push   $0x0
  8015e6:	6a 00                	push   $0x0
  8015e8:	6a 02                	push   $0x2
  8015ea:	e8 64 ff ff ff       	call   801553 <syscall>
  8015ef:	83 c4 18             	add    $0x18,%esp
}
  8015f2:	c9                   	leave  
  8015f3:	c3                   	ret    

008015f4 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8015f4:	55                   	push   %ebp
  8015f5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8015f7:	6a 00                	push   $0x0
  8015f9:	6a 00                	push   $0x0
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 00                	push   $0x0
  801601:	6a 03                	push   $0x3
  801603:	e8 4b ff ff ff       	call   801553 <syscall>
  801608:	83 c4 18             	add    $0x18,%esp
}
  80160b:	c9                   	leave  
  80160c:	c3                   	ret    

0080160d <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80160d:	55                   	push   %ebp
  80160e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801610:	6a 00                	push   $0x0
  801612:	6a 00                	push   $0x0
  801614:	6a 00                	push   $0x0
  801616:	6a 00                	push   $0x0
  801618:	6a 00                	push   $0x0
  80161a:	6a 04                	push   $0x4
  80161c:	e8 32 ff ff ff       	call   801553 <syscall>
  801621:	83 c4 18             	add    $0x18,%esp
}
  801624:	c9                   	leave  
  801625:	c3                   	ret    

00801626 <sys_env_exit>:


void sys_env_exit(void)
{
  801626:	55                   	push   %ebp
  801627:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801629:	6a 00                	push   $0x0
  80162b:	6a 00                	push   $0x0
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	6a 00                	push   $0x0
  801633:	6a 06                	push   $0x6
  801635:	e8 19 ff ff ff       	call   801553 <syscall>
  80163a:	83 c4 18             	add    $0x18,%esp
}
  80163d:	90                   	nop
  80163e:	c9                   	leave  
  80163f:	c3                   	ret    

00801640 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801640:	55                   	push   %ebp
  801641:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801643:	8b 55 0c             	mov    0xc(%ebp),%edx
  801646:	8b 45 08             	mov    0x8(%ebp),%eax
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	6a 00                	push   $0x0
  80164f:	52                   	push   %edx
  801650:	50                   	push   %eax
  801651:	6a 07                	push   $0x7
  801653:	e8 fb fe ff ff       	call   801553 <syscall>
  801658:	83 c4 18             	add    $0x18,%esp
}
  80165b:	c9                   	leave  
  80165c:	c3                   	ret    

0080165d <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80165d:	55                   	push   %ebp
  80165e:	89 e5                	mov    %esp,%ebp
  801660:	56                   	push   %esi
  801661:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801662:	8b 75 18             	mov    0x18(%ebp),%esi
  801665:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801668:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80166b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80166e:	8b 45 08             	mov    0x8(%ebp),%eax
  801671:	56                   	push   %esi
  801672:	53                   	push   %ebx
  801673:	51                   	push   %ecx
  801674:	52                   	push   %edx
  801675:	50                   	push   %eax
  801676:	6a 08                	push   $0x8
  801678:	e8 d6 fe ff ff       	call   801553 <syscall>
  80167d:	83 c4 18             	add    $0x18,%esp
}
  801680:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801683:	5b                   	pop    %ebx
  801684:	5e                   	pop    %esi
  801685:	5d                   	pop    %ebp
  801686:	c3                   	ret    

00801687 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801687:	55                   	push   %ebp
  801688:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80168a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80168d:	8b 45 08             	mov    0x8(%ebp),%eax
  801690:	6a 00                	push   $0x0
  801692:	6a 00                	push   $0x0
  801694:	6a 00                	push   $0x0
  801696:	52                   	push   %edx
  801697:	50                   	push   %eax
  801698:	6a 09                	push   $0x9
  80169a:	e8 b4 fe ff ff       	call   801553 <syscall>
  80169f:	83 c4 18             	add    $0x18,%esp
}
  8016a2:	c9                   	leave  
  8016a3:	c3                   	ret    

008016a4 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8016a4:	55                   	push   %ebp
  8016a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8016a7:	6a 00                	push   $0x0
  8016a9:	6a 00                	push   $0x0
  8016ab:	6a 00                	push   $0x0
  8016ad:	ff 75 0c             	pushl  0xc(%ebp)
  8016b0:	ff 75 08             	pushl  0x8(%ebp)
  8016b3:	6a 0a                	push   $0xa
  8016b5:	e8 99 fe ff ff       	call   801553 <syscall>
  8016ba:	83 c4 18             	add    $0x18,%esp
}
  8016bd:	c9                   	leave  
  8016be:	c3                   	ret    

008016bf <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8016bf:	55                   	push   %ebp
  8016c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8016c2:	6a 00                	push   $0x0
  8016c4:	6a 00                	push   $0x0
  8016c6:	6a 00                	push   $0x0
  8016c8:	6a 00                	push   $0x0
  8016ca:	6a 00                	push   $0x0
  8016cc:	6a 0b                	push   $0xb
  8016ce:	e8 80 fe ff ff       	call   801553 <syscall>
  8016d3:	83 c4 18             	add    $0x18,%esp
}
  8016d6:	c9                   	leave  
  8016d7:	c3                   	ret    

008016d8 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8016d8:	55                   	push   %ebp
  8016d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8016db:	6a 00                	push   $0x0
  8016dd:	6a 00                	push   $0x0
  8016df:	6a 00                	push   $0x0
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	6a 0c                	push   $0xc
  8016e7:	e8 67 fe ff ff       	call   801553 <syscall>
  8016ec:	83 c4 18             	add    $0x18,%esp
}
  8016ef:	c9                   	leave  
  8016f0:	c3                   	ret    

008016f1 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8016f1:	55                   	push   %ebp
  8016f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8016f4:	6a 00                	push   $0x0
  8016f6:	6a 00                	push   $0x0
  8016f8:	6a 00                	push   $0x0
  8016fa:	6a 00                	push   $0x0
  8016fc:	6a 00                	push   $0x0
  8016fe:	6a 0d                	push   $0xd
  801700:	e8 4e fe ff ff       	call   801553 <syscall>
  801705:	83 c4 18             	add    $0x18,%esp
}
  801708:	c9                   	leave  
  801709:	c3                   	ret    

0080170a <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80170a:	55                   	push   %ebp
  80170b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 00                	push   $0x0
  801713:	ff 75 0c             	pushl  0xc(%ebp)
  801716:	ff 75 08             	pushl  0x8(%ebp)
  801719:	6a 11                	push   $0x11
  80171b:	e8 33 fe ff ff       	call   801553 <syscall>
  801720:	83 c4 18             	add    $0x18,%esp
	return;
  801723:	90                   	nop
}
  801724:	c9                   	leave  
  801725:	c3                   	ret    

00801726 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801726:	55                   	push   %ebp
  801727:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801729:	6a 00                	push   $0x0
  80172b:	6a 00                	push   $0x0
  80172d:	6a 00                	push   $0x0
  80172f:	ff 75 0c             	pushl  0xc(%ebp)
  801732:	ff 75 08             	pushl  0x8(%ebp)
  801735:	6a 12                	push   $0x12
  801737:	e8 17 fe ff ff       	call   801553 <syscall>
  80173c:	83 c4 18             	add    $0x18,%esp
	return ;
  80173f:	90                   	nop
}
  801740:	c9                   	leave  
  801741:	c3                   	ret    

00801742 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801742:	55                   	push   %ebp
  801743:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801745:	6a 00                	push   $0x0
  801747:	6a 00                	push   $0x0
  801749:	6a 00                	push   $0x0
  80174b:	6a 00                	push   $0x0
  80174d:	6a 00                	push   $0x0
  80174f:	6a 0e                	push   $0xe
  801751:	e8 fd fd ff ff       	call   801553 <syscall>
  801756:	83 c4 18             	add    $0x18,%esp
}
  801759:	c9                   	leave  
  80175a:	c3                   	ret    

0080175b <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80175b:	55                   	push   %ebp
  80175c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80175e:	6a 00                	push   $0x0
  801760:	6a 00                	push   $0x0
  801762:	6a 00                	push   $0x0
  801764:	6a 00                	push   $0x0
  801766:	ff 75 08             	pushl  0x8(%ebp)
  801769:	6a 0f                	push   $0xf
  80176b:	e8 e3 fd ff ff       	call   801553 <syscall>
  801770:	83 c4 18             	add    $0x18,%esp
}
  801773:	c9                   	leave  
  801774:	c3                   	ret    

00801775 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801775:	55                   	push   %ebp
  801776:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	6a 00                	push   $0x0
  801780:	6a 00                	push   $0x0
  801782:	6a 10                	push   $0x10
  801784:	e8 ca fd ff ff       	call   801553 <syscall>
  801789:	83 c4 18             	add    $0x18,%esp
}
  80178c:	90                   	nop
  80178d:	c9                   	leave  
  80178e:	c3                   	ret    

0080178f <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80178f:	55                   	push   %ebp
  801790:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801792:	6a 00                	push   $0x0
  801794:	6a 00                	push   $0x0
  801796:	6a 00                	push   $0x0
  801798:	6a 00                	push   $0x0
  80179a:	6a 00                	push   $0x0
  80179c:	6a 14                	push   $0x14
  80179e:	e8 b0 fd ff ff       	call   801553 <syscall>
  8017a3:	83 c4 18             	add    $0x18,%esp
}
  8017a6:	90                   	nop
  8017a7:	c9                   	leave  
  8017a8:	c3                   	ret    

008017a9 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8017a9:	55                   	push   %ebp
  8017aa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8017ac:	6a 00                	push   $0x0
  8017ae:	6a 00                	push   $0x0
  8017b0:	6a 00                	push   $0x0
  8017b2:	6a 00                	push   $0x0
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 15                	push   $0x15
  8017b8:	e8 96 fd ff ff       	call   801553 <syscall>
  8017bd:	83 c4 18             	add    $0x18,%esp
}
  8017c0:	90                   	nop
  8017c1:	c9                   	leave  
  8017c2:	c3                   	ret    

008017c3 <sys_cputc>:


void
sys_cputc(const char c)
{
  8017c3:	55                   	push   %ebp
  8017c4:	89 e5                	mov    %esp,%ebp
  8017c6:	83 ec 04             	sub    $0x4,%esp
  8017c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8017cf:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	6a 00                	push   $0x0
  8017d9:	6a 00                	push   $0x0
  8017db:	50                   	push   %eax
  8017dc:	6a 16                	push   $0x16
  8017de:	e8 70 fd ff ff       	call   801553 <syscall>
  8017e3:	83 c4 18             	add    $0x18,%esp
}
  8017e6:	90                   	nop
  8017e7:	c9                   	leave  
  8017e8:	c3                   	ret    

008017e9 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8017e9:	55                   	push   %ebp
  8017ea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8017ec:	6a 00                	push   $0x0
  8017ee:	6a 00                	push   $0x0
  8017f0:	6a 00                	push   $0x0
  8017f2:	6a 00                	push   $0x0
  8017f4:	6a 00                	push   $0x0
  8017f6:	6a 17                	push   $0x17
  8017f8:	e8 56 fd ff ff       	call   801553 <syscall>
  8017fd:	83 c4 18             	add    $0x18,%esp
}
  801800:	90                   	nop
  801801:	c9                   	leave  
  801802:	c3                   	ret    

00801803 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801803:	55                   	push   %ebp
  801804:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801806:	8b 45 08             	mov    0x8(%ebp),%eax
  801809:	6a 00                	push   $0x0
  80180b:	6a 00                	push   $0x0
  80180d:	6a 00                	push   $0x0
  80180f:	ff 75 0c             	pushl  0xc(%ebp)
  801812:	50                   	push   %eax
  801813:	6a 18                	push   $0x18
  801815:	e8 39 fd ff ff       	call   801553 <syscall>
  80181a:	83 c4 18             	add    $0x18,%esp
}
  80181d:	c9                   	leave  
  80181e:	c3                   	ret    

0080181f <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80181f:	55                   	push   %ebp
  801820:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801822:	8b 55 0c             	mov    0xc(%ebp),%edx
  801825:	8b 45 08             	mov    0x8(%ebp),%eax
  801828:	6a 00                	push   $0x0
  80182a:	6a 00                	push   $0x0
  80182c:	6a 00                	push   $0x0
  80182e:	52                   	push   %edx
  80182f:	50                   	push   %eax
  801830:	6a 1b                	push   $0x1b
  801832:	e8 1c fd ff ff       	call   801553 <syscall>
  801837:	83 c4 18             	add    $0x18,%esp
}
  80183a:	c9                   	leave  
  80183b:	c3                   	ret    

0080183c <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80183c:	55                   	push   %ebp
  80183d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80183f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801842:	8b 45 08             	mov    0x8(%ebp),%eax
  801845:	6a 00                	push   $0x0
  801847:	6a 00                	push   $0x0
  801849:	6a 00                	push   $0x0
  80184b:	52                   	push   %edx
  80184c:	50                   	push   %eax
  80184d:	6a 19                	push   $0x19
  80184f:	e8 ff fc ff ff       	call   801553 <syscall>
  801854:	83 c4 18             	add    $0x18,%esp
}
  801857:	90                   	nop
  801858:	c9                   	leave  
  801859:	c3                   	ret    

0080185a <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80185a:	55                   	push   %ebp
  80185b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80185d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801860:	8b 45 08             	mov    0x8(%ebp),%eax
  801863:	6a 00                	push   $0x0
  801865:	6a 00                	push   $0x0
  801867:	6a 00                	push   $0x0
  801869:	52                   	push   %edx
  80186a:	50                   	push   %eax
  80186b:	6a 1a                	push   $0x1a
  80186d:	e8 e1 fc ff ff       	call   801553 <syscall>
  801872:	83 c4 18             	add    $0x18,%esp
}
  801875:	90                   	nop
  801876:	c9                   	leave  
  801877:	c3                   	ret    

00801878 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801878:	55                   	push   %ebp
  801879:	89 e5                	mov    %esp,%ebp
  80187b:	83 ec 04             	sub    $0x4,%esp
  80187e:	8b 45 10             	mov    0x10(%ebp),%eax
  801881:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801884:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801887:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80188b:	8b 45 08             	mov    0x8(%ebp),%eax
  80188e:	6a 00                	push   $0x0
  801890:	51                   	push   %ecx
  801891:	52                   	push   %edx
  801892:	ff 75 0c             	pushl  0xc(%ebp)
  801895:	50                   	push   %eax
  801896:	6a 1c                	push   $0x1c
  801898:	e8 b6 fc ff ff       	call   801553 <syscall>
  80189d:	83 c4 18             	add    $0x18,%esp
}
  8018a0:	c9                   	leave  
  8018a1:	c3                   	ret    

008018a2 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8018a2:	55                   	push   %ebp
  8018a3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8018a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ab:	6a 00                	push   $0x0
  8018ad:	6a 00                	push   $0x0
  8018af:	6a 00                	push   $0x0
  8018b1:	52                   	push   %edx
  8018b2:	50                   	push   %eax
  8018b3:	6a 1d                	push   $0x1d
  8018b5:	e8 99 fc ff ff       	call   801553 <syscall>
  8018ba:	83 c4 18             	add    $0x18,%esp
}
  8018bd:	c9                   	leave  
  8018be:	c3                   	ret    

008018bf <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8018bf:	55                   	push   %ebp
  8018c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8018c2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018c5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cb:	6a 00                	push   $0x0
  8018cd:	6a 00                	push   $0x0
  8018cf:	51                   	push   %ecx
  8018d0:	52                   	push   %edx
  8018d1:	50                   	push   %eax
  8018d2:	6a 1e                	push   $0x1e
  8018d4:	e8 7a fc ff ff       	call   801553 <syscall>
  8018d9:	83 c4 18             	add    $0x18,%esp
}
  8018dc:	c9                   	leave  
  8018dd:	c3                   	ret    

008018de <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8018de:	55                   	push   %ebp
  8018df:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8018e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e7:	6a 00                	push   $0x0
  8018e9:	6a 00                	push   $0x0
  8018eb:	6a 00                	push   $0x0
  8018ed:	52                   	push   %edx
  8018ee:	50                   	push   %eax
  8018ef:	6a 1f                	push   $0x1f
  8018f1:	e8 5d fc ff ff       	call   801553 <syscall>
  8018f6:	83 c4 18             	add    $0x18,%esp
}
  8018f9:	c9                   	leave  
  8018fa:	c3                   	ret    

008018fb <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8018fb:	55                   	push   %ebp
  8018fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8018fe:	6a 00                	push   $0x0
  801900:	6a 00                	push   $0x0
  801902:	6a 00                	push   $0x0
  801904:	6a 00                	push   $0x0
  801906:	6a 00                	push   $0x0
  801908:	6a 20                	push   $0x20
  80190a:	e8 44 fc ff ff       	call   801553 <syscall>
  80190f:	83 c4 18             	add    $0x18,%esp
}
  801912:	c9                   	leave  
  801913:	c3                   	ret    

00801914 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801914:	55                   	push   %ebp
  801915:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801917:	8b 45 08             	mov    0x8(%ebp),%eax
  80191a:	6a 00                	push   $0x0
  80191c:	ff 75 14             	pushl  0x14(%ebp)
  80191f:	ff 75 10             	pushl  0x10(%ebp)
  801922:	ff 75 0c             	pushl  0xc(%ebp)
  801925:	50                   	push   %eax
  801926:	6a 21                	push   $0x21
  801928:	e8 26 fc ff ff       	call   801553 <syscall>
  80192d:	83 c4 18             	add    $0x18,%esp
}
  801930:	c9                   	leave  
  801931:	c3                   	ret    

00801932 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  801932:	55                   	push   %ebp
  801933:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801935:	8b 45 08             	mov    0x8(%ebp),%eax
  801938:	6a 00                	push   $0x0
  80193a:	6a 00                	push   $0x0
  80193c:	6a 00                	push   $0x0
  80193e:	6a 00                	push   $0x0
  801940:	50                   	push   %eax
  801941:	6a 22                	push   $0x22
  801943:	e8 0b fc ff ff       	call   801553 <syscall>
  801948:	83 c4 18             	add    $0x18,%esp
}
  80194b:	90                   	nop
  80194c:	c9                   	leave  
  80194d:	c3                   	ret    

0080194e <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80194e:	55                   	push   %ebp
  80194f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801951:	8b 45 08             	mov    0x8(%ebp),%eax
  801954:	6a 00                	push   $0x0
  801956:	6a 00                	push   $0x0
  801958:	6a 00                	push   $0x0
  80195a:	6a 00                	push   $0x0
  80195c:	50                   	push   %eax
  80195d:	6a 23                	push   $0x23
  80195f:	e8 ef fb ff ff       	call   801553 <syscall>
  801964:	83 c4 18             	add    $0x18,%esp
}
  801967:	90                   	nop
  801968:	c9                   	leave  
  801969:	c3                   	ret    

0080196a <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80196a:	55                   	push   %ebp
  80196b:	89 e5                	mov    %esp,%ebp
  80196d:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801970:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801973:	8d 50 04             	lea    0x4(%eax),%edx
  801976:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801979:	6a 00                	push   $0x0
  80197b:	6a 00                	push   $0x0
  80197d:	6a 00                	push   $0x0
  80197f:	52                   	push   %edx
  801980:	50                   	push   %eax
  801981:	6a 24                	push   $0x24
  801983:	e8 cb fb ff ff       	call   801553 <syscall>
  801988:	83 c4 18             	add    $0x18,%esp
	return result;
  80198b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80198e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801991:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801994:	89 01                	mov    %eax,(%ecx)
  801996:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801999:	8b 45 08             	mov    0x8(%ebp),%eax
  80199c:	c9                   	leave  
  80199d:	c2 04 00             	ret    $0x4

008019a0 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8019a0:	55                   	push   %ebp
  8019a1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8019a3:	6a 00                	push   $0x0
  8019a5:	6a 00                	push   $0x0
  8019a7:	ff 75 10             	pushl  0x10(%ebp)
  8019aa:	ff 75 0c             	pushl  0xc(%ebp)
  8019ad:	ff 75 08             	pushl  0x8(%ebp)
  8019b0:	6a 13                	push   $0x13
  8019b2:	e8 9c fb ff ff       	call   801553 <syscall>
  8019b7:	83 c4 18             	add    $0x18,%esp
	return ;
  8019ba:	90                   	nop
}
  8019bb:	c9                   	leave  
  8019bc:	c3                   	ret    

008019bd <sys_rcr2>:
uint32 sys_rcr2()
{
  8019bd:	55                   	push   %ebp
  8019be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 00                	push   $0x0
  8019c4:	6a 00                	push   $0x0
  8019c6:	6a 00                	push   $0x0
  8019c8:	6a 00                	push   $0x0
  8019ca:	6a 25                	push   $0x25
  8019cc:	e8 82 fb ff ff       	call   801553 <syscall>
  8019d1:	83 c4 18             	add    $0x18,%esp
}
  8019d4:	c9                   	leave  
  8019d5:	c3                   	ret    

008019d6 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8019d6:	55                   	push   %ebp
  8019d7:	89 e5                	mov    %esp,%ebp
  8019d9:	83 ec 04             	sub    $0x4,%esp
  8019dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019df:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8019e2:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8019e6:	6a 00                	push   $0x0
  8019e8:	6a 00                	push   $0x0
  8019ea:	6a 00                	push   $0x0
  8019ec:	6a 00                	push   $0x0
  8019ee:	50                   	push   %eax
  8019ef:	6a 26                	push   $0x26
  8019f1:	e8 5d fb ff ff       	call   801553 <syscall>
  8019f6:	83 c4 18             	add    $0x18,%esp
	return ;
  8019f9:	90                   	nop
}
  8019fa:	c9                   	leave  
  8019fb:	c3                   	ret    

008019fc <rsttst>:
void rsttst()
{
  8019fc:	55                   	push   %ebp
  8019fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8019ff:	6a 00                	push   $0x0
  801a01:	6a 00                	push   $0x0
  801a03:	6a 00                	push   $0x0
  801a05:	6a 00                	push   $0x0
  801a07:	6a 00                	push   $0x0
  801a09:	6a 28                	push   $0x28
  801a0b:	e8 43 fb ff ff       	call   801553 <syscall>
  801a10:	83 c4 18             	add    $0x18,%esp
	return ;
  801a13:	90                   	nop
}
  801a14:	c9                   	leave  
  801a15:	c3                   	ret    

00801a16 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801a16:	55                   	push   %ebp
  801a17:	89 e5                	mov    %esp,%ebp
  801a19:	83 ec 04             	sub    $0x4,%esp
  801a1c:	8b 45 14             	mov    0x14(%ebp),%eax
  801a1f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801a22:	8b 55 18             	mov    0x18(%ebp),%edx
  801a25:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801a29:	52                   	push   %edx
  801a2a:	50                   	push   %eax
  801a2b:	ff 75 10             	pushl  0x10(%ebp)
  801a2e:	ff 75 0c             	pushl  0xc(%ebp)
  801a31:	ff 75 08             	pushl  0x8(%ebp)
  801a34:	6a 27                	push   $0x27
  801a36:	e8 18 fb ff ff       	call   801553 <syscall>
  801a3b:	83 c4 18             	add    $0x18,%esp
	return ;
  801a3e:	90                   	nop
}
  801a3f:	c9                   	leave  
  801a40:	c3                   	ret    

00801a41 <chktst>:
void chktst(uint32 n)
{
  801a41:	55                   	push   %ebp
  801a42:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801a44:	6a 00                	push   $0x0
  801a46:	6a 00                	push   $0x0
  801a48:	6a 00                	push   $0x0
  801a4a:	6a 00                	push   $0x0
  801a4c:	ff 75 08             	pushl  0x8(%ebp)
  801a4f:	6a 29                	push   $0x29
  801a51:	e8 fd fa ff ff       	call   801553 <syscall>
  801a56:	83 c4 18             	add    $0x18,%esp
	return ;
  801a59:	90                   	nop
}
  801a5a:	c9                   	leave  
  801a5b:	c3                   	ret    

00801a5c <inctst>:

void inctst()
{
  801a5c:	55                   	push   %ebp
  801a5d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801a5f:	6a 00                	push   $0x0
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	6a 00                	push   $0x0
  801a69:	6a 2a                	push   $0x2a
  801a6b:	e8 e3 fa ff ff       	call   801553 <syscall>
  801a70:	83 c4 18             	add    $0x18,%esp
	return ;
  801a73:	90                   	nop
}
  801a74:	c9                   	leave  
  801a75:	c3                   	ret    

00801a76 <gettst>:
uint32 gettst()
{
  801a76:	55                   	push   %ebp
  801a77:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801a79:	6a 00                	push   $0x0
  801a7b:	6a 00                	push   $0x0
  801a7d:	6a 00                	push   $0x0
  801a7f:	6a 00                	push   $0x0
  801a81:	6a 00                	push   $0x0
  801a83:	6a 2b                	push   $0x2b
  801a85:	e8 c9 fa ff ff       	call   801553 <syscall>
  801a8a:	83 c4 18             	add    $0x18,%esp
}
  801a8d:	c9                   	leave  
  801a8e:	c3                   	ret    

00801a8f <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801a8f:	55                   	push   %ebp
  801a90:	89 e5                	mov    %esp,%ebp
  801a92:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a95:	6a 00                	push   $0x0
  801a97:	6a 00                	push   $0x0
  801a99:	6a 00                	push   $0x0
  801a9b:	6a 00                	push   $0x0
  801a9d:	6a 00                	push   $0x0
  801a9f:	6a 2c                	push   $0x2c
  801aa1:	e8 ad fa ff ff       	call   801553 <syscall>
  801aa6:	83 c4 18             	add    $0x18,%esp
  801aa9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801aac:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801ab0:	75 07                	jne    801ab9 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801ab2:	b8 01 00 00 00       	mov    $0x1,%eax
  801ab7:	eb 05                	jmp    801abe <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801ab9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801abe:	c9                   	leave  
  801abf:	c3                   	ret    

00801ac0 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801ac0:	55                   	push   %ebp
  801ac1:	89 e5                	mov    %esp,%ebp
  801ac3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ac6:	6a 00                	push   $0x0
  801ac8:	6a 00                	push   $0x0
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 2c                	push   $0x2c
  801ad2:	e8 7c fa ff ff       	call   801553 <syscall>
  801ad7:	83 c4 18             	add    $0x18,%esp
  801ada:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801add:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801ae1:	75 07                	jne    801aea <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801ae3:	b8 01 00 00 00       	mov    $0x1,%eax
  801ae8:	eb 05                	jmp    801aef <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801aea:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801aef:	c9                   	leave  
  801af0:	c3                   	ret    

00801af1 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801af1:	55                   	push   %ebp
  801af2:	89 e5                	mov    %esp,%ebp
  801af4:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801af7:	6a 00                	push   $0x0
  801af9:	6a 00                	push   $0x0
  801afb:	6a 00                	push   $0x0
  801afd:	6a 00                	push   $0x0
  801aff:	6a 00                	push   $0x0
  801b01:	6a 2c                	push   $0x2c
  801b03:	e8 4b fa ff ff       	call   801553 <syscall>
  801b08:	83 c4 18             	add    $0x18,%esp
  801b0b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801b0e:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801b12:	75 07                	jne    801b1b <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801b14:	b8 01 00 00 00       	mov    $0x1,%eax
  801b19:	eb 05                	jmp    801b20 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801b1b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b20:	c9                   	leave  
  801b21:	c3                   	ret    

00801b22 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801b22:	55                   	push   %ebp
  801b23:	89 e5                	mov    %esp,%ebp
  801b25:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b28:	6a 00                	push   $0x0
  801b2a:	6a 00                	push   $0x0
  801b2c:	6a 00                	push   $0x0
  801b2e:	6a 00                	push   $0x0
  801b30:	6a 00                	push   $0x0
  801b32:	6a 2c                	push   $0x2c
  801b34:	e8 1a fa ff ff       	call   801553 <syscall>
  801b39:	83 c4 18             	add    $0x18,%esp
  801b3c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801b3f:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801b43:	75 07                	jne    801b4c <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801b45:	b8 01 00 00 00       	mov    $0x1,%eax
  801b4a:	eb 05                	jmp    801b51 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801b4c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b51:	c9                   	leave  
  801b52:	c3                   	ret    

00801b53 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801b53:	55                   	push   %ebp
  801b54:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801b56:	6a 00                	push   $0x0
  801b58:	6a 00                	push   $0x0
  801b5a:	6a 00                	push   $0x0
  801b5c:	6a 00                	push   $0x0
  801b5e:	ff 75 08             	pushl  0x8(%ebp)
  801b61:	6a 2d                	push   $0x2d
  801b63:	e8 eb f9 ff ff       	call   801553 <syscall>
  801b68:	83 c4 18             	add    $0x18,%esp
	return ;
  801b6b:	90                   	nop
}
  801b6c:	c9                   	leave  
  801b6d:	c3                   	ret    

00801b6e <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b6e:	55                   	push   %ebp
  801b6f:	89 e5                	mov    %esp,%ebp
  801b71:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b72:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b75:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b78:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b7b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7e:	6a 00                	push   $0x0
  801b80:	53                   	push   %ebx
  801b81:	51                   	push   %ecx
  801b82:	52                   	push   %edx
  801b83:	50                   	push   %eax
  801b84:	6a 2e                	push   $0x2e
  801b86:	e8 c8 f9 ff ff       	call   801553 <syscall>
  801b8b:	83 c4 18             	add    $0x18,%esp
}
  801b8e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b91:	c9                   	leave  
  801b92:	c3                   	ret    

00801b93 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b93:	55                   	push   %ebp
  801b94:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b96:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b99:	8b 45 08             	mov    0x8(%ebp),%eax
  801b9c:	6a 00                	push   $0x0
  801b9e:	6a 00                	push   $0x0
  801ba0:	6a 00                	push   $0x0
  801ba2:	52                   	push   %edx
  801ba3:	50                   	push   %eax
  801ba4:	6a 2f                	push   $0x2f
  801ba6:	e8 a8 f9 ff ff       	call   801553 <syscall>
  801bab:	83 c4 18             	add    $0x18,%esp
}
  801bae:	c9                   	leave  
  801baf:	c3                   	ret    

00801bb0 <__udivdi3>:
  801bb0:	55                   	push   %ebp
  801bb1:	57                   	push   %edi
  801bb2:	56                   	push   %esi
  801bb3:	53                   	push   %ebx
  801bb4:	83 ec 1c             	sub    $0x1c,%esp
  801bb7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801bbb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801bbf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801bc3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801bc7:	89 ca                	mov    %ecx,%edx
  801bc9:	89 f8                	mov    %edi,%eax
  801bcb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801bcf:	85 f6                	test   %esi,%esi
  801bd1:	75 2d                	jne    801c00 <__udivdi3+0x50>
  801bd3:	39 cf                	cmp    %ecx,%edi
  801bd5:	77 65                	ja     801c3c <__udivdi3+0x8c>
  801bd7:	89 fd                	mov    %edi,%ebp
  801bd9:	85 ff                	test   %edi,%edi
  801bdb:	75 0b                	jne    801be8 <__udivdi3+0x38>
  801bdd:	b8 01 00 00 00       	mov    $0x1,%eax
  801be2:	31 d2                	xor    %edx,%edx
  801be4:	f7 f7                	div    %edi
  801be6:	89 c5                	mov    %eax,%ebp
  801be8:	31 d2                	xor    %edx,%edx
  801bea:	89 c8                	mov    %ecx,%eax
  801bec:	f7 f5                	div    %ebp
  801bee:	89 c1                	mov    %eax,%ecx
  801bf0:	89 d8                	mov    %ebx,%eax
  801bf2:	f7 f5                	div    %ebp
  801bf4:	89 cf                	mov    %ecx,%edi
  801bf6:	89 fa                	mov    %edi,%edx
  801bf8:	83 c4 1c             	add    $0x1c,%esp
  801bfb:	5b                   	pop    %ebx
  801bfc:	5e                   	pop    %esi
  801bfd:	5f                   	pop    %edi
  801bfe:	5d                   	pop    %ebp
  801bff:	c3                   	ret    
  801c00:	39 ce                	cmp    %ecx,%esi
  801c02:	77 28                	ja     801c2c <__udivdi3+0x7c>
  801c04:	0f bd fe             	bsr    %esi,%edi
  801c07:	83 f7 1f             	xor    $0x1f,%edi
  801c0a:	75 40                	jne    801c4c <__udivdi3+0x9c>
  801c0c:	39 ce                	cmp    %ecx,%esi
  801c0e:	72 0a                	jb     801c1a <__udivdi3+0x6a>
  801c10:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801c14:	0f 87 9e 00 00 00    	ja     801cb8 <__udivdi3+0x108>
  801c1a:	b8 01 00 00 00       	mov    $0x1,%eax
  801c1f:	89 fa                	mov    %edi,%edx
  801c21:	83 c4 1c             	add    $0x1c,%esp
  801c24:	5b                   	pop    %ebx
  801c25:	5e                   	pop    %esi
  801c26:	5f                   	pop    %edi
  801c27:	5d                   	pop    %ebp
  801c28:	c3                   	ret    
  801c29:	8d 76 00             	lea    0x0(%esi),%esi
  801c2c:	31 ff                	xor    %edi,%edi
  801c2e:	31 c0                	xor    %eax,%eax
  801c30:	89 fa                	mov    %edi,%edx
  801c32:	83 c4 1c             	add    $0x1c,%esp
  801c35:	5b                   	pop    %ebx
  801c36:	5e                   	pop    %esi
  801c37:	5f                   	pop    %edi
  801c38:	5d                   	pop    %ebp
  801c39:	c3                   	ret    
  801c3a:	66 90                	xchg   %ax,%ax
  801c3c:	89 d8                	mov    %ebx,%eax
  801c3e:	f7 f7                	div    %edi
  801c40:	31 ff                	xor    %edi,%edi
  801c42:	89 fa                	mov    %edi,%edx
  801c44:	83 c4 1c             	add    $0x1c,%esp
  801c47:	5b                   	pop    %ebx
  801c48:	5e                   	pop    %esi
  801c49:	5f                   	pop    %edi
  801c4a:	5d                   	pop    %ebp
  801c4b:	c3                   	ret    
  801c4c:	bd 20 00 00 00       	mov    $0x20,%ebp
  801c51:	89 eb                	mov    %ebp,%ebx
  801c53:	29 fb                	sub    %edi,%ebx
  801c55:	89 f9                	mov    %edi,%ecx
  801c57:	d3 e6                	shl    %cl,%esi
  801c59:	89 c5                	mov    %eax,%ebp
  801c5b:	88 d9                	mov    %bl,%cl
  801c5d:	d3 ed                	shr    %cl,%ebp
  801c5f:	89 e9                	mov    %ebp,%ecx
  801c61:	09 f1                	or     %esi,%ecx
  801c63:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801c67:	89 f9                	mov    %edi,%ecx
  801c69:	d3 e0                	shl    %cl,%eax
  801c6b:	89 c5                	mov    %eax,%ebp
  801c6d:	89 d6                	mov    %edx,%esi
  801c6f:	88 d9                	mov    %bl,%cl
  801c71:	d3 ee                	shr    %cl,%esi
  801c73:	89 f9                	mov    %edi,%ecx
  801c75:	d3 e2                	shl    %cl,%edx
  801c77:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c7b:	88 d9                	mov    %bl,%cl
  801c7d:	d3 e8                	shr    %cl,%eax
  801c7f:	09 c2                	or     %eax,%edx
  801c81:	89 d0                	mov    %edx,%eax
  801c83:	89 f2                	mov    %esi,%edx
  801c85:	f7 74 24 0c          	divl   0xc(%esp)
  801c89:	89 d6                	mov    %edx,%esi
  801c8b:	89 c3                	mov    %eax,%ebx
  801c8d:	f7 e5                	mul    %ebp
  801c8f:	39 d6                	cmp    %edx,%esi
  801c91:	72 19                	jb     801cac <__udivdi3+0xfc>
  801c93:	74 0b                	je     801ca0 <__udivdi3+0xf0>
  801c95:	89 d8                	mov    %ebx,%eax
  801c97:	31 ff                	xor    %edi,%edi
  801c99:	e9 58 ff ff ff       	jmp    801bf6 <__udivdi3+0x46>
  801c9e:	66 90                	xchg   %ax,%ax
  801ca0:	8b 54 24 08          	mov    0x8(%esp),%edx
  801ca4:	89 f9                	mov    %edi,%ecx
  801ca6:	d3 e2                	shl    %cl,%edx
  801ca8:	39 c2                	cmp    %eax,%edx
  801caa:	73 e9                	jae    801c95 <__udivdi3+0xe5>
  801cac:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801caf:	31 ff                	xor    %edi,%edi
  801cb1:	e9 40 ff ff ff       	jmp    801bf6 <__udivdi3+0x46>
  801cb6:	66 90                	xchg   %ax,%ax
  801cb8:	31 c0                	xor    %eax,%eax
  801cba:	e9 37 ff ff ff       	jmp    801bf6 <__udivdi3+0x46>
  801cbf:	90                   	nop

00801cc0 <__umoddi3>:
  801cc0:	55                   	push   %ebp
  801cc1:	57                   	push   %edi
  801cc2:	56                   	push   %esi
  801cc3:	53                   	push   %ebx
  801cc4:	83 ec 1c             	sub    $0x1c,%esp
  801cc7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ccb:	8b 74 24 34          	mov    0x34(%esp),%esi
  801ccf:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801cd3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801cd7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801cdb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801cdf:	89 f3                	mov    %esi,%ebx
  801ce1:	89 fa                	mov    %edi,%edx
  801ce3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ce7:	89 34 24             	mov    %esi,(%esp)
  801cea:	85 c0                	test   %eax,%eax
  801cec:	75 1a                	jne    801d08 <__umoddi3+0x48>
  801cee:	39 f7                	cmp    %esi,%edi
  801cf0:	0f 86 a2 00 00 00    	jbe    801d98 <__umoddi3+0xd8>
  801cf6:	89 c8                	mov    %ecx,%eax
  801cf8:	89 f2                	mov    %esi,%edx
  801cfa:	f7 f7                	div    %edi
  801cfc:	89 d0                	mov    %edx,%eax
  801cfe:	31 d2                	xor    %edx,%edx
  801d00:	83 c4 1c             	add    $0x1c,%esp
  801d03:	5b                   	pop    %ebx
  801d04:	5e                   	pop    %esi
  801d05:	5f                   	pop    %edi
  801d06:	5d                   	pop    %ebp
  801d07:	c3                   	ret    
  801d08:	39 f0                	cmp    %esi,%eax
  801d0a:	0f 87 ac 00 00 00    	ja     801dbc <__umoddi3+0xfc>
  801d10:	0f bd e8             	bsr    %eax,%ebp
  801d13:	83 f5 1f             	xor    $0x1f,%ebp
  801d16:	0f 84 ac 00 00 00    	je     801dc8 <__umoddi3+0x108>
  801d1c:	bf 20 00 00 00       	mov    $0x20,%edi
  801d21:	29 ef                	sub    %ebp,%edi
  801d23:	89 fe                	mov    %edi,%esi
  801d25:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801d29:	89 e9                	mov    %ebp,%ecx
  801d2b:	d3 e0                	shl    %cl,%eax
  801d2d:	89 d7                	mov    %edx,%edi
  801d2f:	89 f1                	mov    %esi,%ecx
  801d31:	d3 ef                	shr    %cl,%edi
  801d33:	09 c7                	or     %eax,%edi
  801d35:	89 e9                	mov    %ebp,%ecx
  801d37:	d3 e2                	shl    %cl,%edx
  801d39:	89 14 24             	mov    %edx,(%esp)
  801d3c:	89 d8                	mov    %ebx,%eax
  801d3e:	d3 e0                	shl    %cl,%eax
  801d40:	89 c2                	mov    %eax,%edx
  801d42:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d46:	d3 e0                	shl    %cl,%eax
  801d48:	89 44 24 04          	mov    %eax,0x4(%esp)
  801d4c:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d50:	89 f1                	mov    %esi,%ecx
  801d52:	d3 e8                	shr    %cl,%eax
  801d54:	09 d0                	or     %edx,%eax
  801d56:	d3 eb                	shr    %cl,%ebx
  801d58:	89 da                	mov    %ebx,%edx
  801d5a:	f7 f7                	div    %edi
  801d5c:	89 d3                	mov    %edx,%ebx
  801d5e:	f7 24 24             	mull   (%esp)
  801d61:	89 c6                	mov    %eax,%esi
  801d63:	89 d1                	mov    %edx,%ecx
  801d65:	39 d3                	cmp    %edx,%ebx
  801d67:	0f 82 87 00 00 00    	jb     801df4 <__umoddi3+0x134>
  801d6d:	0f 84 91 00 00 00    	je     801e04 <__umoddi3+0x144>
  801d73:	8b 54 24 04          	mov    0x4(%esp),%edx
  801d77:	29 f2                	sub    %esi,%edx
  801d79:	19 cb                	sbb    %ecx,%ebx
  801d7b:	89 d8                	mov    %ebx,%eax
  801d7d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801d81:	d3 e0                	shl    %cl,%eax
  801d83:	89 e9                	mov    %ebp,%ecx
  801d85:	d3 ea                	shr    %cl,%edx
  801d87:	09 d0                	or     %edx,%eax
  801d89:	89 e9                	mov    %ebp,%ecx
  801d8b:	d3 eb                	shr    %cl,%ebx
  801d8d:	89 da                	mov    %ebx,%edx
  801d8f:	83 c4 1c             	add    $0x1c,%esp
  801d92:	5b                   	pop    %ebx
  801d93:	5e                   	pop    %esi
  801d94:	5f                   	pop    %edi
  801d95:	5d                   	pop    %ebp
  801d96:	c3                   	ret    
  801d97:	90                   	nop
  801d98:	89 fd                	mov    %edi,%ebp
  801d9a:	85 ff                	test   %edi,%edi
  801d9c:	75 0b                	jne    801da9 <__umoddi3+0xe9>
  801d9e:	b8 01 00 00 00       	mov    $0x1,%eax
  801da3:	31 d2                	xor    %edx,%edx
  801da5:	f7 f7                	div    %edi
  801da7:	89 c5                	mov    %eax,%ebp
  801da9:	89 f0                	mov    %esi,%eax
  801dab:	31 d2                	xor    %edx,%edx
  801dad:	f7 f5                	div    %ebp
  801daf:	89 c8                	mov    %ecx,%eax
  801db1:	f7 f5                	div    %ebp
  801db3:	89 d0                	mov    %edx,%eax
  801db5:	e9 44 ff ff ff       	jmp    801cfe <__umoddi3+0x3e>
  801dba:	66 90                	xchg   %ax,%ax
  801dbc:	89 c8                	mov    %ecx,%eax
  801dbe:	89 f2                	mov    %esi,%edx
  801dc0:	83 c4 1c             	add    $0x1c,%esp
  801dc3:	5b                   	pop    %ebx
  801dc4:	5e                   	pop    %esi
  801dc5:	5f                   	pop    %edi
  801dc6:	5d                   	pop    %ebp
  801dc7:	c3                   	ret    
  801dc8:	3b 04 24             	cmp    (%esp),%eax
  801dcb:	72 06                	jb     801dd3 <__umoddi3+0x113>
  801dcd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801dd1:	77 0f                	ja     801de2 <__umoddi3+0x122>
  801dd3:	89 f2                	mov    %esi,%edx
  801dd5:	29 f9                	sub    %edi,%ecx
  801dd7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801ddb:	89 14 24             	mov    %edx,(%esp)
  801dde:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801de2:	8b 44 24 04          	mov    0x4(%esp),%eax
  801de6:	8b 14 24             	mov    (%esp),%edx
  801de9:	83 c4 1c             	add    $0x1c,%esp
  801dec:	5b                   	pop    %ebx
  801ded:	5e                   	pop    %esi
  801dee:	5f                   	pop    %edi
  801def:	5d                   	pop    %ebp
  801df0:	c3                   	ret    
  801df1:	8d 76 00             	lea    0x0(%esi),%esi
  801df4:	2b 04 24             	sub    (%esp),%eax
  801df7:	19 fa                	sbb    %edi,%edx
  801df9:	89 d1                	mov    %edx,%ecx
  801dfb:	89 c6                	mov    %eax,%esi
  801dfd:	e9 71 ff ff ff       	jmp    801d73 <__umoddi3+0xb3>
  801e02:	66 90                	xchg   %ax,%ax
  801e04:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801e08:	72 ea                	jb     801df4 <__umoddi3+0x134>
  801e0a:	89 d9                	mov    %ebx,%ecx
  801e0c:	e9 62 ff ff ff       	jmp    801d73 <__umoddi3+0xb3>
