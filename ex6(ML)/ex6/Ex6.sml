(* Meital Birka
id:311124283
group:04
username: birkame*)

fun add x = x+1;
exception IllegalArgumentException;

fun rotate (ls,n) =
	if(n<0) then raise IllegalArgumentException
	else if ((n=0) orelse (List.null(ls)=true))then (ls)
	else let
			val headls= List.hd(ls)
			val restls= List.tl(ls)
			
		 in
		 rotate((List.rev(List.hd(ls)::List.rev(List.tl(ls)))),n-1) 
		 end;
;

fun helpSplit ([],_)=([],[])
 |	helpSplit(x::tl,num)=
		let 
			val (r,l) = helpSplit (tl,num+1);
			val n =num+1;
		in
		if((n mod 2) = 0) then (r, x::l) else (x::r, l)
		end;
;
fun split [] = ([], [])
      | split (x::tl) =
	 helpSplit(x::tl,0); 
	
		
		
		
fun merge (ls1,[])= ls1
		|merge ([],ls2)= ls2
		|merge (x1::tlLs1,x2::tlLs2)=
		if (x1<x2) then x1::merge(tlLs1,x2::tlLs2)
		else x2::merge(x1::tlLs1,tlLs2);;


		
fun sort  [] = []
|	sort [a] = [a]
|   sort [a,b] =	if a <= b then
							[a,b]
						else [b,a]
|   sort ls =
        let val (M,N) = split ls
        in
          merge (sort M, sort N)
        end

(*fun allcons (num, ls )=
	let
	var x=List.t1(ls)
	in
	merge(num,
	end
;

(define (comb m lst)
  (cond ((= m 0) '(()))
        ((null? lst) '())
        (else (append (map (lambda (y) (cons (car lst) y))
                           (comb (- m 1) (cdr lst)))
                      (comb m (cdr lst))))))

*)
fun comb (num:int, ls:int list,ansList:int list list)=
	if (num=0) then []
	else if (List.length(ls)=0) then []
	else (List.hd(ls)::comb(num-1,List.tl(ls),ansList))@comb(num,List.tl(ls),ansList)
	
	
fun beforeNumList(ls,num:int,ansList)=
	let
		val x= List.hd(ls)
		in
	if( (List.length(ls))=0) then ansList	
	else if (num=x) then ansList
	else beforeNumList(List.tl(ls),num,x::ansList)
	end
	;
fun afterNumList(ls,num,ansList)=
	let
		val rev=List.rev(ls)
	in
	 beforeNumList(rev,num,ansList)
	 end
fun ListNoNum(ls,num,ansList)=
List.rev(beforeNumList(ls,num,ansList))@afterNumList(ls,num,ansList)	
	
	
fun helpChoose ([],numOfIteration,ansList,originalLength)=[] 
	|helpChoose (x::ls,numOfIteration,ansList,originalLength)=
	let
		val numNOThere=ListNoNum(x::ls,x,[])
	in
	if (numOfIteration=0) then
				if(List.length(List.rev(ansList))=originalLength) then[List.rev(ansList)]
				else []
	else if (List.length(numNOThere)=0) then 
				if(List.length(List.rev(x::ansList))=originalLength) then[List.rev(x::ansList)]
				else []
	else (helpChoose(numNOThere,numOfIteration-1,x::ansList,originalLength)
	@helpChoose(numNOThere,numOfIteration,ansList,originalLength))
	end;
	
	
	
fun choose (k,ls)=
	if(k<0) then raise IllegalArgumentException
	else if (k> List.length(ls)) then []
	else if (k=List.length(ls)) then[ls]
	else helpChoose(ls,k,[],k);
	
	
fun explodeString (str:string)=
		explode str;

fun	helpisPolindrom (h1::t1:char list,h2::t2:char list,n ) = 
	if (n=0) then true
		else if ( h1 = h2 ) then helpisPolindrom( t1, t2, n - 1)
		else  false
			|helpisPolindrom (_,[],n) = false
			|helpisPolindrom ([],_,n) =false;
fun  isPolindrom  (s:string) =
				let
					val es= explodeString (s);
					val hdes=List.hd(es);
					val tles=List.tl(es);
					val res =rev es;
					val reshd=List.hd(res);
					val restl=List.tl(res);
					(*val r= List.length( res);*)
					val k = List.length(es) div 2;
				in
					(*isPolindrom (tles, restl, k)*)
				helpisPolindrom(tles,restl,k)					
			end

datatype Arguments = IntPair of int * int
					 | RealTriple of real * real * real
					 | StringSingle of string;
					 
datatype OutputArgs = IntNum of int | RealNum of real | Str of string;	
		
fun multiFunc (IntPair(x,y)):OutputArgs=IntNum(x*y)
	|multiFunc(RealTriple(x,y,z)):OutputArgs =RealNum((x+y+z)/3.0)
	|multiFunc(StringSingle(x)):OutputArgs =Str(implode(List.rev(explode(x))));

		
datatype Square = Alive of int | Dead of int;
datatype GameStatus = Extinct | OnGoing;
type LifeState = Square list list * GameStatus;

fun getXFromPair(x:int,y:int)=x;
fun getYFromPair(x:int,y:int)=y;

fun helpCreateOnLineGrid2 (lengthLine:int,numOfLine:int, lives:(int*int) list,xCounter:int,yCounter:int,allList)=
	if(yCounter=lengthLine) then []
	else
	if(List.length(lives)=0) then Dead(0)::helpCreateOnLineGrid2(lengthLine,numOfLine,allList,xCounter,yCounter+1,allList)
	else
	let
		val currentInLiveList = List.hd(lives)
		val mycurrentX=getXFromPair(currentInLiveList)
		val mycurrentY=getYFromPair(currentInLiveList)
	in
		if (yCounter=lengthLine) then []
		else
			if(List.length(lives) =0) then Dead(0)::helpCreateOnLineGrid2(lengthLine,numOfLine,allList,xCounter,yCounter+1,allList)
				else if(xCounter=mycurrentX) then
						if(yCounter=mycurrentY) then Alive(0)::helpCreateOnLineGrid2(lengthLine,numOfLine,List.tl(lives),xCounter,yCounter+1,allList)
						else helpCreateOnLineGrid2(lengthLine,numOfLine,List.tl(lives),xCounter,yCounter,allList)
				else helpCreateOnLineGrid2(lengthLine,numOfLine,List.tl(lives),xCounter,yCounter,allList)
				
	end;


fun helpCreateOnLineGrid(lengthLine:int,numOfLine:int, lives:(int*int) list,xCounter:int,yCounter:int)=
	if (yCounter=lengthLine) then []
			else
	if (List.length(lives) =0) then Dead(0)::helpCreateOnLineGrid(lengthLine,numOfLine,lives,xCounter,yCounter+1)
	else
	let
		val currentInLiveList = List.hd(lives)
		val mycurrentX=getXFromPair(currentInLiveList)
		val mycurrentY=getYFromPair(currentInLiveList)
	in
			if (yCounter=lengthLine) then []
			else
				if((List.length(lives) =0)orelse (mycurrentX>xCounter)) then Dead(0)::helpCreateOnLineGrid(lengthLine,numOfLine,lives,xCounter,yCounter+1)
				else if(xCounter>mycurrentX) then helpCreateOnLineGrid(lengthLine,numOfLine,List.tl(lives),xCounter,yCounter)
				else if(xCounter=mycurrentX) then
						if(yCounter=mycurrentY) then Alive(0)::helpCreateOnLineGrid(lengthLine,numOfLine,List.tl(lives),xCounter,yCounter+1)
						else Dead(0)::helpCreateOnLineGrid(lengthLine,numOfLine,lives,xCounter,yCounter+1)
				else helpCreateOnLineGrid(lengthLine,numOfLine,List.tl(lives),xCounter,yCounter)
				
	end;

fun helpCreateAllGrid(lengthLine:int,numOfLine:int,	lives:(int*int) list,xCounter:int,yCounter:int)=
	if(numOfLine>lengthLine-1)then []
	else (helpCreateOnLineGrid2(lengthLine,numOfLine,lives,xCounter,yCounter,lives))
	::(helpCreateAllGrid(lengthLine,numOfLine+1,lives,xCounter+1,0));
		
fun createLifeGrid(0,_) =raise  IllegalArgumentException
|createLifeGrid (n:int,lives:(int*int) list):Square list list=
if(n<0) then raise IllegalArgumentException
else
 helpCreateAllGrid(n,0,lives,0,0)
  ;
 
 fun checkOneNode(Alive(x))= true
	|checkOneNode(Dead(x))= false;
	
fun updateOneNode(Alive(x))= Alive(x+1)
	|updateOneNode(Dead(x))=Dead(x+1);
	
 fun checkLiveOneLine(line:Square list)=
	let 
	val currentNode= List.hd(line)
	val rest=List.tl(line)
	in
	if (checkOneNode(currentNode)=true)
		then true
		else if(List.length(rest)=0) then false
		else checkLiveOneLine(rest)
	end;
	
fun checkLiveAllGrid(grid:Square list list)=
	let
		val currentLine=List.hd(grid);
		val restLines= List.tl(grid)
	in
		if (checkLiveOneLine(currentLine)=true) then true
		else if(List.length(restLines)=0) then false
		else checkLiveAllGrid(restLines)
	end;
fun determineStatusOf[]= raise IllegalArgumentException
 |determineStatusOf(grid:Square list list)=
	if(checkLiveAllGrid(grid)=true) then OnGoing
	else Extinct;
	
fun helpgetSquare(	ySquare:int,gridcurrentLine:Square list,currentY)=(*return Square*)
	let
		val currentNode= List.hd(gridcurrentLine)
		val restNodes= List.tl(gridcurrentLine)
	in
		if (ySquare=currentY) then currentNode
		else helpgetSquare(ySquare,restNodes,currentY+1)
	end;
	
	
fun getSquare(xSquare:int,ySquare:int,grid:Square list list,currentLine:int)=
	let
		val myLine=List.hd(grid)
		val restLines=List.tl(grid)
	in
		if(xSquare=currentLine) then  helpgetSquare(ySquare,myLine,0)
		else getSquare(xSquare,ySquare,restLines,currentLine+1)
	end;
	
fun newStateOneNode	(xcounter:int,ycounter:int,grid:Square list list,
													numNeighborToCheck:int,sumALive:int,lenghtGrid:int)=
	if(numNeighborToCheck=0) then (*chceck left up*)
		if ((xcounter>0)andalso(ycounter>0)) then (*if the neighbor exist*)
			if (checkOneNode(getSquare(xcounter-1,ycounter-1,grid,0))=true) then (*if he alive*)
				newStateOneNode	(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive+1,lenghtGrid)
			else newStateOneNode(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive,lenghtGrid)(*if he dead*)
		else newStateOneNode(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive,lenghtGrid)(*if the neighbor  NOT exist*)
	
	else if (numNeighborToCheck=1) then (*check up*)
		if (xcounter>0) then (*if the neighbor exist*)
			if (checkOneNode(getSquare(xcounter-1,ycounter,grid,0))=true) then (*if he alive*)
				newStateOneNode	(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive+1,lenghtGrid)
			else newStateOneNode(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive,lenghtGrid)(*if he dead*)
		else newStateOneNode(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive,lenghtGrid)(*if the neighbor  NOT exist*)
	
	else if (numNeighborToCheck=2) then (*check right up*)
		if ((xcounter>0)andalso(ycounter+1< lenghtGrid))then (*if the neighbor exist*)
			if (checkOneNode(getSquare(xcounter-1,ycounter+1,grid,0))=true) then (*if he alive*)
				newStateOneNode	(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive+1,lenghtGrid)
			else newStateOneNode(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive,lenghtGrid)(*if he dead*)
		else newStateOneNode(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive,lenghtGrid)(*if the neighbor  NOT exist*)
	
	else if(numNeighborToCheck=3)then (*check left*)
		if (ycounter>0)then (*if the neighbor exist*)
			if(checkOneNode(getSquare(xcounter,ycounter-1,grid,0))=true) then (*if he alive*)
				newStateOneNode	(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive+1,lenghtGrid)
			else newStateOneNode(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive,lenghtGrid)(*if he dead*)
		else newStateOneNode(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive,lenghtGrid)(*if the neighbor  NOT exist*)
	
	else if(numNeighborToCheck=4)then (*check right*)
		if (ycounter+1<lenghtGrid)then (*if the neighbor exist*)
			if(checkOneNode(getSquare(xcounter,ycounter+1,grid,0))=true) then (*if he alive*)
				newStateOneNode	(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive+1,lenghtGrid)
			else newStateOneNode(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive,lenghtGrid)(*if he dead*)
		else newStateOneNode(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive,lenghtGrid)(*if the neighbor  NOT exist*)
	
	else if(numNeighborToCheck=5)then (*check left down*)
		if ((xcounter+1<lenghtGrid)andalso(ycounter>0))then (*if the neighbor exist*)
			if(checkOneNode(getSquare(xcounter+1,ycounter-1,grid,0))=true) then (*if he alive*)
				newStateOneNode	(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive+1,lenghtGrid)
			else newStateOneNode(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive,lenghtGrid)(*if he dead*)
		else newStateOneNode(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive,lenghtGrid)(*if the neighbor  NOT exist*)
	
	else if(numNeighborToCheck=6)then (*check  down*)
		if (xcounter+1<lenghtGrid)then (*if the neighbor exist*)
			if(checkOneNode(getSquare(xcounter+1,ycounter,grid,0))=true) then (*if he alive*)
				newStateOneNode	(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive+1,lenghtGrid)
			else newStateOneNode(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive,lenghtGrid)(*if he dead*)
		else newStateOneNode(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive,lenghtGrid)(*if the neighbor  NOT exist*)
	
	else if(numNeighborToCheck=7)then (*check right down*)
		if ((xcounter+1<lenghtGrid)andalso(ycounter+1<lenghtGrid))then (*if the neighbor exist*)
			if(checkOneNode(getSquare(xcounter+1,ycounter+1,grid,0))=true) then (*if he alive*)
				newStateOneNode	(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive+1,lenghtGrid)
			else newStateOneNode(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive,lenghtGrid)(*if he dead*)
		else newStateOneNode(xcounter,ycounter,grid,numNeighborToCheck+1,sumALive,lenghtGrid)(*if the neighbor  NOT exist*)
	
	else if(numNeighborToCheck=8) then sumALive
	else 99
	
	
	
fun chekLineNextGen(numOfLine:int,numOfNode:int,lengthGrid:int,
						line:Square list,grid:Square list list):Square list=
	if(numOfNode=lengthGrid) then []
	else
		let
			val currentNode=List.hd(line)
			val restNode=List.tl(line)
			val numOfNeighbors= newStateOneNode(numOfLine,numOfNode,grid,0,0,lengthGrid)
		in
		if(numOfNode=lengthGrid) then []
		else
			if( checkOneNode(currentNode)=true) then(*is alive*)
				if((numOfNeighbors<2)orelse(numOfNeighbors>3)) then Dead(0)::chekLineNextGen(numOfLine,numOfNode+1,lengthGrid,restNode,grid)
				else updateOneNode(currentNode)::chekLineNextGen(numOfLine,numOfNode+1,lengthGrid,restNode,grid)
			else if(numOfNeighbors=3) then Alive(0)::chekLineNextGen(numOfLine,numOfNode+1,lengthGrid,restNode,grid)
			else updateOneNode(currentNode)::chekLineNextGen(numOfLine,numOfNode+1,lengthGrid,restNode,grid)
		
		
		end;
fun allLinesNextGen(numOfLine:int,lengthGrid:int,allLines :Square list list,grid:Square list list)=
	if(numOfLine=lengthGrid) then []
	else 
		let
			val myLine=List.hd(allLines)
			val restLines=List.tl(allLines)
		in
	chekLineNextGen(numOfLine,0,lengthGrid,
						myLine,grid)::allLinesNextGen(numOfLine+1,lengthGrid,
						restLines,grid)
		end;
fun nextGeneration []= raise IllegalArgumentException
	|nextGeneration (grid:Square list list)=
	
	allLinesNextGen(0,List.length(grid),grid,grid);
 

fun determineNState((mysquare ,mystatus):LifeState,n:int)=
	if(n=0) then (mysquare,mystatus):LifeState
	else 
	let
		val nextGen=nextGeneration(mysquare)
		val curentstatus=determineStatusOf(nextGen)
	in
		if(curentstatus =Extinct) then (nextGen,curentstatus):LifeState
		else determineNState((nextGen,curentstatus):LifeState,n-1)
		end;
	(*(mysquare,mystatus):LifeState;*)

datatype 'a Seq = Cons of 'a * (unit -> 'a Seq) | Nil;
fun head (Cons(x,_)) = x 
		| head Nil = raise IllegalArgumentException
		;
fun tail (Cons(_,t)) = t () 
		|tail Nil = raise IllegalArgumentException
		;
fun  take (0, _) = [] 
 |	    take (n, Nil) = raise IllegalArgumentException
 |		take (n, Cons(h, t)) = h :: (take(n-1, t()));


fun upF(u,f:'a->'a)=
Cons(u, fn()=>upF(f(u),f));
 
(use"test.sml")