public class ExpressionValidation{
   
    public ExpressionValidation(){
        Stack stack = new Stack();
        Boolean leftFound = false;
        Boolean rightFound = false;
        Boolean invalidExpression = false;
        
        //System.debug('#### size of stack ' + stack.size());
        
        String expression = '';
        //expression = '((a + (a + a)))';
        //expression = '( a + a )';
        //expression = '( a + ) a )';
        //expression = '( ( a + a ) + a )'; // ( b + a )
        //expression = '( a + a ) )';
        
        
        //expression = '( a + a )';
        expression = '( a ( a + a ) )';
         
        String[] symbolsList = expression.split(' ');
        System.debug('##### ' + symbolsList);
        try{
            for(String str : symbolsList){
                if(str == '('){
                    stack.push(str);
                }else if(str == ')'){
                    if(stack.size() != 0){
                        while(stack.peek() != '('){
                            stack.pop();
                        }
                        stack.pop();
                        stack.push('b');
                    }
                    else{
                        invalidExpression = true;
                        break;
                    }
                        
                }else{
                    if(str == 'a'){
                        if(stack.peek() == '(' || stack.peek() == '+'){
                            stack.push(str);
                        }else{
                            invalidExpression = true;
                            break;
                        }
                    }else if(str == '+'){
                        if(stack.peek() == 'a' || stack.peek() == 'b'){
                            stack.push(str);
                        }else{
                            invalidExpression = true;
                            break;
                        }
                    }
                }
            }
            
            if(stack.peek() == 'b')
                stack.pop();
        }catch(StackUnderflowException ex){
            invalidExpression = true;
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
                throw new StackUnderflowException();
            }
            
            return this.items.get(size() - 1);
        }    
    }
    public class StackUnderflowException extends Exception {
        /* Custom exception */
    }

}