ggplot(pew1, aes(x=reorder(group, -approval), y=approval)) + geom_col(fill = "coral", colour = "black") +
  theme(text=element_text(size=18, family="KerkisSans")) + labs(x="Religious Group", y="Percent Approving of Donald Trump",
title="Donald Trump Approval Rating",
subtitle="Do you approve or disapprove of the way Donald Trump is handling his job as President?",
caption="Data from Pew (April 17th, 2017)")
