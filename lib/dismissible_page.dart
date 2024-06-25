import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Um widget de página que pode ser dispensado deslizando em uma direção especificada.
/// 
/// Este widget envolve seu filho e fornece a capacidade de dispensar a página
/// com um gesto de deslizar. A direção do deslize pode ser configurada.
class DismissiblePage extends StatefulWidget {
  final Widget child;
  final VoidCallback onDismissed;
  final DismissDirection direction;

  /// Cria uma [DismissiblePage].
  /// 
  /// O [child] é o widget a ser exibido e dispensado.
  /// O callback [onDismissed] é chamado quando a página é dispensada.
  /// O [direction] especifica a direção na qual a página pode ser dispensada.
  const DismissiblePage({
    required this.child,
    required this.onDismissed,
    this.direction = DismissDirection.vertical,
  });

  @override
  _DismissiblePageState createState() => _DismissiblePageState();
}

class _DismissiblePageState extends State<DismissiblePage> {
  late Offset offset;
  late double scale;
  BorderRadiusGeometry borderRadius = BorderRadius.zero;

  @override
  void initState() {
    super.initState();
    offset = Offset.zero;
    scale = 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        // Atualiza o offset e a escala com base na direção do deslize e no movimento delta.
        if (widget.direction == DismissDirection.horizontal) {
          offset = Offset(offset.dx + details.delta.dx, 0);
        } else {
          offset += details.delta;
        }
        setState(() {
          scale = 1.0 - (offset.distance / (MediaQuery.of(context).size.height / 2));
          scale = scale.clamp(0.85, 1.0);
          borderRadius = BorderRadius.circular(120.0 * (1 - scale));
        });
      },
      onPanEnd: (details) {
        // Determina se deve dispensar a página ou redefinir o offset e a escala.
        if (scale < 0.9) {
          HapticFeedback.mediumImpact(); // Feedback tátil ao dispensar com sucesso
          widget.onDismissed();
        } else {
          setState(() {
            offset = Offset.zero;
            scale = 1.0;
            borderRadius = BorderRadius.zero;
          });
        }
      },
      child: Transform.translate(
        offset: offset,
        child: Transform.scale(
          scale: scale,
          child: ClipRRect(
            borderRadius: borderRadius,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}