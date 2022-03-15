#include <iostream>
#include<string>
#include <stack>
using namespace std;
stack <char> s;
int getPriority(char c) //获取符号的优先级 
{
    switch (c)
    {
        case '+':
        case '-':
    return 1;
        case '*':
        case '/':
    return 2;
        case '%':
    return 3;
    case'#':
    default:
        return 0;
    }
}
bool judgePriority(char c1, char c2) //判断两个符号的优先级 
{
    if (getPriority(c1) > getPriority(c2))
    {
        return true;
    }
    else
    {
        return false;
    }
}

bool deleteBracket(stack<char>& s)
{
    stack<char> t;
    while (!s.empty() && s.top() != '(')//如果栈顶不是右括号
    {
        t.push(s.top());
        s.pop();
    }
    if (s.empty())//证明没有与右括号匹配的左括号
    {
        return false;
    }
    else if (s.top() == '(')//如果匹配上了左括号
    {
        s.pop();//弹出左括号
        while (!t.empty())//把（之上的元素压入栈
        {
            s.push(t.top());
            t.pop();
        }
        return true;
    }
}

string translate(string prefix)
{
    string result;
    s.push('#');
    for (int i = 0; i < prefix.length(); i++)
    {
        if (prefix[i] == '#')
        {
            break;
        }
        if (isalpha(prefix[i]) || isdigit(prefix[i]))//当前字符为字母或数字
        {
            result += prefix[i];
        }
        else if (prefix[i] == '(')//左括号，入栈
        {
            s.push(prefix[i]);
        }
        else if (prefix[i] == ')')//右括号，匹配左括号，都去掉
        {
            if (!deleteBracket(s))
            {
                return "error";
            }
        }
        else
        {
            if (judgePriority(prefix[i], s.top()))//若当前字符的优先级高于栈顶字符的优先级
            {
                s.push(prefix[i]);//入栈
            }
            else
            {
                while (!judgePriority(prefix[i], s.top()) && s.top() != '#'&& s.top() != '(')
                {
                    result += s.top();
                    s.pop();
                }
                s.push(prefix[i]);
            }
        }
    }
    while (!s.empty() && s.top() != '#')
    {
        result += s.top();
        s.pop();
    }
    return result;
}

int main()
{
    string s;
    while (true)
    {
        cout << "请输入需要转换的中缀表达式，输入0退出" << endl;
        cin >> s;
        if (s == "0")
        {
            break;
        }
        s += '#';
        string inversePolandexpression = translate(s);
        cout << "逆波兰表达式为"<<endl;
        cout << inversePolandexpression<<endl;
    }
}

