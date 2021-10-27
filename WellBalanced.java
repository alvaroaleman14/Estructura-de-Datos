package wellBalanced;
import dataStructures.stack.*;

public class WellBalanced {
	private final static String OPEN_PARENTHESES =  "{[(";
	private final static String CLOSE_PARENTHESES = "}])";
	
	public static void main (String [] args) {
		String cadena = "vv(hg(jij)hags{ss[dd]dd})";
		Stack <Character> stack = new LinkedStack<>();
		if (wellBalanced (cadena,stack) == true) {
			System.out.println("La cadena está equilibrada");
		}else {
			System.out.println("La cadena no esta equilibrada");
		}
	}
	
	public static boolean wellBalanced (String exp, Stack <Character> stack) {
		for (int i = 0; i < exp.length();i++) {
			char c = exp.charAt(i);
			if (isOpenParentheses(c)) {
				stack.push(c);
			}
			if (isClosedParentheses(c) && match(c,stack.top())) {
				stack.pop();
			}
		}
		if (stack.isEmpty()) {
			return true;
		}else {
			return false;
		}
		
	}
	
	public static boolean isOpenParentheses (char c) {
		return OPEN_PARENTHESES.indexOf(new Character(c).toString()) >= 0;
	}
	
	public static boolean isClosedParentheses(char c) {
		 return CLOSE_PARENTHESES.indexOf(new Character(c).toString()) >= 0;
	}
	
	public static boolean match(char x, char y) {
		 return OPEN_PARENTHESES.indexOf(new Character(x).toString()) ==
		CLOSE_PARENTHESES.indexOf(new Character(y).toString());
	}

}
