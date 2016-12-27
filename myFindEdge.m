function [ sOut, tOut ] = myFindEdge( G, s, t )
%myFindEdge znajduje w grafie G krawêdzi skierowane s -> t jeœli s¹
%   funkcja potrzebna z powodu b³êdnego dzi³ania findedge
i=1;
f=1;
while i<=size(s,1)
    for j=1:size(G.Edges.EndNodes,1)
        if G.Edges.EndNodes(j,:)==[s(i), t(i)]
            sOut(f)=s(i);
            tOut(f)=t(i);
            f=f+1;
            break;
        end
    end
    i=i+1;
end


end

