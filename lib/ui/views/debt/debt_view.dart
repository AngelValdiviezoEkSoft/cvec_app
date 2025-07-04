
import 'package:cve_app/config/config.dart';
import 'package:cve_app/domain/domain.dart';
import 'package:cve_app/infraestructure/infraestructure.dart';
import 'package:cve_app/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

String searchQueryDebt = '';
List<ItemBoton> filteredTransactionsDeb = [];
late TextEditingController searchDebTxt;
int idContrato = 0;
String nameContrato = '';
String namePlan = '';
String fechaInsc = '';

class DebtView extends StatefulWidget {
  //const DebtView(Key? key) : super (key: key);  

  const DebtView(Key? key) : super (key: key);
  
  @override
  DebtViewSt createState() => DebtViewSt();
}

class DebtViewSt extends State<DebtView> {

  @override
  void initState() {
    super.initState();
    searchQueryDebt = '';
    searchDebTxt = TextEditingController();
    filteredTransactionsDeb = [];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return FutureBuilder(
      future: DebsService().getDebts(),
      builder: (context, snapshot) {

        if(!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Image.asset(
                "assets/gifs/gif_carga.gif",
                height: size.width * 0.85,
                width: size.width * 0.85,
              ),
            ),
          );
        }
        else
        {  
          //
          if(snapshot.data != null && snapshot.data!.isNotEmpty) {

            idContrato = 0;
            nameContrato = '';
            namePlan = '';
            fechaInsc = '';

            List<Subscription> lstSubs = snapshot.data as List<Subscription>;
            List<Subscription> lstSubsResp = [];

            if(searchQueryDebt.isNotEmpty){
              
              for(int i = 0; i < lstSubs.length; i++){
                if(lstSubs[i].contractPlan.toLowerCase().contains(searchQueryDebt.toLowerCase())){
                  lstSubsResp.add(lstSubs[i]);
                }
              }

              lstSubs = [];
              lstSubs = lstSubsResp;
            }

            return Container(
                width: size.width,
                height: size.height * 0.85,
                color: Colors.transparent,
                child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: searchDebTxt,
                          decoration: InputDecoration(
                            hintText: locGen!.searchContPlanLbl,//'Buscar por plan del contrato',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            suffixIcon: IconButton(
                              onPressed: () {
                                
                                setState(() {                                      
                                  searchQueryDebt = '';
                                  searchDebTxt.text = searchQueryDebt;
                                });
                                
                              },
                              icon: const Icon(Icons.close, color: Colors.black,),
                            )
                          ),
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus();
                  
                            setState(() {
                              searchQueryDebt = searchDebTxt.text;
                            });
                            
                          },
                        ),
                      ),

                      SizedBox(height: size.height * 0.009,),
                      
                      Expanded(
                        child: ListView.builder(
                          itemCount: lstSubs.length,
                          itemBuilder: (context, index) {
                            final item = lstSubs[index];
                            
                            return GestureDetector(
                              onTap: () {
                                idContrato = item.contractId;
                                nameContrato = item.contractName;
                                namePlan = item.contractPlan;

                                DateTime dateQuote = DateTime.parse(item.contractInscriptionDate);
                                fechaInsc = DateFormat("dd/MM/yyyy").format(dateQuote);

                                context.push(objRutas.rutaDebsDetScrn);
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: size.width,
                                    color: Colors.grey[100],
                                    alignment: Alignment.center,
                                    //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: size.width * 0.85,
                                          height: size.height * 0.13,
                                          alignment: Alignment.centerRight,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          //alignment: Alignment.center,
                                          child: Container(
                                            width: size.width * 0.75,
                                            color: Colors.transparent,
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  color: Colors.transparent,
                                                  width: size.width * 0.42,
                                                  alignment: Alignment.centerLeft,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      
                                                      SizedBox(height: size.height * 0.019),

                                                      Text(item.contractName,
                                                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18, ), maxLines: 1, overflow: TextOverflow.ellipsis,
                                                      ),
                                                      
                                                      SizedBox(height: size.height * 0.005),
                                                      
                                                      Text(item.contractPlan, maxLines: 1,  overflow: TextOverflow.ellipsis,),
                                                      
                                                      SizedBox(height: size.height * 0.008),
                                                      
                                                      Text(DateFormat("dd/MM/yyyy").format(DateTime.parse(item.contractInscriptionDate)),style: const TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic,)),
                                                      
                                                    ],
                                                  ),
                                                ),
                              
                                                Container(
                                                  color: Colors.transparent,
                                                  width: size.width * 0.3,
                                                  alignment: Alignment.centerRight,
                                                  child: Text('\$${item.contractResidual.toStringAsFixed(2)}',
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w600, fontSize: 20)),
                                                ),
                              
                                                SizedBox(width: size.width * 0.0004),
                                              ],
                                            ),
                                          ),
                                        
                                        ),
                              
                                        SizedBox(height: size.height * 0.14,),
                                      
                                      ],
                                    ),
                                  ),
                              
                                  SizedBox(height: size.height * 0.04,),
                              
                                    
                                    // Ícono exterior al card
                                    Positioned(
                                      left: size.width * 0.028,//5,
                                      top: size.height * 0.042,
                                      child: const Stack(
                                        alignment: Alignment.topLeft,
                                        children: [
                                          CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Color(0xFF007AFF),
                                                child: Icon(Icons.notifications_none_outlined, //Icon(item['icon'] as IconData,
                                                    color: Colors.white),
                                              ),
                                          /*
                                              if (item['unread'] as bool)
                                                const Positioned(
                                                  left: -2,
                                                  top: -2,
                                                  child: Icon(Icons.circle,
                                                      size: 10, color: Colors.blue),
                                                )
                                        */
                                        ],
                                      ),
                                    ),
                                  
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
              );
              
          }
          
        }

        return Container(
              color: Colors.transparent,
              width: size.width,
              height: size.height * 0.78,
              alignment: Alignment.center,
              child: const Text("No hay datos"),
            );
      }
    );
    
  }

}