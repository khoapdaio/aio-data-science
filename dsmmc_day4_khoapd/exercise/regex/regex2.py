import re

# bài 1


str = """
>Venues
>Marketing
>medalists
>Controversies
>Paralympics
>snowboarding
>[1]
>Netherlands
>[2]
>Norway
>[10]
>[11]
>References
>edit
>[12]
>Norway
>Germany
>Canada
>Netherlands
>Japan
>Italy
>Belarus
>China
>Slovakia
<$#%#$%
<#$#$$
<**&&^^
>Slovenia
>Belgium
>Spain
>Kazakhstan
>[15]
>1964
>1968
>1972
>1992
>1996
>2000"""

result1 = [line for line in str.split("\n") if re.findall(r'>', line)]
print(result1)

# bài 2
str = 'The advancements in biomarine studies franky@google.com with the investments necessary and Davos sinatra123@yahoo.com Then The New Yorker article on wind farms...'
# Type your answer here.

regex = r'[A-Za-z0-9._%+-]+@[A-Za-z0-9._%+-]+\.[A-Z|a-z]{2,7}'
emails = re.findall(regex, str)

print(emails)

# bài 3

str = 'The advancements in biomarine studies franky@google.com, with the investments necessary and Davos sinatra123@yahoo.com Then The New Yorker article on wind farms...'
# Type your answer here.

regex = r'[A-Za-z0-9._%+-]+@'
emails = re.findall(regex, str)

print(emails)


# bài 4
str='The advancements in biomarine studies franky@google.com, with the investments necessary and Davos sinatra123@yahoo.com Then The New Yorker article on wind farms...'
#Type your answer here.

regex= r'([^@\s]+)@'
emails=re.findall(regex, str)


print(emails)

#bài 5
str='''Au pays parfume que le soleil caresse,
J'ai connu, sous un dais d'arbres tout empourpres
Et de palmiers d'ou pleut sur les yeux la paresse,
Une dame creole aux charmes ignores.'''

#Type your answer here.

regex=r'[\w]{8}'
emails=re.findall(regex, str)


print(emails)


#bài 6
str='''Ancient Script 21299: The Takenouchi documents are the ancient historical records that have been secretly preserved and passed down from generation to generation by the Takenouchi family, the head of family being the chief priest of the Koso Kotai Jingu shrine. 212-111-5932 '''

#Type your answer here.

regex=r'212[\d]+'
data=re.findall(regex, str)


print(data)

#bài 7
str="""Some of the prices were as following TSLA:749.50, ORCL: 50.50, GE: 10.90, MSFT: 170.50, BIDU: 121.40. As the macroeconomic developments continue we will update the prices. """

#Type your answer here.

regex = r'[A-Z]{2,}'
data=re.findall(regex, str)


print(data)


#bài 8
str="""<div class="tut-list tut-list-new tut-row ">
<div class="tut-list-primary"> <div class="tut-vote">
<video>intro</video>
<span class="count">50</span> <span class="tut-upvotes-text hidden">Upvotes</span> </a> </div>
<center>k="11" rel="nofollow"></center>
<span class="tutorial-title-txt">Automate the Boring Stuff with Python</span>
<span class="tut-title-link">  <span class="js-tutorial" data-id="3529"
title="Automate the Boring Stuff with Python" target="_blank">(udemy.com)</span>
</span>  </a></div> <div class="action-footer">
<form class="save-tutorial-form" method="post" <button></button> </form>"""

#Type your answer here.

regex=r'<([^<^>^/\s]+)>'
data=re.findall(regex, str)


print(data)