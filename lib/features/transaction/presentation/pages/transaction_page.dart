import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_pro_assignment/core/di/injection.dart';
import 'package:better_pro_assignment/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:better_pro_assignment/features/transaction/domain/domain.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TransactionBloc>()..add(const TransactionEvent.recoverPending()),
      child: const _TransactionView(),
    );
  }
}

class _TransactionView extends StatefulWidget {
  const _TransactionView();

  @override
  State<_TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<_TransactionView> {
  final TextEditingController _amountController = TextEditingController();
  Currency _selectedCurrency = Currency.USD;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Better Transaction')),
      body: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (transaction) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Transaction ${transaction.id.substring(0, 8)}... Success!'),
                  backgroundColor: Colors.green,
                ),
              );
              _amountController.clear();
            },
            failure: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: $message'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(loading: () => true, orElse: () => false);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter Amount',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          decoration: const InputDecoration(
                            labelText: 'Amount',
                            border: OutlineInputBorder(),
                            hintText: '0.00',
                          ),
                          enabled: !isLoading,
                          validator: (value) {
                            // Focus on handle Risk challenge
                            // Will add validator in real app
                            if (value == null || value.isEmpty) {
                              return 'Please enter an amount';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Invalid number';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      DropdownButton<Currency>(
                        value: _selectedCurrency,
                        items: Currency.values.map((Currency value) {
                          return DropdownMenuItem<Currency>(
                            value: value,
                            child: Text(value.code),
                          );
                        }).toList(),
                        onChanged: isLoading
                            ? null
                            : (newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _selectedCurrency = newValue;
                                  });
                                }
                              },
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<TransactionBloc>().add(
                                      TransactionEvent.submit(
                                        _amountController.text,
                                        _selectedCurrency,
                                      ),
                                    );
                              }
                            },
                      child: isLoading
                          ? const CircularProgressIndicator.adaptive()
                          : const Text('SUBMIT TRANSACTION'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
