
obj/user/arrayOperations_quicksort:     file format elf32-i386


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
  800031:	e8 20 03 00 00       	call   800356 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

void QuickSort(int *Elements, int NumOfElements);
void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	int32 envID = sys_getenvid();
  80003e:	e8 25 16 00 00       	call   801668 <sys_getenvid>
  800043:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int32 parentenvID = sys_getparentenvid();
  800046:	e8 4f 16 00 00       	call   80169a <sys_getparentenvid>
  80004b:	89 45 ec             	mov    %eax,-0x14(%ebp)

	int ret;
	/*[1] GET SHARED VARs*/
	//Get the shared array & its size
	int *numOfElements = NULL;
  80004e:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
	int *sharedArray = NULL;
  800055:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	sharedArray = sget(parentenvID,"arr") ;
  80005c:	83 ec 08             	sub    $0x8,%esp
  80005f:	68 80 20 80 00       	push   $0x802080
  800064:	ff 75 ec             	pushl  -0x14(%ebp)
  800067:	e8 c6 14 00 00       	call   801532 <sget>
  80006c:	83 c4 10             	add    $0x10,%esp
  80006f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	numOfElements = sget(parentenvID,"arrSize") ;
  800072:	83 ec 08             	sub    $0x8,%esp
  800075:	68 84 20 80 00       	push   $0x802084
  80007a:	ff 75 ec             	pushl  -0x14(%ebp)
  80007d:	e8 b0 14 00 00       	call   801532 <sget>
  800082:	83 c4 10             	add    $0x10,%esp
  800085:	89 45 e8             	mov    %eax,-0x18(%ebp)

	//Get the check-finishing counter
	int *finishedCount = NULL;
  800088:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	finishedCount = sget(parentenvID,"finishedCount") ;
  80008f:	83 ec 08             	sub    $0x8,%esp
  800092:	68 8c 20 80 00       	push   $0x80208c
  800097:	ff 75 ec             	pushl  -0x14(%ebp)
  80009a:	e8 93 14 00 00       	call   801532 <sget>
  80009f:	83 c4 10             	add    $0x10,%esp
  8000a2:	89 45 e0             	mov    %eax,-0x20(%ebp)

	/*[2] DO THE JOB*/
	//take a copy from the original array
	int *sortedArray;
	sortedArray = smalloc("quicksortedArr", sizeof(int) * *numOfElements, 0) ;
  8000a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000a8:	8b 00                	mov    (%eax),%eax
  8000aa:	c1 e0 02             	shl    $0x2,%eax
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 00                	push   $0x0
  8000b2:	50                   	push   %eax
  8000b3:	68 9a 20 80 00       	push   $0x80209a
  8000b8:	e8 52 14 00 00       	call   80150f <smalloc>
  8000bd:	83 c4 10             	add    $0x10,%esp
  8000c0:	89 45 dc             	mov    %eax,-0x24(%ebp)
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000ca:	eb 25                	jmp    8000f1 <_main+0xb9>
	{
		sortedArray[i] = sharedArray[i];
  8000cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000cf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8000d6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8000d9:	01 c2                	add    %eax,%edx
  8000db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000de:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8000e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000e8:	01 c8                	add    %ecx,%eax
  8000ea:	8b 00                	mov    (%eax),%eax
  8000ec:	89 02                	mov    %eax,(%edx)
	/*[2] DO THE JOB*/
	//take a copy from the original array
	int *sortedArray;
	sortedArray = smalloc("quicksortedArr", sizeof(int) * *numOfElements, 0) ;
	int i ;
	for (i = 0 ; i < *numOfElements ; i++)
  8000ee:	ff 45 f4             	incl   -0xc(%ebp)
  8000f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000f4:	8b 00                	mov    (%eax),%eax
  8000f6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8000f9:	7f d1                	jg     8000cc <_main+0x94>
	{
		sortedArray[i] = sharedArray[i];
	}
	QuickSort(sortedArray, *numOfElements);
  8000fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000fe:	8b 00                	mov    (%eax),%eax
  800100:	83 ec 08             	sub    $0x8,%esp
  800103:	50                   	push   %eax
  800104:	ff 75 dc             	pushl  -0x24(%ebp)
  800107:	e8 23 00 00 00       	call   80012f <QuickSort>
  80010c:	83 c4 10             	add    $0x10,%esp
	cprintf("Quick sort is Finished!!!!\n") ;
  80010f:	83 ec 0c             	sub    $0xc,%esp
  800112:	68 a9 20 80 00       	push   $0x8020a9
  800117:	e8 53 04 00 00       	call   80056f <cprintf>
  80011c:	83 c4 10             	add    $0x10,%esp

	/*[3] SHARE THE RESULTS & DECLARE FINISHING*/
	(*finishedCount)++ ;
  80011f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800122:	8b 00                	mov    (%eax),%eax
  800124:	8d 50 01             	lea    0x1(%eax),%edx
  800127:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80012a:	89 10                	mov    %edx,(%eax)

}
  80012c:	90                   	nop
  80012d:	c9                   	leave  
  80012e:	c3                   	ret    

0080012f <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  80012f:	55                   	push   %ebp
  800130:	89 e5                	mov    %esp,%ebp
  800132:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  800135:	8b 45 0c             	mov    0xc(%ebp),%eax
  800138:	48                   	dec    %eax
  800139:	50                   	push   %eax
  80013a:	6a 00                	push   $0x0
  80013c:	ff 75 0c             	pushl  0xc(%ebp)
  80013f:	ff 75 08             	pushl  0x8(%ebp)
  800142:	e8 06 00 00 00       	call   80014d <QSort>
  800147:	83 c4 10             	add    $0x10,%esp
}
  80014a:	90                   	nop
  80014b:	c9                   	leave  
  80014c:	c3                   	ret    

0080014d <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  80014d:	55                   	push   %ebp
  80014e:	89 e5                	mov    %esp,%ebp
  800150:	83 ec 28             	sub    $0x28,%esp
	if (startIndex >= finalIndex) return;
  800153:	8b 45 10             	mov    0x10(%ebp),%eax
  800156:	3b 45 14             	cmp    0x14(%ebp),%eax
  800159:	0f 8d 1b 01 00 00    	jge    80027a <QSort+0x12d>
	int pvtIndex = RAND(startIndex, finalIndex) ;
  80015f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  800162:	83 ec 0c             	sub    $0xc,%esp
  800165:	50                   	push   %eax
  800166:	e8 8c 18 00 00       	call   8019f7 <sys_get_virtual_time>
  80016b:	83 c4 0c             	add    $0xc,%esp
  80016e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800171:	8b 55 14             	mov    0x14(%ebp),%edx
  800174:	2b 55 10             	sub    0x10(%ebp),%edx
  800177:	89 d1                	mov    %edx,%ecx
  800179:	ba 00 00 00 00       	mov    $0x0,%edx
  80017e:	f7 f1                	div    %ecx
  800180:	8b 45 10             	mov    0x10(%ebp),%eax
  800183:	01 d0                	add    %edx,%eax
  800185:	89 45 ec             	mov    %eax,-0x14(%ebp)
	Swap(Elements, startIndex, pvtIndex);
  800188:	83 ec 04             	sub    $0x4,%esp
  80018b:	ff 75 ec             	pushl  -0x14(%ebp)
  80018e:	ff 75 10             	pushl  0x10(%ebp)
  800191:	ff 75 08             	pushl  0x8(%ebp)
  800194:	e8 e4 00 00 00       	call   80027d <Swap>
  800199:	83 c4 10             	add    $0x10,%esp

	int i = startIndex+1, j = finalIndex;
  80019c:	8b 45 10             	mov    0x10(%ebp),%eax
  80019f:	40                   	inc    %eax
  8001a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8001a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8001a6:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8001a9:	e9 80 00 00 00       	jmp    80022e <QSort+0xe1>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  8001ae:	ff 45 f4             	incl   -0xc(%ebp)
  8001b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001b4:	3b 45 14             	cmp    0x14(%ebp),%eax
  8001b7:	7f 2b                	jg     8001e4 <QSort+0x97>
  8001b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8001bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8001c6:	01 d0                	add    %edx,%eax
  8001c8:	8b 10                	mov    (%eax),%edx
  8001ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8001cd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8001d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8001d7:	01 c8                	add    %ecx,%eax
  8001d9:	8b 00                	mov    (%eax),%eax
  8001db:	39 c2                	cmp    %eax,%edx
  8001dd:	7d cf                	jge    8001ae <QSort+0x61>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8001df:	eb 03                	jmp    8001e4 <QSort+0x97>
  8001e1:	ff 4d f0             	decl   -0x10(%ebp)
  8001e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8001e7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8001ea:	7e 26                	jle    800212 <QSort+0xc5>
  8001ec:	8b 45 10             	mov    0x10(%ebp),%eax
  8001ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8001f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8001f9:	01 d0                	add    %edx,%eax
  8001fb:	8b 10                	mov    (%eax),%edx
  8001fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800200:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800207:	8b 45 08             	mov    0x8(%ebp),%eax
  80020a:	01 c8                	add    %ecx,%eax
  80020c:	8b 00                	mov    (%eax),%eax
  80020e:	39 c2                	cmp    %eax,%edx
  800210:	7e cf                	jle    8001e1 <QSort+0x94>

		if (i <= j)
  800212:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800215:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800218:	7f 14                	jg     80022e <QSort+0xe1>
		{
			Swap(Elements, i, j);
  80021a:	83 ec 04             	sub    $0x4,%esp
  80021d:	ff 75 f0             	pushl  -0x10(%ebp)
  800220:	ff 75 f4             	pushl  -0xc(%ebp)
  800223:	ff 75 08             	pushl  0x8(%ebp)
  800226:	e8 52 00 00 00       	call   80027d <Swap>
  80022b:	83 c4 10             	add    $0x10,%esp
	int pvtIndex = RAND(startIndex, finalIndex) ;
	Swap(Elements, startIndex, pvtIndex);

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  80022e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800231:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800234:	0f 8e 77 ff ff ff    	jle    8001b1 <QSort+0x64>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  80023a:	83 ec 04             	sub    $0x4,%esp
  80023d:	ff 75 f0             	pushl  -0x10(%ebp)
  800240:	ff 75 10             	pushl  0x10(%ebp)
  800243:	ff 75 08             	pushl  0x8(%ebp)
  800246:	e8 32 00 00 00       	call   80027d <Swap>
  80024b:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  80024e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800251:	48                   	dec    %eax
  800252:	50                   	push   %eax
  800253:	ff 75 10             	pushl  0x10(%ebp)
  800256:	ff 75 0c             	pushl  0xc(%ebp)
  800259:	ff 75 08             	pushl  0x8(%ebp)
  80025c:	e8 ec fe ff ff       	call   80014d <QSort>
  800261:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  800264:	ff 75 14             	pushl  0x14(%ebp)
  800267:	ff 75 f4             	pushl  -0xc(%ebp)
  80026a:	ff 75 0c             	pushl  0xc(%ebp)
  80026d:	ff 75 08             	pushl  0x8(%ebp)
  800270:	e8 d8 fe ff ff       	call   80014d <QSort>
  800275:	83 c4 10             	add    $0x10,%esp
  800278:	eb 01                	jmp    80027b <QSort+0x12e>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  80027a:	90                   	nop
	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);

	//cprintf("qs,after sorting: start = %d, end = %d\n", startIndex, finalIndex);

}
  80027b:	c9                   	leave  
  80027c:	c3                   	ret    

0080027d <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80027d:	55                   	push   %ebp
  80027e:	89 e5                	mov    %esp,%ebp
  800280:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800283:	8b 45 0c             	mov    0xc(%ebp),%eax
  800286:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80028d:	8b 45 08             	mov    0x8(%ebp),%eax
  800290:	01 d0                	add    %edx,%eax
  800292:	8b 00                	mov    (%eax),%eax
  800294:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800297:	8b 45 0c             	mov    0xc(%ebp),%eax
  80029a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8002a4:	01 c2                	add    %eax,%edx
  8002a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8002a9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8002b3:	01 c8                	add    %ecx,%eax
  8002b5:	8b 00                	mov    (%eax),%eax
  8002b7:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  8002b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8002bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c6:	01 c2                	add    %eax,%edx
  8002c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8002cb:	89 02                	mov    %eax,(%edx)
}
  8002cd:	90                   	nop
  8002ce:	c9                   	leave  
  8002cf:	c3                   	ret    

008002d0 <PrintElements>:


void PrintElements(int *Elements, int NumOfElements)
{
  8002d0:	55                   	push   %ebp
  8002d1:	89 e5                	mov    %esp,%ebp
  8002d3:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  8002d6:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8002dd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8002e4:	eb 42                	jmp    800328 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  8002e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002e9:	99                   	cltd   
  8002ea:	f7 7d f0             	idivl  -0x10(%ebp)
  8002ed:	89 d0                	mov    %edx,%eax
  8002ef:	85 c0                	test   %eax,%eax
  8002f1:	75 10                	jne    800303 <PrintElements+0x33>
			cprintf("\n");
  8002f3:	83 ec 0c             	sub    $0xc,%esp
  8002f6:	68 c5 20 80 00       	push   $0x8020c5
  8002fb:	e8 6f 02 00 00       	call   80056f <cprintf>
  800300:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800303:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800306:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80030d:	8b 45 08             	mov    0x8(%ebp),%eax
  800310:	01 d0                	add    %edx,%eax
  800312:	8b 00                	mov    (%eax),%eax
  800314:	83 ec 08             	sub    $0x8,%esp
  800317:	50                   	push   %eax
  800318:	68 c7 20 80 00       	push   $0x8020c7
  80031d:	e8 4d 02 00 00       	call   80056f <cprintf>
  800322:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800325:	ff 45 f4             	incl   -0xc(%ebp)
  800328:	8b 45 0c             	mov    0xc(%ebp),%eax
  80032b:	48                   	dec    %eax
  80032c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80032f:	7f b5                	jg     8002e6 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800331:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800334:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80033b:	8b 45 08             	mov    0x8(%ebp),%eax
  80033e:	01 d0                	add    %edx,%eax
  800340:	8b 00                	mov    (%eax),%eax
  800342:	83 ec 08             	sub    $0x8,%esp
  800345:	50                   	push   %eax
  800346:	68 cc 20 80 00       	push   $0x8020cc
  80034b:	e8 1f 02 00 00       	call   80056f <cprintf>
  800350:	83 c4 10             	add    $0x10,%esp

}
  800353:	90                   	nop
  800354:	c9                   	leave  
  800355:	c3                   	ret    

00800356 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800356:	55                   	push   %ebp
  800357:	89 e5                	mov    %esp,%ebp
  800359:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80035c:	e8 20 13 00 00       	call   801681 <sys_getenvindex>
  800361:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800364:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800367:	89 d0                	mov    %edx,%eax
  800369:	c1 e0 03             	shl    $0x3,%eax
  80036c:	01 d0                	add    %edx,%eax
  80036e:	8d 0c c5 00 00 00 00 	lea    0x0(,%eax,8),%ecx
  800375:	01 c8                	add    %ecx,%eax
  800377:	01 c0                	add    %eax,%eax
  800379:	01 d0                	add    %edx,%eax
  80037b:	01 c0                	add    %eax,%eax
  80037d:	01 d0                	add    %edx,%eax
  80037f:	89 c2                	mov    %eax,%edx
  800381:	c1 e2 05             	shl    $0x5,%edx
  800384:	29 c2                	sub    %eax,%edx
  800386:	8d 04 d5 00 00 00 00 	lea    0x0(,%edx,8),%eax
  80038d:	89 c2                	mov    %eax,%edx
  80038f:	8d 82 00 00 c0 ee    	lea    -0x11400000(%edx),%eax
  800395:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80039a:	a1 20 30 80 00       	mov    0x803020,%eax
  80039f:	8a 80 40 3c 01 00    	mov    0x13c40(%eax),%al
  8003a5:	84 c0                	test   %al,%al
  8003a7:	74 0f                	je     8003b8 <libmain+0x62>
		binaryname = myEnv->prog_name;
  8003a9:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ae:	05 40 3c 01 00       	add    $0x13c40,%eax
  8003b3:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8003b8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8003bc:	7e 0a                	jle    8003c8 <libmain+0x72>
		binaryname = argv[0];
  8003be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c1:	8b 00                	mov    (%eax),%eax
  8003c3:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8003c8:	83 ec 08             	sub    $0x8,%esp
  8003cb:	ff 75 0c             	pushl  0xc(%ebp)
  8003ce:	ff 75 08             	pushl  0x8(%ebp)
  8003d1:	e8 62 fc ff ff       	call   800038 <_main>
  8003d6:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8003d9:	e8 3e 14 00 00       	call   80181c <sys_disable_interrupt>
	cprintf("**************************************\n");
  8003de:	83 ec 0c             	sub    $0xc,%esp
  8003e1:	68 e8 20 80 00       	push   $0x8020e8
  8003e6:	e8 84 01 00 00       	call   80056f <cprintf>
  8003eb:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003ee:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f3:	8b 90 30 3c 01 00    	mov    0x13c30(%eax),%edx
  8003f9:	a1 20 30 80 00       	mov    0x803020,%eax
  8003fe:	8b 80 20 3c 01 00    	mov    0x13c20(%eax),%eax
  800404:	83 ec 04             	sub    $0x4,%esp
  800407:	52                   	push   %edx
  800408:	50                   	push   %eax
  800409:	68 10 21 80 00       	push   $0x802110
  80040e:	e8 5c 01 00 00       	call   80056f <cprintf>
  800413:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE IN (from disk) = %d, Num of PAGE OUT (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut);
  800416:	a1 20 30 80 00       	mov    0x803020,%eax
  80041b:	8b 90 3c 3c 01 00    	mov    0x13c3c(%eax),%edx
  800421:	a1 20 30 80 00       	mov    0x803020,%eax
  800426:	8b 80 38 3c 01 00    	mov    0x13c38(%eax),%eax
  80042c:	83 ec 04             	sub    $0x4,%esp
  80042f:	52                   	push   %edx
  800430:	50                   	push   %eax
  800431:	68 38 21 80 00       	push   $0x802138
  800436:	e8 34 01 00 00       	call   80056f <cprintf>
  80043b:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	cprintf("Num of clocks = %d\n", myEnv->nClocks);
  80043e:	a1 20 30 80 00       	mov    0x803020,%eax
  800443:	8b 80 88 3c 01 00    	mov    0x13c88(%eax),%eax
  800449:	83 ec 08             	sub    $0x8,%esp
  80044c:	50                   	push   %eax
  80044d:	68 79 21 80 00       	push   $0x802179
  800452:	e8 18 01 00 00       	call   80056f <cprintf>
  800457:	83 c4 10             	add    $0x10,%esp
	cprintf("**************************************\n");
  80045a:	83 ec 0c             	sub    $0xc,%esp
  80045d:	68 e8 20 80 00       	push   $0x8020e8
  800462:	e8 08 01 00 00       	call   80056f <cprintf>
  800467:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80046a:	e8 c7 13 00 00       	call   801836 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80046f:	e8 19 00 00 00       	call   80048d <exit>
}
  800474:	90                   	nop
  800475:	c9                   	leave  
  800476:	c3                   	ret    

00800477 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800477:	55                   	push   %ebp
  800478:	89 e5                	mov    %esp,%ebp
  80047a:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80047d:	83 ec 0c             	sub    $0xc,%esp
  800480:	6a 00                	push   $0x0
  800482:	e8 c6 11 00 00       	call   80164d <sys_env_destroy>
  800487:	83 c4 10             	add    $0x10,%esp
}
  80048a:	90                   	nop
  80048b:	c9                   	leave  
  80048c:	c3                   	ret    

0080048d <exit>:

void
exit(void)
{
  80048d:	55                   	push   %ebp
  80048e:	89 e5                	mov    %esp,%ebp
  800490:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800493:	e8 1b 12 00 00       	call   8016b3 <sys_env_exit>
}
  800498:	90                   	nop
  800499:	c9                   	leave  
  80049a:	c3                   	ret    

0080049b <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80049b:	55                   	push   %ebp
  80049c:	89 e5                	mov    %esp,%ebp
  80049e:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8004a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004a4:	8b 00                	mov    (%eax),%eax
  8004a6:	8d 48 01             	lea    0x1(%eax),%ecx
  8004a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004ac:	89 0a                	mov    %ecx,(%edx)
  8004ae:	8b 55 08             	mov    0x8(%ebp),%edx
  8004b1:	88 d1                	mov    %dl,%cl
  8004b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004b6:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8004ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004bd:	8b 00                	mov    (%eax),%eax
  8004bf:	3d ff 00 00 00       	cmp    $0xff,%eax
  8004c4:	75 2c                	jne    8004f2 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8004c6:	a0 24 30 80 00       	mov    0x803024,%al
  8004cb:	0f b6 c0             	movzbl %al,%eax
  8004ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004d1:	8b 12                	mov    (%edx),%edx
  8004d3:	89 d1                	mov    %edx,%ecx
  8004d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004d8:	83 c2 08             	add    $0x8,%edx
  8004db:	83 ec 04             	sub    $0x4,%esp
  8004de:	50                   	push   %eax
  8004df:	51                   	push   %ecx
  8004e0:	52                   	push   %edx
  8004e1:	e8 25 11 00 00       	call   80160b <sys_cputs>
  8004e6:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8004e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004ec:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8004f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f5:	8b 40 04             	mov    0x4(%eax),%eax
  8004f8:	8d 50 01             	lea    0x1(%eax),%edx
  8004fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004fe:	89 50 04             	mov    %edx,0x4(%eax)
}
  800501:	90                   	nop
  800502:	c9                   	leave  
  800503:	c3                   	ret    

00800504 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800504:	55                   	push   %ebp
  800505:	89 e5                	mov    %esp,%ebp
  800507:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80050d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800514:	00 00 00 
	b.cnt = 0;
  800517:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80051e:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800521:	ff 75 0c             	pushl  0xc(%ebp)
  800524:	ff 75 08             	pushl  0x8(%ebp)
  800527:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80052d:	50                   	push   %eax
  80052e:	68 9b 04 80 00       	push   $0x80049b
  800533:	e8 11 02 00 00       	call   800749 <vprintfmt>
  800538:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80053b:	a0 24 30 80 00       	mov    0x803024,%al
  800540:	0f b6 c0             	movzbl %al,%eax
  800543:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800549:	83 ec 04             	sub    $0x4,%esp
  80054c:	50                   	push   %eax
  80054d:	52                   	push   %edx
  80054e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800554:	83 c0 08             	add    $0x8,%eax
  800557:	50                   	push   %eax
  800558:	e8 ae 10 00 00       	call   80160b <sys_cputs>
  80055d:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800560:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800567:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80056d:	c9                   	leave  
  80056e:	c3                   	ret    

0080056f <cprintf>:

int cprintf(const char *fmt, ...) {
  80056f:	55                   	push   %ebp
  800570:	89 e5                	mov    %esp,%ebp
  800572:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800575:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80057c:	8d 45 0c             	lea    0xc(%ebp),%eax
  80057f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800582:	8b 45 08             	mov    0x8(%ebp),%eax
  800585:	83 ec 08             	sub    $0x8,%esp
  800588:	ff 75 f4             	pushl  -0xc(%ebp)
  80058b:	50                   	push   %eax
  80058c:	e8 73 ff ff ff       	call   800504 <vcprintf>
  800591:	83 c4 10             	add    $0x10,%esp
  800594:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800597:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80059a:	c9                   	leave  
  80059b:	c3                   	ret    

0080059c <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80059c:	55                   	push   %ebp
  80059d:	89 e5                	mov    %esp,%ebp
  80059f:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005a2:	e8 75 12 00 00       	call   80181c <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8005a7:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b0:	83 ec 08             	sub    $0x8,%esp
  8005b3:	ff 75 f4             	pushl  -0xc(%ebp)
  8005b6:	50                   	push   %eax
  8005b7:	e8 48 ff ff ff       	call   800504 <vcprintf>
  8005bc:	83 c4 10             	add    $0x10,%esp
  8005bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8005c2:	e8 6f 12 00 00       	call   801836 <sys_enable_interrupt>
	return cnt;
  8005c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005ca:	c9                   	leave  
  8005cb:	c3                   	ret    

008005cc <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8005cc:	55                   	push   %ebp
  8005cd:	89 e5                	mov    %esp,%ebp
  8005cf:	53                   	push   %ebx
  8005d0:	83 ec 14             	sub    $0x14,%esp
  8005d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8005d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8005d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8005dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8005df:	8b 45 18             	mov    0x18(%ebp),%eax
  8005e2:	ba 00 00 00 00       	mov    $0x0,%edx
  8005e7:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005ea:	77 55                	ja     800641 <printnum+0x75>
  8005ec:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8005ef:	72 05                	jb     8005f6 <printnum+0x2a>
  8005f1:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8005f4:	77 4b                	ja     800641 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8005f6:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8005f9:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8005fc:	8b 45 18             	mov    0x18(%ebp),%eax
  8005ff:	ba 00 00 00 00       	mov    $0x0,%edx
  800604:	52                   	push   %edx
  800605:	50                   	push   %eax
  800606:	ff 75 f4             	pushl  -0xc(%ebp)
  800609:	ff 75 f0             	pushl  -0x10(%ebp)
  80060c:	e8 fb 17 00 00       	call   801e0c <__udivdi3>
  800611:	83 c4 10             	add    $0x10,%esp
  800614:	83 ec 04             	sub    $0x4,%esp
  800617:	ff 75 20             	pushl  0x20(%ebp)
  80061a:	53                   	push   %ebx
  80061b:	ff 75 18             	pushl  0x18(%ebp)
  80061e:	52                   	push   %edx
  80061f:	50                   	push   %eax
  800620:	ff 75 0c             	pushl  0xc(%ebp)
  800623:	ff 75 08             	pushl  0x8(%ebp)
  800626:	e8 a1 ff ff ff       	call   8005cc <printnum>
  80062b:	83 c4 20             	add    $0x20,%esp
  80062e:	eb 1a                	jmp    80064a <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800630:	83 ec 08             	sub    $0x8,%esp
  800633:	ff 75 0c             	pushl  0xc(%ebp)
  800636:	ff 75 20             	pushl  0x20(%ebp)
  800639:	8b 45 08             	mov    0x8(%ebp),%eax
  80063c:	ff d0                	call   *%eax
  80063e:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800641:	ff 4d 1c             	decl   0x1c(%ebp)
  800644:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800648:	7f e6                	jg     800630 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80064a:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80064d:	bb 00 00 00 00       	mov    $0x0,%ebx
  800652:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800655:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800658:	53                   	push   %ebx
  800659:	51                   	push   %ecx
  80065a:	52                   	push   %edx
  80065b:	50                   	push   %eax
  80065c:	e8 bb 18 00 00       	call   801f1c <__umoddi3>
  800661:	83 c4 10             	add    $0x10,%esp
  800664:	05 b4 23 80 00       	add    $0x8023b4,%eax
  800669:	8a 00                	mov    (%eax),%al
  80066b:	0f be c0             	movsbl %al,%eax
  80066e:	83 ec 08             	sub    $0x8,%esp
  800671:	ff 75 0c             	pushl  0xc(%ebp)
  800674:	50                   	push   %eax
  800675:	8b 45 08             	mov    0x8(%ebp),%eax
  800678:	ff d0                	call   *%eax
  80067a:	83 c4 10             	add    $0x10,%esp
}
  80067d:	90                   	nop
  80067e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800681:	c9                   	leave  
  800682:	c3                   	ret    

00800683 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800683:	55                   	push   %ebp
  800684:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800686:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80068a:	7e 1c                	jle    8006a8 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80068c:	8b 45 08             	mov    0x8(%ebp),%eax
  80068f:	8b 00                	mov    (%eax),%eax
  800691:	8d 50 08             	lea    0x8(%eax),%edx
  800694:	8b 45 08             	mov    0x8(%ebp),%eax
  800697:	89 10                	mov    %edx,(%eax)
  800699:	8b 45 08             	mov    0x8(%ebp),%eax
  80069c:	8b 00                	mov    (%eax),%eax
  80069e:	83 e8 08             	sub    $0x8,%eax
  8006a1:	8b 50 04             	mov    0x4(%eax),%edx
  8006a4:	8b 00                	mov    (%eax),%eax
  8006a6:	eb 40                	jmp    8006e8 <getuint+0x65>
	else if (lflag)
  8006a8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006ac:	74 1e                	je     8006cc <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8006ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b1:	8b 00                	mov    (%eax),%eax
  8006b3:	8d 50 04             	lea    0x4(%eax),%edx
  8006b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b9:	89 10                	mov    %edx,(%eax)
  8006bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006be:	8b 00                	mov    (%eax),%eax
  8006c0:	83 e8 04             	sub    $0x4,%eax
  8006c3:	8b 00                	mov    (%eax),%eax
  8006c5:	ba 00 00 00 00       	mov    $0x0,%edx
  8006ca:	eb 1c                	jmp    8006e8 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8006cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cf:	8b 00                	mov    (%eax),%eax
  8006d1:	8d 50 04             	lea    0x4(%eax),%edx
  8006d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d7:	89 10                	mov    %edx,(%eax)
  8006d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006dc:	8b 00                	mov    (%eax),%eax
  8006de:	83 e8 04             	sub    $0x4,%eax
  8006e1:	8b 00                	mov    (%eax),%eax
  8006e3:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8006e8:	5d                   	pop    %ebp
  8006e9:	c3                   	ret    

008006ea <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8006ea:	55                   	push   %ebp
  8006eb:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006ed:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006f1:	7e 1c                	jle    80070f <getint+0x25>
		return va_arg(*ap, long long);
  8006f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f6:	8b 00                	mov    (%eax),%eax
  8006f8:	8d 50 08             	lea    0x8(%eax),%edx
  8006fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fe:	89 10                	mov    %edx,(%eax)
  800700:	8b 45 08             	mov    0x8(%ebp),%eax
  800703:	8b 00                	mov    (%eax),%eax
  800705:	83 e8 08             	sub    $0x8,%eax
  800708:	8b 50 04             	mov    0x4(%eax),%edx
  80070b:	8b 00                	mov    (%eax),%eax
  80070d:	eb 38                	jmp    800747 <getint+0x5d>
	else if (lflag)
  80070f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800713:	74 1a                	je     80072f <getint+0x45>
		return va_arg(*ap, long);
  800715:	8b 45 08             	mov    0x8(%ebp),%eax
  800718:	8b 00                	mov    (%eax),%eax
  80071a:	8d 50 04             	lea    0x4(%eax),%edx
  80071d:	8b 45 08             	mov    0x8(%ebp),%eax
  800720:	89 10                	mov    %edx,(%eax)
  800722:	8b 45 08             	mov    0x8(%ebp),%eax
  800725:	8b 00                	mov    (%eax),%eax
  800727:	83 e8 04             	sub    $0x4,%eax
  80072a:	8b 00                	mov    (%eax),%eax
  80072c:	99                   	cltd   
  80072d:	eb 18                	jmp    800747 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80072f:	8b 45 08             	mov    0x8(%ebp),%eax
  800732:	8b 00                	mov    (%eax),%eax
  800734:	8d 50 04             	lea    0x4(%eax),%edx
  800737:	8b 45 08             	mov    0x8(%ebp),%eax
  80073a:	89 10                	mov    %edx,(%eax)
  80073c:	8b 45 08             	mov    0x8(%ebp),%eax
  80073f:	8b 00                	mov    (%eax),%eax
  800741:	83 e8 04             	sub    $0x4,%eax
  800744:	8b 00                	mov    (%eax),%eax
  800746:	99                   	cltd   
}
  800747:	5d                   	pop    %ebp
  800748:	c3                   	ret    

00800749 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800749:	55                   	push   %ebp
  80074a:	89 e5                	mov    %esp,%ebp
  80074c:	56                   	push   %esi
  80074d:	53                   	push   %ebx
  80074e:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800751:	eb 17                	jmp    80076a <vprintfmt+0x21>
			if (ch == '\0')
  800753:	85 db                	test   %ebx,%ebx
  800755:	0f 84 af 03 00 00    	je     800b0a <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80075b:	83 ec 08             	sub    $0x8,%esp
  80075e:	ff 75 0c             	pushl  0xc(%ebp)
  800761:	53                   	push   %ebx
  800762:	8b 45 08             	mov    0x8(%ebp),%eax
  800765:	ff d0                	call   *%eax
  800767:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80076a:	8b 45 10             	mov    0x10(%ebp),%eax
  80076d:	8d 50 01             	lea    0x1(%eax),%edx
  800770:	89 55 10             	mov    %edx,0x10(%ebp)
  800773:	8a 00                	mov    (%eax),%al
  800775:	0f b6 d8             	movzbl %al,%ebx
  800778:	83 fb 25             	cmp    $0x25,%ebx
  80077b:	75 d6                	jne    800753 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80077d:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800781:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800788:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80078f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800796:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80079d:	8b 45 10             	mov    0x10(%ebp),%eax
  8007a0:	8d 50 01             	lea    0x1(%eax),%edx
  8007a3:	89 55 10             	mov    %edx,0x10(%ebp)
  8007a6:	8a 00                	mov    (%eax),%al
  8007a8:	0f b6 d8             	movzbl %al,%ebx
  8007ab:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8007ae:	83 f8 55             	cmp    $0x55,%eax
  8007b1:	0f 87 2b 03 00 00    	ja     800ae2 <vprintfmt+0x399>
  8007b7:	8b 04 85 d8 23 80 00 	mov    0x8023d8(,%eax,4),%eax
  8007be:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8007c0:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8007c4:	eb d7                	jmp    80079d <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8007c6:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8007ca:	eb d1                	jmp    80079d <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007cc:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8007d3:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8007d6:	89 d0                	mov    %edx,%eax
  8007d8:	c1 e0 02             	shl    $0x2,%eax
  8007db:	01 d0                	add    %edx,%eax
  8007dd:	01 c0                	add    %eax,%eax
  8007df:	01 d8                	add    %ebx,%eax
  8007e1:	83 e8 30             	sub    $0x30,%eax
  8007e4:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8007e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8007ea:	8a 00                	mov    (%eax),%al
  8007ec:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8007ef:	83 fb 2f             	cmp    $0x2f,%ebx
  8007f2:	7e 3e                	jle    800832 <vprintfmt+0xe9>
  8007f4:	83 fb 39             	cmp    $0x39,%ebx
  8007f7:	7f 39                	jg     800832 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007f9:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8007fc:	eb d5                	jmp    8007d3 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8007fe:	8b 45 14             	mov    0x14(%ebp),%eax
  800801:	83 c0 04             	add    $0x4,%eax
  800804:	89 45 14             	mov    %eax,0x14(%ebp)
  800807:	8b 45 14             	mov    0x14(%ebp),%eax
  80080a:	83 e8 04             	sub    $0x4,%eax
  80080d:	8b 00                	mov    (%eax),%eax
  80080f:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800812:	eb 1f                	jmp    800833 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800814:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800818:	79 83                	jns    80079d <vprintfmt+0x54>
				width = 0;
  80081a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800821:	e9 77 ff ff ff       	jmp    80079d <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800826:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80082d:	e9 6b ff ff ff       	jmp    80079d <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800832:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800833:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800837:	0f 89 60 ff ff ff    	jns    80079d <vprintfmt+0x54>
				width = precision, precision = -1;
  80083d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800840:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800843:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80084a:	e9 4e ff ff ff       	jmp    80079d <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80084f:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800852:	e9 46 ff ff ff       	jmp    80079d <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800857:	8b 45 14             	mov    0x14(%ebp),%eax
  80085a:	83 c0 04             	add    $0x4,%eax
  80085d:	89 45 14             	mov    %eax,0x14(%ebp)
  800860:	8b 45 14             	mov    0x14(%ebp),%eax
  800863:	83 e8 04             	sub    $0x4,%eax
  800866:	8b 00                	mov    (%eax),%eax
  800868:	83 ec 08             	sub    $0x8,%esp
  80086b:	ff 75 0c             	pushl  0xc(%ebp)
  80086e:	50                   	push   %eax
  80086f:	8b 45 08             	mov    0x8(%ebp),%eax
  800872:	ff d0                	call   *%eax
  800874:	83 c4 10             	add    $0x10,%esp
			break;
  800877:	e9 89 02 00 00       	jmp    800b05 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80087c:	8b 45 14             	mov    0x14(%ebp),%eax
  80087f:	83 c0 04             	add    $0x4,%eax
  800882:	89 45 14             	mov    %eax,0x14(%ebp)
  800885:	8b 45 14             	mov    0x14(%ebp),%eax
  800888:	83 e8 04             	sub    $0x4,%eax
  80088b:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80088d:	85 db                	test   %ebx,%ebx
  80088f:	79 02                	jns    800893 <vprintfmt+0x14a>
				err = -err;
  800891:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800893:	83 fb 64             	cmp    $0x64,%ebx
  800896:	7f 0b                	jg     8008a3 <vprintfmt+0x15a>
  800898:	8b 34 9d 20 22 80 00 	mov    0x802220(,%ebx,4),%esi
  80089f:	85 f6                	test   %esi,%esi
  8008a1:	75 19                	jne    8008bc <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8008a3:	53                   	push   %ebx
  8008a4:	68 c5 23 80 00       	push   $0x8023c5
  8008a9:	ff 75 0c             	pushl  0xc(%ebp)
  8008ac:	ff 75 08             	pushl  0x8(%ebp)
  8008af:	e8 5e 02 00 00       	call   800b12 <printfmt>
  8008b4:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8008b7:	e9 49 02 00 00       	jmp    800b05 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8008bc:	56                   	push   %esi
  8008bd:	68 ce 23 80 00       	push   $0x8023ce
  8008c2:	ff 75 0c             	pushl  0xc(%ebp)
  8008c5:	ff 75 08             	pushl  0x8(%ebp)
  8008c8:	e8 45 02 00 00       	call   800b12 <printfmt>
  8008cd:	83 c4 10             	add    $0x10,%esp
			break;
  8008d0:	e9 30 02 00 00       	jmp    800b05 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8008d5:	8b 45 14             	mov    0x14(%ebp),%eax
  8008d8:	83 c0 04             	add    $0x4,%eax
  8008db:	89 45 14             	mov    %eax,0x14(%ebp)
  8008de:	8b 45 14             	mov    0x14(%ebp),%eax
  8008e1:	83 e8 04             	sub    $0x4,%eax
  8008e4:	8b 30                	mov    (%eax),%esi
  8008e6:	85 f6                	test   %esi,%esi
  8008e8:	75 05                	jne    8008ef <vprintfmt+0x1a6>
				p = "(null)";
  8008ea:	be d1 23 80 00       	mov    $0x8023d1,%esi
			if (width > 0 && padc != '-')
  8008ef:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008f3:	7e 6d                	jle    800962 <vprintfmt+0x219>
  8008f5:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8008f9:	74 67                	je     800962 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8008fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008fe:	83 ec 08             	sub    $0x8,%esp
  800901:	50                   	push   %eax
  800902:	56                   	push   %esi
  800903:	e8 0c 03 00 00       	call   800c14 <strnlen>
  800908:	83 c4 10             	add    $0x10,%esp
  80090b:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80090e:	eb 16                	jmp    800926 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800910:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800914:	83 ec 08             	sub    $0x8,%esp
  800917:	ff 75 0c             	pushl  0xc(%ebp)
  80091a:	50                   	push   %eax
  80091b:	8b 45 08             	mov    0x8(%ebp),%eax
  80091e:	ff d0                	call   *%eax
  800920:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800923:	ff 4d e4             	decl   -0x1c(%ebp)
  800926:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80092a:	7f e4                	jg     800910 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80092c:	eb 34                	jmp    800962 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80092e:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800932:	74 1c                	je     800950 <vprintfmt+0x207>
  800934:	83 fb 1f             	cmp    $0x1f,%ebx
  800937:	7e 05                	jle    80093e <vprintfmt+0x1f5>
  800939:	83 fb 7e             	cmp    $0x7e,%ebx
  80093c:	7e 12                	jle    800950 <vprintfmt+0x207>
					putch('?', putdat);
  80093e:	83 ec 08             	sub    $0x8,%esp
  800941:	ff 75 0c             	pushl  0xc(%ebp)
  800944:	6a 3f                	push   $0x3f
  800946:	8b 45 08             	mov    0x8(%ebp),%eax
  800949:	ff d0                	call   *%eax
  80094b:	83 c4 10             	add    $0x10,%esp
  80094e:	eb 0f                	jmp    80095f <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800950:	83 ec 08             	sub    $0x8,%esp
  800953:	ff 75 0c             	pushl  0xc(%ebp)
  800956:	53                   	push   %ebx
  800957:	8b 45 08             	mov    0x8(%ebp),%eax
  80095a:	ff d0                	call   *%eax
  80095c:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80095f:	ff 4d e4             	decl   -0x1c(%ebp)
  800962:	89 f0                	mov    %esi,%eax
  800964:	8d 70 01             	lea    0x1(%eax),%esi
  800967:	8a 00                	mov    (%eax),%al
  800969:	0f be d8             	movsbl %al,%ebx
  80096c:	85 db                	test   %ebx,%ebx
  80096e:	74 24                	je     800994 <vprintfmt+0x24b>
  800970:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800974:	78 b8                	js     80092e <vprintfmt+0x1e5>
  800976:	ff 4d e0             	decl   -0x20(%ebp)
  800979:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80097d:	79 af                	jns    80092e <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80097f:	eb 13                	jmp    800994 <vprintfmt+0x24b>
				putch(' ', putdat);
  800981:	83 ec 08             	sub    $0x8,%esp
  800984:	ff 75 0c             	pushl  0xc(%ebp)
  800987:	6a 20                	push   $0x20
  800989:	8b 45 08             	mov    0x8(%ebp),%eax
  80098c:	ff d0                	call   *%eax
  80098e:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800991:	ff 4d e4             	decl   -0x1c(%ebp)
  800994:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800998:	7f e7                	jg     800981 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80099a:	e9 66 01 00 00       	jmp    800b05 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80099f:	83 ec 08             	sub    $0x8,%esp
  8009a2:	ff 75 e8             	pushl  -0x18(%ebp)
  8009a5:	8d 45 14             	lea    0x14(%ebp),%eax
  8009a8:	50                   	push   %eax
  8009a9:	e8 3c fd ff ff       	call   8006ea <getint>
  8009ae:	83 c4 10             	add    $0x10,%esp
  8009b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009b4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8009b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009bd:	85 d2                	test   %edx,%edx
  8009bf:	79 23                	jns    8009e4 <vprintfmt+0x29b>
				putch('-', putdat);
  8009c1:	83 ec 08             	sub    $0x8,%esp
  8009c4:	ff 75 0c             	pushl  0xc(%ebp)
  8009c7:	6a 2d                	push   $0x2d
  8009c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cc:	ff d0                	call   *%eax
  8009ce:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8009d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009d4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009d7:	f7 d8                	neg    %eax
  8009d9:	83 d2 00             	adc    $0x0,%edx
  8009dc:	f7 da                	neg    %edx
  8009de:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009e1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8009e4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8009eb:	e9 bc 00 00 00       	jmp    800aac <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8009f0:	83 ec 08             	sub    $0x8,%esp
  8009f3:	ff 75 e8             	pushl  -0x18(%ebp)
  8009f6:	8d 45 14             	lea    0x14(%ebp),%eax
  8009f9:	50                   	push   %eax
  8009fa:	e8 84 fc ff ff       	call   800683 <getuint>
  8009ff:	83 c4 10             	add    $0x10,%esp
  800a02:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a05:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a08:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a0f:	e9 98 00 00 00       	jmp    800aac <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a14:	83 ec 08             	sub    $0x8,%esp
  800a17:	ff 75 0c             	pushl  0xc(%ebp)
  800a1a:	6a 58                	push   $0x58
  800a1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1f:	ff d0                	call   *%eax
  800a21:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a24:	83 ec 08             	sub    $0x8,%esp
  800a27:	ff 75 0c             	pushl  0xc(%ebp)
  800a2a:	6a 58                	push   $0x58
  800a2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2f:	ff d0                	call   *%eax
  800a31:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a34:	83 ec 08             	sub    $0x8,%esp
  800a37:	ff 75 0c             	pushl  0xc(%ebp)
  800a3a:	6a 58                	push   $0x58
  800a3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3f:	ff d0                	call   *%eax
  800a41:	83 c4 10             	add    $0x10,%esp
			break;
  800a44:	e9 bc 00 00 00       	jmp    800b05 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a49:	83 ec 08             	sub    $0x8,%esp
  800a4c:	ff 75 0c             	pushl  0xc(%ebp)
  800a4f:	6a 30                	push   $0x30
  800a51:	8b 45 08             	mov    0x8(%ebp),%eax
  800a54:	ff d0                	call   *%eax
  800a56:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a59:	83 ec 08             	sub    $0x8,%esp
  800a5c:	ff 75 0c             	pushl  0xc(%ebp)
  800a5f:	6a 78                	push   $0x78
  800a61:	8b 45 08             	mov    0x8(%ebp),%eax
  800a64:	ff d0                	call   *%eax
  800a66:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a69:	8b 45 14             	mov    0x14(%ebp),%eax
  800a6c:	83 c0 04             	add    $0x4,%eax
  800a6f:	89 45 14             	mov    %eax,0x14(%ebp)
  800a72:	8b 45 14             	mov    0x14(%ebp),%eax
  800a75:	83 e8 04             	sub    $0x4,%eax
  800a78:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a7a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a7d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a84:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a8b:	eb 1f                	jmp    800aac <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a8d:	83 ec 08             	sub    $0x8,%esp
  800a90:	ff 75 e8             	pushl  -0x18(%ebp)
  800a93:	8d 45 14             	lea    0x14(%ebp),%eax
  800a96:	50                   	push   %eax
  800a97:	e8 e7 fb ff ff       	call   800683 <getuint>
  800a9c:	83 c4 10             	add    $0x10,%esp
  800a9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aa2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800aa5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800aac:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ab0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ab3:	83 ec 04             	sub    $0x4,%esp
  800ab6:	52                   	push   %edx
  800ab7:	ff 75 e4             	pushl  -0x1c(%ebp)
  800aba:	50                   	push   %eax
  800abb:	ff 75 f4             	pushl  -0xc(%ebp)
  800abe:	ff 75 f0             	pushl  -0x10(%ebp)
  800ac1:	ff 75 0c             	pushl  0xc(%ebp)
  800ac4:	ff 75 08             	pushl  0x8(%ebp)
  800ac7:	e8 00 fb ff ff       	call   8005cc <printnum>
  800acc:	83 c4 20             	add    $0x20,%esp
			break;
  800acf:	eb 34                	jmp    800b05 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ad1:	83 ec 08             	sub    $0x8,%esp
  800ad4:	ff 75 0c             	pushl  0xc(%ebp)
  800ad7:	53                   	push   %ebx
  800ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  800adb:	ff d0                	call   *%eax
  800add:	83 c4 10             	add    $0x10,%esp
			break;
  800ae0:	eb 23                	jmp    800b05 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800ae2:	83 ec 08             	sub    $0x8,%esp
  800ae5:	ff 75 0c             	pushl  0xc(%ebp)
  800ae8:	6a 25                	push   $0x25
  800aea:	8b 45 08             	mov    0x8(%ebp),%eax
  800aed:	ff d0                	call   *%eax
  800aef:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800af2:	ff 4d 10             	decl   0x10(%ebp)
  800af5:	eb 03                	jmp    800afa <vprintfmt+0x3b1>
  800af7:	ff 4d 10             	decl   0x10(%ebp)
  800afa:	8b 45 10             	mov    0x10(%ebp),%eax
  800afd:	48                   	dec    %eax
  800afe:	8a 00                	mov    (%eax),%al
  800b00:	3c 25                	cmp    $0x25,%al
  800b02:	75 f3                	jne    800af7 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b04:	90                   	nop
		}
	}
  800b05:	e9 47 fc ff ff       	jmp    800751 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b0a:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b0b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b0e:	5b                   	pop    %ebx
  800b0f:	5e                   	pop    %esi
  800b10:	5d                   	pop    %ebp
  800b11:	c3                   	ret    

00800b12 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b12:	55                   	push   %ebp
  800b13:	89 e5                	mov    %esp,%ebp
  800b15:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b18:	8d 45 10             	lea    0x10(%ebp),%eax
  800b1b:	83 c0 04             	add    $0x4,%eax
  800b1e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b21:	8b 45 10             	mov    0x10(%ebp),%eax
  800b24:	ff 75 f4             	pushl  -0xc(%ebp)
  800b27:	50                   	push   %eax
  800b28:	ff 75 0c             	pushl  0xc(%ebp)
  800b2b:	ff 75 08             	pushl  0x8(%ebp)
  800b2e:	e8 16 fc ff ff       	call   800749 <vprintfmt>
  800b33:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b36:	90                   	nop
  800b37:	c9                   	leave  
  800b38:	c3                   	ret    

00800b39 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b39:	55                   	push   %ebp
  800b3a:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b3c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3f:	8b 40 08             	mov    0x8(%eax),%eax
  800b42:	8d 50 01             	lea    0x1(%eax),%edx
  800b45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b48:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b4e:	8b 10                	mov    (%eax),%edx
  800b50:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b53:	8b 40 04             	mov    0x4(%eax),%eax
  800b56:	39 c2                	cmp    %eax,%edx
  800b58:	73 12                	jae    800b6c <sprintputch+0x33>
		*b->buf++ = ch;
  800b5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b5d:	8b 00                	mov    (%eax),%eax
  800b5f:	8d 48 01             	lea    0x1(%eax),%ecx
  800b62:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b65:	89 0a                	mov    %ecx,(%edx)
  800b67:	8b 55 08             	mov    0x8(%ebp),%edx
  800b6a:	88 10                	mov    %dl,(%eax)
}
  800b6c:	90                   	nop
  800b6d:	5d                   	pop    %ebp
  800b6e:	c3                   	ret    

00800b6f <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b6f:	55                   	push   %ebp
  800b70:	89 e5                	mov    %esp,%ebp
  800b72:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b75:	8b 45 08             	mov    0x8(%ebp),%eax
  800b78:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b7e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b81:	8b 45 08             	mov    0x8(%ebp),%eax
  800b84:	01 d0                	add    %edx,%eax
  800b86:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b89:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b90:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b94:	74 06                	je     800b9c <vsnprintf+0x2d>
  800b96:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b9a:	7f 07                	jg     800ba3 <vsnprintf+0x34>
		return -E_INVAL;
  800b9c:	b8 03 00 00 00       	mov    $0x3,%eax
  800ba1:	eb 20                	jmp    800bc3 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ba3:	ff 75 14             	pushl  0x14(%ebp)
  800ba6:	ff 75 10             	pushl  0x10(%ebp)
  800ba9:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800bac:	50                   	push   %eax
  800bad:	68 39 0b 80 00       	push   $0x800b39
  800bb2:	e8 92 fb ff ff       	call   800749 <vprintfmt>
  800bb7:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800bba:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800bbd:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800bc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800bc3:	c9                   	leave  
  800bc4:	c3                   	ret    

00800bc5 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800bc5:	55                   	push   %ebp
  800bc6:	89 e5                	mov    %esp,%ebp
  800bc8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800bcb:	8d 45 10             	lea    0x10(%ebp),%eax
  800bce:	83 c0 04             	add    $0x4,%eax
  800bd1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800bd4:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd7:	ff 75 f4             	pushl  -0xc(%ebp)
  800bda:	50                   	push   %eax
  800bdb:	ff 75 0c             	pushl  0xc(%ebp)
  800bde:	ff 75 08             	pushl  0x8(%ebp)
  800be1:	e8 89 ff ff ff       	call   800b6f <vsnprintf>
  800be6:	83 c4 10             	add    $0x10,%esp
  800be9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800bec:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bef:	c9                   	leave  
  800bf0:	c3                   	ret    

00800bf1 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800bf1:	55                   	push   %ebp
  800bf2:	89 e5                	mov    %esp,%ebp
  800bf4:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800bf7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bfe:	eb 06                	jmp    800c06 <strlen+0x15>
		n++;
  800c00:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c03:	ff 45 08             	incl   0x8(%ebp)
  800c06:	8b 45 08             	mov    0x8(%ebp),%eax
  800c09:	8a 00                	mov    (%eax),%al
  800c0b:	84 c0                	test   %al,%al
  800c0d:	75 f1                	jne    800c00 <strlen+0xf>
		n++;
	return n;
  800c0f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c12:	c9                   	leave  
  800c13:	c3                   	ret    

00800c14 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c14:	55                   	push   %ebp
  800c15:	89 e5                	mov    %esp,%ebp
  800c17:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c1a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c21:	eb 09                	jmp    800c2c <strnlen+0x18>
		n++;
  800c23:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800c26:	ff 45 08             	incl   0x8(%ebp)
  800c29:	ff 4d 0c             	decl   0xc(%ebp)
  800c2c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c30:	74 09                	je     800c3b <strnlen+0x27>
  800c32:	8b 45 08             	mov    0x8(%ebp),%eax
  800c35:	8a 00                	mov    (%eax),%al
  800c37:	84 c0                	test   %al,%al
  800c39:	75 e8                	jne    800c23 <strnlen+0xf>
		n++;
	return n;
  800c3b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c3e:	c9                   	leave  
  800c3f:	c3                   	ret    

00800c40 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800c40:	55                   	push   %ebp
  800c41:	89 e5                	mov    %esp,%ebp
  800c43:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800c46:	8b 45 08             	mov    0x8(%ebp),%eax
  800c49:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800c4c:	90                   	nop
  800c4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c50:	8d 50 01             	lea    0x1(%eax),%edx
  800c53:	89 55 08             	mov    %edx,0x8(%ebp)
  800c56:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c59:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c5c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c5f:	8a 12                	mov    (%edx),%dl
  800c61:	88 10                	mov    %dl,(%eax)
  800c63:	8a 00                	mov    (%eax),%al
  800c65:	84 c0                	test   %al,%al
  800c67:	75 e4                	jne    800c4d <strcpy+0xd>
		/* do nothing */;
	return ret;
  800c69:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c6c:	c9                   	leave  
  800c6d:	c3                   	ret    

00800c6e <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800c6e:	55                   	push   %ebp
  800c6f:	89 e5                	mov    %esp,%ebp
  800c71:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c74:	8b 45 08             	mov    0x8(%ebp),%eax
  800c77:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c7a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c81:	eb 1f                	jmp    800ca2 <strncpy+0x34>
		*dst++ = *src;
  800c83:	8b 45 08             	mov    0x8(%ebp),%eax
  800c86:	8d 50 01             	lea    0x1(%eax),%edx
  800c89:	89 55 08             	mov    %edx,0x8(%ebp)
  800c8c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c8f:	8a 12                	mov    (%edx),%dl
  800c91:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c96:	8a 00                	mov    (%eax),%al
  800c98:	84 c0                	test   %al,%al
  800c9a:	74 03                	je     800c9f <strncpy+0x31>
			src++;
  800c9c:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c9f:	ff 45 fc             	incl   -0x4(%ebp)
  800ca2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ca5:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ca8:	72 d9                	jb     800c83 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800caa:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800cad:	c9                   	leave  
  800cae:	c3                   	ret    

00800caf <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800caf:	55                   	push   %ebp
  800cb0:	89 e5                	mov    %esp,%ebp
  800cb2:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800cb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800cbb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cbf:	74 30                	je     800cf1 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800cc1:	eb 16                	jmp    800cd9 <strlcpy+0x2a>
			*dst++ = *src++;
  800cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc6:	8d 50 01             	lea    0x1(%eax),%edx
  800cc9:	89 55 08             	mov    %edx,0x8(%ebp)
  800ccc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ccf:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cd2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800cd5:	8a 12                	mov    (%edx),%dl
  800cd7:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800cd9:	ff 4d 10             	decl   0x10(%ebp)
  800cdc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ce0:	74 09                	je     800ceb <strlcpy+0x3c>
  800ce2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce5:	8a 00                	mov    (%eax),%al
  800ce7:	84 c0                	test   %al,%al
  800ce9:	75 d8                	jne    800cc3 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ceb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cee:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800cf1:	8b 55 08             	mov    0x8(%ebp),%edx
  800cf4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800cf7:	29 c2                	sub    %eax,%edx
  800cf9:	89 d0                	mov    %edx,%eax
}
  800cfb:	c9                   	leave  
  800cfc:	c3                   	ret    

00800cfd <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800cfd:	55                   	push   %ebp
  800cfe:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d00:	eb 06                	jmp    800d08 <strcmp+0xb>
		p++, q++;
  800d02:	ff 45 08             	incl   0x8(%ebp)
  800d05:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d08:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0b:	8a 00                	mov    (%eax),%al
  800d0d:	84 c0                	test   %al,%al
  800d0f:	74 0e                	je     800d1f <strcmp+0x22>
  800d11:	8b 45 08             	mov    0x8(%ebp),%eax
  800d14:	8a 10                	mov    (%eax),%dl
  800d16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d19:	8a 00                	mov    (%eax),%al
  800d1b:	38 c2                	cmp    %al,%dl
  800d1d:	74 e3                	je     800d02 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800d1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d22:	8a 00                	mov    (%eax),%al
  800d24:	0f b6 d0             	movzbl %al,%edx
  800d27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d2a:	8a 00                	mov    (%eax),%al
  800d2c:	0f b6 c0             	movzbl %al,%eax
  800d2f:	29 c2                	sub    %eax,%edx
  800d31:	89 d0                	mov    %edx,%eax
}
  800d33:	5d                   	pop    %ebp
  800d34:	c3                   	ret    

00800d35 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800d35:	55                   	push   %ebp
  800d36:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800d38:	eb 09                	jmp    800d43 <strncmp+0xe>
		n--, p++, q++;
  800d3a:	ff 4d 10             	decl   0x10(%ebp)
  800d3d:	ff 45 08             	incl   0x8(%ebp)
  800d40:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800d43:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d47:	74 17                	je     800d60 <strncmp+0x2b>
  800d49:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4c:	8a 00                	mov    (%eax),%al
  800d4e:	84 c0                	test   %al,%al
  800d50:	74 0e                	je     800d60 <strncmp+0x2b>
  800d52:	8b 45 08             	mov    0x8(%ebp),%eax
  800d55:	8a 10                	mov    (%eax),%dl
  800d57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d5a:	8a 00                	mov    (%eax),%al
  800d5c:	38 c2                	cmp    %al,%dl
  800d5e:	74 da                	je     800d3a <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800d60:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d64:	75 07                	jne    800d6d <strncmp+0x38>
		return 0;
  800d66:	b8 00 00 00 00       	mov    $0x0,%eax
  800d6b:	eb 14                	jmp    800d81 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800d6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d70:	8a 00                	mov    (%eax),%al
  800d72:	0f b6 d0             	movzbl %al,%edx
  800d75:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d78:	8a 00                	mov    (%eax),%al
  800d7a:	0f b6 c0             	movzbl %al,%eax
  800d7d:	29 c2                	sub    %eax,%edx
  800d7f:	89 d0                	mov    %edx,%eax
}
  800d81:	5d                   	pop    %ebp
  800d82:	c3                   	ret    

00800d83 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d83:	55                   	push   %ebp
  800d84:	89 e5                	mov    %esp,%ebp
  800d86:	83 ec 04             	sub    $0x4,%esp
  800d89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d8c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d8f:	eb 12                	jmp    800da3 <strchr+0x20>
		if (*s == c)
  800d91:	8b 45 08             	mov    0x8(%ebp),%eax
  800d94:	8a 00                	mov    (%eax),%al
  800d96:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d99:	75 05                	jne    800da0 <strchr+0x1d>
			return (char *) s;
  800d9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9e:	eb 11                	jmp    800db1 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800da0:	ff 45 08             	incl   0x8(%ebp)
  800da3:	8b 45 08             	mov    0x8(%ebp),%eax
  800da6:	8a 00                	mov    (%eax),%al
  800da8:	84 c0                	test   %al,%al
  800daa:	75 e5                	jne    800d91 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800dac:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800db1:	c9                   	leave  
  800db2:	c3                   	ret    

00800db3 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800db3:	55                   	push   %ebp
  800db4:	89 e5                	mov    %esp,%ebp
  800db6:	83 ec 04             	sub    $0x4,%esp
  800db9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbc:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800dbf:	eb 0d                	jmp    800dce <strfind+0x1b>
		if (*s == c)
  800dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc4:	8a 00                	mov    (%eax),%al
  800dc6:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800dc9:	74 0e                	je     800dd9 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800dcb:	ff 45 08             	incl   0x8(%ebp)
  800dce:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd1:	8a 00                	mov    (%eax),%al
  800dd3:	84 c0                	test   %al,%al
  800dd5:	75 ea                	jne    800dc1 <strfind+0xe>
  800dd7:	eb 01                	jmp    800dda <strfind+0x27>
		if (*s == c)
			break;
  800dd9:	90                   	nop
	return (char *) s;
  800dda:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ddd:	c9                   	leave  
  800dde:	c3                   	ret    

00800ddf <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ddf:	55                   	push   %ebp
  800de0:	89 e5                	mov    %esp,%ebp
  800de2:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800de5:	8b 45 08             	mov    0x8(%ebp),%eax
  800de8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800deb:	8b 45 10             	mov    0x10(%ebp),%eax
  800dee:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800df1:	eb 0e                	jmp    800e01 <memset+0x22>
		*p++ = c;
  800df3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800df6:	8d 50 01             	lea    0x1(%eax),%edx
  800df9:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800dfc:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dff:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e01:	ff 4d f8             	decl   -0x8(%ebp)
  800e04:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e08:	79 e9                	jns    800df3 <memset+0x14>
		*p++ = c;

	return v;
  800e0a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e0d:	c9                   	leave  
  800e0e:	c3                   	ret    

00800e0f <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e0f:	55                   	push   %ebp
  800e10:	89 e5                	mov    %esp,%ebp
  800e12:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e18:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800e21:	eb 16                	jmp    800e39 <memcpy+0x2a>
		*d++ = *s++;
  800e23:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e26:	8d 50 01             	lea    0x1(%eax),%edx
  800e29:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e2c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e2f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e32:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e35:	8a 12                	mov    (%edx),%dl
  800e37:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800e39:	8b 45 10             	mov    0x10(%ebp),%eax
  800e3c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e3f:	89 55 10             	mov    %edx,0x10(%ebp)
  800e42:	85 c0                	test   %eax,%eax
  800e44:	75 dd                	jne    800e23 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800e46:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e49:	c9                   	leave  
  800e4a:	c3                   	ret    

00800e4b <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800e4b:	55                   	push   %ebp
  800e4c:	89 e5                	mov    %esp,%ebp
  800e4e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e54:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800e57:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800e5d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e60:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e63:	73 50                	jae    800eb5 <memmove+0x6a>
  800e65:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e68:	8b 45 10             	mov    0x10(%ebp),%eax
  800e6b:	01 d0                	add    %edx,%eax
  800e6d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e70:	76 43                	jbe    800eb5 <memmove+0x6a>
		s += n;
  800e72:	8b 45 10             	mov    0x10(%ebp),%eax
  800e75:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e78:	8b 45 10             	mov    0x10(%ebp),%eax
  800e7b:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e7e:	eb 10                	jmp    800e90 <memmove+0x45>
			*--d = *--s;
  800e80:	ff 4d f8             	decl   -0x8(%ebp)
  800e83:	ff 4d fc             	decl   -0x4(%ebp)
  800e86:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e89:	8a 10                	mov    (%eax),%dl
  800e8b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e8e:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e90:	8b 45 10             	mov    0x10(%ebp),%eax
  800e93:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e96:	89 55 10             	mov    %edx,0x10(%ebp)
  800e99:	85 c0                	test   %eax,%eax
  800e9b:	75 e3                	jne    800e80 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e9d:	eb 23                	jmp    800ec2 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e9f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ea2:	8d 50 01             	lea    0x1(%eax),%edx
  800ea5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800ea8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eab:	8d 4a 01             	lea    0x1(%edx),%ecx
  800eae:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800eb1:	8a 12                	mov    (%edx),%dl
  800eb3:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800eb5:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ebb:	89 55 10             	mov    %edx,0x10(%ebp)
  800ebe:	85 c0                	test   %eax,%eax
  800ec0:	75 dd                	jne    800e9f <memmove+0x54>
			*d++ = *s++;

	return dst;
  800ec2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ec5:	c9                   	leave  
  800ec6:	c3                   	ret    

00800ec7 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800ec7:	55                   	push   %ebp
  800ec8:	89 e5                	mov    %esp,%ebp
  800eca:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800ecd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800ed3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed6:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800ed9:	eb 2a                	jmp    800f05 <memcmp+0x3e>
		if (*s1 != *s2)
  800edb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ede:	8a 10                	mov    (%eax),%dl
  800ee0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ee3:	8a 00                	mov    (%eax),%al
  800ee5:	38 c2                	cmp    %al,%dl
  800ee7:	74 16                	je     800eff <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ee9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eec:	8a 00                	mov    (%eax),%al
  800eee:	0f b6 d0             	movzbl %al,%edx
  800ef1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ef4:	8a 00                	mov    (%eax),%al
  800ef6:	0f b6 c0             	movzbl %al,%eax
  800ef9:	29 c2                	sub    %eax,%edx
  800efb:	89 d0                	mov    %edx,%eax
  800efd:	eb 18                	jmp    800f17 <memcmp+0x50>
		s1++, s2++;
  800eff:	ff 45 fc             	incl   -0x4(%ebp)
  800f02:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f05:	8b 45 10             	mov    0x10(%ebp),%eax
  800f08:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f0b:	89 55 10             	mov    %edx,0x10(%ebp)
  800f0e:	85 c0                	test   %eax,%eax
  800f10:	75 c9                	jne    800edb <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f12:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f17:	c9                   	leave  
  800f18:	c3                   	ret    

00800f19 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800f19:	55                   	push   %ebp
  800f1a:	89 e5                	mov    %esp,%ebp
  800f1c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800f1f:	8b 55 08             	mov    0x8(%ebp),%edx
  800f22:	8b 45 10             	mov    0x10(%ebp),%eax
  800f25:	01 d0                	add    %edx,%eax
  800f27:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800f2a:	eb 15                	jmp    800f41 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800f2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2f:	8a 00                	mov    (%eax),%al
  800f31:	0f b6 d0             	movzbl %al,%edx
  800f34:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f37:	0f b6 c0             	movzbl %al,%eax
  800f3a:	39 c2                	cmp    %eax,%edx
  800f3c:	74 0d                	je     800f4b <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800f3e:	ff 45 08             	incl   0x8(%ebp)
  800f41:	8b 45 08             	mov    0x8(%ebp),%eax
  800f44:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800f47:	72 e3                	jb     800f2c <memfind+0x13>
  800f49:	eb 01                	jmp    800f4c <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800f4b:	90                   	nop
	return (void *) s;
  800f4c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f4f:	c9                   	leave  
  800f50:	c3                   	ret    

00800f51 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800f51:	55                   	push   %ebp
  800f52:	89 e5                	mov    %esp,%ebp
  800f54:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800f57:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800f5e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f65:	eb 03                	jmp    800f6a <strtol+0x19>
		s++;
  800f67:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800f6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6d:	8a 00                	mov    (%eax),%al
  800f6f:	3c 20                	cmp    $0x20,%al
  800f71:	74 f4                	je     800f67 <strtol+0x16>
  800f73:	8b 45 08             	mov    0x8(%ebp),%eax
  800f76:	8a 00                	mov    (%eax),%al
  800f78:	3c 09                	cmp    $0x9,%al
  800f7a:	74 eb                	je     800f67 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7f:	8a 00                	mov    (%eax),%al
  800f81:	3c 2b                	cmp    $0x2b,%al
  800f83:	75 05                	jne    800f8a <strtol+0x39>
		s++;
  800f85:	ff 45 08             	incl   0x8(%ebp)
  800f88:	eb 13                	jmp    800f9d <strtol+0x4c>
	else if (*s == '-')
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	8a 00                	mov    (%eax),%al
  800f8f:	3c 2d                	cmp    $0x2d,%al
  800f91:	75 0a                	jne    800f9d <strtol+0x4c>
		s++, neg = 1;
  800f93:	ff 45 08             	incl   0x8(%ebp)
  800f96:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f9d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fa1:	74 06                	je     800fa9 <strtol+0x58>
  800fa3:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800fa7:	75 20                	jne    800fc9 <strtol+0x78>
  800fa9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fac:	8a 00                	mov    (%eax),%al
  800fae:	3c 30                	cmp    $0x30,%al
  800fb0:	75 17                	jne    800fc9 <strtol+0x78>
  800fb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb5:	40                   	inc    %eax
  800fb6:	8a 00                	mov    (%eax),%al
  800fb8:	3c 78                	cmp    $0x78,%al
  800fba:	75 0d                	jne    800fc9 <strtol+0x78>
		s += 2, base = 16;
  800fbc:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800fc0:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800fc7:	eb 28                	jmp    800ff1 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800fc9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fcd:	75 15                	jne    800fe4 <strtol+0x93>
  800fcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd2:	8a 00                	mov    (%eax),%al
  800fd4:	3c 30                	cmp    $0x30,%al
  800fd6:	75 0c                	jne    800fe4 <strtol+0x93>
		s++, base = 8;
  800fd8:	ff 45 08             	incl   0x8(%ebp)
  800fdb:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800fe2:	eb 0d                	jmp    800ff1 <strtol+0xa0>
	else if (base == 0)
  800fe4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800fe8:	75 07                	jne    800ff1 <strtol+0xa0>
		base = 10;
  800fea:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800ff1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff4:	8a 00                	mov    (%eax),%al
  800ff6:	3c 2f                	cmp    $0x2f,%al
  800ff8:	7e 19                	jle    801013 <strtol+0xc2>
  800ffa:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffd:	8a 00                	mov    (%eax),%al
  800fff:	3c 39                	cmp    $0x39,%al
  801001:	7f 10                	jg     801013 <strtol+0xc2>
			dig = *s - '0';
  801003:	8b 45 08             	mov    0x8(%ebp),%eax
  801006:	8a 00                	mov    (%eax),%al
  801008:	0f be c0             	movsbl %al,%eax
  80100b:	83 e8 30             	sub    $0x30,%eax
  80100e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801011:	eb 42                	jmp    801055 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801013:	8b 45 08             	mov    0x8(%ebp),%eax
  801016:	8a 00                	mov    (%eax),%al
  801018:	3c 60                	cmp    $0x60,%al
  80101a:	7e 19                	jle    801035 <strtol+0xe4>
  80101c:	8b 45 08             	mov    0x8(%ebp),%eax
  80101f:	8a 00                	mov    (%eax),%al
  801021:	3c 7a                	cmp    $0x7a,%al
  801023:	7f 10                	jg     801035 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801025:	8b 45 08             	mov    0x8(%ebp),%eax
  801028:	8a 00                	mov    (%eax),%al
  80102a:	0f be c0             	movsbl %al,%eax
  80102d:	83 e8 57             	sub    $0x57,%eax
  801030:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801033:	eb 20                	jmp    801055 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801035:	8b 45 08             	mov    0x8(%ebp),%eax
  801038:	8a 00                	mov    (%eax),%al
  80103a:	3c 40                	cmp    $0x40,%al
  80103c:	7e 39                	jle    801077 <strtol+0x126>
  80103e:	8b 45 08             	mov    0x8(%ebp),%eax
  801041:	8a 00                	mov    (%eax),%al
  801043:	3c 5a                	cmp    $0x5a,%al
  801045:	7f 30                	jg     801077 <strtol+0x126>
			dig = *s - 'A' + 10;
  801047:	8b 45 08             	mov    0x8(%ebp),%eax
  80104a:	8a 00                	mov    (%eax),%al
  80104c:	0f be c0             	movsbl %al,%eax
  80104f:	83 e8 37             	sub    $0x37,%eax
  801052:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801055:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801058:	3b 45 10             	cmp    0x10(%ebp),%eax
  80105b:	7d 19                	jge    801076 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80105d:	ff 45 08             	incl   0x8(%ebp)
  801060:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801063:	0f af 45 10          	imul   0x10(%ebp),%eax
  801067:	89 c2                	mov    %eax,%edx
  801069:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80106c:	01 d0                	add    %edx,%eax
  80106e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801071:	e9 7b ff ff ff       	jmp    800ff1 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801076:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801077:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80107b:	74 08                	je     801085 <strtol+0x134>
		*endptr = (char *) s;
  80107d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801080:	8b 55 08             	mov    0x8(%ebp),%edx
  801083:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801085:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801089:	74 07                	je     801092 <strtol+0x141>
  80108b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80108e:	f7 d8                	neg    %eax
  801090:	eb 03                	jmp    801095 <strtol+0x144>
  801092:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801095:	c9                   	leave  
  801096:	c3                   	ret    

00801097 <ltostr>:

void
ltostr(long value, char *str)
{
  801097:	55                   	push   %ebp
  801098:	89 e5                	mov    %esp,%ebp
  80109a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80109d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8010a4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8010ab:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010af:	79 13                	jns    8010c4 <ltostr+0x2d>
	{
		neg = 1;
  8010b1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8010b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010bb:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8010be:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8010c1:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8010c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8010cc:	99                   	cltd   
  8010cd:	f7 f9                	idiv   %ecx
  8010cf:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8010d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010d5:	8d 50 01             	lea    0x1(%eax),%edx
  8010d8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010db:	89 c2                	mov    %eax,%edx
  8010dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e0:	01 d0                	add    %edx,%eax
  8010e2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010e5:	83 c2 30             	add    $0x30,%edx
  8010e8:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8010ea:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8010ed:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8010f2:	f7 e9                	imul   %ecx
  8010f4:	c1 fa 02             	sar    $0x2,%edx
  8010f7:	89 c8                	mov    %ecx,%eax
  8010f9:	c1 f8 1f             	sar    $0x1f,%eax
  8010fc:	29 c2                	sub    %eax,%edx
  8010fe:	89 d0                	mov    %edx,%eax
  801100:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801103:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801106:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80110b:	f7 e9                	imul   %ecx
  80110d:	c1 fa 02             	sar    $0x2,%edx
  801110:	89 c8                	mov    %ecx,%eax
  801112:	c1 f8 1f             	sar    $0x1f,%eax
  801115:	29 c2                	sub    %eax,%edx
  801117:	89 d0                	mov    %edx,%eax
  801119:	c1 e0 02             	shl    $0x2,%eax
  80111c:	01 d0                	add    %edx,%eax
  80111e:	01 c0                	add    %eax,%eax
  801120:	29 c1                	sub    %eax,%ecx
  801122:	89 ca                	mov    %ecx,%edx
  801124:	85 d2                	test   %edx,%edx
  801126:	75 9c                	jne    8010c4 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801128:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80112f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801132:	48                   	dec    %eax
  801133:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801136:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80113a:	74 3d                	je     801179 <ltostr+0xe2>
		start = 1 ;
  80113c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801143:	eb 34                	jmp    801179 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801145:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801148:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114b:	01 d0                	add    %edx,%eax
  80114d:	8a 00                	mov    (%eax),%al
  80114f:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801152:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801155:	8b 45 0c             	mov    0xc(%ebp),%eax
  801158:	01 c2                	add    %eax,%edx
  80115a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80115d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801160:	01 c8                	add    %ecx,%eax
  801162:	8a 00                	mov    (%eax),%al
  801164:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801166:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801169:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116c:	01 c2                	add    %eax,%edx
  80116e:	8a 45 eb             	mov    -0x15(%ebp),%al
  801171:	88 02                	mov    %al,(%edx)
		start++ ;
  801173:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801176:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801179:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80117c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80117f:	7c c4                	jl     801145 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801181:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801184:	8b 45 0c             	mov    0xc(%ebp),%eax
  801187:	01 d0                	add    %edx,%eax
  801189:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80118c:	90                   	nop
  80118d:	c9                   	leave  
  80118e:	c3                   	ret    

0080118f <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80118f:	55                   	push   %ebp
  801190:	89 e5                	mov    %esp,%ebp
  801192:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801195:	ff 75 08             	pushl  0x8(%ebp)
  801198:	e8 54 fa ff ff       	call   800bf1 <strlen>
  80119d:	83 c4 04             	add    $0x4,%esp
  8011a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8011a3:	ff 75 0c             	pushl  0xc(%ebp)
  8011a6:	e8 46 fa ff ff       	call   800bf1 <strlen>
  8011ab:	83 c4 04             	add    $0x4,%esp
  8011ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8011b1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8011b8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8011bf:	eb 17                	jmp    8011d8 <strcconcat+0x49>
		final[s] = str1[s] ;
  8011c1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011c4:	8b 45 10             	mov    0x10(%ebp),%eax
  8011c7:	01 c2                	add    %eax,%edx
  8011c9:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8011cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cf:	01 c8                	add    %ecx,%eax
  8011d1:	8a 00                	mov    (%eax),%al
  8011d3:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8011d5:	ff 45 fc             	incl   -0x4(%ebp)
  8011d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011db:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8011de:	7c e1                	jl     8011c1 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8011e0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8011e7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8011ee:	eb 1f                	jmp    80120f <strcconcat+0x80>
		final[s++] = str2[i] ;
  8011f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8011f3:	8d 50 01             	lea    0x1(%eax),%edx
  8011f6:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8011f9:	89 c2                	mov    %eax,%edx
  8011fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fe:	01 c2                	add    %eax,%edx
  801200:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801203:	8b 45 0c             	mov    0xc(%ebp),%eax
  801206:	01 c8                	add    %ecx,%eax
  801208:	8a 00                	mov    (%eax),%al
  80120a:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80120c:	ff 45 f8             	incl   -0x8(%ebp)
  80120f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801212:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801215:	7c d9                	jl     8011f0 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801217:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80121a:	8b 45 10             	mov    0x10(%ebp),%eax
  80121d:	01 d0                	add    %edx,%eax
  80121f:	c6 00 00             	movb   $0x0,(%eax)
}
  801222:	90                   	nop
  801223:	c9                   	leave  
  801224:	c3                   	ret    

00801225 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801225:	55                   	push   %ebp
  801226:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801228:	8b 45 14             	mov    0x14(%ebp),%eax
  80122b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801231:	8b 45 14             	mov    0x14(%ebp),%eax
  801234:	8b 00                	mov    (%eax),%eax
  801236:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80123d:	8b 45 10             	mov    0x10(%ebp),%eax
  801240:	01 d0                	add    %edx,%eax
  801242:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801248:	eb 0c                	jmp    801256 <strsplit+0x31>
			*string++ = 0;
  80124a:	8b 45 08             	mov    0x8(%ebp),%eax
  80124d:	8d 50 01             	lea    0x1(%eax),%edx
  801250:	89 55 08             	mov    %edx,0x8(%ebp)
  801253:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801256:	8b 45 08             	mov    0x8(%ebp),%eax
  801259:	8a 00                	mov    (%eax),%al
  80125b:	84 c0                	test   %al,%al
  80125d:	74 18                	je     801277 <strsplit+0x52>
  80125f:	8b 45 08             	mov    0x8(%ebp),%eax
  801262:	8a 00                	mov    (%eax),%al
  801264:	0f be c0             	movsbl %al,%eax
  801267:	50                   	push   %eax
  801268:	ff 75 0c             	pushl  0xc(%ebp)
  80126b:	e8 13 fb ff ff       	call   800d83 <strchr>
  801270:	83 c4 08             	add    $0x8,%esp
  801273:	85 c0                	test   %eax,%eax
  801275:	75 d3                	jne    80124a <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801277:	8b 45 08             	mov    0x8(%ebp),%eax
  80127a:	8a 00                	mov    (%eax),%al
  80127c:	84 c0                	test   %al,%al
  80127e:	74 5a                	je     8012da <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801280:	8b 45 14             	mov    0x14(%ebp),%eax
  801283:	8b 00                	mov    (%eax),%eax
  801285:	83 f8 0f             	cmp    $0xf,%eax
  801288:	75 07                	jne    801291 <strsplit+0x6c>
		{
			return 0;
  80128a:	b8 00 00 00 00       	mov    $0x0,%eax
  80128f:	eb 66                	jmp    8012f7 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801291:	8b 45 14             	mov    0x14(%ebp),%eax
  801294:	8b 00                	mov    (%eax),%eax
  801296:	8d 48 01             	lea    0x1(%eax),%ecx
  801299:	8b 55 14             	mov    0x14(%ebp),%edx
  80129c:	89 0a                	mov    %ecx,(%edx)
  80129e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a8:	01 c2                	add    %eax,%edx
  8012aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ad:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012af:	eb 03                	jmp    8012b4 <strsplit+0x8f>
			string++;
  8012b1:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8012b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b7:	8a 00                	mov    (%eax),%al
  8012b9:	84 c0                	test   %al,%al
  8012bb:	74 8b                	je     801248 <strsplit+0x23>
  8012bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c0:	8a 00                	mov    (%eax),%al
  8012c2:	0f be c0             	movsbl %al,%eax
  8012c5:	50                   	push   %eax
  8012c6:	ff 75 0c             	pushl  0xc(%ebp)
  8012c9:	e8 b5 fa ff ff       	call   800d83 <strchr>
  8012ce:	83 c4 08             	add    $0x8,%esp
  8012d1:	85 c0                	test   %eax,%eax
  8012d3:	74 dc                	je     8012b1 <strsplit+0x8c>
			string++;
	}
  8012d5:	e9 6e ff ff ff       	jmp    801248 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8012da:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8012db:	8b 45 14             	mov    0x14(%ebp),%eax
  8012de:	8b 00                	mov    (%eax),%eax
  8012e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ea:	01 d0                	add    %edx,%eax
  8012ec:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8012f2:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8012f7:	c9                   	leave  
  8012f8:	c3                   	ret    

008012f9 <malloc>:
int sizeofarray=0;
uint32 addresses[1000];
int changed[1000];
int numOfPages[1000];
void* malloc(uint32 size)
{
  8012f9:	55                   	push   %ebp
  8012fa:	89 e5                	mov    %esp,%ebp
  8012fc:	83 ec 38             	sub    $0x38,%esp
	//TODO: [PROJECT 2021 - [2] User Heap] malloc() [User Side]
		// Write your code here, remove the panic and write your code
		int num = size /PAGE_SIZE;
  8012ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801302:	c1 e8 0c             	shr    $0xc,%eax
  801305:	89 45 f4             	mov    %eax,-0xc(%ebp)
		uint32 return_addres;

		if(size%PAGE_SIZE!=0)
  801308:	8b 45 08             	mov    0x8(%ebp),%eax
  80130b:	25 ff 0f 00 00       	and    $0xfff,%eax
  801310:	85 c0                	test   %eax,%eax
  801312:	74 03                	je     801317 <malloc+0x1e>
			num++;
  801314:	ff 45 f4             	incl   -0xc(%ebp)
		if(last_addres==USER_HEAP_START)
  801317:	a1 04 30 80 00       	mov    0x803004,%eax
  80131c:	3d 00 00 00 80       	cmp    $0x80000000,%eax
  801321:	75 73                	jne    801396 <malloc+0x9d>
		{
			sys_allocateMem(USER_HEAP_START,size);
  801323:	83 ec 08             	sub    $0x8,%esp
  801326:	ff 75 08             	pushl  0x8(%ebp)
  801329:	68 00 00 00 80       	push   $0x80000000
  80132e:	e8 80 04 00 00       	call   8017b3 <sys_allocateMem>
  801333:	83 c4 10             	add    $0x10,%esp
			return_addres=last_addres;
  801336:	a1 04 30 80 00       	mov    0x803004,%eax
  80133b:	89 45 d8             	mov    %eax,-0x28(%ebp)
			last_addres+=num*PAGE_SIZE;
  80133e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801341:	c1 e0 0c             	shl    $0xc,%eax
  801344:	89 c2                	mov    %eax,%edx
  801346:	a1 04 30 80 00       	mov    0x803004,%eax
  80134b:	01 d0                	add    %edx,%eax
  80134d:	a3 04 30 80 00       	mov    %eax,0x803004
			numOfPages[sizeofarray]=num;
  801352:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801357:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80135a:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
			addresses[sizeofarray]=last_addres;
  801361:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801366:	8b 15 04 30 80 00    	mov    0x803004,%edx
  80136c:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
			changed[sizeofarray]=1;
  801373:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801378:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  80137f:	01 00 00 00 
			sizeofarray++;
  801383:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801388:	40                   	inc    %eax
  801389:	a3 2c 30 80 00       	mov    %eax,0x80302c
			return (void*)return_addres;
  80138e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  801391:	e9 71 01 00 00       	jmp    801507 <malloc+0x20e>
		}
		else
		{
			if(changes==0)
  801396:	a1 28 30 80 00       	mov    0x803028,%eax
  80139b:	85 c0                	test   %eax,%eax
  80139d:	75 71                	jne    801410 <malloc+0x117>
			{
				sys_allocateMem(last_addres,size);
  80139f:	a1 04 30 80 00       	mov    0x803004,%eax
  8013a4:	83 ec 08             	sub    $0x8,%esp
  8013a7:	ff 75 08             	pushl  0x8(%ebp)
  8013aa:	50                   	push   %eax
  8013ab:	e8 03 04 00 00       	call   8017b3 <sys_allocateMem>
  8013b0:	83 c4 10             	add    $0x10,%esp
				return_addres=last_addres;
  8013b3:	a1 04 30 80 00       	mov    0x803004,%eax
  8013b8:	89 45 d8             	mov    %eax,-0x28(%ebp)
				last_addres+=num*PAGE_SIZE;
  8013bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013be:	c1 e0 0c             	shl    $0xc,%eax
  8013c1:	89 c2                	mov    %eax,%edx
  8013c3:	a1 04 30 80 00       	mov    0x803004,%eax
  8013c8:	01 d0                	add    %edx,%eax
  8013ca:	a3 04 30 80 00       	mov    %eax,0x803004
				numOfPages[sizeofarray]=num;
  8013cf:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013d4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013d7:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=return_addres;
  8013de:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013e3:	8b 55 d8             	mov    -0x28(%ebp),%edx
  8013e6:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  8013ed:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8013f2:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  8013f9:	01 00 00 00 
				sizeofarray++;
  8013fd:	a1 2c 30 80 00       	mov    0x80302c,%eax
  801402:	40                   	inc    %eax
  801403:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return (void*)return_addres;
  801408:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80140b:	e9 f7 00 00 00       	jmp    801507 <malloc+0x20e>
			}
			else{
				int count=0;
  801410:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
				int min=1000;
  801417:	c7 45 ec e8 03 00 00 	movl   $0x3e8,-0x14(%ebp)
				int index=-1;
  80141e:	c7 45 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%ebp)
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  801425:	c7 45 e0 00 00 00 80 	movl   $0x80000000,-0x20(%ebp)
  80142c:	eb 7c                	jmp    8014aa <malloc+0x1b1>
				{
					uint32 *pg=NULL;
  80142e:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
					for(int j=0;j<sizeofarray;j++)
  801435:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  80143c:	eb 1a                	jmp    801458 <malloc+0x15f>
					{
						if(addresses[j]==i)
  80143e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801441:	8b 04 85 20 31 80 00 	mov    0x803120(,%eax,4),%eax
  801448:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80144b:	75 08                	jne    801455 <malloc+0x15c>
						{
							index=j;
  80144d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801450:	89 45 e8             	mov    %eax,-0x18(%ebp)
							break;
  801453:	eb 0d                	jmp    801462 <malloc+0x169>
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
				{
					uint32 *pg=NULL;
					for(int j=0;j<sizeofarray;j++)
  801455:	ff 45 dc             	incl   -0x24(%ebp)
  801458:	a1 2c 30 80 00       	mov    0x80302c,%eax
  80145d:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  801460:	7c dc                	jl     80143e <malloc+0x145>
							index=j;
							break;
						}
					}

					if(index==-1)
  801462:	83 7d e8 ff          	cmpl   $0xffffffff,-0x18(%ebp)
  801466:	75 05                	jne    80146d <malloc+0x174>
					{
						count++;
  801468:	ff 45 f0             	incl   -0x10(%ebp)
  80146b:	eb 36                	jmp    8014a3 <malloc+0x1aa>
					}
					else
					{
						if(changed[index]==0)
  80146d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801470:	8b 04 85 c0 40 80 00 	mov    0x8040c0(,%eax,4),%eax
  801477:	85 c0                	test   %eax,%eax
  801479:	75 05                	jne    801480 <malloc+0x187>
						{
							count++;
  80147b:	ff 45 f0             	incl   -0x10(%ebp)
  80147e:	eb 23                	jmp    8014a3 <malloc+0x1aa>
						}
						else
						{
							if(count<min&&count>=num)
  801480:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801483:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  801486:	7d 14                	jge    80149c <malloc+0x1a3>
  801488:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80148b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80148e:	7c 0c                	jl     80149c <malloc+0x1a3>
							{
								min=count;
  801490:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801493:	89 45 ec             	mov    %eax,-0x14(%ebp)
								min_addresss=i;
  801496:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801499:	89 45 e4             	mov    %eax,-0x1c(%ebp)
							}
							count=0;
  80149c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
			else{
				int count=0;
				int min=1000;
				int index=-1;
				uint32 min_addresss;
				for(uint32 i=USER_HEAP_START;i<USER_HEAP_MAX;i+=PAGE_SIZE)
  8014a3:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
  8014aa:	81 7d e0 ff ff ff 9f 	cmpl   $0x9fffffff,-0x20(%ebp)
  8014b1:	0f 86 77 ff ff ff    	jbe    80142e <malloc+0x135>

					}

					}

				sys_allocateMem(min_addresss,size);
  8014b7:	83 ec 08             	sub    $0x8,%esp
  8014ba:	ff 75 08             	pushl  0x8(%ebp)
  8014bd:	ff 75 e4             	pushl  -0x1c(%ebp)
  8014c0:	e8 ee 02 00 00       	call   8017b3 <sys_allocateMem>
  8014c5:	83 c4 10             	add    $0x10,%esp
				numOfPages[sizeofarray]=num;
  8014c8:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014cd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8014d0:	89 14 85 60 50 80 00 	mov    %edx,0x805060(,%eax,4)
				addresses[sizeofarray]=last_addres;
  8014d7:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014dc:	8b 15 04 30 80 00    	mov    0x803004,%edx
  8014e2:	89 14 85 20 31 80 00 	mov    %edx,0x803120(,%eax,4)
				changed[sizeofarray]=1;
  8014e9:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014ee:	c7 04 85 c0 40 80 00 	movl   $0x1,0x8040c0(,%eax,4)
  8014f5:	01 00 00 00 
				sizeofarray++;
  8014f9:	a1 2c 30 80 00       	mov    0x80302c,%eax
  8014fe:	40                   	inc    %eax
  8014ff:	a3 2c 30 80 00       	mov    %eax,0x80302c
				return(void*) min_addresss;
  801504:	8b 45 e4             	mov    -0x1c(%ebp),%eax

		//refer to the project presentation and documentation for details

		return NULL;

}
  801507:	c9                   	leave  
  801508:	c3                   	ret    

00801509 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801509:	55                   	push   %ebp
  80150a:	89 e5                	mov    %esp,%ebp
	//TODO: [PROJECT 2021 - [2] User Heap] free() [User Side]
	// Write your code here, remove the panic and write your code
	//you should get the size of the given allocation using its address

	//refer to the project presentation and documentation for details
}
  80150c:	90                   	nop
  80150d:	5d                   	pop    %ebp
  80150e:	c3                   	ret    

0080150f <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  80150f:	55                   	push   %ebp
  801510:	89 e5                	mov    %esp,%ebp
  801512:	83 ec 18             	sub    $0x18,%esp
  801515:	8b 45 10             	mov    0x10(%ebp),%eax
  801518:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  80151b:	83 ec 04             	sub    $0x4,%esp
  80151e:	68 30 25 80 00       	push   $0x802530
  801523:	68 8d 00 00 00       	push   $0x8d
  801528:	68 53 25 80 00       	push   $0x802553
  80152d:	e8 0b 07 00 00       	call   801c3d <_panic>

00801532 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801532:	55                   	push   %ebp
  801533:	89 e5                	mov    %esp,%ebp
  801535:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801538:	83 ec 04             	sub    $0x4,%esp
  80153b:	68 30 25 80 00       	push   $0x802530
  801540:	68 93 00 00 00       	push   $0x93
  801545:	68 53 25 80 00       	push   $0x802553
  80154a:	e8 ee 06 00 00       	call   801c3d <_panic>

0080154f <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  80154f:	55                   	push   %ebp
  801550:	89 e5                	mov    %esp,%ebp
  801552:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801555:	83 ec 04             	sub    $0x4,%esp
  801558:	68 30 25 80 00       	push   $0x802530
  80155d:	68 99 00 00 00       	push   $0x99
  801562:	68 53 25 80 00       	push   $0x802553
  801567:	e8 d1 06 00 00       	call   801c3d <_panic>

0080156c <realloc>:
}

void *realloc(void *virtual_address, uint32 new_size)
{
  80156c:	55                   	push   %ebp
  80156d:	89 e5                	mov    %esp,%ebp
  80156f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801572:	83 ec 04             	sub    $0x4,%esp
  801575:	68 30 25 80 00       	push   $0x802530
  80157a:	68 9e 00 00 00       	push   $0x9e
  80157f:	68 53 25 80 00       	push   $0x802553
  801584:	e8 b4 06 00 00       	call   801c3d <_panic>

00801589 <expand>:
	return 0;
}

void expand(uint32 newSize)
{
  801589:	55                   	push   %ebp
  80158a:	89 e5                	mov    %esp,%ebp
  80158c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80158f:	83 ec 04             	sub    $0x4,%esp
  801592:	68 30 25 80 00       	push   $0x802530
  801597:	68 a4 00 00 00       	push   $0xa4
  80159c:	68 53 25 80 00       	push   $0x802553
  8015a1:	e8 97 06 00 00       	call   801c3d <_panic>

008015a6 <shrink>:
}
void shrink(uint32 newSize)
{
  8015a6:	55                   	push   %ebp
  8015a7:	89 e5                	mov    %esp,%ebp
  8015a9:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8015ac:	83 ec 04             	sub    $0x4,%esp
  8015af:	68 30 25 80 00       	push   $0x802530
  8015b4:	68 a8 00 00 00       	push   $0xa8
  8015b9:	68 53 25 80 00       	push   $0x802553
  8015be:	e8 7a 06 00 00       	call   801c3d <_panic>

008015c3 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  8015c3:	55                   	push   %ebp
  8015c4:	89 e5                	mov    %esp,%ebp
  8015c6:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8015c9:	83 ec 04             	sub    $0x4,%esp
  8015cc:	68 30 25 80 00       	push   $0x802530
  8015d1:	68 ad 00 00 00       	push   $0xad
  8015d6:	68 53 25 80 00       	push   $0x802553
  8015db:	e8 5d 06 00 00       	call   801c3d <_panic>

008015e0 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8015e0:	55                   	push   %ebp
  8015e1:	89 e5                	mov    %esp,%ebp
  8015e3:	57                   	push   %edi
  8015e4:	56                   	push   %esi
  8015e5:	53                   	push   %ebx
  8015e6:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8015e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ef:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015f2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015f5:	8b 7d 18             	mov    0x18(%ebp),%edi
  8015f8:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8015fb:	cd 30                	int    $0x30
  8015fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801600:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801603:	83 c4 10             	add    $0x10,%esp
  801606:	5b                   	pop    %ebx
  801607:	5e                   	pop    %esi
  801608:	5f                   	pop    %edi
  801609:	5d                   	pop    %ebp
  80160a:	c3                   	ret    

0080160b <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80160b:	55                   	push   %ebp
  80160c:	89 e5                	mov    %esp,%ebp
  80160e:	83 ec 04             	sub    $0x4,%esp
  801611:	8b 45 10             	mov    0x10(%ebp),%eax
  801614:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801617:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80161b:	8b 45 08             	mov    0x8(%ebp),%eax
  80161e:	6a 00                	push   $0x0
  801620:	6a 00                	push   $0x0
  801622:	52                   	push   %edx
  801623:	ff 75 0c             	pushl  0xc(%ebp)
  801626:	50                   	push   %eax
  801627:	6a 00                	push   $0x0
  801629:	e8 b2 ff ff ff       	call   8015e0 <syscall>
  80162e:	83 c4 18             	add    $0x18,%esp
}
  801631:	90                   	nop
  801632:	c9                   	leave  
  801633:	c3                   	ret    

00801634 <sys_cgetc>:

int
sys_cgetc(void)
{
  801634:	55                   	push   %ebp
  801635:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	6a 00                	push   $0x0
  80163d:	6a 00                	push   $0x0
  80163f:	6a 00                	push   $0x0
  801641:	6a 01                	push   $0x1
  801643:	e8 98 ff ff ff       	call   8015e0 <syscall>
  801648:	83 c4 18             	add    $0x18,%esp
}
  80164b:	c9                   	leave  
  80164c:	c3                   	ret    

0080164d <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80164d:	55                   	push   %ebp
  80164e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801650:	8b 45 08             	mov    0x8(%ebp),%eax
  801653:	6a 00                	push   $0x0
  801655:	6a 00                	push   $0x0
  801657:	6a 00                	push   $0x0
  801659:	6a 00                	push   $0x0
  80165b:	50                   	push   %eax
  80165c:	6a 05                	push   $0x5
  80165e:	e8 7d ff ff ff       	call   8015e0 <syscall>
  801663:	83 c4 18             	add    $0x18,%esp
}
  801666:	c9                   	leave  
  801667:	c3                   	ret    

00801668 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801668:	55                   	push   %ebp
  801669:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80166b:	6a 00                	push   $0x0
  80166d:	6a 00                	push   $0x0
  80166f:	6a 00                	push   $0x0
  801671:	6a 00                	push   $0x0
  801673:	6a 00                	push   $0x0
  801675:	6a 02                	push   $0x2
  801677:	e8 64 ff ff ff       	call   8015e0 <syscall>
  80167c:	83 c4 18             	add    $0x18,%esp
}
  80167f:	c9                   	leave  
  801680:	c3                   	ret    

00801681 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801681:	55                   	push   %ebp
  801682:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801684:	6a 00                	push   $0x0
  801686:	6a 00                	push   $0x0
  801688:	6a 00                	push   $0x0
  80168a:	6a 00                	push   $0x0
  80168c:	6a 00                	push   $0x0
  80168e:	6a 03                	push   $0x3
  801690:	e8 4b ff ff ff       	call   8015e0 <syscall>
  801695:	83 c4 18             	add    $0x18,%esp
}
  801698:	c9                   	leave  
  801699:	c3                   	ret    

0080169a <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80169a:	55                   	push   %ebp
  80169b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80169d:	6a 00                	push   $0x0
  80169f:	6a 00                	push   $0x0
  8016a1:	6a 00                	push   $0x0
  8016a3:	6a 00                	push   $0x0
  8016a5:	6a 00                	push   $0x0
  8016a7:	6a 04                	push   $0x4
  8016a9:	e8 32 ff ff ff       	call   8015e0 <syscall>
  8016ae:	83 c4 18             	add    $0x18,%esp
}
  8016b1:	c9                   	leave  
  8016b2:	c3                   	ret    

008016b3 <sys_env_exit>:


void sys_env_exit(void)
{
  8016b3:	55                   	push   %ebp
  8016b4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8016b6:	6a 00                	push   $0x0
  8016b8:	6a 00                	push   $0x0
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 00                	push   $0x0
  8016be:	6a 00                	push   $0x0
  8016c0:	6a 06                	push   $0x6
  8016c2:	e8 19 ff ff ff       	call   8015e0 <syscall>
  8016c7:	83 c4 18             	add    $0x18,%esp
}
  8016ca:	90                   	nop
  8016cb:	c9                   	leave  
  8016cc:	c3                   	ret    

008016cd <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8016cd:	55                   	push   %ebp
  8016ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8016d0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d6:	6a 00                	push   $0x0
  8016d8:	6a 00                	push   $0x0
  8016da:	6a 00                	push   $0x0
  8016dc:	52                   	push   %edx
  8016dd:	50                   	push   %eax
  8016de:	6a 07                	push   $0x7
  8016e0:	e8 fb fe ff ff       	call   8015e0 <syscall>
  8016e5:	83 c4 18             	add    $0x18,%esp
}
  8016e8:	c9                   	leave  
  8016e9:	c3                   	ret    

008016ea <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8016ea:	55                   	push   %ebp
  8016eb:	89 e5                	mov    %esp,%ebp
  8016ed:	56                   	push   %esi
  8016ee:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8016ef:	8b 75 18             	mov    0x18(%ebp),%esi
  8016f2:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8016f5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8016f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fe:	56                   	push   %esi
  8016ff:	53                   	push   %ebx
  801700:	51                   	push   %ecx
  801701:	52                   	push   %edx
  801702:	50                   	push   %eax
  801703:	6a 08                	push   $0x8
  801705:	e8 d6 fe ff ff       	call   8015e0 <syscall>
  80170a:	83 c4 18             	add    $0x18,%esp
}
  80170d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801710:	5b                   	pop    %ebx
  801711:	5e                   	pop    %esi
  801712:	5d                   	pop    %ebp
  801713:	c3                   	ret    

00801714 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801714:	55                   	push   %ebp
  801715:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801717:	8b 55 0c             	mov    0xc(%ebp),%edx
  80171a:	8b 45 08             	mov    0x8(%ebp),%eax
  80171d:	6a 00                	push   $0x0
  80171f:	6a 00                	push   $0x0
  801721:	6a 00                	push   $0x0
  801723:	52                   	push   %edx
  801724:	50                   	push   %eax
  801725:	6a 09                	push   $0x9
  801727:	e8 b4 fe ff ff       	call   8015e0 <syscall>
  80172c:	83 c4 18             	add    $0x18,%esp
}
  80172f:	c9                   	leave  
  801730:	c3                   	ret    

00801731 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801731:	55                   	push   %ebp
  801732:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801734:	6a 00                	push   $0x0
  801736:	6a 00                	push   $0x0
  801738:	6a 00                	push   $0x0
  80173a:	ff 75 0c             	pushl  0xc(%ebp)
  80173d:	ff 75 08             	pushl  0x8(%ebp)
  801740:	6a 0a                	push   $0xa
  801742:	e8 99 fe ff ff       	call   8015e0 <syscall>
  801747:	83 c4 18             	add    $0x18,%esp
}
  80174a:	c9                   	leave  
  80174b:	c3                   	ret    

0080174c <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80174c:	55                   	push   %ebp
  80174d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80174f:	6a 00                	push   $0x0
  801751:	6a 00                	push   $0x0
  801753:	6a 00                	push   $0x0
  801755:	6a 00                	push   $0x0
  801757:	6a 00                	push   $0x0
  801759:	6a 0b                	push   $0xb
  80175b:	e8 80 fe ff ff       	call   8015e0 <syscall>
  801760:	83 c4 18             	add    $0x18,%esp
}
  801763:	c9                   	leave  
  801764:	c3                   	ret    

00801765 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801765:	55                   	push   %ebp
  801766:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801768:	6a 00                	push   $0x0
  80176a:	6a 00                	push   $0x0
  80176c:	6a 00                	push   $0x0
  80176e:	6a 00                	push   $0x0
  801770:	6a 00                	push   $0x0
  801772:	6a 0c                	push   $0xc
  801774:	e8 67 fe ff ff       	call   8015e0 <syscall>
  801779:	83 c4 18             	add    $0x18,%esp
}
  80177c:	c9                   	leave  
  80177d:	c3                   	ret    

0080177e <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80177e:	55                   	push   %ebp
  80177f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 00                	push   $0x0
  801789:	6a 00                	push   $0x0
  80178b:	6a 0d                	push   $0xd
  80178d:	e8 4e fe ff ff       	call   8015e0 <syscall>
  801792:	83 c4 18             	add    $0x18,%esp
}
  801795:	c9                   	leave  
  801796:	c3                   	ret    

00801797 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801797:	55                   	push   %ebp
  801798:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80179a:	6a 00                	push   $0x0
  80179c:	6a 00                	push   $0x0
  80179e:	6a 00                	push   $0x0
  8017a0:	ff 75 0c             	pushl  0xc(%ebp)
  8017a3:	ff 75 08             	pushl  0x8(%ebp)
  8017a6:	6a 11                	push   $0x11
  8017a8:	e8 33 fe ff ff       	call   8015e0 <syscall>
  8017ad:	83 c4 18             	add    $0x18,%esp
	return;
  8017b0:	90                   	nop
}
  8017b1:	c9                   	leave  
  8017b2:	c3                   	ret    

008017b3 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8017b3:	55                   	push   %ebp
  8017b4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	6a 00                	push   $0x0
  8017bc:	ff 75 0c             	pushl  0xc(%ebp)
  8017bf:	ff 75 08             	pushl  0x8(%ebp)
  8017c2:	6a 12                	push   $0x12
  8017c4:	e8 17 fe ff ff       	call   8015e0 <syscall>
  8017c9:	83 c4 18             	add    $0x18,%esp
	return ;
  8017cc:	90                   	nop
}
  8017cd:	c9                   	leave  
  8017ce:	c3                   	ret    

008017cf <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8017cf:	55                   	push   %ebp
  8017d0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 0e                	push   $0xe
  8017de:	e8 fd fd ff ff       	call   8015e0 <syscall>
  8017e3:	83 c4 18             	add    $0x18,%esp
}
  8017e6:	c9                   	leave  
  8017e7:	c3                   	ret    

008017e8 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8017e8:	55                   	push   %ebp
  8017e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 00                	push   $0x0
  8017f3:	ff 75 08             	pushl  0x8(%ebp)
  8017f6:	6a 0f                	push   $0xf
  8017f8:	e8 e3 fd ff ff       	call   8015e0 <syscall>
  8017fd:	83 c4 18             	add    $0x18,%esp
}
  801800:	c9                   	leave  
  801801:	c3                   	ret    

00801802 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801802:	55                   	push   %ebp
  801803:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801805:	6a 00                	push   $0x0
  801807:	6a 00                	push   $0x0
  801809:	6a 00                	push   $0x0
  80180b:	6a 00                	push   $0x0
  80180d:	6a 00                	push   $0x0
  80180f:	6a 10                	push   $0x10
  801811:	e8 ca fd ff ff       	call   8015e0 <syscall>
  801816:	83 c4 18             	add    $0x18,%esp
}
  801819:	90                   	nop
  80181a:	c9                   	leave  
  80181b:	c3                   	ret    

0080181c <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80181c:	55                   	push   %ebp
  80181d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80181f:	6a 00                	push   $0x0
  801821:	6a 00                	push   $0x0
  801823:	6a 00                	push   $0x0
  801825:	6a 00                	push   $0x0
  801827:	6a 00                	push   $0x0
  801829:	6a 14                	push   $0x14
  80182b:	e8 b0 fd ff ff       	call   8015e0 <syscall>
  801830:	83 c4 18             	add    $0x18,%esp
}
  801833:	90                   	nop
  801834:	c9                   	leave  
  801835:	c3                   	ret    

00801836 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801836:	55                   	push   %ebp
  801837:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 00                	push   $0x0
  801843:	6a 15                	push   $0x15
  801845:	e8 96 fd ff ff       	call   8015e0 <syscall>
  80184a:	83 c4 18             	add    $0x18,%esp
}
  80184d:	90                   	nop
  80184e:	c9                   	leave  
  80184f:	c3                   	ret    

00801850 <sys_cputc>:


void
sys_cputc(const char c)
{
  801850:	55                   	push   %ebp
  801851:	89 e5                	mov    %esp,%ebp
  801853:	83 ec 04             	sub    $0x4,%esp
  801856:	8b 45 08             	mov    0x8(%ebp),%eax
  801859:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80185c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	6a 00                	push   $0x0
  801866:	6a 00                	push   $0x0
  801868:	50                   	push   %eax
  801869:	6a 16                	push   $0x16
  80186b:	e8 70 fd ff ff       	call   8015e0 <syscall>
  801870:	83 c4 18             	add    $0x18,%esp
}
  801873:	90                   	nop
  801874:	c9                   	leave  
  801875:	c3                   	ret    

00801876 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801876:	55                   	push   %ebp
  801877:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 00                	push   $0x0
  80187f:	6a 00                	push   $0x0
  801881:	6a 00                	push   $0x0
  801883:	6a 17                	push   $0x17
  801885:	e8 56 fd ff ff       	call   8015e0 <syscall>
  80188a:	83 c4 18             	add    $0x18,%esp
}
  80188d:	90                   	nop
  80188e:	c9                   	leave  
  80188f:	c3                   	ret    

00801890 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801890:	55                   	push   %ebp
  801891:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801893:	8b 45 08             	mov    0x8(%ebp),%eax
  801896:	6a 00                	push   $0x0
  801898:	6a 00                	push   $0x0
  80189a:	6a 00                	push   $0x0
  80189c:	ff 75 0c             	pushl  0xc(%ebp)
  80189f:	50                   	push   %eax
  8018a0:	6a 18                	push   $0x18
  8018a2:	e8 39 fd ff ff       	call   8015e0 <syscall>
  8018a7:	83 c4 18             	add    $0x18,%esp
}
  8018aa:	c9                   	leave  
  8018ab:	c3                   	ret    

008018ac <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8018ac:	55                   	push   %ebp
  8018ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b5:	6a 00                	push   $0x0
  8018b7:	6a 00                	push   $0x0
  8018b9:	6a 00                	push   $0x0
  8018bb:	52                   	push   %edx
  8018bc:	50                   	push   %eax
  8018bd:	6a 1b                	push   $0x1b
  8018bf:	e8 1c fd ff ff       	call   8015e0 <syscall>
  8018c4:	83 c4 18             	add    $0x18,%esp
}
  8018c7:	c9                   	leave  
  8018c8:	c3                   	ret    

008018c9 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018c9:	55                   	push   %ebp
  8018ca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d2:	6a 00                	push   $0x0
  8018d4:	6a 00                	push   $0x0
  8018d6:	6a 00                	push   $0x0
  8018d8:	52                   	push   %edx
  8018d9:	50                   	push   %eax
  8018da:	6a 19                	push   $0x19
  8018dc:	e8 ff fc ff ff       	call   8015e0 <syscall>
  8018e1:	83 c4 18             	add    $0x18,%esp
}
  8018e4:	90                   	nop
  8018e5:	c9                   	leave  
  8018e6:	c3                   	ret    

008018e7 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8018e7:	55                   	push   %ebp
  8018e8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8018ea:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f0:	6a 00                	push   $0x0
  8018f2:	6a 00                	push   $0x0
  8018f4:	6a 00                	push   $0x0
  8018f6:	52                   	push   %edx
  8018f7:	50                   	push   %eax
  8018f8:	6a 1a                	push   $0x1a
  8018fa:	e8 e1 fc ff ff       	call   8015e0 <syscall>
  8018ff:	83 c4 18             	add    $0x18,%esp
}
  801902:	90                   	nop
  801903:	c9                   	leave  
  801904:	c3                   	ret    

00801905 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801905:	55                   	push   %ebp
  801906:	89 e5                	mov    %esp,%ebp
  801908:	83 ec 04             	sub    $0x4,%esp
  80190b:	8b 45 10             	mov    0x10(%ebp),%eax
  80190e:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801911:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801914:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801918:	8b 45 08             	mov    0x8(%ebp),%eax
  80191b:	6a 00                	push   $0x0
  80191d:	51                   	push   %ecx
  80191e:	52                   	push   %edx
  80191f:	ff 75 0c             	pushl  0xc(%ebp)
  801922:	50                   	push   %eax
  801923:	6a 1c                	push   $0x1c
  801925:	e8 b6 fc ff ff       	call   8015e0 <syscall>
  80192a:	83 c4 18             	add    $0x18,%esp
}
  80192d:	c9                   	leave  
  80192e:	c3                   	ret    

0080192f <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80192f:	55                   	push   %ebp
  801930:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801932:	8b 55 0c             	mov    0xc(%ebp),%edx
  801935:	8b 45 08             	mov    0x8(%ebp),%eax
  801938:	6a 00                	push   $0x0
  80193a:	6a 00                	push   $0x0
  80193c:	6a 00                	push   $0x0
  80193e:	52                   	push   %edx
  80193f:	50                   	push   %eax
  801940:	6a 1d                	push   $0x1d
  801942:	e8 99 fc ff ff       	call   8015e0 <syscall>
  801947:	83 c4 18             	add    $0x18,%esp
}
  80194a:	c9                   	leave  
  80194b:	c3                   	ret    

0080194c <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80194c:	55                   	push   %ebp
  80194d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80194f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801952:	8b 55 0c             	mov    0xc(%ebp),%edx
  801955:	8b 45 08             	mov    0x8(%ebp),%eax
  801958:	6a 00                	push   $0x0
  80195a:	6a 00                	push   $0x0
  80195c:	51                   	push   %ecx
  80195d:	52                   	push   %edx
  80195e:	50                   	push   %eax
  80195f:	6a 1e                	push   $0x1e
  801961:	e8 7a fc ff ff       	call   8015e0 <syscall>
  801966:	83 c4 18             	add    $0x18,%esp
}
  801969:	c9                   	leave  
  80196a:	c3                   	ret    

0080196b <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80196b:	55                   	push   %ebp
  80196c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80196e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801971:	8b 45 08             	mov    0x8(%ebp),%eax
  801974:	6a 00                	push   $0x0
  801976:	6a 00                	push   $0x0
  801978:	6a 00                	push   $0x0
  80197a:	52                   	push   %edx
  80197b:	50                   	push   %eax
  80197c:	6a 1f                	push   $0x1f
  80197e:	e8 5d fc ff ff       	call   8015e0 <syscall>
  801983:	83 c4 18             	add    $0x18,%esp
}
  801986:	c9                   	leave  
  801987:	c3                   	ret    

00801988 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801988:	55                   	push   %ebp
  801989:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80198b:	6a 00                	push   $0x0
  80198d:	6a 00                	push   $0x0
  80198f:	6a 00                	push   $0x0
  801991:	6a 00                	push   $0x0
  801993:	6a 00                	push   $0x0
  801995:	6a 20                	push   $0x20
  801997:	e8 44 fc ff ff       	call   8015e0 <syscall>
  80199c:	83 c4 18             	add    $0x18,%esp
}
  80199f:	c9                   	leave  
  8019a0:	c3                   	ret    

008019a1 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8019a1:	55                   	push   %ebp
  8019a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8019a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a7:	6a 00                	push   $0x0
  8019a9:	ff 75 14             	pushl  0x14(%ebp)
  8019ac:	ff 75 10             	pushl  0x10(%ebp)
  8019af:	ff 75 0c             	pushl  0xc(%ebp)
  8019b2:	50                   	push   %eax
  8019b3:	6a 21                	push   $0x21
  8019b5:	e8 26 fc ff ff       	call   8015e0 <syscall>
  8019ba:	83 c4 18             	add    $0x18,%esp
}
  8019bd:	c9                   	leave  
  8019be:	c3                   	ret    

008019bf <sys_run_env>:

void
sys_run_env(int32 envId)
{
  8019bf:	55                   	push   %ebp
  8019c0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8019c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c5:	6a 00                	push   $0x0
  8019c7:	6a 00                	push   $0x0
  8019c9:	6a 00                	push   $0x0
  8019cb:	6a 00                	push   $0x0
  8019cd:	50                   	push   %eax
  8019ce:	6a 22                	push   $0x22
  8019d0:	e8 0b fc ff ff       	call   8015e0 <syscall>
  8019d5:	83 c4 18             	add    $0x18,%esp
}
  8019d8:	90                   	nop
  8019d9:	c9                   	leave  
  8019da:	c3                   	ret    

008019db <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8019db:	55                   	push   %ebp
  8019dc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8019de:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e1:	6a 00                	push   $0x0
  8019e3:	6a 00                	push   $0x0
  8019e5:	6a 00                	push   $0x0
  8019e7:	6a 00                	push   $0x0
  8019e9:	50                   	push   %eax
  8019ea:	6a 23                	push   $0x23
  8019ec:	e8 ef fb ff ff       	call   8015e0 <syscall>
  8019f1:	83 c4 18             	add    $0x18,%esp
}
  8019f4:	90                   	nop
  8019f5:	c9                   	leave  
  8019f6:	c3                   	ret    

008019f7 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8019f7:	55                   	push   %ebp
  8019f8:	89 e5                	mov    %esp,%ebp
  8019fa:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8019fd:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a00:	8d 50 04             	lea    0x4(%eax),%edx
  801a03:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801a06:	6a 00                	push   $0x0
  801a08:	6a 00                	push   $0x0
  801a0a:	6a 00                	push   $0x0
  801a0c:	52                   	push   %edx
  801a0d:	50                   	push   %eax
  801a0e:	6a 24                	push   $0x24
  801a10:	e8 cb fb ff ff       	call   8015e0 <syscall>
  801a15:	83 c4 18             	add    $0x18,%esp
	return result;
  801a18:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801a1b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a1e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a21:	89 01                	mov    %eax,(%ecx)
  801a23:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801a26:	8b 45 08             	mov    0x8(%ebp),%eax
  801a29:	c9                   	leave  
  801a2a:	c2 04 00             	ret    $0x4

00801a2d <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801a2d:	55                   	push   %ebp
  801a2e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801a30:	6a 00                	push   $0x0
  801a32:	6a 00                	push   $0x0
  801a34:	ff 75 10             	pushl  0x10(%ebp)
  801a37:	ff 75 0c             	pushl  0xc(%ebp)
  801a3a:	ff 75 08             	pushl  0x8(%ebp)
  801a3d:	6a 13                	push   $0x13
  801a3f:	e8 9c fb ff ff       	call   8015e0 <syscall>
  801a44:	83 c4 18             	add    $0x18,%esp
	return ;
  801a47:	90                   	nop
}
  801a48:	c9                   	leave  
  801a49:	c3                   	ret    

00801a4a <sys_rcr2>:
uint32 sys_rcr2()
{
  801a4a:	55                   	push   %ebp
  801a4b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801a4d:	6a 00                	push   $0x0
  801a4f:	6a 00                	push   $0x0
  801a51:	6a 00                	push   $0x0
  801a53:	6a 00                	push   $0x0
  801a55:	6a 00                	push   $0x0
  801a57:	6a 25                	push   $0x25
  801a59:	e8 82 fb ff ff       	call   8015e0 <syscall>
  801a5e:	83 c4 18             	add    $0x18,%esp
}
  801a61:	c9                   	leave  
  801a62:	c3                   	ret    

00801a63 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801a63:	55                   	push   %ebp
  801a64:	89 e5                	mov    %esp,%ebp
  801a66:	83 ec 04             	sub    $0x4,%esp
  801a69:	8b 45 08             	mov    0x8(%ebp),%eax
  801a6c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801a6f:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801a73:	6a 00                	push   $0x0
  801a75:	6a 00                	push   $0x0
  801a77:	6a 00                	push   $0x0
  801a79:	6a 00                	push   $0x0
  801a7b:	50                   	push   %eax
  801a7c:	6a 26                	push   $0x26
  801a7e:	e8 5d fb ff ff       	call   8015e0 <syscall>
  801a83:	83 c4 18             	add    $0x18,%esp
	return ;
  801a86:	90                   	nop
}
  801a87:	c9                   	leave  
  801a88:	c3                   	ret    

00801a89 <rsttst>:
void rsttst()
{
  801a89:	55                   	push   %ebp
  801a8a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801a8c:	6a 00                	push   $0x0
  801a8e:	6a 00                	push   $0x0
  801a90:	6a 00                	push   $0x0
  801a92:	6a 00                	push   $0x0
  801a94:	6a 00                	push   $0x0
  801a96:	6a 28                	push   $0x28
  801a98:	e8 43 fb ff ff       	call   8015e0 <syscall>
  801a9d:	83 c4 18             	add    $0x18,%esp
	return ;
  801aa0:	90                   	nop
}
  801aa1:	c9                   	leave  
  801aa2:	c3                   	ret    

00801aa3 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801aa3:	55                   	push   %ebp
  801aa4:	89 e5                	mov    %esp,%ebp
  801aa6:	83 ec 04             	sub    $0x4,%esp
  801aa9:	8b 45 14             	mov    0x14(%ebp),%eax
  801aac:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801aaf:	8b 55 18             	mov    0x18(%ebp),%edx
  801ab2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ab6:	52                   	push   %edx
  801ab7:	50                   	push   %eax
  801ab8:	ff 75 10             	pushl  0x10(%ebp)
  801abb:	ff 75 0c             	pushl  0xc(%ebp)
  801abe:	ff 75 08             	pushl  0x8(%ebp)
  801ac1:	6a 27                	push   $0x27
  801ac3:	e8 18 fb ff ff       	call   8015e0 <syscall>
  801ac8:	83 c4 18             	add    $0x18,%esp
	return ;
  801acb:	90                   	nop
}
  801acc:	c9                   	leave  
  801acd:	c3                   	ret    

00801ace <chktst>:
void chktst(uint32 n)
{
  801ace:	55                   	push   %ebp
  801acf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801ad1:	6a 00                	push   $0x0
  801ad3:	6a 00                	push   $0x0
  801ad5:	6a 00                	push   $0x0
  801ad7:	6a 00                	push   $0x0
  801ad9:	ff 75 08             	pushl  0x8(%ebp)
  801adc:	6a 29                	push   $0x29
  801ade:	e8 fd fa ff ff       	call   8015e0 <syscall>
  801ae3:	83 c4 18             	add    $0x18,%esp
	return ;
  801ae6:	90                   	nop
}
  801ae7:	c9                   	leave  
  801ae8:	c3                   	ret    

00801ae9 <inctst>:

void inctst()
{
  801ae9:	55                   	push   %ebp
  801aea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801aec:	6a 00                	push   $0x0
  801aee:	6a 00                	push   $0x0
  801af0:	6a 00                	push   $0x0
  801af2:	6a 00                	push   $0x0
  801af4:	6a 00                	push   $0x0
  801af6:	6a 2a                	push   $0x2a
  801af8:	e8 e3 fa ff ff       	call   8015e0 <syscall>
  801afd:	83 c4 18             	add    $0x18,%esp
	return ;
  801b00:	90                   	nop
}
  801b01:	c9                   	leave  
  801b02:	c3                   	ret    

00801b03 <gettst>:
uint32 gettst()
{
  801b03:	55                   	push   %ebp
  801b04:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801b06:	6a 00                	push   $0x0
  801b08:	6a 00                	push   $0x0
  801b0a:	6a 00                	push   $0x0
  801b0c:	6a 00                	push   $0x0
  801b0e:	6a 00                	push   $0x0
  801b10:	6a 2b                	push   $0x2b
  801b12:	e8 c9 fa ff ff       	call   8015e0 <syscall>
  801b17:	83 c4 18             	add    $0x18,%esp
}
  801b1a:	c9                   	leave  
  801b1b:	c3                   	ret    

00801b1c <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801b1c:	55                   	push   %ebp
  801b1d:	89 e5                	mov    %esp,%ebp
  801b1f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b22:	6a 00                	push   $0x0
  801b24:	6a 00                	push   $0x0
  801b26:	6a 00                	push   $0x0
  801b28:	6a 00                	push   $0x0
  801b2a:	6a 00                	push   $0x0
  801b2c:	6a 2c                	push   $0x2c
  801b2e:	e8 ad fa ff ff       	call   8015e0 <syscall>
  801b33:	83 c4 18             	add    $0x18,%esp
  801b36:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801b39:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801b3d:	75 07                	jne    801b46 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801b3f:	b8 01 00 00 00       	mov    $0x1,%eax
  801b44:	eb 05                	jmp    801b4b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801b46:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b4b:	c9                   	leave  
  801b4c:	c3                   	ret    

00801b4d <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801b4d:	55                   	push   %ebp
  801b4e:	89 e5                	mov    %esp,%ebp
  801b50:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b53:	6a 00                	push   $0x0
  801b55:	6a 00                	push   $0x0
  801b57:	6a 00                	push   $0x0
  801b59:	6a 00                	push   $0x0
  801b5b:	6a 00                	push   $0x0
  801b5d:	6a 2c                	push   $0x2c
  801b5f:	e8 7c fa ff ff       	call   8015e0 <syscall>
  801b64:	83 c4 18             	add    $0x18,%esp
  801b67:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801b6a:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801b6e:	75 07                	jne    801b77 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801b70:	b8 01 00 00 00       	mov    $0x1,%eax
  801b75:	eb 05                	jmp    801b7c <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801b77:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b7c:	c9                   	leave  
  801b7d:	c3                   	ret    

00801b7e <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801b7e:	55                   	push   %ebp
  801b7f:	89 e5                	mov    %esp,%ebp
  801b81:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801b84:	6a 00                	push   $0x0
  801b86:	6a 00                	push   $0x0
  801b88:	6a 00                	push   $0x0
  801b8a:	6a 00                	push   $0x0
  801b8c:	6a 00                	push   $0x0
  801b8e:	6a 2c                	push   $0x2c
  801b90:	e8 4b fa ff ff       	call   8015e0 <syscall>
  801b95:	83 c4 18             	add    $0x18,%esp
  801b98:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801b9b:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801b9f:	75 07                	jne    801ba8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801ba1:	b8 01 00 00 00       	mov    $0x1,%eax
  801ba6:	eb 05                	jmp    801bad <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801ba8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bad:	c9                   	leave  
  801bae:	c3                   	ret    

00801baf <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801baf:	55                   	push   %ebp
  801bb0:	89 e5                	mov    %esp,%ebp
  801bb2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801bb5:	6a 00                	push   $0x0
  801bb7:	6a 00                	push   $0x0
  801bb9:	6a 00                	push   $0x0
  801bbb:	6a 00                	push   $0x0
  801bbd:	6a 00                	push   $0x0
  801bbf:	6a 2c                	push   $0x2c
  801bc1:	e8 1a fa ff ff       	call   8015e0 <syscall>
  801bc6:	83 c4 18             	add    $0x18,%esp
  801bc9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801bcc:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801bd0:	75 07                	jne    801bd9 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801bd2:	b8 01 00 00 00       	mov    $0x1,%eax
  801bd7:	eb 05                	jmp    801bde <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801bd9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801bde:	c9                   	leave  
  801bdf:	c3                   	ret    

00801be0 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801be0:	55                   	push   %ebp
  801be1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801be3:	6a 00                	push   $0x0
  801be5:	6a 00                	push   $0x0
  801be7:	6a 00                	push   $0x0
  801be9:	6a 00                	push   $0x0
  801beb:	ff 75 08             	pushl  0x8(%ebp)
  801bee:	6a 2d                	push   $0x2d
  801bf0:	e8 eb f9 ff ff       	call   8015e0 <syscall>
  801bf5:	83 c4 18             	add    $0x18,%esp
	return ;
  801bf8:	90                   	nop
}
  801bf9:	c9                   	leave  
  801bfa:	c3                   	ret    

00801bfb <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801bfb:	55                   	push   %ebp
  801bfc:	89 e5                	mov    %esp,%ebp
  801bfe:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801bff:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c02:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c05:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c08:	8b 45 08             	mov    0x8(%ebp),%eax
  801c0b:	6a 00                	push   $0x0
  801c0d:	53                   	push   %ebx
  801c0e:	51                   	push   %ecx
  801c0f:	52                   	push   %edx
  801c10:	50                   	push   %eax
  801c11:	6a 2e                	push   $0x2e
  801c13:	e8 c8 f9 ff ff       	call   8015e0 <syscall>
  801c18:	83 c4 18             	add    $0x18,%esp
}
  801c1b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801c1e:	c9                   	leave  
  801c1f:	c3                   	ret    

00801c20 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801c20:	55                   	push   %ebp
  801c21:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801c23:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c26:	8b 45 08             	mov    0x8(%ebp),%eax
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	52                   	push   %edx
  801c30:	50                   	push   %eax
  801c31:	6a 2f                	push   $0x2f
  801c33:	e8 a8 f9 ff ff       	call   8015e0 <syscall>
  801c38:	83 c4 18             	add    $0x18,%esp
}
  801c3b:	c9                   	leave  
  801c3c:	c3                   	ret    

00801c3d <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  801c3d:	55                   	push   %ebp
  801c3e:	89 e5                	mov    %esp,%ebp
  801c40:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801c43:	8d 45 10             	lea    0x10(%ebp),%eax
  801c46:	83 c0 04             	add    $0x4,%eax
  801c49:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  801c4c:	a1 00 60 80 00       	mov    0x806000,%eax
  801c51:	85 c0                	test   %eax,%eax
  801c53:	74 16                	je     801c6b <_panic+0x2e>
		cprintf("%s: ", argv0);
  801c55:	a1 00 60 80 00       	mov    0x806000,%eax
  801c5a:	83 ec 08             	sub    $0x8,%esp
  801c5d:	50                   	push   %eax
  801c5e:	68 60 25 80 00       	push   $0x802560
  801c63:	e8 07 e9 ff ff       	call   80056f <cprintf>
  801c68:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801c6b:	a1 00 30 80 00       	mov    0x803000,%eax
  801c70:	ff 75 0c             	pushl  0xc(%ebp)
  801c73:	ff 75 08             	pushl  0x8(%ebp)
  801c76:	50                   	push   %eax
  801c77:	68 65 25 80 00       	push   $0x802565
  801c7c:	e8 ee e8 ff ff       	call   80056f <cprintf>
  801c81:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801c84:	8b 45 10             	mov    0x10(%ebp),%eax
  801c87:	83 ec 08             	sub    $0x8,%esp
  801c8a:	ff 75 f4             	pushl  -0xc(%ebp)
  801c8d:	50                   	push   %eax
  801c8e:	e8 71 e8 ff ff       	call   800504 <vcprintf>
  801c93:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801c96:	83 ec 08             	sub    $0x8,%esp
  801c99:	6a 00                	push   $0x0
  801c9b:	68 81 25 80 00       	push   $0x802581
  801ca0:	e8 5f e8 ff ff       	call   800504 <vcprintf>
  801ca5:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801ca8:	e8 e0 e7 ff ff       	call   80048d <exit>

	// should not return here
	while (1) ;
  801cad:	eb fe                	jmp    801cad <_panic+0x70>

00801caf <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  801caf:	55                   	push   %ebp
  801cb0:	89 e5                	mov    %esp,%ebp
  801cb2:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801cb5:	a1 20 30 80 00       	mov    0x803020,%eax
  801cba:	8b 50 74             	mov    0x74(%eax),%edx
  801cbd:	8b 45 0c             	mov    0xc(%ebp),%eax
  801cc0:	39 c2                	cmp    %eax,%edx
  801cc2:	74 14                	je     801cd8 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  801cc4:	83 ec 04             	sub    $0x4,%esp
  801cc7:	68 84 25 80 00       	push   $0x802584
  801ccc:	6a 26                	push   $0x26
  801cce:	68 d0 25 80 00       	push   $0x8025d0
  801cd3:	e8 65 ff ff ff       	call   801c3d <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  801cd8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  801cdf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  801ce6:	e9 b6 00 00 00       	jmp    801da1 <CheckWSWithoutLastIndex+0xf2>
		if (expectedPages[e] == 0) {
  801ceb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cee:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801cf5:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf8:	01 d0                	add    %edx,%eax
  801cfa:	8b 00                	mov    (%eax),%eax
  801cfc:	85 c0                	test   %eax,%eax
  801cfe:	75 08                	jne    801d08 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  801d00:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  801d03:	e9 96 00 00 00       	jmp    801d9e <CheckWSWithoutLastIndex+0xef>
		}
		int found = 0;
  801d08:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d0f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  801d16:	eb 5d                	jmp    801d75 <CheckWSWithoutLastIndex+0xc6>
			if (myEnv->__uptr_pws[w].empty == 0) {
  801d18:	a1 20 30 80 00       	mov    0x803020,%eax
  801d1d:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801d23:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801d26:	c1 e2 04             	shl    $0x4,%edx
  801d29:	01 d0                	add    %edx,%eax
  801d2b:	8a 40 04             	mov    0x4(%eax),%al
  801d2e:	84 c0                	test   %al,%al
  801d30:	75 40                	jne    801d72 <CheckWSWithoutLastIndex+0xc3>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801d32:	a1 20 30 80 00       	mov    0x803020,%eax
  801d37:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801d3d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801d40:	c1 e2 04             	shl    $0x4,%edx
  801d43:	01 d0                	add    %edx,%eax
  801d45:	8b 00                	mov    (%eax),%eax
  801d47:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801d4a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801d4d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  801d52:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  801d54:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801d57:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801d5e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d61:	01 c8                	add    %ecx,%eax
  801d63:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801d65:	39 c2                	cmp    %eax,%edx
  801d67:	75 09                	jne    801d72 <CheckWSWithoutLastIndex+0xc3>
						== expectedPages[e]) {
					found = 1;
  801d69:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  801d70:	eb 12                	jmp    801d84 <CheckWSWithoutLastIndex+0xd5>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801d72:	ff 45 e8             	incl   -0x18(%ebp)
  801d75:	a1 20 30 80 00       	mov    0x803020,%eax
  801d7a:	8b 50 74             	mov    0x74(%eax),%edx
  801d7d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801d80:	39 c2                	cmp    %eax,%edx
  801d82:	77 94                	ja     801d18 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  801d84:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801d88:	75 14                	jne    801d9e <CheckWSWithoutLastIndex+0xef>
			panic(
  801d8a:	83 ec 04             	sub    $0x4,%esp
  801d8d:	68 dc 25 80 00       	push   $0x8025dc
  801d92:	6a 3a                	push   $0x3a
  801d94:	68 d0 25 80 00       	push   $0x8025d0
  801d99:	e8 9f fe ff ff       	call   801c3d <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801d9e:	ff 45 f0             	incl   -0x10(%ebp)
  801da1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801da4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801da7:	0f 8c 3e ff ff ff    	jl     801ceb <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801dad:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801db4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  801dbb:	eb 20                	jmp    801ddd <CheckWSWithoutLastIndex+0x12e>
		if (myEnv->__uptr_pws[w].empty == 1) {
  801dbd:	a1 20 30 80 00       	mov    0x803020,%eax
  801dc2:	8b 80 80 3c 01 00    	mov    0x13c80(%eax),%eax
  801dc8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801dcb:	c1 e2 04             	shl    $0x4,%edx
  801dce:	01 d0                	add    %edx,%eax
  801dd0:	8a 40 04             	mov    0x4(%eax),%al
  801dd3:	3c 01                	cmp    $0x1,%al
  801dd5:	75 03                	jne    801dda <CheckWSWithoutLastIndex+0x12b>
			actualNumOfEmptyLocs++;
  801dd7:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  801dda:	ff 45 e0             	incl   -0x20(%ebp)
  801ddd:	a1 20 30 80 00       	mov    0x803020,%eax
  801de2:	8b 50 74             	mov    0x74(%eax),%edx
  801de5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801de8:	39 c2                	cmp    %eax,%edx
  801dea:	77 d1                	ja     801dbd <CheckWSWithoutLastIndex+0x10e>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  801dec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801def:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  801df2:	74 14                	je     801e08 <CheckWSWithoutLastIndex+0x159>
		panic(
  801df4:	83 ec 04             	sub    $0x4,%esp
  801df7:	68 30 26 80 00       	push   $0x802630
  801dfc:	6a 44                	push   $0x44
  801dfe:	68 d0 25 80 00       	push   $0x8025d0
  801e03:	e8 35 fe ff ff       	call   801c3d <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  801e08:	90                   	nop
  801e09:	c9                   	leave  
  801e0a:	c3                   	ret    
  801e0b:	90                   	nop

00801e0c <__udivdi3>:
  801e0c:	55                   	push   %ebp
  801e0d:	57                   	push   %edi
  801e0e:	56                   	push   %esi
  801e0f:	53                   	push   %ebx
  801e10:	83 ec 1c             	sub    $0x1c,%esp
  801e13:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801e17:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801e1b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801e1f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801e23:	89 ca                	mov    %ecx,%edx
  801e25:	89 f8                	mov    %edi,%eax
  801e27:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801e2b:	85 f6                	test   %esi,%esi
  801e2d:	75 2d                	jne    801e5c <__udivdi3+0x50>
  801e2f:	39 cf                	cmp    %ecx,%edi
  801e31:	77 65                	ja     801e98 <__udivdi3+0x8c>
  801e33:	89 fd                	mov    %edi,%ebp
  801e35:	85 ff                	test   %edi,%edi
  801e37:	75 0b                	jne    801e44 <__udivdi3+0x38>
  801e39:	b8 01 00 00 00       	mov    $0x1,%eax
  801e3e:	31 d2                	xor    %edx,%edx
  801e40:	f7 f7                	div    %edi
  801e42:	89 c5                	mov    %eax,%ebp
  801e44:	31 d2                	xor    %edx,%edx
  801e46:	89 c8                	mov    %ecx,%eax
  801e48:	f7 f5                	div    %ebp
  801e4a:	89 c1                	mov    %eax,%ecx
  801e4c:	89 d8                	mov    %ebx,%eax
  801e4e:	f7 f5                	div    %ebp
  801e50:	89 cf                	mov    %ecx,%edi
  801e52:	89 fa                	mov    %edi,%edx
  801e54:	83 c4 1c             	add    $0x1c,%esp
  801e57:	5b                   	pop    %ebx
  801e58:	5e                   	pop    %esi
  801e59:	5f                   	pop    %edi
  801e5a:	5d                   	pop    %ebp
  801e5b:	c3                   	ret    
  801e5c:	39 ce                	cmp    %ecx,%esi
  801e5e:	77 28                	ja     801e88 <__udivdi3+0x7c>
  801e60:	0f bd fe             	bsr    %esi,%edi
  801e63:	83 f7 1f             	xor    $0x1f,%edi
  801e66:	75 40                	jne    801ea8 <__udivdi3+0x9c>
  801e68:	39 ce                	cmp    %ecx,%esi
  801e6a:	72 0a                	jb     801e76 <__udivdi3+0x6a>
  801e6c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e70:	0f 87 9e 00 00 00    	ja     801f14 <__udivdi3+0x108>
  801e76:	b8 01 00 00 00       	mov    $0x1,%eax
  801e7b:	89 fa                	mov    %edi,%edx
  801e7d:	83 c4 1c             	add    $0x1c,%esp
  801e80:	5b                   	pop    %ebx
  801e81:	5e                   	pop    %esi
  801e82:	5f                   	pop    %edi
  801e83:	5d                   	pop    %ebp
  801e84:	c3                   	ret    
  801e85:	8d 76 00             	lea    0x0(%esi),%esi
  801e88:	31 ff                	xor    %edi,%edi
  801e8a:	31 c0                	xor    %eax,%eax
  801e8c:	89 fa                	mov    %edi,%edx
  801e8e:	83 c4 1c             	add    $0x1c,%esp
  801e91:	5b                   	pop    %ebx
  801e92:	5e                   	pop    %esi
  801e93:	5f                   	pop    %edi
  801e94:	5d                   	pop    %ebp
  801e95:	c3                   	ret    
  801e96:	66 90                	xchg   %ax,%ax
  801e98:	89 d8                	mov    %ebx,%eax
  801e9a:	f7 f7                	div    %edi
  801e9c:	31 ff                	xor    %edi,%edi
  801e9e:	89 fa                	mov    %edi,%edx
  801ea0:	83 c4 1c             	add    $0x1c,%esp
  801ea3:	5b                   	pop    %ebx
  801ea4:	5e                   	pop    %esi
  801ea5:	5f                   	pop    %edi
  801ea6:	5d                   	pop    %ebp
  801ea7:	c3                   	ret    
  801ea8:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ead:	89 eb                	mov    %ebp,%ebx
  801eaf:	29 fb                	sub    %edi,%ebx
  801eb1:	89 f9                	mov    %edi,%ecx
  801eb3:	d3 e6                	shl    %cl,%esi
  801eb5:	89 c5                	mov    %eax,%ebp
  801eb7:	88 d9                	mov    %bl,%cl
  801eb9:	d3 ed                	shr    %cl,%ebp
  801ebb:	89 e9                	mov    %ebp,%ecx
  801ebd:	09 f1                	or     %esi,%ecx
  801ebf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ec3:	89 f9                	mov    %edi,%ecx
  801ec5:	d3 e0                	shl    %cl,%eax
  801ec7:	89 c5                	mov    %eax,%ebp
  801ec9:	89 d6                	mov    %edx,%esi
  801ecb:	88 d9                	mov    %bl,%cl
  801ecd:	d3 ee                	shr    %cl,%esi
  801ecf:	89 f9                	mov    %edi,%ecx
  801ed1:	d3 e2                	shl    %cl,%edx
  801ed3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ed7:	88 d9                	mov    %bl,%cl
  801ed9:	d3 e8                	shr    %cl,%eax
  801edb:	09 c2                	or     %eax,%edx
  801edd:	89 d0                	mov    %edx,%eax
  801edf:	89 f2                	mov    %esi,%edx
  801ee1:	f7 74 24 0c          	divl   0xc(%esp)
  801ee5:	89 d6                	mov    %edx,%esi
  801ee7:	89 c3                	mov    %eax,%ebx
  801ee9:	f7 e5                	mul    %ebp
  801eeb:	39 d6                	cmp    %edx,%esi
  801eed:	72 19                	jb     801f08 <__udivdi3+0xfc>
  801eef:	74 0b                	je     801efc <__udivdi3+0xf0>
  801ef1:	89 d8                	mov    %ebx,%eax
  801ef3:	31 ff                	xor    %edi,%edi
  801ef5:	e9 58 ff ff ff       	jmp    801e52 <__udivdi3+0x46>
  801efa:	66 90                	xchg   %ax,%ax
  801efc:	8b 54 24 08          	mov    0x8(%esp),%edx
  801f00:	89 f9                	mov    %edi,%ecx
  801f02:	d3 e2                	shl    %cl,%edx
  801f04:	39 c2                	cmp    %eax,%edx
  801f06:	73 e9                	jae    801ef1 <__udivdi3+0xe5>
  801f08:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801f0b:	31 ff                	xor    %edi,%edi
  801f0d:	e9 40 ff ff ff       	jmp    801e52 <__udivdi3+0x46>
  801f12:	66 90                	xchg   %ax,%ax
  801f14:	31 c0                	xor    %eax,%eax
  801f16:	e9 37 ff ff ff       	jmp    801e52 <__udivdi3+0x46>
  801f1b:	90                   	nop

00801f1c <__umoddi3>:
  801f1c:	55                   	push   %ebp
  801f1d:	57                   	push   %edi
  801f1e:	56                   	push   %esi
  801f1f:	53                   	push   %ebx
  801f20:	83 ec 1c             	sub    $0x1c,%esp
  801f23:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801f27:	8b 74 24 34          	mov    0x34(%esp),%esi
  801f2b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801f2f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801f33:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801f37:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801f3b:	89 f3                	mov    %esi,%ebx
  801f3d:	89 fa                	mov    %edi,%edx
  801f3f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801f43:	89 34 24             	mov    %esi,(%esp)
  801f46:	85 c0                	test   %eax,%eax
  801f48:	75 1a                	jne    801f64 <__umoddi3+0x48>
  801f4a:	39 f7                	cmp    %esi,%edi
  801f4c:	0f 86 a2 00 00 00    	jbe    801ff4 <__umoddi3+0xd8>
  801f52:	89 c8                	mov    %ecx,%eax
  801f54:	89 f2                	mov    %esi,%edx
  801f56:	f7 f7                	div    %edi
  801f58:	89 d0                	mov    %edx,%eax
  801f5a:	31 d2                	xor    %edx,%edx
  801f5c:	83 c4 1c             	add    $0x1c,%esp
  801f5f:	5b                   	pop    %ebx
  801f60:	5e                   	pop    %esi
  801f61:	5f                   	pop    %edi
  801f62:	5d                   	pop    %ebp
  801f63:	c3                   	ret    
  801f64:	39 f0                	cmp    %esi,%eax
  801f66:	0f 87 ac 00 00 00    	ja     802018 <__umoddi3+0xfc>
  801f6c:	0f bd e8             	bsr    %eax,%ebp
  801f6f:	83 f5 1f             	xor    $0x1f,%ebp
  801f72:	0f 84 ac 00 00 00    	je     802024 <__umoddi3+0x108>
  801f78:	bf 20 00 00 00       	mov    $0x20,%edi
  801f7d:	29 ef                	sub    %ebp,%edi
  801f7f:	89 fe                	mov    %edi,%esi
  801f81:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f85:	89 e9                	mov    %ebp,%ecx
  801f87:	d3 e0                	shl    %cl,%eax
  801f89:	89 d7                	mov    %edx,%edi
  801f8b:	89 f1                	mov    %esi,%ecx
  801f8d:	d3 ef                	shr    %cl,%edi
  801f8f:	09 c7                	or     %eax,%edi
  801f91:	89 e9                	mov    %ebp,%ecx
  801f93:	d3 e2                	shl    %cl,%edx
  801f95:	89 14 24             	mov    %edx,(%esp)
  801f98:	89 d8                	mov    %ebx,%eax
  801f9a:	d3 e0                	shl    %cl,%eax
  801f9c:	89 c2                	mov    %eax,%edx
  801f9e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fa2:	d3 e0                	shl    %cl,%eax
  801fa4:	89 44 24 04          	mov    %eax,0x4(%esp)
  801fa8:	8b 44 24 08          	mov    0x8(%esp),%eax
  801fac:	89 f1                	mov    %esi,%ecx
  801fae:	d3 e8                	shr    %cl,%eax
  801fb0:	09 d0                	or     %edx,%eax
  801fb2:	d3 eb                	shr    %cl,%ebx
  801fb4:	89 da                	mov    %ebx,%edx
  801fb6:	f7 f7                	div    %edi
  801fb8:	89 d3                	mov    %edx,%ebx
  801fba:	f7 24 24             	mull   (%esp)
  801fbd:	89 c6                	mov    %eax,%esi
  801fbf:	89 d1                	mov    %edx,%ecx
  801fc1:	39 d3                	cmp    %edx,%ebx
  801fc3:	0f 82 87 00 00 00    	jb     802050 <__umoddi3+0x134>
  801fc9:	0f 84 91 00 00 00    	je     802060 <__umoddi3+0x144>
  801fcf:	8b 54 24 04          	mov    0x4(%esp),%edx
  801fd3:	29 f2                	sub    %esi,%edx
  801fd5:	19 cb                	sbb    %ecx,%ebx
  801fd7:	89 d8                	mov    %ebx,%eax
  801fd9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801fdd:	d3 e0                	shl    %cl,%eax
  801fdf:	89 e9                	mov    %ebp,%ecx
  801fe1:	d3 ea                	shr    %cl,%edx
  801fe3:	09 d0                	or     %edx,%eax
  801fe5:	89 e9                	mov    %ebp,%ecx
  801fe7:	d3 eb                	shr    %cl,%ebx
  801fe9:	89 da                	mov    %ebx,%edx
  801feb:	83 c4 1c             	add    $0x1c,%esp
  801fee:	5b                   	pop    %ebx
  801fef:	5e                   	pop    %esi
  801ff0:	5f                   	pop    %edi
  801ff1:	5d                   	pop    %ebp
  801ff2:	c3                   	ret    
  801ff3:	90                   	nop
  801ff4:	89 fd                	mov    %edi,%ebp
  801ff6:	85 ff                	test   %edi,%edi
  801ff8:	75 0b                	jne    802005 <__umoddi3+0xe9>
  801ffa:	b8 01 00 00 00       	mov    $0x1,%eax
  801fff:	31 d2                	xor    %edx,%edx
  802001:	f7 f7                	div    %edi
  802003:	89 c5                	mov    %eax,%ebp
  802005:	89 f0                	mov    %esi,%eax
  802007:	31 d2                	xor    %edx,%edx
  802009:	f7 f5                	div    %ebp
  80200b:	89 c8                	mov    %ecx,%eax
  80200d:	f7 f5                	div    %ebp
  80200f:	89 d0                	mov    %edx,%eax
  802011:	e9 44 ff ff ff       	jmp    801f5a <__umoddi3+0x3e>
  802016:	66 90                	xchg   %ax,%ax
  802018:	89 c8                	mov    %ecx,%eax
  80201a:	89 f2                	mov    %esi,%edx
  80201c:	83 c4 1c             	add    $0x1c,%esp
  80201f:	5b                   	pop    %ebx
  802020:	5e                   	pop    %esi
  802021:	5f                   	pop    %edi
  802022:	5d                   	pop    %ebp
  802023:	c3                   	ret    
  802024:	3b 04 24             	cmp    (%esp),%eax
  802027:	72 06                	jb     80202f <__umoddi3+0x113>
  802029:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80202d:	77 0f                	ja     80203e <__umoddi3+0x122>
  80202f:	89 f2                	mov    %esi,%edx
  802031:	29 f9                	sub    %edi,%ecx
  802033:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802037:	89 14 24             	mov    %edx,(%esp)
  80203a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80203e:	8b 44 24 04          	mov    0x4(%esp),%eax
  802042:	8b 14 24             	mov    (%esp),%edx
  802045:	83 c4 1c             	add    $0x1c,%esp
  802048:	5b                   	pop    %ebx
  802049:	5e                   	pop    %esi
  80204a:	5f                   	pop    %edi
  80204b:	5d                   	pop    %ebp
  80204c:	c3                   	ret    
  80204d:	8d 76 00             	lea    0x0(%esi),%esi
  802050:	2b 04 24             	sub    (%esp),%eax
  802053:	19 fa                	sbb    %edi,%edx
  802055:	89 d1                	mov    %edx,%ecx
  802057:	89 c6                	mov    %eax,%esi
  802059:	e9 71 ff ff ff       	jmp    801fcf <__umoddi3+0xb3>
  80205e:	66 90                	xchg   %ax,%ax
  802060:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802064:	72 ea                	jb     802050 <__umoddi3+0x134>
  802066:	89 d9                	mov    %ebx,%ecx
  802068:	e9 62 ff ff ff       	jmp    801fcf <__umoddi3+0xb3>
