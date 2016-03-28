class CfgPatches {
    class AdvBanking_Server {
        requiredVersion = 0.1;
        requiredAddons[]=
        {
            "exile_client"
        };
        units[] = {};
        weapons[] = {};
    };
};
class CfgFunctions {
    class AdvBankingServer {
        class main {
            file="AdvBanking_Server\bootstrap";
            class preInit {
                preInit = 1;
            };
            class postInit {
                postInit = 1;
            };
        };
    };
};
