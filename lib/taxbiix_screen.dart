import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'taxbiix_logic.dart';

class TaxbiixScreen extends StatelessWidget {
  const TaxbiixScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TaxbiixLogic>(
        builder: (context, taxbiixLogic, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  taxbiixLogic.getBackgroundColor(),
                  taxbiixLogic.getBackgroundColor().withOpacity(0.6),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  _buildAppBar(context, taxbiixLogic),
                  Expanded(
                    child: _buildMainContent(context, taxbiixLogic),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, TaxbiixLogic taxbiixLogic) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () => _showTaxbiixSettings(context, taxbiixLogic),
          ),
          const Text(
            'Taxbiix App',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: Icon(
              taxbiixLogic.isVibrating ? Icons.vibration : Icons.volume_up,
              color: Colors.white,
            ),
            onPressed: taxbiixLogic.toggleVibration,
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, TaxbiixLogic taxbiixLogic) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTaxbiixDisplay(taxbiixLogic),
        const SizedBox(height: 40),
        _buildCounter(taxbiixLogic),
        const SizedBox(height: 60),
        _buildIncrementButton(context, taxbiixLogic),
        const SizedBox(height: 20),
        _buildResetButton(taxbiixLogic),
      ],
    );
  }

  Widget _buildTaxbiixDisplay(TaxbiixLogic taxbiixLogic) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        taxbiixLogic.currentTaxbiix,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCounter(TaxbiixLogic taxbiixLogic) {
    return Text(
      '${taxbiixLogic.counter}',
      style: const TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildIncrementButton(
      BuildContext context, TaxbiixLogic taxbiixLogic) {
    return GestureDetector(
      onTap: () {
        taxbiixLogic.incrementCounter();
        if (taxbiixLogic.isVibrating) {
          HapticFeedback.mediumImpact();
        } else {
          SystemSound.play(SystemSoundType.click);
        }
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            Icons.add,
            size: 60,
            color: Colors.teal[700],
          ),
        ),
      ),
    );
  }

  Widget _buildResetButton(TaxbiixLogic taxbiixLogic) {
    return ElevatedButton(
      onPressed: taxbiixLogic.resetCounter,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.teal[700],
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: const Text('Dib u celi', style: TextStyle(fontSize: 18)),
    );
  }

  void _showTaxbiixSettings(BuildContext context, TaxbiixLogic taxbiixLogic) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Taxbiixooyinka'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                for (int i = 0; i < taxbiixLogic.taxbiixyo.length; i++)
                  ListTile(
                    title: Text(taxbiixLogic.taxbiixyo[i]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        taxbiixLogic.removeTaxbiix(i);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ElevatedButton(
                  child: const Text('Ku dar taxbiix cusub'),
                  onPressed: () => _addNewTaxbiix(context, taxbiixLogic),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addNewTaxbiix(BuildContext context, TaxbiixLogic taxbiixLogic) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ku dar taxbiix cusub'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Gali taxbiix cusub"),
          ),
          actions: [
            TextButton(
              child: const Text('Jooji'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ku dar'),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  taxbiixLogic.addTaxbiix(controller.text);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
