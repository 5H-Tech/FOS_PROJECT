
obj/user/quicksort1:     file format elf32-i386


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
  800031:	e8 eb 05 00 00       	call   800621 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void QuickSort(int *Elements, int NumOfElements);
void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex);
uint32 CheckSorted(int *Elements, int NumOfElements);

void _main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 24 01 00 00    	sub    $0x124,%esp
	//int InitFreeFrames = sys_calculate_free_frames() ;
	char Line[255] ;
	char Chose ;
	int Iteration = 0 ;
  800042:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800049:	e8 57 1d 00 00       	call   801da5 <sys_calculate_free_frames>
  80004e:	89 c3                	mov    %eax,%ebx
  800050:	e8 69 1d 00 00       	call   801dbe <sys_calculate_modified_frames>
  800055:	01 d8                	add    %ebx,%eax
  800057:	89 45 f0             	mov    %eax,-0x10(%ebp)

		Iteration++ ;
  80005a:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

	sys_disable_interrupt();
  80005d:	e8 13 1e 00 00       	call   801e75 <sys_disable_interrupt>
		readline("Enter the number of elements: ", Line);
  800062:	83 ec 08             	sub    $0x8,%esp
  800065:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  80006b:	50                   	push   %eax
  80006c:	68 00 25 80 00       	push   $0x802500
  800071:	e8 14 10 00 00       	call   80108a <readline>
  800076:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  800079:	83 ec 04             	sub    $0x4,%esp
  80007c:	6a 0a                	push   $0xa
  80007e:	6a 00                	push   $0x0
  800080:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800086:	50                   	push   %eax
  800087:	e8 64 15 00 00       	call   8015f0 <strtol>
  80008c:	83 c4 10             	add    $0x10,%esp
  80008f:	89 45 ec             	mov    %eax,-0x14(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  800092:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800095:	c1 e0 02             	shl    $0x2,%eax
  800098:	83 ec 0c             	sub    $0xc,%esp
  80009b:	50                   	push   %eax
  80009c:	e8 f7 18 00 00       	call   801998 <malloc>
  8000a1:	83 c4 10             	add    $0x10,%esp
  8000a4:	89 45 e8             	mov    %eax,-0x18(%ebp)
		Elements[NumOfElements] = 10 ;
  8000a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000aa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8000b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000b4:	01 d0                	add    %edx,%eax
  8000b6:	c7 00 0a 00 00 00    	movl   $0xa,(%eax)
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
  8000bc:	83 ec 0c             	sub    $0xc,%esp
  8000bf:	68 20 25 80 00       	push   $0x802520
  8000c4:	e8 3f 09 00 00       	call   800a08 <cprintf>
  8000c9:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	68 43 25 80 00       	push   $0x802543
  8000d4:	e8 2f 09 00 00       	call   800a08 <cprintf>
  8000d9:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000dc:	83 ec 0c             	sub    $0xc,%esp
  8000df:	68 51 25 80 00       	push   $0x802551
  8000e4:	e8 1f 09 00 00       	call   800a08 <cprintf>
  8000e9:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  8000ec:	83 ec 0c             	sub    $0xc,%esp
  8000ef:	68 60 25 80 00       	push   $0x802560
  8000f4:	e8 0f 09 00 00       	call   800a08 <cprintf>
  8000f9:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  8000fc:	83 ec 0c             	sub    $0xc,%esp
  8000ff:	68 70 25 80 00       	push   $0x802570
  800104:	e8 ff 08 00 00       	call   800a08 <cprintf>
  800109:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80010c:	e8 b8 04 00 00       	call   8005c9 <getchar>
  800111:	88 45 e7             	mov    %al,-0x19(%ebp)
			cputchar(Chose);
  800114:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  800118:	83 ec 0c             	sub    $0xc,%esp
  80011b:	50                   	push   %eax
  80011c:	e8 60 04 00 00       	call   800581 <cputchar>
  800121:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800124:	83 ec 0c             	sub    $0xc,%esp
  800127:	6a 0a                	push   $0xa
  800129:	e8 53 04 00 00       	call   800581 <cputchar>
  80012e:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800131:	80 7d e7 61          	cmpb   $0x61,-0x19(%ebp)
  800135:	74 0c                	je     800143 <_main+0x10b>
  800137:	80 7d e7 62          	cmpb   $0x62,-0x19(%ebp)
  80013b:	74 06                	je     800143 <_main+0x10b>
  80013d:	80 7d e7 63          	cmpb   $0x63,-0x19(%ebp)
  800141:	75 b9                	jne    8000fc <_main+0xc4>

	sys_enable_interrupt();
  800143:	e8 47 1d 00 00       	call   801e8f <sys_enable_interrupt>
		int  i ;
		switch (Chose)
  800148:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  80014c:	83 f8 62             	cmp    $0x62,%eax
  80014f:	74 1d                	je     80016e <_main+0x136>
  800151:	83 f8 63             	cmp    $0x63,%eax
  800154:	74 2b                	je     800181 <_main+0x149>
  800156:	83 f8 61             	cmp    $0x61,%eax
  800159:	75 39                	jne    800194 <_main+0x15c>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80015b:	83 ec 08             	sub    $0x8,%esp
  80015e:	ff 75 ec             	pushl  -0x14(%ebp)
  800161:	ff 75 e8             	pushl  -0x18(%ebp)
  800164:	e8 e0 02 00 00       	call   800449 <InitializeAscending>
  800169:	83 c4 10             	add    $0x10,%esp
			break ;
  80016c:	eb 37                	jmp    8001a5 <_main+0x16d>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80016e:	83 ec 08             	sub    $0x8,%esp
  800171:	ff 75 ec             	pushl  -0x14(%ebp)
  800174:	ff 75 e8             	pushl  -0x18(%ebp)
  800177:	e8 fe 02 00 00       	call   80047a <InitializeDescending>
  80017c:	83 c4 10             	add    $0x10,%esp
			break ;
  80017f:	eb 24                	jmp    8001a5 <_main+0x16d>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800181:	83 ec 08             	sub    $0x8,%esp
  800184:	ff 75 ec             	pushl  -0x14(%ebp)
  800187:	ff 75 e8             	pushl  -0x18(%ebp)
  80018a:	e8 20 03 00 00       	call   8004af <InitializeSemiRandom>
  80018f:	83 c4 10             	add    $0x10,%esp
			break ;
  800192:	eb 11                	jmp    8001a5 <_main+0x16d>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  800194:	83 ec 08             	sub    $0x8,%esp
  800197:	ff 75 ec             	pushl  -0x14(%ebp)
  80019a:	ff 75 e8             	pushl  -0x18(%ebp)
  80019d:	e8 0d 03 00 00       	call   8004af <InitializeSemiRandom>
  8001a2:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001a5:	83 ec 08             	sub    $0x8,%esp
  8001a8:	ff 75 ec             	pushl  -0x14(%ebp)
  8001ab:	ff 75 e8             	pushl  -0x18(%ebp)
  8001ae:	e8 db 00 00 00       	call   80028e <QuickSort>
  8001b3:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001b6:	83 ec 08             	sub    $0x8,%esp
  8001b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8001bc:	ff 75 e8             	pushl  -0x18(%ebp)
  8001bf:	e8 db 01 00 00       	call   80039f <CheckSorted>
  8001c4:	83 c4 10             	add    $0x10,%esp
  8001c7:	89 45 e0             	mov    %eax,-0x20(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001ca:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8001ce:	75 14                	jne    8001e4 <_main+0x1ac>
  8001d0:	83 ec 04             	sub    $0x4,%esp
  8001d3:	68 7c 25 80 00       	push   $0x80257c
  8001d8:	6a 47                	push   $0x47
  8001da:	68 9e 25 80 00       	push   $0x80259e
  8001df:	e8 82 05 00 00       	call   800766 <_panic>
		else
		{ 
			cprintf("\n===============================================\n") ;
  8001e4:	83 ec 0c             	sub    $0xc,%esp
  8001e7:	68 b0 25 80 00       	push   $0x8025b0
  8001ec:	e8 17 08 00 00       	call   800a08 <cprintf>
  8001f1:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  8001f4:	83 ec 0c             	sub    $0xc,%esp
  8001f7:	68 e4 25 80 00       	push   $0x8025e4
  8001fc:	e8 07 08 00 00       	call   800a08 <cprintf>
  800201:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800204:	83 ec 0c             	sub    $0xc,%esp
  800207:	68 18 26 80 00       	push   $0x802618
  80020c:	e8 f7 07 00 00       	call   800a08 <cprintf>
  800211:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		cprintf("Freeing the Heap...\n\n") ;
  800214:	83 ec 0c             	sub    $0xc,%esp
  800217:	68 4a 26 80 00       	push   $0x80264a
  80021c:	e8 e7 07 00 00       	call   800a08 <cprintf>
  800221:	83 c4 10             	add    $0x10,%esp
		free(Elements) ;
  800224:	83 ec 0c             	sub    $0xc,%esp
  800227:	ff 75 e8             	pushl  -0x18(%ebp)
  80022a:	e8 1f 19 00 00       	call   801b4e <free>
  80022f:	83 c4 10             	add    $0x10,%esp

		///========================================================================
	sys_disable_interrupt();
  800232:	e8 3e 1c 00 00       	call   801e75 <sys_disable_interrupt>
		cprintf("Do you want to repeat (y/n): ") ;
  800237:	83 ec 0c             	sub    $0xc,%esp
  80023a:	68 60 26 80 00       	push   $0x802660
  80023f:	e8 c4 07 00 00       	call   800a08 <cprintf>
  800244:	83 c4 10             	add    $0x10,%esp

		Chose = getchar() ;
  800247:	e8 7d 03 00 00       	call   8005c9 <getchar>
  80024c:	88 45 e7             	mov    %al,-0x19(%ebp)
		cputchar(Chose);
  80024f:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  800253:	83 ec 0c             	sub    $0xc,%esp
  800256:	50                   	push   %eax
  800257:	e8 25 03 00 00       	call   800581 <cputchar>
  80025c:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  80025f:	83 ec 0c             	sub    $0xc,%esp
  800262:	6a 0a                	push   $0xa
  800264:	e8 18 03 00 00       	call   800581 <cputchar>
  800269:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  80026c:	83 ec 0c             	sub    $0xc,%esp
  80026f:	6a 0a                	push   $0xa
  800271:	e8 0b 03 00 00       	call   800581 <cputchar>
  800276:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800279:	e8 11 1c 00 00       	call   801e8f <sys_enable_interrupt>

	} while (Chose == 'y');
  80027e:	80 7d e7 79          	cmpb   $0x79,-0x19(%ebp)
  800282:	0f 84 c1 fd ff ff    	je     800049 <_main+0x11>

}
  800288:	90                   	nop
  800289:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80028c:	c9                   	leave  
  80028d:	c3                   	ret    

0080028e <QuickSort>:

///Quick sort 
void QuickSort(int *Elements, int NumOfElements)
{
  80028e:	55                   	push   %ebp
  80028f:	89 e5                	mov    %esp,%ebp
  800291:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  800294:	8b 45 0c             	mov    0xc(%ebp),%eax
  800297:	48                   	dec    %eax
  800298:	50                   	push   %eax
  800299:	6a 00                	push   $0x0
  80029b:	ff 75 0c             	pushl  0xc(%ebp)
  80029e:	ff 75 08             	pushl  0x8(%ebp)
  8002a1:	e8 06 00 00 00       	call   8002ac <QSort>
  8002a6:	83 c4 10             	add    $0x10,%esp
}
  8002a9:	90                   	nop
  8002aa:	c9                   	leave  
  8002ab:	c3                   	ret    

008002ac <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  8002ac:	55                   	push   %ebp
  8002ad:	89 e5                	mov    %esp,%ebp
  8002af:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  8002b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8002b5:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002b8:	0f 8d de 00 00 00    	jge    80039c <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  8002be:	8b 45 10             	mov    0x10(%ebp),%eax
  8002c1:	40                   	inc    %eax
  8002c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8002c5:	8b 45 14             	mov    0x14(%ebp),%eax
  8002c8:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8002cb:	e9 80 00 00 00       	jmp    800350 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  8002d0:	ff 45 f4             	incl   -0xc(%ebp)
  8002d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002d6:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002d9:	7f 2b                	jg     800306 <QSort+0x5a>
  8002db:	8b 45 10             	mov    0x10(%ebp),%eax
  8002de:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e8:	01 d0                	add    %edx,%eax
  8002ea:	8b 10                	mov    (%eax),%edx
  8002ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002ef:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f9:	01 c8                	add    %ecx,%eax
  8002fb:	8b 00                	mov    (%eax),%eax
  8002fd:	39 c2                	cmp    %eax,%edx
  8002ff:	7d cf                	jge    8002d0 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  800301:	eb 03                	jmp    800306 <QSort+0x5a>
  800303:	ff 4d f0             	decl   -0x10(%ebp)
  800306:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800309:	3b 45 10             	cmp    0x10(%ebp),%eax
  80030c:	7e 26                	jle    800334 <QSort+0x88>
  80030e:	8b 45 10             	mov    0x10(%ebp),%eax
  800311:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800318:	8b 45 08             	mov    0x8(%ebp),%eax
  80031b:	01 d0                	add    %edx,%eax
  80031d:	8b 10                	mov    (%eax),%edx
  80031f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800322:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800329:	8b 45 08             	mov    0x8(%ebp),%eax
  80032c:	01 c8                	add    %ecx,%eax
  80032e:	8b 00                	mov    (%eax),%eax
  800330:	39 c2                	cmp    %eax,%edx
  800332:	7e cf                	jle    800303 <QSort+0x57>

		if (i <= j)
  800334:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800337:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80033a:	7f 14                	jg     800350 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  80033c:	83 ec 04             	sub    $0x4,%esp
  80033f:	ff 75 f0             	pushl  -0x10(%ebp)
  800342:	ff 75 f4             	pushl  -0xc(%ebp)
  800345:	ff 75 08             	pushl  0x8(%ebp)
  800348:	e8 a9 00 00 00       	call   8003f6 <Swap>
  80034d:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800350:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800353:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800356:	0f 8e 77 ff ff ff    	jle    8002d3 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  80035c:	83 ec 04             	sub    $0x4,%esp
  80035f:	ff 75 f0             	pushl  -0x10(%ebp)
  800362:	ff 75 10             	pushl  0x10(%ebp)
  800365:	ff 75 08             	pushl  0x8(%ebp)
  800368:	e8 89 00 00 00       	call   8003f6 <Swap>
  80036d:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  800370:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800373:	48                   	dec    %eax
  800374:	50                   	push   %eax
  800375:	ff 75 10             	pushl  0x10(%ebp)
  800378:	ff 75 0c             	pushl  0xc(%ebp)
  80037b:	ff 75 08             	pushl  0x8(%ebp)
  80037e:	e8 29 ff ff ff       	call   8002ac <QSort>
  800383:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  800386:	ff 75 14             	pushl  0x14(%ebp)
  800389:	ff 75 f4             	pushl  -0xc(%ebp)
  80038c:	ff 75 0c             	pushl  0xc(%ebp)
  80038f:	ff 75 08             	pushl  0x8(%ebp)
  800392:	e8 15 ff ff ff       	call   8002ac <QSort>
  800397:	83 c4 10             	add    $0x10,%esp
  80039a:	eb 01                	jmp    80039d <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  80039c:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  80039d:	c9                   	leave  
  80039e:	c3                   	ret    

0080039f <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  80039f:	55                   	push   %ebp
  8003a0:	89 e5                	mov    %esp,%ebp
  8003a2:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8003a5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003ac:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8003b3:	eb 33                	jmp    8003e8 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8003b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003b8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c2:	01 d0                	add    %edx,%eax
  8003c4:	8b 10                	mov    (%eax),%edx
  8003c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003c9:	40                   	inc    %eax
  8003ca:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d4:	01 c8                	add    %ecx,%eax
  8003d6:	8b 00                	mov    (%eax),%eax
  8003d8:	39 c2                	cmp    %eax,%edx
  8003da:	7e 09                	jle    8003e5 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8003dc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8003e3:	eb 0c                	jmp    8003f1 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003e5:	ff 45 f8             	incl   -0x8(%ebp)
  8003e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003eb:	48                   	dec    %eax
  8003ec:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8003ef:	7f c4                	jg     8003b5 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8003f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8003f4:	c9                   	leave  
  8003f5:	c3                   	ret    

008003f6 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8003f6:	55                   	push   %ebp
  8003f7:	89 e5                	mov    %esp,%ebp
  8003f9:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8003fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ff:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800406:	8b 45 08             	mov    0x8(%ebp),%eax
  800409:	01 d0                	add    %edx,%eax
  80040b:	8b 00                	mov    (%eax),%eax
  80040d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800410:	8b 45 0c             	mov    0xc(%ebp),%eax
  800413:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80041a:	8b 45 08             	mov    0x8(%ebp),%eax
  80041d:	01 c2                	add    %eax,%edx
  80041f:	8b 45 10             	mov    0x10(%ebp),%eax
  800422:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800429:	8b 45 08             	mov    0x8(%ebp),%eax
  80042c:	01 c8                	add    %ecx,%eax
  80042e:	8b 00                	mov    (%eax),%eax
  800430:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800432:	8b 45 10             	mov    0x10(%ebp),%eax
  800435:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80043c:	8b 45 08             	mov    0x8(%ebp),%eax
  80043f:	01 c2                	add    %eax,%edx
  800441:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800444:	89 02                	mov    %eax,(%edx)
}
  800446:	90                   	nop
  800447:	c9                   	leave  
  800448:	c3                   	ret    

00800449 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800449:	55                   	push   %ebp
  80044a:	89 e5                	mov    %esp,%ebp
  80044c:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80044f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800456:	eb 17                	jmp    80046f <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800458:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80045b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800462:	8b 45 08             	mov    0x8(%ebp),%eax
  800465:	01 c2                	add    %eax,%edx
  800467:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80046a:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80046c:	ff 45 fc             	incl   -0x4(%ebp)
  80046f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800472:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800475:	7c e1                	jl     800458 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800477:	90                   	nop
  800478:	c9                   	leave  
  800479:	c3                   	ret    

0080047a <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  80047a:	55                   	push   %ebp
  80047b:	89 e5                	mov    %esp,%ebp
  80047d:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800480:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800487:	eb 1b                	jmp    8004a4 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800489:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80048c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800493:	8b 45 08             	mov    0x8(%ebp),%eax
  800496:	01 c2                	add    %eax,%edx
  800498:	8b 45 0c             	mov    0xc(%ebp),%eax
  80049b:	2b 45 fc             	sub    -0x4(%ebp),%eax
  80049e:	48                   	dec    %eax
  80049f:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004a1:	ff 45 fc             	incl   -0x4(%ebp)
  8004a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004a7:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004aa:	7c dd                	jl     800489 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8004ac:	90                   	nop
  8004ad:	c9                   	leave  
  8004ae:	c3                   	ret    

008004af <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8004af:	55                   	push   %ebp
  8004b0:	89 e5                	mov    %esp,%ebp
  8004b2:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8004b5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004b8:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8004bd:	f7 e9                	imul   %ecx
  8004bf:	c1 f9 1f             	sar    $0x1f,%ecx
  8004c2:	89 d0                	mov    %edx,%eax
  8004c4:	29 c8                	sub    %ecx,%eax
  8004c6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8004c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004d0:	eb 1e                	jmp    8004f0 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8004d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004d5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8004df:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8004e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004e5:	99                   	cltd   
  8004e6:	f7 7d f8             	idivl  -0x8(%ebp)
  8004e9:	89 d0                	mov    %edx,%eax
  8004eb:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004ed:	ff 45 fc             	incl   -0x4(%ebp)
  8004f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004f3:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004f6:	7c da                	jl     8004d2 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  8004f8:	90                   	nop
  8004f9:	c9                   	leave  
  8004fa:	c3                   	ret    

008004fb <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8004fb:	55                   	push   %ebp
  8004fc:	89 e5                	mov    %esp,%ebp
  8004fe:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800501:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800508:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80050f:	eb 42                	jmp    800553 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800511:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800514:	99                   	cltd   
  800515:	f7 7d f0             	idivl  -0x10(%ebp)
  800518:	89 d0                	mov    %edx,%eax
  80051a:	85 c0                	test   %eax,%eax
  80051c:	75 10                	jne    80052e <PrintElements+0x33>
			cprintf("\n");
  80051e:	83 ec 0c             	sub    $0xc,%esp
  800521:	68 7e 26 80 00       	push   $0x80267e
  800526:	e8 dd 04 00 00       	call   800a08 <cprintf>
  80052b:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  80052e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800531:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800538:	8b 45 08             	mov    0x8(%ebp),%eax
  80053b:	01 d0                	add    %edx,%eax
  80053d:	8b 00                	mov    (%eax),%eax
  80053f:	83 ec 08             	sub    $0x8,%esp
  800542:	50                   	push   %eax
  800543:	68 80 26 80 00       	push   $0x802680
  800548:	e8 bb 04 00 00       	call   800a08 <cprintf>
  80054d:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800550:	ff 45 f4             	incl   -0xc(%ebp)
  800553:	8b 45 0c             	mov    0xc(%ebp),%eax
  800556:	48                   	dec    %eax
  800557:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80055a:	7f b5                	jg     800511 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  80055c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80055f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800566:	8b 45 08             	mov    0x8(%ebp),%eax
  800569:	01 d0                	add    %edx,%eax
  80056b:	8b 00                	mov    (%eax),%eax
  80056d:	83 ec 08             	sub    $0x8,%esp
  800570:	50                   	push   %eax
  800571:	68 85 26 80 00       	push   $0x802685
  800576:	e8 8d 04 00 00       	call   800a08 <cprintf>
  80057b:	83 c4 10             	add    $0x10,%esp

}
  80057e:	90                   	nop
  80057f:	c9                   	leave  
  800580:	c3                   	ret    

00800581 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800581:	55                   	push   %ebp
  800582:	89 e5                	mov    %esp,%ebp
  800584:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800587:	8b 45 08             	mov    0x8(%ebp),%eax
  80058a:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80058d:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800591:	83 ec 0c             	sub    $0xc,%esp
  800594:	50                   	push   %eax
  800595:	e8 0f 19 00 00       	call   801ea9 <sys_cputc>
  80059a:	83 c4 10             	add    $0x10,%esp
}
  80059d:	90                   	nop
  80059e:	c9                   	leave  
  80059f:	c3                   	ret    

008005a0 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8005a0:	55                   	push   %ebp
  8005a1:	89 e5                	mov    %esp,%ebp
  8005a3:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005a6:	e8 ca 18 00 00       	call   801e75 <sys_disable_interrupt>
	char c = ch;
  8005ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ae:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005b1:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005b5:	83 ec 0c             	sub    $0xc,%esp
  8005b8:	50                   	push   %eax
  8005b9:	e8 eb 18 00 00       	call   801ea9 <sys_cputc>
  8005be:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8005c1:	e8 c9 18 00 00       	call   801e8f <sys_enable_interrupt>
}
  8005c6:	90                   	nop
  8005c7:	c9                   	leave  
  8005c8:	c3                   	ret    

008005c9 <getchar>:

int
getchar(void)
{
  8005c9:	55                   	push   %ebp
  8005ca:	89 e5                	mov    %esp,%ebp
  8005cc:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8005cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005d6:	eb 08                	jmp    8005e0 <getchar+0x17>
	{
		c = sys_cgetc();
  8005d8:	e8 b0 16 00 00       	call   801c8d <sys_cgetc>
  8005dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8005e0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005e4:	74 f2                	je     8005d8 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8005e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005e9:	c9                   	leave  
  8005ea:	c3                   	ret    

008005eb <atomic_getchar>:

int
atomic_getchar(void)
{
  8005eb:	55                   	push   %ebp
  8005ec:	89 e5                	mov    %esp,%ebp
  8005ee:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005f1:	e8 7f 18 00 00       	call   801e75 <sys_disable_interrupt>
	int c=0;
  8005f6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005fd:	eb 08                	jmp    800607 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8005ff:	e8 89 16 00 00       	call   801c8d <sys_cgetc>
  800604:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  800607:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80060b:	74 f2                	je     8005ff <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  80060d:	e8 7d 18 00 00       	call   801e8f <sys_enable_interrupt>
	return c;
  800612:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800615:	c9                   	leave  
  800616:	c3                   	ret    

00800617 <iscons>:

int iscons(int fdnum)
{
  800617:	55                   	push   %ebp
  800618:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  80061a:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80061f:	5d                   	pop    %ebp
  800620:	c3                   	ret    

00800621 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800621:	55                   	push   %ebp
  800622:	89 e5                	mov    %esp,%ebp
  800624:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800627:	e8 ae 16 00 00       	call   801cda <sys_getenvindex>
  80062c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80062f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800632:	89 d0                	mov    %edx,%eax
  800634:	c1 e0 03             	shl    $0x3,%eax
  800637:	01 d0                	add    %edx,%eax
  800639:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800640:	01 c8                	add    %ecx,%eax
  800642:	01 c0                	add    %eax,%eax
  800644:	01 d0                	add    %edx,%eax
  800646:	01 c0                	add    %eax,%eax
  800648:	01 d0                	add    %edx,%eax
  80064a:	89 c2                	mov    %eax,%edx
  80064c:	c1 e2 05             	shl    $0x5,%edx
  80064f:	29 c2                	sub    %eax,%edx
  800651:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  800658:	89 c2                	mov    %eax,%edx
  80065a:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800660:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800665:	a1 24 30 80 00       	mov    0x803024,%eax
  80066a:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  800670:	84 c0                	test   %al,%al
  800672:	74 0f                	je     800683 <libmain+0x62>
		binaryname = myEnv->prog_name;
  800674:	a1 24 30 80 00       	mov    0x803024,%eax
  800679:	05 40 3c 01 00       	add    $0x13c40,%eax
  80067e:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800683:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800687:	7e 0a                	jle    800693 <libmain+0x72>
		binaryname = argv[0];
  800689:	8b 45 0c             	mov    0xc(%ebp),%eax
  80068c:	8b 00                	mov    (%eax),%eax
  80068e:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800693:	83 ec 08             	sub    $0x8,%esp
  800696:	ff 75 0c             	pushl  0xc(%ebp)
  800699:	ff 75 08             	pushl  0x8(%ebp)
  80069c:	e8 97 f9 ff ff       	call   800038 <_main>
  8006a1:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8006a4:	e8 cc 17 00 00       	call   801e75 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8006a9:	83 ec 0c             	sub    $0xc,%esp
  8006ac:	68 a4 26 80 00       	push   $0x8026a4
  8006b1:	e8 52 03 00 00       	call   800a08 <cprintf>
  8006b6:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8006b9:	a1 24 30 80 00       	mov    0x803024,%eax
  8006be:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8006c4:	a1 24 30 80 00       	mov    0x803024,%eax
  8006c9:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  8006cf:	83 ec 04             	sub    $0x4,%esp
  8006d2:	52                   	push   %edx
  8006d3:	50                   	push   %eax
  8006d4:	68 cc 26 80 00       	push   $0x8026cc
  8006d9:	e8 2a 03 00 00       	call   800a08 <cprintf>
  8006de:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  8006e1:	a1 24 30 80 00       	mov    0x803024,%eax
  8006e6:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  8006ec:	a1 24 30 80 00       	mov    0x803024,%eax
  8006f1:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  8006f7:	83 ec 04             	sub    $0x4,%esp
  8006fa:	52                   	push   %edx
  8006fb:	50                   	push   %eax
  8006fc:	68 f4 26 80 00       	push   $0x8026f4
  800701:	e8 02 03 00 00       	call   800a08 <cprintf>
  800706:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800709:	a1 24 30 80 00       	mov    0x803024,%eax
  80070e:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800714:	83 ec 08             	sub    $0x8,%esp
  800717:	50                   	push   %eax
  800718:	68 35 27 80 00       	push   $0x802735
  80071d:	e8 e6 02 00 00       	call   800a08 <cprintf>
  800722:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  800725:	83 ec 0c             	sub    $0xc,%esp
  800728:	68 a4 26 80 00       	push   $0x8026a4
  80072d:	e8 d6 02 00 00       	call   800a08 <cprintf>
  800732:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800735:	e8 55 17 00 00       	call   801e8f <sys_enable_interrupt>

	// exit gracefully
	exit();
  80073a:	e8 19 00 00 00       	call   800758 <exit>
}
  80073f:	90                   	nop
  800740:	c9                   	leave  
  800741:	c3                   	ret    

00800742 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800742:	55                   	push   %ebp
  800743:	89 e5                	mov    %esp,%ebp
  800745:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800748:	83 ec 0c             	sub    $0xc,%esp
  80074b:	6a 00                	push   $0x0
  80074d:	e8 54 15 00 00       	call   801ca6 <sys_env_destroy>
  800752:	83 c4 10             	add    $0x10,%esp
}
  800755:	90                   	nop
  800756:	c9                   	leave  
  800757:	c3                   	ret    

00800758 <exit>:

void
exit(void)
{
  800758:	55                   	push   %ebp
  800759:	89 e5                	mov    %esp,%ebp
  80075b:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80075e:	e8 a9 15 00 00       	call   801d0c <sys_env_exit>
}
  800763:	90                   	nop
  800764:	c9                   	leave  
  800765:	c3                   	ret    

00800766 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800766:	55                   	push   %ebp
  800767:	89 e5                	mov    %esp,%ebp
  800769:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80076c:	8d 45 10             	lea    0x10(%ebp),%eax
  80076f:	83 c0 04             	add    $0x4,%eax
  800772:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800775:	a1 18 31 80 00       	mov    0x803118,%eax
  80077a:	85 c0                	test   %eax,%eax
  80077c:	74 16                	je     800794 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80077e:	a1 18 31 80 00       	mov    0x803118,%eax
  800783:	83 ec 08             	sub    $0x8,%esp
  800786:	50                   	push   %eax
  800787:	68 4c 27 80 00       	push   $0x80274c
  80078c:	e8 77 02 00 00       	call   800a08 <cprintf>
  800791:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800794:	a1 00 30 80 00       	mov    0x803000,%eax
  800799:	ff 75 0c             	pushl  0xc(%ebp)
  80079c:	ff 75 08             	pushl  0x8(%ebp)
  80079f:	50                   	push   %eax
  8007a0:	68 51 27 80 00       	push   $0x802751
  8007a5:	e8 5e 02 00 00       	call   800a08 <cprintf>
  8007aa:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8007ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8007b0:	83 ec 08             	sub    $0x8,%esp
  8007b3:	ff 75 f4             	pushl  -0xc(%ebp)
  8007b6:	50                   	push   %eax
  8007b7:	e8 e1 01 00 00       	call   80099d <vcprintf>
  8007bc:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8007bf:	83 ec 08             	sub    $0x8,%esp
  8007c2:	6a 00                	push   $0x0
  8007c4:	68 6d 27 80 00       	push   $0x80276d
  8007c9:	e8 cf 01 00 00       	call   80099d <vcprintf>
  8007ce:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8007d1:	e8 82 ff ff ff       	call   800758 <exit>

	// should not return here
	while (1) ;
  8007d6:	eb fe                	jmp    8007d6 <_panic+0x70>

008007d8 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8007d8:	55                   	push   %ebp
  8007d9:	89 e5                	mov    %esp,%ebp
  8007db:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8007de:	a1 24 30 80 00       	mov    0x803024,%eax
  8007e3:	8b 50 74             	mov    0x74(%eax),%edx
  8007e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007e9:	39 c2                	cmp    %eax,%edx
  8007eb:	74 14                	je     800801 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007ed:	83 ec 04             	sub    $0x4,%esp
  8007f0:	68 70 27 80 00       	push   $0x802770
  8007f5:	6a 26                	push   $0x26
  8007f7:	68 bc 27 80 00       	push   $0x8027bc
  8007fc:	e8 65 ff ff ff       	call   800766 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800801:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800808:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80080f:	e9 b6 00 00 00       	jmp    8008ca <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  800814:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800817:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80081e:	8b 45 08             	mov    0x8(%ebp),%eax
  800821:	01 d0                	add    %edx,%eax
  800823:	8b 00                	mov    (%eax),%eax
  800825:	85 c0                	test   %eax,%eax
  800827:	75 08                	jne    800831 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800829:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80082c:	e9 96 00 00 00       	jmp    8008c7 <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  800831:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800838:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80083f:	eb 5d                	jmp    80089e <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800841:	a1 24 30 80 00       	mov    0x803024,%eax
  800846:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  80084c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80084f:	c1 e2 04             	shl    $0x4,%edx
  800852:	01 d0                	add    %edx,%eax
  800854:	8a 40 04             	mov    0x4(%eax),%al
  800857:	84 c0                	test   %al,%al
  800859:	75 40                	jne    80089b <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80085b:	a1 24 30 80 00       	mov    0x803024,%eax
  800860:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800866:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800869:	c1 e2 04             	shl    $0x4,%edx
  80086c:	01 d0                	add    %edx,%eax
  80086e:	8b 00                	mov    (%eax),%eax
  800870:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800873:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800876:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80087b:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80087d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800880:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800887:	8b 45 08             	mov    0x8(%ebp),%eax
  80088a:	01 c8                	add    %ecx,%eax
  80088c:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80088e:	39 c2                	cmp    %eax,%edx
  800890:	75 09                	jne    80089b <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800892:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800899:	eb 12                	jmp    8008ad <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80089b:	ff 45 e8             	incl   -0x18(%ebp)
  80089e:	a1 24 30 80 00       	mov    0x803024,%eax
  8008a3:	8b 50 74             	mov    0x74(%eax),%edx
  8008a6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008a9:	39 c2                	cmp    %eax,%edx
  8008ab:	77 94                	ja     800841 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8008ad:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8008b1:	75 14                	jne    8008c7 <CheckWSWithoutLastIndex+0xef>
			panic(
  8008b3:	83 ec 04             	sub    $0x4,%esp
  8008b6:	68 c8 27 80 00       	push   $0x8027c8
  8008bb:	6a 3a                	push   $0x3a
  8008bd:	68 bc 27 80 00       	push   $0x8027bc
  8008c2:	e8 9f fe ff ff       	call   800766 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8008c7:	ff 45 f0             	incl   -0x10(%ebp)
  8008ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008cd:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008d0:	0f 8c 3e ff ff ff    	jl     800814 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8008d6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008dd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008e4:	eb 20                	jmp    800906 <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008e6:	a1 24 30 80 00       	mov    0x803024,%eax
  8008eb:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8008f1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008f4:	c1 e2 04             	shl    $0x4,%edx
  8008f7:	01 d0                	add    %edx,%eax
  8008f9:	8a 40 04             	mov    0x4(%eax),%al
  8008fc:	3c 01                	cmp    $0x1,%al
  8008fe:	75 03                	jne    800903 <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800900:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800903:	ff 45 e0             	incl   -0x20(%ebp)
  800906:	a1 24 30 80 00       	mov    0x803024,%eax
  80090b:	8b 50 74             	mov    0x74(%eax),%edx
  80090e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800911:	39 c2                	cmp    %eax,%edx
  800913:	77 d1                	ja     8008e6 <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800915:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800918:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80091b:	74 14                	je     800931 <CheckWSWithoutLastIndex+0x159>
		panic(
  80091d:	83 ec 04             	sub    $0x4,%esp
  800920:	68 1c 28 80 00       	push   $0x80281c
  800925:	6a 44                	push   $0x44
  800927:	68 bc 27 80 00       	push   $0x8027bc
  80092c:	e8 35 fe ff ff       	call   800766 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800931:	90                   	nop
  800932:	c9                   	leave  
  800933:	c3                   	ret    

00800934 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800934:	55                   	push   %ebp
  800935:	89 e5                	mov    %esp,%ebp
  800937:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80093a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80093d:	8b 00                	mov    (%eax),%eax
  80093f:	8d 48 01             	lea    0x1(%eax),%ecx
  800942:	8b 55 0c             	mov    0xc(%ebp),%edx
  800945:	89 0a                	mov    %ecx,(%edx)
  800947:	8b 55 08             	mov    0x8(%ebp),%edx
  80094a:	88 d1                	mov    %dl,%cl
  80094c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80094f:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800953:	8b 45 0c             	mov    0xc(%ebp),%eax
  800956:	8b 00                	mov    (%eax),%eax
  800958:	3d ff 00 00 00       	cmp    $0xff,%eax
  80095d:	75 2c                	jne    80098b <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80095f:	a0 28 30 80 00       	mov    0x803028,%al
  800964:	0f b6 c0             	movzbl %al,%eax
  800967:	8b 55 0c             	mov    0xc(%ebp),%edx
  80096a:	8b 12                	mov    (%edx),%edx
  80096c:	89 d1                	mov    %edx,%ecx
  80096e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800971:	83 c2 08             	add    $0x8,%edx
  800974:	83 ec 04             	sub    $0x4,%esp
  800977:	50                   	push   %eax
  800978:	51                   	push   %ecx
  800979:	52                   	push   %edx
  80097a:	e8 e5 12 00 00       	call   801c64 <sys_cputs>
  80097f:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800982:	8b 45 0c             	mov    0xc(%ebp),%eax
  800985:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80098b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80098e:	8b 40 04             	mov    0x4(%eax),%eax
  800991:	8d 50 01             	lea    0x1(%eax),%edx
  800994:	8b 45 0c             	mov    0xc(%ebp),%eax
  800997:	89 50 04             	mov    %edx,0x4(%eax)
}
  80099a:	90                   	nop
  80099b:	c9                   	leave  
  80099c:	c3                   	ret    

0080099d <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80099d:	55                   	push   %ebp
  80099e:	89 e5                	mov    %esp,%ebp
  8009a0:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8009a6:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8009ad:	00 00 00 
	b.cnt = 0;
  8009b0:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8009b7:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8009ba:	ff 75 0c             	pushl  0xc(%ebp)
  8009bd:	ff 75 08             	pushl  0x8(%ebp)
  8009c0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009c6:	50                   	push   %eax
  8009c7:	68 34 09 80 00       	push   $0x800934
  8009cc:	e8 11 02 00 00       	call   800be2 <vprintfmt>
  8009d1:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8009d4:	a0 28 30 80 00       	mov    0x803028,%al
  8009d9:	0f b6 c0             	movzbl %al,%eax
  8009dc:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009e2:	83 ec 04             	sub    $0x4,%esp
  8009e5:	50                   	push   %eax
  8009e6:	52                   	push   %edx
  8009e7:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009ed:	83 c0 08             	add    $0x8,%eax
  8009f0:	50                   	push   %eax
  8009f1:	e8 6e 12 00 00       	call   801c64 <sys_cputs>
  8009f6:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009f9:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800a00:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a06:	c9                   	leave  
  800a07:	c3                   	ret    

00800a08 <cprintf>:

int cprintf(const char *fmt, ...) {
  800a08:	55                   	push   %ebp
  800a09:	89 e5                	mov    %esp,%ebp
  800a0b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a0e:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800a15:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a18:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1e:	83 ec 08             	sub    $0x8,%esp
  800a21:	ff 75 f4             	pushl  -0xc(%ebp)
  800a24:	50                   	push   %eax
  800a25:	e8 73 ff ff ff       	call   80099d <vcprintf>
  800a2a:	83 c4 10             	add    $0x10,%esp
  800a2d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a30:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a33:	c9                   	leave  
  800a34:	c3                   	ret    

00800a35 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a35:	55                   	push   %ebp
  800a36:	89 e5                	mov    %esp,%ebp
  800a38:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a3b:	e8 35 14 00 00       	call   801e75 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a40:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a43:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a46:	8b 45 08             	mov    0x8(%ebp),%eax
  800a49:	83 ec 08             	sub    $0x8,%esp
  800a4c:	ff 75 f4             	pushl  -0xc(%ebp)
  800a4f:	50                   	push   %eax
  800a50:	e8 48 ff ff ff       	call   80099d <vcprintf>
  800a55:	83 c4 10             	add    $0x10,%esp
  800a58:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a5b:	e8 2f 14 00 00       	call   801e8f <sys_enable_interrupt>
	return cnt;
  800a60:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a63:	c9                   	leave  
  800a64:	c3                   	ret    

00800a65 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a65:	55                   	push   %ebp
  800a66:	89 e5                	mov    %esp,%ebp
  800a68:	53                   	push   %ebx
  800a69:	83 ec 14             	sub    $0x14,%esp
  800a6c:	8b 45 10             	mov    0x10(%ebp),%eax
  800a6f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a72:	8b 45 14             	mov    0x14(%ebp),%eax
  800a75:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a78:	8b 45 18             	mov    0x18(%ebp),%eax
  800a7b:	ba 00 00 00 00       	mov    $0x0,%edx
  800a80:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a83:	77 55                	ja     800ada <printnum+0x75>
  800a85:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a88:	72 05                	jb     800a8f <printnum+0x2a>
  800a8a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a8d:	77 4b                	ja     800ada <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a8f:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a92:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a95:	8b 45 18             	mov    0x18(%ebp),%eax
  800a98:	ba 00 00 00 00       	mov    $0x0,%edx
  800a9d:	52                   	push   %edx
  800a9e:	50                   	push   %eax
  800a9f:	ff 75 f4             	pushl  -0xc(%ebp)
  800aa2:	ff 75 f0             	pushl  -0x10(%ebp)
  800aa5:	e8 ee 17 00 00       	call   802298 <__udivdi3>
  800aaa:	83 c4 10             	add    $0x10,%esp
  800aad:	83 ec 04             	sub    $0x4,%esp
  800ab0:	ff 75 20             	pushl  0x20(%ebp)
  800ab3:	53                   	push   %ebx
  800ab4:	ff 75 18             	pushl  0x18(%ebp)
  800ab7:	52                   	push   %edx
  800ab8:	50                   	push   %eax
  800ab9:	ff 75 0c             	pushl  0xc(%ebp)
  800abc:	ff 75 08             	pushl  0x8(%ebp)
  800abf:	e8 a1 ff ff ff       	call   800a65 <printnum>
  800ac4:	83 c4 20             	add    $0x20,%esp
  800ac7:	eb 1a                	jmp    800ae3 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800ac9:	83 ec 08             	sub    $0x8,%esp
  800acc:	ff 75 0c             	pushl  0xc(%ebp)
  800acf:	ff 75 20             	pushl  0x20(%ebp)
  800ad2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad5:	ff d0                	call   *%eax
  800ad7:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800ada:	ff 4d 1c             	decl   0x1c(%ebp)
  800add:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800ae1:	7f e6                	jg     800ac9 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800ae3:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800ae6:	bb 00 00 00 00       	mov    $0x0,%ebx
  800aeb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aee:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800af1:	53                   	push   %ebx
  800af2:	51                   	push   %ecx
  800af3:	52                   	push   %edx
  800af4:	50                   	push   %eax
  800af5:	e8 ae 18 00 00       	call   8023a8 <__umoddi3>
  800afa:	83 c4 10             	add    $0x10,%esp
  800afd:	05 94 2a 80 00       	add    $0x802a94,%eax
  800b02:	8a 00                	mov    (%eax),%al
  800b04:	0f be c0             	movsbl %al,%eax
  800b07:	83 ec 08             	sub    $0x8,%esp
  800b0a:	ff 75 0c             	pushl  0xc(%ebp)
  800b0d:	50                   	push   %eax
  800b0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b11:	ff d0                	call   *%eax
  800b13:	83 c4 10             	add    $0x10,%esp
}
  800b16:	90                   	nop
  800b17:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b1a:	c9                   	leave  
  800b1b:	c3                   	ret    

00800b1c <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b1c:	55                   	push   %ebp
  800b1d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b1f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b23:	7e 1c                	jle    800b41 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b25:	8b 45 08             	mov    0x8(%ebp),%eax
  800b28:	8b 00                	mov    (%eax),%eax
  800b2a:	8d 50 08             	lea    0x8(%eax),%edx
  800b2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b30:	89 10                	mov    %edx,(%eax)
  800b32:	8b 45 08             	mov    0x8(%ebp),%eax
  800b35:	8b 00                	mov    (%eax),%eax
  800b37:	83 e8 08             	sub    $0x8,%eax
  800b3a:	8b 50 04             	mov    0x4(%eax),%edx
  800b3d:	8b 00                	mov    (%eax),%eax
  800b3f:	eb 40                	jmp    800b81 <getuint+0x65>
	else if (lflag)
  800b41:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b45:	74 1e                	je     800b65 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b47:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4a:	8b 00                	mov    (%eax),%eax
  800b4c:	8d 50 04             	lea    0x4(%eax),%edx
  800b4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b52:	89 10                	mov    %edx,(%eax)
  800b54:	8b 45 08             	mov    0x8(%ebp),%eax
  800b57:	8b 00                	mov    (%eax),%eax
  800b59:	83 e8 04             	sub    $0x4,%eax
  800b5c:	8b 00                	mov    (%eax),%eax
  800b5e:	ba 00 00 00 00       	mov    $0x0,%edx
  800b63:	eb 1c                	jmp    800b81 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b65:	8b 45 08             	mov    0x8(%ebp),%eax
  800b68:	8b 00                	mov    (%eax),%eax
  800b6a:	8d 50 04             	lea    0x4(%eax),%edx
  800b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b70:	89 10                	mov    %edx,(%eax)
  800b72:	8b 45 08             	mov    0x8(%ebp),%eax
  800b75:	8b 00                	mov    (%eax),%eax
  800b77:	83 e8 04             	sub    $0x4,%eax
  800b7a:	8b 00                	mov    (%eax),%eax
  800b7c:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b81:	5d                   	pop    %ebp
  800b82:	c3                   	ret    

00800b83 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b83:	55                   	push   %ebp
  800b84:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b86:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b8a:	7e 1c                	jle    800ba8 <getint+0x25>
		return va_arg(*ap, long long);
  800b8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8f:	8b 00                	mov    (%eax),%eax
  800b91:	8d 50 08             	lea    0x8(%eax),%edx
  800b94:	8b 45 08             	mov    0x8(%ebp),%eax
  800b97:	89 10                	mov    %edx,(%eax)
  800b99:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9c:	8b 00                	mov    (%eax),%eax
  800b9e:	83 e8 08             	sub    $0x8,%eax
  800ba1:	8b 50 04             	mov    0x4(%eax),%edx
  800ba4:	8b 00                	mov    (%eax),%eax
  800ba6:	eb 38                	jmp    800be0 <getint+0x5d>
	else if (lflag)
  800ba8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bac:	74 1a                	je     800bc8 <getint+0x45>
		return va_arg(*ap, long);
  800bae:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb1:	8b 00                	mov    (%eax),%eax
  800bb3:	8d 50 04             	lea    0x4(%eax),%edx
  800bb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb9:	89 10                	mov    %edx,(%eax)
  800bbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbe:	8b 00                	mov    (%eax),%eax
  800bc0:	83 e8 04             	sub    $0x4,%eax
  800bc3:	8b 00                	mov    (%eax),%eax
  800bc5:	99                   	cltd   
  800bc6:	eb 18                	jmp    800be0 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800bc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bcb:	8b 00                	mov    (%eax),%eax
  800bcd:	8d 50 04             	lea    0x4(%eax),%edx
  800bd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd3:	89 10                	mov    %edx,(%eax)
  800bd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd8:	8b 00                	mov    (%eax),%eax
  800bda:	83 e8 04             	sub    $0x4,%eax
  800bdd:	8b 00                	mov    (%eax),%eax
  800bdf:	99                   	cltd   
}
  800be0:	5d                   	pop    %ebp
  800be1:	c3                   	ret    

00800be2 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800be2:	55                   	push   %ebp
  800be3:	89 e5                	mov    %esp,%ebp
  800be5:	56                   	push   %esi
  800be6:	53                   	push   %ebx
  800be7:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bea:	eb 17                	jmp    800c03 <vprintfmt+0x21>
			if (ch == '\0')
  800bec:	85 db                	test   %ebx,%ebx
  800bee:	0f 84 af 03 00 00    	je     800fa3 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800bf4:	83 ec 08             	sub    $0x8,%esp
  800bf7:	ff 75 0c             	pushl  0xc(%ebp)
  800bfa:	53                   	push   %ebx
  800bfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfe:	ff d0                	call   *%eax
  800c00:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c03:	8b 45 10             	mov    0x10(%ebp),%eax
  800c06:	8d 50 01             	lea    0x1(%eax),%edx
  800c09:	89 55 10             	mov    %edx,0x10(%ebp)
  800c0c:	8a 00                	mov    (%eax),%al
  800c0e:	0f b6 d8             	movzbl %al,%ebx
  800c11:	83 fb 25             	cmp    $0x25,%ebx
  800c14:	75 d6                	jne    800bec <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c16:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c1a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c21:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c28:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c2f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c36:	8b 45 10             	mov    0x10(%ebp),%eax
  800c39:	8d 50 01             	lea    0x1(%eax),%edx
  800c3c:	89 55 10             	mov    %edx,0x10(%ebp)
  800c3f:	8a 00                	mov    (%eax),%al
  800c41:	0f b6 d8             	movzbl %al,%ebx
  800c44:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c47:	83 f8 55             	cmp    $0x55,%eax
  800c4a:	0f 87 2b 03 00 00    	ja     800f7b <vprintfmt+0x399>
  800c50:	8b 04 85 b8 2a 80 00 	mov    0x802ab8(,%eax,4),%eax
  800c57:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c59:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c5d:	eb d7                	jmp    800c36 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c5f:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c63:	eb d1                	jmp    800c36 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c65:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c6c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c6f:	89 d0                	mov    %edx,%eax
  800c71:	c1 e0 02             	shl    $0x2,%eax
  800c74:	01 d0                	add    %edx,%eax
  800c76:	01 c0                	add    %eax,%eax
  800c78:	01 d8                	add    %ebx,%eax
  800c7a:	83 e8 30             	sub    $0x30,%eax
  800c7d:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c80:	8b 45 10             	mov    0x10(%ebp),%eax
  800c83:	8a 00                	mov    (%eax),%al
  800c85:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c88:	83 fb 2f             	cmp    $0x2f,%ebx
  800c8b:	7e 3e                	jle    800ccb <vprintfmt+0xe9>
  800c8d:	83 fb 39             	cmp    $0x39,%ebx
  800c90:	7f 39                	jg     800ccb <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c92:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c95:	eb d5                	jmp    800c6c <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c97:	8b 45 14             	mov    0x14(%ebp),%eax
  800c9a:	83 c0 04             	add    $0x4,%eax
  800c9d:	89 45 14             	mov    %eax,0x14(%ebp)
  800ca0:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca3:	83 e8 04             	sub    $0x4,%eax
  800ca6:	8b 00                	mov    (%eax),%eax
  800ca8:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800cab:	eb 1f                	jmp    800ccc <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800cad:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cb1:	79 83                	jns    800c36 <vprintfmt+0x54>
				width = 0;
  800cb3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800cba:	e9 77 ff ff ff       	jmp    800c36 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800cbf:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800cc6:	e9 6b ff ff ff       	jmp    800c36 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800ccb:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800ccc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cd0:	0f 89 60 ff ff ff    	jns    800c36 <vprintfmt+0x54>
				width = precision, precision = -1;
  800cd6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cd9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800cdc:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800ce3:	e9 4e ff ff ff       	jmp    800c36 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800ce8:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800ceb:	e9 46 ff ff ff       	jmp    800c36 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800cf0:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf3:	83 c0 04             	add    $0x4,%eax
  800cf6:	89 45 14             	mov    %eax,0x14(%ebp)
  800cf9:	8b 45 14             	mov    0x14(%ebp),%eax
  800cfc:	83 e8 04             	sub    $0x4,%eax
  800cff:	8b 00                	mov    (%eax),%eax
  800d01:	83 ec 08             	sub    $0x8,%esp
  800d04:	ff 75 0c             	pushl  0xc(%ebp)
  800d07:	50                   	push   %eax
  800d08:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0b:	ff d0                	call   *%eax
  800d0d:	83 c4 10             	add    $0x10,%esp
			break;
  800d10:	e9 89 02 00 00       	jmp    800f9e <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d15:	8b 45 14             	mov    0x14(%ebp),%eax
  800d18:	83 c0 04             	add    $0x4,%eax
  800d1b:	89 45 14             	mov    %eax,0x14(%ebp)
  800d1e:	8b 45 14             	mov    0x14(%ebp),%eax
  800d21:	83 e8 04             	sub    $0x4,%eax
  800d24:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d26:	85 db                	test   %ebx,%ebx
  800d28:	79 02                	jns    800d2c <vprintfmt+0x14a>
				err = -err;
  800d2a:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d2c:	83 fb 64             	cmp    $0x64,%ebx
  800d2f:	7f 0b                	jg     800d3c <vprintfmt+0x15a>
  800d31:	8b 34 9d 00 29 80 00 	mov    0x802900(,%ebx,4),%esi
  800d38:	85 f6                	test   %esi,%esi
  800d3a:	75 19                	jne    800d55 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d3c:	53                   	push   %ebx
  800d3d:	68 a5 2a 80 00       	push   $0x802aa5
  800d42:	ff 75 0c             	pushl  0xc(%ebp)
  800d45:	ff 75 08             	pushl  0x8(%ebp)
  800d48:	e8 5e 02 00 00       	call   800fab <printfmt>
  800d4d:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d50:	e9 49 02 00 00       	jmp    800f9e <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d55:	56                   	push   %esi
  800d56:	68 ae 2a 80 00       	push   $0x802aae
  800d5b:	ff 75 0c             	pushl  0xc(%ebp)
  800d5e:	ff 75 08             	pushl  0x8(%ebp)
  800d61:	e8 45 02 00 00       	call   800fab <printfmt>
  800d66:	83 c4 10             	add    $0x10,%esp
			break;
  800d69:	e9 30 02 00 00       	jmp    800f9e <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d6e:	8b 45 14             	mov    0x14(%ebp),%eax
  800d71:	83 c0 04             	add    $0x4,%eax
  800d74:	89 45 14             	mov    %eax,0x14(%ebp)
  800d77:	8b 45 14             	mov    0x14(%ebp),%eax
  800d7a:	83 e8 04             	sub    $0x4,%eax
  800d7d:	8b 30                	mov    (%eax),%esi
  800d7f:	85 f6                	test   %esi,%esi
  800d81:	75 05                	jne    800d88 <vprintfmt+0x1a6>
				p = "(null)";
  800d83:	be b1 2a 80 00       	mov    $0x802ab1,%esi
			if (width > 0 && padc != '-')
  800d88:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d8c:	7e 6d                	jle    800dfb <vprintfmt+0x219>
  800d8e:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d92:	74 67                	je     800dfb <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d94:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d97:	83 ec 08             	sub    $0x8,%esp
  800d9a:	50                   	push   %eax
  800d9b:	56                   	push   %esi
  800d9c:	e8 12 05 00 00       	call   8012b3 <strnlen>
  800da1:	83 c4 10             	add    $0x10,%esp
  800da4:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800da7:	eb 16                	jmp    800dbf <vprintfmt+0x1dd>
					putch(padc, putdat);
  800da9:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800dad:	83 ec 08             	sub    $0x8,%esp
  800db0:	ff 75 0c             	pushl  0xc(%ebp)
  800db3:	50                   	push   %eax
  800db4:	8b 45 08             	mov    0x8(%ebp),%eax
  800db7:	ff d0                	call   *%eax
  800db9:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800dbc:	ff 4d e4             	decl   -0x1c(%ebp)
  800dbf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dc3:	7f e4                	jg     800da9 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800dc5:	eb 34                	jmp    800dfb <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800dc7:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800dcb:	74 1c                	je     800de9 <vprintfmt+0x207>
  800dcd:	83 fb 1f             	cmp    $0x1f,%ebx
  800dd0:	7e 05                	jle    800dd7 <vprintfmt+0x1f5>
  800dd2:	83 fb 7e             	cmp    $0x7e,%ebx
  800dd5:	7e 12                	jle    800de9 <vprintfmt+0x207>
					putch('?', putdat);
  800dd7:	83 ec 08             	sub    $0x8,%esp
  800dda:	ff 75 0c             	pushl  0xc(%ebp)
  800ddd:	6a 3f                	push   $0x3f
  800ddf:	8b 45 08             	mov    0x8(%ebp),%eax
  800de2:	ff d0                	call   *%eax
  800de4:	83 c4 10             	add    $0x10,%esp
  800de7:	eb 0f                	jmp    800df8 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800de9:	83 ec 08             	sub    $0x8,%esp
  800dec:	ff 75 0c             	pushl  0xc(%ebp)
  800def:	53                   	push   %ebx
  800df0:	8b 45 08             	mov    0x8(%ebp),%eax
  800df3:	ff d0                	call   *%eax
  800df5:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800df8:	ff 4d e4             	decl   -0x1c(%ebp)
  800dfb:	89 f0                	mov    %esi,%eax
  800dfd:	8d 70 01             	lea    0x1(%eax),%esi
  800e00:	8a 00                	mov    (%eax),%al
  800e02:	0f be d8             	movsbl %al,%ebx
  800e05:	85 db                	test   %ebx,%ebx
  800e07:	74 24                	je     800e2d <vprintfmt+0x24b>
  800e09:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e0d:	78 b8                	js     800dc7 <vprintfmt+0x1e5>
  800e0f:	ff 4d e0             	decl   -0x20(%ebp)
  800e12:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e16:	79 af                	jns    800dc7 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e18:	eb 13                	jmp    800e2d <vprintfmt+0x24b>
				putch(' ', putdat);
  800e1a:	83 ec 08             	sub    $0x8,%esp
  800e1d:	ff 75 0c             	pushl  0xc(%ebp)
  800e20:	6a 20                	push   $0x20
  800e22:	8b 45 08             	mov    0x8(%ebp),%eax
  800e25:	ff d0                	call   *%eax
  800e27:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e2a:	ff 4d e4             	decl   -0x1c(%ebp)
  800e2d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e31:	7f e7                	jg     800e1a <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e33:	e9 66 01 00 00       	jmp    800f9e <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e38:	83 ec 08             	sub    $0x8,%esp
  800e3b:	ff 75 e8             	pushl  -0x18(%ebp)
  800e3e:	8d 45 14             	lea    0x14(%ebp),%eax
  800e41:	50                   	push   %eax
  800e42:	e8 3c fd ff ff       	call   800b83 <getint>
  800e47:	83 c4 10             	add    $0x10,%esp
  800e4a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e4d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e50:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e53:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e56:	85 d2                	test   %edx,%edx
  800e58:	79 23                	jns    800e7d <vprintfmt+0x29b>
				putch('-', putdat);
  800e5a:	83 ec 08             	sub    $0x8,%esp
  800e5d:	ff 75 0c             	pushl  0xc(%ebp)
  800e60:	6a 2d                	push   $0x2d
  800e62:	8b 45 08             	mov    0x8(%ebp),%eax
  800e65:	ff d0                	call   *%eax
  800e67:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e6d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e70:	f7 d8                	neg    %eax
  800e72:	83 d2 00             	adc    $0x0,%edx
  800e75:	f7 da                	neg    %edx
  800e77:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e7a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e7d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e84:	e9 bc 00 00 00       	jmp    800f45 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e89:	83 ec 08             	sub    $0x8,%esp
  800e8c:	ff 75 e8             	pushl  -0x18(%ebp)
  800e8f:	8d 45 14             	lea    0x14(%ebp),%eax
  800e92:	50                   	push   %eax
  800e93:	e8 84 fc ff ff       	call   800b1c <getuint>
  800e98:	83 c4 10             	add    $0x10,%esp
  800e9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e9e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ea1:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ea8:	e9 98 00 00 00       	jmp    800f45 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800ead:	83 ec 08             	sub    $0x8,%esp
  800eb0:	ff 75 0c             	pushl  0xc(%ebp)
  800eb3:	6a 58                	push   $0x58
  800eb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb8:	ff d0                	call   *%eax
  800eba:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ebd:	83 ec 08             	sub    $0x8,%esp
  800ec0:	ff 75 0c             	pushl  0xc(%ebp)
  800ec3:	6a 58                	push   $0x58
  800ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec8:	ff d0                	call   *%eax
  800eca:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ecd:	83 ec 08             	sub    $0x8,%esp
  800ed0:	ff 75 0c             	pushl  0xc(%ebp)
  800ed3:	6a 58                	push   $0x58
  800ed5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed8:	ff d0                	call   *%eax
  800eda:	83 c4 10             	add    $0x10,%esp
			break;
  800edd:	e9 bc 00 00 00       	jmp    800f9e <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ee2:	83 ec 08             	sub    $0x8,%esp
  800ee5:	ff 75 0c             	pushl  0xc(%ebp)
  800ee8:	6a 30                	push   $0x30
  800eea:	8b 45 08             	mov    0x8(%ebp),%eax
  800eed:	ff d0                	call   *%eax
  800eef:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ef2:	83 ec 08             	sub    $0x8,%esp
  800ef5:	ff 75 0c             	pushl  0xc(%ebp)
  800ef8:	6a 78                	push   $0x78
  800efa:	8b 45 08             	mov    0x8(%ebp),%eax
  800efd:	ff d0                	call   *%eax
  800eff:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f02:	8b 45 14             	mov    0x14(%ebp),%eax
  800f05:	83 c0 04             	add    $0x4,%eax
  800f08:	89 45 14             	mov    %eax,0x14(%ebp)
  800f0b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f0e:	83 e8 04             	sub    $0x4,%eax
  800f11:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f13:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f16:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f1d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f24:	eb 1f                	jmp    800f45 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f26:	83 ec 08             	sub    $0x8,%esp
  800f29:	ff 75 e8             	pushl  -0x18(%ebp)
  800f2c:	8d 45 14             	lea    0x14(%ebp),%eax
  800f2f:	50                   	push   %eax
  800f30:	e8 e7 fb ff ff       	call   800b1c <getuint>
  800f35:	83 c4 10             	add    $0x10,%esp
  800f38:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f3b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f3e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f45:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f49:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f4c:	83 ec 04             	sub    $0x4,%esp
  800f4f:	52                   	push   %edx
  800f50:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f53:	50                   	push   %eax
  800f54:	ff 75 f4             	pushl  -0xc(%ebp)
  800f57:	ff 75 f0             	pushl  -0x10(%ebp)
  800f5a:	ff 75 0c             	pushl  0xc(%ebp)
  800f5d:	ff 75 08             	pushl  0x8(%ebp)
  800f60:	e8 00 fb ff ff       	call   800a65 <printnum>
  800f65:	83 c4 20             	add    $0x20,%esp
			break;
  800f68:	eb 34                	jmp    800f9e <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f6a:	83 ec 08             	sub    $0x8,%esp
  800f6d:	ff 75 0c             	pushl  0xc(%ebp)
  800f70:	53                   	push   %ebx
  800f71:	8b 45 08             	mov    0x8(%ebp),%eax
  800f74:	ff d0                	call   *%eax
  800f76:	83 c4 10             	add    $0x10,%esp
			break;
  800f79:	eb 23                	jmp    800f9e <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f7b:	83 ec 08             	sub    $0x8,%esp
  800f7e:	ff 75 0c             	pushl  0xc(%ebp)
  800f81:	6a 25                	push   $0x25
  800f83:	8b 45 08             	mov    0x8(%ebp),%eax
  800f86:	ff d0                	call   *%eax
  800f88:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f8b:	ff 4d 10             	decl   0x10(%ebp)
  800f8e:	eb 03                	jmp    800f93 <vprintfmt+0x3b1>
  800f90:	ff 4d 10             	decl   0x10(%ebp)
  800f93:	8b 45 10             	mov    0x10(%ebp),%eax
  800f96:	48                   	dec    %eax
  800f97:	8a 00                	mov    (%eax),%al
  800f99:	3c 25                	cmp    $0x25,%al
  800f9b:	75 f3                	jne    800f90 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f9d:	90                   	nop
		}
	}
  800f9e:	e9 47 fc ff ff       	jmp    800bea <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800fa3:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800fa4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800fa7:	5b                   	pop    %ebx
  800fa8:	5e                   	pop    %esi
  800fa9:	5d                   	pop    %ebp
  800faa:	c3                   	ret    

00800fab <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800fab:	55                   	push   %ebp
  800fac:	89 e5                	mov    %esp,%ebp
  800fae:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800fb1:	8d 45 10             	lea    0x10(%ebp),%eax
  800fb4:	83 c0 04             	add    $0x4,%eax
  800fb7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800fba:	8b 45 10             	mov    0x10(%ebp),%eax
  800fbd:	ff 75 f4             	pushl  -0xc(%ebp)
  800fc0:	50                   	push   %eax
  800fc1:	ff 75 0c             	pushl  0xc(%ebp)
  800fc4:	ff 75 08             	pushl  0x8(%ebp)
  800fc7:	e8 16 fc ff ff       	call   800be2 <vprintfmt>
  800fcc:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800fcf:	90                   	nop
  800fd0:	c9                   	leave  
  800fd1:	c3                   	ret    

00800fd2 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800fd2:	55                   	push   %ebp
  800fd3:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800fd5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd8:	8b 40 08             	mov    0x8(%eax),%eax
  800fdb:	8d 50 01             	lea    0x1(%eax),%edx
  800fde:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe1:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800fe4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe7:	8b 10                	mov    (%eax),%edx
  800fe9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fec:	8b 40 04             	mov    0x4(%eax),%eax
  800fef:	39 c2                	cmp    %eax,%edx
  800ff1:	73 12                	jae    801005 <sprintputch+0x33>
		*b->buf++ = ch;
  800ff3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff6:	8b 00                	mov    (%eax),%eax
  800ff8:	8d 48 01             	lea    0x1(%eax),%ecx
  800ffb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ffe:	89 0a                	mov    %ecx,(%edx)
  801000:	8b 55 08             	mov    0x8(%ebp),%edx
  801003:	88 10                	mov    %dl,(%eax)
}
  801005:	90                   	nop
  801006:	5d                   	pop    %ebp
  801007:	c3                   	ret    

00801008 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801008:	55                   	push   %ebp
  801009:	89 e5                	mov    %esp,%ebp
  80100b:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80100e:	8b 45 08             	mov    0x8(%ebp),%eax
  801011:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801014:	8b 45 0c             	mov    0xc(%ebp),%eax
  801017:	8d 50 ff             	lea    -0x1(%eax),%edx
  80101a:	8b 45 08             	mov    0x8(%ebp),%eax
  80101d:	01 d0                	add    %edx,%eax
  80101f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801022:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801029:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80102d:	74 06                	je     801035 <vsnprintf+0x2d>
  80102f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801033:	7f 07                	jg     80103c <vsnprintf+0x34>
		return -E_INVAL;
  801035:	b8 03 00 00 00       	mov    $0x3,%eax
  80103a:	eb 20                	jmp    80105c <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80103c:	ff 75 14             	pushl  0x14(%ebp)
  80103f:	ff 75 10             	pushl  0x10(%ebp)
  801042:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801045:	50                   	push   %eax
  801046:	68 d2 0f 80 00       	push   $0x800fd2
  80104b:	e8 92 fb ff ff       	call   800be2 <vprintfmt>
  801050:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801053:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801056:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801059:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80105c:	c9                   	leave  
  80105d:	c3                   	ret    

0080105e <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80105e:	55                   	push   %ebp
  80105f:	89 e5                	mov    %esp,%ebp
  801061:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801064:	8d 45 10             	lea    0x10(%ebp),%eax
  801067:	83 c0 04             	add    $0x4,%eax
  80106a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80106d:	8b 45 10             	mov    0x10(%ebp),%eax
  801070:	ff 75 f4             	pushl  -0xc(%ebp)
  801073:	50                   	push   %eax
  801074:	ff 75 0c             	pushl  0xc(%ebp)
  801077:	ff 75 08             	pushl  0x8(%ebp)
  80107a:	e8 89 ff ff ff       	call   801008 <vsnprintf>
  80107f:	83 c4 10             	add    $0x10,%esp
  801082:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801085:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801088:	c9                   	leave  
  801089:	c3                   	ret    

0080108a <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80108a:	55                   	push   %ebp
  80108b:	89 e5                	mov    %esp,%ebp
  80108d:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801090:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801094:	74 13                	je     8010a9 <readline+0x1f>
		cprintf("%s", prompt);
  801096:	83 ec 08             	sub    $0x8,%esp
  801099:	ff 75 08             	pushl  0x8(%ebp)
  80109c:	68 10 2c 80 00       	push   $0x802c10
  8010a1:	e8 62 f9 ff ff       	call   800a08 <cprintf>
  8010a6:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8010a9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8010b0:	83 ec 0c             	sub    $0xc,%esp
  8010b3:	6a 00                	push   $0x0
  8010b5:	e8 5d f5 ff ff       	call   800617 <iscons>
  8010ba:	83 c4 10             	add    $0x10,%esp
  8010bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8010c0:	e8 04 f5 ff ff       	call   8005c9 <getchar>
  8010c5:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8010c8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8010cc:	79 22                	jns    8010f0 <readline+0x66>
			if (c != -E_EOF)
  8010ce:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8010d2:	0f 84 ad 00 00 00    	je     801185 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8010d8:	83 ec 08             	sub    $0x8,%esp
  8010db:	ff 75 ec             	pushl  -0x14(%ebp)
  8010de:	68 13 2c 80 00       	push   $0x802c13
  8010e3:	e8 20 f9 ff ff       	call   800a08 <cprintf>
  8010e8:	83 c4 10             	add    $0x10,%esp
			return;
  8010eb:	e9 95 00 00 00       	jmp    801185 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8010f0:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8010f4:	7e 34                	jle    80112a <readline+0xa0>
  8010f6:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8010fd:	7f 2b                	jg     80112a <readline+0xa0>
			if (echoing)
  8010ff:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801103:	74 0e                	je     801113 <readline+0x89>
				cputchar(c);
  801105:	83 ec 0c             	sub    $0xc,%esp
  801108:	ff 75 ec             	pushl  -0x14(%ebp)
  80110b:	e8 71 f4 ff ff       	call   800581 <cputchar>
  801110:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801113:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801116:	8d 50 01             	lea    0x1(%eax),%edx
  801119:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80111c:	89 c2                	mov    %eax,%edx
  80111e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801121:	01 d0                	add    %edx,%eax
  801123:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801126:	88 10                	mov    %dl,(%eax)
  801128:	eb 56                	jmp    801180 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  80112a:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80112e:	75 1f                	jne    80114f <readline+0xc5>
  801130:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801134:	7e 19                	jle    80114f <readline+0xc5>
			if (echoing)
  801136:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80113a:	74 0e                	je     80114a <readline+0xc0>
				cputchar(c);
  80113c:	83 ec 0c             	sub    $0xc,%esp
  80113f:	ff 75 ec             	pushl  -0x14(%ebp)
  801142:	e8 3a f4 ff ff       	call   800581 <cputchar>
  801147:	83 c4 10             	add    $0x10,%esp

			i--;
  80114a:	ff 4d f4             	decl   -0xc(%ebp)
  80114d:	eb 31                	jmp    801180 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  80114f:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801153:	74 0a                	je     80115f <readline+0xd5>
  801155:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801159:	0f 85 61 ff ff ff    	jne    8010c0 <readline+0x36>
			if (echoing)
  80115f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801163:	74 0e                	je     801173 <readline+0xe9>
				cputchar(c);
  801165:	83 ec 0c             	sub    $0xc,%esp
  801168:	ff 75 ec             	pushl  -0x14(%ebp)
  80116b:	e8 11 f4 ff ff       	call   800581 <cputchar>
  801170:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801173:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801176:	8b 45 0c             	mov    0xc(%ebp),%eax
  801179:	01 d0                	add    %edx,%eax
  80117b:	c6 00 00             	movb   $0x0,(%eax)
			return;
  80117e:	eb 06                	jmp    801186 <readline+0xfc>
		}
	}
  801180:	e9 3b ff ff ff       	jmp    8010c0 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801185:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801186:	c9                   	leave  
  801187:	c3                   	ret    

00801188 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801188:	55                   	push   %ebp
  801189:	89 e5                	mov    %esp,%ebp
  80118b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80118e:	e8 e2 0c 00 00       	call   801e75 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801193:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801197:	74 13                	je     8011ac <atomic_readline+0x24>
		cprintf("%s", prompt);
  801199:	83 ec 08             	sub    $0x8,%esp
  80119c:	ff 75 08             	pushl  0x8(%ebp)
  80119f:	68 10 2c 80 00       	push   $0x802c10
  8011a4:	e8 5f f8 ff ff       	call   800a08 <cprintf>
  8011a9:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8011ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8011b3:	83 ec 0c             	sub    $0xc,%esp
  8011b6:	6a 00                	push   $0x0
  8011b8:	e8 5a f4 ff ff       	call   800617 <iscons>
  8011bd:	83 c4 10             	add    $0x10,%esp
  8011c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8011c3:	e8 01 f4 ff ff       	call   8005c9 <getchar>
  8011c8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8011cb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8011cf:	79 23                	jns    8011f4 <atomic_readline+0x6c>
			if (c != -E_EOF)
  8011d1:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8011d5:	74 13                	je     8011ea <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  8011d7:	83 ec 08             	sub    $0x8,%esp
  8011da:	ff 75 ec             	pushl  -0x14(%ebp)
  8011dd:	68 13 2c 80 00       	push   $0x802c13
  8011e2:	e8 21 f8 ff ff       	call   800a08 <cprintf>
  8011e7:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8011ea:	e8 a0 0c 00 00       	call   801e8f <sys_enable_interrupt>
			return;
  8011ef:	e9 9a 00 00 00       	jmp    80128e <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8011f4:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8011f8:	7e 34                	jle    80122e <atomic_readline+0xa6>
  8011fa:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801201:	7f 2b                	jg     80122e <atomic_readline+0xa6>
			if (echoing)
  801203:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801207:	74 0e                	je     801217 <atomic_readline+0x8f>
				cputchar(c);
  801209:	83 ec 0c             	sub    $0xc,%esp
  80120c:	ff 75 ec             	pushl  -0x14(%ebp)
  80120f:	e8 6d f3 ff ff       	call   800581 <cputchar>
  801214:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801217:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80121a:	8d 50 01             	lea    0x1(%eax),%edx
  80121d:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801220:	89 c2                	mov    %eax,%edx
  801222:	8b 45 0c             	mov    0xc(%ebp),%eax
  801225:	01 d0                	add    %edx,%eax
  801227:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80122a:	88 10                	mov    %dl,(%eax)
  80122c:	eb 5b                	jmp    801289 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  80122e:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801232:	75 1f                	jne    801253 <atomic_readline+0xcb>
  801234:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801238:	7e 19                	jle    801253 <atomic_readline+0xcb>
			if (echoing)
  80123a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80123e:	74 0e                	je     80124e <atomic_readline+0xc6>
				cputchar(c);
  801240:	83 ec 0c             	sub    $0xc,%esp
  801243:	ff 75 ec             	pushl  -0x14(%ebp)
  801246:	e8 36 f3 ff ff       	call   800581 <cputchar>
  80124b:	83 c4 10             	add    $0x10,%esp
			i--;
  80124e:	ff 4d f4             	decl   -0xc(%ebp)
  801251:	eb 36                	jmp    801289 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  801253:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801257:	74 0a                	je     801263 <atomic_readline+0xdb>
  801259:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80125d:	0f 85 60 ff ff ff    	jne    8011c3 <atomic_readline+0x3b>
			if (echoing)
  801263:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801267:	74 0e                	je     801277 <atomic_readline+0xef>
				cputchar(c);
  801269:	83 ec 0c             	sub    $0xc,%esp
  80126c:	ff 75 ec             	pushl  -0x14(%ebp)
  80126f:	e8 0d f3 ff ff       	call   800581 <cputchar>
  801274:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801277:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80127a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80127d:	01 d0                	add    %edx,%eax
  80127f:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801282:	e8 08 0c 00 00       	call   801e8f <sys_enable_interrupt>
			return;
  801287:	eb 05                	jmp    80128e <atomic_readline+0x106>
		}
	}
  801289:	e9 35 ff ff ff       	jmp    8011c3 <atomic_readline+0x3b>
}
  80128e:	c9                   	leave  
  80128f:	c3                   	ret    

00801290 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801290:	55                   	push   %ebp
  801291:	89 e5                	mov    %esp,%ebp
  801293:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801296:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80129d:	eb 06                	jmp    8012a5 <strlen+0x15>
		n++;
  80129f:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8012a2:	ff 45 08             	incl   0x8(%ebp)
  8012a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a8:	8a 00                	mov    (%eax),%al
  8012aa:	84 c0                	test   %al,%al
  8012ac:	75 f1                	jne    80129f <strlen+0xf>
		n++;
	return n;
  8012ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012b1:	c9                   	leave  
  8012b2:	c3                   	ret    

008012b3 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8012b3:	55                   	push   %ebp
  8012b4:	89 e5                	mov    %esp,%ebp
  8012b6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012b9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012c0:	eb 09                	jmp    8012cb <strnlen+0x18>
		n++;
  8012c2:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012c5:	ff 45 08             	incl   0x8(%ebp)
  8012c8:	ff 4d 0c             	decl   0xc(%ebp)
  8012cb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012cf:	74 09                	je     8012da <strnlen+0x27>
  8012d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d4:	8a 00                	mov    (%eax),%al
  8012d6:	84 c0                	test   %al,%al
  8012d8:	75 e8                	jne    8012c2 <strnlen+0xf>
		n++;
	return n;
  8012da:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012dd:	c9                   	leave  
  8012de:	c3                   	ret    

008012df <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8012df:	55                   	push   %ebp
  8012e0:	89 e5                	mov    %esp,%ebp
  8012e2:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8012e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8012eb:	90                   	nop
  8012ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ef:	8d 50 01             	lea    0x1(%eax),%edx
  8012f2:	89 55 08             	mov    %edx,0x8(%ebp)
  8012f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012f8:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012fb:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012fe:	8a 12                	mov    (%edx),%dl
  801300:	88 10                	mov    %dl,(%eax)
  801302:	8a 00                	mov    (%eax),%al
  801304:	84 c0                	test   %al,%al
  801306:	75 e4                	jne    8012ec <strcpy+0xd>
		/* do nothing */;
	return ret;
  801308:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80130b:	c9                   	leave  
  80130c:	c3                   	ret    

0080130d <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80130d:	55                   	push   %ebp
  80130e:	89 e5                	mov    %esp,%ebp
  801310:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801313:	8b 45 08             	mov    0x8(%ebp),%eax
  801316:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801319:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801320:	eb 1f                	jmp    801341 <strncpy+0x34>
		*dst++ = *src;
  801322:	8b 45 08             	mov    0x8(%ebp),%eax
  801325:	8d 50 01             	lea    0x1(%eax),%edx
  801328:	89 55 08             	mov    %edx,0x8(%ebp)
  80132b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80132e:	8a 12                	mov    (%edx),%dl
  801330:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801332:	8b 45 0c             	mov    0xc(%ebp),%eax
  801335:	8a 00                	mov    (%eax),%al
  801337:	84 c0                	test   %al,%al
  801339:	74 03                	je     80133e <strncpy+0x31>
			src++;
  80133b:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80133e:	ff 45 fc             	incl   -0x4(%ebp)
  801341:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801344:	3b 45 10             	cmp    0x10(%ebp),%eax
  801347:	72 d9                	jb     801322 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801349:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80134c:	c9                   	leave  
  80134d:	c3                   	ret    

0080134e <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80134e:	55                   	push   %ebp
  80134f:	89 e5                	mov    %esp,%ebp
  801351:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801354:	8b 45 08             	mov    0x8(%ebp),%eax
  801357:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80135a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80135e:	74 30                	je     801390 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801360:	eb 16                	jmp    801378 <strlcpy+0x2a>
			*dst++ = *src++;
  801362:	8b 45 08             	mov    0x8(%ebp),%eax
  801365:	8d 50 01             	lea    0x1(%eax),%edx
  801368:	89 55 08             	mov    %edx,0x8(%ebp)
  80136b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80136e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801371:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801374:	8a 12                	mov    (%edx),%dl
  801376:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801378:	ff 4d 10             	decl   0x10(%ebp)
  80137b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80137f:	74 09                	je     80138a <strlcpy+0x3c>
  801381:	8b 45 0c             	mov    0xc(%ebp),%eax
  801384:	8a 00                	mov    (%eax),%al
  801386:	84 c0                	test   %al,%al
  801388:	75 d8                	jne    801362 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80138a:	8b 45 08             	mov    0x8(%ebp),%eax
  80138d:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801390:	8b 55 08             	mov    0x8(%ebp),%edx
  801393:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801396:	29 c2                	sub    %eax,%edx
  801398:	89 d0                	mov    %edx,%eax
}
  80139a:	c9                   	leave  
  80139b:	c3                   	ret    

0080139c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80139c:	55                   	push   %ebp
  80139d:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80139f:	eb 06                	jmp    8013a7 <strcmp+0xb>
		p++, q++;
  8013a1:	ff 45 08             	incl   0x8(%ebp)
  8013a4:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8013a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013aa:	8a 00                	mov    (%eax),%al
  8013ac:	84 c0                	test   %al,%al
  8013ae:	74 0e                	je     8013be <strcmp+0x22>
  8013b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b3:	8a 10                	mov    (%eax),%dl
  8013b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b8:	8a 00                	mov    (%eax),%al
  8013ba:	38 c2                	cmp    %al,%dl
  8013bc:	74 e3                	je     8013a1 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8013be:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c1:	8a 00                	mov    (%eax),%al
  8013c3:	0f b6 d0             	movzbl %al,%edx
  8013c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c9:	8a 00                	mov    (%eax),%al
  8013cb:	0f b6 c0             	movzbl %al,%eax
  8013ce:	29 c2                	sub    %eax,%edx
  8013d0:	89 d0                	mov    %edx,%eax
}
  8013d2:	5d                   	pop    %ebp
  8013d3:	c3                   	ret    

008013d4 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8013d4:	55                   	push   %ebp
  8013d5:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8013d7:	eb 09                	jmp    8013e2 <strncmp+0xe>
		n--, p++, q++;
  8013d9:	ff 4d 10             	decl   0x10(%ebp)
  8013dc:	ff 45 08             	incl   0x8(%ebp)
  8013df:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8013e2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013e6:	74 17                	je     8013ff <strncmp+0x2b>
  8013e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013eb:	8a 00                	mov    (%eax),%al
  8013ed:	84 c0                	test   %al,%al
  8013ef:	74 0e                	je     8013ff <strncmp+0x2b>
  8013f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f4:	8a 10                	mov    (%eax),%dl
  8013f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f9:	8a 00                	mov    (%eax),%al
  8013fb:	38 c2                	cmp    %al,%dl
  8013fd:	74 da                	je     8013d9 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8013ff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801403:	75 07                	jne    80140c <strncmp+0x38>
		return 0;
  801405:	b8 00 00 00 00       	mov    $0x0,%eax
  80140a:	eb 14                	jmp    801420 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80140c:	8b 45 08             	mov    0x8(%ebp),%eax
  80140f:	8a 00                	mov    (%eax),%al
  801411:	0f b6 d0             	movzbl %al,%edx
  801414:	8b 45 0c             	mov    0xc(%ebp),%eax
  801417:	8a 00                	mov    (%eax),%al
  801419:	0f b6 c0             	movzbl %al,%eax
  80141c:	29 c2                	sub    %eax,%edx
  80141e:	89 d0                	mov    %edx,%eax
}
  801420:	5d                   	pop    %ebp
  801421:	c3                   	ret    

00801422 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801422:	55                   	push   %ebp
  801423:	89 e5                	mov    %esp,%ebp
  801425:	83 ec 04             	sub    $0x4,%esp
  801428:	8b 45 0c             	mov    0xc(%ebp),%eax
  80142b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80142e:	eb 12                	jmp    801442 <strchr+0x20>
		if (*s == c)
  801430:	8b 45 08             	mov    0x8(%ebp),%eax
  801433:	8a 00                	mov    (%eax),%al
  801435:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801438:	75 05                	jne    80143f <strchr+0x1d>
			return (char *) s;
  80143a:	8b 45 08             	mov    0x8(%ebp),%eax
  80143d:	eb 11                	jmp    801450 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80143f:	ff 45 08             	incl   0x8(%ebp)
  801442:	8b 45 08             	mov    0x8(%ebp),%eax
  801445:	8a 00                	mov    (%eax),%al
  801447:	84 c0                	test   %al,%al
  801449:	75 e5                	jne    801430 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80144b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801450:	c9                   	leave  
  801451:	c3                   	ret    

00801452 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801452:	55                   	push   %ebp
  801453:	89 e5                	mov    %esp,%ebp
  801455:	83 ec 04             	sub    $0x4,%esp
  801458:	8b 45 0c             	mov    0xc(%ebp),%eax
  80145b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80145e:	eb 0d                	jmp    80146d <strfind+0x1b>
		if (*s == c)
  801460:	8b 45 08             	mov    0x8(%ebp),%eax
  801463:	8a 00                	mov    (%eax),%al
  801465:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801468:	74 0e                	je     801478 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80146a:	ff 45 08             	incl   0x8(%ebp)
  80146d:	8b 45 08             	mov    0x8(%ebp),%eax
  801470:	8a 00                	mov    (%eax),%al
  801472:	84 c0                	test   %al,%al
  801474:	75 ea                	jne    801460 <strfind+0xe>
  801476:	eb 01                	jmp    801479 <strfind+0x27>
		if (*s == c)
			break;
  801478:	90                   	nop
	return (char *) s;
  801479:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80147c:	c9                   	leave  
  80147d:	c3                   	ret    

0080147e <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80147e:	55                   	push   %ebp
  80147f:	89 e5                	mov    %esp,%ebp
  801481:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801484:	8b 45 08             	mov    0x8(%ebp),%eax
  801487:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80148a:	8b 45 10             	mov    0x10(%ebp),%eax
  80148d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801490:	eb 0e                	jmp    8014a0 <memset+0x22>
		*p++ = c;
  801492:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801495:	8d 50 01             	lea    0x1(%eax),%edx
  801498:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80149b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80149e:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8014a0:	ff 4d f8             	decl   -0x8(%ebp)
  8014a3:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8014a7:	79 e9                	jns    801492 <memset+0x14>
		*p++ = c;

	return v;
  8014a9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014ac:	c9                   	leave  
  8014ad:	c3                   	ret    

008014ae <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8014ae:	55                   	push   %ebp
  8014af:	89 e5                	mov    %esp,%ebp
  8014b1:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8014c0:	eb 16                	jmp    8014d8 <memcpy+0x2a>
		*d++ = *s++;
  8014c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014c5:	8d 50 01             	lea    0x1(%eax),%edx
  8014c8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014cb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014ce:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014d1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014d4:	8a 12                	mov    (%edx),%dl
  8014d6:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8014d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8014db:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014de:	89 55 10             	mov    %edx,0x10(%ebp)
  8014e1:	85 c0                	test   %eax,%eax
  8014e3:	75 dd                	jne    8014c2 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8014e5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014e8:	c9                   	leave  
  8014e9:	c3                   	ret    

008014ea <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8014ea:	55                   	push   %ebp
  8014eb:	89 e5                	mov    %esp,%ebp
  8014ed:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014ff:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801502:	73 50                	jae    801554 <memmove+0x6a>
  801504:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801507:	8b 45 10             	mov    0x10(%ebp),%eax
  80150a:	01 d0                	add    %edx,%eax
  80150c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80150f:	76 43                	jbe    801554 <memmove+0x6a>
		s += n;
  801511:	8b 45 10             	mov    0x10(%ebp),%eax
  801514:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801517:	8b 45 10             	mov    0x10(%ebp),%eax
  80151a:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80151d:	eb 10                	jmp    80152f <memmove+0x45>
			*--d = *--s;
  80151f:	ff 4d f8             	decl   -0x8(%ebp)
  801522:	ff 4d fc             	decl   -0x4(%ebp)
  801525:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801528:	8a 10                	mov    (%eax),%dl
  80152a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80152d:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80152f:	8b 45 10             	mov    0x10(%ebp),%eax
  801532:	8d 50 ff             	lea    -0x1(%eax),%edx
  801535:	89 55 10             	mov    %edx,0x10(%ebp)
  801538:	85 c0                	test   %eax,%eax
  80153a:	75 e3                	jne    80151f <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80153c:	eb 23                	jmp    801561 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80153e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801541:	8d 50 01             	lea    0x1(%eax),%edx
  801544:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801547:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80154a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80154d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801550:	8a 12                	mov    (%edx),%dl
  801552:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801554:	8b 45 10             	mov    0x10(%ebp),%eax
  801557:	8d 50 ff             	lea    -0x1(%eax),%edx
  80155a:	89 55 10             	mov    %edx,0x10(%ebp)
  80155d:	85 c0                	test   %eax,%eax
  80155f:	75 dd                	jne    80153e <memmove+0x54>
			*d++ = *s++;

	return dst;
  801561:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801564:	c9                   	leave  
  801565:	c3                   	ret    

00801566 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801566:	55                   	push   %ebp
  801567:	89 e5                	mov    %esp,%ebp
  801569:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80156c:	8b 45 08             	mov    0x8(%ebp),%eax
  80156f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801572:	8b 45 0c             	mov    0xc(%ebp),%eax
  801575:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801578:	eb 2a                	jmp    8015a4 <memcmp+0x3e>
		if (*s1 != *s2)
  80157a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80157d:	8a 10                	mov    (%eax),%dl
  80157f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801582:	8a 00                	mov    (%eax),%al
  801584:	38 c2                	cmp    %al,%dl
  801586:	74 16                	je     80159e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801588:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80158b:	8a 00                	mov    (%eax),%al
  80158d:	0f b6 d0             	movzbl %al,%edx
  801590:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801593:	8a 00                	mov    (%eax),%al
  801595:	0f b6 c0             	movzbl %al,%eax
  801598:	29 c2                	sub    %eax,%edx
  80159a:	89 d0                	mov    %edx,%eax
  80159c:	eb 18                	jmp    8015b6 <memcmp+0x50>
		s1++, s2++;
  80159e:	ff 45 fc             	incl   -0x4(%ebp)
  8015a1:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8015a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8015a7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015aa:	89 55 10             	mov    %edx,0x10(%ebp)
  8015ad:	85 c0                	test   %eax,%eax
  8015af:	75 c9                	jne    80157a <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8015b1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015b6:	c9                   	leave  
  8015b7:	c3                   	ret    

008015b8 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8015b8:	55                   	push   %ebp
  8015b9:	89 e5                	mov    %esp,%ebp
  8015bb:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8015be:	8b 55 08             	mov    0x8(%ebp),%edx
  8015c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c4:	01 d0                	add    %edx,%eax
  8015c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8015c9:	eb 15                	jmp    8015e0 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8015cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ce:	8a 00                	mov    (%eax),%al
  8015d0:	0f b6 d0             	movzbl %al,%edx
  8015d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d6:	0f b6 c0             	movzbl %al,%eax
  8015d9:	39 c2                	cmp    %eax,%edx
  8015db:	74 0d                	je     8015ea <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8015dd:	ff 45 08             	incl   0x8(%ebp)
  8015e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015e6:	72 e3                	jb     8015cb <memfind+0x13>
  8015e8:	eb 01                	jmp    8015eb <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8015ea:	90                   	nop
	return (void *) s;
  8015eb:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015ee:	c9                   	leave  
  8015ef:	c3                   	ret    

008015f0 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8015f0:	55                   	push   %ebp
  8015f1:	89 e5                	mov    %esp,%ebp
  8015f3:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8015f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8015fd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801604:	eb 03                	jmp    801609 <strtol+0x19>
		s++;
  801606:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801609:	8b 45 08             	mov    0x8(%ebp),%eax
  80160c:	8a 00                	mov    (%eax),%al
  80160e:	3c 20                	cmp    $0x20,%al
  801610:	74 f4                	je     801606 <strtol+0x16>
  801612:	8b 45 08             	mov    0x8(%ebp),%eax
  801615:	8a 00                	mov    (%eax),%al
  801617:	3c 09                	cmp    $0x9,%al
  801619:	74 eb                	je     801606 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80161b:	8b 45 08             	mov    0x8(%ebp),%eax
  80161e:	8a 00                	mov    (%eax),%al
  801620:	3c 2b                	cmp    $0x2b,%al
  801622:	75 05                	jne    801629 <strtol+0x39>
		s++;
  801624:	ff 45 08             	incl   0x8(%ebp)
  801627:	eb 13                	jmp    80163c <strtol+0x4c>
	else if (*s == '-')
  801629:	8b 45 08             	mov    0x8(%ebp),%eax
  80162c:	8a 00                	mov    (%eax),%al
  80162e:	3c 2d                	cmp    $0x2d,%al
  801630:	75 0a                	jne    80163c <strtol+0x4c>
		s++, neg = 1;
  801632:	ff 45 08             	incl   0x8(%ebp)
  801635:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80163c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801640:	74 06                	je     801648 <strtol+0x58>
  801642:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801646:	75 20                	jne    801668 <strtol+0x78>
  801648:	8b 45 08             	mov    0x8(%ebp),%eax
  80164b:	8a 00                	mov    (%eax),%al
  80164d:	3c 30                	cmp    $0x30,%al
  80164f:	75 17                	jne    801668 <strtol+0x78>
  801651:	8b 45 08             	mov    0x8(%ebp),%eax
  801654:	40                   	inc    %eax
  801655:	8a 00                	mov    (%eax),%al
  801657:	3c 78                	cmp    $0x78,%al
  801659:	75 0d                	jne    801668 <strtol+0x78>
		s += 2, base = 16;
  80165b:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80165f:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801666:	eb 28                	jmp    801690 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801668:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80166c:	75 15                	jne    801683 <strtol+0x93>
  80166e:	8b 45 08             	mov    0x8(%ebp),%eax
  801671:	8a 00                	mov    (%eax),%al
  801673:	3c 30                	cmp    $0x30,%al
  801675:	75 0c                	jne    801683 <strtol+0x93>
		s++, base = 8;
  801677:	ff 45 08             	incl   0x8(%ebp)
  80167a:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801681:	eb 0d                	jmp    801690 <strtol+0xa0>
	else if (base == 0)
  801683:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801687:	75 07                	jne    801690 <strtol+0xa0>
		base = 10;
  801689:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801690:	8b 45 08             	mov    0x8(%ebp),%eax
  801693:	8a 00                	mov    (%eax),%al
  801695:	3c 2f                	cmp    $0x2f,%al
  801697:	7e 19                	jle    8016b2 <strtol+0xc2>
  801699:	8b 45 08             	mov    0x8(%ebp),%eax
  80169c:	8a 00                	mov    (%eax),%al
  80169e:	3c 39                	cmp    $0x39,%al
  8016a0:	7f 10                	jg     8016b2 <strtol+0xc2>
			dig = *s - '0';
  8016a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a5:	8a 00                	mov    (%eax),%al
  8016a7:	0f be c0             	movsbl %al,%eax
  8016aa:	83 e8 30             	sub    $0x30,%eax
  8016ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016b0:	eb 42                	jmp    8016f4 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8016b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b5:	8a 00                	mov    (%eax),%al
  8016b7:	3c 60                	cmp    $0x60,%al
  8016b9:	7e 19                	jle    8016d4 <strtol+0xe4>
  8016bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016be:	8a 00                	mov    (%eax),%al
  8016c0:	3c 7a                	cmp    $0x7a,%al
  8016c2:	7f 10                	jg     8016d4 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8016c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c7:	8a 00                	mov    (%eax),%al
  8016c9:	0f be c0             	movsbl %al,%eax
  8016cc:	83 e8 57             	sub    $0x57,%eax
  8016cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016d2:	eb 20                	jmp    8016f4 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8016d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d7:	8a 00                	mov    (%eax),%al
  8016d9:	3c 40                	cmp    $0x40,%al
  8016db:	7e 39                	jle    801716 <strtol+0x126>
  8016dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e0:	8a 00                	mov    (%eax),%al
  8016e2:	3c 5a                	cmp    $0x5a,%al
  8016e4:	7f 30                	jg     801716 <strtol+0x126>
			dig = *s - 'A' + 10;
  8016e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e9:	8a 00                	mov    (%eax),%al
  8016eb:	0f be c0             	movsbl %al,%eax
  8016ee:	83 e8 37             	sub    $0x37,%eax
  8016f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8016f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016f7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016fa:	7d 19                	jge    801715 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016fc:	ff 45 08             	incl   0x8(%ebp)
  8016ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801702:	0f af 45 10          	imul   0x10(%ebp),%eax
  801706:	89 c2                	mov    %eax,%edx
  801708:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80170b:	01 d0                	add    %edx,%eax
  80170d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801710:	e9 7b ff ff ff       	jmp    801690 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801715:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801716:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80171a:	74 08                	je     801724 <strtol+0x134>
		*endptr = (char *) s;
  80171c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80171f:	8b 55 08             	mov    0x8(%ebp),%edx
  801722:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801724:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801728:	74 07                	je     801731 <strtol+0x141>
  80172a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80172d:	f7 d8                	neg    %eax
  80172f:	eb 03                	jmp    801734 <strtol+0x144>
  801731:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801734:	c9                   	leave  
  801735:	c3                   	ret    

00801736 <ltostr>:

void
ltostr(long value, char *str)
{
  801736:	55                   	push   %ebp
  801737:	89 e5                	mov    %esp,%ebp
  801739:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80173c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801743:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80174a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80174e:	79 13                	jns    801763 <ltostr+0x2d>
	{
		neg = 1;
  801750:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801757:	8b 45 0c             	mov    0xc(%ebp),%eax
  80175a:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80175d:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801760:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801763:	8b 45 08             	mov    0x8(%ebp),%eax
  801766:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80176b:	99                   	cltd   
  80176c:	f7 f9                	idiv   %ecx
  80176e:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801771:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801774:	8d 50 01             	lea    0x1(%eax),%edx
  801777:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80177a:	89 c2                	mov    %eax,%edx
  80177c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80177f:	01 d0                	add    %edx,%eax
  801781:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801784:	83 c2 30             	add    $0x30,%edx
  801787:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801789:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80178c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801791:	f7 e9                	imul   %ecx
  801793:	c1 fa 02             	sar    $0x2,%edx
  801796:	89 c8                	mov    %ecx,%eax
  801798:	c1 f8 1f             	sar    $0x1f,%eax
  80179b:	29 c2                	sub    %eax,%edx
  80179d:	89 d0                	mov    %edx,%eax
  80179f:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8017a2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017a5:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017aa:	f7 e9                	imul   %ecx
  8017ac:	c1 fa 02             	sar    $0x2,%edx
  8017af:	89 c8                	mov    %ecx,%eax
  8017b1:	c1 f8 1f             	sar    $0x1f,%eax
  8017b4:	29 c2                	sub    %eax,%edx
  8017b6:	89 d0                	mov    %edx,%eax
  8017b8:	c1 e0 02             	shl    $0x2,%eax
  8017bb:	01 d0                	add    %edx,%eax
  8017bd:	01 c0                	add    %eax,%eax
  8017bf:	29 c1                	sub    %eax,%ecx
  8017c1:	89 ca                	mov    %ecx,%edx
  8017c3:	85 d2                	test   %edx,%edx
  8017c5:	75 9c                	jne    801763 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8017c7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8017ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017d1:	48                   	dec    %eax
  8017d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8017d5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017d9:	74 3d                	je     801818 <ltostr+0xe2>
		start = 1 ;
  8017db:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017e2:	eb 34                	jmp    801818 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8017e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ea:	01 d0                	add    %edx,%eax
  8017ec:	8a 00                	mov    (%eax),%al
  8017ee:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8017f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017f7:	01 c2                	add    %eax,%edx
  8017f9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ff:	01 c8                	add    %ecx,%eax
  801801:	8a 00                	mov    (%eax),%al
  801803:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801805:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801808:	8b 45 0c             	mov    0xc(%ebp),%eax
  80180b:	01 c2                	add    %eax,%edx
  80180d:	8a 45 eb             	mov    -0x15(%ebp),%al
  801810:	88 02                	mov    %al,(%edx)
		start++ ;
  801812:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801815:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801818:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80181b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80181e:	7c c4                	jl     8017e4 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801820:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801823:	8b 45 0c             	mov    0xc(%ebp),%eax
  801826:	01 d0                	add    %edx,%eax
  801828:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80182b:	90                   	nop
  80182c:	c9                   	leave  
  80182d:	c3                   	ret    

0080182e <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80182e:	55                   	push   %ebp
  80182f:	89 e5                	mov    %esp,%ebp
  801831:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801834:	ff 75 08             	pushl  0x8(%ebp)
  801837:	e8 54 fa ff ff       	call   801290 <strlen>
  80183c:	83 c4 04             	add    $0x4,%esp
  80183f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801842:	ff 75 0c             	pushl  0xc(%ebp)
  801845:	e8 46 fa ff ff       	call   801290 <strlen>
  80184a:	83 c4 04             	add    $0x4,%esp
  80184d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801850:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801857:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80185e:	eb 17                	jmp    801877 <strcconcat+0x49>
		final[s] = str1[s] ;
  801860:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801863:	8b 45 10             	mov    0x10(%ebp),%eax
  801866:	01 c2                	add    %eax,%edx
  801868:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80186b:	8b 45 08             	mov    0x8(%ebp),%eax
  80186e:	01 c8                	add    %ecx,%eax
  801870:	8a 00                	mov    (%eax),%al
  801872:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801874:	ff 45 fc             	incl   -0x4(%ebp)
  801877:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80187a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80187d:	7c e1                	jl     801860 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80187f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801886:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80188d:	eb 1f                	jmp    8018ae <strcconcat+0x80>
		final[s++] = str2[i] ;
  80188f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801892:	8d 50 01             	lea    0x1(%eax),%edx
  801895:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801898:	89 c2                	mov    %eax,%edx
  80189a:	8b 45 10             	mov    0x10(%ebp),%eax
  80189d:	01 c2                	add    %eax,%edx
  80189f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8018a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a5:	01 c8                	add    %ecx,%eax
  8018a7:	8a 00                	mov    (%eax),%al
  8018a9:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8018ab:	ff 45 f8             	incl   -0x8(%ebp)
  8018ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018b1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018b4:	7c d9                	jl     80188f <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8018b6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8018bc:	01 d0                	add    %edx,%eax
  8018be:	c6 00 00             	movb   $0x0,(%eax)
}
  8018c1:	90                   	nop
  8018c2:	c9                   	leave  
  8018c3:	c3                   	ret    

008018c4 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8018c4:	55                   	push   %ebp
  8018c5:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8018c7:	8b 45 14             	mov    0x14(%ebp),%eax
  8018ca:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8018d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8018d3:	8b 00                	mov    (%eax),%eax
  8018d5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8018df:	01 d0                	add    %edx,%eax
  8018e1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018e7:	eb 0c                	jmp    8018f5 <strsplit+0x31>
			*string++ = 0;
  8018e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ec:	8d 50 01             	lea    0x1(%eax),%edx
  8018ef:	89 55 08             	mov    %edx,0x8(%ebp)
  8018f2:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f8:	8a 00                	mov    (%eax),%al
  8018fa:	84 c0                	test   %al,%al
  8018fc:	74 18                	je     801916 <strsplit+0x52>
  8018fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801901:	8a 00                	mov    (%eax),%al
  801903:	0f be c0             	movsbl %al,%eax
  801906:	50                   	push   %eax
  801907:	ff 75 0c             	pushl  0xc(%ebp)
  80190a:	e8 13 fb ff ff       	call   801422 <strchr>
  80190f:	83 c4 08             	add    $0x8,%esp
  801912:	85 c0                	test   %eax,%eax
  801914:	75 d3                	jne    8018e9 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801916:	8b 45 08             	mov    0x8(%ebp),%eax
  801919:	8a 00                	mov    (%eax),%al
  80191b:	84 c0                	test   %al,%al
  80191d:	74 5a                	je     801979 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80191f:	8b 45 14             	mov    0x14(%ebp),%eax
  801922:	8b 00                	mov    (%eax),%eax
  801924:	83 f8 0f             	cmp    $0xf,%eax
  801927:	75 07                	jne    801930 <strsplit+0x6c>
		{
			return 0;
  801929:	b8 00 00 00 00       	mov    $0x0,%eax
  80192e:	eb 66                	jmp    801996 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801930:	8b 45 14             	mov    0x14(%ebp),%eax
  801933:	8b 00                	mov    (%eax),%eax
  801935:	8d 48 01             	lea    0x1(%eax),%ecx
  801938:	8b 55 14             	mov    0x14(%ebp),%edx
  80193b:	89 0a                	mov    %ecx,(%edx)
  80193d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801944:	8b 45 10             	mov    0x10(%ebp),%eax
  801947:	01 c2                	add    %eax,%edx
  801949:	8b 45 08             	mov    0x8(%ebp),%eax
  80194c:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80194e:	eb 03                	jmp    801953 <strsplit+0x8f>
			string++;
  801950:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801953:	8b 45 08             	mov    0x8(%ebp),%eax
  801956:	8a 00                	mov    (%eax),%al
  801958:	84 c0                	test   %al,%al
  80195a:	74 8b                	je     8018e7 <strsplit+0x23>
  80195c:	8b 45 08             	mov    0x8(%ebp),%eax
  80195f:	8a 00                	mov    (%eax),%al
  801961:	0f be c0             	movsbl %al,%eax
  801964:	50                   	push   %eax
  801965:	ff 75 0c             	pushl  0xc(%ebp)
  801968:	e8 b5 fa ff ff       	call   801422 <strchr>
  80196d:	83 c4 08             	add    $0x8,%esp
  801970:	85 c0                	test   %eax,%eax
  801972:	74 dc                	je     801950 <strsplit+0x8c>
			string++;
	}
  801974:	e9 6e ff ff ff       	jmp    8018e7 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801979:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80197a:	8b 45 14             	mov    0x14(%ebp),%eax
  80197d:	8b 00                	mov    (%eax),%eax
  80197f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801986:	8b 45 10             	mov    0x10(%ebp),%eax
  801989:	01 d0                	add    %edx,%eax
  80198b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801991:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801996:	c9                   	leave  
  801997:	c3                   	ret    

00801998 <malloc>:
int changes=0;
int sizeofarray=0;
uint32 addresses[100];
int changed[100];
void* malloc(uint32 size)
{
  801998:	55                   	push   %ebp
  801999:	89 e5                	mov    %esp,%ebp
  80199b:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  80199e:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a1:	c1 e8 0c             	shr    $0xc,%eax
  8019a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;
		if(size%PAGE_SIZE!=0)
  8019a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019aa:	25 ff 0f 00 00       	and    $0xfff,%eax
  8019af:	85 c0                	test   %eax,%eax
  8019b1:	74 03                	je     8019b6 <malloc+0x1e>
			num++;
  8019b3:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  8019b6:	a1 04 30 80 00       	mov    0x803004,%eax
  8019bb:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  8019c0:	75 64                	jne    801a26 <malloc+0x8e>
		{
			sys_allocateMem(USER_HEAP_START,size);
  8019c2:	83 ec 08             	sub    $0x8,%esp
  8019c5:	ff 75 08             	pushl  0x8(%ebp)
  8019c8:	68 00 00 00 80       	push   $0x80000000
  8019cd:	e8 3a 04 00 00       	call   801e0c <sys_allocateMem>
  8019d2:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  8019d5:	a1 04 30 80 00       	mov    0x803004,%eax
  8019da:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  8019dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019e0:	c1 e0 0c             	shl    $0xc,%eax
  8019e3:	89 c2                	mov    %eax,%edx
  8019e5:	a1 04 30 80 00       	mov    0x803004,%eax
  8019ea:	01 d0                	add    %edx,%eax
  8019ec:	a3 04 30 80 00       	mov    %eax,0x803004
			addresses[sizeofarray]=last_addres;
  8019f1:	a1 30 30 80 00       	mov    0x803030,%eax
  8019f6:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8019fc:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  801a03:	a1 30 30 80 00       	mov    0x803030,%eax
  801a08:	c7 04 85 c0 32 80 00 	movl   $0x1,0x8032c0(,%eax,4)
  801a0f:	01 00 00 00 
			sizeofarray++;
  801a13:	a1 30 30 80 00       	mov    0x803030,%eax
  801a18:	40                   	inc    %eax
  801a19:	a3 30 30 80 00       	mov    %eax,0x803030
			return (void*)return_addres;
  801a1e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801a21:	e9 26 01 00 00       	jmp    801b4c <malloc+0x1b4>
		}
		else
		{
			if(changes==0)
  801a26:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801a2b:	85 c0                	test   %eax,%eax
  801a2d:	75 62                	jne    801a91 <malloc+0xf9>
			{
				sys_allocateMem(last_addres,size);
  801a2f:	a1 04 30 80 00       	mov    0x803004,%eax
  801a34:	83 ec 08             	sub    $0x8,%esp
  801a37:	ff 75 08             	pushl  0x8(%ebp)
  801a3a:	50                   	push   %eax
  801a3b:	e8 cc 03 00 00       	call   801e0c <sys_allocateMem>
  801a40:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  801a43:	a1 04 30 80 00       	mov    0x803004,%eax
  801a48:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  801a4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a4e:	c1 e0 0c             	shl    $0xc,%eax
  801a51:	89 c2                	mov    %eax,%edx
  801a53:	a1 04 30 80 00       	mov    0x803004,%eax
  801a58:	01 d0                	add    %edx,%eax
  801a5a:	a3 04 30 80 00       	mov    %eax,0x803004
				addresses[sizeofarray]=return_addres;
  801a5f:	a1 30 30 80 00       	mov    0x803030,%eax
  801a64:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801a67:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801a6e:	a1 30 30 80 00       	mov    0x803030,%eax
  801a73:	c7 04 85 c0 32 80 00 	movl   $0x1,0x8032c0(,%eax,4)
  801a7a:	01 00 00 00 
				sizeofarray++;
  801a7e:	a1 30 30 80 00       	mov    0x803030,%eax
  801a83:	40                   	inc    %eax
  801a84:	a3 30 30 80 00       	mov    %eax,0x803030
				return (void*)return_addres;
  801a89:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801a8c:	e9 bb 00 00 00       	jmp    801b4c <malloc+0x1b4>
			}
			else{
				int count=0;
  801a91:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801a98:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  801a9f:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801aa6:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801aad:	eb 7c                	jmp    801b2b <malloc+0x193>
				{
					uint32 *pg=NULL;
  801aaf:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  801ab6:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801abd:	eb 1a                	jmp    801ad9 <malloc+0x141>
					{
						if(addresses[j]==i)
  801abf:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801ac2:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801ac9:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801acc:	75 08                	jne    801ad6 <malloc+0x13e>
						{
							index=j;
  801ace:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801ad1:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  801ad4:	eb 0d                	jmp    801ae3 <malloc+0x14b>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801ad6:	ff 45 dc             	incl   -0x24(%ebp)
  801ad9:	a1 30 30 80 00       	mov    0x803030,%eax
  801ade:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801ae1:	7c dc                	jl     801abf <malloc+0x127>
							index=j;
							break;
						}
					}

					if(index==-1)
  801ae3:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801ae7:	75 05                	jne    801aee <malloc+0x156>
					{
						count++;
  801ae9:	ff 45 f0             	incl   -0x10(%ebp)
  801aec:	eb 36                	jmp    801b24 <malloc+0x18c>
					}
					else
					{
						if(changed[index]==0)
  801aee:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801af1:	8b 04 85 c0 32 80 00 	mov    0x8032c0(,%eax,4),%eax
  801af8:	85 c0                	test   %eax,%eax
  801afa:	75 05                	jne    801b01 <malloc+0x169>
						{
							count++;
  801afc:	ff 45 f0             	incl   -0x10(%ebp)
  801aff:	eb 23                	jmp    801b24 <malloc+0x18c>
						}
						else
						{
							if(count<min&&count>=num)
  801b01:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b04:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801b07:	7d 14                	jge    801b1d <malloc+0x185>
  801b09:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b0c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801b0f:	7c 0c                	jl     801b1d <malloc+0x185>
							{
								min=count;
  801b11:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b14:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801b17:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801b1a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  801b1d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801b24:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801b2b:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801b32:	0f 86 77 ff ff ff    	jbe    801aaf <malloc+0x117>

					}

					}

				sys_allocateMem(min_addresss,size);
  801b38:	83 ec 08             	sub    $0x8,%esp
  801b3b:	ff 75 08             	pushl  0x8(%ebp)
  801b3e:	ff 75 e4             	pushl  -0x1c(%ebp)
  801b41:	e8 c6 02 00 00       	call   801e0c <sys_allocateMem>
  801b46:	83 c4 10             	add    $0x10,%esp

				return(void*) min_addresss;
  801b49:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801b4c:	c9                   	leave  
  801b4d:	c3                   	ret    

00801b4e <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801b4e:	55                   	push   %ebp
  801b4f:	89 e5                	mov    %esp,%ebp
  801b51:	83 ec 08             	sub    $0x8,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801b54:	83 ec 04             	sub    $0x4,%esp
  801b57:	68 24 2c 80 00       	push   $0x802c24
  801b5c:	6a 7b                	push   $0x7b
  801b5e:	68 47 2c 80 00       	push   $0x802c47
  801b63:	e8 fe eb ff ff       	call   800766 <_panic>

00801b68 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801b68:	55                   	push   %ebp
  801b69:	89 e5                	mov    %esp,%ebp
  801b6b:	83 ec 18             	sub    $0x18,%esp
  801b6e:	8b 45 10             	mov    0x10(%ebp),%eax
  801b71:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801b74:	83 ec 04             	sub    $0x4,%esp
  801b77:	68 54 2c 80 00       	push   $0x802c54
  801b7c:	68 88 00 00 00       	push   $0x88
  801b81:	68 47 2c 80 00       	push   $0x802c47
  801b86:	e8 db eb ff ff       	call   800766 <_panic>

00801b8b <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801b8b:	55                   	push   %ebp
  801b8c:	89 e5                	mov    %esp,%ebp
  801b8e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b91:	83 ec 04             	sub    $0x4,%esp
  801b94:	68 54 2c 80 00       	push   $0x802c54
  801b99:	68 8e 00 00 00       	push   $0x8e
  801b9e:	68 47 2c 80 00       	push   $0x802c47
  801ba3:	e8 be eb ff ff       	call   800766 <_panic>

00801ba8 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801ba8:	55                   	push   %ebp
  801ba9:	89 e5                	mov    %esp,%ebp
  801bab:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bae:	83 ec 04             	sub    $0x4,%esp
  801bb1:	68 54 2c 80 00       	push   $0x802c54
  801bb6:	68 94 00 00 00       	push   $0x94
  801bbb:	68 47 2c 80 00       	push   $0x802c47
  801bc0:	e8 a1 eb ff ff       	call   800766 <_panic>

00801bc5 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801bc5:	55                   	push   %ebp
  801bc6:	89 e5                	mov    %esp,%ebp
  801bc8:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bcb:	83 ec 04             	sub    $0x4,%esp
  801bce:	68 54 2c 80 00       	push   $0x802c54
  801bd3:	68 99 00 00 00       	push   $0x99
  801bd8:	68 47 2c 80 00       	push   $0x802c47
  801bdd:	e8 84 eb ff ff       	call   800766 <_panic>

00801be2 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801be2:	55                   	push   %ebp
  801be3:	89 e5                	mov    %esp,%ebp
  801be5:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801be8:	83 ec 04             	sub    $0x4,%esp
  801beb:	68 54 2c 80 00       	push   $0x802c54
  801bf0:	68 9f 00 00 00       	push   $0x9f
  801bf5:	68 47 2c 80 00       	push   $0x802c47
  801bfa:	e8 67 eb ff ff       	call   800766 <_panic>

00801bff <shrink>:
}
void shrink(uint32 newSize)
{
  801bff:	55                   	push   %ebp
  801c00:	89 e5                	mov    %esp,%ebp
  801c02:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c05:	83 ec 04             	sub    $0x4,%esp
  801c08:	68 54 2c 80 00       	push   $0x802c54
  801c0d:	68 a3 00 00 00       	push   $0xa3
  801c12:	68 47 2c 80 00       	push   $0x802c47
  801c17:	e8 4a eb ff ff       	call   800766 <_panic>

00801c1c <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801c1c:	55                   	push   %ebp
  801c1d:	89 e5                	mov    %esp,%ebp
  801c1f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c22:	83 ec 04             	sub    $0x4,%esp
  801c25:	68 54 2c 80 00       	push   $0x802c54
  801c2a:	68 a8 00 00 00       	push   $0xa8
  801c2f:	68 47 2c 80 00       	push   $0x802c47
  801c34:	e8 2d eb ff ff       	call   800766 <_panic>

00801c39 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801c39:	55                   	push   %ebp
  801c3a:	89 e5                	mov    %esp,%ebp
  801c3c:	57                   	push   %edi
  801c3d:	56                   	push   %esi
  801c3e:	53                   	push   %ebx
  801c3f:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801c42:	8b 45 08             	mov    0x8(%ebp),%eax
  801c45:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c48:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c4b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c4e:	8b 7d 18             	mov    0x18(%ebp),%edi
  801c51:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801c54:	cd 30                	int    $0x30
  801c56:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801c59:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801c5c:	83 c4 10             	add    $0x10,%esp
  801c5f:	5b                   	pop    %ebx
  801c60:	5e                   	pop    %esi
  801c61:	5f                   	pop    %edi
  801c62:	5d                   	pop    %ebp
  801c63:	c3                   	ret    

00801c64 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801c64:	55                   	push   %ebp
  801c65:	89 e5                	mov    %esp,%ebp
  801c67:	83 ec 04             	sub    $0x4,%esp
  801c6a:	8b 45 10             	mov    0x10(%ebp),%eax
  801c6d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801c70:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c74:	8b 45 08             	mov    0x8(%ebp),%eax
  801c77:	6a 00                	push   $0x0
  801c79:	6a 00                	push   $0x0
  801c7b:	52                   	push   %edx
  801c7c:	ff 75 0c             	pushl  0xc(%ebp)
  801c7f:	50                   	push   %eax
  801c80:	6a 00                	push   $0x0
  801c82:	e8 b2 ff ff ff       	call   801c39 <syscall>
  801c87:	83 c4 18             	add    $0x18,%esp
}
  801c8a:	90                   	nop
  801c8b:	c9                   	leave  
  801c8c:	c3                   	ret    

00801c8d <sys_cgetc>:

int
sys_cgetc(void)
{
  801c8d:	55                   	push   %ebp
  801c8e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801c90:	6a 00                	push   $0x0
  801c92:	6a 00                	push   $0x0
  801c94:	6a 00                	push   $0x0
  801c96:	6a 00                	push   $0x0
  801c98:	6a 00                	push   $0x0
  801c9a:	6a 01                	push   $0x1
  801c9c:	e8 98 ff ff ff       	call   801c39 <syscall>
  801ca1:	83 c4 18             	add    $0x18,%esp
}
  801ca4:	c9                   	leave  
  801ca5:	c3                   	ret    

00801ca6 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801ca6:	55                   	push   %ebp
  801ca7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801ca9:	8b 45 08             	mov    0x8(%ebp),%eax
  801cac:	6a 00                	push   $0x0
  801cae:	6a 00                	push   $0x0
  801cb0:	6a 00                	push   $0x0
  801cb2:	6a 00                	push   $0x0
  801cb4:	50                   	push   %eax
  801cb5:	6a 05                	push   $0x5
  801cb7:	e8 7d ff ff ff       	call   801c39 <syscall>
  801cbc:	83 c4 18             	add    $0x18,%esp
}
  801cbf:	c9                   	leave  
  801cc0:	c3                   	ret    

00801cc1 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801cc1:	55                   	push   %ebp
  801cc2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801cc4:	6a 00                	push   $0x0
  801cc6:	6a 00                	push   $0x0
  801cc8:	6a 00                	push   $0x0
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	6a 02                	push   $0x2
  801cd0:	e8 64 ff ff ff       	call   801c39 <syscall>
  801cd5:	83 c4 18             	add    $0x18,%esp
}
  801cd8:	c9                   	leave  
  801cd9:	c3                   	ret    

00801cda <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801cda:	55                   	push   %ebp
  801cdb:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 00                	push   $0x0
  801ce1:	6a 00                	push   $0x0
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 03                	push   $0x3
  801ce9:	e8 4b ff ff ff       	call   801c39 <syscall>
  801cee:	83 c4 18             	add    $0x18,%esp
}
  801cf1:	c9                   	leave  
  801cf2:	c3                   	ret    

00801cf3 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801cf3:	55                   	push   %ebp
  801cf4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801cf6:	6a 00                	push   $0x0
  801cf8:	6a 00                	push   $0x0
  801cfa:	6a 00                	push   $0x0
  801cfc:	6a 00                	push   $0x0
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 04                	push   $0x4
  801d02:	e8 32 ff ff ff       	call   801c39 <syscall>
  801d07:	83 c4 18             	add    $0x18,%esp
}
  801d0a:	c9                   	leave  
  801d0b:	c3                   	ret    

00801d0c <sys_env_exit>:


void sys_env_exit(void)
{
  801d0c:	55                   	push   %ebp
  801d0d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 00                	push   $0x0
  801d13:	6a 00                	push   $0x0
  801d15:	6a 00                	push   $0x0
  801d17:	6a 00                	push   $0x0
  801d19:	6a 06                	push   $0x6
  801d1b:	e8 19 ff ff ff       	call   801c39 <syscall>
  801d20:	83 c4 18             	add    $0x18,%esp
}
  801d23:	90                   	nop
  801d24:	c9                   	leave  
  801d25:	c3                   	ret    

00801d26 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801d26:	55                   	push   %ebp
  801d27:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d29:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2f:	6a 00                	push   $0x0
  801d31:	6a 00                	push   $0x0
  801d33:	6a 00                	push   $0x0
  801d35:	52                   	push   %edx
  801d36:	50                   	push   %eax
  801d37:	6a 07                	push   $0x7
  801d39:	e8 fb fe ff ff       	call   801c39 <syscall>
  801d3e:	83 c4 18             	add    $0x18,%esp
}
  801d41:	c9                   	leave  
  801d42:	c3                   	ret    

00801d43 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d43:	55                   	push   %ebp
  801d44:	89 e5                	mov    %esp,%ebp
  801d46:	56                   	push   %esi
  801d47:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d48:	8b 75 18             	mov    0x18(%ebp),%esi
  801d4b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d4e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d51:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d54:	8b 45 08             	mov    0x8(%ebp),%eax
  801d57:	56                   	push   %esi
  801d58:	53                   	push   %ebx
  801d59:	51                   	push   %ecx
  801d5a:	52                   	push   %edx
  801d5b:	50                   	push   %eax
  801d5c:	6a 08                	push   $0x8
  801d5e:	e8 d6 fe ff ff       	call   801c39 <syscall>
  801d63:	83 c4 18             	add    $0x18,%esp
}
  801d66:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d69:	5b                   	pop    %ebx
  801d6a:	5e                   	pop    %esi
  801d6b:	5d                   	pop    %ebp
  801d6c:	c3                   	ret    

00801d6d <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801d6d:	55                   	push   %ebp
  801d6e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801d70:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d73:	8b 45 08             	mov    0x8(%ebp),%eax
  801d76:	6a 00                	push   $0x0
  801d78:	6a 00                	push   $0x0
  801d7a:	6a 00                	push   $0x0
  801d7c:	52                   	push   %edx
  801d7d:	50                   	push   %eax
  801d7e:	6a 09                	push   $0x9
  801d80:	e8 b4 fe ff ff       	call   801c39 <syscall>
  801d85:	83 c4 18             	add    $0x18,%esp
}
  801d88:	c9                   	leave  
  801d89:	c3                   	ret    

00801d8a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801d8a:	55                   	push   %ebp
  801d8b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d8d:	6a 00                	push   $0x0
  801d8f:	6a 00                	push   $0x0
  801d91:	6a 00                	push   $0x0
  801d93:	ff 75 0c             	pushl  0xc(%ebp)
  801d96:	ff 75 08             	pushl  0x8(%ebp)
  801d99:	6a 0a                	push   $0xa
  801d9b:	e8 99 fe ff ff       	call   801c39 <syscall>
  801da0:	83 c4 18             	add    $0x18,%esp
}
  801da3:	c9                   	leave  
  801da4:	c3                   	ret    

00801da5 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801da5:	55                   	push   %ebp
  801da6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801da8:	6a 00                	push   $0x0
  801daa:	6a 00                	push   $0x0
  801dac:	6a 00                	push   $0x0
  801dae:	6a 00                	push   $0x0
  801db0:	6a 00                	push   $0x0
  801db2:	6a 0b                	push   $0xb
  801db4:	e8 80 fe ff ff       	call   801c39 <syscall>
  801db9:	83 c4 18             	add    $0x18,%esp
}
  801dbc:	c9                   	leave  
  801dbd:	c3                   	ret    

00801dbe <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801dbe:	55                   	push   %ebp
  801dbf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801dc1:	6a 00                	push   $0x0
  801dc3:	6a 00                	push   $0x0
  801dc5:	6a 00                	push   $0x0
  801dc7:	6a 00                	push   $0x0
  801dc9:	6a 00                	push   $0x0
  801dcb:	6a 0c                	push   $0xc
  801dcd:	e8 67 fe ff ff       	call   801c39 <syscall>
  801dd2:	83 c4 18             	add    $0x18,%esp
}
  801dd5:	c9                   	leave  
  801dd6:	c3                   	ret    

00801dd7 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801dd7:	55                   	push   %ebp
  801dd8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801dda:	6a 00                	push   $0x0
  801ddc:	6a 00                	push   $0x0
  801dde:	6a 00                	push   $0x0
  801de0:	6a 00                	push   $0x0
  801de2:	6a 00                	push   $0x0
  801de4:	6a 0d                	push   $0xd
  801de6:	e8 4e fe ff ff       	call   801c39 <syscall>
  801deb:	83 c4 18             	add    $0x18,%esp
}
  801dee:	c9                   	leave  
  801def:	c3                   	ret    

00801df0 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801df0:	55                   	push   %ebp
  801df1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	6a 00                	push   $0x0
  801df9:	ff 75 0c             	pushl  0xc(%ebp)
  801dfc:	ff 75 08             	pushl  0x8(%ebp)
  801dff:	6a 11                	push   $0x11
  801e01:	e8 33 fe ff ff       	call   801c39 <syscall>
  801e06:	83 c4 18             	add    $0x18,%esp
	return;
  801e09:	90                   	nop
}
  801e0a:	c9                   	leave  
  801e0b:	c3                   	ret    

00801e0c <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801e0c:	55                   	push   %ebp
  801e0d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801e0f:	6a 00                	push   $0x0
  801e11:	6a 00                	push   $0x0
  801e13:	6a 00                	push   $0x0
  801e15:	ff 75 0c             	pushl  0xc(%ebp)
  801e18:	ff 75 08             	pushl  0x8(%ebp)
  801e1b:	6a 12                	push   $0x12
  801e1d:	e8 17 fe ff ff       	call   801c39 <syscall>
  801e22:	83 c4 18             	add    $0x18,%esp
	return ;
  801e25:	90                   	nop
}
  801e26:	c9                   	leave  
  801e27:	c3                   	ret    

00801e28 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801e28:	55                   	push   %ebp
  801e29:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801e2b:	6a 00                	push   $0x0
  801e2d:	6a 00                	push   $0x0
  801e2f:	6a 00                	push   $0x0
  801e31:	6a 00                	push   $0x0
  801e33:	6a 00                	push   $0x0
  801e35:	6a 0e                	push   $0xe
  801e37:	e8 fd fd ff ff       	call   801c39 <syscall>
  801e3c:	83 c4 18             	add    $0x18,%esp
}
  801e3f:	c9                   	leave  
  801e40:	c3                   	ret    

00801e41 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801e41:	55                   	push   %ebp
  801e42:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801e44:	6a 00                	push   $0x0
  801e46:	6a 00                	push   $0x0
  801e48:	6a 00                	push   $0x0
  801e4a:	6a 00                	push   $0x0
  801e4c:	ff 75 08             	pushl  0x8(%ebp)
  801e4f:	6a 0f                	push   $0xf
  801e51:	e8 e3 fd ff ff       	call   801c39 <syscall>
  801e56:	83 c4 18             	add    $0x18,%esp
}
  801e59:	c9                   	leave  
  801e5a:	c3                   	ret    

00801e5b <sys_scarce_memory>:

void sys_scarce_memory()
{
  801e5b:	55                   	push   %ebp
  801e5c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801e5e:	6a 00                	push   $0x0
  801e60:	6a 00                	push   $0x0
  801e62:	6a 00                	push   $0x0
  801e64:	6a 00                	push   $0x0
  801e66:	6a 00                	push   $0x0
  801e68:	6a 10                	push   $0x10
  801e6a:	e8 ca fd ff ff       	call   801c39 <syscall>
  801e6f:	83 c4 18             	add    $0x18,%esp
}
  801e72:	90                   	nop
  801e73:	c9                   	leave  
  801e74:	c3                   	ret    

00801e75 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801e75:	55                   	push   %ebp
  801e76:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801e78:	6a 00                	push   $0x0
  801e7a:	6a 00                	push   $0x0
  801e7c:	6a 00                	push   $0x0
  801e7e:	6a 00                	push   $0x0
  801e80:	6a 00                	push   $0x0
  801e82:	6a 14                	push   $0x14
  801e84:	e8 b0 fd ff ff       	call   801c39 <syscall>
  801e89:	83 c4 18             	add    $0x18,%esp
}
  801e8c:	90                   	nop
  801e8d:	c9                   	leave  
  801e8e:	c3                   	ret    

00801e8f <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801e8f:	55                   	push   %ebp
  801e90:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801e92:	6a 00                	push   $0x0
  801e94:	6a 00                	push   $0x0
  801e96:	6a 00                	push   $0x0
  801e98:	6a 00                	push   $0x0
  801e9a:	6a 00                	push   $0x0
  801e9c:	6a 15                	push   $0x15
  801e9e:	e8 96 fd ff ff       	call   801c39 <syscall>
  801ea3:	83 c4 18             	add    $0x18,%esp
}
  801ea6:	90                   	nop
  801ea7:	c9                   	leave  
  801ea8:	c3                   	ret    

00801ea9 <sys_cputc>:


void
sys_cputc(const char c)
{
  801ea9:	55                   	push   %ebp
  801eaa:	89 e5                	mov    %esp,%ebp
  801eac:	83 ec 04             	sub    $0x4,%esp
  801eaf:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801eb5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801eb9:	6a 00                	push   $0x0
  801ebb:	6a 00                	push   $0x0
  801ebd:	6a 00                	push   $0x0
  801ebf:	6a 00                	push   $0x0
  801ec1:	50                   	push   %eax
  801ec2:	6a 16                	push   $0x16
  801ec4:	e8 70 fd ff ff       	call   801c39 <syscall>
  801ec9:	83 c4 18             	add    $0x18,%esp
}
  801ecc:	90                   	nop
  801ecd:	c9                   	leave  
  801ece:	c3                   	ret    

00801ecf <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801ecf:	55                   	push   %ebp
  801ed0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ed2:	6a 00                	push   $0x0
  801ed4:	6a 00                	push   $0x0
  801ed6:	6a 00                	push   $0x0
  801ed8:	6a 00                	push   $0x0
  801eda:	6a 00                	push   $0x0
  801edc:	6a 17                	push   $0x17
  801ede:	e8 56 fd ff ff       	call   801c39 <syscall>
  801ee3:	83 c4 18             	add    $0x18,%esp
}
  801ee6:	90                   	nop
  801ee7:	c9                   	leave  
  801ee8:	c3                   	ret    

00801ee9 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801ee9:	55                   	push   %ebp
  801eea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801eec:	8b 45 08             	mov    0x8(%ebp),%eax
  801eef:	6a 00                	push   $0x0
  801ef1:	6a 00                	push   $0x0
  801ef3:	6a 00                	push   $0x0
  801ef5:	ff 75 0c             	pushl  0xc(%ebp)
  801ef8:	50                   	push   %eax
  801ef9:	6a 18                	push   $0x18
  801efb:	e8 39 fd ff ff       	call   801c39 <syscall>
  801f00:	83 c4 18             	add    $0x18,%esp
}
  801f03:	c9                   	leave  
  801f04:	c3                   	ret    

00801f05 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801f05:	55                   	push   %ebp
  801f06:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f08:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f0e:	6a 00                	push   $0x0
  801f10:	6a 00                	push   $0x0
  801f12:	6a 00                	push   $0x0
  801f14:	52                   	push   %edx
  801f15:	50                   	push   %eax
  801f16:	6a 1b                	push   $0x1b
  801f18:	e8 1c fd ff ff       	call   801c39 <syscall>
  801f1d:	83 c4 18             	add    $0x18,%esp
}
  801f20:	c9                   	leave  
  801f21:	c3                   	ret    

00801f22 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f22:	55                   	push   %ebp
  801f23:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f25:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f28:	8b 45 08             	mov    0x8(%ebp),%eax
  801f2b:	6a 00                	push   $0x0
  801f2d:	6a 00                	push   $0x0
  801f2f:	6a 00                	push   $0x0
  801f31:	52                   	push   %edx
  801f32:	50                   	push   %eax
  801f33:	6a 19                	push   $0x19
  801f35:	e8 ff fc ff ff       	call   801c39 <syscall>
  801f3a:	83 c4 18             	add    $0x18,%esp
}
  801f3d:	90                   	nop
  801f3e:	c9                   	leave  
  801f3f:	c3                   	ret    

00801f40 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f40:	55                   	push   %ebp
  801f41:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f43:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f46:	8b 45 08             	mov    0x8(%ebp),%eax
  801f49:	6a 00                	push   $0x0
  801f4b:	6a 00                	push   $0x0
  801f4d:	6a 00                	push   $0x0
  801f4f:	52                   	push   %edx
  801f50:	50                   	push   %eax
  801f51:	6a 1a                	push   $0x1a
  801f53:	e8 e1 fc ff ff       	call   801c39 <syscall>
  801f58:	83 c4 18             	add    $0x18,%esp
}
  801f5b:	90                   	nop
  801f5c:	c9                   	leave  
  801f5d:	c3                   	ret    

00801f5e <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801f5e:	55                   	push   %ebp
  801f5f:	89 e5                	mov    %esp,%ebp
  801f61:	83 ec 04             	sub    $0x4,%esp
  801f64:	8b 45 10             	mov    0x10(%ebp),%eax
  801f67:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801f6a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801f6d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f71:	8b 45 08             	mov    0x8(%ebp),%eax
  801f74:	6a 00                	push   $0x0
  801f76:	51                   	push   %ecx
  801f77:	52                   	push   %edx
  801f78:	ff 75 0c             	pushl  0xc(%ebp)
  801f7b:	50                   	push   %eax
  801f7c:	6a 1c                	push   $0x1c
  801f7e:	e8 b6 fc ff ff       	call   801c39 <syscall>
  801f83:	83 c4 18             	add    $0x18,%esp
}
  801f86:	c9                   	leave  
  801f87:	c3                   	ret    

00801f88 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801f88:	55                   	push   %ebp
  801f89:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801f8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f91:	6a 00                	push   $0x0
  801f93:	6a 00                	push   $0x0
  801f95:	6a 00                	push   $0x0
  801f97:	52                   	push   %edx
  801f98:	50                   	push   %eax
  801f99:	6a 1d                	push   $0x1d
  801f9b:	e8 99 fc ff ff       	call   801c39 <syscall>
  801fa0:	83 c4 18             	add    $0x18,%esp
}
  801fa3:	c9                   	leave  
  801fa4:	c3                   	ret    

00801fa5 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801fa5:	55                   	push   %ebp
  801fa6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801fa8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801fab:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fae:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb1:	6a 00                	push   $0x0
  801fb3:	6a 00                	push   $0x0
  801fb5:	51                   	push   %ecx
  801fb6:	52                   	push   %edx
  801fb7:	50                   	push   %eax
  801fb8:	6a 1e                	push   $0x1e
  801fba:	e8 7a fc ff ff       	call   801c39 <syscall>
  801fbf:	83 c4 18             	add    $0x18,%esp
}
  801fc2:	c9                   	leave  
  801fc3:	c3                   	ret    

00801fc4 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801fc4:	55                   	push   %ebp
  801fc5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801fc7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fca:	8b 45 08             	mov    0x8(%ebp),%eax
  801fcd:	6a 00                	push   $0x0
  801fcf:	6a 00                	push   $0x0
  801fd1:	6a 00                	push   $0x0
  801fd3:	52                   	push   %edx
  801fd4:	50                   	push   %eax
  801fd5:	6a 1f                	push   $0x1f
  801fd7:	e8 5d fc ff ff       	call   801c39 <syscall>
  801fdc:	83 c4 18             	add    $0x18,%esp
}
  801fdf:	c9                   	leave  
  801fe0:	c3                   	ret    

00801fe1 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801fe1:	55                   	push   %ebp
  801fe2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801fe4:	6a 00                	push   $0x0
  801fe6:	6a 00                	push   $0x0
  801fe8:	6a 00                	push   $0x0
  801fea:	6a 00                	push   $0x0
  801fec:	6a 00                	push   $0x0
  801fee:	6a 20                	push   $0x20
  801ff0:	e8 44 fc ff ff       	call   801c39 <syscall>
  801ff5:	83 c4 18             	add    $0x18,%esp
}
  801ff8:	c9                   	leave  
  801ff9:	c3                   	ret    

00801ffa <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801ffa:	55                   	push   %ebp
  801ffb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801ffd:	8b 45 08             	mov    0x8(%ebp),%eax
  802000:	6a 00                	push   $0x0
  802002:	ff 75 14             	pushl  0x14(%ebp)
  802005:	ff 75 10             	pushl  0x10(%ebp)
  802008:	ff 75 0c             	pushl  0xc(%ebp)
  80200b:	50                   	push   %eax
  80200c:	6a 21                	push   $0x21
  80200e:	e8 26 fc ff ff       	call   801c39 <syscall>
  802013:	83 c4 18             	add    $0x18,%esp
}
  802016:	c9                   	leave  
  802017:	c3                   	ret    

00802018 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  802018:	55                   	push   %ebp
  802019:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80201b:	8b 45 08             	mov    0x8(%ebp),%eax
  80201e:	6a 00                	push   $0x0
  802020:	6a 00                	push   $0x0
  802022:	6a 00                	push   $0x0
  802024:	6a 00                	push   $0x0
  802026:	50                   	push   %eax
  802027:	6a 22                	push   $0x22
  802029:	e8 0b fc ff ff       	call   801c39 <syscall>
  80202e:	83 c4 18             	add    $0x18,%esp
}
  802031:	90                   	nop
  802032:	c9                   	leave  
  802033:	c3                   	ret    

00802034 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802034:	55                   	push   %ebp
  802035:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802037:	8b 45 08             	mov    0x8(%ebp),%eax
  80203a:	6a 00                	push   $0x0
  80203c:	6a 00                	push   $0x0
  80203e:	6a 00                	push   $0x0
  802040:	6a 00                	push   $0x0
  802042:	50                   	push   %eax
  802043:	6a 23                	push   $0x23
  802045:	e8 ef fb ff ff       	call   801c39 <syscall>
  80204a:	83 c4 18             	add    $0x18,%esp
}
  80204d:	90                   	nop
  80204e:	c9                   	leave  
  80204f:	c3                   	ret    

00802050 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802050:	55                   	push   %ebp
  802051:	89 e5                	mov    %esp,%ebp
  802053:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802056:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802059:	8d 50 04             	lea    0x4(%eax),%edx
  80205c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80205f:	6a 00                	push   $0x0
  802061:	6a 00                	push   $0x0
  802063:	6a 00                	push   $0x0
  802065:	52                   	push   %edx
  802066:	50                   	push   %eax
  802067:	6a 24                	push   $0x24
  802069:	e8 cb fb ff ff       	call   801c39 <syscall>
  80206e:	83 c4 18             	add    $0x18,%esp
	return result;
  802071:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802074:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802077:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80207a:	89 01                	mov    %eax,(%ecx)
  80207c:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80207f:	8b 45 08             	mov    0x8(%ebp),%eax
  802082:	c9                   	leave  
  802083:	c2 04 00             	ret    $0x4

00802086 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802086:	55                   	push   %ebp
  802087:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802089:	6a 00                	push   $0x0
  80208b:	6a 00                	push   $0x0
  80208d:	ff 75 10             	pushl  0x10(%ebp)
  802090:	ff 75 0c             	pushl  0xc(%ebp)
  802093:	ff 75 08             	pushl  0x8(%ebp)
  802096:	6a 13                	push   $0x13
  802098:	e8 9c fb ff ff       	call   801c39 <syscall>
  80209d:	83 c4 18             	add    $0x18,%esp
	return ;
  8020a0:	90                   	nop
}
  8020a1:	c9                   	leave  
  8020a2:	c3                   	ret    

008020a3 <sys_rcr2>:
uint32 sys_rcr2()
{
  8020a3:	55                   	push   %ebp
  8020a4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8020a6:	6a 00                	push   $0x0
  8020a8:	6a 00                	push   $0x0
  8020aa:	6a 00                	push   $0x0
  8020ac:	6a 00                	push   $0x0
  8020ae:	6a 00                	push   $0x0
  8020b0:	6a 25                	push   $0x25
  8020b2:	e8 82 fb ff ff       	call   801c39 <syscall>
  8020b7:	83 c4 18             	add    $0x18,%esp
}
  8020ba:	c9                   	leave  
  8020bb:	c3                   	ret    

008020bc <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8020bc:	55                   	push   %ebp
  8020bd:	89 e5                	mov    %esp,%ebp
  8020bf:	83 ec 04             	sub    $0x4,%esp
  8020c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8020c5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8020c8:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8020cc:	6a 00                	push   $0x0
  8020ce:	6a 00                	push   $0x0
  8020d0:	6a 00                	push   $0x0
  8020d2:	6a 00                	push   $0x0
  8020d4:	50                   	push   %eax
  8020d5:	6a 26                	push   $0x26
  8020d7:	e8 5d fb ff ff       	call   801c39 <syscall>
  8020dc:	83 c4 18             	add    $0x18,%esp
	return ;
  8020df:	90                   	nop
}
  8020e0:	c9                   	leave  
  8020e1:	c3                   	ret    

008020e2 <rsttst>:
void rsttst()
{
  8020e2:	55                   	push   %ebp
  8020e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8020e5:	6a 00                	push   $0x0
  8020e7:	6a 00                	push   $0x0
  8020e9:	6a 00                	push   $0x0
  8020eb:	6a 00                	push   $0x0
  8020ed:	6a 00                	push   $0x0
  8020ef:	6a 28                	push   $0x28
  8020f1:	e8 43 fb ff ff       	call   801c39 <syscall>
  8020f6:	83 c4 18             	add    $0x18,%esp
	return ;
  8020f9:	90                   	nop
}
  8020fa:	c9                   	leave  
  8020fb:	c3                   	ret    

008020fc <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8020fc:	55                   	push   %ebp
  8020fd:	89 e5                	mov    %esp,%ebp
  8020ff:	83 ec 04             	sub    $0x4,%esp
  802102:	8b 45 14             	mov    0x14(%ebp),%eax
  802105:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802108:	8b 55 18             	mov    0x18(%ebp),%edx
  80210b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80210f:	52                   	push   %edx
  802110:	50                   	push   %eax
  802111:	ff 75 10             	pushl  0x10(%ebp)
  802114:	ff 75 0c             	pushl  0xc(%ebp)
  802117:	ff 75 08             	pushl  0x8(%ebp)
  80211a:	6a 27                	push   $0x27
  80211c:	e8 18 fb ff ff       	call   801c39 <syscall>
  802121:	83 c4 18             	add    $0x18,%esp
	return ;
  802124:	90                   	nop
}
  802125:	c9                   	leave  
  802126:	c3                   	ret    

00802127 <chktst>:
void chktst(uint32 n)
{
  802127:	55                   	push   %ebp
  802128:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80212a:	6a 00                	push   $0x0
  80212c:	6a 00                	push   $0x0
  80212e:	6a 00                	push   $0x0
  802130:	6a 00                	push   $0x0
  802132:	ff 75 08             	pushl  0x8(%ebp)
  802135:	6a 29                	push   $0x29
  802137:	e8 fd fa ff ff       	call   801c39 <syscall>
  80213c:	83 c4 18             	add    $0x18,%esp
	return ;
  80213f:	90                   	nop
}
  802140:	c9                   	leave  
  802141:	c3                   	ret    

00802142 <inctst>:

void inctst()
{
  802142:	55                   	push   %ebp
  802143:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802145:	6a 00                	push   $0x0
  802147:	6a 00                	push   $0x0
  802149:	6a 00                	push   $0x0
  80214b:	6a 00                	push   $0x0
  80214d:	6a 00                	push   $0x0
  80214f:	6a 2a                	push   $0x2a
  802151:	e8 e3 fa ff ff       	call   801c39 <syscall>
  802156:	83 c4 18             	add    $0x18,%esp
	return ;
  802159:	90                   	nop
}
  80215a:	c9                   	leave  
  80215b:	c3                   	ret    

0080215c <gettst>:
uint32 gettst()
{
  80215c:	55                   	push   %ebp
  80215d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80215f:	6a 00                	push   $0x0
  802161:	6a 00                	push   $0x0
  802163:	6a 00                	push   $0x0
  802165:	6a 00                	push   $0x0
  802167:	6a 00                	push   $0x0
  802169:	6a 2b                	push   $0x2b
  80216b:	e8 c9 fa ff ff       	call   801c39 <syscall>
  802170:	83 c4 18             	add    $0x18,%esp
}
  802173:	c9                   	leave  
  802174:	c3                   	ret    

00802175 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802175:	55                   	push   %ebp
  802176:	89 e5                	mov    %esp,%ebp
  802178:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80217b:	6a 00                	push   $0x0
  80217d:	6a 00                	push   $0x0
  80217f:	6a 00                	push   $0x0
  802181:	6a 00                	push   $0x0
  802183:	6a 00                	push   $0x0
  802185:	6a 2c                	push   $0x2c
  802187:	e8 ad fa ff ff       	call   801c39 <syscall>
  80218c:	83 c4 18             	add    $0x18,%esp
  80218f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802192:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802196:	75 07                	jne    80219f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802198:	b8 01 00 00 00       	mov    $0x1,%eax
  80219d:	eb 05                	jmp    8021a4 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80219f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021a4:	c9                   	leave  
  8021a5:	c3                   	ret    

008021a6 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8021a6:	55                   	push   %ebp
  8021a7:	89 e5                	mov    %esp,%ebp
  8021a9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021ac:	6a 00                	push   $0x0
  8021ae:	6a 00                	push   $0x0
  8021b0:	6a 00                	push   $0x0
  8021b2:	6a 00                	push   $0x0
  8021b4:	6a 00                	push   $0x0
  8021b6:	6a 2c                	push   $0x2c
  8021b8:	e8 7c fa ff ff       	call   801c39 <syscall>
  8021bd:	83 c4 18             	add    $0x18,%esp
  8021c0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8021c3:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8021c7:	75 07                	jne    8021d0 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8021c9:	b8 01 00 00 00       	mov    $0x1,%eax
  8021ce:	eb 05                	jmp    8021d5 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8021d0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021d5:	c9                   	leave  
  8021d6:	c3                   	ret    

008021d7 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8021d7:	55                   	push   %ebp
  8021d8:	89 e5                	mov    %esp,%ebp
  8021da:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021dd:	6a 00                	push   $0x0
  8021df:	6a 00                	push   $0x0
  8021e1:	6a 00                	push   $0x0
  8021e3:	6a 00                	push   $0x0
  8021e5:	6a 00                	push   $0x0
  8021e7:	6a 2c                	push   $0x2c
  8021e9:	e8 4b fa ff ff       	call   801c39 <syscall>
  8021ee:	83 c4 18             	add    $0x18,%esp
  8021f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8021f4:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8021f8:	75 07                	jne    802201 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8021fa:	b8 01 00 00 00       	mov    $0x1,%eax
  8021ff:	eb 05                	jmp    802206 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802201:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802206:	c9                   	leave  
  802207:	c3                   	ret    

00802208 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802208:	55                   	push   %ebp
  802209:	89 e5                	mov    %esp,%ebp
  80220b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80220e:	6a 00                	push   $0x0
  802210:	6a 00                	push   $0x0
  802212:	6a 00                	push   $0x0
  802214:	6a 00                	push   $0x0
  802216:	6a 00                	push   $0x0
  802218:	6a 2c                	push   $0x2c
  80221a:	e8 1a fa ff ff       	call   801c39 <syscall>
  80221f:	83 c4 18             	add    $0x18,%esp
  802222:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802225:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802229:	75 07                	jne    802232 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80222b:	b8 01 00 00 00       	mov    $0x1,%eax
  802230:	eb 05                	jmp    802237 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802232:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802237:	c9                   	leave  
  802238:	c3                   	ret    

00802239 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802239:	55                   	push   %ebp
  80223a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80223c:	6a 00                	push   $0x0
  80223e:	6a 00                	push   $0x0
  802240:	6a 00                	push   $0x0
  802242:	6a 00                	push   $0x0
  802244:	ff 75 08             	pushl  0x8(%ebp)
  802247:	6a 2d                	push   $0x2d
  802249:	e8 eb f9 ff ff       	call   801c39 <syscall>
  80224e:	83 c4 18             	add    $0x18,%esp
	return ;
  802251:	90                   	nop
}
  802252:	c9                   	leave  
  802253:	c3                   	ret    

00802254 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802254:	55                   	push   %ebp
  802255:	89 e5                	mov    %esp,%ebp
  802257:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802258:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80225b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80225e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802261:	8b 45 08             	mov    0x8(%ebp),%eax
  802264:	6a 00                	push   $0x0
  802266:	53                   	push   %ebx
  802267:	51                   	push   %ecx
  802268:	52                   	push   %edx
  802269:	50                   	push   %eax
  80226a:	6a 2e                	push   $0x2e
  80226c:	e8 c8 f9 ff ff       	call   801c39 <syscall>
  802271:	83 c4 18             	add    $0x18,%esp
}
  802274:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802277:	c9                   	leave  
  802278:	c3                   	ret    

00802279 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802279:	55                   	push   %ebp
  80227a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80227c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80227f:	8b 45 08             	mov    0x8(%ebp),%eax
  802282:	6a 00                	push   $0x0
  802284:	6a 00                	push   $0x0
  802286:	6a 00                	push   $0x0
  802288:	52                   	push   %edx
  802289:	50                   	push   %eax
  80228a:	6a 2f                	push   $0x2f
  80228c:	e8 a8 f9 ff ff       	call   801c39 <syscall>
  802291:	83 c4 18             	add    $0x18,%esp
}
  802294:	c9                   	leave  
  802295:	c3                   	ret    
  802296:	66 90                	xchg   %ax,%ax

00802298 <__udivdi3>:
  802298:	55                   	push   %ebp
  802299:	57                   	push   %edi
  80229a:	56                   	push   %esi
  80229b:	53                   	push   %ebx
  80229c:	83 ec 1c             	sub    $0x1c,%esp
  80229f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8022a3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8022a7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022ab:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8022af:	89 ca                	mov    %ecx,%edx
  8022b1:	89 f8                	mov    %edi,%eax
  8022b3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8022b7:	85 f6                	test   %esi,%esi
  8022b9:	75 2d                	jne    8022e8 <__udivdi3+0x50>
  8022bb:	39 cf                	cmp    %ecx,%edi
  8022bd:	77 65                	ja     802324 <__udivdi3+0x8c>
  8022bf:	89 fd                	mov    %edi,%ebp
  8022c1:	85 ff                	test   %edi,%edi
  8022c3:	75 0b                	jne    8022d0 <__udivdi3+0x38>
  8022c5:	b8 01 00 00 00       	mov    $0x1,%eax
  8022ca:	31 d2                	xor    %edx,%edx
  8022cc:	f7 f7                	div    %edi
  8022ce:	89 c5                	mov    %eax,%ebp
  8022d0:	31 d2                	xor    %edx,%edx
  8022d2:	89 c8                	mov    %ecx,%eax
  8022d4:	f7 f5                	div    %ebp
  8022d6:	89 c1                	mov    %eax,%ecx
  8022d8:	89 d8                	mov    %ebx,%eax
  8022da:	f7 f5                	div    %ebp
  8022dc:	89 cf                	mov    %ecx,%edi
  8022de:	89 fa                	mov    %edi,%edx
  8022e0:	83 c4 1c             	add    $0x1c,%esp
  8022e3:	5b                   	pop    %ebx
  8022e4:	5e                   	pop    %esi
  8022e5:	5f                   	pop    %edi
  8022e6:	5d                   	pop    %ebp
  8022e7:	c3                   	ret    
  8022e8:	39 ce                	cmp    %ecx,%esi
  8022ea:	77 28                	ja     802314 <__udivdi3+0x7c>
  8022ec:	0f bd fe             	bsr    %esi,%edi
  8022ef:	83 f7 1f             	xor    $0x1f,%edi
  8022f2:	75 40                	jne    802334 <__udivdi3+0x9c>
  8022f4:	39 ce                	cmp    %ecx,%esi
  8022f6:	72 0a                	jb     802302 <__udivdi3+0x6a>
  8022f8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8022fc:	0f 87 9e 00 00 00    	ja     8023a0 <__udivdi3+0x108>
  802302:	b8 01 00 00 00       	mov    $0x1,%eax
  802307:	89 fa                	mov    %edi,%edx
  802309:	83 c4 1c             	add    $0x1c,%esp
  80230c:	5b                   	pop    %ebx
  80230d:	5e                   	pop    %esi
  80230e:	5f                   	pop    %edi
  80230f:	5d                   	pop    %ebp
  802310:	c3                   	ret    
  802311:	8d 76 00             	lea    0x0(%esi),%esi
  802314:	31 ff                	xor    %edi,%edi
  802316:	31 c0                	xor    %eax,%eax
  802318:	89 fa                	mov    %edi,%edx
  80231a:	83 c4 1c             	add    $0x1c,%esp
  80231d:	5b                   	pop    %ebx
  80231e:	5e                   	pop    %esi
  80231f:	5f                   	pop    %edi
  802320:	5d                   	pop    %ebp
  802321:	c3                   	ret    
  802322:	66 90                	xchg   %ax,%ax
  802324:	89 d8                	mov    %ebx,%eax
  802326:	f7 f7                	div    %edi
  802328:	31 ff                	xor    %edi,%edi
  80232a:	89 fa                	mov    %edi,%edx
  80232c:	83 c4 1c             	add    $0x1c,%esp
  80232f:	5b                   	pop    %ebx
  802330:	5e                   	pop    %esi
  802331:	5f                   	pop    %edi
  802332:	5d                   	pop    %ebp
  802333:	c3                   	ret    
  802334:	bd 20 00 00 00       	mov    $0x20,%ebp
  802339:	89 eb                	mov    %ebp,%ebx
  80233b:	29 fb                	sub    %edi,%ebx
  80233d:	89 f9                	mov    %edi,%ecx
  80233f:	d3 e6                	shl    %cl,%esi
  802341:	89 c5                	mov    %eax,%ebp
  802343:	88 d9                	mov    %bl,%cl
  802345:	d3 ed                	shr    %cl,%ebp
  802347:	89 e9                	mov    %ebp,%ecx
  802349:	09 f1                	or     %esi,%ecx
  80234b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80234f:	89 f9                	mov    %edi,%ecx
  802351:	d3 e0                	shl    %cl,%eax
  802353:	89 c5                	mov    %eax,%ebp
  802355:	89 d6                	mov    %edx,%esi
  802357:	88 d9                	mov    %bl,%cl
  802359:	d3 ee                	shr    %cl,%esi
  80235b:	89 f9                	mov    %edi,%ecx
  80235d:	d3 e2                	shl    %cl,%edx
  80235f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802363:	88 d9                	mov    %bl,%cl
  802365:	d3 e8                	shr    %cl,%eax
  802367:	09 c2                	or     %eax,%edx
  802369:	89 d0                	mov    %edx,%eax
  80236b:	89 f2                	mov    %esi,%edx
  80236d:	f7 74 24 0c          	divl   0xc(%esp)
  802371:	89 d6                	mov    %edx,%esi
  802373:	89 c3                	mov    %eax,%ebx
  802375:	f7 e5                	mul    %ebp
  802377:	39 d6                	cmp    %edx,%esi
  802379:	72 19                	jb     802394 <__udivdi3+0xfc>
  80237b:	74 0b                	je     802388 <__udivdi3+0xf0>
  80237d:	89 d8                	mov    %ebx,%eax
  80237f:	31 ff                	xor    %edi,%edi
  802381:	e9 58 ff ff ff       	jmp    8022de <__udivdi3+0x46>
  802386:	66 90                	xchg   %ax,%ax
  802388:	8b 54 24 08          	mov    0x8(%esp),%edx
  80238c:	89 f9                	mov    %edi,%ecx
  80238e:	d3 e2                	shl    %cl,%edx
  802390:	39 c2                	cmp    %eax,%edx
  802392:	73 e9                	jae    80237d <__udivdi3+0xe5>
  802394:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802397:	31 ff                	xor    %edi,%edi
  802399:	e9 40 ff ff ff       	jmp    8022de <__udivdi3+0x46>
  80239e:	66 90                	xchg   %ax,%ax
  8023a0:	31 c0                	xor    %eax,%eax
  8023a2:	e9 37 ff ff ff       	jmp    8022de <__udivdi3+0x46>
  8023a7:	90                   	nop

008023a8 <__umoddi3>:
  8023a8:	55                   	push   %ebp
  8023a9:	57                   	push   %edi
  8023aa:	56                   	push   %esi
  8023ab:	53                   	push   %ebx
  8023ac:	83 ec 1c             	sub    $0x1c,%esp
  8023af:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8023b3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8023b7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023bb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8023bf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8023c3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8023c7:	89 f3                	mov    %esi,%ebx
  8023c9:	89 fa                	mov    %edi,%edx
  8023cb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023cf:	89 34 24             	mov    %esi,(%esp)
  8023d2:	85 c0                	test   %eax,%eax
  8023d4:	75 1a                	jne    8023f0 <__umoddi3+0x48>
  8023d6:	39 f7                	cmp    %esi,%edi
  8023d8:	0f 86 a2 00 00 00    	jbe    802480 <__umoddi3+0xd8>
  8023de:	89 c8                	mov    %ecx,%eax
  8023e0:	89 f2                	mov    %esi,%edx
  8023e2:	f7 f7                	div    %edi
  8023e4:	89 d0                	mov    %edx,%eax
  8023e6:	31 d2                	xor    %edx,%edx
  8023e8:	83 c4 1c             	add    $0x1c,%esp
  8023eb:	5b                   	pop    %ebx
  8023ec:	5e                   	pop    %esi
  8023ed:	5f                   	pop    %edi
  8023ee:	5d                   	pop    %ebp
  8023ef:	c3                   	ret    
  8023f0:	39 f0                	cmp    %esi,%eax
  8023f2:	0f 87 ac 00 00 00    	ja     8024a4 <__umoddi3+0xfc>
  8023f8:	0f bd e8             	bsr    %eax,%ebp
  8023fb:	83 f5 1f             	xor    $0x1f,%ebp
  8023fe:	0f 84 ac 00 00 00    	je     8024b0 <__umoddi3+0x108>
  802404:	bf 20 00 00 00       	mov    $0x20,%edi
  802409:	29 ef                	sub    %ebp,%edi
  80240b:	89 fe                	mov    %edi,%esi
  80240d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802411:	89 e9                	mov    %ebp,%ecx
  802413:	d3 e0                	shl    %cl,%eax
  802415:	89 d7                	mov    %edx,%edi
  802417:	89 f1                	mov    %esi,%ecx
  802419:	d3 ef                	shr    %cl,%edi
  80241b:	09 c7                	or     %eax,%edi
  80241d:	89 e9                	mov    %ebp,%ecx
  80241f:	d3 e2                	shl    %cl,%edx
  802421:	89 14 24             	mov    %edx,(%esp)
  802424:	89 d8                	mov    %ebx,%eax
  802426:	d3 e0                	shl    %cl,%eax
  802428:	89 c2                	mov    %eax,%edx
  80242a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80242e:	d3 e0                	shl    %cl,%eax
  802430:	89 44 24 04          	mov    %eax,0x4(%esp)
  802434:	8b 44 24 08          	mov    0x8(%esp),%eax
  802438:	89 f1                	mov    %esi,%ecx
  80243a:	d3 e8                	shr    %cl,%eax
  80243c:	09 d0                	or     %edx,%eax
  80243e:	d3 eb                	shr    %cl,%ebx
  802440:	89 da                	mov    %ebx,%edx
  802442:	f7 f7                	div    %edi
  802444:	89 d3                	mov    %edx,%ebx
  802446:	f7 24 24             	mull   (%esp)
  802449:	89 c6                	mov    %eax,%esi
  80244b:	89 d1                	mov    %edx,%ecx
  80244d:	39 d3                	cmp    %edx,%ebx
  80244f:	0f 82 87 00 00 00    	jb     8024dc <__umoddi3+0x134>
  802455:	0f 84 91 00 00 00    	je     8024ec <__umoddi3+0x144>
  80245b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80245f:	29 f2                	sub    %esi,%edx
  802461:	19 cb                	sbb    %ecx,%ebx
  802463:	89 d8                	mov    %ebx,%eax
  802465:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802469:	d3 e0                	shl    %cl,%eax
  80246b:	89 e9                	mov    %ebp,%ecx
  80246d:	d3 ea                	shr    %cl,%edx
  80246f:	09 d0                	or     %edx,%eax
  802471:	89 e9                	mov    %ebp,%ecx
  802473:	d3 eb                	shr    %cl,%ebx
  802475:	89 da                	mov    %ebx,%edx
  802477:	83 c4 1c             	add    $0x1c,%esp
  80247a:	5b                   	pop    %ebx
  80247b:	5e                   	pop    %esi
  80247c:	5f                   	pop    %edi
  80247d:	5d                   	pop    %ebp
  80247e:	c3                   	ret    
  80247f:	90                   	nop
  802480:	89 fd                	mov    %edi,%ebp
  802482:	85 ff                	test   %edi,%edi
  802484:	75 0b                	jne    802491 <__umoddi3+0xe9>
  802486:	b8 01 00 00 00       	mov    $0x1,%eax
  80248b:	31 d2                	xor    %edx,%edx
  80248d:	f7 f7                	div    %edi
  80248f:	89 c5                	mov    %eax,%ebp
  802491:	89 f0                	mov    %esi,%eax
  802493:	31 d2                	xor    %edx,%edx
  802495:	f7 f5                	div    %ebp
  802497:	89 c8                	mov    %ecx,%eax
  802499:	f7 f5                	div    %ebp
  80249b:	89 d0                	mov    %edx,%eax
  80249d:	e9 44 ff ff ff       	jmp    8023e6 <__umoddi3+0x3e>
  8024a2:	66 90                	xchg   %ax,%ax
  8024a4:	89 c8                	mov    %ecx,%eax
  8024a6:	89 f2                	mov    %esi,%edx
  8024a8:	83 c4 1c             	add    $0x1c,%esp
  8024ab:	5b                   	pop    %ebx
  8024ac:	5e                   	pop    %esi
  8024ad:	5f                   	pop    %edi
  8024ae:	5d                   	pop    %ebp
  8024af:	c3                   	ret    
  8024b0:	3b 04 24             	cmp    (%esp),%eax
  8024b3:	72 06                	jb     8024bb <__umoddi3+0x113>
  8024b5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8024b9:	77 0f                	ja     8024ca <__umoddi3+0x122>
  8024bb:	89 f2                	mov    %esi,%edx
  8024bd:	29 f9                	sub    %edi,%ecx
  8024bf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8024c3:	89 14 24             	mov    %edx,(%esp)
  8024c6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024ca:	8b 44 24 04          	mov    0x4(%esp),%eax
  8024ce:	8b 14 24             	mov    (%esp),%edx
  8024d1:	83 c4 1c             	add    $0x1c,%esp
  8024d4:	5b                   	pop    %ebx
  8024d5:	5e                   	pop    %esi
  8024d6:	5f                   	pop    %edi
  8024d7:	5d                   	pop    %ebp
  8024d8:	c3                   	ret    
  8024d9:	8d 76 00             	lea    0x0(%esi),%esi
  8024dc:	2b 04 24             	sub    (%esp),%eax
  8024df:	19 fa                	sbb    %edi,%edx
  8024e1:	89 d1                	mov    %edx,%ecx
  8024e3:	89 c6                	mov    %eax,%esi
  8024e5:	e9 71 ff ff ff       	jmp    80245b <__umoddi3+0xb3>
  8024ea:	66 90                	xchg   %ax,%ax
  8024ec:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8024f0:	72 ea                	jb     8024dc <__umoddi3+0x134>
  8024f2:	89 d9                	mov    %ebx,%ecx
  8024f4:	e9 62 ff ff ff       	jmp    80245b <__umoddi3+0xb3>
