page 50302 TestPageForLayout
{
    ApplicationArea = All;
    Caption = 'PageForLayoutTest';
    PageType = Card;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(group1)
            {
                Caption = 'group1';

            }
            group(group2)
            {
                Caption = 'group2';

            }
            grid(superGrid)
            {
                grid(grid1)
                {
                    grid(grid1subgrid1)
                    {
                        cuegroup(grid1subgrid1cg1)
                        {
                            Caption = 'cuegroup1';
                            ShowCaption = true;
                            actions
                            {
                                action(grid1subgrid1cg1a1)
                                {
                                }
                                action(cg1a2)
                                {
                                }
                            }
                        }
                    }
                    grid(grid1subgrid2)
                    {
                        cuegroup(grid1subgrid2cg2)
                        {
                            Caption = 'cuegroup2';
                            ShowCaption = true;
                            actions
                            {
                                action(grid1subgrid2cg2a1)
                                {
                                }
                            }
                        }
                    }
                }
                grid(grid2)
                {
                    cuegroup(cg2)
                    {
                        actions
                        {
                            action(cg2a1)
                            {
                            }
                            action(cg2a2)
                            {
                            }
                            action(cg2a3)
                            {
                            }
                        }
                    }
                }
                grid(grid3)
                {
                    cuegroup(cg3)
                    {
                        actions
                        {
                            action(cg3a1)
                            {
                            }
                        }
                    }
                }
            }
            part(x; "Entity Text Part")
            { }
        }
    }

    var
        l1: Label 'grid1Label';
        l2: Label 'grid2Label';
}
