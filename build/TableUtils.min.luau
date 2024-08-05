local a local b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u={function()local b,c,d=a(1)local e return(function(...)local f,g,h
={},d(c.types),d(c.modules)f.Types=g f.Array=h.Array f.Table=h.Table return f end)()end,function()local b,c,d=a(2)local
e return(function(...)end)()end,function()local b,c,d=a(3)local e return(function(...)return{Table=d(c.Parent.modules.
Table),Array=d(c.Parent.modules.Array)}end)()end,function()local b,c,d=a(4)local e return(function(...)local f,g={},d(c.
Parent.Parent.types)function f.isArray<V>(h:Types.Array<V>|Types.Table<any,V>):boolean if typeof(h)~='table'then return
false end for i in h::any do if typeof(i)~='number'then return false end end return true end function f.length<V>(h:
Types.Array<V>):number if not f.isArray(h)then error'Array.reverse called on non-array'end return#h end function f.
indexOf<V>(h:Types.Array<V>,i:V):number if not f.isArray(h)then error'Array.reverse called on non-array'end for j,k in
ipairs(h)do if k==i then return j end end return-1 end function f.reverse<V>(h:Types.Array<V>):Types.Array<V>if not f.
isArray(h)then error'Array.reverse called on non-array'end local i,j=1,#h while i<j do h[i],h[j]=h[j],h[i]i=i+1 j=j-1
end return h end function f.mergei<V>(...:Types.Array<V>):Types.Array<V>local h,i={...},{}for j,k in ipairs(h)do if not
f.isArray(k)then error'Array.mergei called on non-array 'end table.move(k,1,#k,#i+1,i)end return i end function f.map<V,
R>(h:Types.Array<V>,i:Types.mapCallbackFunc<V,R>):Types.Array<R>if not f.isArray(h)then error(string.format
'Array.map called on non-array')end if typeof(i)~='function'then error"Invalid usage: 'predicate' is not a function"end
local j={}for k,l in h do local m:R=i(k,l)if m~=nil then table.insert(j,m)end end return j end function f.reduce<V,U>(h:
Types.Array<V>,i:Types.reduceCallbackFunc<V,U>,j:U):U if not f.isArray(h)then error'Array.reduce called on non-array'end
local k=j for l,m in ipairs(h)do k=i(k,m,l)end return k end return f end)()end,function()local b,c,d=a(5)local e return(
function(...)local f,g,h,i={},(d(c.Parent.Parent.types))function h<K>(j:Types.Table<K,any>,k:any,l:Types.predicateFunc<K
,any>):Types.Table<K,any>local m={}for n,o in pairs(j)do m[n]=o if type(o)=='table'then m[n]=h(j,k,l)end if l(n,o)then m
[n]=k end end return m end function i<K,V>(j:Types.NestedTable<K,V>):Types.NestedTable<K,V>local k:Types.NestedTable<K,V
> ={}for l,m in pairs(j)do if typeof(m)=='table'then k[l]=i(m::Types.NestedTable<K,V>)else k[l]=m end end return k end
function f.keys<K,V>(j:Types.Table<K,V>):Types.Array<K>local k={}for l,m in pairs(j)do k[#k+1]=l end return k end
function f.merge<K,V>(...:Types.Table<K,V>):Types.Table<K,V>local j,k={},{...}for l,m in ipairs(k)do for n,o in pairs(m)
do j[n]=o end end return j end function f.deepMerge<K,V>(...:Types.NestedTable<K,V>):Types.NestedTable<K,V>local j:Types
.NestedTable<K,V> ={}local function k(l:Types.NestedTable<K,V>,m:Types.NestedTable<K,V>)for n,o in pairs(l)do if typeof(
o)=='table'and typeof(m[n])=='table'then k(o::Types.NestedTable<K,V>,m[n]::Types.NestedTable<K,V>)elseif typeof(o)==
'table'then m[n]=f.deepMerge(o::Types.NestedTable<K,V>)::V|Types.NestedTable<K,V>else m[n]=o end end end for l,m in
ipairs{...}do k(m,j)end return j end function f.filter<K,V>(j:Types.Table<K,V>,k:Types.predicateFunc<K,V>):Types.Array<V
>if typeof(k)~='function'then error"Invalid usage: 'predicate' is not a function"end local l={}for m,n in next,j do if
k(m,n)then l[#l+1]=n end end return l end function f.recursiveFind<K>(j:Types.Table<K,any>,k:any,l:Types.predicateFunc<K
,any>):Types.Table<K,any>return h(j,k,l)end function f.clone<K,V>(j:Types.NestedTable<K,V>):Types.NestedTable<K,V>return
i(j)end function f.shallowClone<K,V>(j:Types.Table<K,V>):Types.Table<K,V>local k:Types.Table<K,V> ={}for l,m in pairs(j)
do k[l]=m end return k end function f.find<K,V>(j:Types.Table<K,V>,k:Types.predicateFunc<K,V>):V?if typeof(k)~=
'function'then error"Invalid usage: 'predicate' is not a function"end for l,m in pairs(j)do if k(l,m)then return m end
end return nil end function f.some<K,V>(j:Types.Table<K,V>,k:Types.predicateFunc<K,V>):boolean if typeof(k)~='function'
then error"Invalid usage: 'predicate' is not a function"end for l,m in pairs(j)do if k(l,m)then return true end end
return false end function f.every<K,V>(j:Types.Table<K,V>,k:Types.predicateFunc<K,V>):boolean if typeof(k)~='function'
then error"Invalid usage: 'predicate' is not a function"end for l,m in pairs(j)do if not k(l,m)then return false end end
return true end function f.flatten<K,V>(j:Types.NestedTable<K,V>):Types.Array<V>local k:Types.Array<V> ={}local function
l(m:Types.NestedTable<K,V>)for n,o in pairs(m)do if typeof(o)=='table'then l(o::Types.NestedTable<K,V>)else table.
insert(k,o)end end end l(j)return k end function f.unique<V>(j:Types.Array<V>):Types.Array<V>local k:Types.Array<V>,l:
Types.Table<V,boolean> ={},{}for m,n in ipairs(j)do if not l[n]then l[n]=true table.insert(k,n)end end return k end
function f.chunk<V>(j:Types.Array<V>,k:number):Types.Array<Types.Array<V>>if k<=0 then error
'Chunk size must be greater than 0'end local l:Types.Array<Types.Array<V>>,m:Types.Array<V> ={},{}for n,o in ipairs(j)do
if(n-1)%k==0 and n>1 then table.insert(l,m)m={}end table.insert(m,o)end if#m>0 then table.insert(l,m)end return l end
return f end)()end,function()local b,c,d=a(6)local e return(function(...)local f={}export type Array<T> ={T}export type
Table<K,V> ={[K]:V}export type NestedTable<K,V> ={[K]:V|NestedTable<K,V>}export type predicateFunc<K,V> =(key:K,value:V
)->boolean export type mapCallbackFunc<T,U> =(index:number,value:T)->U export type reduceCallbackFunc<T,U> =(accumulator
:U,value:T,index:number)->U return f end)()end},{{1,2,{'Table'},{{3,2,{'modules'},{{5,2,{'Table'}},{4,2,{'Array'}}}},{2,
2,{'Dump'}},{6,2,{'types'}}}}},'0.4.1','WaxRuntime',string,task,setmetatable,error,next,table,unpack,coroutine,script,
type,require,pcall,tostring,tonumber,_VERSION local v,w,x,y,z,A,B=k.insert,k.remove,k.freeze or function(v)return v end,
m.wrap,f.sub,f.match,f.gmatch if t and z(t,1,4)=='Lune'then local C,D=q(p,'@lune/task')if C and D then g=D end end local
C=g and g.defer local D,E,F,G,H,I,J,K,L=C or function(D,...)y(D)(...)end,{[1]='Folder',[2]='ModuleScript',[3]='Script',[
4]='LocalScript',[5]='StringValue'},{},{},{},{},{},{},{}local M,N={GetFullName={{},function(M)local N,O=M.Name,M.Parent
while O do N=O.Name..'.'..N O=O.Parent end return N end},GetChildren={{},function(M)local N={}for O in j,L[M]do v(N,O)
end return N end},GetDescendants={{},function(M)local N={}for O in j,L[M]do v(N,O)for P,Q in j,O:GetDescendants()do v(N,
Q)end end return N end},FindFirstChild={{'string','boolean?'},function(M,N,O)local P=L[M]for Q in j,P do if Q.Name==N
then return Q end end if O then for R in j,P do return R:FindFirstChild(N,true)end end end},FindFirstAncestor={{'string'
},function(M,N)local O=M.Parent while O do if O.Name==N then return O end O=O.Parent end end},WaitForChild={{'string',
'number?'},function(M,N)return M:FindFirstChild(N)end}},{}for O,P in j,M do local Q,R,S=P[1],P[2],{}for T,U in j,Q do
local V,W=A(U,'^([^%?]+)(%??)')S[T]={V,W}end N[O]=function(V,...)if not L[V]then i(
"Expected ':' not '.' calling member function "..O,2)end local W={...}for X,Y in j,S do local Z=W[X]local _,aa,ab=o(Z),Y
[1],Y[2]if Z==nil and not ab then i('Argument '..Z..' missing or nil',3)end if aa~='any'and _~=aa and not(_=='nil'and ab
)then i('Argument '..X..' expects type "'..aa..'", got "'.._..'"',2)end end return R(V,...)end end local function aa(ab,
Q,R)local S,T=(h({},{__mode='k'}))local function U(V)i(V..' is not a valid (virtual) member of '..ab..' "'..Q..'"',3)end
local function V(W)i('Unable to assign (virtual) property '..W..'. Property is read only',3)end local W,X={},{}X.
__metatable=false X.__index=function(Y,Z)if Z=='ClassName'then return ab elseif Z=='Name'then return Q elseif Z==
'Parent'then return R elseif ab=='StringValue'and Z=='Value'then return T else local _=N[Z]if _ then return _ end end
for _ in j,S do if _.Name==Z then return _ end end U(Z)end X.__newindex=function(Y,Z,_)if Z=='ClassName'then V(Z)elseif
Z=='Name'then Q=_ elseif Z=='Parent'then if _==W then return end if R~=nil then L[R][W]=nil end R=_ if _~=nil then L[_][
W]=true end elseif ab=='StringValue'and Z=='Value'then T=_ else U(Z)end end X.__tostring=function()return Q end h(W,X)L[
W]=S if R~=nil then L[R][W]=true end return W end local function ab(Q,R)local S,T,U,V=Q[1],Q[2],Q[3],Q[4]local W=E[T]
local X=U and w(U,1)or W local Y=aa(W,X,R)F[S]=Y if U then for Z,_ in j,U do Y[Z]=_ end end if V then for Z,_ in j,V do
ab(_,Y)end end return Y end local Q=aa('Folder','['..e..']')for R,S in j,c do ab(S,Q)end for T,U in j,b do local V=F[T]G
[V]=U H[V]=T local W=V.ClassName if W=='LocalScript'or W=='Script'then v(J,V)end end local function V(W)local X,Y=W.
ClassName,I[W]if Y and X=='ModuleScript'then return l(Y)end local Z=G[W]local function _(ac)ac=r(ac)local ad,ae,af=W:
GetFullName(),A(ac,'[^:]+:(%d+): (.+)')if not ae or not u then return ad..':*: '..(af or ac)end ae=s(ae)local ag=H[W]
local ah=u[ag]local ai=ae-ah+1 if ai<0 then ai='?'end return ad..':'..ai..': '..af end if X=='LocalScript'or X=='Script'
then local ac,ad=q(Z)if not ac then i(_(ad),0)end else local ac={q(Z)}local ad=w(ac,1)if not ad then local ae=w(ac,1)i(
_(ae),0)end I[W]=ac return l(ac)end end function a(ac)local ad=F[ac]local function ae(af,...)local ag={q(af,...)}local
ah=w(ag,1)if not ah then i(ag[1],3)end return l(ag)end local af=x(h({},{__index=K,__newindex=function(af,ag,ah)K[ag]=ah
end,__len=function()return#K end,__iter=function()return j,K end}))local ag,ah=x{version=d,envname=e,shared=af,script=n,
require=p},ad local function ai(W,...)local X,Y,Z=o(W),'Attempted to call require with a non-ModuleScript',
'Attempted to call require with self'if X=='table'and L[W]then if W.ClassName~='ModuleScript'then i(Y,2)elseif W==ad
then i(Z,2)end return V(W)elseif X=='string'and z(W,1,1)~='@'then if#W==0 then i(
'Attempted to call require with empty string',2)end local _=ad if z(W,1,1)=='/'then _=Q elseif z(W,1,2)=='./'then W=z(W,
3)end local aj for ak in B(W,'([^/]*)/?')do local al=ak if ak=='..'then al='Parent'end if al~=''then local am=_:
FindFirstChild(al)if not am then local an=_.Parent if an then am=an:FindFirstChild(al)end end if am then _=am elseif ak
~=aj and ak~='init'and ak~='init.server'and ak~='init.client'then i('Virtual script path "'..W..'" not found',2)end end
aj=ak end if _.ClassName~='ModuleScript'then i(Y,2)elseif _==ad then i(Z,2)end return V(_)end return ae(p,W,...)end
return ag,ah,ai end for ac,ad in j,J do D(V,ad)end return V(Q:GetChildren()[1])