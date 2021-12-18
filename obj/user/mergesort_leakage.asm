
obj/user/mergesort_leakage:     file format elf32-i386


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
  800031:	e8 73 07 00 00       	call   8007a9 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void Merge(int* A, int p, int q, int r);

uint32 CheckSorted(int *Elements, int NumOfElements);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	char Line[255] ;
	char Chose ;
	do
	{
		//2012: lock the interrupt
		sys_disable_interrupt();
  800041:	e8 fd 1f 00 00       	call   802043 <sys_disable_interrupt>

		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 e0 26 80 00       	push   $0x8026e0
  80004e:	e8 3d 0b 00 00       	call   800b90 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 e2 26 80 00       	push   $0x8026e2
  80005e:	e8 2d 0b 00 00       	call   800b90 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 f8 26 80 00       	push   $0x8026f8
  80006e:	e8 1d 0b 00 00       	call   800b90 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 e2 26 80 00       	push   $0x8026e2
  80007e:	e8 0d 0b 00 00       	call   800b90 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 e0 26 80 00       	push   $0x8026e0
  80008e:	e8 fd 0a 00 00       	call   800b90 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 10 27 80 00       	push   $0x802710
  8000a5:	e8 68 11 00 00       	call   801212 <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 b8 16 00 00       	call   801778 <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 4b 1a 00 00       	call   801b20 <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 30 27 80 00       	push   $0x802730
  8000e3:	e8 a8 0a 00 00       	call   800b90 <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 52 27 80 00       	push   $0x802752
  8000f3:	e8 98 0a 00 00       	call   800b90 <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 60 27 80 00       	push   $0x802760
  800103:	e8 88 0a 00 00       	call   800b90 <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 6f 27 80 00       	push   $0x80276f
  800113:	e8 78 0a 00 00       	call   800b90 <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 7f 27 80 00       	push   $0x80277f
  800123:	e8 68 0a 00 00       	call   800b90 <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80012b:	e8 21 06 00 00       	call   800751 <getchar>
  800130:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  800133:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 c9 05 00 00       	call   800709 <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 bc 05 00 00       	call   800709 <cputchar>
  80014d:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800150:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800154:	74 0c                	je     800162 <_main+0x12a>
  800156:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  80015a:	74 06                	je     800162 <_main+0x12a>
  80015c:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800160:	75 b9                	jne    80011b <_main+0xe3>

		//2012: lock the interrupt
		sys_enable_interrupt();
  800162:	e8 f6 1e 00 00       	call   80205d <sys_enable_interrupt>

		int  i ;
		switch (Chose)
  800167:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80016b:	83 f8 62             	cmp    $0x62,%eax
  80016e:	74 1d                	je     80018d <_main+0x155>
  800170:	83 f8 63             	cmp    $0x63,%eax
  800173:	74 2b                	je     8001a0 <_main+0x168>
  800175:	83 f8 61             	cmp    $0x61,%eax
  800178:	75 39                	jne    8001b3 <_main+0x17b>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80017a:	83 ec 08             	sub    $0x8,%esp
  80017d:	ff 75 f0             	pushl  -0x10(%ebp)
  800180:	ff 75 ec             	pushl  -0x14(%ebp)
  800183:	e8 f4 01 00 00       	call   80037c <InitializeAscending>
  800188:	83 c4 10             	add    $0x10,%esp
			break ;
  80018b:	eb 37                	jmp    8001c4 <_main+0x18c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	ff 75 f0             	pushl  -0x10(%ebp)
  800193:	ff 75 ec             	pushl  -0x14(%ebp)
  800196:	e8 12 02 00 00       	call   8003ad <InitializeDescending>
  80019b:	83 c4 10             	add    $0x10,%esp
			break ;
  80019e:	eb 24                	jmp    8001c4 <_main+0x18c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a0:	83 ec 08             	sub    $0x8,%esp
  8001a3:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a6:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a9:	e8 34 02 00 00       	call   8003e2 <InitializeSemiRandom>
  8001ae:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b1:	eb 11                	jmp    8001c4 <_main+0x18c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	ff 75 f0             	pushl  -0x10(%ebp)
  8001b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8001bc:	e8 21 02 00 00       	call   8003e2 <InitializeSemiRandom>
  8001c1:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001c4:	83 ec 04             	sub    $0x4,%esp
  8001c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ca:	6a 01                	push   $0x1
  8001cc:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cf:	e8 e0 02 00 00       	call   8004b4 <MSort>
  8001d4:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001d7:	e8 67 1e 00 00       	call   802043 <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001dc:	83 ec 0c             	sub    $0xc,%esp
  8001df:	68 88 27 80 00       	push   $0x802788
  8001e4:	e8 a7 09 00 00       	call   800b90 <cprintf>
  8001e9:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ec:	e8 6c 1e 00 00       	call   80205d <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001f1:	83 ec 08             	sub    $0x8,%esp
  8001f4:	ff 75 f0             	pushl  -0x10(%ebp)
  8001f7:	ff 75 ec             	pushl  -0x14(%ebp)
  8001fa:	e8 d3 00 00 00       	call   8002d2 <CheckSorted>
  8001ff:	83 c4 10             	add    $0x10,%esp
  800202:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800205:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800209:	75 14                	jne    80021f <_main+0x1e7>
  80020b:	83 ec 04             	sub    $0x4,%esp
  80020e:	68 bc 27 80 00       	push   $0x8027bc
  800213:	6a 4a                	push   $0x4a
  800215:	68 de 27 80 00       	push   $0x8027de
  80021a:	e8 cf 06 00 00       	call   8008ee <_panic>
		else
		{
			sys_disable_interrupt();
  80021f:	e8 1f 1e 00 00       	call   802043 <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  800224:	83 ec 0c             	sub    $0xc,%esp
  800227:	68 f8 27 80 00       	push   $0x8027f8
  80022c:	e8 5f 09 00 00       	call   800b90 <cprintf>
  800231:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800234:	83 ec 0c             	sub    $0xc,%esp
  800237:	68 2c 28 80 00       	push   $0x80282c
  80023c:	e8 4f 09 00 00       	call   800b90 <cprintf>
  800241:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800244:	83 ec 0c             	sub    $0xc,%esp
  800247:	68 60 28 80 00       	push   $0x802860
  80024c:	e8 3f 09 00 00       	call   800b90 <cprintf>
  800251:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800254:	e8 04 1e 00 00       	call   80205d <sys_enable_interrupt>
		}

		free(Elements) ;
  800259:	83 ec 0c             	sub    $0xc,%esp
  80025c:	ff 75 ec             	pushl  -0x14(%ebp)
  80025f:	e8 cc 1a 00 00       	call   801d30 <free>
  800264:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  800267:	e8 d7 1d 00 00       	call   802043 <sys_disable_interrupt>
			Chose = 0 ;
  80026c:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800270:	eb 42                	jmp    8002b4 <_main+0x27c>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800272:	83 ec 0c             	sub    $0xc,%esp
  800275:	68 92 28 80 00       	push   $0x802892
  80027a:	e8 11 09 00 00       	call   800b90 <cprintf>
  80027f:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800282:	e8 ca 04 00 00       	call   800751 <getchar>
  800287:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  80028a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80028e:	83 ec 0c             	sub    $0xc,%esp
  800291:	50                   	push   %eax
  800292:	e8 72 04 00 00       	call   800709 <cputchar>
  800297:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80029a:	83 ec 0c             	sub    $0xc,%esp
  80029d:	6a 0a                	push   $0xa
  80029f:	e8 65 04 00 00       	call   800709 <cputchar>
  8002a4:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  8002a7:	83 ec 0c             	sub    $0xc,%esp
  8002aa:	6a 0a                	push   $0xa
  8002ac:	e8 58 04 00 00       	call   800709 <cputchar>
  8002b1:	83 c4 10             	add    $0x10,%esp

		free(Elements) ;

		sys_disable_interrupt();
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  8002b4:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002b8:	74 06                	je     8002c0 <_main+0x288>
  8002ba:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002be:	75 b2                	jne    800272 <_main+0x23a>
				Chose = getchar() ;
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		sys_enable_interrupt();
  8002c0:	e8 98 1d 00 00       	call   80205d <sys_enable_interrupt>

	} while (Chose == 'y');
  8002c5:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002c9:	0f 84 72 fd ff ff    	je     800041 <_main+0x9>

}
  8002cf:	90                   	nop
  8002d0:	c9                   	leave  
  8002d1:	c3                   	ret    

008002d2 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8002d2:	55                   	push   %ebp
  8002d3:	89 e5                	mov    %esp,%ebp
  8002d5:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8002d8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002df:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8002e6:	eb 33                	jmp    80031b <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8002e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002eb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f5:	01 d0                	add    %edx,%eax
  8002f7:	8b 10                	mov    (%eax),%edx
  8002f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002fc:	40                   	inc    %eax
  8002fd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800304:	8b 45 08             	mov    0x8(%ebp),%eax
  800307:	01 c8                	add    %ecx,%eax
  800309:	8b 00                	mov    (%eax),%eax
  80030b:	39 c2                	cmp    %eax,%edx
  80030d:	7e 09                	jle    800318 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  80030f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800316:	eb 0c                	jmp    800324 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800318:	ff 45 f8             	incl   -0x8(%ebp)
  80031b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80031e:	48                   	dec    %eax
  80031f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800322:	7f c4                	jg     8002e8 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800324:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800327:	c9                   	leave  
  800328:	c3                   	ret    

00800329 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  800329:	55                   	push   %ebp
  80032a:	89 e5                	mov    %esp,%ebp
  80032c:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  80032f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800332:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800339:	8b 45 08             	mov    0x8(%ebp),%eax
  80033c:	01 d0                	add    %edx,%eax
  80033e:	8b 00                	mov    (%eax),%eax
  800340:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800343:	8b 45 0c             	mov    0xc(%ebp),%eax
  800346:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80034d:	8b 45 08             	mov    0x8(%ebp),%eax
  800350:	01 c2                	add    %eax,%edx
  800352:	8b 45 10             	mov    0x10(%ebp),%eax
  800355:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80035c:	8b 45 08             	mov    0x8(%ebp),%eax
  80035f:	01 c8                	add    %ecx,%eax
  800361:	8b 00                	mov    (%eax),%eax
  800363:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800365:	8b 45 10             	mov    0x10(%ebp),%eax
  800368:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80036f:	8b 45 08             	mov    0x8(%ebp),%eax
  800372:	01 c2                	add    %eax,%edx
  800374:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800377:	89 02                	mov    %eax,(%edx)
}
  800379:	90                   	nop
  80037a:	c9                   	leave  
  80037b:	c3                   	ret    

0080037c <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80037c:	55                   	push   %ebp
  80037d:	89 e5                	mov    %esp,%ebp
  80037f:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800382:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800389:	eb 17                	jmp    8003a2 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80038b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80038e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800395:	8b 45 08             	mov    0x8(%ebp),%eax
  800398:	01 c2                	add    %eax,%edx
  80039a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80039d:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80039f:	ff 45 fc             	incl   -0x4(%ebp)
  8003a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003a5:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003a8:	7c e1                	jl     80038b <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8003aa:	90                   	nop
  8003ab:	c9                   	leave  
  8003ac:	c3                   	ret    

008003ad <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8003ad:	55                   	push   %ebp
  8003ae:	89 e5                	mov    %esp,%ebp
  8003b0:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003ba:	eb 1b                	jmp    8003d7 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8003bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003bf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c9:	01 c2                	add    %eax,%edx
  8003cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ce:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8003d1:	48                   	dec    %eax
  8003d2:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003d4:	ff 45 fc             	incl   -0x4(%ebp)
  8003d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003da:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003dd:	7c dd                	jl     8003bc <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8003df:	90                   	nop
  8003e0:	c9                   	leave  
  8003e1:	c3                   	ret    

008003e2 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8003e2:	55                   	push   %ebp
  8003e3:	89 e5                	mov    %esp,%ebp
  8003e5:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8003e8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003eb:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8003f0:	f7 e9                	imul   %ecx
  8003f2:	c1 f9 1f             	sar    $0x1f,%ecx
  8003f5:	89 d0                	mov    %edx,%eax
  8003f7:	29 c8                	sub    %ecx,%eax
  8003f9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8003fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800403:	eb 1e                	jmp    800423 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800405:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800408:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80040f:	8b 45 08             	mov    0x8(%ebp),%eax
  800412:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800415:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800418:	99                   	cltd   
  800419:	f7 7d f8             	idivl  -0x8(%ebp)
  80041c:	89 d0                	mov    %edx,%eax
  80041e:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800420:	ff 45 fc             	incl   -0x4(%ebp)
  800423:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800426:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800429:	7c da                	jl     800405 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80042b:	90                   	nop
  80042c:	c9                   	leave  
  80042d:	c3                   	ret    

0080042e <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  80042e:	55                   	push   %ebp
  80042f:	89 e5                	mov    %esp,%ebp
  800431:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800434:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80043b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800442:	eb 42                	jmp    800486 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800444:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800447:	99                   	cltd   
  800448:	f7 7d f0             	idivl  -0x10(%ebp)
  80044b:	89 d0                	mov    %edx,%eax
  80044d:	85 c0                	test   %eax,%eax
  80044f:	75 10                	jne    800461 <PrintElements+0x33>
			cprintf("\n");
  800451:	83 ec 0c             	sub    $0xc,%esp
  800454:	68 e0 26 80 00       	push   $0x8026e0
  800459:	e8 32 07 00 00       	call   800b90 <cprintf>
  80045e:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800461:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800464:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046b:	8b 45 08             	mov    0x8(%ebp),%eax
  80046e:	01 d0                	add    %edx,%eax
  800470:	8b 00                	mov    (%eax),%eax
  800472:	83 ec 08             	sub    $0x8,%esp
  800475:	50                   	push   %eax
  800476:	68 b0 28 80 00       	push   $0x8028b0
  80047b:	e8 10 07 00 00       	call   800b90 <cprintf>
  800480:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800483:	ff 45 f4             	incl   -0xc(%ebp)
  800486:	8b 45 0c             	mov    0xc(%ebp),%eax
  800489:	48                   	dec    %eax
  80048a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80048d:	7f b5                	jg     800444 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  80048f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800492:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800499:	8b 45 08             	mov    0x8(%ebp),%eax
  80049c:	01 d0                	add    %edx,%eax
  80049e:	8b 00                	mov    (%eax),%eax
  8004a0:	83 ec 08             	sub    $0x8,%esp
  8004a3:	50                   	push   %eax
  8004a4:	68 b5 28 80 00       	push   $0x8028b5
  8004a9:	e8 e2 06 00 00       	call   800b90 <cprintf>
  8004ae:	83 c4 10             	add    $0x10,%esp

}
  8004b1:	90                   	nop
  8004b2:	c9                   	leave  
  8004b3:	c3                   	ret    

008004b4 <MSort>:


void MSort(int* A, int p, int r)
{
  8004b4:	55                   	push   %ebp
  8004b5:	89 e5                	mov    %esp,%ebp
  8004b7:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004bd:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004c0:	7d 54                	jge    800516 <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8004c8:	01 d0                	add    %edx,%eax
  8004ca:	89 c2                	mov    %eax,%edx
  8004cc:	c1 ea 1f             	shr    $0x1f,%edx
  8004cf:	01 d0                	add    %edx,%eax
  8004d1:	d1 f8                	sar    %eax
  8004d3:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  8004d6:	83 ec 04             	sub    $0x4,%esp
  8004d9:	ff 75 f4             	pushl  -0xc(%ebp)
  8004dc:	ff 75 0c             	pushl  0xc(%ebp)
  8004df:	ff 75 08             	pushl  0x8(%ebp)
  8004e2:	e8 cd ff ff ff       	call   8004b4 <MSort>
  8004e7:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  8004ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004ed:	40                   	inc    %eax
  8004ee:	83 ec 04             	sub    $0x4,%esp
  8004f1:	ff 75 10             	pushl  0x10(%ebp)
  8004f4:	50                   	push   %eax
  8004f5:	ff 75 08             	pushl  0x8(%ebp)
  8004f8:	e8 b7 ff ff ff       	call   8004b4 <MSort>
  8004fd:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  800500:	ff 75 10             	pushl  0x10(%ebp)
  800503:	ff 75 f4             	pushl  -0xc(%ebp)
  800506:	ff 75 0c             	pushl  0xc(%ebp)
  800509:	ff 75 08             	pushl  0x8(%ebp)
  80050c:	e8 08 00 00 00       	call   800519 <Merge>
  800511:	83 c4 10             	add    $0x10,%esp
  800514:	eb 01                	jmp    800517 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  800516:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  800517:	c9                   	leave  
  800518:	c3                   	ret    

00800519 <Merge>:

void Merge(int* A, int p, int q, int r)
{
  800519:	55                   	push   %ebp
  80051a:	89 e5                	mov    %esp,%ebp
  80051c:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  80051f:	8b 45 10             	mov    0x10(%ebp),%eax
  800522:	2b 45 0c             	sub    0xc(%ebp),%eax
  800525:	40                   	inc    %eax
  800526:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  800529:	8b 45 14             	mov    0x14(%ebp),%eax
  80052c:	2b 45 10             	sub    0x10(%ebp),%eax
  80052f:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800532:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  800539:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  800540:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800543:	c1 e0 02             	shl    $0x2,%eax
  800546:	83 ec 0c             	sub    $0xc,%esp
  800549:	50                   	push   %eax
  80054a:	e8 d1 15 00 00       	call   801b20 <malloc>
  80054f:	83 c4 10             	add    $0x10,%esp
  800552:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  800555:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800558:	c1 e0 02             	shl    $0x2,%eax
  80055b:	83 ec 0c             	sub    $0xc,%esp
  80055e:	50                   	push   %eax
  80055f:	e8 bc 15 00 00       	call   801b20 <malloc>
  800564:	83 c4 10             	add    $0x10,%esp
  800567:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80056a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800571:	eb 2f                	jmp    8005a2 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  800573:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800576:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80057d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800580:	01 c2                	add    %eax,%edx
  800582:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800585:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800588:	01 c8                	add    %ecx,%eax
  80058a:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80058f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800596:	8b 45 08             	mov    0x8(%ebp),%eax
  800599:	01 c8                	add    %ecx,%eax
  80059b:	8b 00                	mov    (%eax),%eax
  80059d:	89 02                	mov    %eax,(%edx)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80059f:	ff 45 ec             	incl   -0x14(%ebp)
  8005a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005a5:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005a8:	7c c9                	jl     800573 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005aa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005b1:	eb 2a                	jmp    8005dd <Merge+0xc4>
	{
		Right[j] = A[q + j];
  8005b3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005b6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005bd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005c0:	01 c2                	add    %eax,%edx
  8005c2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005c8:	01 c8                	add    %ecx,%eax
  8005ca:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d4:	01 c8                	add    %ecx,%eax
  8005d6:	8b 00                	mov    (%eax),%eax
  8005d8:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005da:	ff 45 e8             	incl   -0x18(%ebp)
  8005dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005e0:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005e3:	7c ce                	jl     8005b3 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8005e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005eb:	e9 0a 01 00 00       	jmp    8006fa <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  8005f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005f3:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005f6:	0f 8d 95 00 00 00    	jge    800691 <Merge+0x178>
  8005fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005ff:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800602:	0f 8d 89 00 00 00    	jge    800691 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800608:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80060b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800612:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800615:	01 d0                	add    %edx,%eax
  800617:	8b 10                	mov    (%eax),%edx
  800619:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80061c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800623:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800626:	01 c8                	add    %ecx,%eax
  800628:	8b 00                	mov    (%eax),%eax
  80062a:	39 c2                	cmp    %eax,%edx
  80062c:	7d 33                	jge    800661 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  80062e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800631:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800636:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80063d:	8b 45 08             	mov    0x8(%ebp),%eax
  800640:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800643:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800646:	8d 50 01             	lea    0x1(%eax),%edx
  800649:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80064c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800653:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800656:	01 d0                	add    %edx,%eax
  800658:	8b 00                	mov    (%eax),%eax
  80065a:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80065c:	e9 96 00 00 00       	jmp    8006f7 <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800661:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800664:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800669:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800670:	8b 45 08             	mov    0x8(%ebp),%eax
  800673:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800676:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800679:	8d 50 01             	lea    0x1(%eax),%edx
  80067c:	89 55 f0             	mov    %edx,-0x10(%ebp)
  80067f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800686:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800689:	01 d0                	add    %edx,%eax
  80068b:	8b 00                	mov    (%eax),%eax
  80068d:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80068f:	eb 66                	jmp    8006f7 <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  800691:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800694:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800697:	7d 30                	jge    8006c9 <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  800699:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80069c:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006a1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ab:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006b1:	8d 50 01             	lea    0x1(%eax),%edx
  8006b4:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006be:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006c1:	01 d0                	add    %edx,%eax
  8006c3:	8b 00                	mov    (%eax),%eax
  8006c5:	89 01                	mov    %eax,(%ecx)
  8006c7:	eb 2e                	jmp    8006f7 <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  8006c9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006cc:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006db:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006de:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006e1:	8d 50 01             	lea    0x1(%eax),%edx
  8006e4:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006e7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006ee:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006f1:	01 d0                	add    %edx,%eax
  8006f3:	8b 00                	mov    (%eax),%eax
  8006f5:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8006f7:	ff 45 e4             	incl   -0x1c(%ebp)
  8006fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006fd:	3b 45 14             	cmp    0x14(%ebp),%eax
  800700:	0f 8e ea fe ff ff    	jle    8005f0 <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

}
  800706:	90                   	nop
  800707:	c9                   	leave  
  800708:	c3                   	ret    

00800709 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800709:	55                   	push   %ebp
  80070a:	89 e5                	mov    %esp,%ebp
  80070c:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80070f:	8b 45 08             	mov    0x8(%ebp),%eax
  800712:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800715:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800719:	83 ec 0c             	sub    $0xc,%esp
  80071c:	50                   	push   %eax
  80071d:	e8 55 19 00 00       	call   802077 <sys_cputc>
  800722:	83 c4 10             	add    $0x10,%esp
}
  800725:	90                   	nop
  800726:	c9                   	leave  
  800727:	c3                   	ret    

00800728 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800728:	55                   	push   %ebp
  800729:	89 e5                	mov    %esp,%ebp
  80072b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80072e:	e8 10 19 00 00       	call   802043 <sys_disable_interrupt>
	char c = ch;
  800733:	8b 45 08             	mov    0x8(%ebp),%eax
  800736:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800739:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80073d:	83 ec 0c             	sub    $0xc,%esp
  800740:	50                   	push   %eax
  800741:	e8 31 19 00 00       	call   802077 <sys_cputc>
  800746:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800749:	e8 0f 19 00 00       	call   80205d <sys_enable_interrupt>
}
  80074e:	90                   	nop
  80074f:	c9                   	leave  
  800750:	c3                   	ret    

00800751 <getchar>:

int
getchar(void)
{
  800751:	55                   	push   %ebp
  800752:	89 e5                	mov    %esp,%ebp
  800754:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800757:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80075e:	eb 08                	jmp    800768 <getchar+0x17>
	{
		c = sys_cgetc();
  800760:	e8 f6 16 00 00       	call   801e5b <sys_cgetc>
  800765:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800768:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80076c:	74 f2                	je     800760 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80076e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800771:	c9                   	leave  
  800772:	c3                   	ret    

00800773 <atomic_getchar>:

int
atomic_getchar(void)
{
  800773:	55                   	push   %ebp
  800774:	89 e5                	mov    %esp,%ebp
  800776:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800779:	e8 c5 18 00 00       	call   802043 <sys_disable_interrupt>
	int c=0;
  80077e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800785:	eb 08                	jmp    80078f <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800787:	e8 cf 16 00 00       	call   801e5b <sys_cgetc>
  80078c:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80078f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800793:	74 f2                	je     800787 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800795:	e8 c3 18 00 00       	call   80205d <sys_enable_interrupt>
	return c;
  80079a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80079d:	c9                   	leave  
  80079e:	c3                   	ret    

0080079f <iscons>:

int iscons(int fdnum)
{
  80079f:	55                   	push   %ebp
  8007a0:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8007a2:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8007a7:	5d                   	pop    %ebp
  8007a8:	c3                   	ret    

008007a9 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8007a9:	55                   	push   %ebp
  8007aa:	89 e5                	mov    %esp,%ebp
  8007ac:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8007af:	e8 f4 16 00 00       	call   801ea8 <sys_getenvindex>
  8007b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007ba:	89 d0                	mov    %edx,%eax
  8007bc:	c1 e0 03             	shl    $0x3,%eax
  8007bf:	01 d0                	add    %edx,%eax
  8007c1:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  8007c8:	01 c8                	add    %ecx,%eax
  8007ca:	01 c0                	add    %eax,%eax
  8007cc:	01 d0                	add    %edx,%eax
  8007ce:	01 c0                	add    %eax,%eax
  8007d0:	01 d0                	add    %edx,%eax
  8007d2:	89 c2                	mov    %eax,%edx
  8007d4:	c1 e2 05             	shl    $0x5,%edx
  8007d7:	29 c2                	sub    %eax,%edx
  8007d9:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  8007e0:	89 c2                	mov    %eax,%edx
  8007e2:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  8007e8:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8007ed:	a1 24 30 80 00       	mov    0x803024,%eax
  8007f2:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8007f8:	84 c0                	test   %al,%al
  8007fa:	74 0f                	je     80080b <libmain+0x62>
		binaryname = myEnv->prog_name;
  8007fc:	a1 24 30 80 00       	mov    0x803024,%eax
  800801:	05 40 3c 01 00       	add    $0x13c40,%eax
  800806:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80080b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80080f:	7e 0a                	jle    80081b <libmain+0x72>
		binaryname = argv[0];
  800811:	8b 45 0c             	mov    0xc(%ebp),%eax
  800814:	8b 00                	mov    (%eax),%eax
  800816:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80081b:	83 ec 08             	sub    $0x8,%esp
  80081e:	ff 75 0c             	pushl  0xc(%ebp)
  800821:	ff 75 08             	pushl  0x8(%ebp)
  800824:	e8 0f f8 ff ff       	call   800038 <_main>
  800829:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80082c:	e8 12 18 00 00       	call   802043 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800831:	83 ec 0c             	sub    $0xc,%esp
  800834:	68 d4 28 80 00       	push   $0x8028d4
  800839:	e8 52 03 00 00       	call   800b90 <cprintf>
  80083e:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800841:	a1 24 30 80 00       	mov    0x803024,%eax
  800846:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  80084c:	a1 24 30 80 00       	mov    0x803024,%eax
  800851:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800857:	83 ec 04             	sub    $0x4,%esp
  80085a:	52                   	push   %edx
  80085b:	50                   	push   %eax
  80085c:	68 fc 28 80 00       	push   $0x8028fc
  800861:	e8 2a 03 00 00       	call   800b90 <cprintf>
  800866:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800869:	a1 24 30 80 00       	mov    0x803024,%eax
  80086e:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800874:	a1 24 30 80 00       	mov    0x803024,%eax
  800879:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80087f:	83 ec 04             	sub    $0x4,%esp
  800882:	52                   	push   %edx
  800883:	50                   	push   %eax
  800884:	68 24 29 80 00       	push   $0x802924
  800889:	e8 02 03 00 00       	call   800b90 <cprintf>
  80088e:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  800891:	a1 24 30 80 00       	mov    0x803024,%eax
  800896:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  80089c:	83 ec 08             	sub    $0x8,%esp
  80089f:	50                   	push   %eax
  8008a0:	68 65 29 80 00       	push   $0x802965
  8008a5:	e8 e6 02 00 00       	call   800b90 <cprintf>
  8008aa:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  8008ad:	83 ec 0c             	sub    $0xc,%esp
  8008b0:	68 d4 28 80 00       	push   $0x8028d4
  8008b5:	e8 d6 02 00 00       	call   800b90 <cprintf>
  8008ba:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8008bd:	e8 9b 17 00 00       	call   80205d <sys_enable_interrupt>

	// exit gracefully
	exit();
  8008c2:	e8 19 00 00 00       	call   8008e0 <exit>
}
  8008c7:	90                   	nop
  8008c8:	c9                   	leave  
  8008c9:	c3                   	ret    

008008ca <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8008ca:	55                   	push   %ebp
  8008cb:	89 e5                	mov    %esp,%ebp
  8008cd:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8008d0:	83 ec 0c             	sub    $0xc,%esp
  8008d3:	6a 00                	push   $0x0
  8008d5:	e8 9a 15 00 00       	call   801e74 <sys_env_destroy>
  8008da:	83 c4 10             	add    $0x10,%esp
}
  8008dd:	90                   	nop
  8008de:	c9                   	leave  
  8008df:	c3                   	ret    

008008e0 <exit>:

void
exit(void)
{
  8008e0:	55                   	push   %ebp
  8008e1:	89 e5                	mov    %esp,%ebp
  8008e3:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8008e6:	e8 ef 15 00 00       	call   801eda <sys_env_exit>
}
  8008eb:	90                   	nop
  8008ec:	c9                   	leave  
  8008ed:	c3                   	ret    

008008ee <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8008ee:	55                   	push   %ebp
  8008ef:	89 e5                	mov    %esp,%ebp
  8008f1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8008f4:	8d 45 10             	lea    0x10(%ebp),%eax
  8008f7:	83 c0 04             	add    $0x4,%eax
  8008fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8008fd:	a1 18 31 80 00       	mov    0x803118,%eax
  800902:	85 c0                	test   %eax,%eax
  800904:	74 16                	je     80091c <_panic+0x2e>
		cprintf("%s: ", argv0);
  800906:	a1 18 31 80 00       	mov    0x803118,%eax
  80090b:	83 ec 08             	sub    $0x8,%esp
  80090e:	50                   	push   %eax
  80090f:	68 7c 29 80 00       	push   $0x80297c
  800914:	e8 77 02 00 00       	call   800b90 <cprintf>
  800919:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80091c:	a1 00 30 80 00       	mov    0x803000,%eax
  800921:	ff 75 0c             	pushl  0xc(%ebp)
  800924:	ff 75 08             	pushl  0x8(%ebp)
  800927:	50                   	push   %eax
  800928:	68 81 29 80 00       	push   $0x802981
  80092d:	e8 5e 02 00 00       	call   800b90 <cprintf>
  800932:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800935:	8b 45 10             	mov    0x10(%ebp),%eax
  800938:	83 ec 08             	sub    $0x8,%esp
  80093b:	ff 75 f4             	pushl  -0xc(%ebp)
  80093e:	50                   	push   %eax
  80093f:	e8 e1 01 00 00       	call   800b25 <vcprintf>
  800944:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800947:	83 ec 08             	sub    $0x8,%esp
  80094a:	6a 00                	push   $0x0
  80094c:	68 9d 29 80 00       	push   $0x80299d
  800951:	e8 cf 01 00 00       	call   800b25 <vcprintf>
  800956:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800959:	e8 82 ff ff ff       	call   8008e0 <exit>

	// should not return here
	while (1) ;
  80095e:	eb fe                	jmp    80095e <_panic+0x70>

00800960 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800960:	55                   	push   %ebp
  800961:	89 e5                	mov    %esp,%ebp
  800963:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800966:	a1 24 30 80 00       	mov    0x803024,%eax
  80096b:	8b 50 74             	mov    0x74(%eax),%edx
  80096e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800971:	39 c2                	cmp    %eax,%edx
  800973:	74 14                	je     800989 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800975:	83 ec 04             	sub    $0x4,%esp
  800978:	68 a0 29 80 00       	push   $0x8029a0
  80097d:	6a 26                	push   $0x26
  80097f:	68 ec 29 80 00       	push   $0x8029ec
  800984:	e8 65 ff ff ff       	call   8008ee <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800989:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800990:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800997:	e9 b6 00 00 00       	jmp    800a52 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  80099c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80099f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8009a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a9:	01 d0                	add    %edx,%eax
  8009ab:	8b 00                	mov    (%eax),%eax
  8009ad:	85 c0                	test   %eax,%eax
  8009af:	75 08                	jne    8009b9 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8009b1:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8009b4:	e9 96 00 00 00       	jmp    800a4f <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  8009b9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009c0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8009c7:	eb 5d                	jmp    800a26 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8009c9:	a1 24 30 80 00       	mov    0x803024,%eax
  8009ce:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8009d4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009d7:	c1 e2 04             	shl    $0x4,%edx
  8009da:	01 d0                	add    %edx,%eax
  8009dc:	8a 40 04             	mov    0x4(%eax),%al
  8009df:	84 c0                	test   %al,%al
  8009e1:	75 40                	jne    800a23 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009e3:	a1 24 30 80 00       	mov    0x803024,%eax
  8009e8:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  8009ee:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009f1:	c1 e2 04             	shl    $0x4,%edx
  8009f4:	01 d0                	add    %edx,%eax
  8009f6:	8b 00                	mov    (%eax),%eax
  8009f8:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8009fb:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009fe:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800a03:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800a05:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a08:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800a0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a12:	01 c8                	add    %ecx,%eax
  800a14:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a16:	39 c2                	cmp    %eax,%edx
  800a18:	75 09                	jne    800a23 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  800a1a:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800a21:	eb 12                	jmp    800a35 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a23:	ff 45 e8             	incl   -0x18(%ebp)
  800a26:	a1 24 30 80 00       	mov    0x803024,%eax
  800a2b:	8b 50 74             	mov    0x74(%eax),%edx
  800a2e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a31:	39 c2                	cmp    %eax,%edx
  800a33:	77 94                	ja     8009c9 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a35:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a39:	75 14                	jne    800a4f <CheckWSWithoutLastIndex+0xef>
			panic(
  800a3b:	83 ec 04             	sub    $0x4,%esp
  800a3e:	68 f8 29 80 00       	push   $0x8029f8
  800a43:	6a 3a                	push   $0x3a
  800a45:	68 ec 29 80 00       	push   $0x8029ec
  800a4a:	e8 9f fe ff ff       	call   8008ee <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a4f:	ff 45 f0             	incl   -0x10(%ebp)
  800a52:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a55:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a58:	0f 8c 3e ff ff ff    	jl     80099c <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a5e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a65:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a6c:	eb 20                	jmp    800a8e <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a6e:	a1 24 30 80 00       	mov    0x803024,%eax
  800a73:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  800a79:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a7c:	c1 e2 04             	shl    $0x4,%edx
  800a7f:	01 d0                	add    %edx,%eax
  800a81:	8a 40 04             	mov    0x4(%eax),%al
  800a84:	3c 01                	cmp    $0x1,%al
  800a86:	75 03                	jne    800a8b <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  800a88:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a8b:	ff 45 e0             	incl   -0x20(%ebp)
  800a8e:	a1 24 30 80 00       	mov    0x803024,%eax
  800a93:	8b 50 74             	mov    0x74(%eax),%edx
  800a96:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a99:	39 c2                	cmp    %eax,%edx
  800a9b:	77 d1                	ja     800a6e <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800aa0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800aa3:	74 14                	je     800ab9 <CheckWSWithoutLastIndex+0x159>
		panic(
  800aa5:	83 ec 04             	sub    $0x4,%esp
  800aa8:	68 4c 2a 80 00       	push   $0x802a4c
  800aad:	6a 44                	push   $0x44
  800aaf:	68 ec 29 80 00       	push   $0x8029ec
  800ab4:	e8 35 fe ff ff       	call   8008ee <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800ab9:	90                   	nop
  800aba:	c9                   	leave  
  800abb:	c3                   	ret    

00800abc <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800abc:	55                   	push   %ebp
  800abd:	89 e5                	mov    %esp,%ebp
  800abf:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800ac2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac5:	8b 00                	mov    (%eax),%eax
  800ac7:	8d 48 01             	lea    0x1(%eax),%ecx
  800aca:	8b 55 0c             	mov    0xc(%ebp),%edx
  800acd:	89 0a                	mov    %ecx,(%edx)
  800acf:	8b 55 08             	mov    0x8(%ebp),%edx
  800ad2:	88 d1                	mov    %dl,%cl
  800ad4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ad7:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800adb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ade:	8b 00                	mov    (%eax),%eax
  800ae0:	3d ff 00 00 00       	cmp    $0xff,%eax
  800ae5:	75 2c                	jne    800b13 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800ae7:	a0 28 30 80 00       	mov    0x803028,%al
  800aec:	0f b6 c0             	movzbl %al,%eax
  800aef:	8b 55 0c             	mov    0xc(%ebp),%edx
  800af2:	8b 12                	mov    (%edx),%edx
  800af4:	89 d1                	mov    %edx,%ecx
  800af6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800af9:	83 c2 08             	add    $0x8,%edx
  800afc:	83 ec 04             	sub    $0x4,%esp
  800aff:	50                   	push   %eax
  800b00:	51                   	push   %ecx
  800b01:	52                   	push   %edx
  800b02:	e8 2b 13 00 00       	call   801e32 <sys_cputs>
  800b07:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800b0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800b13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b16:	8b 40 04             	mov    0x4(%eax),%eax
  800b19:	8d 50 01             	lea    0x1(%eax),%edx
  800b1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1f:	89 50 04             	mov    %edx,0x4(%eax)
}
  800b22:	90                   	nop
  800b23:	c9                   	leave  
  800b24:	c3                   	ret    

00800b25 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b25:	55                   	push   %ebp
  800b26:	89 e5                	mov    %esp,%ebp
  800b28:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b2e:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b35:	00 00 00 
	b.cnt = 0;
  800b38:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b3f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b42:	ff 75 0c             	pushl  0xc(%ebp)
  800b45:	ff 75 08             	pushl  0x8(%ebp)
  800b48:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b4e:	50                   	push   %eax
  800b4f:	68 bc 0a 80 00       	push   $0x800abc
  800b54:	e8 11 02 00 00       	call   800d6a <vprintfmt>
  800b59:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b5c:	a0 28 30 80 00       	mov    0x803028,%al
  800b61:	0f b6 c0             	movzbl %al,%eax
  800b64:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b6a:	83 ec 04             	sub    $0x4,%esp
  800b6d:	50                   	push   %eax
  800b6e:	52                   	push   %edx
  800b6f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b75:	83 c0 08             	add    $0x8,%eax
  800b78:	50                   	push   %eax
  800b79:	e8 b4 12 00 00       	call   801e32 <sys_cputs>
  800b7e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b81:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800b88:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b8e:	c9                   	leave  
  800b8f:	c3                   	ret    

00800b90 <cprintf>:

int cprintf(const char *fmt, ...) {
  800b90:	55                   	push   %ebp
  800b91:	89 e5                	mov    %esp,%ebp
  800b93:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b96:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800b9d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ba0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba6:	83 ec 08             	sub    $0x8,%esp
  800ba9:	ff 75 f4             	pushl  -0xc(%ebp)
  800bac:	50                   	push   %eax
  800bad:	e8 73 ff ff ff       	call   800b25 <vcprintf>
  800bb2:	83 c4 10             	add    $0x10,%esp
  800bb5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800bb8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bbb:	c9                   	leave  
  800bbc:	c3                   	ret    

00800bbd <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800bbd:	55                   	push   %ebp
  800bbe:	89 e5                	mov    %esp,%ebp
  800bc0:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800bc3:	e8 7b 14 00 00       	call   802043 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800bc8:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bcb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bce:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd1:	83 ec 08             	sub    $0x8,%esp
  800bd4:	ff 75 f4             	pushl  -0xc(%ebp)
  800bd7:	50                   	push   %eax
  800bd8:	e8 48 ff ff ff       	call   800b25 <vcprintf>
  800bdd:	83 c4 10             	add    $0x10,%esp
  800be0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800be3:	e8 75 14 00 00       	call   80205d <sys_enable_interrupt>
	return cnt;
  800be8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800beb:	c9                   	leave  
  800bec:	c3                   	ret    

00800bed <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800bed:	55                   	push   %ebp
  800bee:	89 e5                	mov    %esp,%ebp
  800bf0:	53                   	push   %ebx
  800bf1:	83 ec 14             	sub    $0x14,%esp
  800bf4:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bfa:	8b 45 14             	mov    0x14(%ebp),%eax
  800bfd:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800c00:	8b 45 18             	mov    0x18(%ebp),%eax
  800c03:	ba 00 00 00 00       	mov    $0x0,%edx
  800c08:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c0b:	77 55                	ja     800c62 <printnum+0x75>
  800c0d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c10:	72 05                	jb     800c17 <printnum+0x2a>
  800c12:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c15:	77 4b                	ja     800c62 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c17:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c1a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c1d:	8b 45 18             	mov    0x18(%ebp),%eax
  800c20:	ba 00 00 00 00       	mov    $0x0,%edx
  800c25:	52                   	push   %edx
  800c26:	50                   	push   %eax
  800c27:	ff 75 f4             	pushl  -0xc(%ebp)
  800c2a:	ff 75 f0             	pushl  -0x10(%ebp)
  800c2d:	e8 32 18 00 00       	call   802464 <__udivdi3>
  800c32:	83 c4 10             	add    $0x10,%esp
  800c35:	83 ec 04             	sub    $0x4,%esp
  800c38:	ff 75 20             	pushl  0x20(%ebp)
  800c3b:	53                   	push   %ebx
  800c3c:	ff 75 18             	pushl  0x18(%ebp)
  800c3f:	52                   	push   %edx
  800c40:	50                   	push   %eax
  800c41:	ff 75 0c             	pushl  0xc(%ebp)
  800c44:	ff 75 08             	pushl  0x8(%ebp)
  800c47:	e8 a1 ff ff ff       	call   800bed <printnum>
  800c4c:	83 c4 20             	add    $0x20,%esp
  800c4f:	eb 1a                	jmp    800c6b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c51:	83 ec 08             	sub    $0x8,%esp
  800c54:	ff 75 0c             	pushl  0xc(%ebp)
  800c57:	ff 75 20             	pushl  0x20(%ebp)
  800c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5d:	ff d0                	call   *%eax
  800c5f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c62:	ff 4d 1c             	decl   0x1c(%ebp)
  800c65:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c69:	7f e6                	jg     800c51 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c6b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c6e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c73:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c76:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c79:	53                   	push   %ebx
  800c7a:	51                   	push   %ecx
  800c7b:	52                   	push   %edx
  800c7c:	50                   	push   %eax
  800c7d:	e8 f2 18 00 00       	call   802574 <__umoddi3>
  800c82:	83 c4 10             	add    $0x10,%esp
  800c85:	05 b4 2c 80 00       	add    $0x802cb4,%eax
  800c8a:	8a 00                	mov    (%eax),%al
  800c8c:	0f be c0             	movsbl %al,%eax
  800c8f:	83 ec 08             	sub    $0x8,%esp
  800c92:	ff 75 0c             	pushl  0xc(%ebp)
  800c95:	50                   	push   %eax
  800c96:	8b 45 08             	mov    0x8(%ebp),%eax
  800c99:	ff d0                	call   *%eax
  800c9b:	83 c4 10             	add    $0x10,%esp
}
  800c9e:	90                   	nop
  800c9f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ca2:	c9                   	leave  
  800ca3:	c3                   	ret    

00800ca4 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ca4:	55                   	push   %ebp
  800ca5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ca7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800cab:	7e 1c                	jle    800cc9 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800cad:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb0:	8b 00                	mov    (%eax),%eax
  800cb2:	8d 50 08             	lea    0x8(%eax),%edx
  800cb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb8:	89 10                	mov    %edx,(%eax)
  800cba:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbd:	8b 00                	mov    (%eax),%eax
  800cbf:	83 e8 08             	sub    $0x8,%eax
  800cc2:	8b 50 04             	mov    0x4(%eax),%edx
  800cc5:	8b 00                	mov    (%eax),%eax
  800cc7:	eb 40                	jmp    800d09 <getuint+0x65>
	else if (lflag)
  800cc9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ccd:	74 1e                	je     800ced <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800ccf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd2:	8b 00                	mov    (%eax),%eax
  800cd4:	8d 50 04             	lea    0x4(%eax),%edx
  800cd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cda:	89 10                	mov    %edx,(%eax)
  800cdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdf:	8b 00                	mov    (%eax),%eax
  800ce1:	83 e8 04             	sub    $0x4,%eax
  800ce4:	8b 00                	mov    (%eax),%eax
  800ce6:	ba 00 00 00 00       	mov    $0x0,%edx
  800ceb:	eb 1c                	jmp    800d09 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ced:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf0:	8b 00                	mov    (%eax),%eax
  800cf2:	8d 50 04             	lea    0x4(%eax),%edx
  800cf5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf8:	89 10                	mov    %edx,(%eax)
  800cfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfd:	8b 00                	mov    (%eax),%eax
  800cff:	83 e8 04             	sub    $0x4,%eax
  800d02:	8b 00                	mov    (%eax),%eax
  800d04:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800d09:	5d                   	pop    %ebp
  800d0a:	c3                   	ret    

00800d0b <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800d0b:	55                   	push   %ebp
  800d0c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d0e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d12:	7e 1c                	jle    800d30 <getint+0x25>
		return va_arg(*ap, long long);
  800d14:	8b 45 08             	mov    0x8(%ebp),%eax
  800d17:	8b 00                	mov    (%eax),%eax
  800d19:	8d 50 08             	lea    0x8(%eax),%edx
  800d1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1f:	89 10                	mov    %edx,(%eax)
  800d21:	8b 45 08             	mov    0x8(%ebp),%eax
  800d24:	8b 00                	mov    (%eax),%eax
  800d26:	83 e8 08             	sub    $0x8,%eax
  800d29:	8b 50 04             	mov    0x4(%eax),%edx
  800d2c:	8b 00                	mov    (%eax),%eax
  800d2e:	eb 38                	jmp    800d68 <getint+0x5d>
	else if (lflag)
  800d30:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d34:	74 1a                	je     800d50 <getint+0x45>
		return va_arg(*ap, long);
  800d36:	8b 45 08             	mov    0x8(%ebp),%eax
  800d39:	8b 00                	mov    (%eax),%eax
  800d3b:	8d 50 04             	lea    0x4(%eax),%edx
  800d3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d41:	89 10                	mov    %edx,(%eax)
  800d43:	8b 45 08             	mov    0x8(%ebp),%eax
  800d46:	8b 00                	mov    (%eax),%eax
  800d48:	83 e8 04             	sub    $0x4,%eax
  800d4b:	8b 00                	mov    (%eax),%eax
  800d4d:	99                   	cltd   
  800d4e:	eb 18                	jmp    800d68 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d50:	8b 45 08             	mov    0x8(%ebp),%eax
  800d53:	8b 00                	mov    (%eax),%eax
  800d55:	8d 50 04             	lea    0x4(%eax),%edx
  800d58:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5b:	89 10                	mov    %edx,(%eax)
  800d5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d60:	8b 00                	mov    (%eax),%eax
  800d62:	83 e8 04             	sub    $0x4,%eax
  800d65:	8b 00                	mov    (%eax),%eax
  800d67:	99                   	cltd   
}
  800d68:	5d                   	pop    %ebp
  800d69:	c3                   	ret    

00800d6a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d6a:	55                   	push   %ebp
  800d6b:	89 e5                	mov    %esp,%ebp
  800d6d:	56                   	push   %esi
  800d6e:	53                   	push   %ebx
  800d6f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d72:	eb 17                	jmp    800d8b <vprintfmt+0x21>
			if (ch == '\0')
  800d74:	85 db                	test   %ebx,%ebx
  800d76:	0f 84 af 03 00 00    	je     80112b <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d7c:	83 ec 08             	sub    $0x8,%esp
  800d7f:	ff 75 0c             	pushl  0xc(%ebp)
  800d82:	53                   	push   %ebx
  800d83:	8b 45 08             	mov    0x8(%ebp),%eax
  800d86:	ff d0                	call   *%eax
  800d88:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d8b:	8b 45 10             	mov    0x10(%ebp),%eax
  800d8e:	8d 50 01             	lea    0x1(%eax),%edx
  800d91:	89 55 10             	mov    %edx,0x10(%ebp)
  800d94:	8a 00                	mov    (%eax),%al
  800d96:	0f b6 d8             	movzbl %al,%ebx
  800d99:	83 fb 25             	cmp    $0x25,%ebx
  800d9c:	75 d6                	jne    800d74 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d9e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800da2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800da9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800db0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800db7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800dbe:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc1:	8d 50 01             	lea    0x1(%eax),%edx
  800dc4:	89 55 10             	mov    %edx,0x10(%ebp)
  800dc7:	8a 00                	mov    (%eax),%al
  800dc9:	0f b6 d8             	movzbl %al,%ebx
  800dcc:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800dcf:	83 f8 55             	cmp    $0x55,%eax
  800dd2:	0f 87 2b 03 00 00    	ja     801103 <vprintfmt+0x399>
  800dd8:	8b 04 85 d8 2c 80 00 	mov    0x802cd8(,%eax,4),%eax
  800ddf:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800de1:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800de5:	eb d7                	jmp    800dbe <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800de7:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800deb:	eb d1                	jmp    800dbe <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ded:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800df4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800df7:	89 d0                	mov    %edx,%eax
  800df9:	c1 e0 02             	shl    $0x2,%eax
  800dfc:	01 d0                	add    %edx,%eax
  800dfe:	01 c0                	add    %eax,%eax
  800e00:	01 d8                	add    %ebx,%eax
  800e02:	83 e8 30             	sub    $0x30,%eax
  800e05:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800e08:	8b 45 10             	mov    0x10(%ebp),%eax
  800e0b:	8a 00                	mov    (%eax),%al
  800e0d:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800e10:	83 fb 2f             	cmp    $0x2f,%ebx
  800e13:	7e 3e                	jle    800e53 <vprintfmt+0xe9>
  800e15:	83 fb 39             	cmp    $0x39,%ebx
  800e18:	7f 39                	jg     800e53 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e1a:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e1d:	eb d5                	jmp    800df4 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e1f:	8b 45 14             	mov    0x14(%ebp),%eax
  800e22:	83 c0 04             	add    $0x4,%eax
  800e25:	89 45 14             	mov    %eax,0x14(%ebp)
  800e28:	8b 45 14             	mov    0x14(%ebp),%eax
  800e2b:	83 e8 04             	sub    $0x4,%eax
  800e2e:	8b 00                	mov    (%eax),%eax
  800e30:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e33:	eb 1f                	jmp    800e54 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e35:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e39:	79 83                	jns    800dbe <vprintfmt+0x54>
				width = 0;
  800e3b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e42:	e9 77 ff ff ff       	jmp    800dbe <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e47:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e4e:	e9 6b ff ff ff       	jmp    800dbe <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e53:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e54:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e58:	0f 89 60 ff ff ff    	jns    800dbe <vprintfmt+0x54>
				width = precision, precision = -1;
  800e5e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e61:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e64:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e6b:	e9 4e ff ff ff       	jmp    800dbe <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e70:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e73:	e9 46 ff ff ff       	jmp    800dbe <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e78:	8b 45 14             	mov    0x14(%ebp),%eax
  800e7b:	83 c0 04             	add    $0x4,%eax
  800e7e:	89 45 14             	mov    %eax,0x14(%ebp)
  800e81:	8b 45 14             	mov    0x14(%ebp),%eax
  800e84:	83 e8 04             	sub    $0x4,%eax
  800e87:	8b 00                	mov    (%eax),%eax
  800e89:	83 ec 08             	sub    $0x8,%esp
  800e8c:	ff 75 0c             	pushl  0xc(%ebp)
  800e8f:	50                   	push   %eax
  800e90:	8b 45 08             	mov    0x8(%ebp),%eax
  800e93:	ff d0                	call   *%eax
  800e95:	83 c4 10             	add    $0x10,%esp
			break;
  800e98:	e9 89 02 00 00       	jmp    801126 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e9d:	8b 45 14             	mov    0x14(%ebp),%eax
  800ea0:	83 c0 04             	add    $0x4,%eax
  800ea3:	89 45 14             	mov    %eax,0x14(%ebp)
  800ea6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ea9:	83 e8 04             	sub    $0x4,%eax
  800eac:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800eae:	85 db                	test   %ebx,%ebx
  800eb0:	79 02                	jns    800eb4 <vprintfmt+0x14a>
				err = -err;
  800eb2:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800eb4:	83 fb 64             	cmp    $0x64,%ebx
  800eb7:	7f 0b                	jg     800ec4 <vprintfmt+0x15a>
  800eb9:	8b 34 9d 20 2b 80 00 	mov    0x802b20(,%ebx,4),%esi
  800ec0:	85 f6                	test   %esi,%esi
  800ec2:	75 19                	jne    800edd <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ec4:	53                   	push   %ebx
  800ec5:	68 c5 2c 80 00       	push   $0x802cc5
  800eca:	ff 75 0c             	pushl  0xc(%ebp)
  800ecd:	ff 75 08             	pushl  0x8(%ebp)
  800ed0:	e8 5e 02 00 00       	call   801133 <printfmt>
  800ed5:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ed8:	e9 49 02 00 00       	jmp    801126 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800edd:	56                   	push   %esi
  800ede:	68 ce 2c 80 00       	push   $0x802cce
  800ee3:	ff 75 0c             	pushl  0xc(%ebp)
  800ee6:	ff 75 08             	pushl  0x8(%ebp)
  800ee9:	e8 45 02 00 00       	call   801133 <printfmt>
  800eee:	83 c4 10             	add    $0x10,%esp
			break;
  800ef1:	e9 30 02 00 00       	jmp    801126 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800ef6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ef9:	83 c0 04             	add    $0x4,%eax
  800efc:	89 45 14             	mov    %eax,0x14(%ebp)
  800eff:	8b 45 14             	mov    0x14(%ebp),%eax
  800f02:	83 e8 04             	sub    $0x4,%eax
  800f05:	8b 30                	mov    (%eax),%esi
  800f07:	85 f6                	test   %esi,%esi
  800f09:	75 05                	jne    800f10 <vprintfmt+0x1a6>
				p = "(null)";
  800f0b:	be d1 2c 80 00       	mov    $0x802cd1,%esi
			if (width > 0 && padc != '-')
  800f10:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f14:	7e 6d                	jle    800f83 <vprintfmt+0x219>
  800f16:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f1a:	74 67                	je     800f83 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f1c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f1f:	83 ec 08             	sub    $0x8,%esp
  800f22:	50                   	push   %eax
  800f23:	56                   	push   %esi
  800f24:	e8 12 05 00 00       	call   80143b <strnlen>
  800f29:	83 c4 10             	add    $0x10,%esp
  800f2c:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f2f:	eb 16                	jmp    800f47 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f31:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f35:	83 ec 08             	sub    $0x8,%esp
  800f38:	ff 75 0c             	pushl  0xc(%ebp)
  800f3b:	50                   	push   %eax
  800f3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3f:	ff d0                	call   *%eax
  800f41:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f44:	ff 4d e4             	decl   -0x1c(%ebp)
  800f47:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f4b:	7f e4                	jg     800f31 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f4d:	eb 34                	jmp    800f83 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f4f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f53:	74 1c                	je     800f71 <vprintfmt+0x207>
  800f55:	83 fb 1f             	cmp    $0x1f,%ebx
  800f58:	7e 05                	jle    800f5f <vprintfmt+0x1f5>
  800f5a:	83 fb 7e             	cmp    $0x7e,%ebx
  800f5d:	7e 12                	jle    800f71 <vprintfmt+0x207>
					putch('?', putdat);
  800f5f:	83 ec 08             	sub    $0x8,%esp
  800f62:	ff 75 0c             	pushl  0xc(%ebp)
  800f65:	6a 3f                	push   $0x3f
  800f67:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6a:	ff d0                	call   *%eax
  800f6c:	83 c4 10             	add    $0x10,%esp
  800f6f:	eb 0f                	jmp    800f80 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f71:	83 ec 08             	sub    $0x8,%esp
  800f74:	ff 75 0c             	pushl  0xc(%ebp)
  800f77:	53                   	push   %ebx
  800f78:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7b:	ff d0                	call   *%eax
  800f7d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f80:	ff 4d e4             	decl   -0x1c(%ebp)
  800f83:	89 f0                	mov    %esi,%eax
  800f85:	8d 70 01             	lea    0x1(%eax),%esi
  800f88:	8a 00                	mov    (%eax),%al
  800f8a:	0f be d8             	movsbl %al,%ebx
  800f8d:	85 db                	test   %ebx,%ebx
  800f8f:	74 24                	je     800fb5 <vprintfmt+0x24b>
  800f91:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f95:	78 b8                	js     800f4f <vprintfmt+0x1e5>
  800f97:	ff 4d e0             	decl   -0x20(%ebp)
  800f9a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f9e:	79 af                	jns    800f4f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fa0:	eb 13                	jmp    800fb5 <vprintfmt+0x24b>
				putch(' ', putdat);
  800fa2:	83 ec 08             	sub    $0x8,%esp
  800fa5:	ff 75 0c             	pushl  0xc(%ebp)
  800fa8:	6a 20                	push   $0x20
  800faa:	8b 45 08             	mov    0x8(%ebp),%eax
  800fad:	ff d0                	call   *%eax
  800faf:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fb2:	ff 4d e4             	decl   -0x1c(%ebp)
  800fb5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fb9:	7f e7                	jg     800fa2 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fbb:	e9 66 01 00 00       	jmp    801126 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800fc0:	83 ec 08             	sub    $0x8,%esp
  800fc3:	ff 75 e8             	pushl  -0x18(%ebp)
  800fc6:	8d 45 14             	lea    0x14(%ebp),%eax
  800fc9:	50                   	push   %eax
  800fca:	e8 3c fd ff ff       	call   800d0b <getint>
  800fcf:	83 c4 10             	add    $0x10,%esp
  800fd2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fd5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fdb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fde:	85 d2                	test   %edx,%edx
  800fe0:	79 23                	jns    801005 <vprintfmt+0x29b>
				putch('-', putdat);
  800fe2:	83 ec 08             	sub    $0x8,%esp
  800fe5:	ff 75 0c             	pushl  0xc(%ebp)
  800fe8:	6a 2d                	push   $0x2d
  800fea:	8b 45 08             	mov    0x8(%ebp),%eax
  800fed:	ff d0                	call   *%eax
  800fef:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ff2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ff5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ff8:	f7 d8                	neg    %eax
  800ffa:	83 d2 00             	adc    $0x0,%edx
  800ffd:	f7 da                	neg    %edx
  800fff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801002:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  801005:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80100c:	e9 bc 00 00 00       	jmp    8010cd <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801011:	83 ec 08             	sub    $0x8,%esp
  801014:	ff 75 e8             	pushl  -0x18(%ebp)
  801017:	8d 45 14             	lea    0x14(%ebp),%eax
  80101a:	50                   	push   %eax
  80101b:	e8 84 fc ff ff       	call   800ca4 <getuint>
  801020:	83 c4 10             	add    $0x10,%esp
  801023:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801026:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801029:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801030:	e9 98 00 00 00       	jmp    8010cd <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  801035:	83 ec 08             	sub    $0x8,%esp
  801038:	ff 75 0c             	pushl  0xc(%ebp)
  80103b:	6a 58                	push   $0x58
  80103d:	8b 45 08             	mov    0x8(%ebp),%eax
  801040:	ff d0                	call   *%eax
  801042:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801045:	83 ec 08             	sub    $0x8,%esp
  801048:	ff 75 0c             	pushl  0xc(%ebp)
  80104b:	6a 58                	push   $0x58
  80104d:	8b 45 08             	mov    0x8(%ebp),%eax
  801050:	ff d0                	call   *%eax
  801052:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  801055:	83 ec 08             	sub    $0x8,%esp
  801058:	ff 75 0c             	pushl  0xc(%ebp)
  80105b:	6a 58                	push   $0x58
  80105d:	8b 45 08             	mov    0x8(%ebp),%eax
  801060:	ff d0                	call   *%eax
  801062:	83 c4 10             	add    $0x10,%esp
			break;
  801065:	e9 bc 00 00 00       	jmp    801126 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80106a:	83 ec 08             	sub    $0x8,%esp
  80106d:	ff 75 0c             	pushl  0xc(%ebp)
  801070:	6a 30                	push   $0x30
  801072:	8b 45 08             	mov    0x8(%ebp),%eax
  801075:	ff d0                	call   *%eax
  801077:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80107a:	83 ec 08             	sub    $0x8,%esp
  80107d:	ff 75 0c             	pushl  0xc(%ebp)
  801080:	6a 78                	push   $0x78
  801082:	8b 45 08             	mov    0x8(%ebp),%eax
  801085:	ff d0                	call   *%eax
  801087:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80108a:	8b 45 14             	mov    0x14(%ebp),%eax
  80108d:	83 c0 04             	add    $0x4,%eax
  801090:	89 45 14             	mov    %eax,0x14(%ebp)
  801093:	8b 45 14             	mov    0x14(%ebp),%eax
  801096:	83 e8 04             	sub    $0x4,%eax
  801099:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80109b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80109e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8010a5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8010ac:	eb 1f                	jmp    8010cd <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8010ae:	83 ec 08             	sub    $0x8,%esp
  8010b1:	ff 75 e8             	pushl  -0x18(%ebp)
  8010b4:	8d 45 14             	lea    0x14(%ebp),%eax
  8010b7:	50                   	push   %eax
  8010b8:	e8 e7 fb ff ff       	call   800ca4 <getuint>
  8010bd:	83 c4 10             	add    $0x10,%esp
  8010c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010c3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010c6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010cd:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010d4:	83 ec 04             	sub    $0x4,%esp
  8010d7:	52                   	push   %edx
  8010d8:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010db:	50                   	push   %eax
  8010dc:	ff 75 f4             	pushl  -0xc(%ebp)
  8010df:	ff 75 f0             	pushl  -0x10(%ebp)
  8010e2:	ff 75 0c             	pushl  0xc(%ebp)
  8010e5:	ff 75 08             	pushl  0x8(%ebp)
  8010e8:	e8 00 fb ff ff       	call   800bed <printnum>
  8010ed:	83 c4 20             	add    $0x20,%esp
			break;
  8010f0:	eb 34                	jmp    801126 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010f2:	83 ec 08             	sub    $0x8,%esp
  8010f5:	ff 75 0c             	pushl  0xc(%ebp)
  8010f8:	53                   	push   %ebx
  8010f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fc:	ff d0                	call   *%eax
  8010fe:	83 c4 10             	add    $0x10,%esp
			break;
  801101:	eb 23                	jmp    801126 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801103:	83 ec 08             	sub    $0x8,%esp
  801106:	ff 75 0c             	pushl  0xc(%ebp)
  801109:	6a 25                	push   $0x25
  80110b:	8b 45 08             	mov    0x8(%ebp),%eax
  80110e:	ff d0                	call   *%eax
  801110:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801113:	ff 4d 10             	decl   0x10(%ebp)
  801116:	eb 03                	jmp    80111b <vprintfmt+0x3b1>
  801118:	ff 4d 10             	decl   0x10(%ebp)
  80111b:	8b 45 10             	mov    0x10(%ebp),%eax
  80111e:	48                   	dec    %eax
  80111f:	8a 00                	mov    (%eax),%al
  801121:	3c 25                	cmp    $0x25,%al
  801123:	75 f3                	jne    801118 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801125:	90                   	nop
		}
	}
  801126:	e9 47 fc ff ff       	jmp    800d72 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80112b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80112c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80112f:	5b                   	pop    %ebx
  801130:	5e                   	pop    %esi
  801131:	5d                   	pop    %ebp
  801132:	c3                   	ret    

00801133 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801133:	55                   	push   %ebp
  801134:	89 e5                	mov    %esp,%ebp
  801136:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801139:	8d 45 10             	lea    0x10(%ebp),%eax
  80113c:	83 c0 04             	add    $0x4,%eax
  80113f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801142:	8b 45 10             	mov    0x10(%ebp),%eax
  801145:	ff 75 f4             	pushl  -0xc(%ebp)
  801148:	50                   	push   %eax
  801149:	ff 75 0c             	pushl  0xc(%ebp)
  80114c:	ff 75 08             	pushl  0x8(%ebp)
  80114f:	e8 16 fc ff ff       	call   800d6a <vprintfmt>
  801154:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801157:	90                   	nop
  801158:	c9                   	leave  
  801159:	c3                   	ret    

0080115a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80115a:	55                   	push   %ebp
  80115b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80115d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801160:	8b 40 08             	mov    0x8(%eax),%eax
  801163:	8d 50 01             	lea    0x1(%eax),%edx
  801166:	8b 45 0c             	mov    0xc(%ebp),%eax
  801169:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80116c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116f:	8b 10                	mov    (%eax),%edx
  801171:	8b 45 0c             	mov    0xc(%ebp),%eax
  801174:	8b 40 04             	mov    0x4(%eax),%eax
  801177:	39 c2                	cmp    %eax,%edx
  801179:	73 12                	jae    80118d <sprintputch+0x33>
		*b->buf++ = ch;
  80117b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80117e:	8b 00                	mov    (%eax),%eax
  801180:	8d 48 01             	lea    0x1(%eax),%ecx
  801183:	8b 55 0c             	mov    0xc(%ebp),%edx
  801186:	89 0a                	mov    %ecx,(%edx)
  801188:	8b 55 08             	mov    0x8(%ebp),%edx
  80118b:	88 10                	mov    %dl,(%eax)
}
  80118d:	90                   	nop
  80118e:	5d                   	pop    %ebp
  80118f:	c3                   	ret    

00801190 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801190:	55                   	push   %ebp
  801191:	89 e5                	mov    %esp,%ebp
  801193:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801196:	8b 45 08             	mov    0x8(%ebp),%eax
  801199:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80119c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119f:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a5:	01 d0                	add    %edx,%eax
  8011a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011aa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8011b1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011b5:	74 06                	je     8011bd <vsnprintf+0x2d>
  8011b7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011bb:	7f 07                	jg     8011c4 <vsnprintf+0x34>
		return -E_INVAL;
  8011bd:	b8 03 00 00 00       	mov    $0x3,%eax
  8011c2:	eb 20                	jmp    8011e4 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011c4:	ff 75 14             	pushl  0x14(%ebp)
  8011c7:	ff 75 10             	pushl  0x10(%ebp)
  8011ca:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011cd:	50                   	push   %eax
  8011ce:	68 5a 11 80 00       	push   $0x80115a
  8011d3:	e8 92 fb ff ff       	call   800d6a <vprintfmt>
  8011d8:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011db:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011de:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011e4:	c9                   	leave  
  8011e5:	c3                   	ret    

008011e6 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011e6:	55                   	push   %ebp
  8011e7:	89 e5                	mov    %esp,%ebp
  8011e9:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011ec:	8d 45 10             	lea    0x10(%ebp),%eax
  8011ef:	83 c0 04             	add    $0x4,%eax
  8011f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011f5:	8b 45 10             	mov    0x10(%ebp),%eax
  8011f8:	ff 75 f4             	pushl  -0xc(%ebp)
  8011fb:	50                   	push   %eax
  8011fc:	ff 75 0c             	pushl  0xc(%ebp)
  8011ff:	ff 75 08             	pushl  0x8(%ebp)
  801202:	e8 89 ff ff ff       	call   801190 <vsnprintf>
  801207:	83 c4 10             	add    $0x10,%esp
  80120a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80120d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801210:	c9                   	leave  
  801211:	c3                   	ret    

00801212 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801212:	55                   	push   %ebp
  801213:	89 e5                	mov    %esp,%ebp
  801215:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801218:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80121c:	74 13                	je     801231 <readline+0x1f>
		cprintf("%s", prompt);
  80121e:	83 ec 08             	sub    $0x8,%esp
  801221:	ff 75 08             	pushl  0x8(%ebp)
  801224:	68 30 2e 80 00       	push   $0x802e30
  801229:	e8 62 f9 ff ff       	call   800b90 <cprintf>
  80122e:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801231:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801238:	83 ec 0c             	sub    $0xc,%esp
  80123b:	6a 00                	push   $0x0
  80123d:	e8 5d f5 ff ff       	call   80079f <iscons>
  801242:	83 c4 10             	add    $0x10,%esp
  801245:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801248:	e8 04 f5 ff ff       	call   800751 <getchar>
  80124d:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801250:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801254:	79 22                	jns    801278 <readline+0x66>
			if (c != -E_EOF)
  801256:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80125a:	0f 84 ad 00 00 00    	je     80130d <readline+0xfb>
				cprintf("read error: %e\n", c);
  801260:	83 ec 08             	sub    $0x8,%esp
  801263:	ff 75 ec             	pushl  -0x14(%ebp)
  801266:	68 33 2e 80 00       	push   $0x802e33
  80126b:	e8 20 f9 ff ff       	call   800b90 <cprintf>
  801270:	83 c4 10             	add    $0x10,%esp
			return;
  801273:	e9 95 00 00 00       	jmp    80130d <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801278:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80127c:	7e 34                	jle    8012b2 <readline+0xa0>
  80127e:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801285:	7f 2b                	jg     8012b2 <readline+0xa0>
			if (echoing)
  801287:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80128b:	74 0e                	je     80129b <readline+0x89>
				cputchar(c);
  80128d:	83 ec 0c             	sub    $0xc,%esp
  801290:	ff 75 ec             	pushl  -0x14(%ebp)
  801293:	e8 71 f4 ff ff       	call   800709 <cputchar>
  801298:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80129b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80129e:	8d 50 01             	lea    0x1(%eax),%edx
  8012a1:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8012a4:	89 c2                	mov    %eax,%edx
  8012a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a9:	01 d0                	add    %edx,%eax
  8012ab:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012ae:	88 10                	mov    %dl,(%eax)
  8012b0:	eb 56                	jmp    801308 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8012b2:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8012b6:	75 1f                	jne    8012d7 <readline+0xc5>
  8012b8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8012bc:	7e 19                	jle    8012d7 <readline+0xc5>
			if (echoing)
  8012be:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012c2:	74 0e                	je     8012d2 <readline+0xc0>
				cputchar(c);
  8012c4:	83 ec 0c             	sub    $0xc,%esp
  8012c7:	ff 75 ec             	pushl  -0x14(%ebp)
  8012ca:	e8 3a f4 ff ff       	call   800709 <cputchar>
  8012cf:	83 c4 10             	add    $0x10,%esp

			i--;
  8012d2:	ff 4d f4             	decl   -0xc(%ebp)
  8012d5:	eb 31                	jmp    801308 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8012d7:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012db:	74 0a                	je     8012e7 <readline+0xd5>
  8012dd:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012e1:	0f 85 61 ff ff ff    	jne    801248 <readline+0x36>
			if (echoing)
  8012e7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012eb:	74 0e                	je     8012fb <readline+0xe9>
				cputchar(c);
  8012ed:	83 ec 0c             	sub    $0xc,%esp
  8012f0:	ff 75 ec             	pushl  -0x14(%ebp)
  8012f3:	e8 11 f4 ff ff       	call   800709 <cputchar>
  8012f8:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8012fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801301:	01 d0                	add    %edx,%eax
  801303:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801306:	eb 06                	jmp    80130e <readline+0xfc>
		}
	}
  801308:	e9 3b ff ff ff       	jmp    801248 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  80130d:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  80130e:	c9                   	leave  
  80130f:	c3                   	ret    

00801310 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801310:	55                   	push   %ebp
  801311:	89 e5                	mov    %esp,%ebp
  801313:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801316:	e8 28 0d 00 00       	call   802043 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  80131b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80131f:	74 13                	je     801334 <atomic_readline+0x24>
		cprintf("%s", prompt);
  801321:	83 ec 08             	sub    $0x8,%esp
  801324:	ff 75 08             	pushl  0x8(%ebp)
  801327:	68 30 2e 80 00       	push   $0x802e30
  80132c:	e8 5f f8 ff ff       	call   800b90 <cprintf>
  801331:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801334:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80133b:	83 ec 0c             	sub    $0xc,%esp
  80133e:	6a 00                	push   $0x0
  801340:	e8 5a f4 ff ff       	call   80079f <iscons>
  801345:	83 c4 10             	add    $0x10,%esp
  801348:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80134b:	e8 01 f4 ff ff       	call   800751 <getchar>
  801350:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801353:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801357:	79 23                	jns    80137c <atomic_readline+0x6c>
			if (c != -E_EOF)
  801359:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80135d:	74 13                	je     801372 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  80135f:	83 ec 08             	sub    $0x8,%esp
  801362:	ff 75 ec             	pushl  -0x14(%ebp)
  801365:	68 33 2e 80 00       	push   $0x802e33
  80136a:	e8 21 f8 ff ff       	call   800b90 <cprintf>
  80136f:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801372:	e8 e6 0c 00 00       	call   80205d <sys_enable_interrupt>
			return;
  801377:	e9 9a 00 00 00       	jmp    801416 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80137c:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801380:	7e 34                	jle    8013b6 <atomic_readline+0xa6>
  801382:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801389:	7f 2b                	jg     8013b6 <atomic_readline+0xa6>
			if (echoing)
  80138b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80138f:	74 0e                	je     80139f <atomic_readline+0x8f>
				cputchar(c);
  801391:	83 ec 0c             	sub    $0xc,%esp
  801394:	ff 75 ec             	pushl  -0x14(%ebp)
  801397:	e8 6d f3 ff ff       	call   800709 <cputchar>
  80139c:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80139f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013a2:	8d 50 01             	lea    0x1(%eax),%edx
  8013a5:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8013a8:	89 c2                	mov    %eax,%edx
  8013aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ad:	01 d0                	add    %edx,%eax
  8013af:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013b2:	88 10                	mov    %dl,(%eax)
  8013b4:	eb 5b                	jmp    801411 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8013b6:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8013ba:	75 1f                	jne    8013db <atomic_readline+0xcb>
  8013bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8013c0:	7e 19                	jle    8013db <atomic_readline+0xcb>
			if (echoing)
  8013c2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013c6:	74 0e                	je     8013d6 <atomic_readline+0xc6>
				cputchar(c);
  8013c8:	83 ec 0c             	sub    $0xc,%esp
  8013cb:	ff 75 ec             	pushl  -0x14(%ebp)
  8013ce:	e8 36 f3 ff ff       	call   800709 <cputchar>
  8013d3:	83 c4 10             	add    $0x10,%esp
			i--;
  8013d6:	ff 4d f4             	decl   -0xc(%ebp)
  8013d9:	eb 36                	jmp    801411 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8013db:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8013df:	74 0a                	je     8013eb <atomic_readline+0xdb>
  8013e1:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8013e5:	0f 85 60 ff ff ff    	jne    80134b <atomic_readline+0x3b>
			if (echoing)
  8013eb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013ef:	74 0e                	je     8013ff <atomic_readline+0xef>
				cputchar(c);
  8013f1:	83 ec 0c             	sub    $0xc,%esp
  8013f4:	ff 75 ec             	pushl  -0x14(%ebp)
  8013f7:	e8 0d f3 ff ff       	call   800709 <cputchar>
  8013fc:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8013ff:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801402:	8b 45 0c             	mov    0xc(%ebp),%eax
  801405:	01 d0                	add    %edx,%eax
  801407:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  80140a:	e8 4e 0c 00 00       	call   80205d <sys_enable_interrupt>
			return;
  80140f:	eb 05                	jmp    801416 <atomic_readline+0x106>
		}
	}
  801411:	e9 35 ff ff ff       	jmp    80134b <atomic_readline+0x3b>
}
  801416:	c9                   	leave  
  801417:	c3                   	ret    

00801418 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801418:	55                   	push   %ebp
  801419:	89 e5                	mov    %esp,%ebp
  80141b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80141e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801425:	eb 06                	jmp    80142d <strlen+0x15>
		n++;
  801427:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80142a:	ff 45 08             	incl   0x8(%ebp)
  80142d:	8b 45 08             	mov    0x8(%ebp),%eax
  801430:	8a 00                	mov    (%eax),%al
  801432:	84 c0                	test   %al,%al
  801434:	75 f1                	jne    801427 <strlen+0xf>
		n++;
	return n;
  801436:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801439:	c9                   	leave  
  80143a:	c3                   	ret    

0080143b <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80143b:	55                   	push   %ebp
  80143c:	89 e5                	mov    %esp,%ebp
  80143e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801441:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801448:	eb 09                	jmp    801453 <strnlen+0x18>
		n++;
  80144a:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80144d:	ff 45 08             	incl   0x8(%ebp)
  801450:	ff 4d 0c             	decl   0xc(%ebp)
  801453:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801457:	74 09                	je     801462 <strnlen+0x27>
  801459:	8b 45 08             	mov    0x8(%ebp),%eax
  80145c:	8a 00                	mov    (%eax),%al
  80145e:	84 c0                	test   %al,%al
  801460:	75 e8                	jne    80144a <strnlen+0xf>
		n++;
	return n;
  801462:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801465:	c9                   	leave  
  801466:	c3                   	ret    

00801467 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801467:	55                   	push   %ebp
  801468:	89 e5                	mov    %esp,%ebp
  80146a:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80146d:	8b 45 08             	mov    0x8(%ebp),%eax
  801470:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801473:	90                   	nop
  801474:	8b 45 08             	mov    0x8(%ebp),%eax
  801477:	8d 50 01             	lea    0x1(%eax),%edx
  80147a:	89 55 08             	mov    %edx,0x8(%ebp)
  80147d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801480:	8d 4a 01             	lea    0x1(%edx),%ecx
  801483:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801486:	8a 12                	mov    (%edx),%dl
  801488:	88 10                	mov    %dl,(%eax)
  80148a:	8a 00                	mov    (%eax),%al
  80148c:	84 c0                	test   %al,%al
  80148e:	75 e4                	jne    801474 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801490:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801493:	c9                   	leave  
  801494:	c3                   	ret    

00801495 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801495:	55                   	push   %ebp
  801496:	89 e5                	mov    %esp,%ebp
  801498:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80149b:	8b 45 08             	mov    0x8(%ebp),%eax
  80149e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8014a1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014a8:	eb 1f                	jmp    8014c9 <strncpy+0x34>
		*dst++ = *src;
  8014aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ad:	8d 50 01             	lea    0x1(%eax),%edx
  8014b0:	89 55 08             	mov    %edx,0x8(%ebp)
  8014b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014b6:	8a 12                	mov    (%edx),%dl
  8014b8:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8014ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014bd:	8a 00                	mov    (%eax),%al
  8014bf:	84 c0                	test   %al,%al
  8014c1:	74 03                	je     8014c6 <strncpy+0x31>
			src++;
  8014c3:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8014c6:	ff 45 fc             	incl   -0x4(%ebp)
  8014c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014cc:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014cf:	72 d9                	jb     8014aa <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8014d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014d4:	c9                   	leave  
  8014d5:	c3                   	ret    

008014d6 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8014d6:	55                   	push   %ebp
  8014d7:	89 e5                	mov    %esp,%ebp
  8014d9:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8014dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014df:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8014e2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014e6:	74 30                	je     801518 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8014e8:	eb 16                	jmp    801500 <strlcpy+0x2a>
			*dst++ = *src++;
  8014ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ed:	8d 50 01             	lea    0x1(%eax),%edx
  8014f0:	89 55 08             	mov    %edx,0x8(%ebp)
  8014f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014f6:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014f9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8014fc:	8a 12                	mov    (%edx),%dl
  8014fe:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801500:	ff 4d 10             	decl   0x10(%ebp)
  801503:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801507:	74 09                	je     801512 <strlcpy+0x3c>
  801509:	8b 45 0c             	mov    0xc(%ebp),%eax
  80150c:	8a 00                	mov    (%eax),%al
  80150e:	84 c0                	test   %al,%al
  801510:	75 d8                	jne    8014ea <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801512:	8b 45 08             	mov    0x8(%ebp),%eax
  801515:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801518:	8b 55 08             	mov    0x8(%ebp),%edx
  80151b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80151e:	29 c2                	sub    %eax,%edx
  801520:	89 d0                	mov    %edx,%eax
}
  801522:	c9                   	leave  
  801523:	c3                   	ret    

00801524 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801524:	55                   	push   %ebp
  801525:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801527:	eb 06                	jmp    80152f <strcmp+0xb>
		p++, q++;
  801529:	ff 45 08             	incl   0x8(%ebp)
  80152c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80152f:	8b 45 08             	mov    0x8(%ebp),%eax
  801532:	8a 00                	mov    (%eax),%al
  801534:	84 c0                	test   %al,%al
  801536:	74 0e                	je     801546 <strcmp+0x22>
  801538:	8b 45 08             	mov    0x8(%ebp),%eax
  80153b:	8a 10                	mov    (%eax),%dl
  80153d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801540:	8a 00                	mov    (%eax),%al
  801542:	38 c2                	cmp    %al,%dl
  801544:	74 e3                	je     801529 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801546:	8b 45 08             	mov    0x8(%ebp),%eax
  801549:	8a 00                	mov    (%eax),%al
  80154b:	0f b6 d0             	movzbl %al,%edx
  80154e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801551:	8a 00                	mov    (%eax),%al
  801553:	0f b6 c0             	movzbl %al,%eax
  801556:	29 c2                	sub    %eax,%edx
  801558:	89 d0                	mov    %edx,%eax
}
  80155a:	5d                   	pop    %ebp
  80155b:	c3                   	ret    

0080155c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  80155c:	55                   	push   %ebp
  80155d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80155f:	eb 09                	jmp    80156a <strncmp+0xe>
		n--, p++, q++;
  801561:	ff 4d 10             	decl   0x10(%ebp)
  801564:	ff 45 08             	incl   0x8(%ebp)
  801567:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80156a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80156e:	74 17                	je     801587 <strncmp+0x2b>
  801570:	8b 45 08             	mov    0x8(%ebp),%eax
  801573:	8a 00                	mov    (%eax),%al
  801575:	84 c0                	test   %al,%al
  801577:	74 0e                	je     801587 <strncmp+0x2b>
  801579:	8b 45 08             	mov    0x8(%ebp),%eax
  80157c:	8a 10                	mov    (%eax),%dl
  80157e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801581:	8a 00                	mov    (%eax),%al
  801583:	38 c2                	cmp    %al,%dl
  801585:	74 da                	je     801561 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801587:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80158b:	75 07                	jne    801594 <strncmp+0x38>
		return 0;
  80158d:	b8 00 00 00 00       	mov    $0x0,%eax
  801592:	eb 14                	jmp    8015a8 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801594:	8b 45 08             	mov    0x8(%ebp),%eax
  801597:	8a 00                	mov    (%eax),%al
  801599:	0f b6 d0             	movzbl %al,%edx
  80159c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159f:	8a 00                	mov    (%eax),%al
  8015a1:	0f b6 c0             	movzbl %al,%eax
  8015a4:	29 c2                	sub    %eax,%edx
  8015a6:	89 d0                	mov    %edx,%eax
}
  8015a8:	5d                   	pop    %ebp
  8015a9:	c3                   	ret    

008015aa <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8015aa:	55                   	push   %ebp
  8015ab:	89 e5                	mov    %esp,%ebp
  8015ad:	83 ec 04             	sub    $0x4,%esp
  8015b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015b6:	eb 12                	jmp    8015ca <strchr+0x20>
		if (*s == c)
  8015b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bb:	8a 00                	mov    (%eax),%al
  8015bd:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015c0:	75 05                	jne    8015c7 <strchr+0x1d>
			return (char *) s;
  8015c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c5:	eb 11                	jmp    8015d8 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8015c7:	ff 45 08             	incl   0x8(%ebp)
  8015ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cd:	8a 00                	mov    (%eax),%al
  8015cf:	84 c0                	test   %al,%al
  8015d1:	75 e5                	jne    8015b8 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8015d3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015d8:	c9                   	leave  
  8015d9:	c3                   	ret    

008015da <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8015da:	55                   	push   %ebp
  8015db:	89 e5                	mov    %esp,%ebp
  8015dd:	83 ec 04             	sub    $0x4,%esp
  8015e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015e6:	eb 0d                	jmp    8015f5 <strfind+0x1b>
		if (*s == c)
  8015e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015eb:	8a 00                	mov    (%eax),%al
  8015ed:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015f0:	74 0e                	je     801600 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8015f2:	ff 45 08             	incl   0x8(%ebp)
  8015f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f8:	8a 00                	mov    (%eax),%al
  8015fa:	84 c0                	test   %al,%al
  8015fc:	75 ea                	jne    8015e8 <strfind+0xe>
  8015fe:	eb 01                	jmp    801601 <strfind+0x27>
		if (*s == c)
			break;
  801600:	90                   	nop
	return (char *) s;
  801601:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801604:	c9                   	leave  
  801605:	c3                   	ret    

00801606 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801606:	55                   	push   %ebp
  801607:	89 e5                	mov    %esp,%ebp
  801609:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  80160c:	8b 45 08             	mov    0x8(%ebp),%eax
  80160f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801612:	8b 45 10             	mov    0x10(%ebp),%eax
  801615:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801618:	eb 0e                	jmp    801628 <memset+0x22>
		*p++ = c;
  80161a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80161d:	8d 50 01             	lea    0x1(%eax),%edx
  801620:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801623:	8b 55 0c             	mov    0xc(%ebp),%edx
  801626:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801628:	ff 4d f8             	decl   -0x8(%ebp)
  80162b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80162f:	79 e9                	jns    80161a <memset+0x14>
		*p++ = c;

	return v;
  801631:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801634:	c9                   	leave  
  801635:	c3                   	ret    

00801636 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801636:	55                   	push   %ebp
  801637:	89 e5                	mov    %esp,%ebp
  801639:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80163c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80163f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801642:	8b 45 08             	mov    0x8(%ebp),%eax
  801645:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801648:	eb 16                	jmp    801660 <memcpy+0x2a>
		*d++ = *s++;
  80164a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80164d:	8d 50 01             	lea    0x1(%eax),%edx
  801650:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801653:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801656:	8d 4a 01             	lea    0x1(%edx),%ecx
  801659:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80165c:	8a 12                	mov    (%edx),%dl
  80165e:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801660:	8b 45 10             	mov    0x10(%ebp),%eax
  801663:	8d 50 ff             	lea    -0x1(%eax),%edx
  801666:	89 55 10             	mov    %edx,0x10(%ebp)
  801669:	85 c0                	test   %eax,%eax
  80166b:	75 dd                	jne    80164a <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80166d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801670:	c9                   	leave  
  801671:	c3                   	ret    

00801672 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801672:	55                   	push   %ebp
  801673:	89 e5                	mov    %esp,%ebp
  801675:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801678:	8b 45 0c             	mov    0xc(%ebp),%eax
  80167b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80167e:	8b 45 08             	mov    0x8(%ebp),%eax
  801681:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801684:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801687:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80168a:	73 50                	jae    8016dc <memmove+0x6a>
  80168c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80168f:	8b 45 10             	mov    0x10(%ebp),%eax
  801692:	01 d0                	add    %edx,%eax
  801694:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801697:	76 43                	jbe    8016dc <memmove+0x6a>
		s += n;
  801699:	8b 45 10             	mov    0x10(%ebp),%eax
  80169c:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80169f:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a2:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8016a5:	eb 10                	jmp    8016b7 <memmove+0x45>
			*--d = *--s;
  8016a7:	ff 4d f8             	decl   -0x8(%ebp)
  8016aa:	ff 4d fc             	decl   -0x4(%ebp)
  8016ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016b0:	8a 10                	mov    (%eax),%dl
  8016b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016b5:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8016b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ba:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016bd:	89 55 10             	mov    %edx,0x10(%ebp)
  8016c0:	85 c0                	test   %eax,%eax
  8016c2:	75 e3                	jne    8016a7 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8016c4:	eb 23                	jmp    8016e9 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8016c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016c9:	8d 50 01             	lea    0x1(%eax),%edx
  8016cc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016cf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016d2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016d5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016d8:	8a 12                	mov    (%edx),%dl
  8016da:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8016dc:	8b 45 10             	mov    0x10(%ebp),%eax
  8016df:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016e2:	89 55 10             	mov    %edx,0x10(%ebp)
  8016e5:	85 c0                	test   %eax,%eax
  8016e7:	75 dd                	jne    8016c6 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8016e9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016ec:	c9                   	leave  
  8016ed:	c3                   	ret    

008016ee <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8016ee:	55                   	push   %ebp
  8016ef:	89 e5                	mov    %esp,%ebp
  8016f1:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8016f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8016fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016fd:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801700:	eb 2a                	jmp    80172c <memcmp+0x3e>
		if (*s1 != *s2)
  801702:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801705:	8a 10                	mov    (%eax),%dl
  801707:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80170a:	8a 00                	mov    (%eax),%al
  80170c:	38 c2                	cmp    %al,%dl
  80170e:	74 16                	je     801726 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801710:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801713:	8a 00                	mov    (%eax),%al
  801715:	0f b6 d0             	movzbl %al,%edx
  801718:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80171b:	8a 00                	mov    (%eax),%al
  80171d:	0f b6 c0             	movzbl %al,%eax
  801720:	29 c2                	sub    %eax,%edx
  801722:	89 d0                	mov    %edx,%eax
  801724:	eb 18                	jmp    80173e <memcmp+0x50>
		s1++, s2++;
  801726:	ff 45 fc             	incl   -0x4(%ebp)
  801729:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  80172c:	8b 45 10             	mov    0x10(%ebp),%eax
  80172f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801732:	89 55 10             	mov    %edx,0x10(%ebp)
  801735:	85 c0                	test   %eax,%eax
  801737:	75 c9                	jne    801702 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801739:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80173e:	c9                   	leave  
  80173f:	c3                   	ret    

00801740 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801740:	55                   	push   %ebp
  801741:	89 e5                	mov    %esp,%ebp
  801743:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801746:	8b 55 08             	mov    0x8(%ebp),%edx
  801749:	8b 45 10             	mov    0x10(%ebp),%eax
  80174c:	01 d0                	add    %edx,%eax
  80174e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801751:	eb 15                	jmp    801768 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801753:	8b 45 08             	mov    0x8(%ebp),%eax
  801756:	8a 00                	mov    (%eax),%al
  801758:	0f b6 d0             	movzbl %al,%edx
  80175b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80175e:	0f b6 c0             	movzbl %al,%eax
  801761:	39 c2                	cmp    %eax,%edx
  801763:	74 0d                	je     801772 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801765:	ff 45 08             	incl   0x8(%ebp)
  801768:	8b 45 08             	mov    0x8(%ebp),%eax
  80176b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80176e:	72 e3                	jb     801753 <memfind+0x13>
  801770:	eb 01                	jmp    801773 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801772:	90                   	nop
	return (void *) s;
  801773:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801776:	c9                   	leave  
  801777:	c3                   	ret    

00801778 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801778:	55                   	push   %ebp
  801779:	89 e5                	mov    %esp,%ebp
  80177b:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80177e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801785:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80178c:	eb 03                	jmp    801791 <strtol+0x19>
		s++;
  80178e:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801791:	8b 45 08             	mov    0x8(%ebp),%eax
  801794:	8a 00                	mov    (%eax),%al
  801796:	3c 20                	cmp    $0x20,%al
  801798:	74 f4                	je     80178e <strtol+0x16>
  80179a:	8b 45 08             	mov    0x8(%ebp),%eax
  80179d:	8a 00                	mov    (%eax),%al
  80179f:	3c 09                	cmp    $0x9,%al
  8017a1:	74 eb                	je     80178e <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8017a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a6:	8a 00                	mov    (%eax),%al
  8017a8:	3c 2b                	cmp    $0x2b,%al
  8017aa:	75 05                	jne    8017b1 <strtol+0x39>
		s++;
  8017ac:	ff 45 08             	incl   0x8(%ebp)
  8017af:	eb 13                	jmp    8017c4 <strtol+0x4c>
	else if (*s == '-')
  8017b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b4:	8a 00                	mov    (%eax),%al
  8017b6:	3c 2d                	cmp    $0x2d,%al
  8017b8:	75 0a                	jne    8017c4 <strtol+0x4c>
		s++, neg = 1;
  8017ba:	ff 45 08             	incl   0x8(%ebp)
  8017bd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8017c4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017c8:	74 06                	je     8017d0 <strtol+0x58>
  8017ca:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8017ce:	75 20                	jne    8017f0 <strtol+0x78>
  8017d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d3:	8a 00                	mov    (%eax),%al
  8017d5:	3c 30                	cmp    $0x30,%al
  8017d7:	75 17                	jne    8017f0 <strtol+0x78>
  8017d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017dc:	40                   	inc    %eax
  8017dd:	8a 00                	mov    (%eax),%al
  8017df:	3c 78                	cmp    $0x78,%al
  8017e1:	75 0d                	jne    8017f0 <strtol+0x78>
		s += 2, base = 16;
  8017e3:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8017e7:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8017ee:	eb 28                	jmp    801818 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8017f0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017f4:	75 15                	jne    80180b <strtol+0x93>
  8017f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f9:	8a 00                	mov    (%eax),%al
  8017fb:	3c 30                	cmp    $0x30,%al
  8017fd:	75 0c                	jne    80180b <strtol+0x93>
		s++, base = 8;
  8017ff:	ff 45 08             	incl   0x8(%ebp)
  801802:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801809:	eb 0d                	jmp    801818 <strtol+0xa0>
	else if (base == 0)
  80180b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80180f:	75 07                	jne    801818 <strtol+0xa0>
		base = 10;
  801811:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801818:	8b 45 08             	mov    0x8(%ebp),%eax
  80181b:	8a 00                	mov    (%eax),%al
  80181d:	3c 2f                	cmp    $0x2f,%al
  80181f:	7e 19                	jle    80183a <strtol+0xc2>
  801821:	8b 45 08             	mov    0x8(%ebp),%eax
  801824:	8a 00                	mov    (%eax),%al
  801826:	3c 39                	cmp    $0x39,%al
  801828:	7f 10                	jg     80183a <strtol+0xc2>
			dig = *s - '0';
  80182a:	8b 45 08             	mov    0x8(%ebp),%eax
  80182d:	8a 00                	mov    (%eax),%al
  80182f:	0f be c0             	movsbl %al,%eax
  801832:	83 e8 30             	sub    $0x30,%eax
  801835:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801838:	eb 42                	jmp    80187c <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80183a:	8b 45 08             	mov    0x8(%ebp),%eax
  80183d:	8a 00                	mov    (%eax),%al
  80183f:	3c 60                	cmp    $0x60,%al
  801841:	7e 19                	jle    80185c <strtol+0xe4>
  801843:	8b 45 08             	mov    0x8(%ebp),%eax
  801846:	8a 00                	mov    (%eax),%al
  801848:	3c 7a                	cmp    $0x7a,%al
  80184a:	7f 10                	jg     80185c <strtol+0xe4>
			dig = *s - 'a' + 10;
  80184c:	8b 45 08             	mov    0x8(%ebp),%eax
  80184f:	8a 00                	mov    (%eax),%al
  801851:	0f be c0             	movsbl %al,%eax
  801854:	83 e8 57             	sub    $0x57,%eax
  801857:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80185a:	eb 20                	jmp    80187c <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80185c:	8b 45 08             	mov    0x8(%ebp),%eax
  80185f:	8a 00                	mov    (%eax),%al
  801861:	3c 40                	cmp    $0x40,%al
  801863:	7e 39                	jle    80189e <strtol+0x126>
  801865:	8b 45 08             	mov    0x8(%ebp),%eax
  801868:	8a 00                	mov    (%eax),%al
  80186a:	3c 5a                	cmp    $0x5a,%al
  80186c:	7f 30                	jg     80189e <strtol+0x126>
			dig = *s - 'A' + 10;
  80186e:	8b 45 08             	mov    0x8(%ebp),%eax
  801871:	8a 00                	mov    (%eax),%al
  801873:	0f be c0             	movsbl %al,%eax
  801876:	83 e8 37             	sub    $0x37,%eax
  801879:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80187c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80187f:	3b 45 10             	cmp    0x10(%ebp),%eax
  801882:	7d 19                	jge    80189d <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801884:	ff 45 08             	incl   0x8(%ebp)
  801887:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80188a:	0f af 45 10          	imul   0x10(%ebp),%eax
  80188e:	89 c2                	mov    %eax,%edx
  801890:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801893:	01 d0                	add    %edx,%eax
  801895:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801898:	e9 7b ff ff ff       	jmp    801818 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80189d:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80189e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8018a2:	74 08                	je     8018ac <strtol+0x134>
		*endptr = (char *) s;
  8018a4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018a7:	8b 55 08             	mov    0x8(%ebp),%edx
  8018aa:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8018ac:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8018b0:	74 07                	je     8018b9 <strtol+0x141>
  8018b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018b5:	f7 d8                	neg    %eax
  8018b7:	eb 03                	jmp    8018bc <strtol+0x144>
  8018b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8018bc:	c9                   	leave  
  8018bd:	c3                   	ret    

008018be <ltostr>:

void
ltostr(long value, char *str)
{
  8018be:	55                   	push   %ebp
  8018bf:	89 e5                	mov    %esp,%ebp
  8018c1:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8018c4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8018cb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8018d2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018d6:	79 13                	jns    8018eb <ltostr+0x2d>
	{
		neg = 1;
  8018d8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8018df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018e2:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8018e5:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8018e8:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8018eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ee:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8018f3:	99                   	cltd   
  8018f4:	f7 f9                	idiv   %ecx
  8018f6:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8018f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018fc:	8d 50 01             	lea    0x1(%eax),%edx
  8018ff:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801902:	89 c2                	mov    %eax,%edx
  801904:	8b 45 0c             	mov    0xc(%ebp),%eax
  801907:	01 d0                	add    %edx,%eax
  801909:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80190c:	83 c2 30             	add    $0x30,%edx
  80190f:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801911:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801914:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801919:	f7 e9                	imul   %ecx
  80191b:	c1 fa 02             	sar    $0x2,%edx
  80191e:	89 c8                	mov    %ecx,%eax
  801920:	c1 f8 1f             	sar    $0x1f,%eax
  801923:	29 c2                	sub    %eax,%edx
  801925:	89 d0                	mov    %edx,%eax
  801927:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80192a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80192d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801932:	f7 e9                	imul   %ecx
  801934:	c1 fa 02             	sar    $0x2,%edx
  801937:	89 c8                	mov    %ecx,%eax
  801939:	c1 f8 1f             	sar    $0x1f,%eax
  80193c:	29 c2                	sub    %eax,%edx
  80193e:	89 d0                	mov    %edx,%eax
  801940:	c1 e0 02             	shl    $0x2,%eax
  801943:	01 d0                	add    %edx,%eax
  801945:	01 c0                	add    %eax,%eax
  801947:	29 c1                	sub    %eax,%ecx
  801949:	89 ca                	mov    %ecx,%edx
  80194b:	85 d2                	test   %edx,%edx
  80194d:	75 9c                	jne    8018eb <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80194f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801956:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801959:	48                   	dec    %eax
  80195a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80195d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801961:	74 3d                	je     8019a0 <ltostr+0xe2>
		start = 1 ;
  801963:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80196a:	eb 34                	jmp    8019a0 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80196c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80196f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801972:	01 d0                	add    %edx,%eax
  801974:	8a 00                	mov    (%eax),%al
  801976:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801979:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80197c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80197f:	01 c2                	add    %eax,%edx
  801981:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801984:	8b 45 0c             	mov    0xc(%ebp),%eax
  801987:	01 c8                	add    %ecx,%eax
  801989:	8a 00                	mov    (%eax),%al
  80198b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80198d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801990:	8b 45 0c             	mov    0xc(%ebp),%eax
  801993:	01 c2                	add    %eax,%edx
  801995:	8a 45 eb             	mov    -0x15(%ebp),%al
  801998:	88 02                	mov    %al,(%edx)
		start++ ;
  80199a:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80199d:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8019a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019a3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8019a6:	7c c4                	jl     80196c <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8019a8:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8019ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019ae:	01 d0                	add    %edx,%eax
  8019b0:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8019b3:	90                   	nop
  8019b4:	c9                   	leave  
  8019b5:	c3                   	ret    

008019b6 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8019b6:	55                   	push   %ebp
  8019b7:	89 e5                	mov    %esp,%ebp
  8019b9:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8019bc:	ff 75 08             	pushl  0x8(%ebp)
  8019bf:	e8 54 fa ff ff       	call   801418 <strlen>
  8019c4:	83 c4 04             	add    $0x4,%esp
  8019c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8019ca:	ff 75 0c             	pushl  0xc(%ebp)
  8019cd:	e8 46 fa ff ff       	call   801418 <strlen>
  8019d2:	83 c4 04             	add    $0x4,%esp
  8019d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8019d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8019df:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019e6:	eb 17                	jmp    8019ff <strcconcat+0x49>
		final[s] = str1[s] ;
  8019e8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8019ee:	01 c2                	add    %eax,%edx
  8019f0:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f6:	01 c8                	add    %ecx,%eax
  8019f8:	8a 00                	mov    (%eax),%al
  8019fa:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8019fc:	ff 45 fc             	incl   -0x4(%ebp)
  8019ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a02:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a05:	7c e1                	jl     8019e8 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801a07:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801a0e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801a15:	eb 1f                	jmp    801a36 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801a17:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a1a:	8d 50 01             	lea    0x1(%eax),%edx
  801a1d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a20:	89 c2                	mov    %eax,%edx
  801a22:	8b 45 10             	mov    0x10(%ebp),%eax
  801a25:	01 c2                	add    %eax,%edx
  801a27:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801a2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a2d:	01 c8                	add    %ecx,%eax
  801a2f:	8a 00                	mov    (%eax),%al
  801a31:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801a33:	ff 45 f8             	incl   -0x8(%ebp)
  801a36:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a39:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a3c:	7c d9                	jl     801a17 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801a3e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a41:	8b 45 10             	mov    0x10(%ebp),%eax
  801a44:	01 d0                	add    %edx,%eax
  801a46:	c6 00 00             	movb   $0x0,(%eax)
}
  801a49:	90                   	nop
  801a4a:	c9                   	leave  
  801a4b:	c3                   	ret    

00801a4c <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801a4c:	55                   	push   %ebp
  801a4d:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801a4f:	8b 45 14             	mov    0x14(%ebp),%eax
  801a52:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a58:	8b 45 14             	mov    0x14(%ebp),%eax
  801a5b:	8b 00                	mov    (%eax),%eax
  801a5d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a64:	8b 45 10             	mov    0x10(%ebp),%eax
  801a67:	01 d0                	add    %edx,%eax
  801a69:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a6f:	eb 0c                	jmp    801a7d <strsplit+0x31>
			*string++ = 0;
  801a71:	8b 45 08             	mov    0x8(%ebp),%eax
  801a74:	8d 50 01             	lea    0x1(%eax),%edx
  801a77:	89 55 08             	mov    %edx,0x8(%ebp)
  801a7a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a7d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a80:	8a 00                	mov    (%eax),%al
  801a82:	84 c0                	test   %al,%al
  801a84:	74 18                	je     801a9e <strsplit+0x52>
  801a86:	8b 45 08             	mov    0x8(%ebp),%eax
  801a89:	8a 00                	mov    (%eax),%al
  801a8b:	0f be c0             	movsbl %al,%eax
  801a8e:	50                   	push   %eax
  801a8f:	ff 75 0c             	pushl  0xc(%ebp)
  801a92:	e8 13 fb ff ff       	call   8015aa <strchr>
  801a97:	83 c4 08             	add    $0x8,%esp
  801a9a:	85 c0                	test   %eax,%eax
  801a9c:	75 d3                	jne    801a71 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801a9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa1:	8a 00                	mov    (%eax),%al
  801aa3:	84 c0                	test   %al,%al
  801aa5:	74 5a                	je     801b01 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801aa7:	8b 45 14             	mov    0x14(%ebp),%eax
  801aaa:	8b 00                	mov    (%eax),%eax
  801aac:	83 f8 0f             	cmp    $0xf,%eax
  801aaf:	75 07                	jne    801ab8 <strsplit+0x6c>
		{
			return 0;
  801ab1:	b8 00 00 00 00       	mov    $0x0,%eax
  801ab6:	eb 66                	jmp    801b1e <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801ab8:	8b 45 14             	mov    0x14(%ebp),%eax
  801abb:	8b 00                	mov    (%eax),%eax
  801abd:	8d 48 01             	lea    0x1(%eax),%ecx
  801ac0:	8b 55 14             	mov    0x14(%ebp),%edx
  801ac3:	89 0a                	mov    %ecx,(%edx)
  801ac5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801acc:	8b 45 10             	mov    0x10(%ebp),%eax
  801acf:	01 c2                	add    %eax,%edx
  801ad1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad4:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ad6:	eb 03                	jmp    801adb <strsplit+0x8f>
			string++;
  801ad8:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801adb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ade:	8a 00                	mov    (%eax),%al
  801ae0:	84 c0                	test   %al,%al
  801ae2:	74 8b                	je     801a6f <strsplit+0x23>
  801ae4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae7:	8a 00                	mov    (%eax),%al
  801ae9:	0f be c0             	movsbl %al,%eax
  801aec:	50                   	push   %eax
  801aed:	ff 75 0c             	pushl  0xc(%ebp)
  801af0:	e8 b5 fa ff ff       	call   8015aa <strchr>
  801af5:	83 c4 08             	add    $0x8,%esp
  801af8:	85 c0                	test   %eax,%eax
  801afa:	74 dc                	je     801ad8 <strsplit+0x8c>
			string++;
	}
  801afc:	e9 6e ff ff ff       	jmp    801a6f <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801b01:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801b02:	8b 45 14             	mov    0x14(%ebp),%eax
  801b05:	8b 00                	mov    (%eax),%eax
  801b07:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b0e:	8b 45 10             	mov    0x10(%ebp),%eax
  801b11:	01 d0                	add    %edx,%eax
  801b13:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801b19:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801b1e:	c9                   	leave  
  801b1f:	c3                   	ret    

00801b20 <malloc>:
int sizeofarray=0;
uint32 addresses[1000];
int changed[1000];
int numOfPages[1000];
void* malloc(uint32 size)
{
  801b20:	55                   	push   %ebp
  801b21:	89 e5                	mov    %esp,%ebp
  801b23:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  801b26:	8b 45 08             	mov    0x8(%ebp),%eax
  801b29:	c1 e8 0c             	shr    $0xc,%eax
  801b2c:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  801b2f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b32:	25 ff 0f 00 00       	and    $0xfff,%eax
  801b37:	85 c0                	test   %eax,%eax
  801b39:	74 03                	je     801b3e <malloc+0x1e>
			num++;
  801b3b:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  801b3e:	a1 04 30 80 00       	mov    0x803004,%eax
  801b43:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  801b48:	75 73                	jne    801bbd <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  801b4a:	83 ec 08             	sub    $0x8,%esp
  801b4d:	ff 75 08             	pushl  0x8(%ebp)
  801b50:	68 00 00 00 80       	push   $0x80000000
  801b55:	e8 80 04 00 00       	call   801fda <sys_allocateMem>
  801b5a:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  801b5d:	a1 04 30 80 00       	mov    0x803004,%eax
  801b62:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  801b65:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b68:	c1 e0 0c             	shl    $0xc,%eax
  801b6b:	89 c2                	mov    %eax,%edx
  801b6d:	a1 04 30 80 00       	mov    0x803004,%eax
  801b72:	01 d0                	add    %edx,%eax
  801b74:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  801b79:	a1 30 30 80 00       	mov    0x803030,%eax
  801b7e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801b81:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
			addresses[sizeofarray]=last_addres;
  801b88:	a1 30 30 80 00       	mov    0x803030,%eax
  801b8d:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801b93:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  801b9a:	a1 30 30 80 00       	mov    0x803030,%eax
  801b9f:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  801ba6:	01 00 00 00 
			sizeofarray++;
  801baa:	a1 30 30 80 00       	mov    0x803030,%eax
  801baf:	40                   	inc    %eax
  801bb0:	a3 30 30 80 00       	mov    %eax,0x803030
			return (void*)return_addres;
  801bb5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801bb8:	e9 71 01 00 00       	jmp    801d2e <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  801bbd:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801bc2:	85 c0                	test   %eax,%eax
  801bc4:	75 71                	jne    801c37 <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  801bc6:	a1 04 30 80 00       	mov    0x803004,%eax
  801bcb:	83 ec 08             	sub    $0x8,%esp
  801bce:	ff 75 08             	pushl  0x8(%ebp)
  801bd1:	50                   	push   %eax
  801bd2:	e8 03 04 00 00       	call   801fda <sys_allocateMem>
  801bd7:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  801bda:	a1 04 30 80 00       	mov    0x803004,%eax
  801bdf:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  801be2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801be5:	c1 e0 0c             	shl    $0xc,%eax
  801be8:	89 c2                	mov    %eax,%edx
  801bea:	a1 04 30 80 00       	mov    0x803004,%eax
  801bef:	01 d0                	add    %edx,%eax
  801bf1:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  801bf6:	a1 30 30 80 00       	mov    0x803030,%eax
  801bfb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801bfe:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=return_addres;
  801c05:	a1 30 30 80 00       	mov    0x803030,%eax
  801c0a:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801c0d:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801c14:	a1 30 30 80 00       	mov    0x803030,%eax
  801c19:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  801c20:	01 00 00 00 
				sizeofarray++;
  801c24:	a1 30 30 80 00       	mov    0x803030,%eax
  801c29:	40                   	inc    %eax
  801c2a:	a3 30 30 80 00       	mov    %eax,0x803030
				return (void*)return_addres;
  801c2f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801c32:	e9 f7 00 00 00       	jmp    801d2e <malloc+0x20e>
			}
			else{
				int count=0;
  801c37:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801c3e:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  801c45:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801c4c:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  801c53:	eb 7c                	jmp    801cd1 <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  801c55:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  801c5c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  801c63:	eb 1a                	jmp    801c7f <malloc+0x15f>
					{
						if(addresses[j]==i)
  801c65:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801c68:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801c6f:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  801c72:	75 08                	jne    801c7c <malloc+0x15c>
						{
							index=j;
  801c74:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801c77:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  801c7a:	eb 0d                	jmp    801c89 <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801c7c:	ff 45 dc             	incl   -0x24(%ebp)
  801c7f:	a1 30 30 80 00       	mov    0x803030,%eax
  801c84:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801c87:	7c dc                	jl     801c65 <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  801c89:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801c8d:	75 05                	jne    801c94 <malloc+0x174>
					{
						count++;
  801c8f:	ff 45 f0             	incl   -0x10(%ebp)
  801c92:	eb 36                	jmp    801cca <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  801c94:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801c97:	8b 04 85 c0 40 80 00 	mov    0x8040c0(,%eax,4),%eax
  801c9e:	85 c0                	test   %eax,%eax
  801ca0:	75 05                	jne    801ca7 <malloc+0x187>
						{
							count++;
  801ca2:	ff 45 f0             	incl   -0x10(%ebp)
  801ca5:	eb 23                	jmp    801cca <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  801ca7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801caa:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801cad:	7d 14                	jge    801cc3 <malloc+0x1a3>
  801caf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cb2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801cb5:	7c 0c                	jl     801cc3 <malloc+0x1a3>
							{
								min=count;
  801cb7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cba:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801cbd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801cc0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  801cc3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801cca:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  801cd1:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  801cd8:	0f 86 77 ff ff ff    	jbe    801c55 <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  801cde:	83 ec 08             	sub    $0x8,%esp
  801ce1:	ff 75 08             	pushl  0x8(%ebp)
  801ce4:	ff 75 e4             	pushl  -0x1c(%ebp)
  801ce7:	e8 ee 02 00 00       	call   801fda <sys_allocateMem>
  801cec:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  801cef:	a1 30 30 80 00       	mov    0x803030,%eax
  801cf4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801cf7:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=last_addres;
  801cfe:	a1 30 30 80 00       	mov    0x803030,%eax
  801d03:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801d09:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  801d10:	a1 30 30 80 00       	mov    0x803030,%eax
  801d15:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  801d1c:	01 00 00 00 
				sizeofarray++;
  801d20:	a1 30 30 80 00       	mov    0x803030,%eax
  801d25:	40                   	inc    %eax
  801d26:	a3 30 30 80 00       	mov    %eax,0x803030
				return(void*) min_addresss;
  801d2b:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801d2e:	c9                   	leave  
  801d2f:	c3                   	ret    

00801d30 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801d30:	55                   	push   %ebp
  801d31:	89 e5                	mov    %esp,%ebp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address

	//refer to the project presentation and documentation for details
}
  801d33:	90                   	nop
  801d34:	5d                   	pop    %ebp
  801d35:	c3                   	ret    

00801d36 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801d36:	55                   	push   %ebp
  801d37:	89 e5                	mov    %esp,%ebp
  801d39:	83 ec 18             	sub    $0x18,%esp
  801d3c:	8b 45 10             	mov    0x10(%ebp),%eax
  801d3f:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801d42:	83 ec 04             	sub    $0x4,%esp
  801d45:	68 44 2e 80 00       	push   $0x802e44
  801d4a:	68 8d 00 00 00       	push   $0x8d
  801d4f:	68 67 2e 80 00       	push   $0x802e67
  801d54:	e8 95 eb ff ff       	call   8008ee <_panic>

00801d59 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801d59:	55                   	push   %ebp
  801d5a:	89 e5                	mov    %esp,%ebp
  801d5c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d5f:	83 ec 04             	sub    $0x4,%esp
  801d62:	68 44 2e 80 00       	push   $0x802e44
  801d67:	68 93 00 00 00       	push   $0x93
  801d6c:	68 67 2e 80 00       	push   $0x802e67
  801d71:	e8 78 eb ff ff       	call   8008ee <_panic>

00801d76 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801d76:	55                   	push   %ebp
  801d77:	89 e5                	mov    %esp,%ebp
  801d79:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d7c:	83 ec 04             	sub    $0x4,%esp
  801d7f:	68 44 2e 80 00       	push   $0x802e44
  801d84:	68 99 00 00 00       	push   $0x99
  801d89:	68 67 2e 80 00       	push   $0x802e67
  801d8e:	e8 5b eb ff ff       	call   8008ee <_panic>

00801d93 <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  801d93:	55                   	push   %ebp
  801d94:	89 e5                	mov    %esp,%ebp
  801d96:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801d99:	83 ec 04             	sub    $0x4,%esp
  801d9c:	68 44 2e 80 00       	push   $0x802e44
  801da1:	68 9e 00 00 00       	push   $0x9e
  801da6:	68 67 2e 80 00       	push   $0x802e67
  801dab:	e8 3e eb ff ff       	call   8008ee <_panic>

00801db0 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801db0:	55                   	push   %ebp
  801db1:	89 e5                	mov    %esp,%ebp
  801db3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801db6:	83 ec 04             	sub    $0x4,%esp
  801db9:	68 44 2e 80 00       	push   $0x802e44
  801dbe:	68 a4 00 00 00       	push   $0xa4
  801dc3:	68 67 2e 80 00       	push   $0x802e67
  801dc8:	e8 21 eb ff ff       	call   8008ee <_panic>

00801dcd <shrink>:
}
void shrink(uint32 newSize)
{
  801dcd:	55                   	push   %ebp
  801dce:	89 e5                	mov    %esp,%ebp
  801dd0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801dd3:	83 ec 04             	sub    $0x4,%esp
  801dd6:	68 44 2e 80 00       	push   $0x802e44
  801ddb:	68 a8 00 00 00       	push   $0xa8
  801de0:	68 67 2e 80 00       	push   $0x802e67
  801de5:	e8 04 eb ff ff       	call   8008ee <_panic>

00801dea <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801dea:	55                   	push   %ebp
  801deb:	89 e5                	mov    %esp,%ebp
  801ded:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801df0:	83 ec 04             	sub    $0x4,%esp
  801df3:	68 44 2e 80 00       	push   $0x802e44
  801df8:	68 ad 00 00 00       	push   $0xad
  801dfd:	68 67 2e 80 00       	push   $0x802e67
  801e02:	e8 e7 ea ff ff       	call   8008ee <_panic>

00801e07 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801e07:	55                   	push   %ebp
  801e08:	89 e5                	mov    %esp,%ebp
  801e0a:	57                   	push   %edi
  801e0b:	56                   	push   %esi
  801e0c:	53                   	push   %ebx
  801e0d:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801e10:	8b 45 08             	mov    0x8(%ebp),%eax
  801e13:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e16:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e19:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e1c:	8b 7d 18             	mov    0x18(%ebp),%edi
  801e1f:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801e22:	cd 30                	int    $0x30
  801e24:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801e27:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801e2a:	83 c4 10             	add    $0x10,%esp
  801e2d:	5b                   	pop    %ebx
  801e2e:	5e                   	pop    %esi
  801e2f:	5f                   	pop    %edi
  801e30:	5d                   	pop    %ebp
  801e31:	c3                   	ret    

00801e32 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801e32:	55                   	push   %ebp
  801e33:	89 e5                	mov    %esp,%ebp
  801e35:	83 ec 04             	sub    $0x4,%esp
  801e38:	8b 45 10             	mov    0x10(%ebp),%eax
  801e3b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801e3e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e42:	8b 45 08             	mov    0x8(%ebp),%eax
  801e45:	6a 00                	push   $0x0
  801e47:	6a 00                	push   $0x0
  801e49:	52                   	push   %edx
  801e4a:	ff 75 0c             	pushl  0xc(%ebp)
  801e4d:	50                   	push   %eax
  801e4e:	6a 00                	push   $0x0
  801e50:	e8 b2 ff ff ff       	call   801e07 <syscall>
  801e55:	83 c4 18             	add    $0x18,%esp
}
  801e58:	90                   	nop
  801e59:	c9                   	leave  
  801e5a:	c3                   	ret    

00801e5b <sys_cgetc>:

int
sys_cgetc(void)
{
  801e5b:	55                   	push   %ebp
  801e5c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801e5e:	6a 00                	push   $0x0
  801e60:	6a 00                	push   $0x0
  801e62:	6a 00                	push   $0x0
  801e64:	6a 00                	push   $0x0
  801e66:	6a 00                	push   $0x0
  801e68:	6a 01                	push   $0x1
  801e6a:	e8 98 ff ff ff       	call   801e07 <syscall>
  801e6f:	83 c4 18             	add    $0x18,%esp
}
  801e72:	c9                   	leave  
  801e73:	c3                   	ret    

00801e74 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801e74:	55                   	push   %ebp
  801e75:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801e77:	8b 45 08             	mov    0x8(%ebp),%eax
  801e7a:	6a 00                	push   $0x0
  801e7c:	6a 00                	push   $0x0
  801e7e:	6a 00                	push   $0x0
  801e80:	6a 00                	push   $0x0
  801e82:	50                   	push   %eax
  801e83:	6a 05                	push   $0x5
  801e85:	e8 7d ff ff ff       	call   801e07 <syscall>
  801e8a:	83 c4 18             	add    $0x18,%esp
}
  801e8d:	c9                   	leave  
  801e8e:	c3                   	ret    

00801e8f <sys_getenvid>:

int32 sys_getenvid(void)
{
  801e8f:	55                   	push   %ebp
  801e90:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801e92:	6a 00                	push   $0x0
  801e94:	6a 00                	push   $0x0
  801e96:	6a 00                	push   $0x0
  801e98:	6a 00                	push   $0x0
  801e9a:	6a 00                	push   $0x0
  801e9c:	6a 02                	push   $0x2
  801e9e:	e8 64 ff ff ff       	call   801e07 <syscall>
  801ea3:	83 c4 18             	add    $0x18,%esp
}
  801ea6:	c9                   	leave  
  801ea7:	c3                   	ret    

00801ea8 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801ea8:	55                   	push   %ebp
  801ea9:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801eab:	6a 00                	push   $0x0
  801ead:	6a 00                	push   $0x0
  801eaf:	6a 00                	push   $0x0
  801eb1:	6a 00                	push   $0x0
  801eb3:	6a 00                	push   $0x0
  801eb5:	6a 03                	push   $0x3
  801eb7:	e8 4b ff ff ff       	call   801e07 <syscall>
  801ebc:	83 c4 18             	add    $0x18,%esp
}
  801ebf:	c9                   	leave  
  801ec0:	c3                   	ret    

00801ec1 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801ec1:	55                   	push   %ebp
  801ec2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801ec4:	6a 00                	push   $0x0
  801ec6:	6a 00                	push   $0x0
  801ec8:	6a 00                	push   $0x0
  801eca:	6a 00                	push   $0x0
  801ecc:	6a 00                	push   $0x0
  801ece:	6a 04                	push   $0x4
  801ed0:	e8 32 ff ff ff       	call   801e07 <syscall>
  801ed5:	83 c4 18             	add    $0x18,%esp
}
  801ed8:	c9                   	leave  
  801ed9:	c3                   	ret    

00801eda <sys_env_exit>:


void sys_env_exit(void)
{
  801eda:	55                   	push   %ebp
  801edb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 00                	push   $0x0
  801ee3:	6a 00                	push   $0x0
  801ee5:	6a 00                	push   $0x0
  801ee7:	6a 06                	push   $0x6
  801ee9:	e8 19 ff ff ff       	call   801e07 <syscall>
  801eee:	83 c4 18             	add    $0x18,%esp
}
  801ef1:	90                   	nop
  801ef2:	c9                   	leave  
  801ef3:	c3                   	ret    

00801ef4 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801ef4:	55                   	push   %ebp
  801ef5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801ef7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801efa:	8b 45 08             	mov    0x8(%ebp),%eax
  801efd:	6a 00                	push   $0x0
  801eff:	6a 00                	push   $0x0
  801f01:	6a 00                	push   $0x0
  801f03:	52                   	push   %edx
  801f04:	50                   	push   %eax
  801f05:	6a 07                	push   $0x7
  801f07:	e8 fb fe ff ff       	call   801e07 <syscall>
  801f0c:	83 c4 18             	add    $0x18,%esp
}
  801f0f:	c9                   	leave  
  801f10:	c3                   	ret    

00801f11 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801f11:	55                   	push   %ebp
  801f12:	89 e5                	mov    %esp,%ebp
  801f14:	56                   	push   %esi
  801f15:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801f16:	8b 75 18             	mov    0x18(%ebp),%esi
  801f19:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801f1c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f1f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f22:	8b 45 08             	mov    0x8(%ebp),%eax
  801f25:	56                   	push   %esi
  801f26:	53                   	push   %ebx
  801f27:	51                   	push   %ecx
  801f28:	52                   	push   %edx
  801f29:	50                   	push   %eax
  801f2a:	6a 08                	push   $0x8
  801f2c:	e8 d6 fe ff ff       	call   801e07 <syscall>
  801f31:	83 c4 18             	add    $0x18,%esp
}
  801f34:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801f37:	5b                   	pop    %ebx
  801f38:	5e                   	pop    %esi
  801f39:	5d                   	pop    %ebp
  801f3a:	c3                   	ret    

00801f3b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801f3b:	55                   	push   %ebp
  801f3c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801f3e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f41:	8b 45 08             	mov    0x8(%ebp),%eax
  801f44:	6a 00                	push   $0x0
  801f46:	6a 00                	push   $0x0
  801f48:	6a 00                	push   $0x0
  801f4a:	52                   	push   %edx
  801f4b:	50                   	push   %eax
  801f4c:	6a 09                	push   $0x9
  801f4e:	e8 b4 fe ff ff       	call   801e07 <syscall>
  801f53:	83 c4 18             	add    $0x18,%esp
}
  801f56:	c9                   	leave  
  801f57:	c3                   	ret    

00801f58 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801f58:	55                   	push   %ebp
  801f59:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801f5b:	6a 00                	push   $0x0
  801f5d:	6a 00                	push   $0x0
  801f5f:	6a 00                	push   $0x0
  801f61:	ff 75 0c             	pushl  0xc(%ebp)
  801f64:	ff 75 08             	pushl  0x8(%ebp)
  801f67:	6a 0a                	push   $0xa
  801f69:	e8 99 fe ff ff       	call   801e07 <syscall>
  801f6e:	83 c4 18             	add    $0x18,%esp
}
  801f71:	c9                   	leave  
  801f72:	c3                   	ret    

00801f73 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801f73:	55                   	push   %ebp
  801f74:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801f76:	6a 00                	push   $0x0
  801f78:	6a 00                	push   $0x0
  801f7a:	6a 00                	push   $0x0
  801f7c:	6a 00                	push   $0x0
  801f7e:	6a 00                	push   $0x0
  801f80:	6a 0b                	push   $0xb
  801f82:	e8 80 fe ff ff       	call   801e07 <syscall>
  801f87:	83 c4 18             	add    $0x18,%esp
}
  801f8a:	c9                   	leave  
  801f8b:	c3                   	ret    

00801f8c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801f8c:	55                   	push   %ebp
  801f8d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801f8f:	6a 00                	push   $0x0
  801f91:	6a 00                	push   $0x0
  801f93:	6a 00                	push   $0x0
  801f95:	6a 00                	push   $0x0
  801f97:	6a 00                	push   $0x0
  801f99:	6a 0c                	push   $0xc
  801f9b:	e8 67 fe ff ff       	call   801e07 <syscall>
  801fa0:	83 c4 18             	add    $0x18,%esp
}
  801fa3:	c9                   	leave  
  801fa4:	c3                   	ret    

00801fa5 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801fa5:	55                   	push   %ebp
  801fa6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801fa8:	6a 00                	push   $0x0
  801faa:	6a 00                	push   $0x0
  801fac:	6a 00                	push   $0x0
  801fae:	6a 00                	push   $0x0
  801fb0:	6a 00                	push   $0x0
  801fb2:	6a 0d                	push   $0xd
  801fb4:	e8 4e fe ff ff       	call   801e07 <syscall>
  801fb9:	83 c4 18             	add    $0x18,%esp
}
  801fbc:	c9                   	leave  
  801fbd:	c3                   	ret    

00801fbe <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801fbe:	55                   	push   %ebp
  801fbf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801fc1:	6a 00                	push   $0x0
  801fc3:	6a 00                	push   $0x0
  801fc5:	6a 00                	push   $0x0
  801fc7:	ff 75 0c             	pushl  0xc(%ebp)
  801fca:	ff 75 08             	pushl  0x8(%ebp)
  801fcd:	6a 11                	push   $0x11
  801fcf:	e8 33 fe ff ff       	call   801e07 <syscall>
  801fd4:	83 c4 18             	add    $0x18,%esp
	return;
  801fd7:	90                   	nop
}
  801fd8:	c9                   	leave  
  801fd9:	c3                   	ret    

00801fda <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801fda:	55                   	push   %ebp
  801fdb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801fdd:	6a 00                	push   $0x0
  801fdf:	6a 00                	push   $0x0
  801fe1:	6a 00                	push   $0x0
  801fe3:	ff 75 0c             	pushl  0xc(%ebp)
  801fe6:	ff 75 08             	pushl  0x8(%ebp)
  801fe9:	6a 12                	push   $0x12
  801feb:	e8 17 fe ff ff       	call   801e07 <syscall>
  801ff0:	83 c4 18             	add    $0x18,%esp
	return ;
  801ff3:	90                   	nop
}
  801ff4:	c9                   	leave  
  801ff5:	c3                   	ret    

00801ff6 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801ff6:	55                   	push   %ebp
  801ff7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801ff9:	6a 00                	push   $0x0
  801ffb:	6a 00                	push   $0x0
  801ffd:	6a 00                	push   $0x0
  801fff:	6a 00                	push   $0x0
  802001:	6a 00                	push   $0x0
  802003:	6a 0e                	push   $0xe
  802005:	e8 fd fd ff ff       	call   801e07 <syscall>
  80200a:	83 c4 18             	add    $0x18,%esp
}
  80200d:	c9                   	leave  
  80200e:	c3                   	ret    

0080200f <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80200f:	55                   	push   %ebp
  802010:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  802012:	6a 00                	push   $0x0
  802014:	6a 00                	push   $0x0
  802016:	6a 00                	push   $0x0
  802018:	6a 00                	push   $0x0
  80201a:	ff 75 08             	pushl  0x8(%ebp)
  80201d:	6a 0f                	push   $0xf
  80201f:	e8 e3 fd ff ff       	call   801e07 <syscall>
  802024:	83 c4 18             	add    $0x18,%esp
}
  802027:	c9                   	leave  
  802028:	c3                   	ret    

00802029 <sys_scarce_memory>:

void sys_scarce_memory()
{
  802029:	55                   	push   %ebp
  80202a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80202c:	6a 00                	push   $0x0
  80202e:	6a 00                	push   $0x0
  802030:	6a 00                	push   $0x0
  802032:	6a 00                	push   $0x0
  802034:	6a 00                	push   $0x0
  802036:	6a 10                	push   $0x10
  802038:	e8 ca fd ff ff       	call   801e07 <syscall>
  80203d:	83 c4 18             	add    $0x18,%esp
}
  802040:	90                   	nop
  802041:	c9                   	leave  
  802042:	c3                   	ret    

00802043 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  802043:	55                   	push   %ebp
  802044:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  802046:	6a 00                	push   $0x0
  802048:	6a 00                	push   $0x0
  80204a:	6a 00                	push   $0x0
  80204c:	6a 00                	push   $0x0
  80204e:	6a 00                	push   $0x0
  802050:	6a 14                	push   $0x14
  802052:	e8 b0 fd ff ff       	call   801e07 <syscall>
  802057:	83 c4 18             	add    $0x18,%esp
}
  80205a:	90                   	nop
  80205b:	c9                   	leave  
  80205c:	c3                   	ret    

0080205d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80205d:	55                   	push   %ebp
  80205e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  802060:	6a 00                	push   $0x0
  802062:	6a 00                	push   $0x0
  802064:	6a 00                	push   $0x0
  802066:	6a 00                	push   $0x0
  802068:	6a 00                	push   $0x0
  80206a:	6a 15                	push   $0x15
  80206c:	e8 96 fd ff ff       	call   801e07 <syscall>
  802071:	83 c4 18             	add    $0x18,%esp
}
  802074:	90                   	nop
  802075:	c9                   	leave  
  802076:	c3                   	ret    

00802077 <sys_cputc>:


void
sys_cputc(const char c)
{
  802077:	55                   	push   %ebp
  802078:	89 e5                	mov    %esp,%ebp
  80207a:	83 ec 04             	sub    $0x4,%esp
  80207d:	8b 45 08             	mov    0x8(%ebp),%eax
  802080:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  802083:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802087:	6a 00                	push   $0x0
  802089:	6a 00                	push   $0x0
  80208b:	6a 00                	push   $0x0
  80208d:	6a 00                	push   $0x0
  80208f:	50                   	push   %eax
  802090:	6a 16                	push   $0x16
  802092:	e8 70 fd ff ff       	call   801e07 <syscall>
  802097:	83 c4 18             	add    $0x18,%esp
}
  80209a:	90                   	nop
  80209b:	c9                   	leave  
  80209c:	c3                   	ret    

0080209d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80209d:	55                   	push   %ebp
  80209e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8020a0:	6a 00                	push   $0x0
  8020a2:	6a 00                	push   $0x0
  8020a4:	6a 00                	push   $0x0
  8020a6:	6a 00                	push   $0x0
  8020a8:	6a 00                	push   $0x0
  8020aa:	6a 17                	push   $0x17
  8020ac:	e8 56 fd ff ff       	call   801e07 <syscall>
  8020b1:	83 c4 18             	add    $0x18,%esp
}
  8020b4:	90                   	nop
  8020b5:	c9                   	leave  
  8020b6:	c3                   	ret    

008020b7 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8020b7:	55                   	push   %ebp
  8020b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8020ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8020bd:	6a 00                	push   $0x0
  8020bf:	6a 00                	push   $0x0
  8020c1:	6a 00                	push   $0x0
  8020c3:	ff 75 0c             	pushl  0xc(%ebp)
  8020c6:	50                   	push   %eax
  8020c7:	6a 18                	push   $0x18
  8020c9:	e8 39 fd ff ff       	call   801e07 <syscall>
  8020ce:	83 c4 18             	add    $0x18,%esp
}
  8020d1:	c9                   	leave  
  8020d2:	c3                   	ret    

008020d3 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8020d3:	55                   	push   %ebp
  8020d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8020d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8020dc:	6a 00                	push   $0x0
  8020de:	6a 00                	push   $0x0
  8020e0:	6a 00                	push   $0x0
  8020e2:	52                   	push   %edx
  8020e3:	50                   	push   %eax
  8020e4:	6a 1b                	push   $0x1b
  8020e6:	e8 1c fd ff ff       	call   801e07 <syscall>
  8020eb:	83 c4 18             	add    $0x18,%esp
}
  8020ee:	c9                   	leave  
  8020ef:	c3                   	ret    

008020f0 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8020f0:	55                   	push   %ebp
  8020f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8020f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8020f9:	6a 00                	push   $0x0
  8020fb:	6a 00                	push   $0x0
  8020fd:	6a 00                	push   $0x0
  8020ff:	52                   	push   %edx
  802100:	50                   	push   %eax
  802101:	6a 19                	push   $0x19
  802103:	e8 ff fc ff ff       	call   801e07 <syscall>
  802108:	83 c4 18             	add    $0x18,%esp
}
  80210b:	90                   	nop
  80210c:	c9                   	leave  
  80210d:	c3                   	ret    

0080210e <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80210e:	55                   	push   %ebp
  80210f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802111:	8b 55 0c             	mov    0xc(%ebp),%edx
  802114:	8b 45 08             	mov    0x8(%ebp),%eax
  802117:	6a 00                	push   $0x0
  802119:	6a 00                	push   $0x0
  80211b:	6a 00                	push   $0x0
  80211d:	52                   	push   %edx
  80211e:	50                   	push   %eax
  80211f:	6a 1a                	push   $0x1a
  802121:	e8 e1 fc ff ff       	call   801e07 <syscall>
  802126:	83 c4 18             	add    $0x18,%esp
}
  802129:	90                   	nop
  80212a:	c9                   	leave  
  80212b:	c3                   	ret    

0080212c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80212c:	55                   	push   %ebp
  80212d:	89 e5                	mov    %esp,%ebp
  80212f:	83 ec 04             	sub    $0x4,%esp
  802132:	8b 45 10             	mov    0x10(%ebp),%eax
  802135:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  802138:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80213b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80213f:	8b 45 08             	mov    0x8(%ebp),%eax
  802142:	6a 00                	push   $0x0
  802144:	51                   	push   %ecx
  802145:	52                   	push   %edx
  802146:	ff 75 0c             	pushl  0xc(%ebp)
  802149:	50                   	push   %eax
  80214a:	6a 1c                	push   $0x1c
  80214c:	e8 b6 fc ff ff       	call   801e07 <syscall>
  802151:	83 c4 18             	add    $0x18,%esp
}
  802154:	c9                   	leave  
  802155:	c3                   	ret    

00802156 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802156:	55                   	push   %ebp
  802157:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  802159:	8b 55 0c             	mov    0xc(%ebp),%edx
  80215c:	8b 45 08             	mov    0x8(%ebp),%eax
  80215f:	6a 00                	push   $0x0
  802161:	6a 00                	push   $0x0
  802163:	6a 00                	push   $0x0
  802165:	52                   	push   %edx
  802166:	50                   	push   %eax
  802167:	6a 1d                	push   $0x1d
  802169:	e8 99 fc ff ff       	call   801e07 <syscall>
  80216e:	83 c4 18             	add    $0x18,%esp
}
  802171:	c9                   	leave  
  802172:	c3                   	ret    

00802173 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802173:	55                   	push   %ebp
  802174:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802176:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802179:	8b 55 0c             	mov    0xc(%ebp),%edx
  80217c:	8b 45 08             	mov    0x8(%ebp),%eax
  80217f:	6a 00                	push   $0x0
  802181:	6a 00                	push   $0x0
  802183:	51                   	push   %ecx
  802184:	52                   	push   %edx
  802185:	50                   	push   %eax
  802186:	6a 1e                	push   $0x1e
  802188:	e8 7a fc ff ff       	call   801e07 <syscall>
  80218d:	83 c4 18             	add    $0x18,%esp
}
  802190:	c9                   	leave  
  802191:	c3                   	ret    

00802192 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802192:	55                   	push   %ebp
  802193:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802195:	8b 55 0c             	mov    0xc(%ebp),%edx
  802198:	8b 45 08             	mov    0x8(%ebp),%eax
  80219b:	6a 00                	push   $0x0
  80219d:	6a 00                	push   $0x0
  80219f:	6a 00                	push   $0x0
  8021a1:	52                   	push   %edx
  8021a2:	50                   	push   %eax
  8021a3:	6a 1f                	push   $0x1f
  8021a5:	e8 5d fc ff ff       	call   801e07 <syscall>
  8021aa:	83 c4 18             	add    $0x18,%esp
}
  8021ad:	c9                   	leave  
  8021ae:	c3                   	ret    

008021af <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8021af:	55                   	push   %ebp
  8021b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8021b2:	6a 00                	push   $0x0
  8021b4:	6a 00                	push   $0x0
  8021b6:	6a 00                	push   $0x0
  8021b8:	6a 00                	push   $0x0
  8021ba:	6a 00                	push   $0x0
  8021bc:	6a 20                	push   $0x20
  8021be:	e8 44 fc ff ff       	call   801e07 <syscall>
  8021c3:	83 c4 18             	add    $0x18,%esp
}
  8021c6:	c9                   	leave  
  8021c7:	c3                   	ret    

008021c8 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8021c8:	55                   	push   %ebp
  8021c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8021cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8021ce:	6a 00                	push   $0x0
  8021d0:	ff 75 14             	pushl  0x14(%ebp)
  8021d3:	ff 75 10             	pushl  0x10(%ebp)
  8021d6:	ff 75 0c             	pushl  0xc(%ebp)
  8021d9:	50                   	push   %eax
  8021da:	6a 21                	push   $0x21
  8021dc:	e8 26 fc ff ff       	call   801e07 <syscall>
  8021e1:	83 c4 18             	add    $0x18,%esp
}
  8021e4:	c9                   	leave  
  8021e5:	c3                   	ret    

008021e6 <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8021e6:	55                   	push   %ebp
  8021e7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8021e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8021ec:	6a 00                	push   $0x0
  8021ee:	6a 00                	push   $0x0
  8021f0:	6a 00                	push   $0x0
  8021f2:	6a 00                	push   $0x0
  8021f4:	50                   	push   %eax
  8021f5:	6a 22                	push   $0x22
  8021f7:	e8 0b fc ff ff       	call   801e07 <syscall>
  8021fc:	83 c4 18             	add    $0x18,%esp
}
  8021ff:	90                   	nop
  802200:	c9                   	leave  
  802201:	c3                   	ret    

00802202 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802202:	55                   	push   %ebp
  802203:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802205:	8b 45 08             	mov    0x8(%ebp),%eax
  802208:	6a 00                	push   $0x0
  80220a:	6a 00                	push   $0x0
  80220c:	6a 00                	push   $0x0
  80220e:	6a 00                	push   $0x0
  802210:	50                   	push   %eax
  802211:	6a 23                	push   $0x23
  802213:	e8 ef fb ff ff       	call   801e07 <syscall>
  802218:	83 c4 18             	add    $0x18,%esp
}
  80221b:	90                   	nop
  80221c:	c9                   	leave  
  80221d:	c3                   	ret    

0080221e <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80221e:	55                   	push   %ebp
  80221f:	89 e5                	mov    %esp,%ebp
  802221:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802224:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802227:	8d 50 04             	lea    0x4(%eax),%edx
  80222a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80222d:	6a 00                	push   $0x0
  80222f:	6a 00                	push   $0x0
  802231:	6a 00                	push   $0x0
  802233:	52                   	push   %edx
  802234:	50                   	push   %eax
  802235:	6a 24                	push   $0x24
  802237:	e8 cb fb ff ff       	call   801e07 <syscall>
  80223c:	83 c4 18             	add    $0x18,%esp
	return result;
  80223f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802242:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802245:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802248:	89 01                	mov    %eax,(%ecx)
  80224a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80224d:	8b 45 08             	mov    0x8(%ebp),%eax
  802250:	c9                   	leave  
  802251:	c2 04 00             	ret    $0x4

00802254 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802254:	55                   	push   %ebp
  802255:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802257:	6a 00                	push   $0x0
  802259:	6a 00                	push   $0x0
  80225b:	ff 75 10             	pushl  0x10(%ebp)
  80225e:	ff 75 0c             	pushl  0xc(%ebp)
  802261:	ff 75 08             	pushl  0x8(%ebp)
  802264:	6a 13                	push   $0x13
  802266:	e8 9c fb ff ff       	call   801e07 <syscall>
  80226b:	83 c4 18             	add    $0x18,%esp
	return ;
  80226e:	90                   	nop
}
  80226f:	c9                   	leave  
  802270:	c3                   	ret    

00802271 <sys_rcr2>:
uint32 sys_rcr2()
{
  802271:	55                   	push   %ebp
  802272:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802274:	6a 00                	push   $0x0
  802276:	6a 00                	push   $0x0
  802278:	6a 00                	push   $0x0
  80227a:	6a 00                	push   $0x0
  80227c:	6a 00                	push   $0x0
  80227e:	6a 25                	push   $0x25
  802280:	e8 82 fb ff ff       	call   801e07 <syscall>
  802285:	83 c4 18             	add    $0x18,%esp
}
  802288:	c9                   	leave  
  802289:	c3                   	ret    

0080228a <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80228a:	55                   	push   %ebp
  80228b:	89 e5                	mov    %esp,%ebp
  80228d:	83 ec 04             	sub    $0x4,%esp
  802290:	8b 45 08             	mov    0x8(%ebp),%eax
  802293:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802296:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80229a:	6a 00                	push   $0x0
  80229c:	6a 00                	push   $0x0
  80229e:	6a 00                	push   $0x0
  8022a0:	6a 00                	push   $0x0
  8022a2:	50                   	push   %eax
  8022a3:	6a 26                	push   $0x26
  8022a5:	e8 5d fb ff ff       	call   801e07 <syscall>
  8022aa:	83 c4 18             	add    $0x18,%esp
	return ;
  8022ad:	90                   	nop
}
  8022ae:	c9                   	leave  
  8022af:	c3                   	ret    

008022b0 <rsttst>:
void rsttst()
{
  8022b0:	55                   	push   %ebp
  8022b1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8022b3:	6a 00                	push   $0x0
  8022b5:	6a 00                	push   $0x0
  8022b7:	6a 00                	push   $0x0
  8022b9:	6a 00                	push   $0x0
  8022bb:	6a 00                	push   $0x0
  8022bd:	6a 28                	push   $0x28
  8022bf:	e8 43 fb ff ff       	call   801e07 <syscall>
  8022c4:	83 c4 18             	add    $0x18,%esp
	return ;
  8022c7:	90                   	nop
}
  8022c8:	c9                   	leave  
  8022c9:	c3                   	ret    

008022ca <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8022ca:	55                   	push   %ebp
  8022cb:	89 e5                	mov    %esp,%ebp
  8022cd:	83 ec 04             	sub    $0x4,%esp
  8022d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8022d3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8022d6:	8b 55 18             	mov    0x18(%ebp),%edx
  8022d9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8022dd:	52                   	push   %edx
  8022de:	50                   	push   %eax
  8022df:	ff 75 10             	pushl  0x10(%ebp)
  8022e2:	ff 75 0c             	pushl  0xc(%ebp)
  8022e5:	ff 75 08             	pushl  0x8(%ebp)
  8022e8:	6a 27                	push   $0x27
  8022ea:	e8 18 fb ff ff       	call   801e07 <syscall>
  8022ef:	83 c4 18             	add    $0x18,%esp
	return ;
  8022f2:	90                   	nop
}
  8022f3:	c9                   	leave  
  8022f4:	c3                   	ret    

008022f5 <chktst>:
void chktst(uint32 n)
{
  8022f5:	55                   	push   %ebp
  8022f6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8022f8:	6a 00                	push   $0x0
  8022fa:	6a 00                	push   $0x0
  8022fc:	6a 00                	push   $0x0
  8022fe:	6a 00                	push   $0x0
  802300:	ff 75 08             	pushl  0x8(%ebp)
  802303:	6a 29                	push   $0x29
  802305:	e8 fd fa ff ff       	call   801e07 <syscall>
  80230a:	83 c4 18             	add    $0x18,%esp
	return ;
  80230d:	90                   	nop
}
  80230e:	c9                   	leave  
  80230f:	c3                   	ret    

00802310 <inctst>:

void inctst()
{
  802310:	55                   	push   %ebp
  802311:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802313:	6a 00                	push   $0x0
  802315:	6a 00                	push   $0x0
  802317:	6a 00                	push   $0x0
  802319:	6a 00                	push   $0x0
  80231b:	6a 00                	push   $0x0
  80231d:	6a 2a                	push   $0x2a
  80231f:	e8 e3 fa ff ff       	call   801e07 <syscall>
  802324:	83 c4 18             	add    $0x18,%esp
	return ;
  802327:	90                   	nop
}
  802328:	c9                   	leave  
  802329:	c3                   	ret    

0080232a <gettst>:
uint32 gettst()
{
  80232a:	55                   	push   %ebp
  80232b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80232d:	6a 00                	push   $0x0
  80232f:	6a 00                	push   $0x0
  802331:	6a 00                	push   $0x0
  802333:	6a 00                	push   $0x0
  802335:	6a 00                	push   $0x0
  802337:	6a 2b                	push   $0x2b
  802339:	e8 c9 fa ff ff       	call   801e07 <syscall>
  80233e:	83 c4 18             	add    $0x18,%esp
}
  802341:	c9                   	leave  
  802342:	c3                   	ret    

00802343 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802343:	55                   	push   %ebp
  802344:	89 e5                	mov    %esp,%ebp
  802346:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802349:	6a 00                	push   $0x0
  80234b:	6a 00                	push   $0x0
  80234d:	6a 00                	push   $0x0
  80234f:	6a 00                	push   $0x0
  802351:	6a 00                	push   $0x0
  802353:	6a 2c                	push   $0x2c
  802355:	e8 ad fa ff ff       	call   801e07 <syscall>
  80235a:	83 c4 18             	add    $0x18,%esp
  80235d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802360:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802364:	75 07                	jne    80236d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802366:	b8 01 00 00 00       	mov    $0x1,%eax
  80236b:	eb 05                	jmp    802372 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80236d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802372:	c9                   	leave  
  802373:	c3                   	ret    

00802374 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802374:	55                   	push   %ebp
  802375:	89 e5                	mov    %esp,%ebp
  802377:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80237a:	6a 00                	push   $0x0
  80237c:	6a 00                	push   $0x0
  80237e:	6a 00                	push   $0x0
  802380:	6a 00                	push   $0x0
  802382:	6a 00                	push   $0x0
  802384:	6a 2c                	push   $0x2c
  802386:	e8 7c fa ff ff       	call   801e07 <syscall>
  80238b:	83 c4 18             	add    $0x18,%esp
  80238e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802391:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802395:	75 07                	jne    80239e <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802397:	b8 01 00 00 00       	mov    $0x1,%eax
  80239c:	eb 05                	jmp    8023a3 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80239e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023a3:	c9                   	leave  
  8023a4:	c3                   	ret    

008023a5 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8023a5:	55                   	push   %ebp
  8023a6:	89 e5                	mov    %esp,%ebp
  8023a8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8023ab:	6a 00                	push   $0x0
  8023ad:	6a 00                	push   $0x0
  8023af:	6a 00                	push   $0x0
  8023b1:	6a 00                	push   $0x0
  8023b3:	6a 00                	push   $0x0
  8023b5:	6a 2c                	push   $0x2c
  8023b7:	e8 4b fa ff ff       	call   801e07 <syscall>
  8023bc:	83 c4 18             	add    $0x18,%esp
  8023bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8023c2:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8023c6:	75 07                	jne    8023cf <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8023c8:	b8 01 00 00 00       	mov    $0x1,%eax
  8023cd:	eb 05                	jmp    8023d4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8023cf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8023d4:	c9                   	leave  
  8023d5:	c3                   	ret    

008023d6 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8023d6:	55                   	push   %ebp
  8023d7:	89 e5                	mov    %esp,%ebp
  8023d9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8023dc:	6a 00                	push   $0x0
  8023de:	6a 00                	push   $0x0
  8023e0:	6a 00                	push   $0x0
  8023e2:	6a 00                	push   $0x0
  8023e4:	6a 00                	push   $0x0
  8023e6:	6a 2c                	push   $0x2c
  8023e8:	e8 1a fa ff ff       	call   801e07 <syscall>
  8023ed:	83 c4 18             	add    $0x18,%esp
  8023f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8023f3:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8023f7:	75 07                	jne    802400 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8023f9:	b8 01 00 00 00       	mov    $0x1,%eax
  8023fe:	eb 05                	jmp    802405 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802400:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802405:	c9                   	leave  
  802406:	c3                   	ret    

00802407 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802407:	55                   	push   %ebp
  802408:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80240a:	6a 00                	push   $0x0
  80240c:	6a 00                	push   $0x0
  80240e:	6a 00                	push   $0x0
  802410:	6a 00                	push   $0x0
  802412:	ff 75 08             	pushl  0x8(%ebp)
  802415:	6a 2d                	push   $0x2d
  802417:	e8 eb f9 ff ff       	call   801e07 <syscall>
  80241c:	83 c4 18             	add    $0x18,%esp
	return ;
  80241f:	90                   	nop
}
  802420:	c9                   	leave  
  802421:	c3                   	ret    

00802422 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802422:	55                   	push   %ebp
  802423:	89 e5                	mov    %esp,%ebp
  802425:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802426:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802429:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80242c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80242f:	8b 45 08             	mov    0x8(%ebp),%eax
  802432:	6a 00                	push   $0x0
  802434:	53                   	push   %ebx
  802435:	51                   	push   %ecx
  802436:	52                   	push   %edx
  802437:	50                   	push   %eax
  802438:	6a 2e                	push   $0x2e
  80243a:	e8 c8 f9 ff ff       	call   801e07 <syscall>
  80243f:	83 c4 18             	add    $0x18,%esp
}
  802442:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802445:	c9                   	leave  
  802446:	c3                   	ret    

00802447 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802447:	55                   	push   %ebp
  802448:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80244a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80244d:	8b 45 08             	mov    0x8(%ebp),%eax
  802450:	6a 00                	push   $0x0
  802452:	6a 00                	push   $0x0
  802454:	6a 00                	push   $0x0
  802456:	52                   	push   %edx
  802457:	50                   	push   %eax
  802458:	6a 2f                	push   $0x2f
  80245a:	e8 a8 f9 ff ff       	call   801e07 <syscall>
  80245f:	83 c4 18             	add    $0x18,%esp
}
  802462:	c9                   	leave  
  802463:	c3                   	ret    

00802464 <__udivdi3>:
  802464:	55                   	push   %ebp
  802465:	57                   	push   %edi
  802466:	56                   	push   %esi
  802467:	53                   	push   %ebx
  802468:	83 ec 1c             	sub    $0x1c,%esp
  80246b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80246f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802473:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802477:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80247b:	89 ca                	mov    %ecx,%edx
  80247d:	89 f8                	mov    %edi,%eax
  80247f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802483:	85 f6                	test   %esi,%esi
  802485:	75 2d                	jne    8024b4 <__udivdi3+0x50>
  802487:	39 cf                	cmp    %ecx,%edi
  802489:	77 65                	ja     8024f0 <__udivdi3+0x8c>
  80248b:	89 fd                	mov    %edi,%ebp
  80248d:	85 ff                	test   %edi,%edi
  80248f:	75 0b                	jne    80249c <__udivdi3+0x38>
  802491:	b8 01 00 00 00       	mov    $0x1,%eax
  802496:	31 d2                	xor    %edx,%edx
  802498:	f7 f7                	div    %edi
  80249a:	89 c5                	mov    %eax,%ebp
  80249c:	31 d2                	xor    %edx,%edx
  80249e:	89 c8                	mov    %ecx,%eax
  8024a0:	f7 f5                	div    %ebp
  8024a2:	89 c1                	mov    %eax,%ecx
  8024a4:	89 d8                	mov    %ebx,%eax
  8024a6:	f7 f5                	div    %ebp
  8024a8:	89 cf                	mov    %ecx,%edi
  8024aa:	89 fa                	mov    %edi,%edx
  8024ac:	83 c4 1c             	add    $0x1c,%esp
  8024af:	5b                   	pop    %ebx
  8024b0:	5e                   	pop    %esi
  8024b1:	5f                   	pop    %edi
  8024b2:	5d                   	pop    %ebp
  8024b3:	c3                   	ret    
  8024b4:	39 ce                	cmp    %ecx,%esi
  8024b6:	77 28                	ja     8024e0 <__udivdi3+0x7c>
  8024b8:	0f bd fe             	bsr    %esi,%edi
  8024bb:	83 f7 1f             	xor    $0x1f,%edi
  8024be:	75 40                	jne    802500 <__udivdi3+0x9c>
  8024c0:	39 ce                	cmp    %ecx,%esi
  8024c2:	72 0a                	jb     8024ce <__udivdi3+0x6a>
  8024c4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8024c8:	0f 87 9e 00 00 00    	ja     80256c <__udivdi3+0x108>
  8024ce:	b8 01 00 00 00       	mov    $0x1,%eax
  8024d3:	89 fa                	mov    %edi,%edx
  8024d5:	83 c4 1c             	add    $0x1c,%esp
  8024d8:	5b                   	pop    %ebx
  8024d9:	5e                   	pop    %esi
  8024da:	5f                   	pop    %edi
  8024db:	5d                   	pop    %ebp
  8024dc:	c3                   	ret    
  8024dd:	8d 76 00             	lea    0x0(%esi),%esi
  8024e0:	31 ff                	xor    %edi,%edi
  8024e2:	31 c0                	xor    %eax,%eax
  8024e4:	89 fa                	mov    %edi,%edx
  8024e6:	83 c4 1c             	add    $0x1c,%esp
  8024e9:	5b                   	pop    %ebx
  8024ea:	5e                   	pop    %esi
  8024eb:	5f                   	pop    %edi
  8024ec:	5d                   	pop    %ebp
  8024ed:	c3                   	ret    
  8024ee:	66 90                	xchg   %ax,%ax
  8024f0:	89 d8                	mov    %ebx,%eax
  8024f2:	f7 f7                	div    %edi
  8024f4:	31 ff                	xor    %edi,%edi
  8024f6:	89 fa                	mov    %edi,%edx
  8024f8:	83 c4 1c             	add    $0x1c,%esp
  8024fb:	5b                   	pop    %ebx
  8024fc:	5e                   	pop    %esi
  8024fd:	5f                   	pop    %edi
  8024fe:	5d                   	pop    %ebp
  8024ff:	c3                   	ret    
  802500:	bd 20 00 00 00       	mov    $0x20,%ebp
  802505:	89 eb                	mov    %ebp,%ebx
  802507:	29 fb                	sub    %edi,%ebx
  802509:	89 f9                	mov    %edi,%ecx
  80250b:	d3 e6                	shl    %cl,%esi
  80250d:	89 c5                	mov    %eax,%ebp
  80250f:	88 d9                	mov    %bl,%cl
  802511:	d3 ed                	shr    %cl,%ebp
  802513:	89 e9                	mov    %ebp,%ecx
  802515:	09 f1                	or     %esi,%ecx
  802517:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80251b:	89 f9                	mov    %edi,%ecx
  80251d:	d3 e0                	shl    %cl,%eax
  80251f:	89 c5                	mov    %eax,%ebp
  802521:	89 d6                	mov    %edx,%esi
  802523:	88 d9                	mov    %bl,%cl
  802525:	d3 ee                	shr    %cl,%esi
  802527:	89 f9                	mov    %edi,%ecx
  802529:	d3 e2                	shl    %cl,%edx
  80252b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80252f:	88 d9                	mov    %bl,%cl
  802531:	d3 e8                	shr    %cl,%eax
  802533:	09 c2                	or     %eax,%edx
  802535:	89 d0                	mov    %edx,%eax
  802537:	89 f2                	mov    %esi,%edx
  802539:	f7 74 24 0c          	divl   0xc(%esp)
  80253d:	89 d6                	mov    %edx,%esi
  80253f:	89 c3                	mov    %eax,%ebx
  802541:	f7 e5                	mul    %ebp
  802543:	39 d6                	cmp    %edx,%esi
  802545:	72 19                	jb     802560 <__udivdi3+0xfc>
  802547:	74 0b                	je     802554 <__udivdi3+0xf0>
  802549:	89 d8                	mov    %ebx,%eax
  80254b:	31 ff                	xor    %edi,%edi
  80254d:	e9 58 ff ff ff       	jmp    8024aa <__udivdi3+0x46>
  802552:	66 90                	xchg   %ax,%ax
  802554:	8b 54 24 08          	mov    0x8(%esp),%edx
  802558:	89 f9                	mov    %edi,%ecx
  80255a:	d3 e2                	shl    %cl,%edx
  80255c:	39 c2                	cmp    %eax,%edx
  80255e:	73 e9                	jae    802549 <__udivdi3+0xe5>
  802560:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802563:	31 ff                	xor    %edi,%edi
  802565:	e9 40 ff ff ff       	jmp    8024aa <__udivdi3+0x46>
  80256a:	66 90                	xchg   %ax,%ax
  80256c:	31 c0                	xor    %eax,%eax
  80256e:	e9 37 ff ff ff       	jmp    8024aa <__udivdi3+0x46>
  802573:	90                   	nop

00802574 <__umoddi3>:
  802574:	55                   	push   %ebp
  802575:	57                   	push   %edi
  802576:	56                   	push   %esi
  802577:	53                   	push   %ebx
  802578:	83 ec 1c             	sub    $0x1c,%esp
  80257b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80257f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802583:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802587:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80258b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80258f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802593:	89 f3                	mov    %esi,%ebx
  802595:	89 fa                	mov    %edi,%edx
  802597:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80259b:	89 34 24             	mov    %esi,(%esp)
  80259e:	85 c0                	test   %eax,%eax
  8025a0:	75 1a                	jne    8025bc <__umoddi3+0x48>
  8025a2:	39 f7                	cmp    %esi,%edi
  8025a4:	0f 86 a2 00 00 00    	jbe    80264c <__umoddi3+0xd8>
  8025aa:	89 c8                	mov    %ecx,%eax
  8025ac:	89 f2                	mov    %esi,%edx
  8025ae:	f7 f7                	div    %edi
  8025b0:	89 d0                	mov    %edx,%eax
  8025b2:	31 d2                	xor    %edx,%edx
  8025b4:	83 c4 1c             	add    $0x1c,%esp
  8025b7:	5b                   	pop    %ebx
  8025b8:	5e                   	pop    %esi
  8025b9:	5f                   	pop    %edi
  8025ba:	5d                   	pop    %ebp
  8025bb:	c3                   	ret    
  8025bc:	39 f0                	cmp    %esi,%eax
  8025be:	0f 87 ac 00 00 00    	ja     802670 <__umoddi3+0xfc>
  8025c4:	0f bd e8             	bsr    %eax,%ebp
  8025c7:	83 f5 1f             	xor    $0x1f,%ebp
  8025ca:	0f 84 ac 00 00 00    	je     80267c <__umoddi3+0x108>
  8025d0:	bf 20 00 00 00       	mov    $0x20,%edi
  8025d5:	29 ef                	sub    %ebp,%edi
  8025d7:	89 fe                	mov    %edi,%esi
  8025d9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8025dd:	89 e9                	mov    %ebp,%ecx
  8025df:	d3 e0                	shl    %cl,%eax
  8025e1:	89 d7                	mov    %edx,%edi
  8025e3:	89 f1                	mov    %esi,%ecx
  8025e5:	d3 ef                	shr    %cl,%edi
  8025e7:	09 c7                	or     %eax,%edi
  8025e9:	89 e9                	mov    %ebp,%ecx
  8025eb:	d3 e2                	shl    %cl,%edx
  8025ed:	89 14 24             	mov    %edx,(%esp)
  8025f0:	89 d8                	mov    %ebx,%eax
  8025f2:	d3 e0                	shl    %cl,%eax
  8025f4:	89 c2                	mov    %eax,%edx
  8025f6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8025fa:	d3 e0                	shl    %cl,%eax
  8025fc:	89 44 24 04          	mov    %eax,0x4(%esp)
  802600:	8b 44 24 08          	mov    0x8(%esp),%eax
  802604:	89 f1                	mov    %esi,%ecx
  802606:	d3 e8                	shr    %cl,%eax
  802608:	09 d0                	or     %edx,%eax
  80260a:	d3 eb                	shr    %cl,%ebx
  80260c:	89 da                	mov    %ebx,%edx
  80260e:	f7 f7                	div    %edi
  802610:	89 d3                	mov    %edx,%ebx
  802612:	f7 24 24             	mull   (%esp)
  802615:	89 c6                	mov    %eax,%esi
  802617:	89 d1                	mov    %edx,%ecx
  802619:	39 d3                	cmp    %edx,%ebx
  80261b:	0f 82 87 00 00 00    	jb     8026a8 <__umoddi3+0x134>
  802621:	0f 84 91 00 00 00    	je     8026b8 <__umoddi3+0x144>
  802627:	8b 54 24 04          	mov    0x4(%esp),%edx
  80262b:	29 f2                	sub    %esi,%edx
  80262d:	19 cb                	sbb    %ecx,%ebx
  80262f:	89 d8                	mov    %ebx,%eax
  802631:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802635:	d3 e0                	shl    %cl,%eax
  802637:	89 e9                	mov    %ebp,%ecx
  802639:	d3 ea                	shr    %cl,%edx
  80263b:	09 d0                	or     %edx,%eax
  80263d:	89 e9                	mov    %ebp,%ecx
  80263f:	d3 eb                	shr    %cl,%ebx
  802641:	89 da                	mov    %ebx,%edx
  802643:	83 c4 1c             	add    $0x1c,%esp
  802646:	5b                   	pop    %ebx
  802647:	5e                   	pop    %esi
  802648:	5f                   	pop    %edi
  802649:	5d                   	pop    %ebp
  80264a:	c3                   	ret    
  80264b:	90                   	nop
  80264c:	89 fd                	mov    %edi,%ebp
  80264e:	85 ff                	test   %edi,%edi
  802650:	75 0b                	jne    80265d <__umoddi3+0xe9>
  802652:	b8 01 00 00 00       	mov    $0x1,%eax
  802657:	31 d2                	xor    %edx,%edx
  802659:	f7 f7                	div    %edi
  80265b:	89 c5                	mov    %eax,%ebp
  80265d:	89 f0                	mov    %esi,%eax
  80265f:	31 d2                	xor    %edx,%edx
  802661:	f7 f5                	div    %ebp
  802663:	89 c8                	mov    %ecx,%eax
  802665:	f7 f5                	div    %ebp
  802667:	89 d0                	mov    %edx,%eax
  802669:	e9 44 ff ff ff       	jmp    8025b2 <__umoddi3+0x3e>
  80266e:	66 90                	xchg   %ax,%ax
  802670:	89 c8                	mov    %ecx,%eax
  802672:	89 f2                	mov    %esi,%edx
  802674:	83 c4 1c             	add    $0x1c,%esp
  802677:	5b                   	pop    %ebx
  802678:	5e                   	pop    %esi
  802679:	5f                   	pop    %edi
  80267a:	5d                   	pop    %ebp
  80267b:	c3                   	ret    
  80267c:	3b 04 24             	cmp    (%esp),%eax
  80267f:	72 06                	jb     802687 <__umoddi3+0x113>
  802681:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802685:	77 0f                	ja     802696 <__umoddi3+0x122>
  802687:	89 f2                	mov    %esi,%edx
  802689:	29 f9                	sub    %edi,%ecx
  80268b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80268f:	89 14 24             	mov    %edx,(%esp)
  802692:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802696:	8b 44 24 04          	mov    0x4(%esp),%eax
  80269a:	8b 14 24             	mov    (%esp),%edx
  80269d:	83 c4 1c             	add    $0x1c,%esp
  8026a0:	5b                   	pop    %ebx
  8026a1:	5e                   	pop    %esi
  8026a2:	5f                   	pop    %edi
  8026a3:	5d                   	pop    %ebp
  8026a4:	c3                   	ret    
  8026a5:	8d 76 00             	lea    0x0(%esi),%esi
  8026a8:	2b 04 24             	sub    (%esp),%eax
  8026ab:	19 fa                	sbb    %edi,%edx
  8026ad:	89 d1                	mov    %edx,%ecx
  8026af:	89 c6                	mov    %eax,%esi
  8026b1:	e9 71 ff ff ff       	jmp    802627 <__umoddi3+0xb3>
  8026b6:	66 90                	xchg   %ax,%ax
  8026b8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8026bc:	72 ea                	jb     8026a8 <__umoddi3+0x134>
  8026be:	89 d9                	mov    %ebx,%ecx
  8026c0:	e9 62 ff ff ff       	jmp    802627 <__umoddi3+0xb3>
