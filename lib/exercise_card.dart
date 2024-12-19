import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExerciseCard extends StatefulWidget {
  final String exerciseName;
  final int sets;
  final int reps;
  final double weight;
  final Function(ExerciseCard) onDelete;
  final Function(ExerciseCard, String, int, int, double) onEdit;

  ExerciseCard({
    required this.exerciseName,
    required this.sets,
    required this.reps,
    required this.weight,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  _ExerciseCardState createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  late TextEditingController _nameController;
  late TextEditingController _setsController;
  late TextEditingController _repsController;
  late TextEditingController _weightController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.exerciseName);
    _setsController = TextEditingController(text: widget.sets.toString());
    _repsController = TextEditingController(text: widget.reps.toString());
    _weightController = TextEditingController(text: widget.weight.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _setsController.dispose();
    _repsController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    widget.onEdit(
      widget,
      _nameController.text,
      int.tryParse(_setsController.text) ?? widget.sets,
      int.tryParse(_repsController.text) ?? widget.reps,
      double.tryParse(_weightController.text) ?? widget.weight,
    );
    _toggleEdit();
  }

  @override
  Widget build(BuildContext context) {
    double suggestedWeight = double.parse(_weightController.text) + 5;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _isEditing
                    ? Expanded(
                  child: TextField(
                    controller: _nameController,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                  ),
                )
                    : Text(
                  _nameController.text,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: FaIcon(_isEditing ? FontAwesomeIcons.xmark : FontAwesomeIcons.penToSquare, color: Colors.blue),
                      onPressed: _toggleEdit,
                    ),
                    if (!_isEditing)
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.trashCan, color: Colors.red),
                        onPressed: () => widget.onDelete(widget),
                      ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatColumn('Sets', _setsController, _isEditing, FontAwesomeIcons.layerGroup),
                _buildStatColumn('Reps', _repsController, _isEditing, FontAwesomeIcons.repeat),
                _buildStatColumn('Weight', _weightController, _isEditing, FontAwesomeIcons.weightHanging, suffix: ' kg'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                FaIcon(FontAwesomeIcons.lightbulb, size: 16, color: Colors.amber),
                SizedBox(width: 8),
                Text(
                  'Suggested weight: ${suggestedWeight.toStringAsFixed(1)} kg',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600], fontStyle: FontStyle.italic),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (_isEditing)
              ElevatedButton.icon(
                onPressed: _saveChanges,
                icon: FaIcon(FontAwesomeIcons.floppyDisk, size: 18),
                label: Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              )
            else
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    double currentWeight = double.tryParse(_weightController.text) ?? widget.weight;
                    _weightController.text = (currentWeight + 2.5).toStringAsFixed(1);
                  });
                },
                icon: FaIcon(FontAwesomeIcons.weightScale, size: 18),
                label: Text('Increase Weight'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, TextEditingController controller, bool isEditing, IconData icon, {String suffix = ''}) {
    return Column(
      children: [
        FaIcon(icon, size: 20, color: Colors.grey[600]),
        SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey[600], fontSize: 16)),
        SizedBox(height: 8),
        isEditing
            ? SizedBox(
          width: 80,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            ),
          ),
        )
            : Text(
          controller.text + suffix,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}