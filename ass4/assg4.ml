(*
CSCI3180 Principles of Programming Languages
--- Declaration ---
I declare that the assignment here submitted is original except for source material explicitly acknowledged.
I also acknowledge that I am aware of University policy and regulations on honesty in academic work,
and of the disciplinary guidelines and procedures applicable to breaches of such policy and regulations,
as contained in the http://www.cuhk.edu.hk/policy/academichonesty/
Assignment 4
Name: KO Chi Keung
Student ID: 1155033234
Email Addr: ckko3@se.cuhk.edu.hk
*)

datatype 'a bTree = nil | bt of 'a bTree * 'a * 'a bTree;

val t = bt(bt(nil,74,nil),
           105,
           bt(bt(nil,109,nil),
              109,
              bt(nil,121,nil)
             )
          );

(* 3a. inorder *)
(* left -> root -> right *)
fun inorder(nil) = []
|   inorder(bt(left,root,right)) = inorder(left) @ [root] @ inorder(right);

(* 3b. preorder *)
(* root -> left -> right *)
fun preorder(nil) = []
|   preorder(bt(left,root,right)) = [root] @ preorder(left) @ preorder(right);

(* 3c. postorder *)
(* left -> right -> root *)
fun postorder(nil) = []
|   postorder(bt(left,root,right)) = postorder(left) @ postorder(right) @ [root];

(* 4a. symmetric *)
(* check a_i = a_n+1-i *)
fun symmetric(i,n,list) =
    let fun element(x,list) = if x = 1 then hd(list) else element(x-1,tl(list))
    in element(i,list) = element(n+1-i,list)
    end;

(* 4b. palindrome *)
(* check for all 1 <= i <= n, a_i = a_n+1-i *)
fun palindrome(n,list) =
    if n > 0 then symmetric(n,length(list),list) andalso palindrome(n-1,list) else true;

(* 4c. rev *)
(* reverse of list of any type *)
(* built-in functions not allowed *)
(*
fun rev(list) =
    if list = [] then [] else rev(tl(list)) @ [hd(list)];
*)

(*
fun rev(list) =
    let
      fun head(h::t) = h
      fun tail(h::t) = t
    in
      if list = [] then [] else rev(tail(list)) @ [head(list)]
    end;
*)

fun rev[] = []
|   rev(h::t) = (rev t) @ [h];
