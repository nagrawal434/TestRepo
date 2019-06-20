public class ExpressionValidation1{
   
    public ExpressionValidation1(){
        Stack stack = new Stack();
        Boolean invalidExpression = false;
        
        //System.debug('#### size of stack ' + stack.size());
        
        String expression = '( a + a + ( a + ( ) ) )'; 
        //expression = '( a + a )'; //pass -valid
        //expression = '( a + ) a )'; //pass - invalid
        //expression = '( ( a + a ) + a )'; //pass - valid
        //expression = '( a + a ) )'; //pass - invalid
        //expression = '( a ( a + a ) )'; //pass-invalid
        //expression = '( ( a + ( a + a ) ) )'; //pass -valid
        //expression = '( ( a + a ) + ( a + a ) ) )'; // pass - invalid
        //expression = '( ( ( a + ( a ( a + a ) ) ) ) )'; // pass - invalid
        //expression = '( a + a ) ) )'; //pass-invalid
        //expression = '( a + a + a )'; //pass - valid
        //expression = '( ( a + + a + a ) )'; //pass - invalid
        
        String[] symbolsList = expression.split(' ');
        System.debug('##### ' + symbolsList);
        try{
            for(String str : symbolsList){
                //System.debug('@@@@@' + stack.items);
                if(str == '('){
                    if(stack.peek() != 'a' || stack.peek() != 'b')
                        stack.push(str);
                    else{
                        System.debug('###(');
                        invalidExpression = true;
                        break;
                    }
                        
                }else if(str == ')'){
                    if(stack.size() != 0 && stack.peek() != '+'){
                        while(stack.peek() != '('){
                            stack.pop();
                        }
                        stack.pop();
                        if(stack.peek() != 'a')
                            stack.push('b');
                        else{
                            System.debug('###)');
                            invalidExpression = true;
                            break;
                        }
                    }
                    else{
                        System.debug('###)');
                        invalidExpression = true;
                        break;
                    }
                        
                }else{
                    if(str == 'a'){
                        if(stack.peek() == '(' || stack.peek() == '+'){
                            stack.push(str);
                        }else{
                            System.debug('###a');
                            invalidExpression = true;
                            break;
                        }
                    }else if(str == '+'){
                        if(stack.peek() == 'a' || stack.peek() == 'b'){
                            stack.push(str);
                        }else{
                            System.debug('###+');
                            invalidExpression = true;
                            break;
                        }
                    }
                }
            }
            
            if(stack.peek() == 'b'){
                System.debug('###b');
                stack.pop();
            }
        }catch(StackUnderflowException ex){
            invalidExpression = true;
            System.debug('###catch');
        }
        
        
            
        if(!invalidExpression){
            if(stack.size() == 0)
                System.debug('expression is valid');
            else 
                System.debug('expression is invalid');
        }else
            System.debug('is invalid expression ' + invalidExpression );
            
        System.debug('#### size of stack ' + stack.size());
        System.debug('##### ' + stack.items); 
    }


    public class Stack {
        public List<Object> items {get; set;}
        
        public Stack() {
            this.items = new List<Object>();
        }
        
        public Integer size() {
            return this.items.size();
        }
    
        public Boolean isEmpty() {
            return size() == 0;
        }
            
        public void push(Object itemToPush) {
            this.items.add(itemToPush);
        }
        
        public Object pop() {
            if (isEmpty()) {
                throw new StackUnderflowException();
            }
            
            return this.items.remove(size() - 1);
        }
        
        public Object peek() {
            if (isEmpty()) {
                return size();
            }
            
            return this.items.get(size() - 1);
        }    
    }
    public class StackUnderflowException extends Exception {
        /* Custom exception */
    }

}